$(function() {
	var $phone = $('.phone');
	var password2 = $('.password');
	var $phoneM = $('.phoneM');
	var $submit = $('.submit');
	var $error = $('.error');

	var phone = '';
	var passwords = '';
	var phoneM = '';

	var bol = false;
	var bol2 = false;
	var bol3 = false;
//	console.log($('.form').serialize())

	$('.phone,.password,.phoneM').change(function() {
		$(this).css('border', '1px solid #999');
	})

	//登录
	$('.form').submit(function() {
		
		
		phone = $.trim($phone.val());
		passwords = $.trim($('.password').val());
		phoneM = $.trim($('.phoneM').val());
		console.log(passwords)
		
		if(!$.trim($phone.val())) {
			$error.show();
			$error.children('span').html('未输入用户名，请输入');
			$phone.focus();
			$phone.css('border', '1px solid #ed4141');
			return false;
		} else if(!password2.val()) {
			$error.show();
			$error.children('span').html('未输入密码，请输入');
			password2.focus();
			password2.css('border', '1px solid #ed4141');
			return false;
		} else if(!$('.phoneM').val()) {
			$error.show();
			$error.children('span').html('未输入验证码，请输入');
			$('.phoneM').focus();
			$('.phoneM').css('border', '1px solid #ed4141');
			return false;
		}else{
			$error.hide()
		}
		if(phoneM==5769){
			bol3 = true;
		}
		
		//ajax
			
			$.ajax({
				type: "post",
				url: "https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/img",
				data: $('.form').serialize(),
				async: true,
				dataType: 'json',
				success: function(data) {
					var data = data.data;
					var newNames = data.usename;
					var newPass = data.passwor;
					
					console.log(newNames,newPass)
					
					for(var i=0;i<newNames.length;i++){
						if(phone==newNames[i]){
							bol = true;
						}
					}
					for(var i=0;i<newPass.length;i++){
						if(passwords==newPass[i]){
							bol2 = true;
						}
					}
					if(phoneM=='5769'){
						bol3 = true;
					}
					console.log(bol,bol2,phoneM)
					
					if(!bol3){
						$error.show();
						$error.children('span').html('验证码输入错误，请重新输入');
						$phoneM.focus();
						$phoneM.css('border', '1px solid #ed4141');
						return false;
					}
					if(!bol || !bol2) {
						$error.show();
						$error.children('span').html('<span>账号或密码错误，请重新输入，或者<a href="" class="miss">忘记密码</a></span>');
						$phone.focus();
						$phone.css('border', '1px solid #ed4141');
						return false;
					}else{
						alert('登录成功')
						$('.phone,.password,.phoneM').each(function() {
							$(this).css('border', '1px solid #999');
						})
					}
					
					$error.hide();
				}
			});
			
		return false;
	})

})