# Lesson 03 — UI for non-fungible tokens

This directory is **lesson 3** in the workshop monorepo. It extends the NFT lesson with **ERC-721 approvals** in `YourCollectible.sol`, a **My NFTs** UI that surfaces approved tokens, and optional **Sepolia** deployment—using [Scaffold-ETH 2](https://scaffoldeth.io) (Next.js + Hardhat + wagmi).

## Start here (lesson hub)

**[→ wiki/README.md](./wiki/README.md)** is the main entry for this lesson: setup, ERC-721 approval notes, the full **TODO** checklist, and a link to the [FinHubSA Simple UI Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-UI-Example) wiki.

Supporting pages:

- [wiki/setup.md](./wiki/setup.md) — prerequisites, chain / deploy / `yarn start`, file paths  
- [wiki/simple-ui-example.md](./wiki/simple-ui-example.md) — key points and practical tasks  

---

## Acknowledgements — Scaffold-ETH 2

This lesson is built with **[Scaffold-ETH 2](https://scaffoldeth.io)** — an open-source toolkit for Ethereum dapps (smart contracts plus a Next.js frontend). The upstream project and docs are the authoritative reference for the stack.

<h4 align="center">
  <a href="https://docs.scaffoldeth.io">Documentation</a> |
  <a href="https://scaffoldeth.io">Website</a>
</h4>

🧪 Scaffold-ETH 2 makes it easier to write contracts, deploy them, and build UIs that talk to the chain.

⚙️ Built with Next.js, RainbowKit, Hardhat, Wagmi, Viem, and TypeScript.

- ✅ **Contract hot reload**: the frontend tracks contract changes as you edit.  
- 🪝 **[Custom hooks](https://docs.scaffoldeth.io/hooks/)**: React hooks around [wagmi](https://wagmi.sh/) with TypeScript-friendly contract calls.  
- 🧱 [**Components**](https://docs.scaffoldeth.io/components/): common web3 UI pieces.  
- 🔥 **Burner wallet & local faucet**: fast iteration on a local chain.  
- 🔐 **Wallet providers**: connect and switch networks from the app.

![Debug Contracts tab](https://github.com/scaffold-eth/scaffold-eth-2/assets/55535804/b237af0c-5027-4849-a5c1-2e31495cccb1)

Course context: practicals align with ideas from **[Speedrun Ethereum](https://speedrunethereum.com)** and related workshop material; the UI and approval exercise steps are in **[wiki/README.md](./wiki/README.md)**.

## Requirements

- [Node.js (>= v18.18)](https://nodejs.org/en/download/)  
- [Yarn](https://yarnpkg.com/getting-started/install) (this package uses Yarn 3; see `.yarnrc.yml`)  
- [Git](https://git-scm.com/downloads)  

## Quickstart (Scaffold-ETH 2)

From **this folder** (`03-ui-non-fungible-token/`):

1. Install dependencies:

   ```bash
   yarn install
   ```

2. Terminal 1 — local chain:

   ```bash
   yarn chain
   ```

3. Terminal 2 — deploy:

   ```bash
   yarn deploy
   ```

4. Terminal 3 — Next.js app:

   ```bash
   yarn start
   ```

Open [http://localhost:3000](http://localhost:3000). Use **Debug Contracts** and **My NFTs** as needed. Configure networks in `packages/nextjs/scaffold.config.ts`. Hardhat settings live in `packages/hardhat/hardhat.config.ts`.

Run contract tests:

```bash
yarn test
```

For this lesson’s collectible tests:

```bash
yarn workspace @se-2/hardhat test test/YourCollectible.ts
```

(or `cd packages/hardhat && yarn test test/YourCollectible.ts` — see the wiki).

**Where to edit**

- Contracts: `packages/hardhat/contracts`  
- Deploy scripts: `packages/hardhat/deploy`  
- My NFTs UI: `packages/nextjs/app/myNFTs`  
- Frontend entry / routes: `packages/nextjs/app` — [Next.js routing docs](https://nextjs.org/docs/app/building-your-application/routing/defining-routes)  

## Documentation

- **This lesson**: [wiki/README.md](./wiki/README.md)  
- **Scaffold-ETH 2**: [docs.scaffoldeth.io](https://docs.scaffoldeth.io) and [scaffoldeth.io](https://scaffoldeth.io)  

## Contributing to Scaffold-ETH 2

Scaffold-ETH 2 welcomes contributions. See the upstream [CONTRIBUTING.md](https://github.com/scaffold-eth/scaffold-eth-2/blob/main/CONTRIBUTING.md).
