# #!/bin/sh
# # 이 스크립트는 주어진 경로에 wp-config.php 파일이 없는 경우에만 해당 파일을 생성하는 스크립트

# if [ ! -f /var/www/html/wp-config.php ]; then
# # 이 부분은 /var/www/html/wp-config.php 파일이 존재하지 않는 경우를 체크합니다. ! -f는 파일이 존재하지 않을 때 참을 반환
# cat << EOF > /var/www/html/wp-config.php
# # 이 부분은 Here Document 문법을 사용하여 새로운 wp-config.php 파일을 생성
# # Here Document는 스크립트 안에서 여러 줄의 텍스트를 표현하는 방법 중 하나
# # 여기서는 EOF라는 구분자로 시작하고, 다시 EOF로 끝나는 영역 내의 모든 텍스트를 /var/www/html/wp-config.php 파일에 쓰게 됩니다. ${DB_NAME}, ${DB_USER}, ${DB_PASSWORD}와 같은 변수는 해당 위치에 지정된 변수 값으로 대체됩니다.

# <?php
# define('DB_NAME', '${DB_NAME}');
# define('DB_USER', '${DB_USER}');
# define('DB_PASSWORD', '${DB_PASSWORD}');
# define('DB_HOST', 'mariadb');
# define('DB_CHARSET', "utf8"); 
# # 데이터베이스 문자 집합을 'utf8'로 설정
# define( 'DB_COLLATE', '' ); 
# # 데이터베이스의 콜레이션을 빈 문자열로 설정
# define('FS_METHOD','direct'); 
# # 파일 시스템 메서드를 'direct'로 설정

# \$table_prefix = 'wp_';

# if ( ! defined( 'ABSPATH' ) ) {
# define( 'ABSPATH', __DIR__ . '/' );}

# require_once ABSPATH . 'wp-settings.php';
# ?>

# EOF
# fi

# # 즉, 이 스크립트는 /var/www/html/wp-config.php 파일이 존재하지 않는 경우에만 해당 파일을 생성하고, 
# # 그 안에 주어진 변수들을 사용하여 WordPress의 설정을 기록

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