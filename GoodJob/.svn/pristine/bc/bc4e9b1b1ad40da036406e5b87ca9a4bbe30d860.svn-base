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
	var o={},T=$("<div>").appendTo($("body"));
	T.attr('id',"CHIbackgroundDiv").css({
		width:'100%',
		height:isIE6() ? $(window).height() : '100%',
		backgroundColor:'black',
		opacity:0.5,
		zIndex:55555
	}).addClass("fixed fixed-top").hide();
	o.open=function(cbfun){
		T.fadeIn('','',function(){
			if(cbfun)cbfun();
		});
		return o;
	}
	o.close=function(cbfun){
		T.fadeOut('','',function(){
			if(cbfun)cbfun();
		}).unbind();
		return o;
	}
	o.focus=function(obj){
		T.one('click',function(){
			if(obj.close) obj.close();
		});
		return o;
	}
	return o;
}
var CHIbg=CHIbgDiv();
