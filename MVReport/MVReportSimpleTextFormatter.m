//
//  MVReportSimpleTextFormatter.m
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

#import "MVReportSimpleTextFormatter.h"
#import "MVReportTextFormatter+Private.h"

@implementation MVReportSimpleTextFormatter

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        self.color = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentLeft;
        self.text = text;
    }
    
    return self;
}

- (void)generateAttributedString
{
    if ([self.text length] <= 0)
    {
        self.attributedString = nil;
        return;
    }
    
    if (!self.font)
    {
        self.attributedString = nil;
        return;
    }
    
    if (!self.color)
    {
        self.attributedString = nil;
        return;
    }
    
    NSMutableAttributedString *mst = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range = NSMakeRange(0, [self.text length]);
    [mst addAttribute:NSFontAttributeName value:self.font range:range];
    [mst addAttribute:NSForegroundColorAttributeName value:self.color range:range];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = self.textAlignment;
    [mst addAttribute:NSParagraphStyleAttributeName value:style range:range];
    NSAttributedString *s = [mst copy];
    self.attributedString = s;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    [self generateAttributedString];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self generateAttributedString];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self generateAttributedString];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    [self generateAttributedString];
}

@end
