# Decentralized Last Will & Testament on Blockchain

## 🔖 Overview

**WillChain** is a decentralized smart contract system that allows users to create, manage, and execute **last wills and testaments** securely on the blockchain. It ensures that a person's assets are distributed to their chosen beneficiaries only upon their confirmed death, removing the need for legal intermediaries or manual execution.

Built using **Solidity**, **Ethereum-compatible EVM**, and deployed on **CORE Testnet**, WillChain leverages blockchain transparency and automation to revolutionize estate planning.

---

## ✨ Features

- 🔐 **Owner-Based Inheritance Setup**  
  Only the contract owner can define and update beneficiaries and inheritance amounts.

- 🧑‍⚖️ **Executor (Oracle) Authorization**  
  A designated **executor** (can be an oracle, family lawyer, or DAO) confirms the death of the testator to trigger distribution.

- 🧾 **Immutable Beneficiary List**  
  All inheritance allocations are transparent and stored on-chain.

- ⚰️ **Post-Death Auto Distribution**  
  ETH is automatically distributed to all beneficiaries once the executor confirms the death.

- 🚨 **Emergency Withdraw Option**  
  Owners can withdraw funds if they’re still alive and need to recover their assets.

- 🧪 **Testnet Deployment**  
  Currently deployed on the [CORE Testnet](https://scan.test2.btcs.network/), providing transparency and immutability.

---

## 🧠 Why WillChain?

Traditional wills:
- Are centralized and require lawyers, courts, and trust institutions.
- Are expensive, slow to execute, and vulnerable to disputes or fraud.

**WillChain** solves these issues with:
- ⚙️ Automation via Smart Contracts
- 💵 Instant distribution of funds
- 🌍 Global accessibility & transparency
- 🧾 Verifiable on-chain records

---

## 🚀 How It Works

1. **Owner Deploys the Contract**
   - Sets the executor address (e.g. trusted family member or DAO).
   - Adds beneficiaries and ETH amounts.
2. **Executor Confirms Death**
   - Calls `confirmDeath()` when the owner's death is confirmed.
3. **Smart Contract Distributes ETH**
   - Automatically sends predefined amounts to each beneficiary.

---

## 💻 Technologies

- **Solidity** – Smart contract logic.
- **Remix IDE** – Development and testing.
- **CORE Testnet** – Deployment and transaction verification.
- **Metamask** – Wallet for deploying and interacting.

---

## 🧪 Example Transaction

- **Contract Creation Hash**: `0xdd672d4cf6d9fe81ebf8df557a23cf11b4628a4b8b7577faf1c7a0480a25108`
- **Contract Address** : `0xad9150a4721b3acade4ecc973c67d8f52c448980`
- **Network**: [CORE Testnet](https://scan.test2.btcs.network/tx/0xdd672d4cf6d9fe81ebf8df557a23cf11b4628a4b8b7577faf1c7a0480a25108)

---

## 🔧 Smart Contract Example =>

```solidity
function confirmDeath() external onlyExecutor {
    isDeceased = true;
    emit DeathConfirmed();
    distributeFunds();
}
