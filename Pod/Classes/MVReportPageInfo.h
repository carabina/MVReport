//
//  MVReportPageInfo.h
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

#import <Foundation/Foundation.h>
@import CoreGraphics;

/**
 An instance of the MVReportPageInfo class encapsulates the size of paper used for a report and the rectangle in which content can be generated.
 
 If you want to print generated report, you can obtain UIPrintPaper instance for the print job and use its properties to create MVReportPageInfo.
 */
@interface MVReportPageInfo : NSObject

/**
 @name Getting the Paper Size and the Printing Area
 */

/**
 The size of the sheet to be used for report.
 
 The paper size is often associated with a standard designation, such as “Letter” and “A4”. For example, the paper size for a Letter sheet of paper is 612 points wide and 792 points high.
 */
@property(nonatomic, assign) CGRect pageRect;

/**
 The rectangle that represents the portion of the paper that can be imaged upon.
 */
@property(nonatomic, assign) CGRect printableRect;

@end
