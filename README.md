# Remix + MetaMask Deployment Starter

This repository is a **minimal Remix IDE deployment starter** for an Ethereum-compatible smart contract.

It is intentionally small so it can work with:

- **Remix IDE** for editing, compiling, and deploying
- **MetaMask** as the wallet/provider
- **Ethereum-compatible networks**
- **Cronos / Crypto.com EVM networks**

> [!IMPORTANT]
> This repository does **not** mean anything has already been deployed. Actual deployment must be done manually by a wallet owner who reviews and approves transactions in MetaMask.

## What is included

- `LICENSE` - existing MIT license preserved
- `contracts/RemixMessageStore.sol` - simple deployable Solidity contract
- `.github/workflows/solidity-validate.yml` - GitHub Actions compilation check

## Contract summary

`RemixMessageStore.sol` is a simple example contract for safe first deployments:

- stores a message string on-chain
- records the deployer as `owner`
- allows only the owner to update the message
- rejects empty message updates
- emits an event when the message changes

This is **not** a token, exchange, bridge, or financial product.

## Prerequisites

Before deploying, you need:

1. A desktop browser with access to [Remix IDE](https://remix.ethereum.org/)
2. The MetaMask browser extension installed and unlocked
3. A wallet address you control
4. A **testnet** selected first
5. Testnet gas funds for the network you want to use

## Remix workflow

### 1. Open the contract in Remix

Choose one of these methods:

- **Upload/import manually**
  - Download or clone this repository
  - Open [Remix IDE](https://remix.ethereum.org/)
  - In the File Explorers panel, create a `contracts` folder if needed
  - Upload `contracts/RemixMessageStore.sol` from your local copy

- **Copy/paste**
  - Create a new file named `RemixMessageStore.sol` in Remix
  - Paste in the contents of `contracts/RemixMessageStore.sol`

### 2. Compile

In Remix:

1. Open the **Solidity Compiler** tab
2. Select compiler version **0.8.24**
3. Compile `RemixMessageStore.sol`
4. Confirm the compile completes without errors

For explorer verification later, remember the verifier must match the **exact compiler version** you used in Remix.

The contract uses:

- explicit pragma: `pragma solidity ^0.8.24;`
- no external imports
- no constructor arguments

### 3. Connect MetaMask through Injected Provider

In Remix:

1. Open the **Deploy & Run Transactions** tab
2. Set **Environment** to **Injected Provider - MetaMask**
3. Approve the connection in MetaMask
4. Confirm Remix shows the correct wallet address and selected network

> [!NOTE]
> MetaMask is the wallet/provider.
> "Crypto.com" in this context refers to the **Cronos ecosystem**, which is EVM-compatible and can be used through MetaMask after adding the correct network.

### 4. Start with a testnet

Deploy to a testnet first before considering any mainnet deployment.

Recommended first choices:

- **Sepolia** for Ethereum testing
- **Cronos Testnet** for Cronos/Crypto.com testing

### 5. Deploy

With MetaMask connected:

1. Confirm the correct network is selected in MetaMask
2. Confirm the `RemixMessageStore` contract is selected in Remix
3. Click **Deploy**
4. Review the transaction in MetaMask
5. Approve the transaction only if:
   - the network is correct
   - the account is correct
   - the gas estimate looks reasonable
6. Wait for the transaction to be mined

### 6. Verify the deployed address

After deployment:

1. Copy the deployed contract address from Remix
2. Open the appropriate block explorer
3. Confirm:
   - the address exists on the network you intended
   - the deployer address matches your MetaMask account
   - the transaction hash succeeded
4. In Remix, expand the deployed contract and call:
   - `owner()` to confirm the deployer address
   - `message()` to confirm the initial stored value

## Network guidance

MetaMask can work with many EVM-compatible networks. For any network:

- use the **official chain ID**
- use a trusted **RPC URL**
- use the correct **block explorer**
- test on a **testnet** first

### Common networks

| Network | Chain ID | Currency | RPC guidance | Explorer |
| --- | ---: | --- | --- | --- |
| Ethereum Mainnet | `1` | ETH | Usually already available in MetaMask; otherwise use a trusted RPC provider such as Infura, Alchemy, QuickNode, or another provider you control | https://etherscan.io/ |
| Sepolia | `11155111` | ETH | Use a trusted Sepolia RPC from your provider if MetaMask does not already expose it | https://sepolia.etherscan.io/ |
| Cronos Mainnet | `25` | CRO | Public RPC commonly used: `https://evm.cronos.org` | https://cronoscan.com/ |
| Cronos Testnet | `338` | TCRO | Public RPC commonly used: `https://evm-t3.cronos.org` | https://testnet.cronoscan.com/ |

> [!CAUTION]
> RPC endpoints can change. Before adding or using a network, compare the chain data with the official network documentation or your infrastructure provider.

### Adding Cronos to MetaMask manually

If Cronos is not already present in MetaMask:

1. Open MetaMask
2. Choose **Add network**
3. Enter the chain ID, RPC URL, and explorer from trusted Cronos documentation
4. Save the network
5. Switch to **Cronos Testnet** first

## Testnet deployment checklist

Use this checklist before any live deployment:

- [ ] I compiled the contract successfully in Remix
- [ ] I connected Remix using **Injected Provider - MetaMask**
- [ ] I selected a **testnet**, not mainnet
- [ ] I confirmed the account in MetaMask is the intended deployer
- [ ] I funded the wallet with testnet gas tokens only
- [ ] I reviewed the estimated gas before approving
- [ ] I saved the deployed contract address
- [ ] I verified the transaction hash on the correct explorer
- [ ] I called `owner()` and `message()` after deployment

Only after successful testnet validation should you consider a mainnet deployment.

## Contract verification guidance

If you want public source verification after deployment:

1. Open the explorer for the deployed network
2. Find the deployed contract address
3. Use the explorer's **Verify and Publish** flow
4. Provide:
   - contract name: `RemixMessageStore`
   - the exact compiler version used for deployment
   - optimization settings matching your Remix compile configuration
   - the exact Solidity source from `contracts/RemixMessageStore.sol`

If verification fails, the usual causes are:

- wrong compiler version
- wrong optimization settings
- wrong source file content
- attempting verification on the wrong network explorer

## Security warnings

- **Do not** put seed phrases, private keys, or funded wallet credentials in this repository
- **Do not** approve transactions you do not understand
- **Do not** start on mainnet
- **Do not** assume a successful compile means a contract is production-safe
- **Do not** hard-code secrets into source files, GitHub Actions, or Remix

This repository does **not** perform automatic deployment, automatic signing, or automatic transaction sending.

All real deployments require **manual confirmation in MetaMask**.

## Manual steps that cannot be automated from GitHub

These steps must be completed by a human wallet owner:

1. Install and unlock MetaMask
2. Add/select the target network in MetaMask
3. Fund the wallet with testnet or mainnet gas assets
4. Connect MetaMask to Remix
5. Review and approve deployment transactions
6. Save the deployed contract address
7. Optionally verify the contract on the network explorer

## Local validation in this repository

This repository includes a GitHub Actions workflow that compiles the Solidity contract without using secrets or deployment keys.

The workflow only validates compilation; it does **not** deploy anything.

Optional local validation on Linux/Ubuntu environments only.
This helper script is not intended for macOS or Windows as written, and it requires `bash`, `curl`, GNU `sha256sum`, `mktemp`, `chmod`, and the ability to execute the Linux `solc-static-linux` compiler binary in your shell environment.

```bash
bash scripts/validate-solidity.sh
```
