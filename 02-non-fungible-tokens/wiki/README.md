# Lesson 02 — Wiki

This folder holds lesson-specific notes that mirror and adapt the [Simple NFT Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example) wiki from the FinHubSA `ethereum-class-workshop-2025` course.

## Contents

- **[Setup for this lesson](./setup.md)** — how to work inside this monorepo lesson folder.
- **[Simple NFT Example — practical & TODOs](./simple-nft-example.md)** — ERC-721 context, extensions, and the full checklist of tasks from the wiki.

## Quick start

From the repository root:

```bash
cd 02-non-fungible-tokens
yarn install
```

Run the collectible tests. From `02-non-fungible-tokens`:

```bash
yarn workspace @se-2/hardhat test test/YourCollectible.ts
```

If that fails in your environment, run Hardhat in the hardhat package:

```bash
cd packages/hardhat
yarn test test/YourCollectible.ts
```

Or run all Hardhat tests from `02-non-fungible-tokens`:

```bash
yarn test
```

## Source

Original tutorial wiki: [Simple NFT Example · FinHubSA/ethereum-class-workshop-2025](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example).
