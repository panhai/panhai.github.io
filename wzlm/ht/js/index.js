//设置布局
$(function() {
	//设置左侧导航尺寸，右侧内容尺寸
	var width = $(window).width() - $('.content-nav').outerWidth();
	var height = $(window).height() - $('#header').height();
	$('.content-nav').height(height)
	$('.content-main').width(width)
	$('.content-main').height(height)
	
	$(window).resize(function(){
		var width = $(window).width() - $('.content-nav').outerWidth();
		var height = $(window).height() - $('#header').height();
		$('.content-nav').height(height)
		$('.content-main').width(width)
		$('.content-main').height(height)
	})
	
	
	//左侧导航二级菜单 content-nav box a 
	var num = 0;
	$('.content-nav .box>a').eq(2).click(function(){
		num++;
		if(num%2==1){
			$('.navList').slideUp(100);
			$(this).find('i').attr('class','fa fa-angle-right')
		}else{
			$('.navList').slideDown(100);
			$(this).find('i').attr('class','fa fa-angle-down')
		}
		return false;
	})
	$('.navList a').click(function(){
		$(this).parent().addClass('active');
		$(this).parent().siblings('.navList').removeClass('active');
		return false;
	})
	
	//判断是否在联盟成员管理栏目
	var $list = $('.content-nav .box>a li').eq(2);
	if($list.hasClass('navVolor')){
		$('.navList').show();
		$(this).find('i').attr('class','fa fa-angle-down')
	}else{
		$('.navList').hide();
		$(this).find('i').attr('class','fa fa-angle-right')
	}
})

