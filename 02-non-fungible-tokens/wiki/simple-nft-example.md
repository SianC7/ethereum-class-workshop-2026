# Simple NFT Example — practical & TODOs

This page adapts the [Simple NFT Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example) wiki for this monorepo. Contracts and tests live under `02-non-fungible-tokens/packages/hardhat/`.

## Simple NFT (`YourCollectible.sol`)

The contract under test is **`YourCollectible.sol`**. It implements **ERC-721** by extending OpenZeppelin’s `ERC721`, and also extends:

- **`ERC721Enumerable`** — optional in the ERC-721 standard. It lets a contract expose a discoverable list of NFTs: total supply, iteration over all token IDs, and per-owner enumeration (for example `tokenOfOwnerByIndex` for the *index*th token owned by an address).
- **`ERC721URIStorage`** — optional metadata support so each token can have a stored URI. Marketplaces and apps use this to show names, descriptions, and images for each token.

OpenSea [describes metadata](https://docs.opensea.io/docs/metadata-standards) roughly as follows: without it, an asset is often “just” a `tokenId`; with metadata, apps can pull rich fields (name, description, image). The `tokenURI` (ERC-721) or `uri` (ERC-1155) should resolve to HTTP or IPFS content—commonly JSON describing the asset.

---

## Practical — checklist

Work from `02-non-fungible-tokens/`. Run tests first; they should fail until you complete the contract and test TODOs.

```bash
yarn workspace @se-2/hardhat test test/YourCollectible.ts
```

(Alternatively: `cd packages/hardhat` then `yarn test test/YourCollectible.ts`.)

### 1. Implement `mintItem` (suite: **Mint token**)

- [ ] **TODO:** Use `_mint` to mint an NFT.  
  *Note:* `_mint` comes from OpenZeppelin’s `ERC721` implementation.

- [ ] **TODO:** Use `_setTokenURI` to set the metadata URI for the NFT.

- [ ] **TODO:** Increment the `tokenIdCounter` (or equivalent counter your contract uses).

Run the tests again. The case **`Should not allow minting to contract address without implementing IERC721Receiver`** may still fail.

### 2. Prefer `_safeMint`

- [ ] **TODO:** Switch from `_mint` to **`_safeMint`**.  
  *Why:* `_safeMint` checks that the recipient can handle ERC-721 tokens via `onERC721Received`. Minting to a contract that does not implement `IERC721Receiver` can **lock the NFT** in that contract with no way to transfer it out.

- [ ] Deploy and run tests:

  ```bash
  yarn deploy
  yarn workspace @se-2/hardhat test test/YourCollectible.ts
  ```

  (From `packages/hardhat`: `yarn test test/YourCollectible.ts` after deploy if you prefer.)

### 3. Transfers and approvals (suite: **Transfer**)

In **`Should allow transfer from non-owner user1 after approving them`** (and related cases):

- [ ] **TODO:** Write a test that **user1 cannot** transfer the token they helped mint for **user2** without permission.  
  *Hint:* `tokenId_0` belongs to **user2**. Connect as **user1** and attempt to transfer user2’s token to user3; expect revert.

- [ ] **TODO:** As **user2**, call **`approve`** on `yourCollectible` so **user1** is allowed to move **`tokenId_0`**.  
  *Note:* `approve(to, tokenId)` lets `to` transfer that `tokenId` until it is transferred or approval is cleared. Only one approved spender per token at a time; approving the zero address clears approval.

- [ ] **TODO:** As **user1**, transfer **`tokenId_0`** from user2 to **user3** (e.g. `transferFrom` / `safeTransferFrom` as appropriate).

- [ ] **TODO:** Assert the owner of **`tokenId_0`** is **user3**.

- [ ] **TODO:** Assert **user2** owns **no** tokens (e.g. `balanceOf(user2) === 0`).

---

## Reference

- Upstream wiki: [Simple NFT Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example)
- Lesson guide: [README.md](./README.md)
