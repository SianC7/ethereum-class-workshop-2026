# Simple Staking Example — practical & TODOs

This page adapts the [Simple Staking Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-Staking-Example) wiki for this monorepo. The smart contracts and tests live under `01-basic-concepts/packages/hardhat/`.

## Test driven development (TDD)

Scaffold-ETH uses **Chai** for assertions inside **Mocha** test suites. TDD means you write (or run) tests first, then implement code until they pass, and refactor as needed.

### Mocha

Mocha structures tests with **`describe`** (suites) and **`it`** (individual cases). Suites group related behaviour; each `it` describes one expected behaviour that either passes or fails.

### Chai

Assertions compare actual values to expectations. Example:

```ts
expect(exampleArray).to.have.lengthOf(3);
```

Every assertion in a test case must succeed for that case to pass.

## Simple staking contract

`StakingContract.sol` is a small contract where users add ETH to a staking pool. Contributions are stored on-chain; users can withdraw at any time. A user may **join only once** until they withdraw—after withdrawal they can join again.

Tests are in `packages/hardhat/test/StakingContract.ts`.

---

## Practical — checklist

Work from `01-basic-concepts/`. Run the staking tests first; they should fail until you complete the TODOs.

```bash
yarn workspace @se-2/hardhat test test/StakingContract.ts
```

(Alternatively: `cd packages/hardhat` then `yarn test test/StakingContract.ts`.)

### 1. `addUser` (suite: **Add users**)

- [ ] **TODO:** Make sure the function can receive ether.  
  *Hint:* Only functions with `payable` in their signature can receive ether.

- [ ] **TODO:** Use `require` to check that the user sent ether in the calling transaction.  
  *Hint:* `msg.value` is the transaction value in wei.

- [ ] **TODO:** Use `require` to check whether the user already exists.  
  *Hint:* Use the `exists` field in the `User` struct.

- [ ] **TODO:** Use `require` to check that user count is less than `MAX_PEOPLE`.  
  *Hint:* Use Solidity’s `string.concat` and OpenZeppelin’s `Strings.toString` for the revert message.

- [ ] **Question:** Why put the `require` checks at the top of the function?

- [ ] **TODO:** Create the user object in memory.  
  *Hint:* Use the `User` struct to see which fields to set.

- [ ] **TODO:** Store the user in the `users` mapping and in the `userAddresses` array.

- [ ] **TODO:** Emit the `UserAdded` event.

### 2. `withdraw` (suite: **Withdrawals**)

- [ ] **TODO:** Read the amount to withdraw.  
  *Note:* How can you save gas when reading `User` fields?

- [ ] **TODO:** Use `require` to ensure the user has something to withdraw.

- [ ] **TODO:** Use the `call` pattern on an address to send ETH to the user.  
  *Note:* For an EOA, `call` transfers ETH. For a contract, it invokes `fallback` / `receive`, which should be `payable` if they should accept ETH.

- [ ] **TODO:** Use `require` to check that the transfer succeeded.

<img width="951" height="822" alt="image" src="https://github.com/user-attachments/assets/918933a9-4a31-49a7-a12d-9aafa58be0f6" />

### 3. `_delete` (suite: **Withdrawals**)

- [ ] **TODO:** Load the user struct into memory.

- [ ] **TODO:** Remove the user from the `users` mapping.

- [ ] **TODO:** Remove the user from `userAddresses` efficiently.  
  *Hint:* Take the address at the last index of `userAddresses`, and the corresponding last user. Move that address into the slot of the user being removed, update that user’s index, then `pop()` the array.

- [ ] **TODO:** Use `pop()` to remove the last element of `userAddresses`.

### 4. Re-entrancy exercise

<img width="668" height="427" alt="image" src="https://github.com/user-attachments/assets/bb139b3b-ce89-4b6d-8017-fae5f2728154" />

A **re-entrancy** attack happens when external code calls back into your contract before the first call finishes, often draining funds because balances were not updated before the external call.

- [ ] **TODO:** Remove the `lock` modifier from `withdraw`.

- [ ] **TODO:** In `AttackerContract.sol`, in `receive`, add logic that recursively calls `withdraw` on the victim contract.  
  *Hint:* The victim must still hold enough ETH for each withdrawal, or the call will revert.

- [ ] **TODO:** Uncomment the test **“Should allow a re-entry attack”** and comment out **“Should not allow a re-entry attack”**.

- [ ] **TODO:** Run the tests; with the vulnerable setup, they should all pass (demonstrating the attack path). In production code you would keep checks-effects-interactions ordering and/or re-entrancy guards instead.

---

## Reference

- Upstream wiki: [Simple Staking Example](https://github.com/FinHubSA/ethereum-class-workshop-2025/wiki/Simple-Staking-Example)
- Lesson setup: [setup.md](./setup.md)
