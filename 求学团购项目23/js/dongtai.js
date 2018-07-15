$(function(){
	var bol = true;
	var $phone = $('.username');
	var $phoneM = $('.phoneM');
	
	
	
	var phone2 = '123';     //假设账号
	var phoneM2 = "123456"; //假设密码
	
	
	$phone.change(function(){
		$(this).css('border','1px solid #999')
		bol = true;
	})
	$phoneM.change(function(){
		$(this).css('border','1px solid #999')
		bol = true;
	})
	
	$('input').each(function(){
		var val = $(this).attr('placeholder');
		$(this).focus(function(){
			$(this).attr('placeholder','');
			$(this).blur(function(){
				$(this).attr('placeholder',val);
			})
		})
	})
	
	$('.submit').click(function(){
		var phone = $.trim($('.username').val());
		var phoneM = $.trim($('.phoneM').val());
		
		$('.need').each(function(){
			var val = $(this).val();
			if(!val){
				$('.msg').show();
				$('.msg span').html($(this).attr('placeholder'));
				$(this).focus();
				$(this).css('border','1px solid #ed4141')
				bol = false;
				return false;
			}
		})
		if(bol){
			if(phone!=phone2 || phoneM!=phoneM2){
				$('.msg').show();
					$('.msg span').html('<span>账号或密码错误，请重新输入，或者<a href="" class="ms" target="_blank">忘记密码</a></span>');
					$(this).focus();
					$(this).css('border','1px solid #ed4141')
					bol = false;
					return false;
			}else{
				bol = true;
			}
		}
		
		if(bol){
			$('.myform').submit();
		}
	})
	
})
