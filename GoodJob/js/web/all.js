// 全站通用的效果
//判断IE版本
function isIE6(){return isIEX(6);}
function isIE7(){return isIEX(7);}
function isIE8(){return isIEX(8);}
function isIEX(x){return navigator.appVersion.indexOf("MSIE "+x+".0")>0;}
function isLow(){return isIE6() || isIE7() || isIE8();}
function isIE(){return navigator.appVersion.indexOf("MSIE")>0;}
//JQ对象的in判断
$.fn.IN=function(JQobj){
	return $(this).closest(JQobj).size()>0;
}
if(!Array.prototype.indexOf)
Array.prototype.indexOf=function(ele){
	for(var n=0;n<this.length;n++)
		if(ele==0 && this[n]===ele || this[n]==ele)return n;
	return -1;
}
//显示对象
function WRITE(obj)
{
	var str='';
	if(typeof obj == 'object')
	for(var n in obj)
	{
		str+="obj."+n+"="+ obj[n] + '\n';
	}
	else str=obj;
	return str;
}
function ALERT(obj){alert(WRITE(obj));}
//计算元素的外围总尺寸
function totalSize(jqObj,attr)
{
	attr=attr.toLowerCase();
	var mapResult;
	if(attr=="w")
	{
		mapResult=jqObj.map(function(){return $(this).outerWidth(true);});
	}
	else if(attr=="h")
	{
		mapResult=jqObj.map(function(){return $(this).outerHeight(true);});
	}
	return eval(mapResult.get().join("+"));
}
//新增主导航下拉
function NavPull(egnoreItem)
{
	var cur=$(".nav-body .cur").eq(0);
	var filter=egnoreItem ? '[data-nav!="'+ egnoreItem +'"]':''
	var navs=$(".nav-body a"+filter),
		subnavs=$(".nav-sub"+filter);
	navs.mouseenter(function(){
		var data=$(this).data("nav");
		if(!data)return;
		var nav=$(".nav-sub").filter("[data-nav='"+ data +"']").show();
		clearTimeout(nav.get(0).timer);
	}).mouseleave(function(){
		var data=$(this).data("nav");
		var nav=$(".nav-sub").filter("[data-nav='"+ data +"']");
		if(nav.size())nav.get(0).timer=setTimeout(function(){
			nav.hide();
		},100);
	});
	subnavs.mouseenter(function(){
		clearTimeout(this.timer);
		var data=$(this).show().data("nav");
		$(".nav-body a[data-nav='"+ data +"']").addClass("cur");
	}).mouseleave(function(){
		var o=$(this);
		this.timer=setTimeout(function(){
			var data=o.hide().data("nav");
			$(".nav-body a[data-nav='"+ data +"']").not(cur).removeClass("cur");
		},100);
	});
	$(".nav-sub").not(subnavs).show();
}
//导航尾部的个人操作列表
function NavFoot()
{
	var nfu=$(".nav-foot ul")
	$(".nav-foot,.nav-foot ul").mouseenter(function(){
		clearTimeout(nfu.timer);
		nfu.show();
	}).mouseleave(function(){
		clearTimeout(nfu.timer);
		nfu.timer=setTimeout(function(){
			nfu.hide();
		},100);
	});
}
//搜索栏的地址列表
function SearchList()
{
	var t=$(".top-search-list");
	var i=$(".top-search-item,.top-search-item2");
	var tar=$(".top-filter-list");
	var inf=tar.find("dt");
	var list=tar.find("dd");
	i.focus(function(){
		this.select();
	    if (t.timer) { clearTimeout(t.timer); }
	    t.show();
		tar.hide();
	}).keyup(function(event){
		var key=event.which;
		if(key==40 || key==38 || key==13)return false;
		var v=this.value;
		if(!v)
		{
			tar.hide();
			return;
		}
		t.hide();
		var ads=GetAreasByRegexp(v);
		var str='';
		if(ads.length)
		{
			inf.html(v +'，若缩小范围，请输入全拼');
			var cnt=0;
			for(var n=0;n<ads.length;n++)
			{
				cnt++;
				str+='<a href="javascript:void(0)">'+ ads[n][0] +'</a>';
				if(cnt>5) break;
			}
			tar.show();
			list.html(str);
		}
		else
		{
			inf.html('对不起找不到，'+ v);
		}
	}).keydown(function(event){
		var key=event.which;
		if(key==40 || key==38)
		{
			var size=tar.find('a').size();
			if(size && tar.is(":visible"))
			{
				var aCur=tar.find("a.cur"),index=key==40 ? 0 : size-1,delta=key==40 ? 1:-1;
				if(aCur.size())
				{
					index=aCur.index();
					index=(index+delta+size)%size;
				}
			//console.log(index);
				tar.find("a").eq(index).addClass('cur').siblings().removeClass('cur');
			}
			return false;
		}
		else if(key==13)
		{
			return false;
		}
	});
	t.close=function(){
		t.timer = setTimeout(function () {
			t.hide();
			tar.hide();
		},200);
	}
	$("body").click(function(event){
		var TAR=$(event.target);
		if(!TAR.IN(t) && !TAR.is(i)) t.close();
	});
	t.find("a").click(function () {
	    i.val($(this).text());
	    i.data("id", $(this).prop("id"));
		t.close();
	});
	tar.delegate('a','click',function(){
		i.val(this.innerHTML);
	}).delegate('a','mouseenter',function(){
		$(this).addClass('cur').siblings().removeClass('cur');
	});
}
//新增职位搜索列表
function JobsSearch()
{
	var list=$(".top-search-jobs"),input=$(".top-search-text");
	input.keyup(function(event){
		var key=event.which;
		if(key==40 || key==38 || key==13) return false;
		var key=this.value;
		if(!key)return;
		var jobs=GetPositionsByKeywords(key);
		if(jobs.length>0)
		{
			var str='';
			for(var n=0;n<jobs.length;n++)
			{
				str+='<a href="javascript:void(0)">'+ jobs[n][0] +'</a>';
				if(n==10)break;
			}
			list.html(str);
		}
		else list.html('找不到符合【'+key+'】的职位，请修改关键字');
		list.show();
	}).keydown(function(event){
		var key=event.which;
		if(key==40 || key==38)
		{
			var size=list.find('a').size(),delta=key==40 ? 1:-1,begin=key==40 ? 0 : size-1;
			if(size && list.is(":visible"))
			{
				var aCur=list.find('a.cur'),index=begin;
				if(aCur.size())
				{
					index= aCur.index();
					index=(index+delta+size)%size;
				}
				list.children().eq(index).addClass('cur').siblings().removeClass('cur');
			}
			return false;
		}
		else if(key==13)
		{
			var aCur=list.find('a.cur');
			if(aCur.size())
			{
				input.val(aCur.text());
				list.hide();
			}
			return false;
		}
	});
	
	$("body").click(function(event){
		var TAR=$(event.target);
		if(!TAR.IN(list) && !TAR.is(input)) list.hide();
	});
	list.delegate('a','click',function(){
		input.val($(this).text());
		list.hide();
	}).delegate('a','mouseenter',function(){
		$(this).addClass('cur').siblings().removeClass('cur');
	});
}
//主导航的二级行为
function NavSubMenu()
{
	var lis=$('.nav-menu').children();
	lis.mouseenter(function(){
		$(this).children("p").addClass("active");
		$(this).find(".sub-menu").show()
			.children().height(function(){return $(this).parent().height();});
		$(this).siblings().find(".sub-menu").hide();
	}).mouseleave(function(){
		$(this).find(".sub-menu").hide();
		$(this).children("p").removeClass("active");
	});
}
//主导航的头部行为，内页用
function NavHead()
{
	$(".nav-head").mouseenter(function(){
		$(".nav-menu").show();
	}).mouseleave(function(){
		$(".nav-menu").hide();
	});
}
//右下角的浮动
function Float()
{
	var t=$('.float');
	function s(){
		t.stop();
		var wh=$(window).height(),st=$(window).scrollTop(),th=t.height();
		t.animate({
			top:wh+st-th+'px'
		},'normal');
	}
	$(window).scroll(s)
	s();
}
//静态层，复制完全一样的层，及事件
function LayerFixed(JQstrs,way,cssObj)
{
	if(way!='bottom')way='top';
	if(!cssObj) cssObj={zIndex:11}
	$(JQstrs).map(function(ind,ele){
		var copy=$(ele).clone(true);
		copy.hide().addClass("cloned");
		$(window).scroll(function(){
			s($(ele),copy);
		});
		s($(ele),copy);
		
		copy.offset({left:($(ele).offset().left - parseInt($(ele).css("marginLeft")))})
			.width($(ele).width())
			.css(cssObj);
		if(isIE6())
		{
			$("body").append(copy);
			copy.css("position","absolute");
			if(way=='top') copy.addClass("top-fixed");
			else copy.addClass("bottom-fixed");
		}
		else
		{
			copy.css("position","fixed")
			if(way=='top') copy.css('top','0px')
			else copy.css('bottom','0px')
			$(ele).parent().append(copy);
		}
	});
	function s(JQobj,JQcopy){
		var st=$(window).scrollTop();
		var wh=$(window).height();
		var ot=JQobj.offset().top;
		var th=JQobj.height();
		var b=way=='top' ?
			st > ot :
			(st + wh < ot + th);
		if(b)
		{
			JQobj.css("visibility","hidden");
			JQcopy.show();
		}
		else
		{
			JQobj.css("visibility","visible");
			JQcopy.hide();
		}
	}
}
//半透明背景
function GlobalBG()
{
	var T=$("#GlobalBG");
    if (T.length == 0) {    //加入背景层
        T = $("<div id='GlobalBG' class='top-fixed black5'></div>");
        $(function () { $("body").append(T); });
    }
	this.open=function(cbfun){
		if(isIE6()) T.css({
			position:'absolute'
			,left:'0px'
			,top:'0px'
			,height:$(document).height() + 'px'
		});
		else T.height($(window).height()/*"100%"*/);
		T.fadeIn('normal',cbfun);
	}
	this.focus=function(obj){
		T.one('click',function(){
			obj.close();
		});
	}
	this.close=function(cbfun){
		T.fadeOut('normal',cbfun);
	}
}
var alphabg=new GlobalBG();

