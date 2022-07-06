#!/bin/bash

set -eo pipefail

xcrun altool --upload-app -t ios -f build/TestApp.ipa -u "$APP_STORE_CONNECT_USERNAME" -p "$APP_STORE_CONNECT_PASSWORD" --verbose
