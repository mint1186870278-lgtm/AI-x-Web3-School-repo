# AI × Web3 个人学习仓库

Personal learning journal and proof-of-work for [AI × Web3 School](https://aiweb3.school/zh/handbook/).

## 固定入口

| 资源 | 链接 |
|------|------|
| Handbook | https://aiweb3.school/zh/handbook/ |
| 课程 / 训练营（WCB） | https://web3career.build/zh/programs/AI-Web3-School |
| WCB Learning 标签 | https://web3career.build/zh/programs/AI-Web3-School#tab=learning |
| Learning Agent 启动 Prompt（中文） | https://aiweb3.school/learning-agent.zh.txt |
| WCB Agent API 文档 | https://web3career.build/llms.txt |

## 隐私与安全（public 仓库必读）

请勿提交：API Key、助记词、私钥、未公开会议链接、他人个人数据、内部资料。环境变量仅本地或密钥管理器。

## 目录说明

```text
README.md
profile.md                 # 学员画像（Learning Agent 优先读）
learning-plan.md           # 周节奏 + Handbook 地图 + 里程碑
CLAUDE.md                  # Cursor / Claude 侧 Agent 约定
daily/                     # 每日打卡（YYYY-MM-DD.md）
tasks/                     # 任务小结 / Proof-of-work
experiments/               # 小实验与草稿（无密钥）
handbook-feedback/         # Handbook 结构化反馈，可索引、可开源
hackathon/                 # 黑客松相关
submissions/               # 营内提交说明与链接备份
templates/
  daily-note.md
  task-note.md
```

`docs/` 与 `daily-logs/` 为旧版路径，内容已迁移至根目录 `profile.md`、`learning-plan.md` 与 `daily/`；请勿在新打卡中使用旧路径。

## 学习进度看板（简版）

- [x] 完成 `profile.md` 并向 Agent 确认画像（**Web3 档位可再补一句**）
- [x] GitHub 学习仓库：<https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo>
- [ ] 本地目录与远程 **完成首 push / 历史对齐**（见下文「关联远程」）
- [ ] 每周至少 1 条 `handbook-feedback/`（无问题可写「本周无疑问」占位说明）
- [ ] `daily/` 连续打卡按营内要求执行

详细统计可写在 `learning-plan.md` 底部。

## 关联远程（你的仓库已创建）

远程：<https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo.git>

在本目录（若尚未添加）：

```powershell
git remote add origin https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo.git
```

若远程已有首次 commit、本地也有独立历史，首迁合流可：

```powershell
git branch -M main
git fetch origin
git pull origin main --allow-unrelated-histories
# 如有冲突，解决后
git push -u origin main
```

**Windows（PowerShell）**：可参考 `scripts/init-github-remote.ps1`。勿将 token 发给 Agent。

## 每日提醒（可选）

可与 Agent 约定：**早上** / **晚上** / **早晚** / **暂不提醒**。

---

## 快速命令（Git）

```powershell
git status --short
git add .
git commit -m "docs: update AI Web3 School daily log"
git push
```

无实质改动时不要空提交。
