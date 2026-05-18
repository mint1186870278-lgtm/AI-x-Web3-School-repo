#Requires -Version 5.1
# AI × Web3 学习仓库 — 在已有项目目录关联 GitHub（PowerShell）
# 用法：先安装 GitHub CLI 并执行 gh auth login
# 在本目录执行：
#   .\scripts\init-github-remote.ps1 -RepoName "ai-web3-school-cohort-0"

param(
    [string]$RepoName = "ai-web3-school-cohort-0",
    [string]$Description = "Personal learning journal and proof-of-work for AI x Web3 School"
)

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Resolve-Path (Join-Path $here "..")
Set-Location $root

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "未找到 gh。请先安装：https://cli.github.com/ 并执行 gh auth login" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path .git)) {
    git init
    Write-Host "已 git init" -ForegroundColor Green
}

Write-Host @"

下一步（请确认仓库名与可见性后再执行）：

  gh repo create $RepoName --public --description "$Description" --source=. --remote=origin --push

若远程已存在且仅需关联：

  git remote add origin https://github.com/<你的用户名>/$RepoName.git
  git branch -M main
  git push -u origin main

"@
