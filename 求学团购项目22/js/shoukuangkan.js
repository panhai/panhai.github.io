//点击图片和标题打开二维码 点击图片和标题
$('.alert').on('click', function() {
	$('.erweima').fadeIn(200)
})
//关闭二维码
$('img.close').on('click', function() {
	$('.erweima').fadeOut(200)
})
//删除项目
$('.btnbox .delete').click(function(){
	var _this = this;
	layer.confirm('确定要删除收藏的项目吗？',function(index){
		$(_this).parent().parent().parent().parent().remove();
		layer.close(index)
	})
})
//点击查看想，项目
$('.btnbox button').click(function(){
	$('.erweima').fadeIn(200)
})

//切换不同状态
$('.main3-to a').click(function(){
	$(this).addClass('acitve').siblings('a').removeClass('acitve');
})
//no yue all
$('.main3-to a.no').click(function(){
	$('.nostop').show(100);
	$('.stop').hide();
})
$('.main3-to a.yue').click(function(){
	$('.nostop').hide();
	$('.stop').show(100);
})
//all
$('.main3-to a.all').click(function(){
	$('.nostop').show(100);
	$('.stop').show(100);
})


