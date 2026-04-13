# Setup — Lesson 02 (Non-fungible tokens)

This lesson is the Scaffold-ETH 2 app inside `02-non-fungible-tokens/`. The parent repository is a **monorepo**: each top-level folder is a self-contained lesson.

## Prerequisites

- [Node.js](https://nodejs.org/en/download/) (>= 18.18)
- [Yarn](https://yarnpkg.com/getting-started/install) (this project uses Yarn 3; see `.yarnrc.yml` in the lesson folder)
- [Git](https://git-scm.com/downloads)

## 1. Open the lesson package

From the **monorepo root**:

```bash
cd 02-non-fungible-tokens
```

The commands below assume your current working directory is `02-non-fungible-tokens/` unless noted.

## 2. Install dependencies

```bash
yarn install
```

## 3. Git remotes (optional, if you fork the monorepo)

If you maintain your own fork and pull updates from the course repository:

```bash
git remote -v
```

Point `origin` at your fork, and add the course repo as `upstream` if you need to fetch upstream changes. Do not force-push to `upstream` unless you own it.

### Note on branches vs. this layout

The [original FinHub wiki](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-NFT-Example) used a branch named `simple-nft-tut`. In **this** monorepo, the same practical lives in `02-non-fungible-tokens/`; use your normal branch workflow from here instead of checking out `simple-nft-tut`.

## 4. Daily development (optional)

Typical Scaffold-ETH 2 flow from `02-non-fungible-tokens/`:

1. Terminal 1 — local chain:

   ```bash
   yarn chain
   ```

2. Terminal 2 — deploy:

   ```bash
   yarn deploy
   ```

3. Terminal 3 — Next.js app:

   ```bash
   yarn start
   ```

Open [http://localhost:3000](http://localhost:3000) and use **Debug Contracts** to interact with deployed contracts.

For **this practical**, tests are enough to start:

```bash
yarn workspace @se-2/hardhat test test/YourCollectible.ts
```

Equivalent:

```bash
cd packages/hardhat
yarn test test/YourCollectible.ts
```

## 5. Where the code lives

| What | Path |
|------|------|
| NFT contract | `packages/hardhat/contracts/YourCollectible.sol` |
| Tests | `packages/hardhat/test/YourCollectible.ts` |
| Deploy script | `packages/hardhat/deploy/01_deploy_your_collectible.ts` |

See [simple-nft-example.md](./simple-nft-example.md) for the step-by-step TODO list.
