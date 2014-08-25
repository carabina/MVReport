//
//  MVTSampleListViewController.m
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

#import "MVTSampleListViewController.h"
#import "MVTPDFReportPreviewController.h"

#import "MVTBloodTypeSectionElement.h"
#import "MVTPersonSectionElement.h"
#import "MVTLoremPageRenderer.h"
#import "MVTLoermIpsumSection.h"

@interface MVTSampleListViewController ()

@property (nonatomic, strong)MVReportPageInfo *pageInfo;

@end

@implementation MVTSampleListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageInfo = [[MVReportPageInfo alloc] init];
//    self.pageInfo.printableRect = CGRectInset(self.pageInfo.pageRect, 60, 60);
}

- (void)simpleTextFormatterExample
{
    MVPDFReport *report = [[MVPDFReport alloc] initWithPageInfo:self.pageInfo];
    NSString *lorem600 = NSLocalizedString(@"lorem600", nil);
    MVReportSimpleTextFormatter *simpleTextFormatter = [[MVReportSimpleTextFormatter alloc] initWithText:lorem600];
    report.pageElement = simpleTextFormatter;
    NSData *data = [report generateReport];
    
    MVTPDFReportPreviewController *previewController = [[MVTPDFReportPreviewController alloc] initWithPDFData:data];
    [self.navigationController pushViewController:previewController animated:YES];
}

- (void)htmlTextFormatterExample
{
    MVPDFReport *report = [[MVPDFReport alloc] initWithPageInfo:self.pageInfo];
    NSString *lorem600HTML = NSLocalizedString(@"lorem600HTML", nil);
    MVReportMarkupTextFormatter *htmlTextFormatter = [[MVReportMarkupTextFormatter alloc] initWithMarkupText:lorem600HTML];
    report.pageElement = htmlTextFormatter;
    NSData *data = [report generateReport];
    
    MVTPDFReportPreviewController *previewController = [[MVTPDFReportPreviewController alloc] initWithPDFData:data];
    [self.navigationController pushViewController:previewController animated:YES];
}

- (NSArray *)simpleSectionElements
{
    NSURL *pathToPeople = [[NSBundle mainBundle] URLForResource:@"People" withExtension:@"plist"];
    NSArray *people = [NSArray arrayWithContentsOfURL:pathToPeople];
    NSMutableArray *peopleArray = [NSMutableArray array];
    for (NSDictionary *person in people)
    {
        MVTBloodTypeSectionElement *element = [[MVTBloodTypeSectionElement alloc] init];
        element.person = person;
        [peopleArray addObject:element];
    }
    
    return peopleArray;
}

- (void)simpleReportSection
{
    MVPDFReport *report = [[MVPDFReport alloc] initWithPageInfo:self.pageInfo];
    MVReportSection *section = [[MVReportSection alloc] init];
    section.sectionElements = [self simpleSectionElements];
    report.pageElement = section;
    NSData *data = [report generateReport];
    
    MVTPDFReportPreviewController *previewController = [[MVTPDFReportPreviewController alloc] initWithPDFData:data];
    [self.navigationController pushViewController:previewController animated:YES];
}

- (void)simpleTextPageRendererExample
{
    MVPDFReport *report = [[MVPDFReport alloc] initWithPageInfo:self.pageInfo];
    NSString *lorem600 = NSLocalizedString(@"lorem600", nil);
    MVReportSimpleTextFormatter *simpleTextFormatter = [[MVReportSimpleTextFormatter alloc] initWithText:lorem600];
    MVTLoremPageRenderer *renderer = [[MVTLoremPageRenderer alloc] init];
    [renderer addPageElement:simpleTextFormatter startingAtPageAtIndex:0];
    renderer.headerHeight = 80;
    renderer.footerHeight = 44;
    report.pageRenderer = renderer;
    NSData *data = [report generateReport];
    
    MVTPDFReportPreviewController *previewController = [[MVTPDFReportPreviewController alloc] initWithPDFData:data];
    [self.navigationController pushViewController:previewController animated:YES];
}

