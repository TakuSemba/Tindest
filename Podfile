platform :ios, '10.0'
use_frameworks!

target 'Tindest' do
pod 'Alamofire'
pod 'RxSwift'
pod 'RxCocoa'
pod 'ObjectMapper'
pod 'SDWebImage'
pod 'XLPagerTabStrip'
pod 'Koloda', :git => 'https://github.com/Yalantis/Koloda.git', :branch => 'swift-3'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
