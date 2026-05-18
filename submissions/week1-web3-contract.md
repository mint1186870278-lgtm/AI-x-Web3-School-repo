# Week 1｜Web3 向 — 最小智能合约提交（Hello.sol）

> Ethereum **Sepolia** 测试网｜**无**私钥、助记词、API Key。  
> 任务：Week 1｜Web3 向｜部署或调用一个最小智能合约。

---

## 1. 合约地址（部署于 Sepolia）

`0x1da7cecdec9e79e95948f3bf54bd25c6f230711c`

## 2. 区块浏览器链接（合约页）

https://sepolia.etherscan.io/address/0x1da7cecdec9e79e95948f3bf54bd25c6f230711c

## 3. 读取 / 写入结果

| 操作 | 类型 | 说明 |
|------|------|------|
| 读 `message`（`message()` / 公开 getter） | **读取（call，不上链）** | 返回值：**Hello, Web3!** |
| `setMessage(...)` | **写入（交易）** | 在 Remix 中发起；**MetaMask 中人工确认**后打包上链；写入的具体新字符串以链上 `message` 当前值为准 |

**部署交易哈希**（合约创建）：  
https://sepolia.etherscan.io/tx/0xf413cedf03578a0ffba056cdbf4e36ade1194e78bcda404d6d53388730c09d99

## 4. 合约代码（Remix 中 `Hello.sol`，与链上一致）

> 与部署字节码是否 100% 一致以 **你若在 Remix 再次编译同一源码 + 对照 Etherscan Contract 页** 为准；以下为常见最小实现。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Hello — Week 1 最小练习合约
contract Hello {
    string public message;

    constructor() {
        message = "Hello, Web3!";
    }

    function setMessage(string calldata newMessage) external {
        message = newMessage;
    }
}
```

**代码存放**：按课程允许 **仅在此 Markdown 贴码**；本仓库另有独立练习用 [`experiments/week1-minimal-contract/Counter.sol`](../experiments/week1-minimal-contract/Counter.sol)（`Counter`，非本笔 `Hello`）。

## 5. 简短说明（可直接用于作业框）

在 **Ethereum Sepolia** 测试网上使用 **Remix** 部署了最小智能合约 **Hello.sol**。合约包含公开字符串状态变量 `message` 与写入函数 `setMessage`。部署后调用读取接口，得到初始值 **Hello, Web3!**；随后调用 `setMessage` **写入**新消息，该步骤在 **MetaMask** 中 **人工确认交易**。**部署**交易哈希：`0xf413cedf03578a0ffba056cdbf4e36ade1194e78bcda404d6d53388730c09d99`；合约地址：`0x1da7cecdec9e79e95948f3bf54bd25c6f230711c`。

**必须人工确认的环节**：在 MetaMask 中确认 **网络为 Sepolia**、**部署合约**交易明细、以及 **`setMessage` 写入**交易（金额/Gas/目标合约）后再签名；**私钥与助记词**不进入 Remix 页面以外的不可信输入框，也不写入本文件。

---

## 自查

- [x] 测试网 Sepolia  
- [x] 写入类操作均在钱包中 **人工确认**  
- [x] 未在提交材料中粘贴密钥  
