# Week 1｜测试网交易记录

> 公开链上证明；**无**私钥、助记词、API Key。

---

## 1. 测试网名称

**Ethereum Sepolia**

## 2. 测试钱包地址（EOA）

`0xDA09c7e6003A047B61DB593a189E8935c23103B8`

## 3. 交易哈希（Tx Hash）

`0xa94677ca3451aa06ac86c362c8021caec84b6cf807d1e8ea2917fe5e7b76387f`

## 4. 区块浏览器链接（完整 URL）

https://sepolia.etherscan.io/tx/0xa94677ca3451aa06ac86c362c8021caec84b6cf807d1e8ea2917fe5e7b76387f

## 5. 简要说明（3～5 句话）

1. **From** 为上述测试钱包地址，**To** 为黑洞地址 `0x000…dEaD`，在 Sepolia 上发起 **原生 ETH 转账**，金额为 **0.001 SepoliaETH**；在 MetaMask 弹窗中 **人工确认** 后交易广播。  
2. 在 **sepolia.etherscan.io** 根据交易哈希查询，状态为 **Success**。  
3. **Gas**：以浏览器页面展示的 **Gas Used**、**Gas Price / Effective Gas Price** 及 **Transaction Fee** 为准（具体数值随区块略有不同，以链上页为准）。  
4. **区块与时间**：在 Etherscan 交易详情页查看 **Block** 与 **Timestamp** 即可对应「区块高度、确认时间」。  
5. **必须人工确认的环节**：确认当前网络为 **Sepolia**、收款地址为预期黑洞地址、转账金额、以及 Gas 预览无误后再在钱包内点击确认；无他人可代为签名。

---

## 自查清单

- [x] 使用测试网专用流程，未向页面粘贴私钥/助记词  
- [x] 能在浏览器中用 Tx Hash **唯一定位**并公开查验本笔交易  
