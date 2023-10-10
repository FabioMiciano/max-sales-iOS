source 'https://cdn.cocoapods.org/'
platform :ios, '16.0'
use_frameworks!

target 'MaxSales' do  
  pod 'SnapKit', '~> 5.0.0'
  pod 'InputMask', '5.0.0'
  pod 'SFFontFeatures'
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
