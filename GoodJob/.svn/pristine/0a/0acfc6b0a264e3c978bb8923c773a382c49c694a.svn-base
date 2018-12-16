/*
上传图片自动缩小及点叉叉的行为
仅仅是那个形状及点击行为而已
*/
$(function(){
	if(typeof CHIpros=='undefined') alert("需要包含文件effect/correct.js");
	else
	$(".FORMUPLOAD dd").delegate("div q",'click',function(){
		$(this).closest("div").remove();
	}).delegate("div img",'load',function(){
		CHIpros(".FORMUPLOAD dd",'img','',true);
	});
})
