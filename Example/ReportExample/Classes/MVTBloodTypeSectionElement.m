//
//  MVTBloodTypeSectionElement.m
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

#import "MVTBloodTypeSectionElement.h"

@implementation MVTBloodTypeSectionElement

- (CGRect)rectForContentRect:(CGRect)contentRect
{
    CGRect result = CGRectMake(contentRect.origin.x, contentRect.origin.y, contentRect.size.width, contentRect.size.height);
    if (result.size.height > 50)
    {
        result.size.height = 50;
    }
    
    return result;
}

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

- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex
{
    CGRect bloodRect = CGRectInset(rect, 3, 3);
    bloodRect.size.width = bloodRect.size.height;
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:bloodRect cornerRadius:8];
    [[UIColor redColor] setStroke];
    roundedPath.lineWidth = 1;
    [roundedPath stroke];
    NSString *bloodType = self.person[@"bloodType"];
    NSDictionary *bloodAttributes = [self textAttributesForFont:[UIFont boldSystemFontOfSize:16] color:[UIColor redColor] alignment:NSTextAlignmentCenter];
    CGSize typeSize = [bloodType sizeWithAttributes:bloodAttributes];
    CGRect typeRect = CGRectZero;
    typeRect.size = typeSize;
    typeRect = [self alignedRect:typeRect toRectCenter:bloodRect];
    [bloodType drawInRect:typeRect withAttributes:bloodAttributes];
    CGRect nameRect = CGRectOffset(rect, CGRectGetMaxX(bloodRect)+4, 0);
    nameRect.size.width -= CGRectGetMaxX(bloodRect)+4;
    NSString *name = [NSString stringWithFormat:@"%@ %@", self.person[@"firstName"], self.person[@"lastName"]];
    NSDictionary *nameAttributes = [self textAttributesForFont:[UIFont systemFontOfSize:16] color:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    CGSize s = [name sizeWithAttributes:nameAttributes];
    CGRect textRect = CGRectZero;
    textRect.size = s;
    textRect = [self alignedRect:textRect toRectCenter:nameRect];
    textRect.origin.x = nameRect.origin.x;
    [name drawInRect:textRect withAttributes:nameAttributes];
    CGPoint lineStart = CGPointMake(CGRectGetMinX(nameRect), CGRectGetMaxY(nameRect));
    CGPoint lineEnd = CGPointMake(CGRectGetMaxX(nameRect)-CGRectGetMaxX(bloodRect)+4, CGRectGetMaxY(nameRect));
    UIBezierPath *line = [UIBezierPath bezierPath];
    [line moveToPoint:lineStart];
    [line addLineToPoint:lineEnd];
    line.lineWidth = 1;
    [[UIColor redColor] setStroke];
    [line stroke];
}

@end
