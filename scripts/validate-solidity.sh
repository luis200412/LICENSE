#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

SOLC_VERSION="0.8.24"
SOLC_BINARY="solc-linux-amd64-v${SOLC_VERSION}+commit.e11b9ed9"
SOLC_SHA256="fb03a29a517452b9f12bcf459ef37d0a543765bb3bbc911e70a87d6a37c30d5f"
SOLC_URL="https://binaries.soliditylang.org/linux-amd64/${SOLC_BINARY}"
SOLC_FALLBACK_URL="https://raw.githubusercontent.com/argotorg/solc-bin/gh-pages/linux-amd64/${SOLC_BINARY}"
SOLC_PATH="${TMP_DIR}/solc"

if ! curl -fsSL "$SOLC_URL" -o "$SOLC_PATH" 2>/dev/null; then
    curl -fsSL "$SOLC_FALLBACK_URL" -o "$SOLC_PATH"
fi

echo "${SOLC_SHA256}  ${SOLC_PATH}" | sha256sum --check --status
chmod +x "$SOLC_PATH"

(
    cd "$TMP_DIR"
    "$SOLC_PATH" --combined-json abi,bin "${ROOT_DIR}/contracts/RemixMessageStore.sol" > /dev/null
)
