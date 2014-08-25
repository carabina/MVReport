//
//  MVReportTextFormatter.m
//
// Copyright (c) 2014 Moroverse
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MVReportTextFormatter+Private.h"
#import "MVReportPageRenderer+Private.h"
@import CoreText;

@interface MVReportTextFormatter ()
{
    CTFramesetterRef framesetter;
    NSAttributedString *_attributedString;
    CFRange localRange;
    CGFloat _maxHeight;
    CGFloat _pageCount;
}

@end

@implementation MVReportTextFormatter



- (void)dealloc
{
    if (framesetter)
    {
        CFRelease(framesetter);
        framesetter = nil;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        localRange = CFRangeMake(0, 0);
    }
    
    return self;
}


- (void)prepareForDrawing
{
    localRange = CFRangeMake(0, self.attributedString.length);
}

- (NSAttributedString *)attributedString
{
    return _attributedString;
}

- (void)setAttributedString:(NSAttributedString *)attributedString
{
    if (_attributedString)
    {
        if (framesetter)
        {
            CFRelease(framesetter);
        }
    }
    
    _attributedString = attributedString;
    
    if ([_attributedString length] > 0)
    {
        framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedString);
    }
}

- (CGFloat)evaluateRectsForTextInRange:(CFRange)range usingRect:(CGRect)rect andPageCount:(NSInteger)pCount
{
    CFRange myRange = CFRangeMake(range.location, range.length);
    
    for (NSInteger i = self.startPage; i < (self.startPage + pCount); i++)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect rect = [self rectForPageAtIndex:i];
        CGPathAddRect(path, NULL, rect);
        
        CTFrameRef sFrame = CTFramesetterCreateFrame(framesetter, myRange, path, NULL);
        CFRange visibleRange = CTFrameGetVisibleStringRange(sFrame);
        
        myRange.location += visibleRange.length;
        myRange.length -= visibleRange.length;
        
        CFRelease(sFrame);
        CFRelease(path);
    }
    
    if (myRange.length > 0)
    {
        CGSize evalSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,myRange,NULL,rect.size,NULL);
        return evalSize.height;
    }
    else
    {
        return 0;
    }
}

- (NSInteger)pageCountForMaxHeight:(CGFloat)mHeight
{
    // ignoring per page insets for now
    mHeight = mHeight + self.contentInsets.top;
    CGFloat numP = mHeight / self.contentRect.size.height;
    numP = ceilf(numP);
    NSInteger pages = numP;
    return pages;
}

- (NSInteger)pageCount
{
    if (_pageCount)
    {
        return _pageCount;
    }
    
    if ([self.attributedString length] <= 0)
    {
        return 0;
    }
    
    if (self.priorPageElement)
    {
        self.startPage = self.priorPageElement.lastPage;
        CGRect peRect = [self.priorPageElement rectForPageAtIndex:self.startPage];
        self.contentInsets = UIEdgeInsetsMake(peRect.origin.y + peRect.size.height - self.reportPageRenderer.headerHeight - self.reportPageRenderer.pageInfo.printableRect.origin.y, self.contentInsets.left, self.contentInsets.bottom, self.contentInsets.right);
    }
    
    CGRect effectiveRect = self.contentRect;
    
    if (CGRectIsNull(effectiveRect))
    {
        effectiveRect = CGRectMake(0, 0, 612, 792);
    }

    effectiveRect.size.width = effectiveRect.size.width - self.contentInsets.left - self.contentInsets.right;
    effectiveRect.size.height = self.maximumContentHeight;
    effectiveRect.size.width = MIN(effectiveRect.size.width, self.maximumContentWidth);
    
    CFRange effectiveRange;
    CGSize textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0),NULL,effectiveRect.size,&effectiveRange);
    _maxHeight = textSize.height;
    
    _pageCount = [self pageCountForMaxHeight:_maxHeight];
    
    //recalculate max height
    
    CGFloat evalSize = 0;
    do
    {
        evalSize = [self evaluateRectsForTextInRange:effectiveRange usingRect:effectiveRect andPageCount:_pageCount];
        if (evalSize > 0)
        {
            
            _maxHeight = _maxHeight + evalSize;
            _pageCount = [self pageCountForMaxHeight:_maxHeight];
        }
    }
    while (evalSize != 0);
    
    return _pageCount;
}

- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex
{
    if (localRange.location < self.attributedString.length)
    {
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSaveGState(currentContext);
        CGContextTranslateCTM(currentContext, 0.0, rect.size.height+2*rect.origin.y);
        CGContextScaleCTM(currentContext, 1.0, -1.0);
        CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        
        CTFrameRef sFrame = CTFramesetterCreateFrame(framesetter, localRange, path, NULL);
        CTFrameDraw(sFrame, currentContext);
        CFRange visibleRange = CTFrameGetVisibleStringRange(sFrame);
        
        CGContextRestoreGState(currentContext);

        localRange.location += visibleRange.length;
        localRange.length -= visibleRange.length;
        CFRelease(sFrame);
        CFRelease(path);
    }
}

- (CGRect)rectForPageAtIndex:(NSInteger)pageIndex
{
    CGRect effectiveRect = self.contentRect;
    if (CGRectIsNull(effectiveRect))
    {
        effectiveRect = CGRectMake(0, 0, 612, 792);
    }
    
    effectiveRect.size.width = effectiveRect.size.width - self.contentInsets.left - self.contentInsets.right;
    effectiveRect.size.width = MIN(effectiveRect.size.width, self.maximumContentWidth);
    effectiveRect.origin.x = effectiveRect.origin.x + self.contentInsets.left;
    
    if (pageIndex == self.startPage)
    {
        effectiveRect.size.height = effectiveRect.size.height - self.contentInsets.top;
        effectiveRect.origin.y = effectiveRect.origin.y + self.contentInsets.top;
        if (_maxHeight < effectiveRect.size.height)
        {
            effectiveRect.size.height = _maxHeight;
        }
    }
    else
    {
        NSInteger pc = pageIndex - self.startPage;
        CGFloat priorHeight = pc * self.contentRect.size.height;
        priorHeight = priorHeight - self.contentInsets.top;
        CGFloat newHeight = priorHeight + effectiveRect.size.height;
        if (newHeight > _maxHeight)
        {
            effectiveRect.size.height = _maxHeight - priorHeight;
        }
    }
    
    return effectiveRect;
}



@end
