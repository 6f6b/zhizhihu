source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'zhizhihu' do
	pod 'MJRefresh'
	pod 'Alamofire', '~> 4.3.0'
	pod 'ObjectMapper', '~> 2.2'
	pod 'Kingfisher', '~> 3.0'
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
end
