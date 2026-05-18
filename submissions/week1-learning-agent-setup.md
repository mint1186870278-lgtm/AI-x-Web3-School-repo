# Week 1｜Learning Agent Setup 配置 / 运行记录

> 可公开提交的学习 Agent 配置说明｜不含任何密钥与隐私

---

## 1. 选择的 Agent / AI 工具

- **主工具**：**Cursor**（桌面端 IDE + 内置 Agent / Composer）  
- **辅助**：课程方建议的启动 Prompt 文本托管在 [learning-agent.zh.txt](https://aiweb3.school/learning-agent.zh.txt)  
- **知识底座**：[AI × Web3 Handbook](https://aiweb3.school/zh/handbook/)

---

## 2. 我让 Agent 帮我完成的学习任务（示例）

| 类型 | 内容 |
|------|------|
| 仓库 | 初始化 [AI-x-Web3-School-repo](https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo) 目录、`daily/`、`tasks/`、`handbook-feedback/`、`templates/` |
| 计划 | 写 `learning-plan.md`、`profile.md`，按画像调整「AI + Web3 双轨」第 1 天节奏 |
| 草稿 | 生成每日打卡、`Handbook feedback` 模板 |
| Git | 建议在 **人工确认** 后 `commit` / `pull --allow-unrelated-histories` / `push` |
| 澄清 | 说明 Agent **无法**做手机定时推送；早中晚提醒依赖本人开对话 |
| 安全 | **拒绝**把本地 `handbooks/*.pdf` 批量塞进 **public** 仓库（改 `.gitignore` + `handbooks/README.md`） |

---

## 3. 一段关键 Prompt / 配置说明

**发给 Agent 的核心话（课程原文）**：

```text
请作为我的 AI × Web3 School Learning Agent，先阅读启动 Prompt：https://aiweb3.school/learning-agent.zh.txt ，并结合 Handbook：https://aiweb3.school/zh/handbook/ ，帮我初始化个人学习计划、GitHub 学习仓库、每日打卡草稿和 Handbook feedback 流程。
```

**本地约定**（`CLAUDE.md` 摘要）：

- 优先读 `profile.md`、`learning-plan.md`、最新 `daily/*.md`。  
- 说「打卡」→ 维护 `daily/YYYY-MM-DD.md`；说「feedback」→ `handbook-feedback/`。  
- 写入型操作（commit、敏感链上操作）需 **本人确认**；API Key 仅存环境变量，**永不写入仓库**。

---

## 4. 一次成功输出记录（简述）

- **输入**：提供 GitHub 仓库 URL、补充画像（前端 Vibe Coding、Web3 久未用、每天 ≤1h、偏开发）。  
- **输出**：完成本地与远程合并冲突解决；`main` 分支已推送；`README` 写明 WCB / Handbook 入口与隐私提醒；生成 **5.18** 双轨学习任务与 `tasks/2026-05-18-day1.md` 骨架。  
- **可核验**：仓库目录与近期 commit 历史（公开页面）。

---

## 5. 一次人工复核、修正或拒绝 Agent 建议的记录

| 事件 | Agent 方向 | 人工处理 |
|------|-------------|----------|
| 初始化第 1 天偏重 | 先建议多啃 Web3 补直觉 | **修正**：自陈 AI 概念也弱 → 改为 **AI 基础为主 + Web3 轻扫**，并写回 `learning-plan.md` / `profile.md` |
| PDF 课件 | `git add` 时包含 42 个 `handbooks/*.pdf` | **拒绝入库**：`.gitignore` 排除 PDF，仅保留 `handbooks/README.md` 说明本机存放 |
| 定时提醒 | 用户问「能否早中晚提醒」 | **澄清**：只能在打开 Cursor 对话时给清单；**另设**手机闹钟作为真实定时 |
| 提交授权 | 任意时刻自动 commit | **规则**：仅在用户明确说「帮我提交」后才执行 git commit；其他时候只改工作区 |

---

## 自评（提交对照）

| 要求 | 完成 |
|------|------|
| 工具选择 | ✅ Cursor |
| Agent 学习任务列举 | ✅ 上表 |
| 关键 prompt / 配置 | ✅ 本节 |
| 成功输出 | ✅ §4 |
| 人工复核 / 拒绝 | ✅ §5 |
| 无敏感信息 | ✅ 本文未含任何 token / 私钥 |
