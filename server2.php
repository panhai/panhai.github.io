<?php
//连接数据库文件
header("content-type: text/html; charset=utf-8");

$servername = "localhost";
$username = "root";
$password = "root";
$db = 'user';
 
// 创建连接
$conn = new mysqli($servername, $username, $password,$db);
 
// 检测连接
if ($conn->connect_error) {
    die("连接失败: " . $conn->connect_error);
} 
//echo "连接成功";
