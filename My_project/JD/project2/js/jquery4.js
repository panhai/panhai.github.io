/*
 * 图片移动事件
 * 1：秒杀京东(右侧轮播图)
 * 2:发现好货
 * 3:领卷中心
 * 4：享品质
 * 5:右侧固定导航条
 * 6：页面左侧隐藏的导航条
 */

//移动函数(元素/属性、属性值、移动的时间)
function move(obj,attr1,value,times) {
//	console.log(obj)
//	obj.css(attr1, value)
var o = {};
o[attr1] = value;
	obj.animate(o,times)
//	console.log(obj)

}
//1
$(function(){
	$("#killsop_list img").hover(
		function(){
			var _index = $(this)
//			console.log($(this))
			move(_index,'left',-10,200)
//			$(this).animate({left:-10},200)
		},function(){
			var _index = $(this)
			move(_index,'left',0,200)
//			$(this).animate({"left":0},200)
		}
	)
})



//2
$(function(){
	$("#find img").hover(
		function(){
			$(this).animate({right:15},400)
		},function(){
			$(this).animate({right:10},400)
		}
	)
})
//3
$(function(){
	$("#stock_center img").hover(
		function(){
			$(this).animate({right:25},400)
		},function(){
			$(this).animate({right:15},400)
		}
	)
})
//4
$(function(){
	$("#Always_Fun .entryShow").hover(
		function(){
			$(this).animate({"background-position":-140},400)
		},function(){
			$(this).animate({"background-position":-133},400)
		}
	)
})

//5右侧固定导航条
$(function(){
	$("#fixed_nav .listt").hover(function(){
		var index = $(this).index();
		$(this).children("div").animate({left:-70},200);
	},function(){
		var index = $(this).index();
		$(this).children("div").animate({left:0},200);
	})
})


//6滚动到领券中心处显示左侧固定导航条 ,左侧滚动条背景颜色跟着变化

$(function(){
	var $aFoor = $(".floor");
	var $li = $("#navigation_left .share");
	var $scroll = $("#stock").offset().top;
	$(window).scroll(function(){
		var $scrollTop = $(this).scrollTop();
		//判断显示左侧导航条
		if($scrollTop > $scroll) {
			$("#navigation_left").show();
		}else{
			$("#navigation_left").hide();
		}
		
		if($scrollTop > $aFoor.eq(0).offset().top-500) {
			$li.eq(0).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(1).offset().top-500) {
			$li.eq(1).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(2).offset().top-500) {
			$li.eq(2).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(3).offset().top-500) {
			$li.eq(3).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(4).offset().top-500) {
			$li.eq(4).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(5).offset().top-500) {
			$li.eq(5).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(6).offset().top-500) {
			$li.eq(6).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(7).offset().top-500) {
			$li.eq(7).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(8).offset().top-500) {
			$li.eq(8).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(9).offset().top-500) {
			$li.eq(9).addClass("showRed").siblings().removeClass("showRed");
		}
		if($scrollTop > $aFoor.eq(10).offset().top-500) {
			$li.eq(10).addClass("showRed").siblings().removeClass("showRed");
		}
	})
})

//楼城切换
$(function () {
	var $li = $("#navigation_left .share");
	var $scrollTop = $(document.body).scrollTop();
	var $aFoor = $(".floor");
	var now = 0;
	//获取左侧滚动条列表
	$("#navigation_left .share").click(function(){
		var $scrollTop = $(document.body).scrollTop();
		now = $(this).index();
		$("html,body").animate({"scrollTop":$(".floor").eq(now).offset().top-60},400);
		$(this).addClass("showRed").siblings().removeClass("showRed");
	})
	
	$("#navigation_left li").mouseenter(function(){
		$(this).addClass("showRed").siblings().removeClass("showRed");
		$("#navigation_left li").eq(now).addClass("showRed");
	})
	$("#navigation_left").mouseleave(function(){
		$("#navigation_left li").removeClass("showRed");
		$("#navigation_left li").eq(now).addClass("showRed");
	})
	
	//回到顶部
	$(".top").click(function(){
		$("html,body").animate({scrollTop:0},300);
	})
})

