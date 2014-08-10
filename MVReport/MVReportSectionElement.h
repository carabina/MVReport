//
//  MVReportSectionElement.h
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

@class MVReportSection;

/**
 MVReportSectionElement is an abstract base class for section elements: objects that lay out custom printable content inside report section. You create your own subclass of MVReportSectionElement in application.
 ## Methods to Override
 Override `-rectForContentRect:` to return desired rect for drawing, and `-drawInRect:forPageAtIndex:` to actually perform drawing in given rect.
 */
@interface MVReportSectionElement : NSObject

/**
 @name Accessing Information About the Report
 */

/**
 The index of the first page that the section element lays out. (read-only)
 
 MVReportSection calculates this value based on the layout metrics and content of other section elements.
*/
@property(nonatomic,readonly, assign) NSInteger startPage;

/**
 The number of pages to be generated by section element. (read-only)
 
 MVReportSection calculates this value based on the layout metrics and content.
 */
@property(nonatomic, readonly, assign) NSInteger pageCount;

/**
 @name Element Behavior
 */

/**
 Set to define can this element span across multiple pages of report or not.
 
 Default value of this property is NO. In your subclass you should take into account value of this property when returning rect from `-rectForContentRect:`. If value of this property is NO, height of bounding rect will be constrained to size of one page.
 */
@property(nonatomic, assign,getter=isBreakable)BOOL breakable;

/**
 @name Communicating with the Report Section
 */

/**
 Returns the report section with which the receiver is associated.
 */
@property(nonatomic, readonly, assign) MVReportSection *reportSection;

/**
 Removes the section element from the report section.
 */
- (void)removeFromReportSection;

/**
 @name Drawing the Content
 */

/**
 Override to return desired rect in which your content can fit.
 
 @param contentRect Proposed content rect in which content of the element should fit. If section element is breakable, height of the bounding rect is usauly max float.
 
 @return Rect in which element can draw its content.
 */
- (CGRect)rectForContentRect:(CGRect)contentRect;

/**
 Returns the area enclosing a specified page of section content.
 
 @param pageIndex The index number of a page.
 
 @return A rectangle enclosing the content area in section for page pageIndex.
 
 */
- (CGRect)rectForPageAtIndex:(NSInteger)pageIndex;

/**
  Draws the portion of a section element's content that goes in the given area for the specified page
 
 @param rect      The area in which to draw the content.
 @param pageIndex The number of the page of content to draw.
 
 This method is called by the default implementation of `-drawSectionElement:forPageAtIndex:` of the MVReportSection class for each section element associated with a page.
 */
- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex;

/**
 Returns actual content rect of the section element in coordinate space of page index
 
 @param pageIndex The index number of a page.
 
 @return A content rectangle as seen from the page requested
 */
- (CGRect)contentRectRelativeToPageAtIndex:(NSInteger)pageIndex;

@end
