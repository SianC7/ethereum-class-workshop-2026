# Setup — Lesson 03 (UI + non-fungible tokens)

This lesson is the Scaffold-ETH 2 app inside `03-ui-non-fungible-token/`. The parent repository is a **monorepo**: each top-level folder is a self-contained lesson.

## Prerequisites

- [Node.js](https://nodejs.org/en/download/) (>= 18.18)
- [Yarn](https://yarnpkg.com/getting-started/install) (Yarn 3; see `.yarnrc.yml` in the lesson folder)
- [Git](https://git-scm.com/downloads)
- A browser (for this lesson you will also use [MetaMask](https://chromewebstore.google.com/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn) and optionally Sepolia test ETH)

## 1. Open the lesson package

From the **monorepo root**:

```bash
cd 03-ui-non-fungible-token
```

## 2. Install dependencies

```bash
yarn install
```

## 3. Git workflow (optional)

If you use a fork and an `upstream` remote, keep your work on a branch as usual. The [original FinHub wiki](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example) used a branch named `simple-nft-ui-tut`. In **this** monorepo, the lesson lives in `03-ui-non-fungible-token/`; you do not need that branch name.

The wiki also suggested committing work before switching branches:

```bash
git add -A
git commit -m "Describe your changes"
```

Adapt that to your own branch strategy.

## 4. Local chain, deploy, and app

1. **Terminal 1** — start the local chain:

   ```bash
   yarn chain
   ```

2. **Terminal 2** — deploy contracts (chain must be running):

   ```bash
   yarn deploy
   ```

3. **Terminal 3** — Next.js dev server:

   ```bash
   yarn start
   ```

4. Open [http://localhost:3000](http://localhost:3000) and use **My NFTs** and **Debug Contracts** as needed.

## 5. Where the code lives

| What | Path |
|------|------|
| `YourCollectible` + `_approve` override | `packages/hardhat/contracts/YourCollectible.sol` |
| Collectible tests | `packages/hardhat/test/YourCollectible.ts` |
| My NFTs UI | `packages/nextjs/app/myNFTs/_components/MyHoldings.tsx` |
| Target network config | `packages/nextjs/scaffold.config.ts` |

See [simple-ui-example.md](./simple-ui-example.md) for ERC-721 approval concepts and the step-by-step TODO list.
