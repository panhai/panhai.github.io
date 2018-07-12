//点击图片和标题打开二维码
$('.alert').on('click', function() {
	$('.erweima').fadeIn(200)
})
//关闭二维码
$('img.close').on('click', function() {
	$('.erweima').fadeOut(200)
})
