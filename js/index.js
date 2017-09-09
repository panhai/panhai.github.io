
function change () {
	var designWidth = 750, rem2px = 100;
	if(window.innerWidth >= 750){
		document.documentElement.style.fontSize = 100 + 'px';
	}else {
		document.documentElement.style.fontSize = (window.innerWidth / designWidth) * rem2px + 'px';
	}
};

/*页面刷新时执行函数*/
change ();

/*屏幕尺寸改变时执行*/
window.onresize = function () {
	change ();
}

//轮播图
$(function(){
	var now = 0;
	var timer = null;
	var timer2 = null;
	timer = setInterval(function(){
		show();
	},4000)
	
	$(".silder").hover(function(){
		clearInterval(timer);
	},function(){
		timer = setInterval(function(){
			show();
		},5500)
	})
	
	$(".btn li").mouseenter(function(){
		clearTimeout(timer2);
		now = $(this).index()
		timer2 = setTimeout(function(){
			$(".btn li").eq(now).toggleClass("active").siblings().removeClass("active");
			$(".slider_box>li").eq(now).stop().fadeIn(300).siblings("li").fadeOut(300);
		},300)
	})
	
	
	
	function show(){
		now++;
		if(now>$(".slider_box>li").size()-1){
			now = 0;
		}
		$(".slider_box>li").eq(now).stop().fadeIn(3000).siblings("li").fadeOut(3000);
		$(".btn li").eq(now).toggleClass("active").siblings().removeClass("active");
//		console.log($(".slider_box>li").size())
	}
})
