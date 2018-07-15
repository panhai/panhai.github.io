//协议勾选状态
var start = $('.checkbox').is(':checked');
var regName = /^[a-zA-Z0-9_-]{4,20}$/; //用户名
var regpassword = /^[a-z0-9_-]{6,20}$/; //密码
var regphone = /^[1][3,4,5,7,8][0-9]{9}$/; //手机
var regId = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; //身份证
var regNumber = /^(-)?\d+(\.\d+)?$/; //全数字
var pattern = /^[\u4e00-\u9fa5]*$/; //只能是中文
var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
var regQQ = /^[0-9]{5,10}$/;



//第一步
$(function() {
	//修改昵称
	var nic = ['等雨停', '那年夏天的回憶錄', '打拼时代今后见高低 ', '羡慕别人不如完美自己i', '一無所有就是拼的理由', '有志者事竟成', '做一个神秘之人', '怒放的理想', '追夢赤子心', '向快乐出发', '理想国度']
	
	var index = Math.floor(Math.random() * 10);
	$('.nicheng').val(nic[index]);

	$('.gai').click(function() {
		$(this).siblings('.nicheng').attr('disabled', false).css('border', '1px solid #999');
		$(this).hide();
	})
	
	//查看密码
	$('.yj').click(function() {
		var type = $(this).siblings('.password').attr('type');
		if(type == 'password') {
			$(this).attr('src', 'img/kyj.png');
			$(this).siblings('.password').attr('type', 'text');
		} else {
			$(this).attr('src', 'img/yj.png');
			$(this).siblings('.password').attr('type', 'password');
		}
	})

	var $memberName = $('.memberName'); //会员名称
	var $password = $('.password');
	var $nicheng = $('.nicheng'); //昵称
	var $phone = $('.phone'); //手机
	var $imgMa = $('.imgMa'); //图片验证码
	var $phoneM = $('.phoneM'); //手机验证码

	var bol = true; //控制表单提交
	var bl = false; //控制手机获取验证码
	$memberName.change(function() {
		var val = $.trim($(this).val());
		if(!regName.test(val)) {
			$(this).siblings('.msg').show(200);
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg').css('color', '#ED4141');
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$(this).siblings('.msg').children('span').html('请输入4-20位字母及数字组合字符');
			bol = false;
		} else {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png')
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
		}
	})
	$password.change(function() {
		var val = $.trim($(this).val());
		if(!regpassword.test(val)) {
			$(this).siblings('.msg').show(200);
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg').css('color', '#ED4141');
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$(this).siblings('.msg').children('span').html('请输入6-20位字符密码');
			bol = false;
		} else {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png')
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
		}
	})

	var phones = 13414486735 //假设是已经注册的号码
	$phone.change(function() {
		var val = $.trim($(this).val());
		if(!regphone.test(val)) {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').css('color', '#ED4141');
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$(this).siblings('.msg').children('span').html('请输入正确的11位数字手机号码');
			bol = false;
			return false;
		} else {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png')
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
		}
		
		if(val == phones) {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').css('color', '#ED4141');
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$(this).siblings('.msg').children('span').html('手机号已注册，请更换，或<a href=""target="_blank" class="goin">立即登录</a');
			bol = false;
			bl = false;
		} else {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png')
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
			bl = true;
		}

	})
	$('.need').focus(function(){
		var placeh = $(this).attr('placeholder')
		$(this).attr('placeholder',' ');
		$(this).blur(function(){
				if(!$(this).val()){
				$(this).attr('placeholder',placeh);
			}
		})
	})
	var imgMa = 'byoe'; //图片验证码假设
	$imgMa.change(function() {
		var val = $.trim($(this).val());
		if(imgMa != val) {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').css('color', '#ED4141');
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$(this).siblings('.msg').children('span').html('验证码输入错误，请重新输入');
			bol = false;
			bl = false;
		} else {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png')
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
			bl = true;
		}
	})
	var phoneM = 123456; //假设是获取的手机验证码
	$phoneM.change(function() {
		var phoneMs = $.trim($(this).val());
		if(phoneMs != phoneM) {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').css('color', '#ED4141');
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$(this).siblings('.msg').children('span').html('请输入正确的短信验证码');
			bol = false;
		} else {
			$(this).siblings('.msg').show(200);
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png')
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
		}
	})

	//获取手机验证码
	$('.getMa').click(function() {
		var phone = $phone.val();
		var imgMa2 = $imgMa.val();

		if(!phone || !regphone.test(phone)) {
			$phone.siblings('.msg').show(200);
			$phone.siblings('.msg').css('color', '#ED4141');
			$phone.focus();
			$phone.css('border', '1px solid #ed4141');
			$phone.siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$phone.siblings('.msg').children('span').html('请输入正确的11位数字的手机号码');
			bol = false;
			return false;
		}
		if(phone == phones) {
			$phone.siblings('.msg').show(200);
			$phone.siblings('.msg').css('color', '#ED4141');
			$phone.focus();
			$phone.css('border', '1px solid #ed4141');
			$phone.siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$phone.siblings('.msg').children('span').html('手机号已注册，请更换，或<a href=""target="_blank" class="goin">立即登录</a');
			bol = false;
			return false;
		}
		if(!imgMa2 || (imgMa2 != imgMa)) {
			$imgMa.siblings('.msg').show(200);
			$imgMa.siblings('.msg').css('color', '#ED4141');
			$imgMa.focus();
			$imgMa.css('border', '1px solid #ed4141');
			$imgMa.siblings('.msg').children('img').attr('src', 'img/bt.jpg')
			$imgMa.siblings('.msg').children('span').html('请输入正确的验证码');
			bol = false;
			return false;
		}

		clearInterval(times);
		var num = 60;
		var times = null;
		var _this = this;
		times = setInterval(function() {
			num--;
			if(num < 0) {
				num = 60;
				clearInterval(times);
				$(_this).attr('disabled', false);
				$(_this).css('cursor', 'pointer');
				$(_this).html('重新获取');
			} else {
				$(_this).html('<span style="color:#999">重新获取</span>(' + num + ')');
			}
		}, 1000)
		$(this).attr('disabled', true);
		$(this).css('cursor', 'not-allowed');
	})

	//点击下一步
	$('.submit').click(function() {

		$('.need').each(function() {
			if(!$(this).val()) {
				$(this).siblings('.msg').show(200);
				$(this).siblings('.msg').css('color', '#ED4141');
				$(this).css('border', '1px solid #ed4141');
				$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg')
				$(this).siblings('.msg').children('span').html('改字段不能为空');
				bol = false;
			}
		})

		if(bol) {
			//是否勾选协议 var start = $('.checkbox').is(':checked');
			if(!$('.checkbox').is(':checked')) {
				$('.checkbox2').attr('checked', false)
				$('.form1').hide();
				$('.form2').show();
				$('.step').attr('src', 'img/step2.png')
			} else {
				$('.checkbox2').attr('checked', true)
				$('.form1').hide();
				$('.form2').show();
				$('.step').attr('src', 'img/step2.png')
			}
		}

	})
})

