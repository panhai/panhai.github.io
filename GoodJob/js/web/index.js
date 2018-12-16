// 首页使用的函数
//幻灯片
function IndexPPT()
{
	var b=$(".banner").eq(0);
	b.find("ul li img").map(function(ind,ele){
		var iw=$(ele).width();
		var pw=$(".banner").width();
		$(ele).css("marginLeft",(pw-iw)/2+"px");
	});
	b.find("ol li").mouseover(function(){
		show($(this).index());
	});
	function show(n){
		var ul=b.find("ul");
		var lis=ul.find("li");
		n%=lis.size();
		var li=lis.eq(n);
		lis.not(li).fadeOut();
		li.fadeIn();
		var ol=b.find("ol");
		var items=ol.find("li");
		var it=items.eq(n);
		items.removeClass("active");
		it.addClass("active");
	}
	var n=0;
	var timer=setInterval(function(){
		n++;
		show(n);
	},5000);
	show(0);
}
//名企效果
function Famous()
{
    $(".famous").on("mouseover", "li", function () {
		$(this).find("div").show();
    }).on("mouseout", "li", function () {
		$(this).find("div").hide();
	});
}
//职位效果
function Jobs()
{
	$(".jobs dt b").mouseover(function(){
		var i=$(this).index();
		$(this).addClass("active")
			.siblings().removeClass("active");
		var ls=$(this).closest(".jobs").find("dd ul");
		var l=ls.eq(i);
		l.show();
		ls.not(l).hide();
	});
	$(".jobs dt b:first").mouseover();
}