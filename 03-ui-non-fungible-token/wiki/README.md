# Lesson 03 — Wiki

## Contents

- **[Simple UI Example — key points & TODOs](./simple-ui-example.md)** — ERC-721 approvals, UI work on **My NFTs**, Sepolia, and the full checklist from the wiki.

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
cd packages/hardhat
yarn test test/YourCollectible.ts
```

Note: the tests are expected to fail at first. If you complete the TODOs in the practical correctly, the tests should pass.

## Source

Original tutorial wiki: [Simple UI Example · FinHubSA/ethereum-class-workshop-2025](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example).
