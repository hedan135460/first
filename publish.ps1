# ============================================================
#  博客一键发布脚本
#  功能: 将本地 D:\myblog 的更改提交并推送到 GitHub
#        (Cloudflare 检测到更新后会自动构建部署)
#  用法: 双击 "一键发布.bat" 即可
# ============================================================

$ErrorActionPreference = "Stop"
$blogDir = "D:\myblog"

Set-Location $blogDir

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "          博 客 一 键 发 布" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查 git 是否可用
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[错误] 未找到 git，请先安装 Git for Windows" -ForegroundColor Red
    Write-Host "       https://git-scm.com/download/win" -ForegroundColor DarkGray
    Read-Host "按回车键退出"
    exit 1
}

# 2. 检查远程仓库
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host "[错误] 未配置远程仓库 origin，请先执行:" -ForegroundColor Red
    Write-Host "       git remote add origin https://github.com/hedan135460/first.git" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit 1
}
Write-Host ("远程仓库: " + $remote) -ForegroundColor DarkGray
Write-Host ""

# 3. 显示当前分支和状态
$branch = git rev-parse --abbrev-ref HEAD 2>$null
Write-Host ("当前分支: " + $branch) -ForegroundColor DarkGray
Write-Host "--- 待发布的更改 ---" -ForegroundColor Yellow
$changed = git status --porcelain
if ($changed) {
    git status --short
} else {
    Write-Host "(没有本地更改)" -ForegroundColor DarkGray
}
Write-Host ""

# 4. 输入提交说明
$defaultMsg = "更新博客 " + (Get-Date -Format "yyyy-MM-dd HH:mm")
$commitMsg = Read-Host ("提交说明 [回车使用默认: " + $defaultMsg + "]")
if ([string]::IsNullOrWhiteSpace($commitMsg)) {
    $commitMsg = $defaultMsg
}

# 5. 提交本地更改
if ($changed) {
    Write-Host ""
    Write-Host "正在提交..." -ForegroundColor Cyan
    git add -A
    git commit -m $commitMsg
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[错误] git commit 失败" -ForegroundColor Red
        Read-Host "按回车键退出"
        exit 1
    }
    Write-Host ("[成功] 已提交: " + $commitMsg) -ForegroundColor Green
} else {
    Write-Host "[提示] 没有本地更改，跳过提交" -ForegroundColor Yellow
}

# 6. 推送到 GitHub
Write-Host ""
Write-Host "正在推送到 GitHub..." -ForegroundColor Cyan
Write-Host "(如果弹出 GitHub 登录窗口，请登录确认)" -ForegroundColor DarkGray
git push origin HEAD
if ($LASTEXITCODE -ne 0) {
    Write-Host "" -ForegroundColor Red
    Write-Host "[错误] git push 失败" -ForegroundColor Red
    Write-Host "可能原因:" -ForegroundColor Yellow
    Write-Host "  1. 网络不通，请检查代理/VPN 是否开启 (当前系统代理: 127.0.0.1:7890)" -ForegroundColor Yellow
    Write-Host "  2. GitHub 登录凭据过期，push 时弹出的窗口里重新登录" -ForegroundColor Yellow
    Write-Host "  3. 远程仓库被其他设备推送了新提交，先执行: git pull --rebase" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit 1
}
Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  [成功] 已推送到 GitHub！" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host "Cloudflare 正在自动构建部署，约 1-3 分钟后生效" -ForegroundColor Cyan
Write-Host ""

# 7. 可选: 检查网站是否可访问
$siteUrl = "http://ayuan.com"
try {
    $urlLine = Select-String -Path "$blogDir\_config.yml" -Pattern "^url:" | Select-Object -First 1
    if ($urlLine) {
        $siteUrl = ($urlLine.Line -replace "^url:\s*", "").Trim()
    }
} catch { }

$check = Read-Host ("发布完成! 是否现在检查网站可访问性? [y/N]")
if ($check -match "^[yY]") {
    Write-Host ("正在访问 " + $siteUrl + " ...") -ForegroundColor Cyan
    try {
        $r = Invoke-WebRequest -Uri $siteUrl -UseBasicParsing -TimeoutSec 15
        Write-Host ("[成功] 网站可访问, HTTP " + $r.StatusCode) -ForegroundColor Green
    } catch {
        Write-Host "[提示] 网站暂未响应(可能仍在构建中, 请稍后再试)" -ForegroundColor Yellow
        Write-Host ("       " + $siteUrl) -ForegroundColor DarkGray
    }
}

Write-Host ""
Read-Host "按回车键关闭窗口"