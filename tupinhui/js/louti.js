(function(){
	$(function(){
		//搜索框移出显示固定到顶部
		//获取搜索框距离顶部距离
		searchBoxTop =  $('#searchBox').offset().top;
		$(window).scroll(function(event){
			//获取页面移出的高度
			var winPos = $(window).scrollTop();
			if(searchBoxTop < winPos){//判断搜索框是否移出视口，移出则显示固定定位搜索框到顶部
				$('#search-top').slideDown(400);
			}else{
				$('#search-top').hide();
			}
		})
		
	})
	$(function(){
		//楼层导航实现
		var id = [
			"#qaulity",
			"#gg",
			"#sy",
			"#ds",
			"#ppt",
			"#zs",
			"#dn"
		];
		//点击导航
		$('#leftNav li').click(function(){
			var index = $(this).index();
			var scrollTop = $(id[index]).offset().top;
			console.log(scrollTop)
			//把对应的导航项位置付给滚动条移动的距离
			$(document).scrollTop($(id[index]).offset().top)
			$(this).addClass('active').siblings('li').removeClass('active');
		})
		var top1 = $('#qaulity').offset().top;
		var top2 = $('#gg').offset().top;
		var top3 = $('#sy').offset().top;
		var top4 = $('#ds').offset().top;
		var top5 = $('#ppt').offset().top;
		var top6 = $('#zs').offset().top;
		var top7 = $('#dn').offset().top;
		
		//页面滚动事件
		$(window).scroll(function(){
			var winPos = $(window).scrollTop();
			
		})
		
		
	})
})()
