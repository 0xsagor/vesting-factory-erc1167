# Vesting Factory (EIP-1167)

Managing a growing Web3 team requires a scalable way to handle token lockups. This factory allows an administrator to trigger multiple vesting schedules in a single transaction using "clones."

## How it Works
* **Logic Contract**: A single `VestingWallet` is deployed once.
* **Clones**: The factory creates "Minimal Proxies" that delegate all calls to the logic contract but maintain their own storage (beneficiary, start time, etc.).
* **Registry**: The factory maintains an on-chain list of all deployed vesting wallets for easy auditing and frontend integration.

## Advantages
* **Gas Efficiency**: Deploying a proxy costs ~60k gas compared to ~1M+ for a full contract.
* **Standardization**: Ensures every employee is under the exact same audited code.
