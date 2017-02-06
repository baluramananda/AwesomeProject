#!/bin/sh

if [["$DEV"="IOS"]]; then
  scripts/ios/sign.sh
fi