//右边的飘浮
function FloatRight(JQstr,StaticMarginTop)
{
	if(!JQstr)JQstr=".right";
	if(!StaticMarginTop) StaticMarginTop=0;
	var t=$(JQstr);
	var ot=t.offset().top,ol=t.offset().left;
	var mt=parseInt(t.css("marginTop"));
	if(t.next().size()) var nextJQobj=t.next();
	else if(t.prev().size()) var prevJQobj=t.prev();
	else var parJQobj=t.parent();
	function s(){
		var st=$(window).scrollTop();
		if(st>ot)
		{
			if(isIE6())
			{
				t.appendTo($("body"));
				t.addClass("top-fixed")
					.css({
						left:ol+'px'
						,marginTop:StaticMarginTop +'px'
					});
			}
			else
			{
				t.css({
					position:'fixed'
					,left:ol+'px'
					,top:(StaticMarginTop-mt)+'px'
				});
			}
		}
		else
		{
			if(isIE6())
			{
				if(nextJQobj) nextJQobj.before(t);
				else if(prevJQobj) prevJQobj.after(t);
				else parent.append(t);
				t.removeClass("top-fixed");
			}
			else
			{
				t.css({
					position:'static'
					,marginTop:mt+'px'
				});
			}
		}
	}
	$(window).scroll(s);
	s();
}
//调出时间选择器
function TimePicker(JQstr, option)
{
	var W=$(window),
		T=$(".timepicker"),
		D=T.find(".tp-date"),
		H=T.find(".tp-hour"),
		M=T.find(".tp-minute"),
		GoalDOM
	;
	if (typeof (option) == "undefined") { option = {}; }
	/*新增文字设置*/
	$(T).find(".tp-topic").text(option.topic ? (option.topic+'：') : '您希望将时间调整为：')
	$(T).find(".tp-submit").val(option.submitString ? option.submitString : '确认调整');
	
	T.find(".tp-short")
	.children(":not(p)").click(function(){
		$(this).siblings("p").show();
	})
	.end()
	.mouseleave(function(){
		$(this).find("p").hide();
	})
	.find("p a").click(function(){
		var a=$(this),ap=a.parent();
		ap.siblings("input").val(a.html())
			.end().hide();
		if(ap.closest("div").has(H).size())
			M.click();
	});
	function close()
	{
		T.fadeOut('',alphabg.close);
	}
	
	D.click(function(){
		JBCalendar.show(this,option,function(){
			H.click();
		})
	});
	
	//被点击的对象
	if($(JQstr).size())
	$(JQstr).map(function(ind,ele){
		var isA=this.tagName.toLowerCase()=='a';
		if(isA) $(this).attr("href","javascript:void(0)");
		$(this).click(function(){
			if ($(this).data("disabled")) { return; }//企业待确认时，不允许调整时间
			var isInput=this.tagName.toLowerCase()=='input';
			var title=isInput ? this.value : this.title,
				now=new Date(),
				arr=title ? title.split(" ") : [now.getFullYear()+'-'+(now.getMonth()+1)+'-'+now.getDate(),now.getHours()+':'+now.getMinutes()],
				date=arr[0],
				time=arr[1],
				arr=time.split(":"),
				hour=arr[0],
				minute=arr[1]
			;
			if ($("#hdfofferid").length > 0) {
				$("#hdfofferid").val($(this).prop("id"));
			}
			alphabg.open(function(){
				T.css({
					left:(W.width() - T.outerWidth())/2+'px'
					,top:((W.height() - T.outerHeight())/2+W.scrollTop())+'px'
				}).fadeIn();
				D.val(option.date ? option.date :date);
				H.val(option.hour ? option.hour : hour);
				M.val('00');

				T.find(".tp-btn").one("click",close);
				T.find(".tp-submit").one("click", function () {
				    //点击确定调整时候的行为
				    var time = D.val()
                        + ' ' + H.val()
                        + ':' + M.val()
                        + ':00';
				    if (GoalDOM.tagName.toLowerCase() == 'input') GoalDOM.value = time;
				});
			});
			GoalDOM=this;
		});
	});
}

//切换后台
function SwitchPlatform()
{
	$(".SwitchPlatform").get(0).open();
}
//意见反馈
function SuggestionReady()
{
	var CenterDiv=$(".Suggestion");
	var Center=CenterDiv.get(0);
	$(".SuggestionStart").click(Center.open);
	CenterDiv.find('.reset,.close').click(Center.close);
	CenterDiv.find('.submit').click(function(){
		//存储的过程
		$(".SuggestForm").hide();
		$(".SuggestResult").show();
	});
}
//新加的画圈功能，代替兼容性CSS
function CanvasInitialize()
{	
	$(".canvas").map(function(ind,ele){
		var paper;
		if($(ele).hasClass('circle'))
		{
			$(ele).css({
				display:'inline-block',
				width:17,
				height:17
			});
			paper=Raphael(ele,17,17);
			var cx=cy=isIE() ? 7: 8;
			paper.circle(cx,cy,8).attr({stroke:false,fill:'red'});
		}
		$(ele).children().css({
			position:'absolute',
			left:0,
			top:0
		});
	});
}