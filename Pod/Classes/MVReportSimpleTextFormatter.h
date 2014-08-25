//
//  MVReportSimpleTextFormatter.h
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
 Instances of the MVReportSimpleTextFormatter class lay out plain text, possibly over multiple pages. The class allows you to specify global font, color, and text alignment properties for the text in report.
 
 To use this report formatter for a report, create an instance of MVReportSimpleTextFormatter initialized with the text, set the text properties and the inherited layout properties, and add the object to the report in one of two ways:
 
 - If a single report formatter is being used for the report (with no additional drawing), assign it to the pageElement property of the MVReport instance. The inherited startPage property identifies the beginning page of content with which the formatter is associated.
 - If you are using multiple elements along with a page renderer, associate each report formatter with a starting page of the printed content. You often take this approach when you want to add content such as headers and footers to what the formatters provide. You have two ways of associating a report formatter with a MVReportPageRenderer object:
    - You can add report formatters to the pageElements property of the MVReportPageRenderer object; the startPage property of the report formatter specifies the starting page.
    - You can add report formatters by calling `-addPageElement:startingAtPageAtIndex:` for each report formatter; the second parameter of this method specifies the starting page (and overrides any startPage value).
 */
@interface MVReportSimpleTextFormatter : MVReportTextFormatter

/**
 @name Getting and Setting the Text
*/

/**
 A string of plain text.
*/
@property(nonatomic, copy) NSString *text;

/**
 @name Text Attributes for Content
 */

/**
 The font of the text.
 
 If the value of this property is nil (the default), MVReport uses the standard system font.
 */
@property(nonatomic, retain) UIFont *font;

/**
 The color of the text.
 
 If the value of this property is nil (the default), MVReport uses a black color when printing.
 */
@property(nonatomic, retain) UIColor *color;

/**
 The alignment of the text.
 
 The default text alignment is UITextAlignmentLeft.
 */
@property(nonatomic) NSTextAlignment textAlignment;

/**
 @name Creating a Simple-Text Report Formatter
 */

/**
 Returns a simple-text report formatter initialized with plain text.
 
 @param text A string of plain text.
 
 @return An initialized instance of MVReportSimpleTextFormatter or nil if the object could not be created.
 */
- (instancetype)initWithText:(NSString *)text;

@end