//第二步
$(function() {
	var $RealName = $('.RealName');
	var $email = $('.email');
	var $qq = $('.qq');
	var $sheng = $('.sheng');
	var $city = $('.city');
	var $address = $('.address');
	var $submit2 = $('.submit2');

	var bol = true;

	$RealName.change(function() {
		var val = $.trim($(this).val());
		if(!pattern.test(val)) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('请输入2-20字中文字符');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else if(val.length < 2 || val.length > 20) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('请输入2-20字中文字符');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg2').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg2').children('span').html('');
			bol = true;
		}
	})

	$email.change(function() {
		var val = $.trim($(this).val());
		if(!regEmail.test(val)) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('请输入正确的邮箱格式');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg2').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg2').children('span').html('');
			bol = true;
		}
	})

	$qq.change(function() {
		var val = $.trim($(this).val());
		if(!regQQ.test(val)) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('请输入正确的QQ格式');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg2').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg2').children('span').html('');
			bol = true;
		}
	})
	$sheng.change(function() {
		var val = $(this).children('option:selected').val();
		var val2 = $city.children('option:selected').val();
		if(!val || !val2) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('该字段不能为空');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #999');
			$city.css('border', '1px solid #999');
			$(this).siblings('.msg2').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg2').children('span').html('');
			bol = true;
		}
	})
	$city.change(function() {
		var val = $(this).children('option:selected').val();
		var val2 = $sheng.children('option:selected').val();
		if(!val || !val2) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('该字段不能为空');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #999');
			$sheng.css('border', '1px solid #999');
			$(this).siblings('.msg2').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg2').children('span').html('');
			bol = true;
		}
	})
	$address.change(function() {
		var val = $.trim($(this).val());
		if(!val) {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #ed4141');
			$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg2').children('span').html('该字段不能为空');
			$(this).siblings('.msg2').css('color', '#ED4141');
			bol = false;
		} else {
			$(this).siblings('.msg2').show();
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg2').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg2').children('span').html('');
			bol = true;
		}
	})

	$submit2.click(function() {
		$('.need2').each(function() {
			var val = $(this).val();
			if(!val) {
				$(this).siblings('.msg2').show();
				$(this).css('border', '1px solid #ed4141');
				$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
				$(this).siblings('.msg2').children('span').html('该字段不能为空');
				$(this).siblings('.msg2').css('color', '#ED4141');
				bol = false;
			}
		})
		$('.sheng,.city').each(function() {
			var val2 = $(this).children('option:selected').val();
			if(!val2) {
				$(this).siblings('.msg2').show();
				$(this).css('border', '1px solid #ed4141');
				$(this).siblings('.msg2').children('img').attr('src', 'img/bt.jpg');
				$(this).siblings('.msg2').children('span').html('该字段不能为空');
				$(this).siblings('.msg2').css('color', '#ED4141');
				bol = false;
			}
		})

		if(bol) {
			//可以进入第三步了
			//判断是否勾选协议
			var strats = $('.checkbox2').is(':checked');
			if(!strats) {
				layer.alert('<div><p style="text-align:center">您未勾选注册协议，请阅读并勾选注册协议</p><p style="text-align:center;padding-top:20px"><span style="color:#ed4141">2</span>秒后自动关闭</p></div>', {
					title: ['<b>提示</b>', 'text-align:center'],
					closeBtn: 0,
					time: 2000,
					btn: false
				}, function(index) {

					layer.close(index)
				})
				return false;
			} else {
				$('.form2').hide();
				$('.form3').show();
				$('img.step').attr('src', 'img/step3.png');
				$('.goover').show();
			}
		}
	})
})

