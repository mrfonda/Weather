# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Weather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

pod 'RealmSwift'
pod 'Alamofire'
pod 'AlamofireObjectMapper', '~> 4.0'
pod 'PopupDialog', '~> 0.5'
pod 'KeychainSwift', '~> 8.0'
pod 'DateToolsSwift'
#pod 'Mapbox-iOS-SDK'
pod 'GoogleMaps'
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

end
