# Week 1｜AI × Web3 项目拆解：Coinbase AgentKit & Eliza

> 任务：拆解 1-2 个 AI × Web3 项目，分析其核心架构、技术选择和权限边界设计。  
> **无**私钥、助记词、API Key。

---

## 项目一：Coinbase AgentKit

### 一句话定位

AgentKit 是 Coinbase 出品的开源框架，让 AI Agent **直接调用链上操作**——发交易、查余额、兑换代币、部署合约——同时保留人工确认节点。

- GitHub：https://github.com/coinbase/agentkit
- 定位：AI × Web3 的"胶水层"，把 LLM 和链上工具绑在一起

---

### 核心架构拆解

```
用户/开发者
    ↓
LLM（GPT / Claude）← 提供推理能力
    ↓ Tool Call（工具调用）
AgentKit Action Layer（动作层）
    ↓ 调用具体工具
┌───────────────────────────────────┐
│  transfer()  swap()  deploy()     │  ← 链上动作工具集
│  getBalance()  readContract()     │
└───────────────────────────────────┘
    ↓ 签名请求
Wallet Provider（钱包层）
    ↓
链上执行（Base / Ethereum / Polygon…）
```

**三层设计**：
1. **LLM 层**：负责理解用户意图、规划工具调用顺序（推理）
2. **Action 层**：标准化的链上操作工具集，每个 action 有明确的入参/出参和描述，LLM 按描述选择调用哪个
3. **Wallet 层**：负责签名，可接 Coinbase CDP 托管钱包，也可接用户自己的私钥方案

---

### 技术选择分析

| 选择 | 原因 |
|------|------|
| 基于 LangChain Tool 接口 | 复用成熟的 Agent 编排生态，不重复造轮子 |
| 支持 Base 链（Coinbase 自己的 L2） | 降低 Gas 成本，加快交易速度，有利于 Agent 高频操作 |
| CDP（Coinbase Developer Platform）托管钱包 | 私钥由 MPC 托管，Agent 拿到的是"签名授权"而非原始私钥 |
| TypeScript + Python 双版本 | 覆盖前端/Node.js 和 AI/数据科学两个开发者群体 |

---

### 权限边界设计

AgentKit 的安全核心在于**Agent 拿不到私钥本身**：

- Agent 调用 `transfer()` → 生成待签名交易 → 发给 CDP 托管服务 → MPC 签名 → 广播上链
- Agent 全程只能说"我要转账"，**不能直接拿到私钥去自己签**
- 开发者可以在 Action 层设置**白名单**：只允许 Agent 调用特定合约/特定金额内的操作

**和 Day 3 Agent Wallet 的对应关系**：

| Day 3 理念 | AgentKit 实现 |
|------------|--------------|
| Agent 不直接持有私钥 | CDP MPC 托管，Agent 只有签名请求权 |
| 交易规则白名单 | Action Layer 可过滤/限制调用范围 |
| 金额上限 | 开发者在 Wallet Provider 层配置 |
| 紧急暂停 | CDP 平台层可以冻结 Agent 的签名权限 |

---

### 适用场景 & 局限

**适合**：需要 Agent 自动化链上操作的产品（DeFi 策略助手、链上交易机器人、自动 Gas 补充）

**局限**：
- 强绑定 Coinbase 生态（CDP 钱包、Base 链），迁移成本高
- 复杂跨链操作支持有限
- 对初学者来说配置链路较长（需要 CDP API Key）

---

## 项目二：Eliza（ai16z）

### 一句话定位

Eliza 是目前最活跃的开源 AI Agent 框架，支持 Twitter / Discord / Telegram / 链上多平台部署，内置 Web3 插件，让 Agent 能**感知链上数据并执行链上操作**。

- GitHub：https://github.com/elizaos/eliza（GitHub Star 1.5w+）
- 定位：通用 AI Agent 框架，Web3 是其插件生态的重要方向

---

### 核心架构拆解

