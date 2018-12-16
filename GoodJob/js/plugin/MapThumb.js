//前台某些页面的缩略地图的行为
//地图的点击伸缩
var map,MapNeed=true,BIGMAP,panorama,newPosition=true;
$(function(){
	if(typeof CHIbg=='undefined') alert('需要包含文件effect/bg.js');
	if(typeof CHItab=='undefined') alert('需要包含文件effect/tab.js');
	BigMap=$("table.MapViewer");
	$(".MAPTHUMB samp").click(function(){
		if($(this).hasClass("on"))
		{
			$(this).removeClass("on");
			$("#MAPCONTAINER").slideUp();
			MapNeed=false;
		}
		else
		{
			$(this).addClass("on");
			$("#MAPCONTAINER").slideDown(function(){
				map.refresh();
			});
			MapNeed=true;
		}
	})
	.siblings("span").click(function(){
		CHIbg.open(function(){
			BigMap.fadeIn(function(){
				BigMap.find("h5.map").click();
			});
		});
	});
	BigMap.find("q").click(function(){
		BigMap.fadeOut(function(){
			CHIbg.close();
		});
	});
	//百度地图
	if($('#MAPCONTAINER').size()) map=BaiduMap('MAPCONTAINER');
	if($('#ViewerMap').size()) BIGMAP=BaiduMap('ViewerMap',{busstops:true});
	if($('#Panorama').size()) panorama = new BMap.Panorama('Panorama');//默认为显示导航控件
	//地图查看器标签切换
	CHItab(
		"div.MapViewer",
		"h5",
		" > div",
		{way:'click'},
		{
			show:function(oDOMtitle){
				var viewer=$('div.MapViewer'),bRefresh=true,
					currentCenter=BIGMAP.getCenter();
				if($(oDOMtitle).hasClass("map"))
				{
					var center=BIGMAP.getCenter();
					if(center.lng!=defaultLng || center.lat!=defaultLat)
					setTimeout(function(){
						BIGMAP.refresh(newPosition);
						newPosition=false;
					},100);
					else BIGMAP.focus(defaultLng,defaultLat);
				}
				else if($(oDOMtitle).hasClass("view") && bRefresh)
				{
					var center=panorama.getPosition();
					panorama.setPosition(new BMap.Point(defaultLng,defaultLat));
				}
			}
		}
	);
	$(".MapExpand").click(function(){
		$(this).toggleClass('off');
		var mapWidth,linesWidth,left;
		if($(this).hasClass("off"))
		{
			mapWidth=959;
			linswidth=0;
			left=949;
		}
		else
		{
			mapWidth=680;
			linswidth=280;
			left=670
		}
		$("#ViewerMap").animate({width:mapWidth});
		$(".TrafficLines").animate({width:linswidth});
		$(this).animate({left:left});
	});
});
//在小地图上使用滚轮的话，页面禁止滚动
$(document).on('mousewheel',function(event){
	var target=event.target;
	if($(target).closest(".MAPTHUMB").length) return false;
});
