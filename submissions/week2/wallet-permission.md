# Week 2 Task E｜Wallet / Permission｜Agent 链上动作权限策略

> 课程：AI × Web3 School｜Week 2 Task E  
> 完成日期：2026-05-31  
> 主方向：Payment / Commerce / Settlement  
> 关联阅读：[Account Abstraction](https://aiweb3.school/zh/handbook/web3/account-abstraction/)（Web3 模块 17）

---

## 一、问题定义：Agent 如何安全地发起链上操作？

Week 2 主线中，消费方 Agent 需要代用户完成 x402 支付、Escrow 锁定与释放。  
传统 EOA 模型（一把私钥 = 全部权力）不适合自动化——需要的是 **策略驱动的智能账户**。

> **把账户从「私钥驱动」升级为「策略驱动」。**

---

## 二、EOA vs 智能账户（AA）

| 维度 | EOA | 智能账户（AA / ERC-4337） |
|------|-----|---------------------------|
| 账户形态 | 地址由私钥推导，无合约代码 | 链上合约账户，逻辑可编程 |
| 验证位置 | 协议层：ecrecover 检查签名 | 合约层：`validateUserOp` 自定义规则 |
| 权限模型 | 全有或全无 | Owner、Guardian、Session Key、日限额 |
| 适合 Agent | ❌ 不宜把私钥交给程序 | ✅ Session Key / 策略引擎限权 |
| 主要风险 | 私钥泄露即失控 | 合约漏洞、策略配置错误 |

与 Week 1 对照：多签解决「多人共同管钱」；AA 解决「同一账户内灵活、可编程的授权」。

---

## 三、ERC-4337 执行路径

```
用户 / Agent 意图
    → 构造 UserOperation（目标、calldata、gas）
    → Bundler 打包进区块
    → EntryPoint 合约统一校验 & 执行
    → Smart Account.validateUserOp() → 通过则执行
```

| 角色 | 职责 |
|------|------|
| **Smart Account** | 链上账户合约；定义「什么签名/条件算合法」 |
| **UserOperation** | 结构化「待执行意图」，不是传统 tx |
| **Bundler** | 收集 UserOp、代发上链 |
| **EntryPoint** | 标准入口；校验、扣费、回调账户逻辑 |
| **Paymaster** | 可选；代付 Gas 或 ERC-20 付 Gas |

---

## 四、Session Key 权限策略表（Payment 场景）

Week 2 x402 + Escrow 场景下的 Session Key 配置：

| 约束维度 | 配置值 | 目的 |
|----------|--------|------|
| **时间** | 24h 或单次任务结束即失效 | 缩小泄露窗口 |
| **单笔金额** | ≤ 100 USDC（6 decimals: 100000000） | 控制单次损失 |
| **日累计** | ≤ 500 USDC | 防止连续小额榨干 |
| **代币** | USDC on Base（`0x833589...`） | 限定支付资产 |
| **合约白名单** | Escrow 合约、USDC 合约、x402 Facilitator | 禁止调用任意合约 |
| **方法选择器** | `transfer`, `lock`, `release`（Escrow） | 禁止 `approve(max)` 等 |
| **撤销** | Owner 调 `revokeSessionKey()`，30 秒内生效 | 攻击后快速止血 |

---

## 五、授权设计四维度

结合 Day 6 Module D 框架：

| 维度 | Payment 场景实例 |
|------|-----------------|
| **1. 对象** | Session Key 代表用户智能账户（Owner: 0xUser...） |
| **2. 范围** | Base 链 · USDC · Escrow + Facilitator 白名单 · 100/500 USDC 限额 |
| **3. 执行策略** | < 50 USDC 且已知服务方 → 全自动；≥ 50 USDC 或新服务方 → 人工确认 |
| **4. 恢复机制** | `revokeSessionKey()` · Safe 2/3 多签暂停 · Audit Log 复盘 |

---

## 六、Pact / CAW 与 AA 的分层

| 机制 | 层级 | 作用 |
|------|------|------|
| **Pact / CAW** | 应用 / 预算层 | 围绕哪次任务、多少预算、何时失效 |
| **ERC-4337 / AA** | 链上账户与交易验证 | 这笔链上操作是否被允许执行 |
| **x402 / Escrow** | 支付与结算层 | 付款节奏、条件释放 |

```
Pact 定义任务预算（「本次推理任务最多 1 USDC」）
    → AA Session Key 在链上落实白名单与限额
    → x402 解析 402 响应 + Escrow 处理大额托管
```

**边界**：
- **AI 能做**：理解意图、起草 UserOp、解释 calldata、在策略内建议是否执行
- **链上 / 账户合约做**：最终是否接受签名、是否超限额、是否命中白名单
- **人不能省掉的**：首次授权、提高限额、改 Owner、approve 大额、升级实现

---

## 七、人工确认触发条件

继承 Week 1 [`restricted-web3-agent.md`](../week1/restricted-web3-agent.md)，针对 Payment 场景调整：

| 条件 | 动作 |
|------|------|
| 单笔 > 50 USDC | 暂停，等待 Owner 确认 |
| 目标合约 / 服务方不在白名单 | 暂停，等待 Owner 确认 |
| 任何 `approve()` 操作 | 一律人工确认 |
| 过去 1 小时已发起 3 笔以上支付 | 暂停，触发风控告警 |
| Prompt Injection 命中（见 threat-model） | 进入人工审核，撤销 Session Key |

---

## 八、反例

| 反例 | 问题 |
|------|------|
| Agent 持有 EOA 主私钥 | 泄露即全仓失控 |
| 界面只有「用自然语言发交易」 | 无权限范围展示、无失败原因、不可审计 |
| Paymaster 代付 Gas 但无 Session Key 限额 | 代付 Gas ≠ 代付风险，仍可能无限调用 |
| 只有 LLM 软约束、无链上硬约束 | Prompt Injection 可绕过 |

---

## 九、与仓库其他文件的交叉引用

| 文件 | 关联点 |
|------|--------|
| `submissions/week1/restricted-web3-agent.md` | Session Key + 撤销 + 白名单基线 |
| `submissions/week1/eoa-account-compare.md` | 三类账户对比 |
| `submissions/week2/payment-flow.md` | Agent 支付 → Session Key |
| `submissions/week2/x402-caw-design.md` | Pact 与 AA 分层 |
| `submissions/week2/agent-identity.md` | Profile Scope 与 Session Key 对齐 |
| `tasks/2026-05-28-day8.md` | AA 阅读笔记 |

---

*AI × Web3 School · Week 2 Task E*
