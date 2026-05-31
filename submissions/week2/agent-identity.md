# Week 2 Task D｜Agent Identity｜Agent Profile 与能力声明草图

> 课程：AI × Web3 School｜Week 2 Task D  
> 完成日期：2026-05-31  
> 主方向：Payment / Commerce / Settlement  
> 关联阅读：[Agent Identity](https://aiweb3.school/zh/handbook/bridge/agent-identity/)（Bridge 模块 28）

---

## 一、问题定义：Agent 如何被可验证地识别？

AI Agent 在无信任环境中向 x402 服务方付款、向 Escrow 合约锁定资金时，服务方和其他 Agent 需要回答：

> **「这个 Agent 是谁授权的？它能做什么？我凭什么相信它？」**

普通 EOA 身份模型（地址 + 签名）不够用——Agent 还需要**能力声明、权限范围、行为记录**。

> 身份不是「我说我是谁」，而是「我能证明我能做什么」。

---

## 二、Agent 身份 vs 普通用户身份

| 维度 | EOA（普通用户） | Agent Identity |
|------|----------------|----------------|
| 控制者 | 人类持有私钥 | 程序 / 人类共同控制 |
| 身份内容 | 地址 + 签名 | 地址 + 能力声明 + 所有者 + 权限范围 |
| 信任来源 | 私钥签名 | 链上 DID / ERC-8004 声明 |
| 可审计性 | 交易历史 | 交易 + 行为记录 + 声誉 |

---

## 三、Agent Profile 结构（草图）

基于 Handbook 模块 28 与 ERC-8004 草案方向，Week 2 Payment 场景下的 Agent Profile 应包含：

```json
{
  "profileVersion": "1.0",
  "agentId": "did:ethr:8453:0xConsumerAgent...",
  "owner": {
    "type": "human",
    "address": "0xUserOwner...",
    "contact": "owner@example.com"
  },
  "capabilities": [
    {
      "name": "x402-payment",
      "description": "Parse 402 responses and initiate USDC payments on Base",
      "standards": ["x402-v2", "eip-3009"]
    },
    {
      "name": "escrow-interaction",
      "description": "Lock and release funds via Escrow contract",
      "contracts": ["0xEscrow..."]
    }
  ],
  "scope": {
    "networks": ["eip155:8453", "eip155:84532"],
    "tokens": ["0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913"],
    "maxSinglePayment": "100000000",
    "maxDailySpend": "500000000",
    "serviceWhitelist": ["https://api.inference.example.com"]
  },
  "sessionKey": {
    "address": "0xSessionKey...",
    "validUntil": "2026-06-01T00:00:00Z",
    "revocable": true
  },
  "reputation": {
    "completedPayments": 47,
    "disputeRate": 0.02,
    "lastActiveBlock": 12345678
  }
}
```

| 字段 | 含义 | 验证方式 |
|------|------|----------|
| **Owner** | 谁授权了这个 Agent | Owner 地址签名 Profile |
| **Capabilities** | 能做什么、遵循什么标准 | 链上注册 + 标准引用 |
| **Scope** | 资产上限、网络、服务白名单 | Session Key / Pact 策略对齐 |
| **Session Key** | 临时授权密钥 | 链上 `revokeSessionKey()` 可撤销 |
| **Reputation** | 历史行为可验证记录 | 链上 tx 索引 + 争议率 |

---

## 四、在 Payment 闭环中的位置

```
人类用户（Owner）
    │ 授权 + 设定预算
    ▼
Agent Profile（链上 / IPFS 注册）
    │ 能力声明 + Scope
    ▼
消费方 Agent ──► x402 服务方
    │              │
    │ 携带 Profile  │ 验证：Agent 是否有权付款？
    │  + tx 签名     │ 验证：金额是否在 Scope 内？
    ▼              ▼
链上 Escrow / USDC 转账
    │
    ▼
声誉更新（completedPayments++, lastActiveBlock）
```

**服务方验证 checklist**：
1. Profile 中 Owner 签名有效
2. Session Key 未过期、未被 revoke
3. 支付金额 ≤ `maxSinglePayment`，日累计 ≤ `maxDailySpend`
4. 服务 URL 在 `serviceWhitelist` 内（或首次需 Owner 确认）
5. 可选：声誉 `disputeRate` 低于阈值

---

## 五、相关标准

| 标准 | 状态 | 在本场景的作用 |
|------|------|---------------|
| **W3C DID** | 成熟 | 去中心化身份标识，链上可解析 |
| **ERC-8004** | 草案 | Agent Profile 注册标准，专为 AI Agent 设计 |
| **Session Key** | ERC-4337 生态实践 | 临时授权，限额度 / 时间 / 目标 |
| **EIP-3009** | 已部署（USDC） | x402 支付授权签名 |

与 Week 1 [`eoa-account-compare.md`](../week1/eoa-account-compare.md) 对照：EOA 适合人类直接操作；Agent 自动化应走 **智能账户 + Session Key + Profile 声明**。

---

## 六、AI 边界

| AI 能做 | AI 不能做 |
|---------|-----------|
| 解析对方 Profile、评估 Scope 是否匹配任务 | 自行注册或伪造 Owner 签名 |
| 向服务方展示自身 Profile 摘要 | 修改链上声誉记录 |
| 建议「该 Agent 历史 dispute 率偏高，建议人工确认」 | 替 Owner 授权新 Agent |

---

## 七、与仓库其他文件的交叉引用

| 文件 | 关联点 |
|------|--------|
| `submissions/week2/payment-flow.md` | Agent 不能自行证明身份，需 DID + 签名 |
| `submissions/week2/x402-caw-design.md` | Pact 任务授权与 Profile Scope 对齐 |
| `submissions/week2/wallet-permission.md` | Session Key 约束落实 Scope 字段 |
| `submissions/week1/restricted-web3-agent.md` | Session Key + 白名单实例 |
| `tasks/2026-05-26-day7.md` | Agent Identity 阅读笔记 |

---

*AI × Web3 School · Week 2 Task D*
