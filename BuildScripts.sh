#!/bin/bash

git status
git stash
git checkout Developer


xcodebuild clean build -workspace SWSApp.xcworkspace -scheme SWSApp -sdk iphoneos -configuration AppStoreDistribution archive -archivePath SWSApp.xcarchive DEVELOPMENT_TEAM=Y6PXE5R6AZ 'CODE_SIGN_IDENTITY=iPhone Distribution' 'PROVISIONING_PROFILE_SPECIFIER=SFAProvisioningProductionDistribution'

xcodebuild -exportArchive -archivePath SWSApp.xcarchive -exportPath . -exportOptionsPlist exportOptions.plist

