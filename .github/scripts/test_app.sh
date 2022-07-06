#!/bin/bash

set -eo pipefail

xcodebuild -workspace OTFMagicBox.xcworkspace \
            -scheme OTFMagicBox
            -destination platform=iOS\ Simulator,OS=13.3,name=iPhone\ 11 \
            clean test | xcpretty
