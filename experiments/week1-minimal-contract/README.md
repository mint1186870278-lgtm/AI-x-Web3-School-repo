# Week 1 · 最小合约 `Counter`

Solidity 源码：[Counter.sol](Counter.sol)

## 目标（对应课程任务）

- **部署**到自己的测试网 → 浏览器里看到 **合约地址**。  
- **读取**：调用 `getNumber()` 或公开变量 getter `number()`（Remix 里蓝色按钮 = 不耗 gas 的 call）。  
- **写入**：调用 `increment()`（橙色按钮 = 发交易）→ **MetaMask 人工确认** Gas、网络、合约地址。

## Remix 步骤（推荐最快）

1. 打开 [Remix IDE](https://remix.ethereum.org/)，新建文件 `Counter.sol`，粘贴本仓库同款代码。  
2. **Compiler**：选 `0.8.20`（或与 `pragma` 兼容的版本），编译通过。  
3. **Deploy**：Environment 选 **Injected Provider - MetaMask**，网络切到 **Sepolia**（或其它任务允许的测试网）。  
4. **Deploy** 按钮 → 钱包 **确认部署交易** → 复制 **合约地址**。  
5. 在 Remix 下方 **Deployed Contracts** 展开：  
   - 点 `number` 或 `getNumber` → 看到返回值 `0` 或当前累计。  
   - 点 `increment` → 钱包 **再确认一笔交易** → 再读 `number` 应 `+1`。

## 区块浏览器

- Sepolia：在对应 Etherscan 子域搜索 **合约地址** 与 **两笔交易哈希**（deploy + increment）。

## 提交指引

把结果填进 [`submissions/week1-web3-contract.md`](../../submissions/week1-web3-contract.md)。  
代码可引用：**本文件路径** 或你的 GitHub / Remix gist 链接。

## 安全

- **测试网专用钱包**；**绝不**把助记词、私钥、`.env` 提交到 GitHub 或发给 AI。  
- 主网勿用此练习流程随意交互陌生合约。
