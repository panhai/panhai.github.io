// 企业中心通用行为
//左导航
function LeftMenu()
{
	$(".left .menus h3").click(function(){
		$(this).toggleClass("off")
			.next("p").slideToggle();
	});
	$(":button,:reset,:submit").focus(function(){
		$(this).blur();
	});
	$(".left li:last-child p").css("border","0")
}
//顶上发布下拉
function ToolPull()
{
	$(".tool-pull").mouseenter(function(){
		$(this).find("samp").stop(true).hide().slideDown();
	}).mouseleave(function(){
		$(this).find("samp").stop(true).show().slideUp();
	});
}
//简单的radio组效果，适用于label中包裹的radio，且没有特殊行为的
function SimpleRadios(Context)
{
	$(Context).find("label").has(":radio").click(function(){
		$(this).addClass("checked").find(":radio").get(0).checked=true;
		$(this).siblings().removeClass("checked");
	});
}

