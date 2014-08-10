//
//  MVReportSection.m
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

#import "MVReportSection+Private.h"
#import "MVReportPageElement+Private.h"
#import "MVReportSectionElement+Private.h"
#import "MVReportPageRenderer+Private.h"

@interface MVReportSection ()
{
    CGFloat _pageCount;
    BOOL needsToRecalculatePageCount;
}

@property (nonatomic)CGRect headerRect;
@property (nonatomic)NSMutableArray *sectionContentRects;
@property (nonatomic)CGRect footerRect;

@end

@implementation MVReportSection

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.sectionContentRects = [NSMutableArray array];
    }
    
    return self;
}

- (void)setPriorPageElement:(MVReportPageElement *)priorPageElement
{
    [super setPriorPageElement:priorPageElement];
    needsToRecalculatePageCount = YES;
}

- (void)setSectionElements:(NSArray *)sectionElements
{
    NSArray *oldElements = [_sectionElements copy];
    for (MVReportSectionElement *element in oldElements)
    {
        [element removeFromReportSection];
    }
    
    _sectionElements = sectionElements;
    
    for (MVReportSectionElement *element in _sectionElements)
    {
        element.reportSection = self;
    }
}

- (void)addsectionElement:(MVReportSectionElement *)element
{
    element.reportSection = self;
    NSMutableArray *mutableElements = [self.sectionElements mutableCopy];
    if (!mutableElements)
    {
        mutableElements = [NSMutableArray array];
    }
    [mutableElements addObject:element];
    _sectionElements = [mutableElements copy];
    needsToRecalculatePageCount = YES;
}

- (void)removeSectionElement:(MVReportSectionElement *)element
{
    if ([self.sectionElements containsObject:element])
    {
        NSMutableArray *mutableElements = [self.sectionElements mutableCopy];
        [mutableElements removeObject:element];
        _sectionElements = [mutableElements copy];
        needsToRecalculatePageCount = YES;
    }
}

- (void)setContentRect:(CGRect)contentRect
{
    [super setContentRect:contentRect];
    needsToRecalculatePageCount = YES;
}

- (NSInteger)pageCount
{
    if (needsToRecalculatePageCount == NO)
    {
        return _pageCount;
    }
    
    [self.sectionContentRects removeAllObjects];
    
    if (self.priorPageElement)
    {
        self.startPage = self.priorPageElement.lastPage;
        CGRect peRect = [self.priorPageElement rectForPageAtIndex:self.startPage];
        self.contentInsets = UIEdgeInsetsMake(peRect.origin.y + peRect.size.height - self.reportPageRenderer.headerHeight - self.reportPageRenderer.pageInfo.printableRect.origin.y, self.contentInsets.left, self.contentInsets.bottom, self.contentInsets.right);
    }

    
    CGFloat verticalOffset = self.contentRect.origin.y + self.contentInsets.top;
    CGFloat horizontalOffset = self.contentRect.origin.x + self.contentInsets.left;
    CGFloat width = self.contentRect.size.width - self.contentInsets.left - self.contentInsets.right;
    CGFloat height = 0;
    CGFloat maxH = self.contentRect.origin.y + self.contentRect.size.height;
    
    CGRect pageContent = CGRectMake(horizontalOffset, verticalOffset, width, height);
    
    if (self.headerHeight > 0)
    {
        height = height + self.headerHeight;
        CGRect hRect = CGRectZero;
        hRect.origin.x = horizontalOffset;
        hRect.origin.y = verticalOffset;
        hRect.size.width = width;
        hRect.size.height = height;
        self.headerRect = hRect;
        
        verticalOffset = verticalOffset + height;
        height = 0;
        pageContent.origin.y = verticalOffset;
    }
    
    _pageCount = 1;
    
    CGRect cRect = CGRectZero;
    cRect.origin.x = horizontalOffset;
    cRect.origin.y = verticalOffset;
    cRect.size.width = width;
    cRect.size.height = self.contentRect.size.height - self.headerHeight; // maximum per element

    BOOL pb = NO;
    for (MVReportSectionElement *element in self.sectionElements)
    {
        pb = NO;
        CGRect er = CGRectMake(cRect.origin.x, cRect.origin.y, cRect.size.width, cRect.size.height);
        if ([element isBreakable])
        {
            er.size.height = MAXFLOAT;
        }
        
        [element setContentRect:er];
        CGRect aRect = element.contentRect;
        
        if (![element isBreakable])
        {
            // constrain W & H
            aRect.size.height = MIN(aRect.size.height, cRect.size.height);
            aRect.size.width = MIN(aRect.size.width, width);
            
            CGFloat bh = aRect.origin.y + aRect.size.height;
            if (bh > maxH)
            {
                pageContent.size.height = height;
                [self.sectionContentRects addObject:[NSValue valueWithCGRect:pageContent]];
                pb = YES;
                //page break
                verticalOffset = self.contentRect.origin.y;
                aRect.origin.y = verticalOffset;
                cRect.origin.y = verticalOffset;
                height = 0;
                pageContent = CGRectMake(horizontalOffset, verticalOffset, width, height);
                element.contentRect = aRect;
                _pageCount ++;
            }
            
            cRect.origin.y = cRect.origin.y + aRect.size.height;
            height = height + aRect.size.height;
            cRect.size.height = maxH - height;
            element.startPage =  self.startPage + _pageCount - 1;
            element.pageCount = 1;
        }
        else
        {
            element.startPage = self.startPage + _pageCount - 1;
            
            aRect.size.width = MIN(aRect.size.width, width);
            
            CGFloat bh = aRect.origin.y + aRect.size.height;
            if (bh > maxH)
            {
                NSInteger pc = ceil(bh / self.contentRect.size.height)-1;
                _pageCount = _pageCount + pc;
                element.pageCount = pc+1;
                pb = NO;
                CGFloat fph = maxH - aRect.origin.y;
                CGFloat lph = aRect.size.height - fph - ((pc-1)*self.contentRect.size.height);
                for (int i=0; i<pc+1; i++)
                {
                    CGFloat h = self.contentRect.size.height;
                    CGFloat y = self.contentRect.origin.y;
                    if (i==0)
                    {
                        h = fph;
                        y = aRect.origin.y;
                    }
                    else if (i == pc)
                    {
                        h = lph;
                    }
                    
                    height = height + h;
                    
                    if (i<pc)
                    {
                        pageContent.size.height = height;
                        [self.sectionContentRects addObject:[NSValue valueWithCGRect:pageContent]];
                        verticalOffset = self.contentRect.origin.y;
                        aRect.origin.y = verticalOffset;
                        cRect.origin.y = verticalOffset;
                        height = 0;
                        pageContent = CGRectMake(horizontalOffset, verticalOffset, width, height);
                    }
                    
                    cRect.origin.y = cRect.origin.y + height;
                    cRect.size.height = maxH - height;
                }
            }
            else
            {
                element.pageCount = 1;

                cRect.origin.y = cRect.origin.y + aRect.size.height;
                height = height + aRect.size.height;
                cRect.size.height = maxH - height;
            }
            
            
        }
    }
    
    if (!pb)
    {
        pageContent.size.height = height;
        [self.sectionContentRects addObject:[NSValue valueWithCGRect:pageContent]];
    }
    
    if (self.footerHeight > 0)
    {
        CGFloat fheight = height + self.footerHeight;
        if (fheight > maxH)
        {
            //page break
            _pageCount++;
            cRect.origin.y = self.contentRect.origin.y;
        }
        
        cRect.size.height = self.footerHeight;
        self.footerRect = cRect;
    }
    
    needsToRecalculatePageCount = NO;
    return _pageCount;
}


