# Week 1 · Proof-of-Work Pack

> 学员：[@mint1186870278-lgtm](https://github.com/mint1186870278-lgtm)  
> 学习周期：2026-05-18 ～ 2026-05-22  
> 仓库：https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo  
> 正式提交以 WCB / 平台为准。

---

## 任务完成总览

| # | 任务 | 文件 | 分值 | 状态 |
|---|------|------|------|------|
| 1 | AI 基础概念卡片（≥6） | [ai-concept-cards.md](ai-concept-cards.md) | 20 | ✅ |
| 2 | Learning Agent Setup | [learning-agent-setup.md](learning-agent-setup.md) | 20 | ✅ |
| 3 | AI 可交互学习产物 | [interactive-artifact.md](interactive-artifact.md) | 20 | ✅ |
| 4 | AI × Web3 最小交叉流程图 | [ai-web3-cross-flow.md](ai-web3-cross-flow.md) | 20 | ✅ |
| 5 | Web3 基础概念卡片（≥8） | [web3-concept-cards.md](web3-concept-cards.md) | 20 | ✅ |
| 6 | 测试网交易记录 | [web3-testnet-tx.md](web3-testnet-tx.md) | 20 | ✅ |
| 7 | 最小合约部署 | [web3-contract.md](web3-contract.md) | 20 | ✅ |
| 8 | EOA / 智能账户 / 多签对比 | [eoa-account-compare.md](eoa-account-compare.md) | 30 | ✅ |
| 9 | 课程工具准备记录 | [tool-setup.md](tool-setup.md) | 10 | ✅ |
| 10 | 受限 Web3 助手授权规则设计 | [restricted-web3-agent.md](restricted-web3-agent.md) | 40 | ✅ |
| 11 | AI × Web3 行业观察清单 | [industry-radar.md](industry-radar.md) | 20 | ✅ |
| 12 | AI × Web3 项目拆解（AgentKit & Eliza） | [project-deconstruct.md](project-deconstruct.md) | 30 | ✅ |
| 13 | Week 1 学习总结 | [learning-summary.md](learning-summary.md) | 20 | ✅ |
| 14 | Proof-of-Work Pack 汇总 | 本文件 | 40 | ✅ |

**已完成分值合计：330 分**

---

## 核心产物说明

### 可运行产物

**AI 概念复习卡片页**（本地静态 HTML）

- 代码：[experiments/week1/interactive-concept/](../../experiments/week1/interactive-concept/)
- 功能：选概念 → 阅读复习卡 → 用自己的话复述 → 规则化反馈
- 无外部 API，无密钥，`file://` 直接打开

**Hello.sol 智能合约**（Sepolia 测试网）

- 合约地址：`0x1da7cecdec9e79e95948f3bf54bd25c6f230711c`
- 链上验证：https://sepolia.etherscan.io/address/0x1da7cecdec9e79e95948f3bf54bd25c6f230711c
- 部署交易：https://sepolia.etherscan.io/tx/0xf413cedf03578a0ffba056cdbf4e36ade1194e78bcda404d6d53388730c09d99

### 分析与设计产物

**受限 Web3 助手授权规则**：覆盖白名单/金额上限/人工确认/紧急暂停四层设计，对应 Agent Wallet 安全边界

**AI × Web3 项目拆解**：Coinbase AgentKit（MPC 托管 + Action Layer 限权）与 Eliza（Character 规则层 + Plugin 代码硬约束）横向对比

**AI × Web3 流程图**：最小交叉场景——用户意图 → LLM 推理 → Agent 调用 → 链上执行（[图片](assets/ai-web3-cross-flow.png)）

---

## Handbook 阅读进度（Week 1）

| 天 | AI 基础 | Web3 基础 | Bridge |
|----|---------|-----------|--------|
| Day 1（5/18） | LLM | 密码学/私钥/哈希 | — |
| Day 2（5/19） | Prompt · Context Window | Wallet | — |
| Day 3（5/20） | Agent · RAG | Smart Contract | Agent Workflow · Agent Wallet |
| Day 4（5/21） | Fine-tuning · Inference | Dev Stack | 链感知上下文 |
| Day 5（5/22） | Frameworks | Network | Machine Payment |

**累计：AI 基础 8 节 · Web3 基础 5 节 · Bridge 4 节**

---

## 卡点与人工修正记录

### 卡点 1：MetaMask 测试网开关位置变了

**问题**：按旧教程找"显示测试网络"的开关，在设置里找不到。  
**原因**：新版 MetaMask UI 改版，测试网开关移到了「管理网络」列表底部，旧教程截图已失效。  
**修正**：放弃截图对照，直接在当前客户端里逐级翻找，找到后手动添加 Sepolia。  
**结论**：Web3 工具迭代快，UI 和旧文档会频繁脱节，以当前客户端为准。

---

### 卡点 2：水龙头地址粘贴失败（O 与 0 混淆）

**问题**：在 PoWFaucet 粘贴钱包地址后显示无效地址。  
**原因**：手动输入时字母 O 和数字 0 混淆，导致地址校验失败。  
**修正**：改用钱包界面的一键复制按钮，不再手动输入。  
**结论**：链上地址严格区分大小写和字符，任何手动输入都应通过复制粘贴 + 目测校验避免。

---

### 人工修正记录：合约部署前的代码审查

**场景**：在 Remix 部署 Hello.sol 之前，AI 生成了合约代码。  
**人工确认步骤**：
1. 阅读合约逻辑，确认 `setMessage` 没有权限限制（任何人都可以调用）——在测试网上可接受，生产环境需加 `onlyOwner`
2. 在 MetaMask 弹窗里核对 Gas 估算和目标地址，手动点击确认
3. 部署后在 Etherscan 上核对合约地址和部署 Tx 状态

**为什么这一步必须人工**：链上部署不可撤销，合约逻辑有漏洞无法打补丁，只能重新部署。AI 生成的代码需要人工逐行确认后才能签名上链。

**链上证明**：
- 部署 Tx：https://sepolia.etherscan.io/tx/0xf413cedf03578a0ffba056cdbf4e36ade1194e78bcda404d6d53688730c09d99
- 合约地址：https://sepolia.etherscan.io/address/0x1da7cecdec9e79e95948f3bf54bd25c6f230711c

---

## 学习日志索引

| 类型 | 文件 |
|------|------|
| 每日打卡 | [daily/](../../daily/)（2026-05-17 ～ 2026-05-22） |
| 阅读笔记 | [tasks/](../../tasks/)（Day 1–5） |
| Week 1 总结 | [learning-summary.md](learning-summary.md) |
