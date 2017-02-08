#!/bin/bash

if [[ "$DEV" = "IOS" ]]; then
  scripts/ios/remove-key.sh
fi
