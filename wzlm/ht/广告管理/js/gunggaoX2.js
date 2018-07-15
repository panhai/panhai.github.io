
$('.item').mouseenter(function() { //btn button revise del
	$(this).find('.btn').show();
	$(this).find('.btn button').show();
})

$('.item').mouseleave(function() { //btn button
	$(this).find('.btn').hide();
	$(this).find('.btn button').hide();
})
$('.revise').click(function() {
	$('.revise-form').show();
	$('.zhezhao').show();
})
$('.del').click(function() {
	var _this = this;
	layer.confirm('确定删除？', function(index) {
		$(_this).parent().parent().remove();
		layer.close(index)
	})
})

//关闭修改弹框
$('.closed').click(function() {
	$('.revise-form').hide();
	$('.zhezhao').hide();
})

/*
 *  var obj=$("#avatarSlect")[0].files[0];
    var wuc=window.URL.createObjectURL(obj);
 */

//自定义获取图片路径函数
function getObjectURL(file) {
	var url = null;
	if(window.createObjectURL != undefined) { // basic
		url = window.createObjectURL(file);
	} else if(window.URL != undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file);
	} else if(window.webkitURL != undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file);
	}
	return url;
}
//reviseFile 上传 logo
$('.reviseFile').change(function() {
	var files = document.getElementById('reviseFile');
	var obj = files.files[0];

	var imgurl = window.URL.createObjectURL(obj);
	
	$(this).siblings('.showimg').attr('src',imgurl);
//	console.log(files,imgurl)
})

$('#file').change(function(){
	var files = $(this)[0];
	var obj = files.files[0];
	
	var imgurl = getObjectURL(obj);
	$(this).siblings('img').attr('src',imgurl);
	
})

//取消
$('.reset2').click(function(){
	$('.showimg').attr('src','img/jia_03.jpg');
})

//返回上一级
$('.goback').click(function(){
	window.history.go(-1);
})
