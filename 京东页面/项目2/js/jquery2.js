
/*
 * 1:jquery实现领卷中心部分右侧轮播图
 * 
 * 3:头部轮播图左侧背景图移动效果
 * 
 * 
 */
$(function(){
	var now = 0;
	var timer = null;
	var len = $("#coupo2_imgbox").children().length;
	
	//移入大盒子
	$("#cp2").mouseenter(function(){
		$("#coupo2Left").show();
		$("#coupo2Right").show();
		clearInterval(timer)
	})
	$("#cp2").mouseleave(function(){
		$("#coupo2Left").hide();
		$("#coupo2Right").hide();
		timer = setInterval(function(){
			show(1);
		},2000)
	})
	
	//圆点切换
	$("#coupo2_btn").children().mouseenter(function(){
		now = $(this).index();
		$(this).addClass("display").siblings().removeClass("display")
		$("#coupo2_imgbox").children().eq($(this).index()).css("z-index",1).siblings().css("z-index",0)
	})
	
	//轮播函数
	function show (m) {
		now +=m;
		if(m==1) {
			if(now > len -1) now = 0;
			$("#coupo2_btn").children().eq(now).addClass("display").siblings().removeClass("display")
			$("#coupo2_imgbox").children().eq(now).css("z-index",1).siblings().css("z-index",0)
		}else if(m ==-1) {
			if(now < 0 ) now = len -1;
			$("#coupo2_btn").children().eq(now).addClass("display").siblings().removeClass("display")
			$("#coupo2_imgbox").children().eq(now).css("z-index",1).siblings().css("z-index",0)
		}
	}
	//左右切换按钮
	$("#coupo2Right").click(function(){
		show(1);
	})
	$("#coupo2Left").click(function(){
		show(-1);
	})
	
	
	timer = setInterval(function(){
		show(1);
	},2000)
})


