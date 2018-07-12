/*
 * 顶部导航
 */
$(function(){
	$('ul.h-top-nav li').hover(function(){
		$(this).children('.fix').stop().slideDown(200);
	},function(){
		$(this).children('.fix').stop().slideUp(200);
	})
})
/*
 * 搜索框
 */
$(function(){
	$('.search-inp').focus(function(){
		$(this).val('');
	})
	$('.search-inp').blur(function(){
		$(this).val('请输入您要搜索的课程名称');
	})
	$('.search-tab span').hover(function(){
		$(this).addClass('active').siblings('span').removeClass('active');
		var index = $(this).index();
		$('.tab-item').eq(index).addClass('show').siblings('.tab-item').removeClass('show'); //对应下标显示
	},function(){
		$(this).addClass('active').siblings('span').removeClass('active');
		$('.tab-item').eq(index).addClass('show').siblings('.tab-item').removeClass('show'); //对应下标显示
	})
	
})

/*
 * 热门砍价
 */
$(function(){
	$('.c-kan-content .box .r,.c-kan-content .box .x').click(function(){
		$(this).addClass('active').siblings().removeClass('active');
	})
})


/*
 * 热门学校移入移除动画
 */

//移入动漫显示，移出动漫消失
$(function(){
	$('ul.school-box>li').hover(function(){
		$(this).children('.goin').stop().slideDown(400);
	},function(){
		$(this).children('.goin').stop().slideUp(400);
	})
})



