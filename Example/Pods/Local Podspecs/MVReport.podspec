#
# Be sure to run `pod lib lint MVReport.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MVReport"
  s.version          = "0.1.3"
  s.summary          = "Simple Objective-C framework for report generation on iOS"
  s.description      = <<-DESC
                       MVReport aims to solve reporting problem on iOS by introducing set of classes similar to Apple's iOS Printing API but for report generation. It uses the same paradigm, formatter and page renderer objects, and same methods where it make sense. But, It also extends functionality by adding some new objects that allow generation of repeatable content, and positioning of text sections relative to other sections.
                       DESC
  s.homepage         = "https://github.com/Moroverse/MVReport"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { 'Moroverse' => 'moroverse@gmail.com' }
  s.source           = { :git => 'https://github.com/Moroverse/MVReport.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/moroverse'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.{h,m}'
  #s.resources = 'Pod/Assets/*.png'

  s.private_header_files = "Pod/Classes/*{+Private}.h"
  s.frameworks = 'CoreGraphics', 'UIKit', 'CoreText'
end
