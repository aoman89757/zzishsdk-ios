#
# Be sure to run `pod lib lint ZzishSDK.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZzishSDK"
  s.version          = "0.2.3"
  s.summary          = "Wrapper for Zzish REST API"
  s.description      = <<-DESC
                       A store and forward wrapper for creating activities/actions on the Zzish Platform

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://www.zzish.com"
  s.license          = 'MIT'
  s.author           = { "Samir Seetal" => "samir@zzish.com" }
  s.source           = { :git => "https://github.com/zzishdev/zzishsdk-ios.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'ZzishSDK' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.frameworks = "SystemConfiguration", "CFNetwork"
    s.library = "sqlite3"
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'Reachability', '3.2.0'
    s.dependency 'JSONModel', '1.0.1'
end
