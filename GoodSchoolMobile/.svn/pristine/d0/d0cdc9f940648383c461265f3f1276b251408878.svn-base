// 通用函数
/*
显示一个半透明的灰色遮挡层
此层的ID恒为BackgroundDivision
z是z轴值，默认10000
cbfuns，回调函数对象，可以使用的属性有
cbfuns.init()，显示完成后的函数
cbfuns.over()，关闭完成后的函数
大图使用img的lowsrc属性
*/
function CHIbgDiv()
{
	var o=new Object();
	o.id="CHIbackgroundDiv";
	o.show=function(cbfun){
		var div=$("#"+o.id);
		resize();
		$(window).resize(function(){resize();});
		div.fadeIn('',function(){if(cbfun)cbfun();});
	}
	function resize(){
		$("#"+o.id).height($(window).height()+100);
	}
	o.hide=function(cbfun){
		$(window).unbind("resize",resize);
		$("#"+o.id).fadeOut("normal",cbfun);
	}
	return o;
}
var CHIbg=new CHIbgDiv();
document.write("<div id=\""+CHIbg.id+"\"></div>");
CHIbg.hide();

//初始化提示窗
function TipInit()
{
	var TIP=$(".tip");
	var W=$(window);
	W.on('load resize',function(){
		TIP.map(function(ind,ele){
			$(ele).css({
				left:(W.width() - $(ele).width()) /2 + 'px'
				,top:(W.height() - $(ele).height()) /2 + 'px'
			});
		});
	});
	TIP.find(".close").click(function(){
		$(this).closest(".tip").fadeOut('',function(){
			if(CHIbg) CHIbg.hide();
		});
	});
}
//报名按钮的定位
function SingUp(isIndex)
{
	var T=$(".sign-up");
	if(!T.size())return;
	//首页定位为绝对时，才需要调整距离
	T.attr("href",'javascript:void(0)')
		.css("visibility","visible")
		.click(function(){
			var regOK=true;//测试是否注册的返回结果
			if(regOK)//已经注册过的
			{
				var signOK=false;//测试是否已经报名的返回结果
				if(!signOK)//没报名的话，跳到学校选择页面
				window.open('schools.html','_self');
				
			}
			else window.open('regist.html','_self');
		});
}
//点击注册的行为
function Regist()
{
	var TIP=$(".tip");
	if(CHIbg)CHIbg.show(function(){
		TIP.fadeIn();
	});
	return false;
}
//点击学校的列表
function Schools()
{
	var T=$(".schools");
	var W=$(window);
	W.on('load resize',function(){
		T.find("dd").css("maxHeight",(W.height()-30-T.find("dt").height())+'px')
		T.css({
			left:(W.width() - T.width()) /2 + 'px'
			,top:(W.height() - T.height()) /2 + 'px'
		});
	});
	function shut(){
		T.fadeOut('',function(){
			CHIbg.hide();
		});
	}
	$(".select").click(function(){
		$("input,textarea").blur();
		CHIbg.show(function(){
			T.fadeIn();
		});
	});
	T.find("dt q").click(shut);
	T.find("dd a").click(function(){
		$(".select input").val($(this).html())
		shut();
	});
}
