//
//  MVTReportPreviewController.m
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

#import "MVTPDFReportPreviewController.h"

@interface MVTPDFReportPreviewController ()

@property (nonatomic, strong)UIPopoverController *sharingPopoverController;
@property (nonatomic, readonly)UIWebView *webView;

@end

@implementation MVTPDFReportPreviewController

- (instancetype)initWithPDFData:(NSData *)data
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.PDFData = data;
    }
    
    return self;
}

- (void)loadView
{
    self.view = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.leftBarButtonItem = doneButton;
    self.navigationItem.rightBarButtonItem = shareButton;
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

- (UIWebView *)webView
{
    return (UIWebView *)self.view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.webView loadData:self.PDFData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
}


- (IBAction)done:(id)sender
{
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)share:(id)sender
{
    if (self.sharingPopoverController)
    {
        return;
    }
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.PDFData] applicationActivities:nil];
    __weak typeof(activityViewController) weakViewController = activityViewController;
    activityViewController.completionHandler = ^(NSString *activityType, BOOL completed)
    {
        [self.sharingPopoverController dismissPopoverAnimated:YES];
        self.sharingPopoverController = nil;
        weakViewController.completionHandler = nil;
    };
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.sharingPopoverController = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [self.sharingPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else
    {
        [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
    }
}

@end
