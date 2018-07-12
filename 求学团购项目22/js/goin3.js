$(function() {

	var nicheng = ['jack', '狂傲与生俱来', '同游生死', '持刀走四方']; //昵称
	var name = '';
	var regphone = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
	var $uaername = $('.uaername');
	var $phone = $('.phone');
	var $phoneM = $('.phoneM');
	var Submit = $('.submit');
	var bol = true; //控制登录
	var boll = true; //控制获取动态码
	var $phoneM = $('.phoneM'); //验证码  
	var $msg = $('.msg');
	
	var ma = '';

	if(Math.random() > 0.6) {
		name = nicheng[0];
	} else if(Math.random() > 0.3) {
		name = nicheng[1];
	} else if(Math.random() > 0.5) {
		name = nicheng[2];
	} else {
		name = nicheng[3];
	}
	
	$('.uaername').val(name)
	
	$phone.change(function() {
		if(!regphone.test($(this).val())) {
			$msg.show();
			$msg.children('span').html('手机号码格式不正确，请重新输入');
			$(this).css('border', '1px solid #ed4141');
			$(this).focus();
			bol = false;
			boll = false;
			return false;
		} else {
			bol = true;
			boll = true;
			$msg.hide();
			$(this).css('border', '1px solid #36ab60');
		}
	})
	
	//获取验证码
	var num = 60;
	var times = null;

	if(boll) {
		$('.getMa').on('click', function() {
			clearInterval(times);
			var _this = this;
			var phone = $phone.val();
			if(!phone){
				$msg.show();
				$msg.children('span').html('未输入手机号码，请输入');
				$phone.css('border', '1px solid #ed4141');
				$phone.focus();
				return false;
			}
			if(!regphone.test(phone)){
				$msg.show();
				$msg.children('span').html('手机号码格式不正确，请重新输入');
				$phone.css('border', '1px solid #ed4141');
				$phone.focus();
				return false;
			}
			times = setInterval(function() {
				num--;
				if(num < 0) {
					num = 60;
					clearInterval(times);
					$(_this).attr('disabled', false);
					$(_this).css('cursor', 'pointer');
					$(_this).html('重新获取');
				} else {
					$(_this).html('已发送，还剩' + num + '秒')
				}
			}, 1000)
			
			$(this).attr('disabled', true);
			$(this).css('cursor', 'not-allowed');
			
			$.ajax({
				type: 'POST',
				url: 'https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/img',
				data: '',
				dataType: 'json',
				success: function(data) {
					ma = data.data.phoMa[0];

					console.log(ma)
				}
			})
		})
	}

	if(bol) {
		$('.form').submit(function() {
			var phone = $phone.val();
			var phoneM = $phoneM.val();

			if(!phone) {
				$msg.show();
				$msg.children('span').html('未输入手机号，请输入');
				$phone.css('border', '1px solid #ed4141');
				$phone.focus();
				return false;
			}
			if(!phoneM) {
				$msg.show();
				$msg.children('span').html('未输入验证码，请输入');
				$phoneM.focus();
				$phoneM.css('border', '1px solid #ed4141');
				return false;
			}
			if(ma==''){
				$msg.show();
				$msg.children('span').html('您还没有获取验证码，请获取验证码');
				$phoneM.focus();
				$phoneM.css('border', '1px solid #ed4141');
				return false;
			}
			if(ma!=phoneM){
				$msg.show();
				$msg.children('span').html('验证码输入错误，请重新输入');
				$phoneM.focus();
				$phoneM.css('border', '1px solid #ed4141');
				return false;
			}
			
			alert('登录成功');
			$('input').css('border','1px solid #999');
			
			
			return false;
		})

	}

})