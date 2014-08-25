//
//  MVTHTMLPageRenderer.m
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

#import "MVTLoremPageRenderer.h"

@implementation MVTLoremPageRenderer

- (NSDictionary *)textAttributesForFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (font)
    {
        [dictionary setObject:font forKey:NSFontAttributeName];
    }
    
    if (color)
    {
        [dictionary setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = alignment;
    
    [dictionary setObject:style forKey:NSParagraphStyleAttributeName];
    
    return [dictionary copy];
}

- (CGRect)alignedRect:(CGRect)rect toRectCenter:(CGRect)sourceRect
{
    CGFloat x = CGRectGetMidX(sourceRect);
    CGFloat y = CGRectGetMidY(sourceRect);
    
    CGFloat rx = CGRectGetMidX(rect);
    CGFloat ry = CGRectGetMidY(rect);
    
    CGFloat dx = x - rx;
    CGFloat dy = y - ry;
    
    CGRect result = CGRectMake(rect.origin.x + dx, rect.origin.y + dy, rect.size.width, rect.size.height);
    return result;
}

- (void)drawHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect
{
    NSString *headerText = @"LOREM IPSUM REPORT";
    NSDictionary *textAttributes = [self textAttributesForFont:[UIFont boldSystemFontOfSize:18] color:[UIColor purpleColor] alignment:NSTextAlignmentCenter];
    CGRect rect = CGRectZero;
    rect.size = [headerText sizeWithAttributes:textAttributes];
    rect = [self alignedRect:rect toRectCenter:headerRect];
    [headerText drawInRect:rect withAttributes:textAttributes];
    CGRect inseted = CGRectInset(headerRect, 5, 5);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:inseted];
    path.lineWidth = 1;
    [[UIColor purpleColor] setStroke];
    [path stroke];
}

- (void)drawFooterForPageAtIndex:(NSInteger)index inRect:(CGRect)footerRect
{
    NSString *footerText = [NSString stringWithFormat:@"Page %ld of %ld",index+1, self.numberOfPages];
    NSDictionary *textAttributes = [self textAttributesForFont:[UIFont systemFontOfSize:12] color:[UIColor blackColor] alignment:NSTextAlignmentRight];
    [footerText drawInRect:footerRect withAttributes:textAttributes];
}

- (void)drawContentForPageAtIndex:(NSInteger)index inRect:(CGRect)contentRect
{
    if (!self.shouldDrawWatermark)
    {
        return;
    }
    
    UIColor *paleGray = [UIColor colorWithWhite:0.5 alpha:0.25];
    NSString *sampleText = @"SAMPLE REPORT!";
    NSDictionary *textAttributes = [self textAttributesForFont:[UIFont boldSystemFontOfSize:44] color:paleGray alignment:NSTextAlignmentCenter];
    CGRect textRect = CGRectZero;
    textRect.size = [sampleText sizeWithAttributes:textAttributes];
    textRect = [self alignedRect:textRect toRectCenter:contentRect];
    [sampleText drawInRect:textRect withAttributes:textAttributes];
    [paleGray setStroke];
    CGRect inflated = CGRectInset(textRect, -10, -10);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:inflated];
    path.lineWidth = 4;
    [path stroke];
}

@end