//证件类型切换

$('.shop').click(function() {
	$('.shop').prop('checked', true)
	$('.study').prop('checked', false)
	$('.step3-a').show();
	$('.step3-b').hide();
})
$('.study').click(function() {
	$('.study').prop('checked', true)
	$('.shop').prop('checked', false)
	$('.step3-a').hide();
	$('.step3-b').show();
})

//上传身份证  营业执照
$('.file1').change(function() {
	var filelist = $(this)[0].files;
	var srcUrl = getObjectURL(filelist[0]);
	$(this).siblings('.radioImg').children('img').attr('src', srcUrl)
	//	console.log(srcUrl)
})
//上传合同

var defaults = {
	fileType: ["jpg", "png", "bmp", "jpeg"], // 上传文件的类型
	fileSize: 1024 * 1024 * 10 // 上传文件的大小 10M
};

function validateUp(files) { //控制文件上传类型
	var arrFiles = []; //替换的文件数组
	for(var i = 0, file; file = files[i]; i++) {
		//获取文件上传的后缀名
		var newStr = file.name.split("").reverse().join("");
		if(newStr.split(".")[0] != null) {
			var type = newStr.split(".")[0].split("").reverse().join("");
			console.log(type + "===type===");
			if(jQuery.inArray(type, defaults.fileType) > -1) {
				// 类型符合，可以上传
				if(file.size >= defaults.fileSize) {
					alert(file.size);
					alert('您这个"' + file.name + '"文件大小过大');
				} else {
					// 在这里需要判断当前所有文件中
					arrFiles.push(file);
				}
			} else {
				alert('您这个"' + file.name + '"上传类型不符合');
			}
		} else {
			alert('您这个"' + file.name + '"没有类型, 无法识别');
		}
	}
	return arrFiles;
}

