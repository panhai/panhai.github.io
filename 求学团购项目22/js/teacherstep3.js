/*
 * 步骤3
 */

//图片上传 
/**   
 * 从 file 域获取 本地图片 url   
 */
function getFileUrl(sourceId) {
	var url;
	if(navigator.userAgent.indexOf("MSIE") >= 1) { // IE   
		url = document.getElementById(sourceId).value;
	} else if(navigator.userAgent.indexOf("Firefox") > 0) { // Firefox   
		url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));
	} else if(navigator.userAgent.indexOf("Chrome") > 0) { // Chrome  
		url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));
	}
	return url;
}

/**   
 * 将本地图片 显示到浏览器上   
 */
function preImg(sourceId, targetId) {
	var url = getFileUrl(sourceId);
	var imgPre = document.getElementById(targetId);
	imgPre.src = url;
}

/* 方法图片 */
function scaleBig() {
	var oldimg = document.getElementById("imgPre");
	var bigimg = document.getElementById("toBigImg");
	bigimg.src = oldimg.src;
}

$(function() {
	//身份证上传 正面
	/*imgUpload({
		inputId: 'file', //input框id
		imgBox: 'imgBox', //图片容器id
		buttonId: 'btn', //提交按钮id
		upUrl: 'php/imgFile.php', //提交地址
		data: 'file1', //参数名
		num: 3 //上传个数
	})
	 */
	//正面
	$('#file').on("change", function() {
		preImg(this.id, 'imgPre1'); //input元素id , img Id 
		//改变最近显示图片的data-src 属性
		var urls = getFileUrl(this.id); //获取本地图地址
		$(this).parent().siblings('.imgbox').children('img').attr('data-src', urls);
	})

	//反面
	$('#file1').on("change", function() {
		preImg(this.id, 'imgPre2'); //input元素id , img Id 
		var urls = getFileUrl(this.id); //获取本地图地址
		$(this).parent().siblings('.imgbox').children('img').attr('data-src', urls);
	})
	//双手拿证件
	$('#file2').on("change", function() {
		preImg(this.id, 'imgPre3'); //input元素id , img Id 
		var urls = getFileUrl(this.id); //获取本地图地址
		$(this).parent().siblings('.imgbox').children('img').attr('data-src', urls);
	})

	//办学许可证
	$('#file3').on('change', function() {
		preImg(this.id, 'imgPre4'); //input元素id , img Id 
		var urls = getFileUrl(this.id); //获取本地图地址
		$(this).parent().siblings('.imgbox').children('img').attr('data-src', urls);
	})

	//上传合同
	idNum = 3; //图片id
	var imgList = "<li><span class='delete'>删除</span><img data-magnify ='gallery'  src='img/hetong1.jpg' /></li>"; // 获取li
	$('body').on('change', '#filehettong', function() {
		idNum++;
		var urls = getFileUrl(this.id); //获取本地图地址
		var imgLists = $(imgList);
		imgLists.children('img').attr('src', urls);
		imgLists.children('img').attr('id', 'swiperImg' + idNum);
		imgLists.children('img').attr('data-src', urls);
		imgLists.appendTo($('.swiperImgBox'));
		preImg(this.id, 'swiperImg' + idNum); //input元素id , img Id 
	})

	$('.btn').click(function() {
		console.log($(".myform").serialize());
	})

	//点击删除图片
	$('body').on('click', 'span.delete', function() {
		$(this).parent().remove();
	})

})

//合同上传轮播图
$(function() {

	var num = 3; //显示的张数
	var index = 0; //初始值
	var step = $('.swiperbox li').outerWidth() + 15; //合同图片的宽度 (轮播一步移动的距离)

	console.log(step);

	function next() {
		var len = $('.swiperbox li').length; //合同图片张数
		index++;
		if(index > len - num) {
			index = 0;
			$('.swiperImgBox').stop().animate({
				left: 0
			});
		} else {
			$('.swiperImgBox').stop().animate({
				left: '+=' + (-step)
			})
		}

	}

	function prev() {
		var len = $('.swiperbox li').length; //合同图片张数
		index--;
		if(index < num) {
			index = 0;
			$('.swiperImgBox').stop().animate({
				left: 0
			})
		} else {
			$('.swiperImgBox').stop().animate({
				left: '+=' + step
			})
		}
	}

	$('.swiperbox').hover(function() {
		$('.next').stop().animate({
			left: 0
		})
		$('.prev').stop().animate({
			right: 0
		})
		$('span.delete').stop().fadeIn(300);
	}, function() {
		$('.next').stop().animate({
			left: -34
		})
		$('.prev').stop().animate({
			right: -34
		})
		$('span.delete').stop().fadeOut(300);
	});

	$('.next').click(function() {
		next();
	})
	$('.prev').click(function() {
		prev();
	})
})

//启用图片预览插件
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
	//点击显示当前的图片
	$('[data-magnify=gallery]').magnify(options);

})
//点击提交审核

$(function() {
	var bol = true;
	var regName = /^[\u4e00-\u9fa5]{2,10}$/; //验证姓名
	var regID = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; //身份证
	var regnum = /^[0-9]*$/; //全部数字

	$('button.submit').click(function() {
		//必须填写
		$('.need').each(function() {
			var val = $.trim($(this).val());
			if(!val) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})

		if(bol) {
			$('#alert').show();
			layer.msg("提交成功，管理员会尽快审核，请耐心等待<br><br><div style='text-align:center'>正在前往学校中心<br><i style='font-size:24px' class='fa fa-spinner'></i></div>", {
				icon: 1,
				title: "",
				closeBtn: 0,
				time: 3500
			}, function(index) {
				//do something  
				$('#alert').hide();
				layer.close(index);
			});

			//			$('#myform').submit();
		}
		return false;
	})
	//验证姓名 4-20位中文
	$('#username').blur(function() {
		var username = $.trim($('#username').val()); //中文姓名
		if(!regName.test(username)) {
			layer.tips('请输入中文名', '#username', {
				tips: 2
			});
			bol = false;
		} else {
			bol = true;
			layer.tips('输入成功', '#username', {
				tips: 2
			})
		}
	})

	//身份证
	$('#IdCard').blur(function() {
		var IdCard = $.trim($('#IdCard').val()); //身份证
		if(!regID.test(IdCard)) {
			layer.tips('请填写正确的身份证格式', '#IdCard', {
				tips: 2
			})
			bol = false;
		} else {
			bol = true;
			layer.tips('输入成功', '#IdCard', {
				tips: 2
			})
		}
	})
	//全部为数字
	$('#licenseNumber').blur(function() {
		var licenseNumber = $.trim($('#licenseNumber').val()); //证件号码
		if(!regnum.test(licenseNumber)) {
			layer.tips('请输入数字证件号码', '#licenseNumber', {
				tips: 2
			})
			bol = false;
		} else {
			bol = true;
			layer.tips('输入成功', '#licenseNumber', {
				tips: 2
			})
		}
	})

})
//取消enter回车默认提交事件
$(function() {
	var myform = document.getElementById("myform");
	myform.onkeypress = function(ev) {
		var ev = window.event || ev;
		if(ev.keyCode == 13 || ev.which == 13) {
			return false;
		}
	}
})