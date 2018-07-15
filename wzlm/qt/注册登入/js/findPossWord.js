//修改密码提交验证
$(function() {

	/*
	 * 1手机密码，验证码，新密码，确认密码内容不能为空
	 * 2手机号格式正确
	 * 3密码必须控制在6到18而且由数字和英文字符组成
	 * 4:两次输入的密码必须一样
	 */

	$('#formPhoneBtn').click(function(e) {
		var phone = $('#pbone').val();
		var code = $('#code').val();
		var newPassWord = $('#newPassWord').val();
		var confirm = $('#confirm').val() //获取确认密码
		var phoneReg = /^1[3|4|5|7|8][0-9]{9}$/; //验证手机号码
		var regPassword = /^[a-zA-Z0-9]{6,18}$/;
		var bol = true;

		$('.ned').each(function() {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})
		if(bol) {
			//验证手机
			if(!phoneReg.test(phone)) {
				layer.msg('手机格式不正确！');
				$('#pbone').focus();
				bol = false;
				return false;
			}

			//验证密码
			if(!regPassword.test(newPassWord)) {
				layer.msg('密码必须由6-18数字和字母组成！');
				$('#newPassWord').focus();
				bol = false;
				return false;
			}
			if(newPassWord !== confirm) {
				layer.msg('两次输入密码不一致！');
				$('#confirm').focus();
				bol = false;
				return false;
			}
			//验证码
			//验证通过
			$('.myform input').val('');
			//提交数据
			//显示提示恭喜框
			$('.fontPass').show();
			$('.zezhao').show();
		}
		return false;
		e.preventDefault()
	})
	var times = null;
	//获取验证码
	$('#gets').click(function() {
		var bol = true;
		var nums = 60;
		var phoneReg = /^1[3|4|5|7|8][0-9]{9}$/; //验证手机号码
		clearInterval(times);
		if(!$('#pbone').val()) {
			layer.msg('请输入手机号码！');
			$('#pbone').focus();
			bol = false;
			return false;
		}
		if(bol) {
			if(!phoneReg.test($('#pbone').val())) {
				layer.msg('手机格式不正确！');
				$('#pbone').focus();
				bol = false;
				return false;
			}

			times = setInterval(function() {
				nums--;
				if(nums < 0) {
					nums = 60;
					$('#gets').attr('disabled', false);
					$('#gets').css('cursor', 'pointer');
					$('#gets').css('color', '#fff');
					$('#gets').html('获取验证码');
					clearInterval(times);
					return false;
				}

				$('#gets').css('cursor', 'not-allowed');
				$('#gets').css('color', 'red');
				$('#gets').attr('disabled', true);
				$('#gets').html('还剩' + nums + '秒')
				console.log(nums)
			}, 1000)

		}

	})
})
//关闭提示框
$(function() {
	$('.fa-close').click(function() {
		$('.fontPass').hide();
		$('.zezhao').hide();
	})
})