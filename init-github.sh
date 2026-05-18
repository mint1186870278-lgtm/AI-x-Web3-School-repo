#!/bin/bash
# GitHub 学习仓库初始化脚本
# 使用方式：bash init-github.sh <你的GitHub用户名> <仓库名>
# 示例：bash init-github.sh alice ai-web3-learning

set -e

GITHUB_USER="${1:-your-username}"
REPO_NAME="${2:-ai-web3-learning}"
REPO_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo "=== AI × Web3 Learning Repo 初始化 ==="
echo "GitHub 用户名：${GITHUB_USER}"
echo "仓库名：${REPO_NAME}"
echo ""

# 初始化 git
if [ ! -d ".git" ]; then
  git init
  echo "[1/5] Git 初始化完成"
else
  echo "[1/5] Git 已初始化，跳过"
fi

# 设置 .gitignore
cat > .gitignore << 'EOF'
# OS
.DS_Store
Thumbs.db

# Editor
.vscode/
.idea/
*.swp

# Node
node_modules/
.env
.env.local

# Python
__pycache__/
*.pyc
.venv/

# Build
dist/
build/
EOF
echo "[2/5] .gitignore 创建完成"

# 初始 commit
git add .
git commit -m "chore: initialize AI × Web3 learning repository

- Add learning plan and profile templates
- Add daily log template and Day 0 log
- Add Handbook feedback workflow
- Setup project directory structure

Learning journey started: $(date +%Y-%m-%d)"
echo "[3/5] 初始 commit 完成"

# 添加远程仓库
echo ""
echo "=== 下一步操作 ==="
echo ""
echo "1. 先在 GitHub 上创建空仓库（不要勾选 README）："
echo "   https://github.com/new"
echo "   仓库名建议：${REPO_NAME}"
echo ""
echo "2. 然后运行以下命令连接远程仓库并推送："
echo ""
echo "   git remote add origin ${REPO_URL}"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "[4/5] 脚本执行完成，等待手动推送"
echo ""
echo "=== 完成后记得 ==="
echo "- 更新 README.md 中的 GitHub 用户名"
echo "- 填写 docs/profile.md 背景自评"
echo "- 访问 https://aiweb3.school/zh/handbook/ 更新模块列表"
