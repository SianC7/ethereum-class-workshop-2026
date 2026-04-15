# Simple UI Example — key points & TODOs

This page adapts the [Simple UI Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example) wiki for this monorepo. Work under `03-ui-non-fungible-token/`.

**Scaffold-ETH hooks:** [docs.scaffoldeth.io — Hooks](https://docs.scaffoldeth.io/hooks/).

## What this lesson adds

You extend the app so users can **approve** an NFT for another address. On ERC-721, `approve` lets the token owner grant a **single address** permission to transfer **one** `tokenId`. That pattern shows up in marketplaces and escrow: the marketplace is not the owner but must be allowed to move the NFT when a sale settles.

## Key points — ERC-721 approvals

1. **Per-token approval (`approve`)**
   - Grants one address the right to transfer **that** token.
   - Replaces any previous approval for the same `tokenId`.
   - Only **one** approved spender per token at a time.

2. **Operator approval (`setApprovalForAll`)**
   - Grants an operator the right to transfer **all** of the owner’s tokens from this contract.
   - Common for marketplaces; can be revoked.
   - Multiple operators can be allowed (each is a separate `setApprovalForAll`).

3. **Approvals can change**
   - `approve(newAddress, tokenId)` overwrites the previous approvee for that token.
   - `approve(address(0), tokenId)` clears approval for that token.
   - `setApprovalForAll(operator, false)` revokes that operator.

4. **Approved addresses may transfer**
   - Whoever holds the approval can call `transferFrom` / `safeTransferFrom` according to ERC-721 rules.

---

## Practical — checklist

### 1. Point the app at Sepolia (testnet)

- [ ] **TODO:** In `packages/nextjs/scaffold.config.ts`, switch from **`chains.hardhat`** to **`chains.sepolia`** (or the equivalent target network your template exports).  
      _Note:_ This file defines which networks the frontend targets by default.

- [ ] **TODO:** Install [MetaMask](https://chromewebstore.google.com/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn) (or another compatible wallet).  
      _Security:_ Store seed phrases **offline** in a safe place; never commit them or share them.

- [ ] **TODO:** In MetaMask, connect to **Sepolia** and create or select an account.

- [ ] **TODO:** Fund the account with Sepolia ETH (e.g. [Google Cloud Sepolia faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia) or another trusted faucet).  
      _Note:_ Copy your account address from the wallet and paste it into the faucet.

### 2. Deploy to Sepolia

- [ ] **TODO:** Export or copy the **private key** for the funded test account (testnet only; never reuse mainnet keys).

- [ ] **TODO:** Run `yarn account:import` from `03-ui-non-fungible-token` and paste the key when prompted (follow any local password / keystore prompts your script uses).

- [ ] **TODO:** Deploy to Sepolia, for example:

  ```bash
  yarn deploy --network sepolia
  ```

  Ensure `hardhat.config.ts` defines `sepolia` and that you have a valid RPC URL / API key in environment variables as required by this repo.

---

## Reference

- Upstream wiki: [Simple UI Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example)
- Lesson guide: [README.md](./README.md)
