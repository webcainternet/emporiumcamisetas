<?php
// HTTP
define('HTTP_SERVER', 'http://emporiumcamisetas.com.br/admin/');
define('HTTP_CATALOG', 'http://emporiumcamisetas.com.br/');

// HTTPS
define('HTTPS_SERVER', 'http://emporiumcamisetas.com.br/admin/');
define('HTTPS_CATALOG', 'http://emporiumcamisetas.com.br/');

switch ($_SERVER['SERVER_ADDR'])
    {
        //Ambiente Local
        case '127.0.0.1':
			// DIR
			define('DIR_APPLICATION', '/Users/fernandomendes/github/emporiumcamisetas/public/admin/');
			define('DIR_SYSTEM', '/Users/fernandomendes/github/emporiumcamisetas/public/system/');
			define('DIR_DATABASE', '/Users/fernandomendes/github/emporiumcamisetas/public/system/database/');
			define('DIR_LANGUAGE', '/Users/fernandomendes/github/emporiumcamisetas/public/admin/language/');
			define('DIR_TEMPLATE', '/Users/fernandomendes/github/emporiumcamisetas/public/admin/view/template/');
			define('DIR_CONFIG', '/Users/fernandomendes/github/emporiumcamisetas/public/system/config/');
			define('DIR_IMAGE', '/Users/fernandomendes/github/emporiumcamisetas/public/image/');
			define('DIR_CACHE', '/Users/fernandomendes/github/emporiumcamisetas/public/system/cache/');
			define('DIR_DOWNLOAD', '/Users/fernandomendes/github/emporiumcamisetas/public/download/');
			define('DIR_LOGS', '/Users/fernandomendes/github/emporiumcamisetas/public/system/logs/');
			define('DIR_CATALOG', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/');

			// DB
			define('DB_DRIVER', 'mysql');
			define('DB_HOSTNAME', 'localhost');
			define('DB_USERNAME', 'root');
			define('DB_PASSWORD', 'root');
			define('DB_DATABASE', 'emporiumca');
			define('DB_PREFIX', 'oc_');
			break;
		default:
			// DIR
			define('DIR_APPLICATION', '/srv/httpd/emporiumcamisetas.com.br/public/admin/');
			define('DIR_SYSTEM', '/srv/httpd/emporiumcamisetas.com.br/public/system/');
			define('DIR_DATABASE', '/srv/httpd/emporiumcamisetas.com.br/public/system/database/');
			define('DIR_LANGUAGE', '/srv/httpd/emporiumcamisetas.com.br/public/admin/language/');
			define('DIR_TEMPLATE', '/srv/httpd/emporiumcamisetas.com.br/public/admin/view/template/');
			define('DIR_CONFIG', '/srv/httpd/emporiumcamisetas.com.br/public/system/config/');
			define('DIR_IMAGE', '/srv/httpd/emporiumcamisetas.com.br/public/image/');
			define('DIR_CACHE', '/srv/httpd/emporiumcamisetas.com.br/public/system/cache/');
			define('DIR_DOWNLOAD', '/srv/httpd/emporiumcamisetas.com.br/public/download/');
			define('DIR_LOGS', '/srv/httpd/emporiumcamisetas.com.br/public/system/logs/');
			define('DIR_CATALOG', '/srv/httpd/emporiumcamisetas.com.br/public/catalog/');

			// DB
			define('DB_DRIVER', 'mysql');
			define('DB_HOSTNAME', 'localhost');
			define('DB_USERNAME', 'emporiumca');
			define('DB_PASSWORD', 'jUSuy3gdd');
			define('DB_DATABASE', 'emporiumca');
			define('DB_PREFIX', 'oc_');
			break;
	}
?>