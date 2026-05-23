# Week 1｜AI × Web3 项目拆解：Coinbase AgentKit & Eliza

> 任务：拆解 1-2 个 AI × Web3 项目，训练识别真实问题、技术路径和 proof-of-work 的能力。  
> **无**私钥、助记词、API Key。

---

## 项目一：Coinbase AgentKit

### 1. 它在解决什么问题

开发者想让 AI Agent 自动执行链上操作（转账、兑换、部署合约），但面临两个障碍：

- **技术障碍**：LLM 和链上工具（ethers.js、钱包签名）之间没有标准连接方式，每个项目都要从零手写胶水代码
- **安全障碍**：Agent 要发交易就得接触私钥，但直接把私钥给 Agent 风险极高

AgentKit 的解法：提供一套标准化的链上 Action 工具集，并用 MPC 托管私钥——Agent 只能"申请签名"，拿不到私钥本身。

---

### 2. AI 部分是什么

- 用 LLM（GPT / Claude 等）作为推理核心，理解用户意图、规划工具调用顺序
- 基于 LangChain Tool 接口封装链上 Action，LLM 按工具描述自主选择调用哪个
- 多步骤 Agent Workflow：用户说"帮我把钱包里的 ETH 换成 USDC"→ LLM 拆解为：查余额 → 获取报价 → 发起 swap → 确认结果

---

### 3. Web3 部分是什么

- 链上 Action 工具集：`transfer()`、`swap()`、`deploy()`、`getBalance()`、`readContract()` 等
- Wallet Provider 层：对接 Coinbase CDP（MPC 多方计算托管钱包），私钥分片存储，Agent 无法直接接触
- 支持 Base（Coinbase 自己的 L2）、Ethereum、Polygon 等主流链
- Action 层可设白名单：只允许 Agent 调用特定合约/特定金额范围内的操作

```
LLM 推理
  ↓ Tool Call
AgentKit Action Layer（标准化工具集）
  ↓ 签名申请
CDP MPC 托管钱包（私钥不出）
  ↓
链上广播执行
```

---

### 4. 可验证材料

| 类型 | 链接 |
|------|------|
| GitHub 仓库 | https://github.com/coinbase/agentkit |
| 官方文档 | https://docs.cdp.coinbase.com/agentkit/docs/welcome |
| Coinbase 官方介绍博客 | https://www.coinbase.com/developer-platform/discover/launches/introducing-agentkit |
| 支持的 Action 列表 | https://github.com/coinbase/agentkit/tree/main/python/coinbase-agentkit/coinbase_agentkit/action_providers |

---

### 5. 我学到了什么 / 还有什么疑问

**学到的**：
- "Agent 不持有私钥"不是口号，而是可以工程化实现的——MPC 托管 + 只暴露签名接口是一种可行路径
- LangChain Tool 接口的设计很巧妙：每个工具有 name + description，LLM 读描述来决定调用哪个，这让工具集可以无限扩展而不需要重训练模型
- 框架的"局限"和"绑定"本身就是一种产品策略：深度整合 Coinbase 生态可以换来更好的开发体验，但也意味着用户粘性

**还有疑问**：
- MPC 托管钱包在极端情况下（Coinbase 宕机或被黑）用户资产怎么处理？自托管的 recovery 路径是什么？
- Agent 的 Tool Call 序列如果中途失败（比如 swap 成功但记录写入失败），怎么做状态回滚？链上已执行的操作不可逆，这个问题比 Web2 里难得多。

---

## 项目二：Eliza（ElizaOS / ai16z）

### 1. 它在解决什么问题

社区想让 AI Agent 在 Twitter、Discord、Telegram 等社交平台上"活着"——能回帖、能发布内容、能查链上数据、能执行简单的链上操作。

但现有的 Agent 框架（LangChain 等）主要面向开发者 API 调用，不擅长：
- 多平台同时部署
- 保持跨会话的"记忆"和"人格一致性"
- 让非开发者也能快速配置一个 Agent 的行为规则

Eliza 的解法：用一个声明式的 JSON 配置文件（Character File）定义 Agent 的性格、规则和权限，插件化接入各个平台和链上工具。

