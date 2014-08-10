//
//  MVReportPageElement.m
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

#import "MVReportPageElement+Private.h"
#import "MVReportPageRenderer+Private.h"

@interface MVReportPageElement ()
{
    CGRect _contentRect;
    __weak MVReportPageElement *_priorPageElement;
}

@end

@implementation MVReportPageElement

- (void)initInstance
{
    self.maximumContentHeight = CGFLOAT_MAX;
    self.maximumContentWidth = CGFLOAT_MAX;
    self.startPage = 0;
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

- (NSInteger)lastPage
{
    return self.startPage + ([self pageCount]-1);
}

- (MVReportPageElement *)priorPageElement
{
    return _priorPageElement;
}

- (void)setPriorPageElement:(MVReportPageElement *)priorPageElement
{
    _priorPageElement = priorPageElement;
}


- (CGRect)contentRect
{
    return _contentRect;
}

- (void)setContentRect:(CGRect)contentRect
{
    _contentRect = contentRect;
}


- (void)setReportPageRenderer:(MVReportPageRenderer *)reportPageRenderer
{
    if (self.reportPageRenderer)
    {
        [self.reportPageRenderer removePageElement:self];
    }
    
    _reportPageRenderer = reportPageRenderer;
}


- (void)removeFromReportPageRenderer
{
    self.reportPageRenderer = nil;
}

- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex
{
    NSAssert(NO, @"should be implemented by subclass");    
}

- (CGRect)rectForPageAtIndex:(NSInteger)pageIndex
{
    NSAssert(NO, @"should be implemented by subclass");
    return CGRectZero;
}

- (void)prepareForDrawing
{
    NSAssert(NO, @"should be implemented by subclass");
}

- (NSInteger)pageCount
{
    NSAssert(NO, @"should be implemented by subclass");
    return 0;
}

@end
