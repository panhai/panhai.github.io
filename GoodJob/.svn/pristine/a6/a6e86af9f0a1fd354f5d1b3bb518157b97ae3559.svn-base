/*
*****************************这回这个是全局用的，所以一改全改，好多页都用它的，改时请慎重
*****************************这回这个是全局用的，所以一改全改，好多页都用它的，改时请慎重
百度地图，考虑一页可能有多个地图
本段需要引用百度地图的JS
oOptions，可以使用的属性有
	editable，默认为false，为true时地图可编辑
	multiple，默认为false，为true时可以使用多个标注
	busstops，默认为false，为true时可以显示指定标注周围的公交车站
	defaultMarker，默认为true，为true时显示默认的标注点
oCallbacks，回调函数集合对象，可以使用的属性有
	dragend(lng,lat)，拖拽标注点时的回调函数
	reposition(lng,lat)，重新设置标注点位置的回调函数
*/
var defaultLng=113.30764967515,defaultLat=23.120049102076;
function BaiduMap(sIDcontainer,oOptions,oCallbacks)
{
	if(!$("#"+sIDcontainer).size())return false;
	if(!oOptions || !$.isPlainObject(oOptions)) oOptions={};
	if(!oCallbacks || !$.isPlainObject(oCallbacks)) oCallbacks={};
	var editable= ('editable' in oOptions) ? Boolean(oOptions.editable) : false,
		multiple= ('multiple' in oOptions) ? Boolean(oOptions.multiple) : false,
		label = ('label' in oOptions) ? Boolean(oOptions.label) : false,
        defaultMarker = ('defaultMarker' in oOptions) ? Boolean(oOptions.defaultMarker) : true,
		busstops= ('busstops' in oOptions) ? Boolean(oOptions.busstops) : false;
	var oResult=new BMap.Map(sIDcontainer),
		oDefaultPoint = new BMap.Point(defaultLng, defaultLat),
        //程序需以根目录开始，请改为相对路径，调试后改回来
		myIcon = new BMap.Icon("/images/v2/marker.gif", new BMap.Size(25, 37), {
		    anchor: new BMap.Size(12, 37)   // 设置图片偏移    
		}),
		oDefaultMarker=new BMap.Marker(oDefaultPoint,{icon:myIcon})
 	;

    //当一次只显示一个地点的时候，使用默认标注
	if (defaultMarker) {
	    oResult.addOverlay(oDefaultMarker);
	}
	
	oResult.addControl(new BMap.NavigationControl());    
	oResult.enableScrollWheelZoom();
	oResult.enableAutoResize();
	
	//使用默认坐标进行视野更新
	oResult.refresh=function(bFreshBusstops){
		this.moveMarker(defaultLng,defaultLat);
		if(busstops && bFreshBusstops) this.seekBusStops(defaultLng,defaultLat);
	}
	//视线关注某一点，单纯改变关注点
	oResult.focus = function (lng, lat) {
	    if (!lng || !lat || lng == 0 || lat == 0) return;
		this.centerAndZoom(new BMap.Point(lng,lat),15);
	}
	//移动关注点及标注
	oResult.moveMarker=function(lng, lat){
	    if (!lng || !lat || lng == 0 || lat == 0) return;
		oDefaultPoint=null;
		oDefaultPoint=new BMap.Point(lng,lat);
		oDefaultMarker.setPosition(oDefaultPoint);
		this.centerAndZoom(oDefaultPoint,15);
	}
	//添加新标注，可使其能被删除
	oResult.addMarker = function (lng, lat,info,opts) {
		if (!lng || !lat || lng == 0 || lat == 0) return;
		var point = new BMap.Point(lng, lat);
		var marker = new BMap.Marker(point);
		this.addOverlay(marker);
		this.addClickHandler(info,marker,opts);
		/*----------------------------------------------------------*/
		
    	/*----------------------------------------------------------*/
		if(editable)
		{
			var menuitem=new BMap.MenuItem('删除这个标注',function(point,pixel,marker){
				if(confirm('真的删除这个标注？')) oResult.removeOverlay(marker);
			});
			var menu = new BMap.ContextMenu();
			menu.addItem(menuitem);
			marker.addContextMenu(menu);
			marker.enableDragging();
			marker.addEventListener("dragend",function(event){
				//拖拽完成时的标注坐标
				var position=event.point.lng+','+event.point.lat;
				if($.isFunction(oCallbacks.dragend)) oCallbacks.dragend(event.point.lng,event.point.lat);
			});
			

			
		}
		if(busstops)
		{
			marker.addEventListener("click",function(event){
				defaultLng=event.point.lng;
				defaultLat=event.point.lat;
				oResult.refresh();
			});
		}
	}
	//可以直接使用地址字符串进行搜索
	var local = new BMap.LocalSearch(oResult, {
		renderOptions:{map: oResult}
	});
	oResult.search = function (address) {
	    var option = {
	        onSearchComplete: function (results) {
	            if (local.getStatus() == BMAP_STATUS_SUCCESS) {
	                if (results.getCurrentNumPois()) {
	                    var p = results.getPoi(0).point;
	                    oResult.moveMarker(p.lng, p.lat);
	                    oCallbacks.reposition(p.lng, p.lat);
	                }
	            } else {
	                alert("找不到搜索的地址，请重新输入");
	            }
	        }
	    };

	    var local = new BMap.LocalSearch(oResult, option);
	    local.search(address);

		//var myGeo = new BMap.Geocoder();//地址解析
        //myGeo.getPoint(address, function (p) {
        //    if (p) {
        //        oResult.moveMarker(p.lng, p.lat);
        //        oCallbacks.reposition(p.lng, p.lat);
        //    } else { alert("找不到搜索的地址，请重新输入"); }
        //});
        //local.search(address);
	}

	/*
	编辑模式下
	可拖动地图改变标注位置
	可右键添加标注
	可模糊搜索地点
	*/
	if(editable)
	{
	
		//默认标注可拖拽，在拖拽结束时返回新坐标
		oDefaultMarker.enableDragging();
		oDefaultMarker.addEventListener("dragend",function(event){
			oDefaultPoint=event.point;
			//拖拽完成时的点坐标
			var position=oDefaultPoint.lng + ',' + oDefaultPoint.lat;
			if($.isFunction(oCallbacks.dragend)) oCallbacks.dragend(event.point.lng,event.point.lat);
		});
		//地图本身可通过右键添加新标注，或移动默认标注
		var MENU = new BMap.ContextMenu(),menuItem;
		if(multiple)//多标注情况下，使用添加标注
			menuItem=new BMap.MenuItem('在此添加标注',function(point){
				oResult.addMarker(point.lng, point.lat);
			});
		else//单标注情况下，使用移动标注
			menuItem=new BMap.MenuItem('在此添加标注',function(point){
				oResult.moveMarker(point.lng, point.lat);
				if($.isFunction(oCallbacks.reposition)) oCallbacks.reposition(point.lng,point.lat);
			});
		MENU.addItem(menuItem);
		oResult.addContextMenu(MENU);
	}
	if(busstops)
	{
		//var oDefaultCircle = new BMap.Circle(oDefaultPoint,1000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});
		//oResult.addOverlay(oDefaultCircle);
		oResult.seekBusStops=function(lng,lat){
			if (!lng || !lat || lng == 0 || lat == 0) return;
			$(".TrafficLines div").empty();
			
			//oDefaultCircle.setCenter(new BMap.Point(lng,lat));
			var local =  new BMap.LocalSearch(
				oResult,
				{
					renderOptions:{
						map: oResult,
						autoViewport: false
					},
					onSearchComplete: function(results){
						// 判断状态是否正确
						if (local.getStatus() == BMAP_STATUS_SUCCESS){
							var allnums=results.getCurrentNumPois(),str=[];
							for(var n=0;n<allnums;n++)
							{
								var result=results.getPoi(n);
								str.push('<p><strong>', result.title ,'</strong>', result.address ,'</p>');
							}
							$(".TrafficLines div").append(str.join(''));
						}
					}
				}
			);  
			//local.searchInBounds("公交车站",bounds); 
			local.searchNearby("公交",new BMap.Point(lng,lat),1000);
		}
	}
	oResult.addClickHandler =function(content,marker,opts){
		marker.addEventListener("click",function(e){
			oResult.openInfo(content,e,opts)}
		);
	}
	oResult.openInfo = function(content,e,opts){
	    var p = e.target;
        var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
        var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象
        oResult.openInfoWindow(infoWindow,point); //开启信息窗口
	}
	oResult.centerAndZoom(oDefaultPoint, 15);
	return oResult;
}
