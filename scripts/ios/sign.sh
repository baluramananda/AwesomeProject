#!/bin/sh

if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  echo "This is a pull request. No deployment will be done."
  exit 0
fi
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
  echo "Testing on a branch other than master. No deployment will be done."
  exit 0
fi

openssl aes-256-cbc -k "$KEY_PASSWORD" -in scripts/ios/profile/AwesomeProject_Ad_Hoc.mobileprovision.enc -d -a -out scripts/ios/profile/AwesomeProject_Ad_Hoc.mobileprovision
openssl aes-256-cbc -k "$KEY_PASSWORD" -in scripts/ios/certs/dist.cer.enc -d -a -out scripts/ios/certs/dist.cer
openssl aes-256-cbc -k "$KEY_PASSWORD" -in scripts/ios/certs/dist.p12.enc -d -a -out scripts/ios/certs/dist.p12

#PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_NAME.mobileprovision"
PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/AwesomeProject_Ad_Hoc.mobileprovision"
#OUTPUTDIR="$PWD/build/Release-iphoneos"

#xcodebuild archive -project ./ios/AwesomeProject.xcodeproj -scheme AwesomeProject -configuration RELEASE -derivedDataPath ./ios/build -archivePath ./ios/build/Products/AwesomeProject.xcarchive

xcodebuild -exportArchive -archivePath ./ios/build/Products/AwesomeProject.xcarchive -exportOptionsPlist ./scripts/ios/exportOptions-Release.plist -exportPath ./ios/build/Products/IPA
