#!/bin/sh
set -euo pipefail

if [[ "${DOMAIN}" != "your.domain" && "${DB_HOST}" != "localhost" ]]; then
  if [ ! -f videos/configuration.php ]; then
    cp /root/configuration.php /var/www/localhost/htdocs/videos/configuration.php
    sed -ri \
        -e "s!PROTOCOL!${DOMAIN_PROTOCOL}!g" \
        -e "s!DOMAIN!${DOMAIN}!g" \
        -e "s!SALT!${SALT}!g" \
        -e "s!DB_HOST!${DB_HOST}!g" \
        -e "s!DB_USER!${DB_USER}!g" \
        -e "s!DB_PASSWORD!${DB_PASSWORD}!g" \
        "/var/www/localhost/htdocs/videos/configuration.php"
  fi
  
  if mysqlshow --host=${DB_HOST} --user=${DB_USER} --password=${DB_PASSWORD} youPHPTube; then
    echo "database exist!"
  else
    echo "CREATE DATABASE youPHPTube CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" | mysql --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASSWORD}"
    mysql --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASSWORD}" youPHPTube < /var/www/localhost/htdocs/install/database.sql
    echo "USE youPHPTube; INSERT INTO users (id, user, email, password, created, modified, isAdmin) VALUES (1, 'admin', '${ADMIN_EMAIL}', md5('${ADMIN_PASSWORD}'), now(), now(), true);" | mysql --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASSWORD}"
    echo "USE youPHPTube; INSERT INTO categories (id, name, clean_name, description, created, modified) VALUES (1, 'Default', 'default', '', now(), now());" | mysql --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASSWORD}"
    echo "USE youPHPTube; INSERT INTO configurations (id, video_resolution, users_id, version, webSiteTitle, language, contactEmail, encoderURL, created, modified) VALUES (1, '858:480', 1, '8.8', '${SITE_TITLE}', '${LANG}', '${ADMIN_EMAIL}', 'http://${DOMAIN}:${Encoder_Port}', now(), now());" | mysql --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASSWORD}"
  fi
fi

chown -R apache:apache /var/www

set -e

rm -f /run/apache2/httpd.pid

exec httpd -DFOREGROUND "$@"
