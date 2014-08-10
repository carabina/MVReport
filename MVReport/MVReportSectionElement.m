//
//  MVReportSectionElement.m
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

#import "MVReportSectionElement+Private.h"
#import "MVReportSection+Private.h"
#import "MVReportPageElement+Private.h"

@interface MVReportSectionElement ()
{
    CGRect _contentRect;
    NSInteger _pageCount;
    NSInteger _startPage;
}

@property (nonatomic)NSMutableArray *elementContentRects;

@end

@implementation MVReportSectionElement

- (void)initInstance
{
    self.startPage = 0;
    self.elementContentRects = [NSMutableArray array];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initInstance];
    }
    
    return self;
}

- (NSInteger)startPage
{
    return _startPage;
}

- (void)setStartPage:(NSInteger)startPage
{
    _startPage = startPage;
}

- (NSInteger)lastPage
{
    return self.startPage + ([self pageCount]-1);
}

- (void)setContentRect:(CGRect)contentRect
{
    _contentRect = [self rectForContentRect:contentRect];
    if ([self isBreakable])
    {
        if ((_contentRect.origin.y + _contentRect.size.height) > contentRect.origin.y + contentRect.size.height)
        {
            _contentRect.size.height = (contentRect.origin.y + contentRect.size.height) - _contentRect.origin.y;
        }
    }
}

- (CGRect)contentRect
{
    return _contentRect;
}

- (NSInteger)pageCount
{
    return _pageCount;
}

- (void)setPageCount:(NSInteger)pageCount
{
    _pageCount = pageCount;
}

- (CGRect)rectForPageAtIndex:(NSInteger)pageIndex
{
    CGRect pageRect = self.reportSection.contentRect;
    CGFloat maxHeight = self.contentRect.size.height;
    CGFloat pY = pageRect.origin.y + pageRect.size.height;
    if (pageIndex == self.startPage)
    {
        if (self.contentRect.origin.y + maxHeight < pY)
        {
            return self.contentRect;
        }
        else
        {
            CGRect r = CGRectMake(self.contentRect.origin.x, self.contentRect.origin.y, self.contentRect.size.width, self.contentRect.size.height);
            r.size.height = pY - self.contentRect.origin.y;
            return r;
        }
    }
    else
    {
        NSInteger pc = pageIndex - self.startPage;
        CGFloat priorHeight = pc * pageRect.size.height;
        priorHeight = (priorHeight + pageRect.origin.y) - self.contentRect.origin.y;
        CGFloat h = priorHeight + pageRect.size.height;
        CGRect result = CGRectMake(self.contentRect.origin.x, self.contentRect.origin.y, self.contentRect.size.width, self.contentRect.size.height);
        result.origin.y = pageRect.origin.y;
        result.size.height = pageRect.size.height;
        
        if (h > maxHeight)
        {
            result.size.height = maxHeight - priorHeight;
        }
        
        return result;
    }
}

- (CGRect)contentRectRelativeToPageAtIndex:(NSInteger)pageIndex
{
    CGRect pageRect = self.reportSection.contentRect;
    if (pageIndex == self.startPage)
    {
        return self.contentRect;
    }
    else
    {
        NSInteger pc = pageIndex - self.startPage;
        CGFloat priorHeight = pc * pageRect.size.height;
        priorHeight = (priorHeight + pageRect.origin.y) - self.contentRect.origin.y;
        CGRect result = CGRectMake(self.contentRect.origin.x, self.contentRect.origin.y, self.contentRect.size.width, self.contentRect.size.height);
        result.origin.y = pageRect.origin.y-priorHeight;
        
        return result;
    }
}


- (void)setReportSection:(MVReportSection *)reportSection
{
    if (self.reportSection)
    {
        [self.reportSection removeSectionElement:self];
    }
    
    _reportSection = reportSection;
}


- (void)removeFromReportSection
{
    self.reportSection = nil;
}


- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex
{
    //draw nothing
}


- (CGRect)rectForContentRect:(CGRect)contentRect
{
    NSAssert(NO, @"should be implemented by subclass");
    return CGRectZero;
}

- (void)prepareForDrawing
{
    
}


@end
