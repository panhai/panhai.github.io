// 是否同意协议，勾选
$(document).ready(function() {
	$('.ag').click(function() {
		if($('.ag img').css('display') != 'none') {
			$('.ag img').hide()
		} else {
			$('.ag img').show()
		}
	})
})

//提交初步验证 
/*
 * 1 全部选项必须填写
 * 2 密码和确认密码必须相同
 * 3 手机需要验证
 * 4 必须添加验证码
 * 5 必须勾选同意协议才能提交
 * 
 */
$(function() {

	//获取字符长度
	function getLength(str) {
		return str.replace(/[^\x00-xff]/g, 'xx').length;
	}

	$('.myForm .btn').click(function(e) {
		/*
		 * 1获取用户名
		 * 2获取密码
		 * 3获取确认的密码
		 * 4获取手机
		 * 5获取验证码
		 * 6获取勾选
		 * 
		 */
		var regUserName = /[^\w\u4e00-\u9fa5]/g; //数字，字母（不分大小写），汉字，下划线。
		var phoneReg = /^1[3|4|5|7|8][0-9]{9}$/; //验证手机号码
		var regPassWorld = /^(?![^a-zA-Z]+$)(?!\D+$)/; //必须为数字和字母组成

		var usernames = $('#usename').val();
		var passwords = $('#password').val();
		var passwords2 = $('#password2').val();
		var phone = $('#phone').val();
		var identifyingCode = $('#code').val(); //验证码
		var agree = $('.ag img').css('display'); //是否同意

		console.log(agree)

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
			//验证手机
			if(!phoneReg.test(phone)) {
				layer.msg('手机格式不正确！');
				$('#phone').focus();
				return false;
			}
			//验证密码
			if(!regPassWorld.test(passwords)) {
				layer.msg('密码必须由字母和数字,字符组成！');
				$('#password').focus();
				return false;
			}
			if(passwords.length < 6 || passwords.length > 25) {
				layer.msg('密码长度在6-25之间！');
				$('#password').focus();
				return false;
			}
			if(passwords.length != passwords2.length) {
				layer.msg('两次输入密码不一致！');
				$('#password2').focus();
				return false;
			}

			//验证用户名
			if(regUserName.test(usernames)) {
				layer.msg('用户名必须由数字，字母，汉字，下划线组成！');
				$('#usename').focus();
				return false;
			}
			if(getLength(usernames) < 5 || getLength(usernames) > 25) {
				layer.msg('用户名长度在5-25字符！');
				$('#usename').focus();
				return false;
			}
			//验验证码

			//判断是否同意协议
			if(agree == 'none') {
				layer.msg('请阅读协议并接受协议！');
				return false;
			}
			
			$('.preimg img.one').hide();
			$('.preimg img.two').hide();
			$('.preimg img.three').hide();
			layer.msg('注册成功！')
			$('.myForm input').val('');
		}
		//					
		return false; //阻止默认跳转
	})

	//获取验证码
	var times = 60;
	var intimes = 0;
	$('#get').click(function() {
		var bl = true;
		clearInterval(intimes);
		var phoneReg = /^1[3|4|5|7|8][0-9]{9}$/; //验证手机号码
		if(!$('#phone').val()) {
			layer.msg('请输入手机号！');
			$('#phone').focus();
			bl = false;
			return false;
		}
		if(!phoneReg.test($('#phone').val())) {
			layer.msg('请输入正确的手机号！');
			$('#phone').focus();
			bl = false;
			return false;
		}

		if(bl) {
			intimes = setInterval(function() {
				times--;
				if(times < 0) {
					times = 60;
					clearInterval(intimes);
					$('#get').attr('disabled', false);
					$('#get').css('cursor', 'pointer');
					$('#get').css('color', '#fff');
					$('#get span').html('免费获取验证码');
					return false;
				}
				$('#get').css('cursor', 'not-allowed');
				$('#get').css('color', '#FE3F4C');
				$('#get').attr('disabled', true);
				$('#get span').html('还剩' + times + '秒！');
			}, 1000)
		}

	})
})
//监听密码强度
$(function(){
	//全部数字--弱
	//字母数字组合中等
	//字符，字母，数字一起--强 6位数以上
	
	//当鼠标离开的时候监听
	// password
	
	$('#password').keyup(function(){
		var passwords = $('#password').val();
		var regnum = /^[0-9]*$/;
		if(passwords.length < 5){
			$('.preimg img.one').hide();
			$('.preimg img.two').hide();
			$('.preimg img.three').hide();
		}
		if(regnum.test(passwords) && passwords.length > 6){
			$('.preimg img.three').show();
		}
		if(!regnum.test(passwords) && passwords.length > 6){
			$('.preimg img.two').show();
			$('.preimg img.one').hide();
			$('.preimg img.three').hide();
		}
		if(!regnum.test(passwords) && passwords.length>=9){
			$('.preimg img.two').hide();
			$('.preimg img.three').hide();
			$('.preimg img.one').show();
		}
	})
	
	
})
