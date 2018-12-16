// 职位展示页
//公司图片
function Pics(JQstr)
{
	var d=$("<div/>"),img;
	$(JQstr).mouseenter(function(event){
		d.css({
			position:'absolute'
			,left:event.pageX + 'px'
			,top:event.pageY + 'px'
			,border:'1px solid #000'
			,fontSize:"0px"
			,zIndex:1111
			//,visibility:'hidden'
		});
		d.empty().appendTo($("body"));
		img=$("<img>").attr("src",this.lowsrc).appendTo(d);
		if(img.get(0).complete) pos(event);
		else img.load(function(){pos(event);});
	}).mousemove(function(event){pos(event)})
	.mouseleave(function(){
		d.remove();
	});
	function pos(event)
	{
		var left=event.pageX+5,top=event.pageY+5;
		if(left+img.width()>$(window).width()) left= event.pageX-5-img.width();
		if(top+img.height()>$(window).height()) top= event.pageY-5-img.height();
		
		d.css({
			left:left + 'px'
			,top:top + 'px'
		});
	}
}
//职位列表
function JobLists()
{
	var minh=154;
	var t=$(".job-other-lists");
	var sw=$(".job-other-switch");
	if(t.height()<minh) {sw.hide(); return;}
	t.maxHeight=t.height();
	t.css({
		height:minh+'px'
		,overflow:'hidden'
	});
	sw.click(function(){
		t.stop();
		if(!t.open)
		{
			sw.find("i").addClass("up");
			t.animate(
				{height:t.maxHeight+'px'}
				,'normal',''
				,function(){
					t.open=true;
				}
			);
		}
		else
		{
			sw.find("i").removeClass();
			t.animate(
				{height:minh+'px'}
				,'normal',''
				,function(){
					t.open=false;
				}
			);
		}
	});
}
//大段文字上边的小导航，滚动监听
function JobNav(JQstr)
{
	var t=$(JQstr),th=t.height() + 10;
	var goals=[];
	var lis=t.find("li").not(".last")
		.map(function(ind,ele){
			var tt=ele.title;
			$("."+ tt).attr("title", tt);
			goals.push("."+tt);
			$(ele).click(function(){
				var title=this.title;
				var goal=$("."+ title);
				var top=goal.offset().top - th;
				window.scrollTo(0,top);
				active(title);
			});
		});
	function active(title){
		var t=$(JQstr).find("[title="+ title +"]");
		t.addClass("cur").siblings().removeClass("cur");
		var tt=$(JQstr+" .last");
		if(tt.size())
		{
			if(t.index()) tt.show();
			else tt.hide();
		}
	}
	function navItem()
	{
		var st=$(window).scrollTop();
		var gs=$(goals.join(','));
		for(var n=0;n<gs.size();n++)
		{
			var g=gs.eq(n);
			var top=gs.eq(n).offset().top;
			if(st >= top - th)
			{
				active(g.attr("title"));
			}else break;
		}
	}
	$(window).scroll(navItem).load(navItem);
}
//右侧地图
function Map()
{
	var t=$(".map-large");
	$(".map dt,.map-lit").click(function(){
		alphabg.open(function(){
			var top=($(window).height() - t.height())/2
				,left=($(window).width() - t.width())/2
			//在IE6下保留HACK让它也可以静态滚动
			if(isIE6()) t.css({
				left: left + $(window).scrollLeft() +  'px'
				,marginTop: top/2 +  'px'
			});
			else t.css({
				left: left + 'px'
				,top: top + 'px'
			});
			t.fadeIn();
			alphabg.focus(t);
		});
	});
	t.close=function(cbfun){
		t.fadeOut('normal',function(){
			alphabg.close();
		});
	}
	t.find("dt q").click(t.close);
}

function Accuse()
{
	$(".Accuse").get(0).open();
}
function FigureRemove()
{
	$(".CenterDiv")
}
/*新增收藏*/
function Favor()
{
	var b=true;
	$(".detail code").hide().find("s").click(function(){
		$(this).closest("code").hide();
	});
	$(".detail q a.link").attr('href','javascript:void(0)').click(function(){
		var id=$(this).data("id"),img=$(this).find('img'),src=img.attr('src');
		if(b)//收藏成功，图片由灰变橙
		{
			img.attr('src',src.replace('star2.jpg','star.jpg'));
			$(".detail code").hide().filter('.collect').show();
		}
		else//取消收藏
		{
			img.attr('src',src.replace('star.jpg','star2.jpg'));
			$(".detail code").hide().filter('.cancel').show();
		}
		b=!b;
	});
}