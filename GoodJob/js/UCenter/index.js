function Results()
{
	$(".search-results li").map(function(ind,ele){
		//列表序号自动生成，最大到15
		var i=ind;
		var t=$(ele).find("h3").find("i").eq(0);
		t.css({
			backgroundPosition:"0px "+(i*-18)+"px"
		});
		//搜索结果的隐藏层
		$(ele).mouseenter(function(){
			if(!$(this).has("address").size())return;
			var arr=$(this).find("address").html().split(',');
			map.focus(arr[0],arr[1]);
		})
		.find(".search-job").mouseenter(function(){
			$(this).css("zIndex",2)
				.find(".search-hide").show();
		}).mouseleave(function(){
			$(this).css("zIndex",1)
				.find(".search-hide").hide();
		});
		if(!$(this).index())
		$(this).mouseenter();
	});
}
//地图的切换中心
function getBaiduMap()
{
	var map;
	map = new BMap.Map("mapContainer");          // 创建地图实例  
	map.addControl(new BMap.NavigationControl());    
	map.enableScrollWheelZoom();

	map.focus=function(lng,lat){
		var point=new BMap.Point(lng,lat);
		map.centerAndZoom(point,15);
		var marker = new BMap.Marker(point);        // 创建标注    
		map.addOverlay(marker);                     // 将标注添加到地图中
	}
	
	return map;
}
//三个标签切换
function Labels()
{
	$(".labels li").click(function(){
		var ind=$(this).index();
		$(this).addClass("cur")
			.siblings().removeClass("cur");
		$(".lists .list").hide().eq(ind).show();
		if(isIE6())
		{
			if($(".lists .list").eq(ind).find(".float").size()) $(".float.right").show();
			else $(".float.right").hide();
		}
	}).first().click();
	$(".sub-labels li").click(function(){
		var ind=$(this).index();
		$(this).addClass("cur")
			.siblings().removeClass("cur");
		var ls=$(this).parent().nextAll(".sub-list");
		ls.hide().eq(ind).show();
	}).filter(":first-child").click();
}
//画圈圈
function Circle(MAX)
{
//	var MAX=90;
	if(MAX<0 || isNaN(MAX))MAX=0;
	if(MAX>100)MAX=100;
	function a2t(angle){return angle*PI/180;}
	var o=document.getElementById("Percentage");
	var PI=Math.PI;
	var ctx=o.getContext("2d");
	ctx.lineWidth=5;
	var start=0,from=-90;
	var delta=5;
	var x=y=45,r=40;
	var timer=setInterval(function(){
		var a1=start+from,a2=start+delta*2+from;
		if(a1>=360+from)a1=360+from;
		if(a2>=360+from)a2=360+from;
		arc(a1,a2,'#eee');
		start+=delta;
		if(start>=360) {clearInterval(timer);timer=0;}
	},30);
	
	var timer2;
	var begin=0,over=MAX/100*360;
	setTimeout(function(){
		timer2=setInterval(function(){
			var a1=begin+from,a2=begin+delta*2+from;
			if(a2>over+from)a2=over+from;
			arc(a1,a2,'#ff9500');
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
