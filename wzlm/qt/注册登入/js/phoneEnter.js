layui.use('element', function() {
	var element = layui.element;

	//…
});
layui.use('layer', function() {
	var layer = layui.layer;
	var $ = layui.jquery;
});

/*手机登入验证
 * 手机 ，验证码必须填写
 * 2，手机号码格式验证
 * 3 验证码输入正确
 */
$(function() {
	$('#phoneBtn').click(function() {
		var phone = $('#phone').val();
		var phonetest = $('#phonetest').val();
		var regPhone = /^1[34578]\d{9}$/;
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
			//判断手机号码
			if(!regPhone.test(phone)) {
				layer.msg('请输入正确的手机格式！');
				$('#phone').focus();
				bol = false;
				return false;
			}
			//判断验证码
			
			layer.msg('登录成功！');
			$('input').val('');
		}
		return false;
	})
	//获取验证码
	var num = 60;
	var timess = 0;
	$('.get').click(function() {
		clearInterval(timess)
		bol = true;
		var regPhone = /^1[34578]\d{9}$/;
		if(!$('#phone').val()) {
			layer.msg('请写上手机号码！');
			$('#phone').focus();
			bol = false;
			return false;
		}
		if(!regPhone.test($('#phone').val())) {
			layer.msg('手机号码格式不正确！');
			$('#phone').focus();
			bol = false;
			return false;
		}
		if(bol) {
			timess = setInterval(function() {
				num--;
				if(num < 0) {
					num = 60;
					clearInterval(timess);
					$('.get').html('获取验证码');
					$('.get').css('color', '#FFF');
					$('#gets').attr('disabled', false);
					$('.gets').css('cursor', 'pointer');
					return false;
				}
				$('#gets').attr('disabled', true);
				$('.get').html('还剩' + num + '秒')
				$('.get').css('color', 'red');
				$('.get').css('cursor', 'not-allowed');

			}, 1000)
		}

	})
})

/*
 * 电脑登入验证
 * 1用户名，密码，验证码必须填写
 * 2用户名（6-25字符，不可以含有非法字符，）
 * 
 * 3密码必须为6-18位数字和字符组成
 * 4
 */
$(function() {

	//获取字符串长度
	function getLength(str) {
		return str.replace(/[^\x00-xff]/g, 'xx').length;
	}

	$('#PCBtn').click(function() {
		var regName = /[^\w\u4e00-\u9fa5]/g; //数字，字母（不分大小写），汉字，下划线。
		var regPassword = /^[a-zA-Z0-9]{6,18}$/; //6-18个字母或数字组成
		var usename = $('#usename').val();
		var passwords = $('#password').val();
		var code = $('#code').val();
		var bol = true;
		$('.need').each(function() {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})
		if(bol) {
			//用户名
			if(!regPassword.test(usename)) {
				layer.msg('用户名必须是数字，字母，汉字，下划线组成！');
				$('#usename').focus();
				bol = false;
				return false;
			}
			if(getLength(usename) < 5 || getLength(usename) > 25) {
				layer.msg('用户名长度为5-25之间！');
				$('#usename').focus();
				bol = false;
				return false;
			}
			//密码
			if(!regPassword.test(passwords)) {
				layer.msg('密码必须是6-18个字母或数字组成！');
				$('#password').focus();
				bol = false;
				return false;
			}

			//验证码

			layer.msg('登入成功！');
			$('input').val('');
		}

		return false;
	})
})
//补充tab点击
$(function(){
	$('.layui-tab-title li').click(function(){
		var width = $(this).width()+30;
		var index = $(this).index();
		$('.line .move').animate({left:(index*width+40)},100);
	})
})
