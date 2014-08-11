MVReport
========

Lightweight Objective-C framework for report generation on iOS.

## Introduction

In 2011 Apple introduced iOS Printing API, a set of classes intended to simplify printing from iOS devices. Those classes will allow user to compose document for printing and send it to a printer.
However, that didn't resolve a reporting problem completely. If user wants to print a document he can use those new classes, but if one wants to generate document and send it via mail, or share it on some other way
he will need to abandon this approach and use c frameworks to generate PDF report. MVReport aims to solve this problem buy introducing set of classes similar to Apple's printing classes but without limitations.
I tried to use the same paradigm, formatter and page renderer objects, and same methods where it make sense. But, I also extended functionality by adding objects called report sections that can be used to generate
repeatable content (think of table views), and dynamic chaining of formatters through the document.

## How To Get Started

- [Download MVReport](https://github.com/Moroverse/MVReport/archive/master.zip) and try out the included iPhone & iPad example app
- Check out the [documentation](http://cocoadocs.org/docsets/MVReport/0.1.0/) for a comprehensive look at all of the APIs available in MVReport

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like MVReport in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod "MVReport", "~> 0.1.0"
```

## Requirements

MVReport 0.1 and higher requires Xcode 5, targeting either iOS 7.0 and above.

## Usage

TBD