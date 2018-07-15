//公用的弹框遮罩
//回到顶部、
function goTop(){
	 $("html,body").animate({scrollTop:0}, 400);
}

//工共的二维码弹框
/*
 * <!--二维码弹框-->
		<div style="width: 140px;height: 140px;position: relative;">
			<img src="img/close.png" class="closeid" style="position: absolute;right: -1px;top: -14px;"/>
			<img src="img/erweima2.png"/>
		</div>
 */
function alertWx(){
	$('#alertWx').fadeIn(300);
	$('#motai').fadeIn(200)
	$('#closeid').click(function(){
		$('#alertWx').fadeOut(200);
		$('#motai').fadeOut(200);
	})
}
//alertWx()

//隐藏的导航栏  aside-box   aside>li
$(function(){
	$('.aside>li').mouseenter(function(){
		var index = $(this).index();
		$(this).addClass('acitve').siblings('li').removeClass('acitve');
		$('.aside-box').eq(index).stop().show(200).siblings('.aside-box').hide();
		
		$('.aside-box').mouseleave(function(){
			$(this).hide();
		})
	})
	$('.nav-box').mouseleave(function(){
		$('.aside-box').hide();
	})
})
