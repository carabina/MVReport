//
//  MVTPersonSectionElement.m
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

#import "MVTPersonSectionElement.h"

@implementation MVTPersonSectionElement

- (void)drawTopFrameInRect:(CGRect)rect
{
    UIBezierPath* rectanglePath = UIBezierPath.bezierPath;
    [rectanglePath moveToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 12.23)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.52, CGRectGetMinY(rect) + 5.36) controlPoint1: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 8.71) controlPoint2: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 6.95)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 0.6, CGRectGetMinY(rect) + 5.05)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 5.05, CGRectGetMinY(rect) + 0.6) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 1.35, CGRectGetMinY(rect) + 2.98) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 2.98, CGRectGetMinY(rect) + 1.35)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 12.23, CGRectGetMinY(rect)) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 6.95, CGRectGetMinY(rect)) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 8.71, CGRectGetMinY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect) - 12.23, CGRectGetMinY(rect))];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 5.36, CGRectGetMinY(rect) + 0.52) controlPoint1: CGPointMake(CGRectGetMaxX(rect) - 8.71, CGRectGetMinY(rect)) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 6.95, CGRectGetMinY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect) - 5.05, CGRectGetMinY(rect) + 0.6)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 0.6, CGRectGetMinY(rect) + 5.05) controlPoint1: CGPointMake(CGRectGetMaxX(rect) - 2.98, CGRectGetMinY(rect) + 1.35) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 1.35, CGRectGetMinY(rect) + 2.98)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 12.23) controlPoint1: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 6.95) controlPoint2: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 8.71)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
}

- (void)drawBottomFrameInRect:(CGRect)rect
{
    UIBezierPath* rectanglePath = UIBezierPath.bezierPath;
    [rectanglePath moveToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 9)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 9)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 8.55)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 5.51, CGRectGetMaxY(rect) - 0.67) controlPoint1: CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 5.03) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 2.2, CGRectGetMaxY(rect) - 1.88)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 13.59, CGRectGetMaxY(rect)) controlPoint1: CGPointMake(CGRectGetMaxX(rect) - 7.65, CGRectGetMaxY(rect)) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 9.63, CGRectGetMaxY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 12.23, CGRectGetMaxY(rect))];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 5.86, CGRectGetMaxY(rect) - 0.59) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 9.63, CGRectGetMaxY(rect)) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 7.65, CGRectGetMaxY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 5.51, CGRectGetMaxY(rect) - 0.67)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 8.55) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 2.2, CGRectGetMaxY(rect) - 1.88) controlPoint2: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 5.03)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 9) controlPoint1: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 9) controlPoint2: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 9)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 9)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect))];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
}

- (void)drawMiddleFrameInRect:(CGRect)rect
{
    CGPoint tl = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint tr = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint br = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint bl = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    UIBezierPath* rectanglePath = UIBezierPath.bezierPath;
    [rectanglePath moveToPoint: bl];
    [rectanglePath addLineToPoint: tl];
    [rectanglePath moveToPoint: tr];
    [rectanglePath addLineToPoint: br];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
}

