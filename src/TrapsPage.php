<?php

$GzipFile = 'bomb.gzip';

header("Content-Encoding: gzip"); 
header("Content-Type: text/html; charset=utf-8");
header("Cache-control: no-store");
header("Content-Length: ".filesize($GzipFile));
Header("HTTP/1.1 200 OK"); //'HTTP/1.1 404 Not Found'

if (ob_get_level()){
    ob_end_clean()
}

readfile($GzipFile);
exit;
?>