#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
cleanup() {
    local status=$?
    if [[ $status -eq 0 ]]; then
        rm -rf "$TMP_DIR"
    else
        echo "Validation failed. Temporary files preserved at: ${TMP_DIR}" >&2
    fi
}
trap cleanup EXIT

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "Skipping local Solidity validation: this helper only runs on Linux environments." >&2
    exit 0
fi

for required_tool in curl sha256sum; do
    if ! command -v "$required_tool" >/dev/null 2>&1; then
        echo "Missing required tool: ${required_tool}" >&2
        exit 1
    fi
done

SOLC_VERSION="0.8.24"
SOLC_BINARY="solc-linux-amd64-v${SOLC_VERSION}+commit.e11b9ed9"
SOLC_SHA256="fb03a29a517452b9f12bcf459ef37d0a543765bb3bbc911e70a87d6a37c30d5f"
SOLC_URL="https://raw.githubusercontent.com/ethereum/solc-bin/gh-pages/linux-amd64/${SOLC_BINARY}"
SOLC_PATH="${TMP_DIR}/solc"

curl -fsSL "$SOLC_URL" -o "$SOLC_PATH"
if ! echo "${SOLC_SHA256}  ${SOLC_PATH}" | sha256sum --check --status; then
    echo "SHA256 verification failed for the downloaded Solidity compiler binary." >&2
    exit 1
fi

chmod +x "$SOLC_PATH"

shopt -s nullglob
CONTRACT_FILES=("${ROOT_DIR}"/contracts/*.sol)

if [[ ${#CONTRACT_FILES[@]} -eq 0 ]]; then
    echo "No Solidity contracts found under ${ROOT_DIR}/contracts." >&2
    exit 1
fi

(
    cd "$TMP_DIR"
    "$SOLC_PATH" --metadata-hash ipfs --combined-json abi,bin,userdoc,devdoc "${CONTRACT_FILES[@]}" > "${TMP_DIR}/solc-output.json"
)
