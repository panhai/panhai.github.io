// 高级搜索页效果
//初始化过滤器列表
function Filters()
{
	var dls=$(".search-filters dl");
	//dls.not(":last").map(function(ind,ele){
	dls.map(function(ind,ele){
		var dl=$(ele);
		var mh/*max height*/=dl.find("dd").height();
		var ph/*primary height*/=ind?25:50;
		dl.find('.more').click(function(){
			var gh/*goal height*/,cn/*class name*/,w/*words*/;
			if($(this).hasClass('more'))
			{
				gh=mh;
				cn='MORE';
				w='收缩';
			}
			else
			{
				gh=ph;
				cn='more';
				w='更多';
			}
			$(this).html(w+'<i></i>').removeClass().addClass(cn)
				.closest('dl').animate({height:gh+'px'});
		});
	});
	//subfilters
	//dls.last().find("var").not(":last").not(":first").mouseenter(function(){
	dls.last().find("var").not(":first").mouseenter(function(){
		$(this).addClass("on").find("div").show();
	}).mouseleave(function(){
		$(this).removeClass("on").find("div").hide();
	})
	dls.last().find("var").first().mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
		$(this).addClass("on").find("div,pre").show();
	}).mouseleave(function(){
		var T=$(this);
		if(!this.timer)this.timer=setTimeout(function(){
			T.removeClass("on").find("div,pre").hide();
		},500);
	})
	.find("blockquote").mouseenter(function(){
		$(this).addClass("on")
			.find("p").show();
	}).mouseleave(function(){
		$(this).removeClass("on")
			.find("p").hide();
	});
}
function Results()
{
	$(".search-results li").map(function(ind,ele){
		//列表序号自动生成，最大到15
		var i=ind;
		var t=$(ele).find("h3").find("i").eq(0);
		t.css({
			backgroundPosition:"0px "+(i*-18)+"px"
		});
		var ptArr = $("address", ele).html().split(',');
		map.addMarker(ptArr[0], ptArr[1]);
		//搜索结果的隐藏层
		$(ele).mouseenter(function(){
			if(!$(this).find("address").size()) return;
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

	map.focus = function (lng, lat) {
	    if (!lng || !lat || lng == 0 || lat == 0) { return; }	//坐标为空不移动地图
		var point=new BMap.Point(lng,lat);
		map.centerAndZoom(point,15);
	}
	map.addMarker = function (lng, lat) {
	    if (!lng || !lat || lng == 0 || lat == 0) { return; }	//坐标为空不添加标注
	    var point = new BMap.Point(lng, lat);
	    var marker = new BMap.Marker(point);        // 创建标注    
	    map.addOverlay(marker);                     // 将标注添加到地图中
	}

	map.centerAndZoom(new BMap.Point(113.30764967515, 23.120049102076), 15);
	return map;
}
