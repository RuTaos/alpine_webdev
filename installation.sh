echo "Nginx package is available in the Alpine Linux repositories"
apk update
apk add nginx mc htop zip

echo "Creating new user and group 'www' for nginx"
adduser -D -g 'www' www

echo "Create a directory for html files"
#mkdir /www
chown -R www:www /var/lib/nginx
#chown -R www:www /www

#echo "Make backup of original nginx.conf file"
# mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

#echo "Configuring Nginx to listen to port 80 and process .html or .htm files"
#cp /vagrant/base-configs/nginx.conf /etc/nginx/nginx.conf
#chmod 644 /etc/nginx/nginx.conf

echo "Install php7 with modules"
apk add php7 php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-tokenizer php7-session

#echo "To add PHP support to Nginx we should modify Nginx configuration file"
#cp /vagrant/base-configs/nginx_php.conf /etc/nginx/nginx.conf
#chmod 644 /etc/nginx/nginx.conf

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