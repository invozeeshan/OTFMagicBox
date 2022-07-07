#!/bin/bash
#!/bin/sh


set -euo pipefail

security create-keychain -p "${SIGINING_CERTIFICATES_PASSWORD}" build.keychain
security list-keychains -s build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p "${SIGINING_CERTIFICATES_PASSWORD}" build.keychain
security set-keychain-settings
security import <(echo "${SIGINING_CERTIFICATES_DATA_DEBUG}" | base64 --decode) \
                -f pkcs12 \
                -k build.keychain \
                -P "${SIGINING_CERTIFICATES_PASSWORD}" \
                -T /usr/bin/codesign
security import <(echo "${SIGINING_CERTIFICATES_DATA_RELEASE}" | base64 --decode) \
                -f pkcs12 \
                -k build.keychain \
                -P "${SIGINING_CERTIFICATES_PASSWORD}" \
                -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple: -s -k "${SIGINING_CERTIFICATES_PASSWORD}" build.keychain
