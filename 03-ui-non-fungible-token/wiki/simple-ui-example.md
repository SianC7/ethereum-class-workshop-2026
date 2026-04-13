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

### Tests first

- [ ] Run tests; they should fail until `_approve` is implemented.

  ```bash
  yarn workspace @se-2/hardhat test test/YourCollectible.ts
  ```

  (Or `cd packages/hardhat && yarn test test/YourCollectible.ts`.)

### 1. Fix `_approve` in `YourCollectible.sol`

Implemented in `packages/hardhat/contracts/YourCollectible.sol` (override of OpenZeppelin’s internal `_approve`).

- [ ] **TODO:** Read the **currently approved** address for `tokenId`.  
  *Note:* You need the previous approvee to remove `tokenId` from tracking when approvals change.

- [ ] **TODO:** Call the **parent** `ERC721` `_approve` logic (OpenZeppelin’s internal implementation).

- [ ] **TODO:** If the previous approved address equals the **new** approved address, **return** early.  
  *Note:* Avoid duplicate work / redundant updates when nothing changes.

- [ ] **TODO:** Add `tokenId` to the **new** approver’s list in `_addressTokenApprovals`.  
  *Note:* Do not treat the zero address as a real approver for this bookkeeping.

- [ ] **TODO:** Remove `tokenId` from the **previous** approver’s array in `_addressTokenApprovals`.

### 2. My NFTs — approved tokens UI

File: `packages/nextjs/app/myNFTs/_components/MyHoldings.tsx`.

- [ ] **TODO:** Add state `myApprovedCollectibles` of type `Collectible[]` (or the type your file uses for holdings).

- [ ] **TODO:** Add state `approvedCollectiblesLoading` (boolean).

- [ ] **TODO:** In a `useEffect`, load **approved** tokens for the connected wallet and set `myApprovedCollectibles`.  
  *Note:* For tokens you are **approved** to move, **you are not `ownerOf`**. Set the displayed **owner** to the actual owner (read from the contract), not the connected address.

- [ ] **TODO:** Use `approvedCollectiblesLoading` in the loading UI (same pattern as other loading flags in the component).

- [ ] **TODO:** Render `myApprovedCollectibles` similarly to how **`myAllCollectibles`** (or equivalent) is shown.

### 3. Point the app at Sepolia (testnet)

- [ ] **TODO:** In `packages/nextjs/scaffold.config.ts`, switch from **`chains.hardhat`** to **`chains.sepolia`** (or the equivalent target network your template exports).  
  *Note:* This file defines which networks the frontend targets by default.

- [ ] **TODO:** Install [MetaMask](https://chromewebstore.google.com/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn) (or another compatible wallet).  
  *Security:* Store seed phrases **offline** in a safe place; never commit them or share them.

- [ ] **TODO:** In MetaMask, connect to **Sepolia** and create or select an account.

- [ ] **TODO:** Fund the account with Sepolia ETH (e.g. [Google Cloud Sepolia faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia) or another trusted faucet).  
  *Note:* Copy your account address from the wallet and paste it into the faucet.

### 4. Deploy to Sepolia

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
- Lesson setup: [setup.md](./setup.md)
