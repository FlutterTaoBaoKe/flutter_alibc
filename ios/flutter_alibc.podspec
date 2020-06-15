#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_alibc'
  s.version          = '0.0.1'
  s.summary          = '阿里百川'
  s.description      = <<-DESC
阿里百川
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AlibcTradeSDK','4.0.1.6'
  s.dependency 'AliAuthSDK','1.1.0.41-bc'
  s.dependency 'mtopSDK','3.0.0.3-BC'
  s.dependency 'securityGuard','5.4.191'
  s.dependency 'AliLinkPartnerSDK','4.0.0.24'
  s.dependency 'BCUserTrack','5.2.0.18-appkeys'
  s.dependency 'UTDID','1.1.0.16'
  s.dependency 'WindVane','8.5.0.46-bc11'

  # s.vendored_frameworks ="AliBaichuan/Frameworks/*.framework"
  # s.resource = "AliBaichuan/Resources/*.bundle"

  s.frameworks = "CoreTelephony","CoreMotion","UIKit","Foundation"
  s.libraries = "z","c++","sqlite3.0"

  s.ios.deployment_target = '8.0'
  s.static_framework = true
end