- (NSArray *)personSectionElements
{
    NSURL *pathToPeople = [[NSBundle mainBundle] URLForResource:@"People" withExtension:@"plist"];
    NSArray *people = [NSArray arrayWithContentsOfURL:pathToPeople];
    NSMutableArray *peopleArray = [NSMutableArray array];
    for (NSDictionary *person in people)
    {
        MVTPersonSectionElement *element = [[MVTPersonSectionElement alloc] init];
        element.person = person;
        element.breakable = YES;
        [peopleArray addObject:element];
    }
    
    return peopleArray;
}

- (void)htmlTextPageRendererExample
{
    MVPDFReport *report = [[MVPDFReport alloc] initWithPageInfo:self.pageInfo];
    NSString *lorem600 = NSLocalizedString(@"lorem600", nil);
    MVReportSimpleTextFormatter *simpleTextFormatter = [[MVReportSimpleTextFormatter alloc] initWithText:lorem600];
    simpleTextFormatter.contentInsets = UIEdgeInsetsMake(10, 0, 0, self.pageInfo.printableRect.size.width/2-5);
    NSString *lorem600HTML = NSLocalizedString(@"lorem600HTML", nil);
    MVReportMarkupTextFormatter *htmlTextFormatter = [[MVReportMarkupTextFormatter alloc] initWithMarkupText:lorem600HTML];
    htmlTextFormatter.contentInsets = UIEdgeInsetsMake(10, self.pageInfo.printableRect.size.width/2+10, 0, 10);
    MVTLoremPageRenderer *renderer = [[MVTLoremPageRenderer alloc] init];
    [renderer addPageElement:simpleTextFormatter startingAtPageAtIndex:0];
    [renderer addPageElement:htmlTextFormatter startingAtPageAtIndex:1];
    renderer.headerHeight = 80;
    renderer.footerHeight = 44;
    renderer.shouldDrawWatermark = YES;
    report.pageRenderer = renderer;
    NSData *data = [report generateReport];
    
    MVTPDFReportPreviewController *previewController = [[MVTPDFReportPreviewController alloc] initWithPDFData:data];
    [self.navigationController pushViewController:previewController animated:YES];
}

- (void)multipleSectionsPageRendererExample
{
    MVPDFReport *report = [[MVPDFReport alloc] initWithPageInfo:self.pageInfo];
    MVTLoremPageRenderer *renderer = [[MVTLoremPageRenderer alloc] init];
    renderer.headerHeight = 80;
    renderer.footerHeight = 44;
    renderer.shouldDrawWatermark = YES;
    report.pageRenderer = renderer;

    NSString *lorem600 = NSLocalizedString(@"lorem600", nil);
    MVReportSimpleTextFormatter *simpleTextFormatter = [[MVReportSimpleTextFormatter alloc] initWithText:lorem600];
    [renderer addPageElement:simpleTextFormatter startingAtPageAtIndex:0];

    MVTLoermIpsumSection *section = [[MVTLoermIpsumSection alloc] init];
    section.headerHeight = 60;
    section.footerHeight = 30;
    section.sectionElements = [self personSectionElements];
    [renderer addPageElement:section afterPageElement:simpleTextFormatter];
    
    MVTLoermIpsumSection *section2 = [[MVTLoermIpsumSection alloc] init];
    section2.headerHeight = 30;
    section2.footerHeight = 30;
    section2.sectionElements = [self simpleSectionElements];
    [renderer addPageElement:section2 afterPageElement:section];

    NSData *data = [report generateReport];
    
    MVTPDFReportPreviewController *previewController = [[MVTPDFReportPreviewController alloc] initWithPDFData:data];
    [self.navigationController pushViewController:previewController animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            switch (indexPath.row)
        {
                case 0:
                    [self simpleTextFormatterExample];
                    break;
                case 1:
                    [self htmlTextFormatterExample];
                    break;
                case 2:
                    [self simpleReportSection];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row)
        {
            case 0:
                [self simpleTextPageRendererExample];
                break;
            case 1:
                [self htmlTextPageRendererExample];
                break;
            case 2:
                [self multipleSectionsPageRendererExample];
                break;
            default:
                break;
        }
            break;
        default:
            break;
    }
}


@end
