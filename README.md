# AI × Web3 个人学习仓库

Personal learning journal and proof-of-work for [AI × Web3 School](https://aiweb3.school/zh/handbook/).

> 这是我在 AI × Web3 School 的学习记录与 Proof-of-Work 仓库。

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
tasks/                     # Handbook 每日阅读笔记（YYYY-MM-DD-dayN.md）
experiments/               # 小实验与草稿（无密钥）
handbook-feedback/         # Handbook 结构化反馈，可索引、可开源
hackathon/                 # 黑客松相关
submissions/               # 营内提交说明与链接备份
templates/
  daily-note.md
  task-note.md
handbooks/                 # 本地 PDF 仅在本机，见 handbooks/README.md
```


## 学员信息

- **GitHub**：[@mint1186870278-lgtm](https://github.com/mint1186870278-lgtm)
- **仓库**：https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo
- **开始日期**：2026-05-17
- **方向**：**开发**（前端可交付 Demo；Web3 按新手重补基础）
- **每日投入**：≤ 1 小时
- **打卡提醒**：**早、中、晚**（见下方「提醒」；**非**手机/系统定时推送）  

## 早 / 中 / 晚提醒（与 Learning Agent）

开对话时说「早间提醒」「午间提醒」或「晚间提醒」，Agent 会给对应时段的学习清单。详细响应逻辑见 [`CLAUDE.md`](CLAUDE.md)。

若需真正的定时推送，请用手机日历各设一条闹钟，标题指向 [WCB Learning](https://web3career.build/zh/programs/AI-Web3-School#tab=learning) 即可。

## 学习进度看板（简版）

- [x] 完成 `profile.md` 并向 Agent 确认画像
- [x] GitHub 学习仓库已与本地关联
- [ ] `daily/`、`handbook-feedback/` 按营内节奏推进
- [ ] 每周至少 1 条 `handbook-feedback/`（无问题可写「本周无疑问」占位说明）

详细统计写在 `learning-plan.md` 底部。

## 远程仓库

已配置 `origin`：<https://github.com/mint1186870278-lgtm/AI-x-Web3-School-repo.git>

日常推送：

```powershell
git status --short
git add .
git commit -m "docs: update AI Web3 School daily log"
git push
```

**Windows**：可参考 `scripts/init-github-remote.ps1`。勿将 token 发给 Agent。

无实质改动时不要空提交。

