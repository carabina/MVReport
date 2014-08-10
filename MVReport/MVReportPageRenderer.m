//
//  MVReportPageRenderer.m
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

#import "MVReportPageRenderer+Private.h"
#import "MVReportPageElement+Private.h"

@interface MVReportPageRenderer ()
{
    MVReportPageInfo *_pageInfo;
}

@property (nonatomic)CGRect headerRect;
@property (nonatomic)CGRect contentRect;
@property (nonatomic)CGRect footerRect;

@end


@implementation MVReportPageRenderer

- (void)setPageInfo:(MVReportPageInfo *)pageInfo
{
    _pageInfo = pageInfo;
    [self calculateRectsForPageRect:pageInfo.printableRect];
    for (MVReportPageElement *element in self.pageElements)
    {
        element.contentRect = self.contentRect;
    }
}

- (MVReportPageInfo *)pageInfo
{
    return _pageInfo;
}

- (void)setPageElements:(NSArray *)pageElements
{
    for (MVReportPageElement *element in pageElements)
    {
        element.reportPageRenderer = self;
    }
}

- (NSInteger)numberOfPages
{
    NSInteger result = 0;
    for (MVReportPageElement *element in self.pageElements)
    {
        NSInteger tc = [element pageCount];
        //start page can be modified by page count call in case of chained elements...
        NSInteger sp = element.startPage;
        result = MAX(result, sp+tc);
    }
    
    return result;
}

- (void)addPageElement:(MVReportPageElement *)element startingAtPageAtIndex:(NSInteger)pageIndex
{
    element.startPage = pageIndex;
    element.reportPageRenderer = self;
    element.contentRect = self.contentRect;
    NSMutableArray *mutableElements = [self.pageElements mutableCopy];
    if (!mutableElements)
    {
        mutableElements = [NSMutableArray array];
    }
    [mutableElements addObject:element];
    _pageElements = [mutableElements copy];
}

- (void)addPageElement:(MVReportPageElement *)element afterPageElement:(MVReportPageElement *)priorElement
{
    element.reportPageRenderer = self;
    element.contentRect = self.contentRect;
    element.priorPageElement = priorElement;
    NSMutableArray *mutableElements = [self.pageElements mutableCopy];
    if (!mutableElements)
    {
        mutableElements = [NSMutableArray array];
    }
    [mutableElements addObject:element];
    _pageElements = [mutableElements copy];
}

- (void)removePageElement:(MVReportPageElement *)element
{
    if ([self.pageElements containsObject:element])
    {
        NSMutableArray *mutableElements = [self.pageElements mutableCopy];
        [mutableElements removeObject:element];
        _pageElements = [mutableElements copy];
    }
}

- (NSArray *)pageElementsForPageAtIndex:(NSInteger)pageIndex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startPage <= %d) AND (lastPage >= %d)",pageIndex, pageIndex];
    return [self.pageElements filteredArrayUsingPredicate:predicate];
}


- (void)prepareForDrawing
{
    for (MVReportPageElement *element in self.pageElements)
    {
        [element prepareForDrawing];
    }
}

- (void)calculateRectsForPageRect:(CGRect)pageRect
{
    NSInteger contentHeight = pageRect.size.height;
    NSInteger contentOffset = pageRect.origin.y;
    if (self.headerHeight > 0)
    {
        CGRect rect = pageRect;
        rect.size.height = self.headerHeight;
        self.headerRect = rect;
        contentHeight = contentHeight - self.headerHeight;
        contentOffset = contentOffset + self.headerHeight;
    }
    else
    {
        self.headerRect = CGRectZero;
    }
    
    if (self.footerHeight)
    {
        CGRect rect = pageRect;
        rect.size.height = self.footerHeight;
        rect.origin.y = (pageRect.origin.y + pageRect.size.height) - self.footerHeight;
        self.footerRect = rect;
        contentHeight = contentHeight - self.footerHeight;
    }
    else
    {
        self.footerRect = CGRectZero;
    }
    
    CGRect cRect = pageRect;
    cRect.origin.y = contentOffset;
    cRect.size.height = contentHeight;
    
    self.contentRect = cRect;
    
}

- (void)drawPageAtIndex:(NSInteger)index inRect:(CGRect)pageRect
{
    if (self.headerHeight > 0)
    {
        [self drawHeaderForPageAtIndex:index inRect:self.headerRect];
    }
    
    [self drawContentForPageAtIndex:index inRect:self.contentRect];
    
    NSArray *elements = [self pageElementsForPageAtIndex:index];
    for (MVReportPageElement *element in elements)
    {
        [self drawPageElement:element forPageAtIndex:index];
    }
    
    
    if (self.footerHeight > 0)
    {
        [self drawFooterForPageAtIndex:index inRect:self.footerRect];
    }
}

- (void)drawHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect
{
    
}


- (void)drawContentForPageAtIndex:(NSInteger)index inRect:(CGRect)contentRect
{
    
}


- (void)drawPageElement:(MVReportPageElement *)element forPageAtIndex:(NSInteger)index
{
    CGRect rect = [element rectForPageAtIndex:index];
    [element drawInRect:rect forPageAtIndex:index];
}

- (void)drawFooterForPageAtIndex:(NSInteger)index inRect:(CGRect)footerRect
{
    
}

@end
