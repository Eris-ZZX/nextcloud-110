# nextcloud-110

个人 Nextcloud 的部署仓库。站点跑在 http://43.110.141.102:3000 。

程序本体是 Nextcloud 35.0.1 的官方安装包，放在服务器 `/var/www/nextcloud`，不是从这个仓库编译出来的。上游源码在 https://github.com/nextcloud/server 。整份程序大约 1 GB，里面还有数据库和密钥，所以没有放进这个公开仓库。

这个仓库只保存可以公开的部署配置：

- Apache 只监听 3000
- PHP 内存和上传限制
- 每 15 分钟一次的后台任务

`config.php`、SQLite 数据库和用户文件不在这里。

往 `main` 推送后，GitHub Actions 会把 `deploy/` 同步到服务器并重新加载 Apache 和 PHP。
