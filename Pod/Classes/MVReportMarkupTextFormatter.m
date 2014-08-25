//
//  MVReportMarkupTextFormatter.m
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

#import "MVReportMarkupTextFormatter.h"
#import "MVReportTextFormatter+Private.h"

@interface MVReportMarkupTextFormatter ()

@property(nonatomic,readwrite, copy) NSString *markupText;

@end

@implementation MVReportMarkupTextFormatter

- (instancetype)initWithMarkupText:(NSString *)markupText
{
    self = [super init];
    if (self)
    {
        self.markupText = markupText;
    }
    
    return self;
}

- (void)setMarkupText:(NSString *)markupText
{
    _markupText = markupText;
    
    if ([_markupText length] > 0)
    {
        NSData *sData = [markupText dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@(8)};
        NSError *error;
        NSAttributedString *aStr = [[NSAttributedString alloc] initWithData:sData options:options documentAttributes:nil error:&error];
        self.attributedString = aStr;
    }
    else
    {
        self.attributedString = nil;
    }
}

@end
