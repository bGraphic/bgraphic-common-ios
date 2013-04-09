Pod::Spec.new do |s|
  s.name         = "bGraphicCommon"
  s.version      = "1.0"
  s.summary      = "Common gfx and other stuff for bGraphic projects."
  s.homepage     = "http://bgraphic.no"
  s.license	     = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "raae" => "raae@bgraphic.no" }
  s.source       = { :git => "https://raae@bitbucket.org/raae/bgraphic-common-stuff.git", :tag => "1.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'bGraphicCommonStuff/*.{h,m}'
  s.resources = "bGraphicCommonStuff/*.png"
  s.requires_arc = true
  s.dependency 'TestFlightSDK', '~> 1.2.4'
  s.framework = 'MessageUI'
end
