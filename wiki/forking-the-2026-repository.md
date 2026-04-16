# Forking the 2026 repository

Use this guide to create your own GitHub copy of the course repository before you start making changes.

## 1) Fork on GitHub

1. Open the course repository: [FinHubSA/ethereum-class-workshop-2026](https://github.com/FinHubSA/ethereum-class-workshop-2026).
2. Click **Fork** (top-right on GitHub).
3. Choose your personal GitHub account as the destination.

## 2) Clone your fork locally

```bash
git clone https://github.com/<your-username>/ethereum-class-workshop-2026.git
cd ethereum-class-workshop-2026
```

## 3) Add the original repo as `upstream` (recommended)

This makes it easy to pull future updates from the course repository.

```bash
git remote add upstream https://github.com/FinHubSA/ethereum-class-workshop-2026.git
git remote -v
```

You should now see both:

- `origin` -> your fork
- `upstream` -> `FinHubSA/ethereum-class-workshop-2026`
