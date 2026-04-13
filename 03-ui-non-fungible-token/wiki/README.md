# Lesson 03 — Wiki

This folder holds lesson-specific notes that mirror and adapt the [Simple UI Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example) wiki from the FinHubSA `ethereum-class-workshop-2025` course.

## Contents

- **[Setup for this lesson](./setup.md)** — how to work inside this monorepo lesson folder and run chain / deploy / app.
- **[Simple UI Example — key points & TODOs](./simple-ui-example.md)** — ERC-721 approvals, UI work on **My NFTs**, Sepolia, and the full checklist from the wiki.

Scaffold-ETH hook documentation: [docs.scaffoldeth.io — Hooks](https://docs.scaffoldeth.io/hooks/).

## Quick start

From the repository root:

```bash
cd 03-ui-non-fungible-token
yarn install
```

Local development (three terminals from `03-ui-non-fungible-token`):

```bash
yarn chain
yarn deploy   # with chain running
yarn start
```

Open [http://localhost:3000](http://localhost:3000). The practical focuses on **My NFTs** (`/myNFTs`) and contract tests.

Run collectible tests:

```bash
yarn workspace @se-2/hardhat test test/YourCollectible.ts
```

If that fails in your environment:

```bash
cd packages/hardhat
yarn test test/YourCollectible.ts
```

## Source

Original tutorial wiki: [Simple UI Example · FinHubSA/ethereum-class-workshop-2025](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example).
