<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require_once "vendor/autoload.php";

use App\Service\Crypto;

$username = null;
$enc = "";

if (isset($argc)) {
    if(isset($argv[1]))
	    $username = $argv[1];
}

if(is_null($username)){
    $enc = 'a:2:{s:4:"user";s:4:"user";s:6:"locale";s:2:"en";}';
}else{
    $enc = 'a:2:{s:4:"user";s:'.strlen($username).':"'.$username.'";s:6:"locale";s:2:"en";}';
}

print(base64_encode(Crypto::encrypt($enc)));
