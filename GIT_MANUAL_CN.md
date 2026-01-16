# Git 操作手册 (TrendRadar 专用版)

这份手册是为了配合您的 TrendRadar 部署而量身定制的。
作为初学者，您只需要掌握以下几个核心操作即可。

## 1. 核心概念 (简人话版)

您可以把 Git 想象成一个“网盘同步工具”：
*   **Local (本地)**：您现在操作的这台 Mac 电脑。
*   **Origin (远程)**：您的 GitHub 仓库 (云端备份)。
*   **Upstream (上游)**：作者的原始仓库 (用于获取最新功能)。

我们要做的主要就是：
1.  **提交 (Commit)**：把修改好的文件打个包。
2.  **推送 (Push)**：把包上传到 GitHub，让云端服务器开始干活。

## 2. 日常操作流程 (最常用)

每次您修了 `config.yaml` 或其他配置后，请按顺序执行以下命令：

### 第一步：确认状态
看看哪些文件被修改了。
```bash
git status
```
*红色文件表示已修改但未准备提交，绿色表示已准备好。*

### 第二步：添加修改
把所有修改过的文件加入“待提交列表”。
```bash
git add .
```

### 第三步：提交说明
给这次修改写个备注（中文即可），告诉自己改了什么。
```bash
git commit -m "更新配置：增加游戏关键词"
```

### 第三步：推送到云端 (关键)
这一步做完，GitHub 才会收到您的更新并开始运行爬虫。
```bash
# 如果之前已经解决了冲突，直接推送到 master 分支
git push origin master
```

---

## 3. 获取作者最新功能 (Sync Upstream)

当原作者更新了新功能（比如修复了 bug 或增加了新平台），您需要同步过来：

```bash
# 1. 下载作者的最新代码
git fetch upstream

# 2. 切换到您的主分支 (如果不在的话)
git checkout master

# 3. 合并作者的代码到您的本地
git merge upstream/master
```
*如果出现冲突 (CONFLICT)，请联系 AI 助手协助解决。*

## 4. 验证更新 (Verification)

修改完配置后，如何让 GitHub 知道并开始为您工作？

1.  **提交更改**：
    按照上面的 **日常操作** 步骤，执行 `git add`, `git commit`, `git push`。

2.  **查看效果**：
    - 等待 GitHub Actions 运行一次（或者是手动触发一次）。
    - 打开您的 **GitHub Pages** 链接（如 `https://用户名.github.io/My-TrendRadar/`）。
    - 您应该能看到新的“游戏行业”分组和 RSS 订阅内容了！

## 5. 常见问题 (FAQ)

### Q: 推送时提示 `refusing to merge unrelated histories`？
A: 这是因为云端和本地的记录不一致。强制把云端的拉下来合并即可（注意备份 config.yaml）：
```bash
git pull origin master --allow-unrelated-histories
```

### Q: 推送时提示 `Updates were rejected because the remote contains work that you do not have`？
A: 说明云端有您本地没有的修改（可能是 Actions 自动更新了文件）。先拉取再推送：
```bash
git pull origin master
# 然后如果没冲突，再 push
git push origin master
```

### Q: 推送时提示包含 secrets 无法推送？
A: 检查 `config.yaml` 里是否不小心填入了真的密码或 token。请把它们删掉（留空字符串 ""），真正的密码填在 GitHub 网页的 Secrets 里。
