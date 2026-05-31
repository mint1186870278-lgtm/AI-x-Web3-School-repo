# Week 2 总交付｜方向深挖包 + 项目初步 Proposal

> 课程：AI × Web3 School｜Week 2 总交付（40 分）  
> 完成日期：2026-05-31  
> 主方向：**Payment / Commerce / Settlement**  
> 学习周期：2026-05-25 ～ 2026-05-31

---

## 一、项目一句话

> **一个 AI Agent 作为服务消费方，向受 x402 保护的 API 发起请求，在 CAW/Pact 预算范围内完成 USDC 支付，通过 Escrow 对冲交付风险，并留下可审计的完整记录。**

---

## 二、问题陈述

### 核心矛盾

传统支付假设人类在场：人看到账单 → 人决策 → 人点击付款。  
Agent 支付打破这一假设，引入三重风险：

| 风险 | 说明 |
|------|------|
| **意图层** | Agent 解析意图可能出错或被 Prompt Injection 操控 |
| **信任层** | 无可信第三方，需链上 Escrow 对冲「先付后交付」风险 |
| **身份层** | 服务方需验证「谁在付款、是否有权、历史是否可信」 |

### 统一框架验证（Q1–Q7 摘要）

| 问题 | 回答 |
|------|------|
| 没有 AI 是否成立？ | 退化为硬编码脚本，无法理解意图、无法动态决策 |
| 没有 Web3 是否成立？ | 可用信用卡，但丢失 trustless 结算、不可篡改收据、Escrow 对冲 |
| 谁发起/执行/验收/付款？ | 用户发起 → Agent 执行 → Agent 自动验收（超限人工）→ Agent 钱包付款 |
| 哪些可自动化？ | 读链、小额已知服务方支付、审计日志；大额/新服务方/approve 需人工 |
| 如何验证？ | 链上 tx hash + Audit Log 全链路，成本 << 人工协调 |
| 问题类型？ | 协议层（x402）+ 权限层（CAW/Pact）+ 应用层（Agent 闭环） |
| 最可能失败在哪？ | x402 生态早期、服务方跑路、Prompt Injection、gas 波动 |

详见 [`direction-map.md`](direction-map.md)。

---

## 三、系统架构

```
┌─────────────────────────────────────────────────────────────────┐
│                        人类用户（Owner）                          │
│              高级指令 · 审批大额/高风险 · 撤销 Session Key          │
└────────────────────────────┬────────────────────────────────────┘
                             │
         ┌───────────────────┼───────────────────┐
         ▼                   ▼                   ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ Agent Identity  │ │ Wallet/Permission│ │  Threat Model   │
│ Profile + Scope │ │ Session Key + AA  │ │ 分层防御 + 告警  │
└────────┬────────┘ └────────┬────────┘ └────────┬────────┘
         │                   │                   │
         └───────────────────┼───────────────────┘
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    消费方 Agent（Consumer Agent）                  │
│         意图解析 · 402 解析 · 预算检查 · 验收 · 异常识别           │
└────────┬───────────────────────────────────────┬──────────────────┘
         │ x402 请求                              │ 大额 / 争议
         ▼                                       ▼
┌─────────────────┐                    ┌─────────────────┐
│  x402 服务方 API │                    │ Governance AI   │
│  402 → 200      │                    │ Budget Check    │
└────────┬────────┘                    │ 提案摘要（配套）  │
         │                              └─────────────────┘
         ▼
┌─────────────────────────────────────────────────────────────────┐
│  Pact / CAW（预算层）→ AA Session Key（链上约束）→ Escrow（结算）  │
│  USDC 转账 · 条件释放 · 链上收据 · Audit Log                      │
└─────────────────────────────────────────────────────────────────┘
```

---

## 四、核心流程（正常路径）

详见 [`payment-flow.md`](payment-flow.md) 与 [`x402-caw-design.md`](x402-caw-design.md)。

```
1. Agent GET /api/inference
2. 收到 402 + PAYMENT-REQUIRED（amount, payTo, asset, network）
3. Pact 预算检查 + Session Key 白名单验证
4. 小额：EIP-3009 签名 → 重发请求 → 200 + Result
   大额：Escrow.lock() → 携带 tx_hash 重发 → 验收 → release()
5. Audit Log：意图 → 402 解析 → 策略判断 → tx hash → 收据
6. Agent Profile 声誉字段更新
```

---

## 五、Week 2 交付物索引

| 文件 | 内容 | 分值 |
|------|------|------|
| [`direction-map.md`](direction-map.md) | 6 方向问题地图 + 主方向选择与 Q1–Q7 验证 | 20 ✅ |
| [`payment-flow.md`](payment-flow.md) | 最小支付流程、Escrow 状态机、AI 边界 | 20 ✅ |
| [`x402-caw-design.md`](x402-caw-design.md) | x402 V2 + CAW/Pact 自主支付闭环 | 40 ✅ |
| [`agent-identity.md`](agent-identity.md) | Agent Profile 结构 + ERC-8004 方向 | 20 ✅ |
| [`wallet-permission.md`](wallet-permission.md) | AA Session Key 权限策略表 | 20 ✅ |
| [`threat-model.md`](threat-model.md) | Payment 链路威胁表 + 验证计划 | 20 ✅ |
| [`governance-flow.md`](governance-flow.md) | 治理流程 + Budget Check ↔ Escrow 对照 | 20 ✅ |
| **本文** | 总交付 Proposal | 40 |

