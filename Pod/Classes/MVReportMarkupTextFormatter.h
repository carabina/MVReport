//
//  MVReportMarkupTextFormatter.h
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

#import "MVReportTextFormatter.h"

/**
 Instances of the MVReportMarkupTextFormatter class lay out HTML markup text, possibly over multiple pages.
 
 To use this report formatter for a report, create an instance of MVReportMarkupTextFormatter initialized with the HTML, set the inherited layout properties, and add the object to the report in one of two ways:
 
 - If a single report formatter is being used for the report (with no additional drawing), assign it to the pageElement property of the MVReport instance. The inherited startPage property identifies the beginning page of content with which the formatter is associated.
 - If you are using multiple elements along with a page renderer, associate each report formatter with a starting page of the printed content. You often take this approach when you want to add content such as headers and footers to what the formatters provide. You have two ways of associating a report formatter with a MVReportPageRenderer object:
    - You can add report formatters to the pageElements property of the MVReportPageRenderer object; the startPage property of the report formatter specifies the starting page.
    - You can add report formatters by calling `-addPageElement:startingAtPageAtIndex:` for each report formatter; the second parameter of this method specifies the starting page (and overrides any startPage value).
 */
@interface MVReportMarkupTextFormatter : MVReportTextFormatter

/**
 @name Getting the Markup Text
 */

/**
 The HTML markup text for the print formatter.
*/
@property(nonatomic,readonly, copy) NSString *markupText;

/**
 @name Creating a Markup-Text Report Formatter
 */

/**
 Returns a markup-text print formatter initialized with an HTML string.
 
 @param markupText A string of HTML markup text.
 
 @return An instance of MVReportMarkupTextFormatter or nil if the object could not be created.
 */
- (instancetype)initWithMarkupText:(NSString *)markupText;

@end
