#!/bin/sh

echo "Decryptiong and exporting keys."
openssl aes-256-cbc -k "$KEY_PASSWORD" -in scripts/ios/profile/AwesomeProject_Ad_Hoc.mobileprovision.enc -d -a -out scripts/ios/profile/AwesomeProject_Ad_Hoc.mobileprovision
openssl aes-256-cbc -k "$KEY_PASSWORD" -in scripts/ios/certs/dist.cer.enc -d -a -out scripts/ios/certs/dist.cer
openssl aes-256-cbc -k "$KEY_PASSWORD" -in scripts/ios/certs/dist.p12.enc -d -a -out scripts/ios/certs/dist.p12

# Create a custom keychain and add it to the list
security create-keychain -p travis  ios-build.keychain
security list-keychains -d user -s ios-build.keychain
echo "Created ios-build key chain."

# Make the custom keychain default, so xcodebuild will use it for signing
security default-keychain -s ios-build.keychain

# Unlock the keychain
security unlock-keychain -p travis ios-build.keychain

# Set keychain timeout to 1 hour for long builds
# see http://www.egeek.me/2013/02/23/jenkins-and-xcode-user-interaction-is-not-allowed/
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

# Add certificates to keychain and allow codesign to access them
echo "Import certs and keys."
security import ./scripts/ios/certs/AppleWWDRCA.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/ios/certs/dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/ios/certs/dist.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign

# fix the travis stalling issue
security set-key-partition-list -S apple-tool:,apple: -s -k travis  ios-build.keychain

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "./scripts/ios/profile/$PROFILE_NAME.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
#cp "./scripts/ios/profile/AwesomeProject_Ad_Hoc.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
