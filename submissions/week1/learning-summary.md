# Week 1｜AI × Web3 学习总结

> 学习周期：2026-05-18 ～ 2026-05-22（Day 1–5）  
> 方向：开发者 · 前端可交付 Demo · AI × Web3 交叉探索  
> 无私钥、助记词、API Key。

---

## 这一周我学了什么

### AI 基础线（7 节）

| 节次 | 概念 | 最关键的一句话 |
|------|------|--------------|
| 01 | LLM | 输出概率上合理的内容，不是事实；能帮推理，不能替你验证 |
| 02 | Prompt | 角色+任务+约束+示例的组合；清晰度决定输出质量 |
| 03 | Context Window | 模型每次只能看到有限范围，超出即忘；Agent 需要外部记忆跨会话 |
| 04 | RAG | 先检索再生成；给 LLM 接上实时/私有知识库，解决训练截止问题 |
| 05 | Agent | 感知→推理→行动的循环系统；能力越大，人工确认节点越重要 |
| 10 | Fine-tuning | 在预训练底座上用专项数据继续优化；改行为用微调，补知识用 RAG |
| 11 | Inference | 模型跑起来服务用户的过程；延迟/吞吐/成本是核心指标 |
| 06 | Frameworks | 工程组织工具；先画工作流再选框架；AI 管 prompt/state，Web3 管签名/权限 |

### Web3 基础线（5 节）

| 节次 | 概念 | 最关键的一句话 |
|------|------|--------------|
| 12 | 密码学/私钥/哈希 | 私钥就是控制权本身；哈希是单向承诺；签名是对内容的授权证明 |
| 13 | Wallet | 私钥管理器，不是存钱的地方；助记词泄露=完全失控 |
| 14 | Smart Contract | 链上自执行代码，不可改、不可停；漏洞是永久风险 |
| 15 | Dev Stack | ethers.js + LLM SDK 是 AI × Web3 最小交叉组合 |
| 16 | Network | 区块链按区块推进状态；L2 继承 L1 安全但更便宜；操作必须明确 chain id |

### Bridge 线（4 节）

| 节次 | 概念 | 最关键的一句话 |
|------|------|--------------|
| 24 | Agent Workflow | 多步骤循环推理-执行；每步可审计，可插入人工检查点 |
| 25 | Agent Wallet | 安全核心是授权边界，不是技术加密；Agent 只能做明确被允许的事 |
| 22 | 链感知上下文 | 链上 Agent 的输入基础；链上事实必须由工具读取，模型负责解释 |
| 26 | Machine Payment | Agent 支付必须有预算边界+quote+receipt；把付款意图和结算拆开 |

---

## 我做了什么

| 产物 | 类型 | 说明 |
|------|------|------|
| [AI 概念复习卡片页](interactive-artifact.md) | 前端实验 | 本地静态 HTML，选概念→阅读→用自己的话复述→规则反馈 |
| [Hello.sol 合约部署](web3-contract.md) | 链上操作 | Sepolia 测试网，Remix + MetaMask 人工确认，完整交易哈希 |
| [AI × Web3 流程图](ai-web3-cross-flow.md) | 可视化 | 最小交叉场景：用户意图→LLM推理→Agent调用→链上执行 |
| [受限 Web3 助手设计](restricted-web3-agent.md) | 系统设计 | 授权规则：白名单、金额上限、人工确认节点、紧急暂停 |
| [AgentKit & Eliza 项目拆解](project-deconstruct.md) | 分析 | 架构、技术选型、权限边界对比；对应到课程 Agent Wallet / Dev Stack 知识点 |
| [行业观察清单](industry-radar.md) | 持续更新 | AI × Web3 实际落地项目追踪（Bittensor、EigenLayer、Coinbase x402 等） |

---

## 最重要的三个认知转变

**1. AI 不等于"更聪明的搜索"**

开始之前我以为 AI 就是问答工具。学完 Agent + RAG + Fine-tuning 之后，我理解了 AI 系统的三层分工：模型负责推理、RAG 负责知识检索、Fine-tuning 改变行为。三者解决不同问题，可以叠加，但不互相替代。

**2. 区块链不等于"记账本"**

学完 Smart Contract + Network + Agent Wallet 之后，我真正理解了"代码即规则"的含义——合约一旦部署，任何人都无法单方面更改，这既是它的价值（可信执行），也是它的风险（漏洞永久存在）。

**3. AI × Web3 的真实交叉点不是"AI 炒币"**

这周最大的认知更新是：AI × Web3 的核心不是用 AI 预测价格，而是用 AI 扩展 Web3 的可用性——让普通人能通过自然语言操作链上资产，同时通过权限边界设计保证安全。AgentKit 的 MPC 托管、Eliza 的 Plugin 代码层硬约束，都是在解决这个问题。

---

## 卡过的点

- **Dev Stack 和 Bridge 的边界**：一开始把 Dev Stack（Web3 工具链）误归为 Bridge 章节，后来纠正——Dev Stack 是 Web3 基础，Bridge 是两侧能力的交叉应用
- **链感知上下文的必要性**：一开始觉得"告诉 Agent 在哪条链就够了"，读完之后才理解为什么每条链上事实都要附 chain id + block number + citation——因为状态随每个区块变化
- **Framework 不是越多越好**：LangChain 很流行，但"先引入框架再让产品逻辑迁就框架"是常见失败路径，正确顺序是先画工作流，再决定是否需要框架

---

## 下一步（Week 2 方向）

- 深入 Bridge 线：Web3 Tool Use、Settlement & Escrow、Agent Identity
- 开始一个最小的前端 Demo：ethers.js 读链上数据 + LLM 解释展示
- 关注 x402 / MPP 在真实项目里的落地（Coinbase 已有实现）

---

## 自评（提交对照）

| 要求 | 完成 |
|------|------|
| 覆盖 Week 1 所有主要知识点 | ✅ AI × Web3 × Bridge 三线均有总结 |
| 有具体产物说明 | ✅ 6 个产物附链接 |
| 有个人反思与认知转变 | ✅ 三条认知转变 + 卡点记录 |
| 无敏感信息 | ✅ |
