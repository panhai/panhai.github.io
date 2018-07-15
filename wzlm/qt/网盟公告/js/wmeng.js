$(function() {
	$('.list-box li a').hover(function() {
		$(this).css('color', '#dc201e')
	}, function() {
		$(this).css('color', '')
	})

	//回到顶部
	$('#totop').click(function() {
		$('html , body').animate({
			scrollTop: 0
		}, '900');
	})

})

//公告详情
$(function(){
	
	$('body').on('click','.list-box li a',function(){
		$('.motai').show();
		$('.ggxq').show();
		return false;
	})
	$('.fa-close').click(function(){
		$('.motai').hide();
		$('.ggxq').hide();
	})
})

//点击查看后眼睛图标消失
$(function(){
	$('.list-box li a').click(function(){
		$(this).children('img').hide();
	})
})

$(function() {
	//模拟数据渲染

})