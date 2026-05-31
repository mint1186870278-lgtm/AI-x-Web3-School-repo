# Week 2 Task G｜Governance / Coordination｜治理协作流程草图

> 课程：AI × Web3 School｜Week 2 Task G  
> 完成日期：2026-05-31  
> 主方向：Payment / Commerce / Settlement（治理作为配套层）  
> 关联阅读：[Governance AI](https://aiweb3.school/zh/handbook/bridge/governance-ai/)（Bridge 模块 35）

---

## 一、问题定义：为什么 Payment 场景也需要治理 AI？

Week 2 主方向是 Agent 自主支付，但以下场景天然涉及**公共决策**，不能仅靠 Agent 或合约自动完成：

| Payment 场景 | 需要治理的原因 |
|-------------|---------------|
| 协议金库拨款给 x402 服务生态 | 预算归属社区，需投票 / 多签批准 |
| Agent 消费公共 API / 开源 infra | 谁维护底层库、是否重复拨款——需贡献可见性 |
| Escrow 争议升级 | 争议材料需结构化整理，供仲裁者或投票者判断 |
| CAW / Pact 策略变更 | 预算上限、白名单调整需 Meeting Action + 投票 |
| 社区对「Agent 自主支付上限」表决 | 多元利益相关方视角需保留，不能压成单一结论 |

> **Governance AI 是提高公共决策的信息质量，不是替代人的政治判断。**

**第一性原理**：
- **来源可追溯**：每个关键摘要都能回到提案、论坛、会议或链上记录
- **立场要分开**：事实、推断、观点、建议不能混写
- **人保留决策权**：AI 辅助阅读与整理；投票、授权、拨款仍由人或明确规则完成

---

## 二、三层架构：信息层 → 决策层 → 执行层

```
┌─────────────────────────────────────────────────────────────┐
│  信息层（Governance AI 主战场）                                │
│  Proposal Summary · Meeting Action · Budget Check           │
│  Source Traceability · Plurality · Contribution Graph       │
└──────────────────────────┬──────────────────────────────────┘
                           │ 结构化材料 + 来源链接
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  决策层（人 / 治理流程）                                      │
│  论坛讨论 · 投票 · 多签批准 · Timelock 等待期                 │
└──────────────────────────┬──────────────────────────────────┘
                           │ 通过的决议 + 授权
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  执行层（Web3 机制）                                          │
│  链上转账 · Escrow 里程碑释放 · Grants 栈 · 审计日志          │
└─────────────────────────────────────────────────────────────┘
```

| 阶段 | AI 角色 | 人的角色 | Web3 机制 |
|------|---------|----------|-----------|
| 提案阅读 | Proposal Summary + Source Traceability | 阅读摘要、点回原文、补充观点 | 论坛 / Snapshot / Tally |
| 讨论协调 | Meeting Action、Plurality 多视角整理 | 确认 action owner、发起/参与讨论 | 会议纪要链上锚定（可选） |
| 预算审查 | Budget Check checklist | 投票 / 多签批准 | Timelock、多签金库 |
| 拨款执行 | 执行 checklist、里程碑提醒 | 确认收款地址与权限 | 链上转账 / Escrow 释放 |
| 贡献复盘 | Contribution Graph 证据整理 | 评审、申诉、下轮资助 | 链上支付记录、Grants 栈 |

---

## 三、主流程：提案 → 摘要 → 审查 → 投票 → 执行

```
新提案发布（论坛 / 链上）
        │
        ▼
┌───────────────────┐
│  Proposal Summary │  ← AI：结构化摘要 + 保留争议 + 附来源
│  + Source Trace   │  ← 人：点回原文、补充遗漏观点
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│  社区讨论          │  ← AI：Meeting Action、Plurality 多视角
│  + Budget Check   │  ← 人：确认 action owner、发起投票
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│  投票 / 多签       │  ← 人：投赞成 / 反对 / 弃权
│  + Timelock       │  ← Web3：Governor 合约、Token 权重
└─────────┬─────────┘
          │ 通过
          ▼
┌───────────────────┐
│  拨款执行          │  ← AI：里程碑提醒、执行 checklist
│  Escrow / 直接转账 │  ← Web3：条件释放、链上收据
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│  贡献复盘          │  ← AI：Contribution Graph 证据整理
│  + 下轮资助        │  ← 人：评审、申诉、调整规则
└───────────────────┘
```

---

## 四、Proposal 摘要模板（7 步）

Handbook 最小实践，可直接用于任何治理提案的信息整理：

| 步骤 | 字段 | 说明 |
|------|------|------|
| 1 | 提案目标和背景 | 要解决什么问题 |
| 2 | 预算金额、付款地址、里程碑 | 可核对的事实项 |
| 3 | 支持理由和反对理由 | 保留争议，不单列一方 |
| 4 | 未回答问题 | AI 不能假装已回答 |
| 5 | 相关历史提案或链上交易 | 避免重复讨论 |
| 6 | 每条关键结论附来源链接 | 论坛 / 提案编号 / tx hash |
| 7 | 免责声明 | **「AI 没有替你做投票建议」** |

### 示例：协议金库资助 x402 服务生态（虚构场景）

```markdown
## 提案摘要（AI 辅助整理 · 非投票建议）

**目标**：向 3 个 x402 兼容 API 服务方各拨款 10,000 USDC，用于 6 个月基础设施维护。

**预算事实**（来源：提案 #42 原文 §2）
- 总额：30,000 USDC
- 收款地址：0xA...（服务方 A）、0xB...、0xC...
- 里程碑：M1 集成测试网（30 天）→ M2 主网上线（90 天）→ M3 文档与 SDK（180 天）

**支持理由**（来源：论坛帖 #128–#131）
- 降低 Agent 接入 x402 的摩擦
- 已有 2 个服务方在测试网有可用 demo

**反对理由**（来源：论坛帖 #135–#137）
- 服务方 B 上次 Grant 未交付文档（链上 tx 0x... 已拨款，GitHub issue 仍 open）
- 30,000 USDC 占金库季度预算 15%，比例偏高

**未决问题**
- 服务方 B 历史交付是否构成否决理由？（需社区讨论，AI 不判断）
- Escrow 条款是否绑定里程碑？（提案未明确）

**相关历史**
- Grant #38（2025-Q4）：服务方 A，已交付 ✅（tx 0x...）
- Grant #39（2025-Q4）：服务方 B，部分交付 ⚠️（tx 0x...）

**来源索引**
- 提案原文：https://forum.example.com/t/42
- 链上预算表：https://explorer.example.com/address/0xTreasury...

---
⚠️ 本摘要由 AI 辅助整理，仅供阅读参考。投票、授权、拨款决策由社区成员自行完成。
```

---

## 五、Budget Check ↔ Escrow 对照表

治理审查与链上 Escrow 是**同一笔钱的两种视图**（对齐 `payment-flow.md`）：

| Budget Check 问题 | 链上 Escrow 条件 | 验证方式 |
|-------------------|-----------------|----------|
| 预算项是否覆盖开发、审计、运营？ | `lock()` 金额 = 提案总额 | 多签 / 投票 tx |
| 里程碑 deliverables 能否验证？ | `DELIVERED` 状态需提交证明 | GitHub release / 测试网 tx |
| 上次拨款是否交付？ | 历史 `RELEASED` vs `REFUNDED` | 链上 tx + issue 状态 |
| 收款地址是否属提案方？ | `release()` 目标地址 = 提案地址 | 地址签名 / 多签确认 |
| 是否有 vesting / 分期？ | 分阶段 `lock()` + 条件 `release()` | 合约状态机 |
| 异常提款？ | Timelock 延迟 + 多签 | 告警 + 人工复核 |

**一行对照（Day 10 笔记提炼）**：

```
Budget Check「服务方 B 上次 Grant 未交付文档」
    → Escrow 条件「M1 验收通过前不 release 第二笔」
    → 链上验证「GitHub issue #47 closed + 测试网 endpoint 200 OK」
```

---

## 六、附录：Payment 主线迷你流程

**场景**：协议金库资助 x402 服务生态（Budget Check → 投票 → Escrow 里程碑付款）

```
金库多签 / Governor 投票通过 Grant #42
        │
        ▼
Treasury 调用 Escrow.lock(30000 USDC, milestones=[M1,M2,M3])
        │
        ├── M1 到期：服务方提交测试网 tx hash + demo URL
        │       → AI Budget Check：对照 checklist
        │       → 社区 / 多签确认 → Escrow.release(10000)
        │
        ├── M2 到期：主网 endpoint + 402 响应头样例
        │       → 同上 → Escrow.release(10000)
        │
        └── M3 到期：SDK 文档 + GitHub release tag
                → 同上 → Escrow.release(10000)
        │
        ▼
链上留存：lock_tx + 3× release_tx + 审计日志（意图→审查→执行→收据）
```

与 `x402-caw-design.md` 衔接：若 Pact 策略变更（如 Agent 支付上限从 100 → 500 USDC）也需走 **Meeting Action → 提案 → 投票 → 链上策略更新**。

---

## 七、AI 边界与反例

### AI 适合做的

| 能力 | 说明 |
|------|------|
| Proposal Summary | 长提案结构化，保留支持与反对 |
| Meeting Action | 会议讨论 → owner + deadline + 链接 |
| Budget Check | checklist 式审查，标出缺失项 |
| Source Traceability | 每条结论附来源 |
| Plurality | LP / 开发者 / 金库管理者等视角分开呈现 |
| Contribution Graph | 整理贡献证据，不替社区打分 |

### AI 不适合做的

| 限制 | 原因 |
|------|------|
| 替社区投票或生成「建议投赞成票」 | 政治判断权在人 |
| 黑箱拨款或隐藏反对意见 | 破坏治理正当性 |
| 无来源摘要作为投票依据 | 可被信息操纵（见 `threat-model.md`） |
| 自动生成并通过预算提案 | Day 6 Module G 反例——治理风险，非效率提升 |

---

## 八、与仓库其他文件的交叉引用

| 文件 | 关联点 |
|------|--------|
| `submissions/week2/payment-flow.md` | Escrow 状态机、里程碑释放 |
| `submissions/week2/x402-caw-design.md` | Pact 策略变更需 Meeting Action + 投票 |
| `submissions/week2/threat-model.md` | 治理提案作为 Prompt Injection 载体 |
| `submissions/week1/eoa-account-compare.md` | 多签适合治理场景；AI 辅助起草、人工确认 |
| `tasks/2026-05-30-day10.md` | Governance AI 七大知识节点原文笔记 |
| `tasks/2026-05-25-day6.md` Module G | 适合/不适合 AI 的治理分工 |

---

*AI × Web3 School · Week 2 Task G*