- (NSArray *)sectionElementsForPageAtIndex:(NSInteger)pageIndex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startPage <= %d) AND (lastPage >= %d)",pageIndex, pageIndex];
    return [self.sectionElements filteredArrayUsingPredicate:predicate];
}


- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex
{
    if (pageIndex == self.startPage)
    {
        if (self.headerHeight > 0)
        {
            [self drawSectionHeaderForPageAtIndex:pageIndex inRect:self.headerRect];
        }
    }
    
    NSInteger i = pageIndex - self.startPage;
    if (i < self.sectionContentRects.count)
    {
        NSValue *v = self.sectionContentRects[i];
        [self drawSectionContentForPageAtIndex:pageIndex inRect:[v CGRectValue]];
    }
    
    NSArray *elements = [self sectionElementsForPageAtIndex:pageIndex];
    for (MVReportSectionElement *element in elements)
    {
        [self drawSectionElement:element forPageAtIndex:pageIndex];
    }
    
    
    if (pageIndex == self.lastPage)
    {
        if (self.footerHeight > 0)
        {
            [self drawSectionFooterForPageAtIndex:pageIndex inRect:self.footerRect];
        }
    }
}

- (CGRect)rectForPageAtIndex:(NSInteger)pageIndex
{
    CGRect result = CGRectZero;
    
    CGRect r = CGRectZero;
    
    NSInteger i = pageIndex - self.startPage;
    
    if (i < self.sectionContentRects.count)
    {
        NSValue *v = self.sectionContentRects[i];
        r = [v CGRectValue];
    }
    
    if (pageIndex == self.startPage)
    {
        if (self.headerHeight > 0)
        {
            result = CGRectMake(self.headerRect.origin.x, self.headerRect.origin.y, self.headerRect.size.width, self.headerRect.size.height);
            result.size.height = result.size.height + r.size.height;
        }
    }
    
    if (pageIndex == self.startPage + self.pageCount - 1)
    {
        if (self.footerHeight > 0)
        {
            if (CGRectIsNull(result))
            {
                result = self.footerRect;
            }
            else
            {
                result = r;
                result.size.height = result.size.height + self.footerHeight;
            }
        }
        else
        {
            result = r;
        }
    }
    else
    {
        result = r;
    }
    
    return result;
}

- (void)prepareForDrawing
{
    for (MVReportSectionElement *element in self.sectionElements)
    {
        [element prepareForDrawing];
    }
}

- (void)drawSectionHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect
{
    
}

- (void)drawSectionContentForPageAtIndex:(NSInteger)index inRect:(CGRect)contentRect
{
    
}

- (void)drawSectionFooterForPageAtIndex:(NSInteger)index inRect:(CGRect)footerRect
{
    
}

- (void)drawSectionElement:(MVReportSectionElement *)element forPageAtIndex:(NSInteger)index
{
    CGRect rect = [element rectForPageAtIndex:index];
    [element drawInRect:rect forPageAtIndex:index];
}

@end
