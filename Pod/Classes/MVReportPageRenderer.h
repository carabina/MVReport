//
//  MVReportPageRenderer.h
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

@class MVReportPageElement;

/**
 A MVReportPageRenderer object draws pages of content in the report, with or without the assistance of page elements.
 
 A page renderer is an instance of a custom subclass of MVReportPageRenderer. When you compose a report using the instance of MVReport, you assign the page renderer to the pageRenderer property of that instance. The subclass typically overrides one or more of the five draw... methods:
 
 - The `-drawPageAtIndex:inRect:` by default calls each of the other draw methods, in the order listed below. Your application can override it if you want to have complete control over what is drawn in the report.
 - Override `-drawHeaderForPageAtIndex:inRect:` to draw content in the header.
 - Override `-drawContentForPageAtIndex:inRect:` to draw the main content of the report in the area between the header and the footer.
 - Override `-drawPageElement:forPageAtIndex:` to intermix custom drawing with the drawing performed by an associated page element. This method is called for each page element associated with a given page.
 - Override `-drawFooterForPageAtIndex:inRect:` to draw content in the footer.
 
 MVReportPageRenderer usually requires you to specify the number of pages of the content by overriding numberOfPages. It also allows you to specify the heights of page headers and footers.
 
 You may assign one or more page elements—that is, MVReportPageElement objects that can lay out content of a certain kind—to specific page ranges of the content. For example, if your content is partially HTML, you may assign an instance of the MVReportMarkupTextFormatter object to the starting page of HTML content. You assign a report formatter using the `-addPageElement:startingAtPageAtIndex:` method and you can get the report formatters for a given page by calling `-pageElementsForPageAtIndex:`.
 */
@interface MVReportPageRenderer : NSObject

/**
 @name Accessing Information About the Report
 */

/**
 The number of pages to render.

 By default, returns the number of pages as calculated by MVReport if the receiver uses page elements. If the page renderer uses no page elements, the returned value is zero. If your page renderer is doing any custom drawing except for headers and footers, it must override this method.

 This method is called at any point when MVReport needs the number of pages.

 If page elements aren’t used to compute the page count, the page renderer can override this method to calculate and return the number of pages. The computation can take into account the current printableRect value for each page, any implicit margins, and the content to be drawn when laid out within these boundaries.
*/
- (NSInteger)numberOfPages;

/**
 @name Specifying Header and Footer Heights
 */

/**
 The height of the page header.
 
 The header is measured in points from the top of printableRect and is above the content area. The default header height is 0.0.
 */
@property(nonatomic) CGFloat headerHeight;

/**
 The height of the page footer.
 
 The footer is measured in points from the bottom of printableRect and is below the content area. The default footer height is 0.0.
 */
@property(nonatomic) CGFloat footerHeight;

/**
 @name Managing Page Elements
 */

/**
 The page elements associated with the page renderer.
 
 The elements of the array are MVReportPageElement objects. A page element can be an instance of MVReportSimpleTextFormatter, MVReportMarkupTextFormatter, or MVReportSection. Page elements added this way to a page renderer are associated with page ranges through each page element's startPage and pageCount properties.
 */
@property(nonatomic, copy) NSArray *pageElements;

/**
 Adds a page element to the page renderer starting at the specified page.
 
 @param element   The MVReportPageElement object to add to the page renderer. A page element can be an instance of MVReportSimpleTextFormatter, MVReportMarkupTextFormatter, or MVReportSection.
 @param pageIndex The index identifying the first page with which the page element should be associated with. This value overrides the startPage property of the page element.
 */
- (void)addPageElement:(MVReportPageElement *)element startingAtPageAtIndex:(NSInteger)pageIndex;

/**
 Adds a page element to the page renderer starting after priorElement.
 
 @param element The MVReportPageElement object to add to the page renderer. A page element can be an instance of MVReportSimpleTextFormatter, MVReportMarkupTextFormatter, or MVReportSection.
 @param priorElement page element after which page element should be added.
 
 When you add page element to page renderer this way, start page and top content insets of the element will be overriden. You should not try to change those after page element is assigned to the page renderer.
 */
