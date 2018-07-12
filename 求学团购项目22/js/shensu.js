//计算字符长度
function getByteLen(val) {
	var len = 0;
	for(var i = 0; i < val.length; i++) {
		var a = val.charAt(i);
		if(a.match(/[^\x00-\xff]/ig) != null) {
			len += 2;
		} else {
			len += 1;
		}
	}
	return len;
}

//选者图片
function imgUpload(obj) {
	var oInput = '#' + obj.inputId;
	var imgBox = '#' + obj.imgBox;
	$(oInput).on("change", function() {
		var fileImg = $(oInput)[0];
		var fileList = fileImg.files;
		for(var i = 0; i < fileList.length; i++) {
			var imgSrcI = getObjectURL(fileList[i]);
			imgName.push(fileList[i].name);
			imgSrc.push(imgSrcI);
			imgFile.push(fileList[i]);
		}
		addNewContent(imgBox);
	})

}
//图片预览路径
function getObjectURL(file) {
	var url = null;
	if(window.createObjectURL != undefined) { // basic
		url = window.createObjectURL(file);
	} else if(window.URL != undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file);
	} else if(window.webkitURL != undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file);
	}
	return url;
}

//限制图片个数
function limitNum(num) {
	if(!num) {
		return true;
	} else if(imgFile.length > num) {
		return false;
	} else {
		return true;
	}
}

//图片展示
function addNewContent(obj) {
	$(imgBox).html("");
	for(var a = 0; a < imgSrc.length; a++) {
		var oldBox = $(obj).html();
		$(obj).html(oldBox + '<div class="imgContainer"><img title=' + imgName[a] + ' alt=' + imgName[a] + ' src=' + imgSrc[a] + ' onclick="imgDisplay(this)"></div>');
	}
}
//删除
function removeImg() {
	imgSrc.splice(index, 1);
	imgFile.splice(index, 1);
}

$(function() { //图片选着 
	//var imgSrcI = getObjectURL(fileList[i]);
	var imgSrc = []; //存储图片地址  
	var imgFile = []; //文件流
	var imgName = []; //图片名字
	var imghtml = $('.item').eq(0).clone(true).prop('outerHTML');
	$('body').on('change', '#file', function() { //文件选着
		imgSrc = [];
		var fileImg = $(this)[0]; //获取file demo对象 var imgSrcI = getObjectURL(fileList[i]);
		var fileList = fileImg.files; //获取属性信息
		for(var i = 0; i < fileList.length; i++) {
			var imgSrcI = getObjectURL(fileList[i]);
			imgSrc.push(imgSrcI) //把每个对象的图片地址存到数组
			imgFile.push(fileList[i]); //把文件数据存到数组
			imgName.push(fileList[i].name);
		}
		if(imgSrc.length > 5) {
			alert('上传图片不可以超过5张');
			imgSrc.length = 0;
			return false;
		}
		//把原来的站位图片删除        
											
		if($('.item')) { //判断是否有上传来的图片  image-box
			$('.item').remove();
			for(var i = 0; i < imgSrc.length; i++) {
				//插入到页面盒子
				var html = '<div class="item"><img src=' + imgSrc[i] + ' class="cl"><div class="cuowu"><span><img src="img/cuowu.png"/></span></div></div>'
				
				$(html).insertBefore($('.tianjia'))
//				console.log(imgSrc[i])
			}
		} else {
			
		}
		//		console.log(imgName)
	})
	//删除图片
	$('body').on('click', '.cuowu span', function() {
		$(this).parent().parent().remove();
		var index = $(this).index();
		imgSrc.splice(0, 1);
		imgFile.splice(0, 1);
		imgName.splice(index, 1);
	})
	//获取字符长度 一个汉字算2字节
	function getByteLen(val) {
		var len = 0;
		for(var i = 0; i < val.length; i++) {
			var a = val.charAt(i);
			if(a.match(/[^\x00-\xff]/ig) != null) { //\x00-\xff→GBK双字节编码范围
				len += 2;
			} else {
				len += 1;
			}
		}
		return len;
	}
	
	//计算申诉描述汉字数量
	var num = 0;
	$('.textarea').keyup(function() {
		var leng = getByteLen($(this).val());
		num = leng/2;
		
		$('.font-num .num').html(num);
		
		if(num>1000){
			layer.msg('您输入不可以超过1000个汉字');
		}
	})
	
	//点击提交诉求
	$('.form-btn .submit').on('click', function() {
		//检测必填选项 全部是必填
		//不可以超过1000汉字 2000字符     不可以超过5张图   

		var bol = true;

		$('inpu').each(function() {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})
		if(!$('textarea').val()) {
			layer.msg('请如实描述您的问题..');
			$('textarea').focus();
			bol = false;
			return false;
		}
		//判断图是否超出5张
		if(imgSrc.length > 5) {
			layer.msg('图片超出数量！');
			bol = false;
			return false;
		}
		//判断汉字超出1000
		if(num > 1000) {
			layer.msg('你描述不可以超过1000个汉字');
			bol=false;
			$('textarea').focus();
			return false;
		}
		if(!$('.phon').val()){
			layer.msg('请输入联系方式');
			bol=false;
			$('.phon').focus();
			return false;
		}
		if(imgSrc.length==0){
			layer.msg('请上传凭证');
			bol=false;
			return false;
		}
		if(bol) {
			//提交
//			alert('提交')
		}
		
		console.log($('#file').val())

//		return false;
	})

})