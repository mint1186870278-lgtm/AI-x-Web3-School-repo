# Week 1｜AI × Web3 行业信息流关注清单

> 任务：建立 AI × Web3 高质量信息流，选择 ≥10 个账号并说明关注理由。  
> 参考来源：https://ethpanda.notion.site/364bbd63be878088bddce3a54ee15a39

---

## 关注列表（共 12 个）

### 课程 / 社区（必关注）

| 账号名称 | X Handle | 关注理由 |
|---------|---------|---------|
| AI Web3 School | @aiweb3school | 课程官方账号；任务通知、学员作品展示、活动更新的第一手来源 |
| ETHPanda | @ETHPanda_Org | 华语以太坊社区、课程联合发起方；持续追踪中文生态活动和 Ethereum 进展 |
| LXDAO | @LXDAO_Official | 研发驱动 DAO、课程联合发起方；观察开源公共物品项目和实际 builder 机会 |
| Web3 Career Build | @web3careerbuild | 课程平台官方账号；任务反馈、学习记录展示和职业路径信息 |

### AI / Agent 工具

| 账号名称 | X Handle | 关注理由 |
|---------|---------|---------|
| Z.AI / GLM | @Zai_org | 课程领衔赞助方；观察 GLM 模型能力更新、Agent 工具调用实践和 AI coding 工作流 |
| Draken | @draken_zeng | 分享会嘉宾，主题是 Agent 从 0 到 1；适合跟踪中文开发者视角的 Agent 实践路径 |

### Ethereum / Web3 基础

| 账号名称 | X Handle | 关注理由 |
|---------|---------|---------|
| Vitalik Buterin | @VitalikButerin | Ethereum 核心思想来源；观察 L2、AA、隐私、AI × Web3 的长期路线判断 |
| Bruce Xu | @brucexu_eth | ETHPanda / LXDAO 相关；课程 Web3 基础分享嘉宾，观察中文 builder 生态和公共物品方向 |

### Agent Wallet / 账户安全

| 账号名称 | X Handle | 关注理由 |
|---------|---------|---------|
| Elytro | @elytro_eth | EIP-4337 智能账户钱包，内置日消费上限和 Session Keys；直接对应 Week 1 Agent Wallet 授权边界知识点 |
| Cobo | @Cobo_Global | 课程联合赞助方；观察机构级 MPC 托管、Agent Wallet 安全边界和链上支付实践 |

### AI Security / 可信执行

| 账号名称 | X Handle | 关注理由 |
|---------|---------|---------|
| Phala Network | @PhalaNetwork | TEE（可信执行环境）方向；Week 1 遗留问题——去中心化推理怎么证明输出正确，TEE 是候选答案之一 |
| GoPlus Security | @GoPlusSecurity | AI × 安全检测；观察链上地址风险识别、合约审计和 Agent 执行前的风险过滤实践 |

---

## 为什么选这些账号

**选择逻辑**：覆盖课程生态 + AI 工具链 + Web3 基础 + Agent 安全四个方向，刻意避免只跟行情/价格类账号。

- **课程生态 4 个**：保证任务和活动信息不遗漏
- **AI/Agent 2 个**：持续跟踪工具能力更新，避免对框架的认知停留在 Week 1
- **Ethereum/Web3 2 个**：基础概念来源，长期路线判断不依赖二手解读
- **Agent Wallet/AA 2 个**：Week 1 最核心的实践交叉点，需要持续观察真实产品进展
- **安全 2 个**：Week 1 遗留的核心疑问（TEE 验证、Prompt Injection 防御）在这两个账号里最可能找到新进展

---

## 我希望观察的问题

1. **Elytro / Cobo**：MPC 托管 vs 智能账户钱包，在 Agent 场景下哪个路径更被开发者采用？
2. **Phala Network**：TEE 方案用于验证 AI 推理输出，目前有没有生产级落地案例？
3. **GoPlus**：链上 AI Agent 的交易在发出前做风险检测，这个检测的误报率有多高，会不会卡死 Agent 工作流？

---

## 内容笔记（进阶）

### 笔记 1｜@VitalikButerin｜Ethereum 路线中的 AI 角色

Vitalik 多次提到 AI 和区块链的潜在结合点不是"AI 预测价格"，而是用 ZK Proof 验证 AI 推理过程的正确性——即证明"这个输出是由某个特定模型在特定输入下产生的"，而不需要重新运行模型。

**和 Week 1 的关系**：对应我在 project-deconstruct 里留下的疑问——去中心化推理网络怎么验证输出。ZK + AI 是一个方向，但计算代价极高。

**还不理解的问题**：ZK 证明一次 LLM 推理的成本目前是多少量级？有没有实际跑通的 Demo？

---

### 笔记 2｜@PhalaNetwork｜TEE 作为 AI Agent 的可信执行环境

Phala 的核心方案是把 AI Agent 的推理放进 TEE（Intel SGX / TDX），让外部可以验证"推理发生在隔离环境中、代码未被篡改"，而不需要信任运营方。

**和 Week 1 的关系**：Inference 章节学到推理服务可以自托管；TEE 是在不信任运营方的前提下做自托管的工程路径。

**还不理解的问题**：TEE 内存大小有上限，跑大参数模型（70B+）是否可行？还是说 TEE 只适合验证小模型或推理哈希？

---

### 笔记 3｜@elytro_eth｜Session Key 让 Agent 有"有限签名权"

Elytro 的 Session Key 机制允许为某个 Agent 生成一个临时密钥，绑定：有效期（如 24h）+ 可调用合约白名单 + 金额上限。超出任一条件，Session Key 自动失效。

**和 Week 1 的关系**：这是 Agent Wallet 章节"最小授权原则"的真实产品实现——不是给 Agent 完整私钥，而是给一个受限临时凭证。

**还不理解的问题**：Session Key 能否被 Revoke？如果 Agent 被攻击在 24h 内连续发起接近上限的小额交易，有没有异常检测机制？
