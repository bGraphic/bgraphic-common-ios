Pod::Spec.new do |s|
  s.name         = "bGraphicCommonStuff"
  s.version      = "1.0.2"
  s.summary      = "Reusable bGraphic stuff."
  s.homepage     = "http://bgraphic.no"
  s.license      = 'MIT'
  s.author       = { "raae" => "raae@bgraphic.no" }
  s.source       = { :git => "https://github.com/bGraphic/bgraphic-common-ios.git", :tag => s.version.to_s }
  
  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true
  
  s.source_files = 'Classes/ios/*.{h,m}'
  s.resources = 'Assets/*.{png,storyboard,xib}'
  
  s.dependency 'TestFlightSDK', '~> 3.0'
  s.framework = 'MessageUI'
end
