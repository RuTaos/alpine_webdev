echo "Defining ENV variables which will be used in configuration"
PHP_FPM_USER="www"
PHP_FPM_GROUP="www"
PHP_FPM_LISTEN_MODE="0660"
PHP_MEMORY_LIMIT="256M"
PHP_MAX_UPLOAD="50M"
PHP_MAX_FILE_UPLOAD="200"
PHP_MAX_POST="100M"
PHP_DISPLAY_ERRORS="On"
PHP_DISPLAY_STARTUP_ERRORS="On"
PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
PHP_CGI_FIX_PATHINFO=0

echo "Modifying configuration file www.conf"
sed -i "s|;listen.owner\s*=.*|listen.owner = $PHP_FPM_USER|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;listen.group\s*=.*|listen.group = $PHP_FPM_GROUP|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;listen.mode\s*=.*|listen.mode = $PHP_FPM_LISTEN_MODE|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|user\s*=.*|user = $PHP_FPM_USER|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|group\s*=.*|group = $PHP_FPM_GROUP|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;log_level\s*=.*|log_level = notice|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;php_admin_value\[memory_limit\].*|php_admin_value\[memory_limit\] = $PHP_MEMORY_LIMIT|g" /etc/php7/php-fpm.d/www.conf

echo "Modifying configuration file php.ini"
sed -i "s|display_errors\s*=.*|display_errors = $PHP_DISPLAY_ERRORS|i" /etc/php7/php.ini
sed -i "s|display_startup_errors\s*=.*|display_startup_errors = $PHP_DISPLAY_STARTUP_ERRORS|i" /etc/php7/php.ini
sed -i "s|error_reporting\s*=.*|error_reporting = $PHP_ERROR_REPORTING|i" /etc/php7/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = -1|i" /etc/php7/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = $PHP_MAX_UPLOAD|i" /etc/php7/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = $PHP_MAX_FILE_UPLOAD|i" /etc/php7/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = $PHP_MAX_POST|i" /etc/php7/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= $PHP_CGI_FIX_PATHINFO|i" /etc/php7/php.ini