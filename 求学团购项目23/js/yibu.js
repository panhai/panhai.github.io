$(function(){
	var $phone = $('.phone');
	var $phoneM = $('.phoneM');
	var $miss = $('.miss');
	
	var phoneReg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;   
	var bol = true;
	
	$phone.change(function(){
		var val = $(this).val();
		if(!phoneReg.test(val)){
			layer.msg('输入手机号码格式不正确，请重新输入');
			$(this).focus();
			$(this).css('border','1px solid #ed4141')
			bol = false;
			return false;
		}else{
			bol = false;
			$(this).css('border','1px solid #36ab60')
			return false;
		}
	})
	$phoneM.change(function(){
		var val = $(this).val();
		if(val!='123456'){
			layer.msg('输入验证码错误，请重新输入');
			$(this).focus();
			$(this).css('border','1px solid #ed4141')
			bol = false;
			return false;
		}else{
			bol = false;
			$(this).css('border','1px solid #36ab60')
			return false;
		}
	})
	
	
	
	var num = 60;
	var times = null;
	$miss.click(function(){
		var val = $phone.val();
		var _this = this;
		clearInterval(times);
		if(!val){
			layer.msg('未填写手机号码，请填写')
			$phone.focus();
			bol = false;
			$phone.css('border','1px solid #ed4141')
			return false;
		}
		if(!phoneReg.test(val)){
			layer.msg('请输入正确的手机号码')
			$phone.focus();
			bol = false;
			$phone.css('border','1px solid #ed4141')
			return false;
		}
		times = setInterval(function(){
			num--;
			if(num<0){
				num = 60;
				$(_this).attr('disabled',true);
				$(_this).css('cursor','not-allowed');
				$(_this).html('重新获取')
			}
			$(_this).html('重新获取'+num+'秒')
		},1000)
		$(this).attr('disabled',true);
		$(this).css('cursor','not-allowed');
	})
	
	
	
	
	$('form').submit(function(){
		
		$('.need').each(function(){
			var val = $(this).val();
			if(!val){
				layer.msg($(this).attr('placeholder'))
				$(this).css('border','1px solid #ed4141')
				$(this).focus();
				bol = false;
				return false;
			}
			
		})
		
		if($phoneM.val()){
			if($phoneM.val()!='123456'){
				layer.msg('输入验证码不正确，请重新输入')
				$(this).css('border','1px solid #ed4141')
				$(this).focus();
				bol = false;
				return false;
			}else{
				bol = true;
			}
		}
		if(bol){
			
			$(this).submit()
			
		}
		
		return false;
	})
})
