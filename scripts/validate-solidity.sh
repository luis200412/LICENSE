#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

SOLC_VERSION="0.8.24"
SOLC_BINARY="solc-linux-amd64-v${SOLC_VERSION}+commit.e11b9ed9"
SOLC_SHA256="fb03a29a517452b9f12bcf459ef37d0a543765bb3bbc911e70a87d6a37c30d5f"
SOLC_URL="https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solc-static-linux"
SOLC_PATH="${TMP_DIR}/solc"

curl -fsSL "$SOLC_URL" -o "$SOLC_PATH"
echo "${SOLC_SHA256}  ${SOLC_PATH}" | sha256sum --check --status
chmod +x "$SOLC_PATH"

(
    cd "$TMP_DIR"
    "$SOLC_PATH" --metadata-hash ipfs --combined-json abi,bin "${ROOT_DIR}/contracts/RemixMessageStore.sol" > /dev/null
)
