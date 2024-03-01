#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
cat << EOF > /var/www/html/wp-config.php
<?php
define('DB_NAME', '${DB_NAME}');
define('DB_USER', '${DB_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', "utf8");
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');

\$table_prefix = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}

require_once ABSPATH . 'wp-settings.php';
?>

EOF
fi