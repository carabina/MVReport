Pod::Spec.new do |s|
  s.name         = 'MVReport'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/Moroverse/MVReport'
  s.authors      = { 'Moroverse' => 'moroverse@gmail.com' }
  s.summary      = 'Lightweight Objective-C framework for report generation on iOS'

# Source Info
  s.platform     =  :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       =  { :git => 'https://github.com/Moroverse/MVReport.git', :tag => "0.1.0" }
  s.public_header_files = 'MVReport/*.h'
  s.source_files = 'MVReport/MVReport-iOS.h'
  s.frameworks    =  'CoreGraphics', 'UIKit', 'CoreText'

  s.requires_arc = true
  
# Pod Dependencies

end