- (void)drawFullFrameInRect:(CGRect)rect
{
    UIBezierPath* rectanglePath = UIBezierPath.bezierPath;
    [rectanglePath moveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.05096 * CGRectGetWidth(rect), CGRectGetMinY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 0.94904 * CGRectGetWidth(rect), CGRectGetMinY(rect))];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 5.36, CGRectGetMinY(rect) + 0.52) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 0.96372 * CGRectGetWidth(rect), CGRectGetMinY(rect)) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 6.95, CGRectGetMinY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect) - 5.05, CGRectGetMinY(rect) + 0.6)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 0.6, CGRectGetMinY(rect) + 5.05) controlPoint1: CGPointMake(CGRectGetMaxX(rect) - 2.98, CGRectGetMinY(rect) + 1.35) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 1.35, CGRectGetMinY(rect) + 2.98)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 0.10191 * CGRectGetHeight(rect)) controlPoint1: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 6.95) controlPoint2: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 0.07257 * CGRectGetHeight(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 0.89809 * CGRectGetHeight(rect))];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 0.52, CGRectGetMaxY(rect) - 5.36) controlPoint1: CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + 0.92743 * CGRectGetHeight(rect)) controlPoint2: CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 6.95)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect) - 0.6, CGRectGetMaxY(rect) - 5.05)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMaxX(rect) - 5.05, CGRectGetMaxY(rect) - 0.6) controlPoint1: CGPointMake(CGRectGetMaxX(rect) - 1.35, CGRectGetMaxY(rect) - 2.98) controlPoint2: CGPointMake(CGRectGetMaxX(rect) - 2.98, CGRectGetMaxY(rect) - 1.35)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.94904 * CGRectGetWidth(rect), CGRectGetMaxY(rect)) controlPoint1: CGPointMake(CGRectGetMaxX(rect) - 6.95, CGRectGetMaxY(rect)) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 0.96372 * CGRectGetWidth(rect), CGRectGetMaxY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 0.05096 * CGRectGetWidth(rect), CGRectGetMaxY(rect))];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 5.36, CGRectGetMaxY(rect) - 0.52) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 0.03628 * CGRectGetWidth(rect), CGRectGetMaxY(rect)) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 6.95, CGRectGetMaxY(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 5.05, CGRectGetMaxY(rect) - 0.6)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.6, CGRectGetMaxY(rect) - 5.05) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 2.98, CGRectGetMaxY(rect) - 1.35) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 1.35, CGRectGetMaxY(rect) - 2.98)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 0.89809 * CGRectGetHeight(rect)) controlPoint1: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 6.95) controlPoint2: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 0.92743 * CGRectGetHeight(rect))];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 0.10191 * CGRectGetHeight(rect))];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.52, CGRectGetMinY(rect) + 5.36) controlPoint1: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 0.07257 * CGRectGetHeight(rect)) controlPoint2: CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + 6.95)];
    [rectanglePath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 0.6, CGRectGetMinY(rect) + 5.05)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 5.05, CGRectGetMinY(rect) + 0.6) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 1.35, CGRectGetMinY(rect) + 2.98) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 2.98, CGRectGetMinY(rect) + 1.35)];
    [rectanglePath addCurveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.05096 * CGRectGetWidth(rect), CGRectGetMinY(rect)) controlPoint1: CGPointMake(CGRectGetMinX(rect) + 6.95, CGRectGetMinY(rect)) controlPoint2: CGPointMake(CGRectGetMinX(rect) + 0.03628 * CGRectGetWidth(rect), CGRectGetMinY(rect))];
    [rectanglePath closePath];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
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
    CGContextRef currentContext =  UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    UIBezierPath *mask = [UIBezierPath bezierPathWithRect:rect];
    [mask addClip];
    
    CGRect relativeRect = [self contentRectRelativeToPageAtIndex:pageIndex];
    [UIColor.blueColor setStroke];
    
    CGRect inR = CGRectInset(relativeRect, 2, 2);
    if (self.pageCount == 1)
    {
        [self drawFullFrameInRect:inR];
    }
    else
    {
        if (pageIndex == self.startPage)
        {
            [self drawTopFrameInRect:inR];
        }
        else if (pageIndex == self.startPage + self.pageCount -1)
        {
            [self drawBottomFrameInRect:inR];
        }
        else
        {
            [self drawMiddleFrameInRect:inR];
        }
    }
    
    CGRect tR = CGRectInset(inR, 5, 5);
    NSString *personName = [NSString stringWithFormat:@"%@ %@", self.person[@"firstName"], self.person[@"lastName"]];
    NSString *personMail = self.person[@"email"];
    NSString *personBloodType = self.person[@"bloodType"];
    
    NSDictionary *nameTextDictionary = [self textAttributesForFont:[UIFont boldSystemFontOfSize:18] color:[UIColor blueColor] alignment:NSTextAlignmentLeft];
    NSDictionary *mailTextDictionary = [self textAttributesForFont:[UIFont italicSystemFontOfSize:12] color:[UIColor grayColor] alignment:NSTextAlignmentLeft];
    NSDictionary *bloodTextDictionary = [self textAttributesForFont:[UIFont boldSystemFontOfSize:44] color:[UIColor colorWithRed:1 green:0.2 blue:0.8 alpha:0.5] alignment:NSTextAlignmentCenter];
    
    CGRect nameRect = CGRectZero;
    nameRect.size = [personName sizeWithAttributes:nameTextDictionary];
    nameRect.origin = tR.origin;
    
    CGRect mailRect = CGRectZero;
    mailRect.size = [personMail sizeWithAttributes:mailTextDictionary];
    mailRect.origin = CGPointMake(nameRect.origin.x, CGRectGetMaxY(nameRect)+2);
    
    CGRect bloodRect = CGRectZero;
    bloodRect.size = [personBloodType sizeWithAttributes:bloodTextDictionary];
    bloodRect = [self alignedRect:bloodRect toRectCenter:relativeRect];
    
    if (CGRectContainsRect(tR, bloodRect))
    {
        [personBloodType drawInRect:bloodRect withAttributes:bloodTextDictionary];
    }
    
    if (CGRectContainsRect(tR, nameRect))
    {
        [personName drawInRect:nameRect withAttributes:nameTextDictionary];
    }
    
    if (CGRectContainsRect(tR, mailRect))
    {
        [personMail drawInRect:mailRect withAttributes:mailTextDictionary];
    }
    
    CGContextRestoreGState(currentContext);
}

- (CGRect)rectForContentRect:(CGRect)contentRect
{
    CGFloat h = 100;
    CGRect result = CGRectMake(contentRect.origin.x, contentRect.origin.y, contentRect.size.width, h);
    return result;
}


@end
