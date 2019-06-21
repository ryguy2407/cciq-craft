<?php
/**
 * Database Configuration
 *
 * All of your system's database connection settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/DbConfig.php.
 *
 * @see craft\config\DbConfig
 */

//Get the heroku postgres URL
 $dbopts = parse_url(getenv('DATABASE_URL'));

//If the postgres is set in heroku, use those connections otherwise use default
if(!empty($dbopts['path'])) {
     return [
         'server' => $dbopts["host"],
         'user' => $dbopts["user"],
         'password' => $dbopts["pass"],
         'database' => ltrim($dbopts["path"],'/'),
         'schema' => getenv('DB_SCHEMA'),
         'tablePrefix' => getenv('DB_TABLE_PREFIX'),
         'port' => $dbopts["port"]
     ];
 }

return [
    'driver' => getenv('DB_DRIVER'),
    'server' => getenv('DB_SERVER'),
    'user' => getenv('DB_USER'),
    'password' => getenv('DB_PASSWORD'),
    'database' => getenv('DB_DATABASE'),
    'schema' => getenv('DB_SCHEMA'),
    'tablePrefix' => getenv('DB_TABLE_PREFIX'),
    'port' => getenv('DB_PORT')
];
