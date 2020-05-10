<?php
$global['configurationVersion'] = 2;
$global['disableAdvancedConfigurations'] = 0;
$global['videoStorageLimitMinutes'] = 0;
if(!empty($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME']!=='localhost' && !filter_var($_SERVER['SERVER_NAME'], FILTER_VALIDATE_IP)) {
    // get the subdirectory, if exists
    $subDir = str_replace(array($_SERVER["DOCUMENT_ROOT"], 'videos/configuration.php'), array('',''), __FILE__);
    $global['webSiteRootURL'] = "http".(!empty($_SERVER['HTTPS'])?"s":"")."://".$_SERVER['SERVER_NAME'].$subDir;
}else{
    $global['webSiteRootURL'] = 'PROTOCOL://DOMAIN/';
}
$global['disableAdvancedConfigurations'] = 0;
$global['videoStorageLimitMinutes'] = 0;
$global['systemRootPath'] = '/var/www/localhost/htdocs/';
$global['salt'] = 'SALT';
$global['disableTimeFix'] = 0;
$global['enableDDOSprotection'] = 1;
$global['ddosMaxConnections'] = 40;
$global['ddosSecondTimeout'] = 5;
$global['strictDDOSprotection'] = 0;
$global['noDebug'] = 0;


$mysqlHost = 'DB_HOST';
$mysqlPort = '3306';
$mysqlUser = 'DB_USER';
$mysqlPass = 'DB_PASSWORD';
$mysqlDatabase = 'youPHPTube';

/**
 * Do NOT change from here
 */

require_once $global['systemRootPath'].'objects/include_config.php';