- (void)addPageElement:(MVReportPageElement *)element afterPageElement:(MVReportPageElement *)priorElement;

/**
 Returns the page elements associated with a specified page.
 
 @param pageIndex The index of a page of the report.
 
 @return An array of MVReportPageElement objects. A page element can be an instance of MVReportSimpleTextFormatter, MVReportMarkupTextFormatter, or MVReportSection.
 
 A page element is associated with a starting page of report through the `-addPageElement:startingAtPageAtIndex:` method or the startPage property of MVReportPageElement. The number of pages from that page is determined by the pageCount property, which MVReportPageElement computes based on layout metrics and content.
 */
- (NSArray *)pageElementsForPageAtIndex:(NSInteger)pageIndex;

/**
 @name Preparing for Drawing
 */

/**
 Overridden by the page renderer to prepare for drawing.
 
 MVReport calls this method before it requests drawing of the report. You can optionally override this method to perform setup tasks. 
 @warning If you are using page elements in page renderer you should call super before any other call.
 */
- (void)prepareForDrawing;

/**
 @name Drawing a Page
 */

/**
 Overridden to draw a given page of content for the report.
 
 @param index    The index of the page to draw.
 @param pageRect The rectangle in which printable content can be drawn.
 
 The default implementation of this method calls, in sequence, `-drawHeaderForPageAtIndex:inRect:`, `-drawContentForPageAtIndex:inRect:`, `-drawPageElement:forPageAtIndex:`, and `-drawFooterForPageAtIndex:inRect:`. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).
 */
- (void)drawPageAtIndex:(NSInteger)index inRect:(CGRect)pageRect;

/**
 Overridden to draw the header of the given page.
 
 @param index      The index of the page in which to draw the header.
 @param headerRect The rectangle in which the header content should be drawn. It is specified in the coordinate system of the page rectangle (pageRect); that is, the origin of coordinates is at the top-left corner of the sheet.
 
 The default implementation of this method does nothing. It is not called if headerHeight is not a positive value. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).
 */
- (void)drawHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect;

/**
 Overridden to draw the content of the given page.
 
 @param index       The index of the page in which to draw content.
 @param contentRect The area in which content is to be drawn, specified in the coordinate system of the page rectangle (pageRect); that is, the origin of coordinates is at the top-left corner of the sheet.
 
 The default implementation of this method does nothing. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).
 */
- (void)drawContentForPageAtIndex:(NSInteger)index inRect:(CGRect)contentRect;

/**
 Overridden to add custom drawing to the drawing provided by a given page element for a page.
 
 @param element A MVReportPageElement object associated with page index.
 @param index   The index of the page in which element is to draw.
 
 This method is invoked for each page element assigned to the specified page. The default implementation invokes the `-drawInRect:forPageAtIndex:` method of the MVReportPageElement object that is passed in. You can override this method to intermix custom drawing with the element drawing—for example, by adding an overlay or underlay graphic. Call `-drawInRect:forPageAtIndex:` to have the page element draw its portion of the page. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).
 */
- (void)drawPageElement:(MVReportPageElement *)element forPageAtIndex:(NSInteger)index;

/**
 Overridden to draw the footer of the given page.
 
 @param index      The index of the page in which to draw the footer content.
 @param footerRect The rectangle in which the footer content should be drawn. It is specified in the coordinate system of the page rectangle (pageRect); that is, the origin of coordinates is at the top-left corner of the sheet.
 
 The default implementation of this method does nothing. It is not called if footerHeight is not a positive value. The method is set up for drawing to the current graphics context (as returned by UIGraphicsGetCurrentContext).
 */
- (void)drawFooterForPageAtIndex:(NSInteger)index inRect:(CGRect)footerRect;

@end
