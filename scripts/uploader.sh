#!/bin/bash

if [[ "$DEV" = "IOS" ]]; then
  echo "Uploading ipa to TestFairy..."
  $TRAVIS_BUILD_DIR/scripts/tf_uploader.sh "$TRAVIS_BUILD_DIR/ios/build/Products/IPA/AwesomeProject.ipa"
fi

if [[ "$DEV" = "ANDROID" ]]; then
  echo "Uploading apk to TestFairy..."
  $TRAVIS_BUILD_DIR/scripts/tf_uploader.sh "$TRAVIS_BUILD_DIR/android/app/build/outputs/apk/app-release-unsigned.apk"
fi
