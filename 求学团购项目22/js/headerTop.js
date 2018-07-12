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

//课程分类
$(function(){
	//fa-angle-up  fa-angle-down
	$('.h-nav-content>span').hover(function(){
		$(this).children('i').eq(0).removeClass('show');//图标转换
		$(this).children('i').eq(1).addClass('show');
	},function(){
		$(this).children('i').eq(1).removeClass('show');
		$(this).children('i').eq(0).addClass('show');
	})
	
	//课程分类下的导航
	$('.aside>li').eq(0).hover(function(){
		$(this).children('img.ning').attr('src','img/nav1.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav11.png')
	})
	$('.aside>li').eq(1).hover(function(){
		$(this).children('img.ning').attr('src','img/nav222.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav2.png')
	})
	$('.aside>li').eq(2).hover(function(){
		$(this).children('img.ning').attr('src','img/nav333.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav3.png')
	})
	$('.aside>li').eq(3).hover(function(){
		$(this).children('img.ning').attr('src','img/nav444.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav4.png')
	})
	$('.aside>li').eq(4).hover(function(){
		$(this).children('img.ning').attr('src','img/nav555.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav5.png')
	})
	$('.aside>li').eq(5).hover(function(){
		$(this).children('img.ning').attr('src','img/nav666.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav6.png')
	})
	$('.aside>li').eq(6).hover(function(){
		$(this).children('img.ning').attr('src','img/nav777.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav7.png')
	})
	$('.aside>li').eq(7).hover(function(){
		$(this).children('img.ning').attr('src','img/999.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav9.png')
	})
	$('.aside>li').eq(8).hover(function(){
		$(this).children('img.ning').attr('src','img/nav999.png')
	},function(){
		$(this).children('img.ning').attr('src','img/nav10.png')
	})
})

