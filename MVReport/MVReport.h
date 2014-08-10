//
//  MVReport.h
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

#import "MVReportPageInfo.h"
#import "MVReportPageRenderer.h"
#import "MVReportPageElement.h"

/**
 Base abstract class for report generation. Do not instantiate this class, use more specialized ones for desired report type.
 ## Subclassing Notes
 If you create subclass or MVReport you MUST override `-generateReport` and return a result. Default implementation will raise an exeption.
 ## Methods to Override
 To generate report of type not already provided by the framework you should override method `-generateReport`. Once you did this, its your resposibility to initialize apropriate context, render to it and return generated data.
 */
@interface MVReport : NSObject

/**
 @name Accessing Report Information
 */

/**
 An object representing the paper size and printing area for the report. (read-only)
 */
@property (nonatomic,readonly, strong)MVReportPageInfo *pageInfo;

/**
 @name Providing the Source of Report Content
 */

/**
 An object that draws pages of printable content when requested.
 
 The object assigned to this property must be an instance of a custom subclass of MVReportPageRenderer. The default value is nil.
 
 If you set this property, MVReport sets the textFormatter property to nil. (Only one of these properties can be set for a print job.)
 */

@property (nonatomic, strong)MVReportPageRenderer *pageRenderer;

/**
 An object that lays out the content of pages based on the kind of content.
 
 Assign to this property an instance of one of the concrete subclasses of MVReportPageElement: MVReportSimpleTextFormatter, MVReportMarkupTextFormatter, and MVReportSection. The default value is nil.
 
 If you set this property, MVReport sets the pageRenderer property to nil. (Only one of these properties can be set for a report generation.)
 */
@property (nonatomic, strong)MVReportPageElement *pageElement;

/**
 @name Generating Report
 */

/**
 Generates and returns a report.
 
 @return generated report.
 */
- (id)generateReport;

/**
 @name Creating MVReport Instance
 */

/**
 Returns a newly initialized report with the page info assigned.
 
 @param pageInfo decription of the page used in report.
 
 @return A newly initialized MVReport object.
 */
- (instancetype)initWithPageInfo:(MVReportPageInfo *)pageInfo;

@end
