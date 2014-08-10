//
//  MVTLoermIpsumSection.m
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

#import "MVTLoermIpsumSection.h"

@implementation MVTLoermIpsumSection

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

- (void)drawSectionHeaderForPageAtIndex:(NSInteger)index inRect:(CGRect)headerRect
{
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:headerRect];
//    [[UIColor grayColor] setFill];
//    [path fill];
    
    NSString *sectionHeader = @"Lorem Ipsum Section";
    NSDictionary *headerDictionary = [self textAttributesForFont:[UIFont boldSystemFontOfSize:14] color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
    CGRect rect = CGRectZero;
    rect.size = [sectionHeader sizeWithAttributes:headerDictionary];
    rect = [self alignedRect:rect toRectCenter:headerRect];
    rect.origin.x = headerRect.origin.x + 10;
    [sectionHeader drawInRect:rect withAttributes:headerDictionary];
}

- (void)drawSectionFooterForPageAtIndex:(NSInteger)index inRect:(CGRect)footerRect
{
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:footerRect];
//    [[UIColor greenColor] setFill];
//    [path fill];
    
    NSString *sectionFooter = @"end of the list";
    NSDictionary *footerDictionary = [self textAttributesForFont:[UIFont systemFontOfSize:14] color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
    CGRect rect = CGRectZero;
    rect.size = [sectionFooter sizeWithAttributes:footerDictionary];
    rect = [self alignedRect:rect toRectCenter:footerRect];
    rect.origin.x = CGRectGetMaxX(footerRect)- rect.size.width;
    [sectionFooter drawInRect:rect withAttributes:footerDictionary];
}

@end
