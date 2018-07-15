//选着类型
$(function() {
	$('.radio1').click(function() {
		$(this).siblings('.tg').children('.cimg').addClass('show');
		$('.radio1').not(this).siblings('.tg').children('.cimg').removeClass('show');
	})
	$('.radio2').click(function() {
		$(this).siblings('.tg').children('.cimg').addClass('show');
		$('.radio2').not(this).siblings('.tg').children('.cimg').removeClass('show');
	})
})

//选图片
$('#file').change(function(){
	//file设置层级低于img
	$(this).css("z-index",-1);

	var filesList = $(this)[0].files;
	
	for(var i=0;i<filesList.length;i++){
//		console.log(filesList[i]);
	}
	
})


//图片上传
$(function() {
	imgUpload({
		inputId: 'file', //input框id
		imgBox: 'imgBox', //图片容器id
		buttonId: 'btn', //提交按钮id
		upUrl: 'php/imgFile.php', //提交地址
		data: 'file1', //参数名
		num: 3 //上传个数
	})
})

$(function() {
	//显示图片的尺寸，
	$('.inp-c').click(function() {
		//获取图片宽高
		if($('.imgbox img').width()) {
			var width = $('.imgbox img').width();
			var height = $('.imgbox img').height();
			var cc = width + 'x' + height;
			$('.inp-c').val(cc);
		}
	})
})
//点击预览
$(function() {
	$('.YL').click(function() {
		$('.imgbox img').click();
	})
})
//点击删除图片
$(function() {
	$('.delImg').click(function() {
		$('#imgBox').empty();
		//file设置层级高于img
		$("#file").css("z-index",3);
		
	})
})

//选着日期
layui.use('laydate', function() {
	var laydate = layui.laydate;
	//年选择器
	laydate.render({
		elem: '#time',
		type: 'datetime'
	});

})
layui.use('layer', function() {
	var layer = layui.layer;
	

})

//选着广告主
$(function() {
	$('.inp-z').click(function() {
		$('.ggz').slideDown();
		return false;
	})
	$('.ggz li').click(function() {
		$('.inp-z').val($(this).text())
	})
	$('body').click(function() {
		$('.ggz').slideUp();
	})
})
//确定添加
$(function() {

	$('.fobtn').click(function() {
		var bol = true;
		var regUrl = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		var weburl = $('.weburl').val();
		$('.inp').each(function() {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})

		if(!regUrl.test(weburl)) {
			layer.msg('请输入正确的链接地址！');
			$('.weburl').focus();
			bol = false;
			return false;
		}
		
		if(bol) {

			layer.msg('添加成功！');
			return false;
		}

		return false;
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
		modalWidth: 540, //图片框宽度
		modalHeight: 320,
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