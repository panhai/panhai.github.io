


//选着状态

$(function(){
	$('.chek .input').click(function(){
		$(this).siblings('.tg').html($('.tg img'));
		$(this).parent().siblings('.chek').children('.tg').html('');
	})
	
})
//选着年月
$(function(){
	layui.use('laydate',function() {
		var laydate = layui.laydate;
		//年选择器
		laydate.render({
			elem: '.Year',
			type: 'year',
			value:new Date().getFullYear()
		});
		
	})
	function getStr(a) {
		if(a < 10) {
			return "0" + a;
		} else {
			return "" + a;
		}
	}

	//选着月份
	$(function() {
		$('.month').click(function() {
			$('.month-box').show();
			return false;
		})
		$('.month-box li').click(function() {
			$('.month').val(getStr(parseInt($(this).text())))
			return false;
		})
		$('.qd').click(function() {
			$('.month-box').hide();
		})
		$('body').click(function() {
			$('.month-box').hide();
		})
	})
	//显示当前月份
	$(function(){
		var times = new Date();
		var month = getStr(times.getMonth()+1);
		$('.month').val(month);
	})

})
//点击查看截图  data-caption="加载中" title="加载中" data-src = "layui-v2.2.6/layui-v2.2.6/layui/css/modules/layer/default/loading-2.gif" src="layui-v2.2.6/layui-v2.2.6/layui/css/modules/layer/default/loading-2.gif"

$(function(){
	$('table .look').click(function(){
		$(this).siblings('.mximg').show();
		$(this).siblings('.mximg').click()
		return false;
	})
	$('.mximg').click(function(){
		$('.mximg').show();
		return false;
	})
	$('body').click(function(){
		$('.mximg').hide();
	})
	
})
//图片上传
$(function(){
	imgUpload({
		inputId:'file', //input框id
		imgBox:'imgBox', //图片容器id
		buttonId:'btn', //提交按钮id
		upUrl:'php/imgFile.php',  //提交地址
		data:'file1', //参数名
		num:"1"//上传个数
	})
})
//上传图片  没有删除图片按钮
$(function(){
	$('.jt .inp').click(function(){
//		$(this).css('z-index',0);
	})
	//关闭框
	$('.fa-close').click(function(){
		$('.shouyiBox').hide();
		$('.motai').hide();
	})
	//点击结算收益查看
	$('.look3').click(function(){
		$('.shouyiBox').show();
		$('.motai').show();
		var file = window.document.getElementById('file');
		file.value = ''; //虽然file的value不能设为有字符的值，但是可以设置为空值
		//或者
//		file.outerHTML = file.outerHTML; //重新初始化了file的html
		
		//获取信息
		
	})
	//完成结算
	$('.submit').click(function(e){
		
		$('.shouyiBox').hide();
		$('.motai').hide();
		return false;
		e.preventDefault();
	})
})
$(function(){
	//data-magnify="gallery" data-src="img/tp.png" src="img/tp.png" class="mximg"
	//预览图片
	$('.imgbtn').click(function(){
		var src = $('#imgBox img').attr('src');
		$('#imgBox img').attr('data-magnify','gallery');
		$('#imgBox img').attr('src',src);
		$('#imgBox img').attr('data-src',src);
		
		$('#imgBox img').click();
	})
	//删除图片
	$('.delImg').click(function(){
		$('#imgBox img').remove();
	})
})
//图片放大插件
$(function() {
	options = {
		draggable: true,
		resizable: true,
		movable: true,
		keyboard: true,
		title: true,
		modalWidth: 940, //图片框宽度
		modalHeight: 520,
		fixedContent: true,
		fixedModalSize: false,
		initMaximized: false,
		gapThreshold: 0.02,
		ratioThreshold: 0.1,
		minRatio: 0.1,
		maxRatio: 16,
		headToolbar: [
			'maximize',
			'close'
		],
		footToolbar: [
			'zoomIn',
			'zoomOut',
			'prev',
			'fullscreen',
			'next',
			'actualSize',
			'rotateRight'
		],
		icons: {
			maximize: 'fa fa-window-maximize',
			close: 'fa fa-close',
			zoomIn: 'fa fa-search-plus',
			zoomOut: 'fa fa-search-minus',
			prev: 'fa fa-arrow-left',
			next: 'fa fa-arrow-right',
			fullscreen: 'fa fa-photo',
			actualSize: 'fa fa-arrows-alt',
			rotateLeft: 'fa fa-rotate-left',
			rotateRight: 'fa fa-rotate-right'
		}
	}
	$("img").magnify(options)
})