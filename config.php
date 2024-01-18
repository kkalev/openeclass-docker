<?php
/* ========================================================
 * Open eClass 3.x configuration file
 * Created by install on 2024-01-18 11:10
 * ======================================================== */

$mysqlServer = getenv('MYSQL_HOST')?:'db';
$mysqlUser = getenv('MYSQL_USER')?:'eclass';
$mysqlPassword = getenv('MYSQL_PASSWORD')?:'eclass';
$mysqlMainDb = getenv('MYSQL_DATABASE')?:'eclass';