```
外部平台（Twitter / Discord / Telegram / 链上事件）
    ↓ 消息输入
Client Layer（客户端层）
    ↓
Runtime Core（运行时核心）
    ├── Memory（记忆模块）← 向量数据库，存储对话历史 + 知识
    ├── Character（人设配置）← JSON 文件定义 Agent 的性格/规则
    ├── Action（动作模块）← 内置 + 自定义工具集
    └── Provider（上下文提供者）← 实时注入链上数据、时间、余额等
    ↓
LLM（OpenAI / Anthropic / 本地模型）
    ↓ 生成回复 / 动作指令
输出：回复消息 / 执行链上操作
```

**关键设计：Character 文件**

每个 Eliza Agent 的行为由一个 JSON 配置文件（character file）定义：
```json
{
  "name": "my-agent",
  "bio": "我是一个链上数据分析助手",
  "rules": ["不执行超过 0.1 ETH 的操作", "每次链上操作前必须输出确认信息"],
  "plugins": ["@eliza/plugin-evm", "@eliza/plugin-solana"]
}
```
这个 JSON 就是 Agent 的"授权边界文档"——规则在启动时写死，运行中不可被用户指令覆盖。

---

### 技术选择分析

| 选择 | 原因 |
|------|------|
| 插件架构 | 核心轻量，功能通过插件扩展；Web3 支持不强制依赖，按需安装 |
| 向量数据库做记忆（RAG） | Agent 能跨会话记住用户偏好、历史操作，实现"有记忆的助手" |
| Character JSON 定义人设和规则 | 规则声明式、可审计；开发者能清楚看到 Agent 被允许做什么 |
| 支持本地 LLM（llama.cpp）| 敏感场景可以不走 OpenAI，数据不出本地 |

---

### 权限边界设计

Eliza 的安全设计分两层：

**第一层：Character 规则层**（软约束）
- 在 character.json 里写明限制，LLM 生成回复时会遵守这些规则
- 缺点：LLM 可能被绕过（prompt injection），不能作为硬安全边界

**第二层：Plugin 代码层**（硬约束）
- EVM 插件里可以在代码层设置金额上限、合约白名单、需要二次确认的操作类型
- 代码层的限制无论 LLM 说什么都不会被绕过

**最佳实践**：两层叠加——Character 规则做第一道过滤，Plugin 代码做最终兜底。

---

### 和 AgentKit 的对比

| 维度 | Coinbase AgentKit | Eliza |
|------|-------------------|-------|
| **定位** | 专注链上操作的工具集 | 通用 Agent 框架，Web3 是其中一个插件方向 |
| **链上操作** | 深度支持，原生设计 | 通过插件支持，需要配置 |
| **记忆能力** | 无内置记忆 | 内置向量数据库，跨会话记忆 |
| **平台支持** | 主要是代码调用/API | Twitter / Discord / Telegram / Web 全覆盖 |
| **适合人群** | 要构建链上自动化工具的开发者 | 要部署社交平台 AI Agent 的开发者 |
| **Web3 绑定** | 强（Coinbase 生态） | 弱（插件可替换，多链支持） |

---

## 综合总结

| 问题 | 两个项目的共同回答 |
|------|-----------------|
| AI 怎么调用链上操作？ | 通过标准化的 Tool / Action 接口，LLM 选择调用哪个工具，工具封装了 ethers.js 等链上调用 |
| 私钥怎么保护？ | Agent 不持有原始私钥——AgentKit 用 MPC 托管，Eliza 由开发者在 Plugin 层控制签名逻辑 |
| 权限边界怎么设计？ | 代码层硬约束（金额上限/白名单）> 规则层软约束（Character 声明）> LLM 自我判断 |
| 和我学过的概念的联系 | Agent Workflow（多步骤推理执行）+ Agent Wallet（受限签名）+ Dev Stack（ethers.js + LLM SDK）都能在这两个项目里找到对应实现 |

---

## 自评（提交对照）

| 要求 | 完成 |
|------|------|
| 拆解 1-2 个 AI × Web3 项目 | ✅ Coinbase AgentKit + Eliza 各一份 |
| 说明核心架构 | ✅ 两个项目均有架构图和三层/四层分析 |
| 分析技术选择原因 | ✅ 各有技术选择表格 |
| 结合课程概念（Agent Wallet / Dev Stack 等） | ✅ 与 Day 3、Day 4 知识点对应 |
| 两项目横向对比 | ✅ 对比表格 |
| 无敏感信息 | ✅ |