---

### 2. AI 部分是什么

- 支持多种 LLM 后端：OpenAI、Anthropic、本地模型（llama.cpp / Ollama）
- **Memory 模块**：用向量数据库（RAG）存储对话历史和知识文档，Agent 能跨会话记住用户信息
- **Character File**：JSON 配置定义 Agent 的 bio、风格、规则、禁止行为——这份文件本质上是一个结构化的 System Prompt 加权限边界声明
- **Provider 层**：在每次 LLM 调用前实时注入上下文（当前时间、钱包余额、链上最新数据），让 Agent 始终有最新状态

---

### 3. Web3 部分是什么

- 插件化支持多链：`@eliza/plugin-evm`（以太坊系）、`@eliza/plugin-solana`、`@eliza/plugin-sui` 等
- EVM 插件能力：查余额、发交易、调用合约、监听链上事件
- Character File 里可以直接声明 Web3 规则：

```json
{
  "name": "my-agent",
  "plugins": ["@elizaos/plugin-evm"],
  "settings": {
    "chains": { "evm": ["base", "ethereum"] }
  }
}
```

- 权限双层设计：Character 规则（软约束，LLM 层）+ Plugin 代码白名单（硬约束，代码层）

---

### 4. 可验证材料

| 类型 | 链接 |
|------|------|
| GitHub 仓库 | https://github.com/elizaos/eliza |
| 官方文档 | https://eliza.how/docs/intro |
| EVM 插件文档 | https://eliza.how/docs/plugins/evm-plugin |
| Character File 示例 | https://github.com/elizaos/eliza/tree/develop/characters |
| ai16z 介绍文章（Coindesk） | https://www.coindesk.com/tech/2024/11/27/ai-agents-are-changing-crypto-meet-the-new-players |

---

### 5. 我学到了什么 / 还有什么疑问

**学到的**：
- "Character File 即授权边界文档"这个设计思路很有启发：把 Agent 的行为规则做成可审计的静态文件，任何人都能读懂这个 Agent"被允许做什么"——这和智能合约"代码即规则"的理念是同构的
- 软约束（LLM 规则）和硬约束（代码白名单）要叠加用，不能只依赖 LLM 遵纪守法——因为 LLM 可以被 prompt injection 攻击绕过
- Eliza 的爆火说明"社交 Agent"是一个真实需求：有大量人愿意用自然语言配置一个"链上机器人"替自己刷社交媒体和做简单链上操作

**还有疑问**：
- Memory 模块里存了用户的对话历史和链上操作记录，这些数据的隐私边界在哪？谁能访问这个向量数据库？
- Character File 的软约束能被有经验的用户通过精心设计的 prompt 绕过，Eliza 社区有没有针对 prompt injection 攻击的防御方案？

---

## 两个项目的横向对比

| 维度 | Coinbase AgentKit | Eliza |
|------|-------------------|-------|
| 核心问题 | Agent 如何安全调用链上操作 | Agent 如何在社交平台上活着并感知链上状态 |
| AI 架构 | LLM + Tool Call，无内置记忆 | LLM + RAG 记忆 + Character 人设 |
| Web3 接入 | 原生深度支持，MPC 托管钱包 | 插件化，支持多链，钱包由开发者自管 |
| 权限设计 | MPC 隔离私钥 + Action 白名单 | Character 软约束 + Plugin 代码硬约束 |
| 适合场景 | 链上自动化工具、DeFi 策略机器人 | 社交 Agent、社区机器人、链上数据播报 |
| 生态绑定 | 强（Coinbase / Base） | 弱（插件可替换，多链） |

---

## 来源汇总

- Coinbase AgentKit GitHub：https://github.com/coinbase/agentkit
- Coinbase AgentKit 文档：https://docs.cdp.coinbase.com/agentkit/docs/welcome
- Eliza GitHub：https://github.com/elizaos/eliza
- Eliza 文档：https://eliza.how/docs/intro
- AI × Web3 Handbook（Agent Wallet 章节）：https://aiweb3.school/zh/handbook/
