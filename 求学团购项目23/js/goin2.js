$(function(){
	var $phone = $('.phone');
	var $password = $('.password');
	var $submit = $('.submit');
	var $error = $('.error');
	
	var bol = false;
	var username = 'jack';//假设这是存在的用户名
	var usepassword = '123456';//假设是密码
	
	//1
	$phone.change(function(){
		var val = $.trim($(this).val());
		if(val){
			$(this).css('border','1px solid #999')
		}
	})
	$password.change(function(){
		var val = $.trim($(this).val());
		if(val){
			$(this).css('border','1px solid #999')
		}
	})
	
	$('input').each(function(){
		var val = $(this).attr('placeholder');
		$(this).focus(function(){
			$(this).attr('placeholder','');
			$(this).blur(function(){
				$(this).attr('placeholder',val)
			})
		})
	})
	
	//登录  
	$submit.on('click',function(){
		if(!$.trim($phone.val())){
			$error.show();
			$error.children('span').html('未输入帐号，请输入');
			$phone.focus();
			$phone.css('border','1px solid #ed4141');
			bol = false;
			return false;
		}
		
		if(!$password.val()){
			$error.show();
			$error.children('span').html('未输入密码，请输入');
			$password.focus();
			$password.css('border','1px solid #ed4141');
			bol = false;
			return false;
		}
		
		if($.trim($phone.val())!=username){
			$error.show();
			$error.children('span').html('<span>账号或密码错误，请重新输入，或者<a href="" class="miss">忘记密码</a></span>');
			$phone.focus();
			$phone.css('border','1px solid #ed4141');
			bol = false;
			return false;
		}else if($.trim($phone.val())==username){
			bol = true;
			$error.hide();
		}
		
		if($.trim($password.val())!=usepassword){
			$error.show();
			$error.children('span').html('<span>账号或密码错误，请重新输入，或者<a href="" class="miss">忘记密码</a></span>');
			$password.focus();
			$password.css('border','1px solid #ed4141');
			bol = false;
			return false;
		}else if($.trim($password.val())==usepassword){
			bol = true;
			$error.hide();
		}
		
		if(bol){
			$('.form').submit();
		}
		
		return false;
	})
})
