# Week 1｜课程工具准备记录

> 任务：记录完成课程所需工具的安装、配置和验证情况。  
> **无**私钥、助记词、API Key。

---

## 工具清单总表

| 类别 | 工具 | 版本 / 网络 | 状态 | 验证方式 |
|------|------|------------|------|---------|
| **AI 助手** | Cursor（内置 Claude Sonnet） | 最新桌面版 | ✅ 已配置 | 本次对话即运行中 |
| **编辑器** | Cursor IDE | 最新版 | ✅ 已使用 | 日常代码 + Agent 交互 |
| **Web3 钱包** | MetaMask（浏览器扩展） | 最新版 | ✅ 已安装 | 在 Sepolia 上发送测试 ETH |
| **测试网** | Sepolia Testnet | chainId 11155111 | ✅ 已接入 | 收到 Faucet ETH、发送 Tx 成功 |
| **合约开发** | Remix IDE（在线） | remix.ethereum.org | ✅ 已使用 | 部署 Hello.sol、读写合约 |
| **区块浏览器** | Etherscan（Sepolia） | sepolia.etherscan.io | ✅ 已使用 | 查看 Tx Hash、合约地址、Gas |
| **版本控制** | Git + GitHub | Git ≥ 2.4 | ✅ 已连接 | push 到 [AI-x-Web3-School-repo](https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo) |
| **文本编辑** | Markdown（VSCode/Cursor） | — | ✅ 日常使用 | 所有 `submissions/` 文件 |

---

## 各工具简要说明

### 1. Cursor + Claude Sonnet（AI Agent）
- 用途：生成代码、整理笔记、辅助完成课程任务、维护仓库结构
- 配置：直接使用桌面版内置模型，无需额外 API Key 配置
- Agent 配置文件：`CLAUDE.md`（记录了角色、提醒节奏、安全边界）

### 2. MetaMask
- 用途：持有测试 ETH、签名交易、与 Remix 连接部署合约
- 当前网络：Sepolia Testnet（测试用，无真实资产）
- 安全注意：助记词本地离线保存，未提交至任何代码仓库

### 3. Sepolia Testnet
- 用途：无真实资产的测试环境，用于练习转账、部署合约
- 领水途径：[Alchemy Sepolia Faucet](https://sepoliafaucet.com/) 或 [Chainlink Faucet](https://faucets.chain.link/sepolia)
- 验证：已成功发送测试 ETH，Tx 在 Etherscan 可查

### 4. Remix IDE
- 用途：在线合约编写与部署，无需本地环境
- 已用于：编写 `Hello.sol`、`Counter.sol`，在 Injected Provider 模式下通过 MetaMask 部署到 Sepolia
- 合约代码存档：`experiments/week1-minimal-contract/`

### 5. GitHub
- 仓库：[mint1186870278-lgtm/AI-x-Web3-School-repo](https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo)
- 用途：存储学习笔记、任务提交、实验代码；作为可公开验证的 proof-of-work
- 当前状态：`main` 分支，已推送所有 Week 1 提交文件

---

## 课程通讯工具

| 工具 | 用途 | 状态 |
|------|------|------|
| WCB Learning（课程平台） | 查看打卡任务、提交作业链接 | ✅ 已登录 |
| 课程社群（Telegram / 群组） | 参考同学提交、社区讨论 | — |

---

## 尚待探索（可选扩展）

| 工具 | 说明 | 优先级 |
|------|------|--------|
| Hardhat / Foundry | 本地合约开发框架，Week 2+ 可能用到 | 中 |
| The Graph | 链上数据查询，适合 AI × Web3 数据流任务 | 低 |
| OpenAI / Anthropic API | 如需调用 LLM API 构建工作流，届时配置 | 中 |

---

## 自评（提交对照）

| 要求 | 完成 |
|------|------|
| 列出所有课程相关工具 | ✅ |
| 每个工具有状态和验证方式 | ✅ |
| 无私钥/助记词/API Key | ✅ |
| 与 Learning Agent Setup 互相印证 | ✅（见 `submissions/week1-learning-agent-setup.md`） |
