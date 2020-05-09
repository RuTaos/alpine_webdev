echo "Set swap"
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=4096
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

echo "Reload nginx"
nginx -s reload

echo "Restart php-fpm"
rc-service php-fpm7 restart