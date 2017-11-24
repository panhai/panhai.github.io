<?php
//根据前端请求，查询数据库，把数据返回给前端
include 'server2.php';
//前端请求的数据拆分
//$username = $_GET['username'];
//$password = $_GET['password'];



//创建sql语句
$sql = "SELECT * FROM  user";
//执行
$result = $conn->query($sql);

$arr = array();
//资源型数据需要转换为类
class Content {
	
}

//做判断
if($result->num_rows > 0){
	//输出数据
	 while($row = $result->fetch_assoc()){
	 	$Content = new Content();
		
		
	 	$Content -> username = $row['username'];
		$Content -> password = $row['password'];
		
		$arr[] = $Content;
	 }
	 
	
}else{
	echo '0 结果';
}
//转换为json打印
echo json_encode($arr);

$conn->close();
