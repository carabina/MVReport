//
//  MVPDFReport.m
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

#import "MVPDFReport.h"
#import "MVReportPageRenderer+Private.h"
#import "MVReportTextFormatter+Private.h"

@import CoreGraphics;

@interface MVPDFReport ()

@property (nonatomic, strong)NSMutableData *data;

@end

@implementation MVPDFReport

- (id)generateReport
{
    self.data = [NSMutableData data];
    
    if (self.pageRenderer)
    {
        UIGraphicsBeginPDFContextToData(self.data, self.pageInfo.pageRect, nil);
        NSInteger pageCount = [self.pageRenderer numberOfPages];
        [self.pageRenderer prepareForDrawing];
        for (NSInteger page = 0; page < pageCount; page++)
        {
            UIGraphicsBeginPDFPage();
            CGRect rect = self.pageInfo.printableRect;
            
            [self.pageRenderer drawPageAtIndex:page inRect:rect];
            
        }
        UIGraphicsEndPDFContext();
        
        return [self.data copy];
    }
    else if (self.pageElement)
    {
        UIGraphicsBeginPDFContextToData(self.data, self.pageInfo.pageRect, nil);
        self.pageElement.contentRect = self.pageInfo.printableRect;
        NSInteger pageCount = [self.pageElement pageCount];
        [self.pageElement prepareForDrawing];
        for (NSInteger page = 0; page < pageCount; page++)
        {
            UIGraphicsBeginPDFPage();
            
            CGRect rect = [self.pageElement rectForPageAtIndex:page];
            [self.pageElement drawInRect:rect forPageAtIndex:page];
        }
        
        UIGraphicsEndPDFContext();
        
        return [self.data copy];
    }
    else
    {
        return nil;
    }
}

@end