$(function() { //#item-box .item  outerHTML
	var imgSrc = []; //图片路径
	var imgFile = []; //文件流
	var imgName = []; //图片名字
	var $itemBox = $('.item-boxA');
	var html = $('.item-boxA .item').eq(0).clone(true).prop('outerHTML');
	var newhtml = '';

	$('#fileA').change(function() {
		$itemBox.html('');
		imgSrc = [];
		imgName = [];
		imgFile = [];
		var fileImg = document.getElementById('fileA');
		var fileList = fileImg.files;
		fileList = validateUp(fileList);

		for(var i = 0; i < fileList.length; i++) {
			var imgUrl = getObjectURL(fileList[i]);
			imgName.push(fileList[i].name);
			imgSrc.push(imgUrl);
			imgFile.push(fileList[i]);
			var html = '<div class="item"><img src=' + imgSrc[i] + '><span class="delete">删除</span></div>';
			$(html).appendTo($itemBox);
//			console.log(imgSrc[i])
		}
		
	})

	//删除图片
	$('body').on('click', '.item-boxA .delete', function() {
		$(this).parent().remove();
		var index = $(this).index() - 1;
		imgSrc.splice(index, 1);
		imgFile.splice(index, 1);
		imgName.splice(index, 1);
		//		console.log(imgName)
	})

})
//表单2
$(function() { //#item-box .item  outerHTML
	var imgSrc2 = []; //图片路径
	var imgFile2 = []; //文件流
	var imgName2 = []; //图片名字
	var $itemBox2 = $('.item-boxB');

	$('#fileB').change(function() {
		$itemBox2.html('');
		imgSrc2 = [];
		imgName2 = [];
		imgFile2 = [];
		var fileImg2 = document.getElementById('fileB');
		var fileList2 = fileImg2.files;
		fileList2 = validateUp(fileList2);

		for(var i = 0; i < fileList2.length; i++) {
			var imgUrl2 = getObjectURL(fileList2[i]);
			imgName2.push(fileList2[i].name);
			imgSrc2.push(imgUrl2);
			imgFile2.push(fileList2[i]);
			var html2 = '<div class="item"><img src=' + imgSrc2[i] + '><span class="delete">删除</span></div>';
			$(html2).appendTo($itemBox2);
		}
	})

	//删除图片
	$('body').on('click', '.item-boxB .delete', function() {
		$(this).parent().remove();
		var index = $(this).index() - 1;
		imgSrc2.splice(index, 1);
		imgFile2.splice(index, 1);
		imgName2.splice(index, 1);
		//		console.log(imgName2)
	})

})
//合同图片轮播
$(function() {
	//prev  next imgdisplay2
	
	$('.main4').hover(function() {
		$('.prev').fadeIn(300)
		$('.next').fadeIn(300)
	}, function() {
		$('.prev').fadeOut(300)
		$('.next').fadeOut(300)
	})
	
	$('.prev').hover(function() {
		$(this).children('img').attr('src', 'img/prevs.png');
	}, function() {
		$(this).children('img').attr('src', 'img/prevs2.png');
	})
	$('.next').hover(function() {
		$(this).children('img').attr('src', 'img/nexts.png');
	}, function() {
		$(this).children('img').attr('src', 'img/nexts2.png');
	})
	
	//一次走三张宽度  item-boxB 

	
	var $imgboxB = $('.item-boxB');
	var $imgboxA = $('.item-boxA');
	var $prev1 = $('.f3 .prev');
	var $next1 = $('.f3 .next');
	var $prev2 = $('.f4 .prev');
	var $next2 = $('.f4 .next');
	
	var len1 = $imgboxA.children('.item');
	var len2 = $imgboxB.children('.item');
	
//	console.log(len1,len2)
	var num1 = 0;
	var num2 = 0;
	
	$prev1.click(function() {
		if(len1.length<=3){
			return false;
		}else{
			num1++
			if(num1 > Math.floor(len1/3)) {
				num1 = 0;
				$imgboxA.css({left:0})
			} else {
				$imgboxA.stop().animate({
					left: -num1 * 420
				})
			}
		}
//		console.log(num1)
	})
	$next1.click(function() {
		if(len1.length<=3){
			return false;
		}else{
			num1--;
			if(num1 < 0) {
				num1 = Math.floor(len1/3);
				$imgboxA.css({left:0})
			} else {
				$imgboxA.stop().animate({
					left: -num1 * 420
				})
			}
		}
//		console.log(num1)
	})
	$prev2.click(function() {
		if(len2.length<=3){
			return false;
		}else{
			num2++
			if(num2 > Math.floor(len2/3)) {
				num2 = 0;
				$imgboxB.css({left:0})
			} else {
				$imgboxB.stop().animate({
					left: -num2 * 420
				})
			}
		}
//		console.log(num2,len2)
	})
	$next2.click(function() {
		if(len2.length<3){
			return false;
		}else{
			num2--;
			if(num2 < 0) {
				num2 = Math.floor(len2/3);
				$imgboxB.css({left:0})
			} else {
				$imgboxB.stop().animate({
					left: -num2 * 420
				})
			}
		}
	})
	
	
	$('#fileB,#fileA').change(function() {
		console.log($(this).attr('id'))
		if($(this).attr('id')=="fileB"){
			len2 = Math.floor($('.item-boxB .item').length);
		}
		if($(this).attr('id')=="fileA"){
			len1 = Math.floor($('.item-boxA .item').length);
		}
	})
	
})

