#!/bin/bash
#!/bin/sh


set -euo pipefail

security create-keychain -p "" build.keychain
security list-keychains -s build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p "" build.keychain
security set-keychain-settings
security import <(echo "${SIGINING_CERTIFICATES_DATA}" | base64 --decode) \
                -f pkcs12 \
                -k build.keychain \
                -P "${SIGINING_CERTIFICATES_PASSWORD}" \
                -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple: -s -k "" build.keychain
