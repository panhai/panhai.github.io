$(function() {
	//分页
	var len = 2;
	var index = 0;
	$('.paging a.num').click(function() {
		$(this).addClass('acitve').siblings('a').removeClass('acitve');
		index = $(this).index() - 1;
		console.log(index)
	})
	
//	$('.paging .next').click(function() {
//		index++;
//		if(index > len - 1) {
//			index = len - 1;
//			$(this).hide();
//			$('.priv').show();
//		}
//		$('.paging a').eq(index).addClass('acitve').siblings('a').removeClass('active');
//	})
//	$('.paging .priv').click(function() {
//		index--;
//		if(index < 0) {
//			index = 0;
//			$(this).hide();
//			$('.next').show();
//		}
//		$('.paging a').eq(index).addClass('acitve').siblings('a').removeClass('active');
//	})
})

//查看图片
$(function() {
	var num = 3;
	var len = $('.showM img').length;
	$('.closeimg').click(function() {
		$('.showImg').fadeOut(200);
		$('.zhezhao').fadeOut(200);
	})
	$('.lookimg').click(function() {
		$('.showImg').fadeIn(200);
		$('.zhezhao').fadeIn(200);
	})

	$('.left').click(function() {
		num--;
		if(num < 0) {
			num = len - 1;
		}
		$('.showM img').eq(num).addClass('show').siblings('img').removeClass('show');
	})
	$('.right').click(function() {
		num++;
		if(num > len - 1) {
			num = 0;
		}
		$('.showM img').eq(num).addClass('show').siblings('img').removeClass('show');
	})
})

//查看地址地图
$(function() {
	var longtitude = 0;
	var latitude = 0;
	//获取地址

	function GetPostion() {
		//通过百度获取经纬度
		var address = "广州市天河区五山路二楼 ";
		var url = "http://api.map.baidu.com/geocoder/v2/?address=" + address + "&output=json&ak=FG7wxr1VUj0k2NwoO3yXzymd&callback=?";
		$.getJSON(url, function(data) {
			longtitude = data.result.location.lng;
			latitude = data.result.location.lat;
//			console.log(longtitude,latitude)
		});

		// 创建地图实例 
		var map = new BMap.Map("map");
		// 创建点坐标 
		var point = new BMap.Point(113.35263211514224, 23.150293975287784);
		// 初始化地图，设置中心点坐标和地图级别
		map.centerAndZoom(point, 15);
		//添加控件
		map.centerAndZoom(new BMap.Point(113.35263211514224, 23.150293975287784), 11);
		map.addControl(new BMap.NavigationControl());
		//添加标注
		var marker = new BMap.Marker(point); // 创建标注    
		map.addOverlay(marker); // 将标注添加到地图中
		console.log(latitude)
	}
	GetPostion()
})
//关闭地图
$('.closeMap').click(function() {
	$('#container').fadeOut(300);
	$('.zhezhao').fadeOut(300);
})
//打开地图
$('.lookaddress').click(function() {
	$('#container').fadeIn(300);
	$('.zhezhao').fadeIn(300);
})