//提交审核
$(function() {
	var $username = $('.username'); //经营者姓名
	var $certificate = $('.certificate'); //身份证号
	var $school = $('.school') //机构名称
	var $nums = $('.nums'); //证件号码
	
	var $submit3 = $('.submit3');
	var $submit4 = $('.submit4');

	var bol = true; //必须填写
	var a = false;	// 经营者姓名
	var b = false;	// 身份证号
	var c= false;	// 证件号码
	
	

	$username.change(function() {
		var val = $.trim($(this).val());
		
		if(!pattern.test(val)) {
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg').children('span').html('请输入2-20位中文汉字');
			a = false;
			$(this).focus()
			$(this).css('border', '1px solid #ed4141');
//			return false;
		} else {
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg').children('span').html('');
			a = true;
		}
		
	})
	$certificate.change(function() {
		var val = $.trim($(this).val());
		
		if(!regId.test(val)) {
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg').children('span').html('请输入正确的身份证格式字');
			b = false;
			$(this).focus()
			$(this).css('border', '1px solid #ed4141');
			return false;
		} else {
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg').children('span').html('');
			b = true;
		}
	})
	
	$school.change(function(){
		var val = $(this).val();
		if(val){
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg').children('span').html('');
			$(this).css('border', '1px solid #999');
			bol = true;
		}
	})
	//.file-b  .file-a .file-c .zhizhao
	
	$('.zhizhao').change(function(){
		console.log($(this).parent())
		$(this).parent().siblings('.msg').show();
		$(this).parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
		$(this).parent().siblings('.msg').children('span').html("");
	})
	
	$('.file-b').change(function(){
		console.log($(this).parent())
		$(this).parent().siblings('.msg').show();
		$(this).parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
		$(this).parent().siblings('.msg').children('span').html("");
	})
	$('.file-a').change(function(){
		console.log($(this).parent())
		$(this).parent().siblings('.msg').show();
		$(this).parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
		$(this).parent().siblings('.msg').children('span').html("");
	})
	$('.file-c').change(function(){
		console.log($(this).parent())
		$(this).parent().siblings('.msg').show();
		$(this).parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
		$(this).parent().siblings('.msg').children('span').html("");
	})
	
	//regNumber
	$nums.change(function() {
		var val = $.trim($(this).val());
		if(!regNumber.test(val)) {
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$(this).siblings('.msg').children('span').html('证件号码必须为数字');
			c = false;
			$(this).focus()
			$(this).css('border', '1px solid #ed4141');
			return false;
		} else {
			$(this).css('border', '1px solid #999');
			$(this).siblings('.msg').show();
			$(this).siblings('.msg').children('img').attr('src', 'img/zq.png');
			$(this).siblings('.msg').children('span').html('');
			c = true;
		}
	})
	$('.need3').focus(function(){
		var val = $(this).attr('placeholder');
		$(this).attr('placeholder',"");
		$(this).blur(function(){
			$(this).attr('placeholder',val)
		})
		
	})
	function need(clas){
		if(!$(clas+' .file-a').val()){
			$('.file-a').parent().siblings('.msg').show();
			$('.file-a').parent().siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$('.file-a').parent().siblings('.msg').children('span').html('您还没有上传身份证正面，请上传');
			bol = false;
//			return false;
		}else{
			$('.file-a').css('border', '1px solid #36ab60');
			$('.file-a').parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
			$('.file-a').parent().siblings('.msg').children('span').html('');
			bol = true;
		}
		if(!$(clas+' .file-b').val()){
			$('.file-b').parent().siblings('.msg').show();
			$('.file-b').parent().siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$('.file-b').parent().siblings('.msg').children('span').html('您还没有上传身份证反面，请上传');
			bol = false;
//			return false;
		}else{
			bol = true;
			$('.file-b').css('border', '1px solid #36ab60');
			$('.file-b').parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
			$('.file-b').parent().siblings('.msg').children('span').html('');
		}
		if(!$(clas+' .file-c').val()){
			$('.file-c').parent().siblings('.msg').show();
			$('.file-c').parent().siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$('.file-c').parent().siblings('.msg').children('span').html('您还没有上传手执身份证，请上传');
			
			bol = false;
//			return false;
		}else{
			bol = true;
			$('.file-c').css('border', '1px solid #36ab60');
			$('.file-c').parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
			$('.file-c').parent().siblings('.msg').children('span').html('');
		}
		if(!$(clas+' .zhizhao').val()){
			$('.zhizhao').parent().siblings('.msg').show();
			$('.zhizhao').parent().siblings('.msg').children('img').attr('src', 'img/bt.jpg');
			$('.zhizhao').parent().siblings('.msg').children('span').html('您还没有上传营业执照，请上传');
			bol = false;
//			return false;
		}else{
			bol = true;
			$('.zhizhao').css('border', '1px solid #36ab60');
			$('.zhizhao').parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
			$('.zhizhao').parent().siblings('.msg').children('span').html('');
		}
		if(clas=='.form3-a'){
			if(!$('#fileA').val()){
				$('#fileA').parent().siblings('.msg').show();
				$('#fileA').parent().siblings('.msg').children('img').attr('src', 'img/bt.jpg');
				$('#fileA').parent().siblings('.msg').children('span').html('您还没有上传合同，请上传');
				bol = false;
//				return false;
			}else{
				bol = true;
				$('#fileA').css('border', '1px solid #36ab60');
				$('#fileA').parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
				$('#fileA').parent().siblings('.msg').children('span').html('');
			}
		}else{
			if(!$('#fileB').val()){
				$('#fileB').parent().siblings('.msg').show();
				$('#fileB').parent().siblings('.msg').children('img').attr('src', 'img/bt.jpg');
				$('#fileB').parent().siblings('.msg').children('span').html('您还没有上传合同，请上传');
				
				bol = false;
//				return false;
			}else{
				bol = true;
				$('#fileB').css('border', '1px solid #36ab60');
				$('#fileB').parent().siblings('.msg').children('img').attr('src', 'img/zq.png');
				$('#fileB').parent().siblings('.msg').children('span').html('');
			}
		}
		
		$(clas + ' .need3').each(function(){
			var val = $(this).val();
			if(!val){
				$(this).siblings('.msg').show();
				$(this).siblings('.msg').children('img').attr('src', 'img/bt.jpg');
				$(this).siblings('.msg').children('span').html($(this).attr('placeholder'));
				
				$(this).focus();
				$(this).css('border','1px solid #ED4141');
				bol = false;
//				return false;
			}else{
				bol = true;
			}
		})
	}
	
	$submit3.on('click', function() {
		need('.form3-a')
		if(bol&& a && b && c){
			layer.alert('<div><p style="color:#999"><img src="img/66px.png"/>提交成功，管理员会尽快审核，请耐心等待~~</p><p style="text-align:center;padding:10px 0px">现在前往学校中心</p><p style="text-align:center"><img src="img/loade.gif" alt="" /></p></p></div>', {
				title: false,
					closeBtn: 0,
					time: 4000,
					btn: false
				}, function(index) {
				
					
				layer.close(index)
			})
			return false;
		}
		
//		return false;
	})
	$submit4.on('click', function() {
		need('.form3-b')
		
		if(bol&& a && b && c){
			layer.alert('<div><p style="color:#999"><img src="img/66px.png"/>提交成功，管理员会尽快审核，请耐心等待~~</p><p style="text-align:center;padding:10px 0px">现在前往学校中心</p><p style="text-align:center"><img src="img/den.png" alt="" /></p></p></div>', {
				title: false,
					closeBtn: 0,
					time: 4000,
					btn: false
				}, function(index) {
				
				
				layer.close(index)
			})
			return false;
		}
//		return false;
	})
})