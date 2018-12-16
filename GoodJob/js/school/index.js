// JavaScript Document
function Bars(className,MaxValue)
{
	var MaxLength=440;
	$(".bar","."+className).map(function(ind,ele){
		var value=parseInt($(ele).html()),
			length=value*MaxLength/MaxValue,
			xEnd=length-6;
		$(ele).empty();
		var paper=Raphael(ele,$(ele).width(),$(ele).height());
		var attr={fill:'#2673ec',stroke:false};
		var str='M6,0A6,6,0,1,0,6,12L'+xEnd+',12A6,6,0,1,0,'+xEnd+',0Z';
		if(isIE())
		{
//			var front=paper.circle(6,5,6).attr(attr),
//				back=paper.circle(6,5,6).attr(attr),
//				body=paper.rect(5,-1,0,13).attr(attr);
//			back.animate({cx:xEnd},2000);
//			body.animate({width:length-12},2000);
			paper.path(str).attr(attr).attr({transform:'t0,-0.5'});
		}
		else
		{
			var strOriginal='M6,0A6,6,0,1,0,6,12L7,12A6,6,0,1,0,7,0L6,0Z';
			var path=paper.path(strOriginal).attr(attr);
			$(ele).children().css({
				position:'absolute',
				left:0,
				top:isIE() ? -2:0
			});
			path.animate({path:str},2000);
		}
	});
}