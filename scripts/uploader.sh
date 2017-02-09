#!/bin/bash

if [[ "$DEV" = "IOS" ]]; then
  scripts/tf_uploader "$TRAVIS_BUILD_DIR/ios/build/Products/IPA/AwesomeProject.ipa"
fi

if [[ "$DEV" = "ANDROID" ]]; then
  scripts/tf_uploader "$TRAVIS_BUILD_DIR/android/app/build/outputs/apk/app-release-unsigned.apk"
fi
