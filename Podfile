platform :ios, '10.0'
use_frameworks!

# Pods for SGWSApp
pod 'ReachabilitySwift'
pod 'SwipeCellKit', '~> 2.1.0'
pod 'DateToolsSwift'
pod 'IQKeyboardManagerSwift'
# pod 'ActionSheetPicker-3.0'

def sf_pods
    pod 'SalesforceAnalytics',    :git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
    pod 'SalesforceSDKCore',    :git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
    pod 'SalesforceSwiftSDK',    :git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
    pod 'SmartStore',        :git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
    pod 'SmartSync',            :git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
end

target 'SWSApp' do
  sf_pods
  pod 'PromiseKit', :git => 'https://github.com/mxcl/PromiseKit', :tag => '5.0.3'

  target 'SWSAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SWSAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

# Fix for xcode9/fmdb/sqlcipher/cocoapod issue - see https://discuss.zetetic.net/t/ios-11-xcode-issue-implicit-declaration-of-function-sqlite3-key-is-invalid-in-c99/2198/27
post_install do | installer |
  print "SQLCipher: link Pods/Headers/sqlite3.h"
  system "mkdir -p Pods/Headers/Private && ln -s ../../SQLCipher/sqlite3.h Pods/Headers/Private"

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end

