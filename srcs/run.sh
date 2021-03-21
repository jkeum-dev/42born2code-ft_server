#!/bin/bash

# 권한 설정
chmod 775 /run.sh
chown -R www-data:www-data /var/www/
chmod -R 755 /var/www

# ssl 개인키 및 인증서 생성
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gon/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
mv localhost.dev.crt etc/ssl/certs/
mv localhost.dev.key etc/ssl/private/
chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key

# nginx 설정
cp -rp /default /etc/nginx/sites-available/

# phpMyAdmin 설치 및 설정
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin /var/www/html/
rm phpMyAdmin-5.0.2-all-languages.tar.gz
cp -rp /config.inc.php /var/www/html/phpmyadmin/

# wordpress를 위한 DB 테이블 생성
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" \
	| mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'jkeum'@'localhost' IDENTIFIED BY 'jkeum';" \
	| mysql -u root --skip-password
