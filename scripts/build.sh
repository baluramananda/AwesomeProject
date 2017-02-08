#!/bin/bash

if [[ "$DEV" = "IOS" ]]; then
  xcodebuild -project $PWD/ios/AwesomeProject.xcodeproj -scheme AwesomeProject -configuration RELEASE OBJROOT=$PWD/ios/build SYMROOT=$PWD/ios/build -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.3'
  xcodebuild archive -project $PWD/ios/AwesomeProject.xcodeproj -scheme AwesomeProject -configuration RELEASE -derivedDataPath $PWD/ios/build -archivePath $PWD/ios/build/Products/AwesomeProject.xcarchive
fi

if [[ "$DEV" = "ANDROID" ]]; then
  $PWD/android/gradlew assembleRelease
fi
