echo "Nginx package is available in the Alpine Linux repositories"
apk update
apk add nginx mc htop zip

echo "Creating new user and group 'www' for nginx"
adduser -D -g 'www' www

echo "Create a directory for html files"
chown -R www:www /var/lib/nginx

echo "Make backup of original nginx.conf file"
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

echo "Install php7 with modules"
apk add php7 php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-tokenizer php7-session php7-simplexml

echo "Make backup of original www.conf and php.ini files"
cp /etc/php7/php-fpm.d/www.conf /etc/php7/php-fpm.d/www.conf.orig
cp /etc/php7/php.ini /etc/php7/php.ini.orig

echo "Configurating Nginx for use sites-conf"
cp /vagrant/base-configs/nginx_php_vhosts.conf /etc/nginx/nginx.conf
chmod 644 /etc/nginx/nginx.conf

echo "Install composer"
apk add composer

echo "Add nginx and php-fpm7 to autorun"
rc-update add nginx default
rc-update add php-fpm7 default

echo "Install MariaDB"
apk add mysql mysql-client

sed -i "s|.*bind-address.*|\#bind-address = |g" /etc/mysql/my.cnf
sed -i "s|.*skip-external-locking.*|\#skip-external-locking|g" /etc/mysql/my.cnf

mysql_install_db --user=mysql --datadir=/var/lib/mysql
rc-service mariadb start
mysqladmin -u root password root
mysql -u root -proot -e "DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -u root -proot -e "create user 'root'@'%' identified by 'root'; grant all privileges on *.* to 'root'@'%' with grant option; flush privileges;"
rc-update add mariadb default