#!/bin/sh

if [[ "$DEV" = "IOS" ]]; then
  rvm system
  gem update CFPropertyList
  scripts/ios/sign.sh
fi
