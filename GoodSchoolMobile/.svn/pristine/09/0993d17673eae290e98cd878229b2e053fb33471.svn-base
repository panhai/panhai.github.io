//// 全站通用JS
////判断IE版本
//function isIE6(){return isIEX(6);}
//function isIE7(){return isIEX(7);}
//function isIE8(){return isIEX(8);}
//function isIE9(){return isIEX(9);}
//function isIEX(x){return navigator.appVersion.indexOf("MSIE "+x+".0")>0;}
//function isLow(){return isIE6() || isIE7() || isIE8();}
//var needPlaceholder=isLow() || isIE9();
//function isIE(){return navigator.appVersion.indexOf("MSIE")>0;}
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////圆圈的百分比完整度(点评)
//var completeValue=parseFloat($("#Complete").text()),
//	Percentage=$("<div>").append(completeValue+'%').css({
//		position:'absolute',
//		width:'100%',
//		height:'100%',
//		textAlign:'center',
//		lineHeight:'65px',
//		top:0,left:0,
//		fontSize:16,
//		color:'#ff7f00 ',
//		fontWeight:'bold'
//	});
//$("#Complete").empty().css('position','relative').append(Percentage);
//var paper=Raphael("Complete",65,65);
//paper.circle(30,30,30,55).attr({
//	transform:isLow() ? 't1,1' : 't3,3',
//	stroke:'#e0e0e0',
//	'stroke-width':3 
//});
//paper.ca.angle=function(percent){
//	if(!percent) var path='M55,0z';
//	else
//	var large=percent>=50 ? 1:0,
//		per1=2*Math.PI/100,
//		x=30*(1+Math.sin(per1*percent)),
//		y=30*(1-Math.cos(per1*percent)),
//		path='M30,0A30,30,0,'+ large +',1,'+ (percent>=100 ? 30.99 : (percent==0 ? 30 : x)) +','+y;
//	return {path:path};
//}
//paper.path("M30,0").attr({
//	angle:0,
//	transform:isLow() ? 't1,1' : 't3,3',
//	stroke:'#ff7f00 ',
//	'stroke-width':3
//}).animate({
//	angle:completeValue
//},1000);




function Circle(MAX)
{
//	var MAX=90;
	if(MAX<0 || isNaN(MAX))MAX=0;
	if(MAX>100)MAX=100;
	function a2t(angle){return angle*PI/180;}
	var o=document.getElementById("RoundRun");
	var PI=Math.PI;
	var ctx=o.getContext("2d");
	ctx.lineWidth=4;
	var start=0,from=-90;
	var delta=5;
	var x=y=35,r=30;
	var timer=setInterval(function(){
		var a1=start+from,a2=start+delta*2+from;
//			alert(a1);
//			alert(a2);
		if(a1>=360+from)a1=360+from;
		if(a2>=360+from)a2=360+from;
		arc(a1,a2,'#eee');
		start+=delta;
		if(start>=360) {clearInterval(timer);timer=0;}
	},30);
//		console.log(ctx);
	var timer2;
	var begin=0,over=MAX/100*360;
	setTimeout(function(){
		timer2=setInterval(function(){
			var a1=begin+from,a2=begin+delta*2+from;
			if(a2>over+from)a2=over+from;
			arc(a1,a2,'#ff7f00');
			begin+=delta;
			if(begin>=over) {clearInterval(timer2);timer2=0;}
		},30);
	},1000);
	
	function arc(a1,a2,color)
	{
		var point=getPoint(a1);
		var t1=a2t(a1),t2=a2t(a2);
		ctx.beginPath();
		ctx.moveTo(point[0],point[1]);
		ctx.arc(x,y,r,t1,t2);
		ctx.strokeStyle=color;
		ctx.stroke();
	}
	
	function getPoint(angle)
	{
		var arr=[];
		var t=a2t(angle)
		arr[0]=r*Math.cos(t)+x;
		arr[1]=r*Math.sin(t)+y;
		return arr;
	}
}


$(function(){
	// 方法调用
	$(window).load(function(){
		Circle(20);
	});
})

