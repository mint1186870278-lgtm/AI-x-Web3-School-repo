# Week 2 进阶实践｜x402 Paywall + CAW Agent 自主支付闭环

> 课程：AI × Web3 School｜Week 2 进阶实践（40 分）  
> 完成日期：2026-05-26  
> 参考来源：[x402.org](https://x402.org)、[Coinbase x402 Docs](https://docs.cdp.coinbase.com/x402/welcome)、[Cobo CAW](https://www.cobo.com/agentic-wallet)

---

## 一、x402 协议概述

### 什么是 x402？

x402 是基于 HTTP 402 状态码的**互联网原生支付标准**，由 Coinbase 主导开发（2025 年白皮书，2026 年 V2 发布）。

核心理念：把支付变成 HTTP 请求/响应周期的一部分，无需账户、无需 KYC、无需 API Key——AI Agent 可以像发 HTTP 请求一样完成支付。

### 传统支付 vs x402

| 维度 | 传统 API 支付 | x402 |
|------|-------------|------|
| 开通流程 | 注册账号 → KYC → 绑定支付 → 购买额度 → 获取 API Key | 直接发请求 |
| 支付方式 | 信用卡/银行账户 | 稳定币（USDC 等） |
| 协议费用 | 支付网关手续费 | 仅支付网络 gas 费 |
| 适合主体 | 人类用户 | AI Agent / 程序 |
| 收据 | 平台记录（可被修改） | 链上哈希（不可篡改） |
| 去中心化 | 依赖支付平台 | 无需可信第三方 |

---

## 二、x402 V2 协议技术规范

### 2.1 三个核心 Header

```
服务方 → 客户端（402 响应）：
  PAYMENT-REQUIRED: <Base64(PaymentRequired)>

客户端 → 服务方（重发请求）：
  PAYMENT-SIGNATURE: <Base64(PaymentPayload)>

服务方 → 客户端（200 响应）：
  PAYMENT-RESPONSE: <Base64(SettlementResponse)>
```

### 2.2 PaymentRequired 结构（服务方声明）

```json
{
  "scheme": "exact",
  "network": "eip155:8453",
  "maxAmountRequired": "1000000",
  "resource": "https://api.example.com/inference",
  "description": "Per-request LLM inference fee",
  "mimeType": "application/json",
  "payTo": "0xAbCd...1234",
  "maxTimeoutSeconds": 300,
  "asset": "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
  "extra": {
    "name": "USDC on Base",
    "version": "1"
  }
}
```

| 字段 | 含义 |
|------|------|
| `scheme` | 支付方案（`exact` = 精确金额，V2 支持扩展） |
| `network` | CAIP-2 格式网络标识（`eip155:8453` = Base 主网） |
| `maxAmountRequired` | 最大接受金额（USDC 6 位精度，1000000 = $1.00） |
| `payTo` | 收款地址 |
| `asset` | 支付代币合约地址 |
| `maxTimeoutSeconds` | 付款有效期（超时后需重新请求） |

### 2.3 完整交互流程

```
Agent（客户端）                    API（服务方）               Facilitator
      │                                │                          │
      │──── GET /api/resource ────────►│                          │
      │                                │                          │
      │◄─── 402 + PAYMENT-REQUIRED ───│                          │
      │     (Base64 编码的支付要求)     │                          │
      │                                │                          │
      │── 解析支付要求 ──              │                          │
      │── 预算检查（CAW Pact）──       │                          │
      │── 构建 PaymentPayload ──       │                          │
      │── EIP-3009 签名 ──            │                          │
      │                                │                          │
      │──── GET /api/resource ────────►│                          │
      │     PAYMENT-SIGNATURE: ...     │                          │
      │                                │──── POST /verify ───────►│
      │                                │◄─── ✅ valid ────────────│
      │                                │──── POST /settle ───────►│
      │                                │◄─── tx_hash ────────────│
      │                                │                          │
      │◄─── 200 OK + Result ──────────│                          │
      │     PAYMENT-RESPONSE: ...      │                          │
```

### 2.4 Facilitator 的作用

Facilitator 是 x402 的**链上结算代理**，让服务方无需自己维护链上基础设施：

| 接口 | 功能 |
|------|------|
| `POST /verify` | 验证支付授权（链下，不上链）|
| `POST /settle` | 执行链上结算，返回 tx_hash |
| `GET /supported` | 查询支持的支付方案和网络 |

Coinbase CDP 提供托管 Facilitator，支持 Base、Polygon、Arbitrum、World、Solana，每月 1000 笔免费。

### 2.5 支持的支付方案

| 方案 | 说明 |
|------|------|
| `exact` | 精确金额，一次性转账（V1 主方案）|
| Batch Settlement（V2 新增）| 密码学凭证 + 批量链上兑付，适合高频微支付 |
| Session Token（V2 新增）| 可复用的会话令牌，减少重复付款 |

---

## 三、CAW（Cobo Agentic Wallet）与 Pact 协议

### 3.1 CAW 是什么？

Cobo Agentic Wallet（CAW）是为 AI Agent 设计的 **MPC 非托管钱包**（2026 年 4 月发布）。

核心设计原则：**给 Agent 一个任务授权（Pact），而不是给它私钥。**

### 3.2 MPC 密钥分片架构

```
私钥分为三份：
┌────────────┬──────────────┬──────────────────┐
│   用户持有  │   Agent 持有  │  Cobo 基础设施   │
└────────────┴──────────────┴──────────────────┘
         任意两份才能完成签名（2-of-3 门限）

Agent 单独无法签名 → 超出 Pact 范围的交易被数学层拒绝
Cobo 单独无法签名 → 非托管保证
```

### 3.3 Pact 协议：任务级授权

每个 Agent 任务都需要一个 **Pact**——动态生成、用完即废：

```
Pact 结构：
┌─────────────────────────────────────────────┐
│ Intent（意图）                               │
│   "向 x402 API 发送推理请求，最多支付 $5"   │
├─────────────────────────────────────────────┤
│ Execution Plan（执行计划）                   │
│   1. 发 HTTP 请求                           │
│   2. 处理 402 响应                          │
│   3. 发起 USDC 转账                         │
│   4. 重发请求获取结果                        │
├─────────────────────────────────────────────┤
│ Policies（策略/护栏）                        │
│   - 单次支付上限：$1.00                      │
│   - 总预算：$5.00                           │
│   - 允许的收款地址白名单                     │
│   - 允许的合约白名单                         │
│   - 允许的链：Base                          │
├─────────────────────────────────────────────┤
│ Completion Conditions（完成条件）            │
│   预算耗尽 / 任务完成 / 超时（30min）        │
│   → Pact 自动失效，密钥授权自动撤销          │
└─────────────────────────────────────────────┘
```

### 3.4 三层策略引擎

```
交易请求
    │
    ▼
全局策略（Global Policy）
    │ 通过
    ▼
钱包策略（Wallet Policy）
    │ 通过
    ▼
Pact 策略（Delegation Policy）
    │ 通过
    ▼
MPC 签名 → 链上执行

任意一层拒绝 → 交易被阻断，Agent 只能停止并上报
```

### 3.5 CAW 关键特性

| 特性 | 说明 |
|------|------|
| 非托管 | 私钥分片，Cobo 不能单独动钱 |
| Pact 授权 | 每任务一授权，不给常驻权限 |
| 自动撤销 | 完成条件触发 → 授权自动失效 |
| 实时审计 | 所有操作有时间戳日志，可按 policy/时间/身份检索 |
| 紧急暂停 | 用户手机 App 一键冻结所有 Pact |
| 越权即停 | Agent 遇到 Pact 边界时，唯一合法动作是停止并上报，不得尝试绕过 |

---

## 四、x402 + CAW 完整闭环设计

### 4.1 架构图

```
┌──────────────────────────────────────────────────────────────┐
│                         用户层                                │
│  下达指令："帮我调用推理 API 分析这段数据，最多花 $5"          │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────┐
│                     消费方 Agent                              │
│  1. 解析用户意图                                              │
│  2. 生成 Pact（预算 $5，白名单地址，30min 超时）              │
│  3. 等待用户审批 Pact                                         │
│  4. 发送 HTTP 请求 → 处理 402 → 触发 CAW 签名 → 重发请求      │
│  5. 验收结果 → 记录审计日志                                   │
└──────────┬───────────────────────────┬───────────────────────┘
           │ HTTP 请求                  │ 支付指令
           ▼                            ▼
┌─────────────────────┐    ┌───────────────────────────────────┐
│   x402 保护的 API    │    │         CAW + Pact 层             │
│   返回 402           │    │   检查 Pact 策略                   │
│   返回服务结果        │    │   MPC 签名（2-of-3）              │
└─────────────────────┘    └──────────────┬────────────────────┘
                                          │ 授权后执行
                                          ▼
                           ┌───────────────────────────────────┐
                           │        链上（Base / USDC）         │
                           │  ERC-20 transferWithAuthorization  │
                           │  tx_hash → 不可篡改收据            │
                           └───────────────────────────────────┘
```

### 4.2 逐步流程描述

**Step 1：用户下达指令**
```
用户："分析这份合约数据，API 费用不超过 $5"
```

**Step 2：Agent 生成 Pact**
```json
{
  "intent": "调用推理 API 分析合约数据",
  "budget": { "token": "USDC", "max_total": "5000000", "max_per_tx": "1000000" },
  "allowlist": ["0xKnownAPI..."],
  "chain": "eip155:8453",
  "timeout": 1800,
  "completion": "task_done OR budget_exhausted OR timeout"
}
```

**Step 3：用户审批 Pact**（手机 App 确认）

**Step 4：Agent 发起请求**
```http
GET https://api.inference.example/analyze
Content-Type: application/json

{data: "..."}
```

**Step 5：收到 402 响应**
```http
HTTP/1.1 402 Payment Required
PAYMENT-REQUIRED: eyJzY2hlbWUiOiJleGFjdCIsIm5ldHdvcm...
```

**Step 6：CAW 策略检查**
```
金额 $0.50 < 单次上限 $1.00 ✅
收款方在白名单 ✅
总预算剩余 $5.00 ✅
Pact 未超时 ✅
→ 触发 MPC 签名
```

**Step 7：携带支付重发请求**
```http
GET https://api.inference.example/analyze
PAYMENT-SIGNATURE: eyJwYXltZW50UGF5bG9hZCI6...
```

**Step 8：服务方验证并返回结果**
```http
HTTP/1.1 200 OK
PAYMENT-RESPONSE: eyJzZXR0bGVtZW50SGFzaCI6...

{"result": "分析完成，合约存在重入漏洞..."}
```

**Step 9：Agent 验收 + 记录审计日志**
```
tx_hash: 0xabc123...
金额: $0.50 USDC
服务方: 0xKnownAPI...
结果: ✅ 验收通过
Pact 状态: 活跃（剩余预算 $4.50）
```

---

## 五、AI 的角色边界（x402 + CAW 视角）

| 动作 | 执行主体 | AI 参与方式 |
|------|---------|------------|
| 解析 402 响应头 | Agent | 直接解析 JSON |
| 评估金额合理性 | Agent | 与历史价格对比、异常检测 |
| 检查预算约束 | CAW（基础设施层） | AI 不可绕过 |
| MPC 签名授权 | CAW（数学保证） | AI 不可伪造 |
| 验收服务结果 | Agent | 结构化输出可自动断言 |
| 触发争议/退款 | 人工确认 | Agent 只能上报，不能独立触发 |

---

## 六、安全威胁与缓解

| 威胁 | 攻击方式 | 缓解机制 |
|------|---------|---------|
| 伪造 402 响应 | 中间人伪造支付要求，导流到攻击者地址 | CAW 白名单：收款方必须在 Pact 允许列表 |
| Prompt Injection | 恶意输入篡改 Agent 的支付目标 | Pact 在独立层由用户审批，Agent 无法在执行中修改 |
| 预算穿透 | 高频小额请求累积超限 | CAW 三层策略：单次上限 + 滚动预算上限 |
| 服务方不交付 | 收款后不返回结果 | x402 Facilitator 在结算后才返回 200；结合 Escrow |
| 私钥泄露 | Agent 被攻破 | MPC 分片：Agent 单独持有的片段无法单独签名 |
| 僵尸权限 | Pact 完成后仍残留授权 | Pact 完成条件触发自动撤销，无残留 |

---

## 七、最小可验证 Demo 方案

### 目标

在 Base Sepolia 测试网上，让一个 Agent 完成一次 x402 付款闭环。

### 技术栈

| 组件 | 选型 |
|------|------|
| Agent 运行时 | Python + `httpx` |
| x402 客户端库 | `x402-python`（Coinbase 官方）|
| 钱包 | CAW SDK 或本地测试钱包 |
| 支付代币 | USDC on Base Sepolia |
| Facilitator | Coinbase CDP（免费 1000 次/月）|
| 服务方 Mock | 本地 Node.js + `x402-express-middleware` |

### 验证标准

- [ ] Agent 收到 402 → 解析 PAYMENT-REQUIRED header
- [ ] 预算检查通过 → 触发 USDC 转账
- [ ] 携带 PAYMENT-SIGNATURE 重发请求 → 收到 200
- [ ] Base Sepolia 链上可查 tx_hash
- [ ] 超预算请求被拦截，不触发链上操作
- [ ] 审计日志完整（意图 → 付款 → 结果 → 收据）

---

## 八、x402 生态现状（2026 年 5 月）

| 进展 | 说明 |
|------|------|
| x402 V2 发布 | 2025 年 12 月，引入 Session Token、动态路由、模块化 SDK |
| Batch Settlement | 2026 年 5 月，Cloudflare 合作，支持高频微支付密码学凭证 |
| 支持网络 | Base、Polygon、Arbitrum、World、Solana |
| Cloudflare 集成 | Cloudflare Agents SDK + MCP 已原生支持 x402 |
| CAW 发布 | 2026 年 4 月 20 日，首个 MPC 原生 Agent 钱包上线 |

---

*AI × Web3 School · Week 2 进阶实践*
