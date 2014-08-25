//
//  MVReportSection.h
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

#import "MVReportPageElement.h"

@class MVReportSectionElement;

/**
 A MVReportSection object draws pages of content in the report, with or without the assistance of section elements. Report section is convinient way to add table-like contnet into the report, where each section can have its own header, footer, and arbitrary number of section elements inbetween.
 
 A report section is an instance of a custom subclass of MVReportSection, and can be added to report as any other MVReportPageElement instance.
 
 The subclass typically overrides one or more of the five `-draw`... methods:
 
 - The `-drawInRect:forPageAtIndex:` by default calls each of the other draw methods, in the order listed below. Your application can override it if you want to have complete control over what is drawn in the section.
 - Override `-drawSectionHeaderForPageAtIndex:inRect:` to draw content in the section header.
 - Override `-drawSectionContentForPageAtIndex:inRect:` to draw the main content of the section in the area between the section header and the section footer.
 - Override `-drawSectionElement:forPageAtIndex:` to intermix custom drawing with the drawing performed by an associated section element. This method is called for each section element associated with a given page.
 - Override `-drawSectionFooterForPageAtIndex:inRect:` to draw content in the section footer.

 */
@interface MVReportSection : MVReportPageElement

/**
 @name Specifying Header and Footer Heights
 */

/**
 The height of the section header.
 
 The header is measured in points from the top of content rect and is above the content area. The default header height is 0.0.
 
*/
@property(nonatomic) CGFloat headerHeight;

/**
 The height of the section footer.
 
 The footer is measured in points from the bottom of content rect and is below the content area. The default footer height is 0.0.
 */
@property(nonatomic) CGFloat footerHeight;

/**
 @name Managing Section Elements
 */

/**
 The page elements associated with the report section.
 */
@property(nonatomic, copy) NSArray *sectionElements;

/**
 Adds a section element to the report section. 
 
 Section elements are drawn one after the other in order they are added to the section, so there is no need to specify page or position of the element.
 
 @param element instance of the custom subclass of the MVReportSectionElement.
 */
- (void)addsectionElement:(MVReportSectionElement *)element;

/**
 Returns the section elements associated with a specified page.

 @param pageIndex The index of a page of the report.
 
 @return An array of MVReportSectionElement objects. A section element is a instance of the custom subclass of the MVReportSectionElement.
 */
- (NSArray *)sectionElementsForPageAtIndex:(NSInteger)pageIndex;


/**
 @name Drawing a Section
 */

/**
 Overridden to draw the section header of the given page.
 
 @param index      The index of the page in which to draw the section header.
 @param headerRect The rectangle in which the section header content should be drawn. It is specified in the coordinate system of the page rectangle (pageRect); that is, the origin of coordinates is at the top-left corner of the sheet.
 
 The default implementation of this method does nothing. It is not called if headerHeight is not a positive value, and it is called only for first page if section spans across multiple pages. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).

 */
- (void)drawSectionHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect;

/**
 Overridden to draw the section content of the given page.
 
 @param index       The index of the page in which to draw section content.
 @param contentRect The area in which section content is to be drawn, specified in the coordinate system of the page rectangle (pageRect); that is, the origin of coordinates is at the top-left corner of the sheet.
 
 The default implementation of this method does nothing. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).

 */
- (void)drawSectionContentForPageAtIndex:(NSInteger)index inRect:(CGRect)contentRect;

/**
 Overridden to add custom drawing to the drawing provided by a given section element for a page.
 
 @param element A MVReportSectionElement object associated with page index.
 @param index   The index of the page in which section element is to draw.
 
 This method is invoked for each section element assigned to the specified page. The default implementation invokes the `-drawInRect:forPageAtIndex:` method of the MVReportSectionElement object that is passed in. You can override this method to intermix custom drawing with the element drawing—for example, by adding an overlay or underlay graphic. Call `-drawInRect:forPageAtIndex:` to have the section element draw its portion of the page. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).

 */
- (void)drawSectionElement:(MVReportSectionElement *)element forPageAtIndex:(NSInteger)index;

/**
 Overridden to draw the footer of the given page.
 
 @param index      The index of the page in which to draw the section footer content.
 @param footerRect The rectangle in which the section footer content should be drawn. It is specified in the coordinate system of the page rectangle (pageRect); that is, the origin of coordinates is at the top-left corner of the sheet.
 
 The default implementation of this method does nothing. It is not called if footerHeight is not a positive value, and it is called only for last page if report section spans across multiple pages. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).
 */
- (void)drawSectionFooterForPageAtIndex:(NSInteger)index inRect:(CGRect)footerRect;


@end
