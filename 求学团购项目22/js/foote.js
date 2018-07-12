//左侧导航
$(function(){
	$('.main-left-nav ul li').click(function(){
		//点击当前 li 给当前li添加active  当前li 下的a添加acitve
		$(this).addClass('acitve').siblings('li').removeClass('acitve');
		$(this).children('a').addClass('r');
		$(this).siblings('li').children('a').removeClass('r')
	})
})
