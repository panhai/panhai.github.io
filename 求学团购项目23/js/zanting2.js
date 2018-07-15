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
		var index = $(this).index();
		$('.tab-item').eq(index).addClass('show').siblings('.tab-item').removeClass('show'); //对应下标显示
	})
	
})

//分类列表
$(function(){
	$('.main-a-nav li a.by').click(function(){
		$(this).addClass('acitve')
			.parent().siblings('li')
			  .children('a').removeClass('acitve');
			  return false;
	})
})


//<!-- 营业中而且是上线的门店 显示课程 --> 控制显示个数 

//分页{}
$(function(){
	$('.paging a').on('click',function(){
		$(this).addClass('acitve').siblings('a').removeClass('acitve');
		return false;
	})
	//下一页
	$('.paging span').on('click',function(){
		//获取有active的a标签下标  再加1 
		var index = $('.paging a.acitve').index();
		var len = $('.paging a').length;//页总数
		var indexs = index+1
		//然后显示下一页
		if( indexs >len - 1){//判断是否是最后一页了
			return false;
		}else{
			$('.paging a').eq(indexs).addClass('acitve').siblings('a').removeClass('acitve');
		}
//		console.log(index)
	})
})
