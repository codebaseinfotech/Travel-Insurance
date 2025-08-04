# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Hamraa Insurance' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Travel Insurance

  
  pod 'OTPFieldView'
  pod 'DropDown'
  pod 'IQKeyboardManagerSwift', '6.5.10' # specify exact version
  pod 'Toast-Swift'
  pod 'Alamofire'
  pod 'SVProgressHUD'
  pod 'SDWebImage', '~> 5.0'
  pod 'Firebase/Messaging'
  pod 'FirebaseUI/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'ADCountryPicker'
  pod 'NYTPhotoViewer', '~> 1.1.0'
  pod 'libPhoneNumber-iOS', '0.9.15' # specify exact version
  pod 'JMMaskTextField-Swift'
  pod 'UITextView+Placeholder'
  pod 'SwiftyJSON'
  pod 'JMMaskTextField-Swift'
  
   target 'Travel InsuranceTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'Travel InsuranceUITests' do
    # Pods for testing
  end
  
end

# This ensures compatibility for simulators on Apple Silicon (M1/M2/M3)
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end

  # 💡 Set iOS 12.0 for all pod targets
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
