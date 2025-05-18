# 🛠️ Upgradeable Smart Contract - EIP-1967 Proxy Pattern

## 🎯 Objective
This project is a simple implementation of the **EIP-1967** proxy standard, one of the most popular ways to upgrade smart contracts on Ethereum. The idea is simple: deploy a proxy that forwards calls to a separate logic contract. If the logic changes, the proxy can point to a new one!

---

## 📦 What Is a Proxy Contract?

A **proxy** contract acts like a middleman. When you call it, it **forwards your call** to another contract (called the **logic contract**). The logic contract contains the real code.

✨ Benefits:
- You can **upgrade your logic** without changing the proxy address.
- Users always interact with the same contract (the proxy), even after upgrades.

---

## 🧠 What Is EIP-1967?

EIP-1967 defines a **standard storage slot** (a specific variable location) for storing the address of the logic contract (called the “implementation”).

Why? So it doesn’t interfere with variables in the logic contract.

📌 Storage slot used:  
`bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)`

---

## 🧩 Components

- **Proxy Contract**: Delegates all calls to a logic contract using `delegatecall`.
- **Logic Contract (Implementation)**: Contains actual functions and logic.
- **Admin Functionality**: Only the owner can upgrade the implementation address.

---

## 🧪 How It Works (Simple Flow)

1. You call the proxy.
2. The proxy forwards the call to the logic contract.
3. The logic runs **as if it’s the proxy**.
4. When you want to upgrade, you call a function to change the logic address.

---

## 👨‍💻 Code Structure

- `SimpleLogic.sol`: Our first logic version (e.g., counter).
- `Proxy.sol`: The proxy contract using EIP-1967 standard.
- `UpgradedLogic.sol`: A second version to simulate upgrades.

---

## 🔐 Security Notes

- Only the **admin/owner** should be allowed to upgrade the contract.
- Keep your logic and proxy contracts **separate**.
- Use OpenZeppelin’s contracts for production!

---

## 📚 Resources

- [EIP-1967 Explained](https://eips.ethereum.org/EIPS/eip-1967)
- [Solidity Docs](https://docs.soliditylang.org/en/v0.8.19/)

---