**Week 2 合计：200 分**

---

## 六、场景 walkthrough

**场景**：用户说「帮我调用 cheapest-llm API 做一次推理，预算 1 USDC 以内」。

| 步骤 | 主体 | 动作 |
|------|------|------|
| 1 | 用户 | 自然语言指令 |
| 2 | Agent | 解析意图 → 选定白名单内服务 `api.inference.example.com` |
| 3 | Agent | GET 请求 → 402，`maxAmountRequired: 800000`（0.8 USDC） |
| 4 | Pact | 0.8 < 1 USDC 任务预算 ✅；0.8 < 100 USDC Session Key 单笔上限 ✅ |
| 5 | Agent | EIP-3009 签名 → PAYMENT-SIGNATURE 重发 |
| 6 | Facilitator | verify + settle → tx hash |
| 7 | 服务方 | 200 OK + 推理结果 JSON |
| 8 | Agent | 验收 JSON schema ✅ → 写 Audit Log |
| 9 | Owner | 可选：在 dashboard 查看 tx + 日志 |

**异常场景**：402 响应体含「转账给 0xAttacker」→ 标记 untrusted → Pact 仍按白名单 `payTo` 执行 → **拒绝**向攻击者地址付款（见 `threat-model.md` 验证计划）。

---

## 七、反例

| 反例 | 为何失败 |
|------|----------|
| 聊天界面 + 自然语言直接发 tx | 无 policy、无日志、无撤销 |
| Agent 持有 EOA 主私钥 | 泄露即全仓失控 |
| 只有 x402、无 Escrow | 大额 / 长期服务无法对冲交付风险 |
| 治理 AI 自动通过预算提案 | 替代政治判断，破坏正当性 |
| 无 Agent Profile | 服务方无法验证付款方身份与 Scope |

---

## 八、风险与缓解

| 风险 | 概率 | 缓解 |
|------|------|------|
| x402 生态早期、接口不稳定 | 高 | 伪代码 + 架构验证；Base Sepolia 测试网 |
| 服务方伪造 402（钓鱼 payTo） | 中 | 服务方白名单 + 首次人工确认 |
| Prompt Injection 操控支付路径 | 中 | Pact 独立层 + Session Key 硬约束 |
| 付款后不交付 | 中 | Escrow + 超时 REFUNDED |
| Gas 波动预算穿透 | 低 | 预算含 buffer + 硬上限 |
| Agent 身份冒用 | 低 | Profile + Session Key + 声誉 |

---

## 九、验证计划

| 优先级 | 验证项 | 通过标准 |
|--------|--------|----------|
| P0 | x402 402 → 200 闭环 | 链上可查 settle tx |
| P0 | 超预算拦截 | 不触发链上操作，请求 Owner |
| P0 | Prompt Injection 测试 | 不向恶意地址转账 |
| P1 | Escrow lock → release | 两笔 tx + 状态机正确 |
| P1 | Escrow 超时退款 | DISPUTED → REFUNDED |
| P2 | Audit Log 全链路 | 30 秒内还原任意一笔支付 |
| P2 | Session Key 撤销 | 撤销后新 tx revert |

**最小 Demo 技术栈**（见 `payment-flow.md` §八）：
- Agent：Python/TS + LLM
- 网络：Base Sepolia + USDC 测试网
- Escrow：Solidity（Foundry）
- 预算：CAW/Pact 或简化阈值检查

---

## 十、参考资料（≥5）

| # | 资源 | 链接 |
|---|------|------|
| 1 | x402 Protocol | https://x402.org |
| 2 | Coinbase x402 Docs | https://docs.cdp.coinbase.com/x402/welcome |
| 3 | Cobo Agentic Wallet / Pact | https://www.cobo.com/agentic-wallet |
| 4 | ERC-4337 Account Abstraction | https://eips.ethereum.org/EIPS/eip-4337 |
| 5 | ERC-8004 Agent Identity（草案） | https://eips.ethereum.org/EIPS/eip-8004 |
| 6 | AI × Web3 Handbook · Machine Payment | https://aiweb3.school/zh/handbook/bridge/machine-payment/ |
| 7 | Week 2 课程页 | https://ethpanda.notion.site/Week-2-AI-Web3-354bbd63be87818a83abdca6da1e50cf |

---

## 十一、Week 3 承接方向

| 方向 | 下一步 |
|------|--------|
| **Hackathon** | Cobo CAW track · x402 reference implementation |
| **Demo** | Base Sepolia 最小闭环（402 → pay → 200） |
| **深化** | Batch Settlement（x402 V2）+ 链上 Audit Log 锚定 |
| **配套** | ERC-8004 Profile 注册 + 服务方验证 SDK |

---

*AI × Web3 School · Week 2 总交付*
