#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_alibc.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_alibc'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AlibcTradeSDK','~> 4.0.1.6'
  s.dependency 'AliAuthSDK','~> 1.1.0.41-bc'
  s.dependency 'mtopSDK','~> 3.0.0.3-BC'
  s.dependency 'securityGuard','~> 5.4.191'
  s.dependency 'AliLinkPartnerSDK','~> 4.0.0.24'
  s.dependency 'BCUserTrack','~> 5.2.0.18-appkeys'
  s.dependency 'UTDID','~> 1.5.0.91'
  s.dependency 'WindVane','~> 8.5.0.46-bc11'
  s.platform = :ios, '8.0'

  s.frameworks = "CoreTelephony","CoreMotion","UIKit","Foundation"
  s.libraries = "z","c++","sqlite3.0"
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
