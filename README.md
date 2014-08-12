MVReport
========

Lightweight Objective-C framework for report generation on iOS.

## Introduction

In 2011 Apple introduced iOS Printing API, a set of classes intended to simplify printing from iOS devices. Those classes will allow user to compose document for printing and send it to a printer.
However, that didn't resolve a reporting problem completely. If user wants to print a document he can use those new classes, but if one wants to generate document and send it via mail, or share it on some other way
he will need to abandon this approach and use c frameworks to generate PDF report. MVReport aims to solve this problem by introducing set of classes similar to Apple's printing classes but without limitations.
I tried to use the same paradigm, formatter and page renderer objects, and same methods where it make sense. But, I also extended functionality by adding objects called report sections that can be used to generate
repeatable content (think of table views), and dynamic chaining of formatters through the document.

I marked this release as 0.1 because it requires more testing for some edge cases, and there are some parts of code I'm not satisfied how it looks now. I can imagine fairly complex cases resolved with existing classes and methods, but I didn't tried
enough of them to call release 1.0.

## How To Get Started

- [Download MVReport](https://github.com/Moroverse/MVReport/archive/master.zip) and try out the included iPhone & iPad example app
- Check out the [documentation](http://cocoadocs.org/docsets/MVReport/0.1.0/) for a comprehensive look at all of the APIs available in MVReport

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like MVReport in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod "MVReport", "~> 0.1.2"
```

## Requirements

MVReport 0.1 and higher requires Xcode 5, targeting either iOS 7.0 and above. MVReport uses ARC.

## Usage

### Simple Page Elements
If you wish only to generate document with portion of text, or simple repeatable content you can use this approach. 
Create concrete instance of `MVReport` depending on report type you wish to generate (currently there is only `MVPDFReport` available), and initialize it with your `MVReportPageInfo` object. Create concrete instance of `MVReportPageElement` and initialize it with your plain text or HTML text. Attach `MVReportPageElement` instance to pageElement property of `MVReport` instance and generate report.
```objective-c
MVReport *report = [[MVPDFReport alloc] initWithPageInfo:myPageInfo];
MVReportPageElement *pageElement = [[MVReportSimpleTextFormatter alloc] initWithText:mySimpleText];
report.pageElement = pageElement;
NSData *data = [report generateReport];
```
Result is a PDF document that can be written to file, send via email, or send to printer...

#### Report Section
If you need to put repeatable content in report you may use `MVReportSection` class. You don't have to subclass `MVReportSection` if there is no need for section heder, footer or some custom drawing not related to repeatable content.
You will need, however to create custom subclass of `MVReportSectionElement`, object that will draw one row in a section. You can think of it as a table row cell. In your subclass you will override method that returns content rect (height of the row in other words), and method that actually draws something:
```objective-c
@interface MyAcmeElement : MVReportSectionElement

@property (nonatomic, copy)NSString *text;

@end

@implementation MyAcmeElement

- (CGRect)rectForContentRect:(CGRect)contentRect
{
    if (contentRect.size.height > 44)
    {
        contentRect.size.height = 44;
    }
    
    return contentRect;
}

- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex
{
    CGRect myRect = CGRectInset(rect, 3, 3);
    [self.text drawInRect:myRect withAttributes:textAttributes];
}

@end
```
Having `MyAcmeElement` class, its easy to compose report:
```objective-c
NSMutableArray *textElements = [NSMutableArray array];
for (NSString *text in myTextArray)
{
	MyAcmeElement *element = [[MyAcmeElement alloc] init];
    element.text = text;
    [textElements addObject:element];
}

MVReportSection *section = [[MVReportSection alloc] init];
section.sectionElements = textElements;

MVReport *report = [[MVPDFReport alloc] initWithPageInfo:myPageInfo];
report.pageElement = section;

NSData *data = [report generateReport];
```
### Page Renderer

TBD

#### Combining Page Elements in Page Renderer

TBD
