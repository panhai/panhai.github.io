$(function() {
	var $password = $('.password');
	var $phone = $('.phone');
	var $miss = $('.miss');
	var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
	var miss = '';
	//获取验证码
	var num = 60;
	var times = null;
	var bl = true;
	var boll = true;
	$phone.change(function() {
		if(!reg.test($(this).val())) {
			$('.msg').show();
			$('.msg').children('span').html('手机号码格式不正确，请重新输入');
			$('.phone').css('border', '1px solid #ed4141');
			boll = false;
			return false;
		} else {
			$('.msg').hide();
			$('.phone').css('border', '1px solid #36ab60');
			boll = true;
		}
	})

	$password.change(function() {
		if(miss == '') {
			$('.msg').show();
			$('.msg').children('span').html('您还没有获取验证码，请获取验证码');
			$(this).css('border', '1xp solid #ed4141')
			return false;
		}
		if(miss == $password.val()) {
			$('.msg').hide();
			$(this).css('border', '1px solid #36ab60');
		}
	})

	$miss.on('click', function() {
		clearInterval(times);
		if(bl) {
			//			layer.msg('已发送');
			bl = false;
		}
		$(this).css('cursor', 'not-allowed')
		$(this).attr('disabled', true)
		var _this = this;
		times = setInterval(function() {
			num--;
			if(num < 0) {
				num = 60;
				clearInterval(times);
				$(_this).html('重新获取');
				bl = true;
			} else {
				$(_this).html('还剩' + num + '秒')
			}
		}, 1000)
		$.ajax({
			type: 'POST',
			url: 'https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/img',
			data: '',
			dataType: 'json',
			success: function(data) {
				miss = data.data.phoMa[0];

				console.log(miss)
			}
		})

		return false;
	})

	//
	if(boll) {
		$('.myform').submit(function() {
			var phone = $phone.val()
			var passwords = $password.val();
			//		console.log(phone,passwords)
			if(!phone) {
				$('.msg').show();
				$('.msg').children('span').html('未输入手机号码，请输入');
				$('.phone').css('border', '1px solid #ed4141');
				$('.phone').focus();
				return false;
			}
			if(!passwords) {
				$('.msg').show();
				$('.msg').children('span').html('未输入验证码，请输入');
				$password.css('border', '1px solid #ed4141');
				$password.focus();
				return false;
			}
			if(miss == '') {
				$('.msg').show();
				$('.msg').children('span').html('您还没有获取验证码，请获取验证码');
				return false;
			}
			if(miss != passwords) {
				$('.msg').show();
				$('.msg').children('span').html('输入验证码不正确，请重新输入');
				$password.css('border', '1px solid #ed4141');
				return false;
			} else {
				
			}
			
			return false;

		})
	}

})