platform :ios, '10.0'
use_frameworks!

# Pods for SGWSApp
pod 'DropDown'
pod 'ReachabilitySwift'


def sf_pods
	pod 'SalesforceAnalytics',	:git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
	pod 'SalesforceSDKCore',	:git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
	pod 'SalesforceSwiftSDK',	:git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
	pod 'SmartStore',		:git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
	pod 'SmartSync',			:git => 'https://github.com/forcedotcom/SalesforceMobileSDK-iOS'
    pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'master'
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
end

