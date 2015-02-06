<?php
// HTTP
define('HTTP_SERVER', 'http://emporiumcamisetas.com.br/');

// HTTPS
define('HTTPS_SERVER', 'http://emporiumcamisetas.com.br/');

switch ($_SERVER['SERVER_ADDR'])
    {
        //Ambiente Local
        case '127.0.0.1':
			// DIR
			define('DIR_APPLICATION', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/');
			define('DIR_SYSTEM', '/Users/fernandomendes/github/emporiumcamisetas/public/system/');
			define('DIR_DATABASE', '/Users/fernandomendes/github/emporiumcamisetas/public/system/database/');
			define('DIR_LANGUAGE', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/language/');
			define('DIR_TEMPLATE', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/view/theme/');
			define('DIR_CONFIG', '/Users/fernandomendes/github/emporiumcamisetas/public/system/config/');
			define('DIR_IMAGE', '/Users/fernandomendes/github/emporiumcamisetas/public/image/');
			define('DIR_CACHE', '/Users/fernandomendes/github/emporiumcamisetas/public/system/cache/');
			define('DIR_DOWNLOAD', '/Users/fernandomendes/github/emporiumcamisetas/public/download/');
			define('DIR_LOGS', '/Users/fernandomendes/github/emporiumcamisetas/public/system/logs/');

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
			define('DIR_APPLICATION', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/');
			define('DIR_SYSTEM', '/Users/fernandomendes/github/emporiumcamisetas/public/system/');
			define('DIR_DATABASE', '/Users/fernandomendes/github/emporiumcamisetas/public/system/database/');
			define('DIR_LANGUAGE', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/language/');
			define('DIR_TEMPLATE', '/Users/fernandomendes/github/emporiumcamisetas/public/catalog/view/theme/');
			define('DIR_CONFIG', '/Users/fernandomendes/github/emporiumcamisetas/public/system/config/');
			define('DIR_IMAGE', '/Users/fernandomendes/github/emporiumcamisetas/public/image/');
			define('DIR_CACHE', '/Users/fernandomendes/github/emporiumcamisetas/public/system/cache/');
			define('DIR_DOWNLOAD', '/Users/fernandomendes/github/emporiumcamisetas/public/download/');
			define('DIR_LOGS', '/Users/fernandomendes/github/emporiumcamisetas/public/system/logs/');

			// DB
			define('DB_DRIVER', 'mysql');
			define('DB_HOSTNAME', 'localhost');
			define('DB_USERNAME', 'root');
			define('DB_PASSWORD', 'root');
			define('DB_DATABASE', 'emporiumca');
			define('DB_PREFIX', 'oc_');
			break;
	}
?>