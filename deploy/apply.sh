#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
install -m 644 "$ROOT/apache/nextcloud.conf" /etc/httpd/conf.d/nextcloud.conf
install -m 644 "$ROOT/php/99-nextcloud.ini" /etc/php.d/99-nextcloud.ini
install -m 644 "$ROOT/cron/nextcloud" /etc/cron.d/nextcloud
if grep -q '^Listen 80$' /etc/httpd/conf/httpd.conf; then
  sed -i 's/^Listen 80$/Listen 3000/' /etc/httpd/conf/httpd.conf
fi
if ! grep -q '^Listen 3000$' /etc/httpd/conf/httpd.conf; then
  printf '%s\n' 'Listen 3000' >> /etc/httpd/conf/httpd.conf
fi
sed -i 's/^pm = .*/pm = ondemand/' /etc/php-fpm.d/www.conf
sed -i 's/^pm.max_children = .*/pm.max_children = 4/' /etc/php-fpm.d/www.conf
sed -i 's/^;*pm.process_idle_timeout = .*/pm.process_idle_timeout = 10s/' /etc/php-fpm.d/www.conf
apachectl configtest
systemctl reload httpd
systemctl reload php-fpm
