#!/bin/sh

if [[ "$DEV" = "IOS" ]]; then
  scripts/ios/remove-key.sh
fi
