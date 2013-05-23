Pod::Spec.new do |s|
  s.name         = "bGraphicCommon"
  s.version      = "1.1"
  s.summary      = "Common gfx and other stuff for bGraphic projects."
  s.homepage     = "http://bgraphic.no"
  s.license	     = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "raae" => "raae@bgraphic.no" }
  s.source       = { :git => "https://github.com/bGraphic/bGraphic-common-ios.git", :tag => "1.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'bGraphicCommonStuff/*.{h,m}'
  s.resources = "bGraphicCommonStuff/*.{png,xib}"
  s.requires_arc = true
  s.dependency 'TestFlightSDK'
  s.framework = 'MessageUI'
end
