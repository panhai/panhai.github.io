// 前台就业网行为
$(function(){
	$(".NAV li").mouseenter(function(){
		$(this).addClass("on");
	}).mouseleave(function(){
		$(this).removeClass("on");
	}).find("div a:last-child").css('border-bottom-color','transparent');
});