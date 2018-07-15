$(function(){
	//https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/reg  模拟数据
	
	//查看密码
	$('.see').click(function(){ //img/8.png   img/kyj.png
		
		if($(this).siblings('.password').attr('type')=='password'){
			$(this).siblings('.password').attr('type','text');
			$(this).attr('src','img/kyj.png');
		}else{
			$(this).siblings('.password').attr('type','password');
			$(this).attr('src','img/8.png');
		}
		
	})
	
	
	var getMa = '';//手机短信验证码
	var nicehng = '';//昵称
	var phones = '';//注册的手机号码
	$.ajax({
		type:"post",
		url:"https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/reg",
		async:true,
		success:function(data){
			var data = data.data;
			
			phones  = data.phone;
			nicehng  = data.niceng;
			console.log(data)
		}
	});
	
	var $tips = $('.tips');
	var $tacy = $('.tacy');//昵称
	var $phone = $('.phone');
	var $password = $('.password');
	var $phoneM = $('.phoneM');
	var $getMa = $('.getMa');
	var regpassword = /^[a-zA-Z0-9_-]{6,20}$/;
	var regphone = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
	
	
	var bol = true; //控制表单提交
	var bl = false;  //  控制手机获取验证码
	$phone.change(function(){
		var val = $.trim($(this).val());
		if(!regphone.test(val)){
			$(this).siblings('.tips').show();
			$(this).siblings('.tips').css('color','#ED4141')
			$(this).siblings('.tips').children('img').attr('src','img/bt.jpg');
			$(this).siblings('.tips').children('span').html('请输入正确的11位手机号码');
			$(this).addClass('err');
			bl = false;
			return false;
		}else{
			if(val==phones){
				$(this).siblings('.tips').show();
				$(this).siblings('.tips').css('color','#ED4141')
				$(this).siblings('.tips').children('img').attr('src','img/bt.jpg');
				$(this).siblings('.tips').children('span').html('手机号已注册，请更换，或<a href="" class="zc" target="_blank">立即注册</a>');
				$(this).addClass('err');
				bl = false;
				bol = false;
				return false;
			}else{
				bl = true;
				bol = true;
				$(this).siblings('.tips').show();
				$(this).siblings('.tips').children('img').attr('src','img/zq.png');
				$(this).siblings('.tips').children('span').html('');
				$(this).removeClass('err');
				$('.getMa').css('cursor','pointer');
				$('.getMa').css('color','#333');
				return false;
			}
		}
	})
	
	$tacy.change(function(){//昵称
		var val = $.trim($(this).val());
		if(val==nicehng){
			$(this).siblings('.tips').show();
			$(this).siblings('.tips').css('color','#ED4141')
			$(this).siblings('.tips').children('img').attr('src','img/bt.jpg');
			$(this).siblings('.tips').children('span').html('改昵称已被注册，请重新填写');
			$(this).addClass('err');
			bol = false;
			return false;
		}else{
			bol = true;
			$(this).siblings('.tips').show();
			$(this).siblings('.tips').children('img').attr('src','img/zq.png');
			$(this).siblings('.tips').children('span').html('');
			$(this).removeClass('err');
			return false;
		}
	})
	
	$password.change(function(){
		var val = $.trim($(this).val());
		if(!regpassword.test(val)){
			$(this).siblings('.tips').show();
			$(this).siblings('.tips').css('color','#ED4141')
			$(this).siblings('.tips').children('img').attr('src','img/bt.jpg');
			$(this).siblings('.tips').children('span').html('请输入6-20位字符密码');
			$(this).addClass('err');
			bol = false;
			return false;
		}else{
			bol = true;
			$(this).siblings('.tips').show();
			$(this).siblings('.tips').children('img').attr('src','img/zq.png');
			$(this).siblings('.tips').children('span').html('');
			$(this).removeClass('err');
			return false;
		}
	})
	$phoneM.change(function(){
		if(getMa==$(this).val()){
			bol = true;
			$(this).siblings('.tips').show();
			$(this).siblings('.tips').children('img').attr('src','img/zq.png');
			$(this).siblings('.tips').children('span').html('');
			$(this).removeClass('err');
			$('.getMa').css('cursor','pointer');
			return false;
		}
	})
	$('.need').focus(function(){
		var placeh = $(this).attr('placeholder')
		$(this).attr('placeholder',' ');
		$(this).blur(function(){
				if(!$(this).val()){
				$(this).attr('placeholder',placeh);
			}
		})
	})
	//获取验证码
	var num = 60;
	var times = null;
	$getMa.on('click',function(){
		clearInterval(times);
		var _this = this;
		if(!bl){
			$phone.siblings('.tips').show();
			$phone.siblings('.tips').css('color','#ED4141')
			$phone.siblings('.tips').children('img').attr('src','img/bt.jpg');
			$phone.addClass('err');
			$phone.focus();
			if($phone.val()==phones){
				$phone.siblings('.tips').children('span').html('手机号已注册，请更换，或<a href="" class="zc" target="_blank">立即注册</a>');
			}else{
				$phone.siblings('.tips').children('span').html('请输入正确格式的11位手机号码');
			}
			return false;
		}
		times = setInterval(function(){
			num--;
			if(num<0){
				num = 60;
				clearInterval(times);
				$(_this).css('cursor','pointer');
				$(_this).attr('disabled',false);
				$(_this).html('重新获取');
			}else{
				$(_this).html('<span style="color:#999">重新获取</span>('+num+')')
			}
		},1000)
		$(this).attr('disabled',true);
		$(this).css('color','#333');
		$(this).css('cursor','not-allowed');
		$.ajax({
			type:"post",
			url:"https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/reg",
			async:true,
			success:function(data){
				var data = data.data;
				
				getMa  = data.phoneM;
				console.log(getMa)
			}
		});
		
	})
	
	
	$('.submit').click(function(){
		//未勾选协议不可注册 提示框
		if(!$('.checkbox').is(':checked')){
			layer.alert('<div>您未勾选注册协议，请阅读并勾选注册协议<br><p style="text-align:center"><span style="color:#ed4141">2</span>秒后自动关闭</p></div>',{title:'<b>提示</b>',time:2000,closeBtn:false,btn:false})
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"https://www.easy-mock.com/mock/5b1d5031e9810b7fd37bf1ac/example/reg",
			async:true,
			success:function(data){
				console.log(data.data)
			}
		});
		//必填
		$('.need').each(function(){
			var val = $.trim($(this).val());
			if(!val){
				$(this).siblings('.tips').show(200);
				$(this).siblings('.tips').css('color','#ED4141')
				$(this).siblings('.tips').children('img').attr('src','img/bt.jpg');
				$(this).siblings('.tips').children('span').html('该字段不能为空');
				$(this).addClass('err');
				bol = false;
			}
		})
		if(getMa=='' || $phoneM.val()!=getMa){
			$phoneM.siblings('.tips').show();
			$phoneM.siblings('.tips').css('color','#ED4141')
			$phoneM.siblings('.tips').children('img').attr('src','img/bt.jpg');
			$phoneM.siblings('.tips').children('span').html('请输入正确的短信验证码');
			$phoneM.addClass('err');
			bol = false;
			return false;
		}else{
			bol = true;
		}
		
		if(bol){
			$('.myform').submit();
		}
		return false;
	})
	
})
