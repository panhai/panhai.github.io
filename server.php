<?php
header("content-Type: text/html; charset=utf-8");
include 'server2.php';
//接收表单数据，然后插入数据库

//接收数据拆分

$data = $_POST;
$username = $_POST['username'];
$password = $_POST['password'];

//创建spl语句
$sql = "INSERT INTO user (id, username, password) VALUES (null, '$username', '$password')";
//执行sql语句

if ($conn->query($sql) === TRUE) {
	$url = "index.html";
	echo '<script>location.href="'.$url.'"</script>'; //$url就是你的跳转路径
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();