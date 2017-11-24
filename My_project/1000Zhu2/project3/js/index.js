/*
 * 右侧固定导航条
 * 
 * 
 * 
 */

$(function(){
	var olistinline = $(".list-inline");
	var a$section = $(".section");
	var $up = $(".up");
	var $down = $(".down");
	//头部导航列表元素
	var a$list = $(".list-inline li");
	var o$listmove = $(".list-move");
	var scroll = 0;
	
	//黄色祝贺语
	var oCongrats = $("#header .cert");
	
	var step = $(window).height();
	var step2 = a$list.eq(0).outerWidth()+20;
	var now = 0;
	var index = 0;
	var len = a$section.size();
	var oldPosition = parseInt(o$listmove.css("left"));
	var windowWidth = $(document).width();
	
	$(".video").width(windowWidth);
//	console.log(oCongrats);
	
	//点击让导航条显示与隐藏
	$(".switch_remove").click(function(){
		now++;
		if(now%2==0){
			$(".icon").animate({left:50},300);
		}else{
			$(".icon").animate({left:0},300);
		}
	})
	
	//点击向上移动
	$up.click(function(){
		index --;
		if(index < 0) {
			index = 0;
			$("html,body").scrollTop = 0;
			o$listmove.stop().animate({left:oldPosition});
		}else{
			$("html,body").animate({scrollTop:index*step},200);
			if(index >=7){
				o$listmove.stop().animate({left:7*step2});
			}else{
				o$listmove.stop().animate({left:index*step2});
			}
		}
	})
	//点击向下移动
	$down.click(function(){
		if(index > len ){
			index = len;
		}else{
			index++;
			$("html,body").animate({scrollTop:index*step},200);
			if(index >=7){
				o$listmove.stop().animate({left:7*step2});
			}else{
				o$listmove.stop().animate({left:index*step2});
			}
		}
		
	})
	
	//判断页面刷新时index=0;
	
	
	// jquery 兼容的滚轮事件
	$(document).on("mousewheel DOMMouseScroll", function (e) {
	    
	    var delta = (e.originalEvent.wheelDelta && (e.originalEvent.wheelDelta > 0 ? 1 : -1)) ||  // chrome & ie
	                (e.originalEvent.detail && (e.originalEvent.detail > 0 ? -1 : 1));              // firefox
	     
	     
	    if (delta > 0) {
	        // 向上滚
	        index--;
	        show ()
	        if(index <=0){
	        	index = 0 ;
	        	o$listmove.stop().animate({left:oldPosition});
	        }else{
	        	o$listmove.stop().animate({left:index*step2});
	        }
	        
	        $("html,body").stop().animate({scrollTop:index*step});
	       	
	    } else if (delta < 0) {
	        // 向下滚
	        index++;
	        show ()
	        if(index >=len) index = len;
	        if(index >=7) {
	       		o$listmove.stop().animate({left:7*step2});
	       	}else{
	       		o$listmove.stop().animate({left:index*step2});
	       	}
	         
	        $("html,body").stop().animate({scrollTop:index*step});
	    }
	    
	});

	
	//左下角按钮点击向下翻页
	$(".video_bottom .movedown").click(function(){
		$("html,body").animate({scrollTop:step});
		o$listmove.stop().animate({left:step2});
		index++;
	})
	
	//顶部导航条移入移出(隐式迭代)
	a$list.mouseenter(function(){
		index = $(this).index();
		o$listmove.stop().animate({left:index*step2});
	})
	//点击tab切换(头盖移动到当前，对应的主体内容显示到可视区)
	a$list.click(function(){
		index = $(this).index();
		o$listmove.stop().animate({left:index*step2});
		$("html,body").stop().animate({scrollTop:index*step});
		
	})
	//移出导航条回到原位置
	olistinline.mouseleave(function(){
		o$listmove.stop().animate({left:oldPosition});
	})
	
	function show () {
		//当index不是0，即当前显示内容不是第一块主体内容时候，黄色祝贺语消失（显示）
		if(index==0){
			oCongrats.stop().animate({top:100},400);
		}else if(index >0){
			oCongrats.stop().animate({top:-100},400);
		}
	}
	
})

//NEW and moser
$(function(){
	var oListDisBox = $(".list-dis-box");
	var aLi = $(".list-dis-box>li");
	
	var now = 0;
	var timer = null;
	var step = aLi.eq(0).height();
//	console.log(step)
	timer = setInterval(function(){
		now++;
		if(now==4) now = 0;
		oListDisBox.animate({top:(-now*step)},500)
	},2000)
})

//aboutus 部分切换
$(function(){
	var step = $(".aboutus_list_box>li").width();
	var now = 0;
	$(".aboutus_list>li").mouseenter(function(){
		var index = $(this).index();
		now = index;
		$(".aboutus_list >li").eq(now).addClass("active").siblings().removeClass("active");
		$(".aboutus_list_box").stop().animate({left:-index*step});
	})
})


//轮播图
$(function(){
	var amiddleBtn = $(".middle_btn>a");
	var ovideo_top = $(".video_top");
	
//	console.log(amiddleBtn)
	
	var timer = null;
	var now = 0;
	var step = $(window).width();
	var len = $(".video_top>div").size();
	timer = setInterval(function(){
		now++;
		if(now > len-1){
			now = 1;
			ovideo_top.css({left:0});
//			console.log(now)
		}
		if(now==4||now==0){
			amiddleBtn.eq(0).addClass("active").siblings().removeClass("active");
		}
		setTimeout(function(){
			ovideo_top.stop().animate({left:-now*step});
			amiddleBtn.eq(now).addClass("active").siblings().removeClass("active");
//			console.log(now)
		},10)
	},3000)
	
	//鼠标移入切换
	amiddleBtn.mouseenter(function(){
		now = $(this).index();
		amiddleBtn.eq(now).addClass("active").siblings().removeClass("active");
		ovideo_top.stop().animate({left:-now*step});
	})
	
})

//页面刷新回到顶部
$(function(){
	$("html,body").animate({scrollTop:0},500);
})

$(function(){
	var height = $(window).height();
	$(".section").css({height:height});
	console.log($(".video_top .bgg1").height())
})

$(function(){
	var width = $(window).width();
	var height = $(window).height();
	$(".bj").css({width:width});
	$(".bj").css({height:height});
	
})

//拖拽移动
