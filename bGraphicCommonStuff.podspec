Pod::Spec.new do |s|
  s.name         = "bGraphicCommonStuff"
  s.version      = "0.1.0"
  s.summary      = "Reusable bGraphic stuff."
  s.homepage     = "http://bgraphic.no"
  s.license      = 'MIT'
  s.author       = { "raae" => "raae@bgraphic.no" }
  s.source       = { :git => "git@github.com:bGraphic/bGraphic-common-ios.git", :tag => s.version.to_s }
  
  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true
  
  s.source_files = 'Classes/ios/*.{h,m}'
  s.resources = 'Assets/*.{png,storyboard}'
  
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/Parse/Parse.framework/Headers"' }
  
  s.dependency 'TestFlightSDK', '~> 3.0'
  s.framework = 'MessageUI'
end
