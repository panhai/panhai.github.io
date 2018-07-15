$(function() {

	var $username = $('.username');
	var $phone = $('.phone');
	var $phoneM = $('.phoneM');
	var $msg = $('.msg');
	var $getMa = $('.getMa');
	var $submit = $('.submit');
	var ma = '';
	var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
	boll = true;
	
	
	$('input').each(function(){
		var val = $(this).attr('placeholder');
		$(this).focus(function(){
			$(this).attr('placeholder','');
			$(this).blur(function(){
				$(this).attr('placeholder',val);
			})
		})
	})
	
	$phone.change(function() {
		if(!reg.test($(this).val())) {
			$msg.show();
			$msg.children('span').html('手机格式不正确，请重新输入');
			$(this).focus();
			$(this).css('border', '1px solid #ed4141');
			boll = false;
			return false;
		} else {
			$msg.hide();
			boll = true;
			$(this).css('border', '1px solid #999');
			$('.getMa').css('color','#333');
		}
	})
	//获取验证码
	var num = 60;
	var times = null;
	$getMa.click(function() {
		clearInterval(times);
		var _this = this;
		if(!$phone.val()){
			$msg.show();
			$msg.children('span').html('请输入手机号码');
			$phone.focus();
			$phone.css('border', '1px solid #ed4141');
			return false;
		}
		times = setInterval(function() {
			num--;
			if(num < 0) {
				num = 60;
				clearInterval(times);
				$(_this).html('重新获取');
				$(_this).attr('disabled', false);
				$(_this).css({'cursor':'pointer','color':'#333'});
			}else{
				$(_this).html('<span style="color:#999">重新获取</span>(' + num + ')');
				$(_this).attr('disabled', true);
				$(_this).css({'cursor':'not-allowed'}, );
			}

		}, 1000)
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
	
	if(boll) {
		$('.myform').submit(function() {

			var phone = $phone.val();
			var phoneM = $phoneM.val();

			//1 未输入
			//2 输入错
			//帐号不存在

			if(!phone) {
				$msg.show();
				$msg.children('span').html('未输入手机号，请输入');
				$phone.focus();
				$phone.css('border', '1px solid #ed4141');
				return false;
			}
			if(!phoneM) {
				$msg.show();
				$msg.children('span').html('未输入验证码，请输入');
				$phoneM.focus();
				$phoneM.css('border', '1px solid #ed4141');
				return false;

			}
			if(!ma){
				$msg.show();
				$msg.children('span').html('您还没有获取验证码，请获取验证码');
				$phoneM.focus();
				$phoneM.css('border', '1px solid #ed4141');
				return false;
			}
			if(ma != phoneM) {
				$msg.show();
				$msg.children('span').html('验证码不正确，请重新输入');
				$phoneM.focus();
				$phoneM.css('border', '1px solid #ed4141');
				return false;
			}
			
			$('.phone,.phoneM').css('border', '1px solid #999');
			$msg.hide();
			return false;
		})
	}
})