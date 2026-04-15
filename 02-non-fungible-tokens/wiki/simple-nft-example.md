# Simple NFT Example — practical & TODOs

This page adapts the [Simple NFT Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example) wiki for this monorepo. Contracts and tests live under `02-non-fungible-tokens/packages/hardhat/`.

## ERC-721 standard

[ERC-721](https://github.com/ethereum/ercs/blob/master/ERCS/erc-721.md) is the standard interface for **non-fungible tokens (NFTs)** on Ethereum. Unlike ERC-20 tokens (which are interchangeable), each ERC-721 token has a distinct `tokenId` and can represent a unique asset.

### Most important interface methods

- `balanceOf(owner)` - returns how many NFTs an address owns.
- `ownerOf(tokenId)` - returns who currently owns a specific NFT.
- `safeTransferFrom(from, to, tokenId[, data])` - safely transfers an NFT and checks that smart-contract recipients can accept it (`onERC721Received`).
- `transferFrom(from, to, tokenId)` - transfers without the recipient safety check.
- `approve(to, tokenId)` and `getApproved(tokenId)` - grant/check permission for one NFT.
- `setApprovalForAll(operator, approved)` and `isApprovedForAll(owner, operator)` - grant/check permission for all NFTs of an owner.
- `supportsInterface(interfaceId)` (ERC-165) - lets tools detect whether the contract supports ERC-721 and optional extensions.

Common optional extensions:

- **Metadata**: `name()`, `symbol()`, `tokenURI(tokenId)`.
- **Enumerable**: `totalSupply()`, `tokenByIndex(index)`, `tokenOfOwnerByIndex(owner, index)`.

### Why this specification matters

Specifications like ERC-721 make wallets, marketplaces, and apps interoperable: if a contract follows the same interface, external tools can integrate it without custom code. This improves composability, reduces integration bugs, and gives users predictable behavior across the ecosystem.

## Simple NFT (`YourCollectible.sol`)

The contract under test is **`YourCollectible.sol`**. It implements **ERC-721** by extending OpenZeppelin’s `ERC721`, and also extends:

- **`ERC721Enumerable`** — optional in the ERC-721 standard. It lets a contract expose a discoverable list of NFTs: total supply, iteration over all token IDs, and per-owner enumeration (for example `tokenOfOwnerByIndex` for the *index*th token owned by an address).
- **`ERC721URIStorage`** — optional metadata support so each token can have a stored URI. Marketplaces and apps use this to show names, descriptions, and images for each token.

OpenSea [describes metadata](https://docs.opensea.io/docs/metadata-standards) roughly as follows: without it, an asset is often “just” a `tokenId`; with metadata, apps can pull rich fields (name, description, image). The `tokenURI` (ERC-721) or `uri` (ERC-1155) should resolve to HTTP or IPFS content—commonly JSON describing the asset.

For a practical walkthrough of how NFTs are traded on OpenSea (and related transfer/security implications), see: [How NFTs are traded on OpenSea and how hackers can transfer your NFTs](https://medium.com/coinmonks/how-nfts-are-traded-on-opensea-and-how-hackers-can-transfer-your-nfts-c491455087).

---

## Practical — checklist

Work from `02-non-fungible-tokens/`. Run tests first; they should fail until you complete the contract and test TODOs.

```bash
yarn test test/YourCollectible.ts
```

### 1. Implement `mintItem` (suite: **Mint token**)

- [ ] **TODO:** Use `_mint` to mint an NFT.  
       _Note:_ `_mint` comes from OpenZeppelin’s `ERC721` implementation.

- [ ] **TODO:** Use `_setTokenURI` to set the metadata URI for the NFT.

- [ ] **TODO:** Increment the `tokenIdCounter` (or equivalent counter your contract uses).

Run the tests again. The case **`Should not allow minting to contract address without implementing IERC721Receiver`** may still fail.

### 2. Prefer `_safeMint`

- [ ] **TODO:** Switch from `_mint` to **`_safeMint`**.  
       _Why:_ `_safeMint` checks that the recipient can handle ERC-721 tokens via `onERC721Received`. Minting to a contract that does not implement `IERC721Receiver` can **lock the NFT** in that contract with no way to transfer it out.

- [ ] Deploy and run tests:

  ```bash
  yarn deploy
  yarn workspace @se-2/hardhat test test/YourCollectible.ts
  ```

  (From `packages/hardhat`: `yarn test test/YourCollectible.ts` after deploy if you prefer.)

### 3. Fix `_approve` in `YourCollectible.sol`

Implemented in `packages/hardhat/contracts/YourCollectible.sol` (override of OpenZeppelin’s internal `_approve`).

- [ ] **TODO:** Read the **currently approved** address for `tokenId`.  
      _Note:_ You need the previous approvee to remove `tokenId` from tracking when approvals change.

- [ ] **TODO:** Call the **parent** `ERC721` `_approve` logic (OpenZeppelin’s internal implementation).

- [ ] **TODO:** If the previous approved address equals the **new** approved address, **return** early.  
      _Note:_ Avoid duplicate work / redundant updates when nothing changes.

- [ ] **TODO:** Add `tokenId` to the **new** approver’s list in `_addressTokenApprovals`.  
      _Note:_ Do not treat the zero address as a real approver for this bookkeeping.

- [ ] **TODO:** Remove `tokenId` from the **previous** approver’s array in `_addressTokenApprovals`.

---

## Reference

- Upstream wiki: [Simple NFT Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example)
- Lesson guide: [README.md](./README.md)
