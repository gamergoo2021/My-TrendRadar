# TrendRadar 日常维护与自动推送指南

由于您在本地 Mac 环境下运行 TrendRadar，我们需要通过系统自带的定时任务来实现每日自动推送。

## 1. 配置接收渠道 (收取热点)

要收到推送，您需要配置 `config/config.yaml` 文件。打开该文件并找到 `notification` 部分。

### 推荐渠道
*   **企业微信/个人微信** (推荐): 只需要配置 `WEWORK_WEBHOOK_URL`。如果不希望安装企业微信 APP，可以配置 `WEWORK_MSG_TYPE: "text"` 直接推送到个人微信。
*   **飞书**: 配置 `FEISHU_WEBHOOK_URL`。体验很好，支持卡片消息。
*   **Telegram**: 配置 `bot_token` 和 `chat_id`。

**操作步骤:**
1.  打开 `/Users/dayuan/TrendRadar/config/config.yaml`
2.  找到 `notification` -> `channels`
3.  填入您申请的 Webhook 地址或 Token
4.  保存文件。

## 2. 设置每日定时运行 (自动收取)

我们需要设置 Mac 的 `crontab` 来定时运行我们之前创建的脚本。

**操作步骤:**

1.  打开终端。
2.  输入 `crontab -e` 进入编辑模式 (按 `i` 进入插入模式)。
3.  添加一行配置，例如每天早上 8:00 和晚上 20:00 运行：

```bash
0 8,20 * * * /Users/dayuan/TrendRadar/start_trendradar.sh >> /Users/dayuan/TrendRadar/run.log 2>&1
```

4.  按 `Esc`，输入 `:wq` 保存并退出。
5.  系统会提示 `crontab: installing new crontab`，表示设置成功。

## 3. 日常维护与更新

当项目有新功能发布时，您可以按以下步骤更新：

1.  **获取最新代码**:
    ```bash
    cd /Users/dayuan/TrendRadar
    git pull
    ```

2.  **更新依赖**:
    ```bash
    uv sync
    ```

3.  **运行**:
    更新完成后，正常的定时任务会自动使用新代码。您也可以手动运行 `./start_trendradar.sh` 验证。

## 4. 常见问题
*   **查看运行日志**: 所有的运行日志都会保存在 `/Users/dayuan/TrendRadar/run.log` 中 (如果您按第2步配置了日志重定向)。
*   **手动触发**: 随时可以在终端运行 `/Users/dayuan/TrendRadar/start_trendradar.sh` 来立即获取最新热点。
