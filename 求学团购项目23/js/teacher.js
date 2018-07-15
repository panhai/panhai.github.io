/*
 * 步骤1
 */

//昵称  图片验证码   手机短信验证码

var nicheng = "123";
var imgYZ = "byoe";
var phoneYz = "123456";
var phone = '15989223204';

var bool = true;//验证是否填写了
var bl = false;//判断图片验证码是否正确
var bol = true;//验证格式是否准确
var boll = true; //注册协议是否勾选

$(function(){
	$.ajax({
		type:"GET",
		url:"",
		async:true,
		dataType: 'json',
		success: function(data){
			console.log(data)//获取后台信息
		}
	});
})


//切换明文和暗文
$(function(){
	$('.yj').click(function(){
		if($('#password').attr('type')=="password"){
			$('#password').attr('type','text');
			$(this).children('img').attr('src','img/kyj.png');
		}else{
			$('#password').attr('type','password');
			$(this).children('img').attr('src','img/yj.png');
		}
	})
})

//点击下一步 （提交按钮）
$(function(){
	var regname = /^[a-zA-Z0-9_]{4,20}$/;//4-20位字母及数字组合字符
	var regpass = /^[a-z0-9_-]{6,20}$/;//6-20 密码
	var regphone = /^[1][3,4,5,7,8][0-9]{9}$/;//11位手机号码
	
	
	$('#myform .tbody-one .ms').focus(function(){
		$(this).siblings('.miss').hide();
		$(this).siblings('.zq').hide();
		$(this).siblings('.miss2').hide();
	})
	
	$('.submit').click(function(){
		//便利每个input 必填
		$('#myform .tbody-one .ms').each(function(){
			//如果没有内容就显示提示错误信息
			if(!$.trim($(this).val())){
				$(this).siblings('.miss').show(200);
				$(this).siblings('.zq').hide();
				$(this).siblings('.miss2').hide();
				bool = false;
			}else{
				$(this).siblings('.miss').hide();
				bool = true;
			}
		})
		//判断是否勾选协议
		if(!boll){
			layer.open({
				type:0,
				title:'<h2>提示</h2>',
				content:'您未勾选注册协议，请阅读并勾选注册协议<br><br><span style="color:red;margin-left:90px">2</span>秒后自动关闭',
				time:2000
			})
		}
		if(bool && bol && bl){ //填写完整 格式 和 不重复性 都正确通过
			//进入第二步 
			
			layer.msg('验证通过,进入第二步')
			return false;
		}
		
		return false;
	})
	//输入框失去焦点时判断字段
	//用户名 请输入4-20位字母及数字组合字符  验证不过显示错误信息（输入通过显示正确图标）
	
	$('#usename').blur(function(){
		var val = $.trim($(this).val());
		if(!regname.test(val)){
			$(this).siblings('.miss2').show(200);
			$(this).siblings('.zq').hide();
			$(this).siblings('.miss').hide();
			bol = false;
		}else{
			$(this).siblings('.miss2').hide();
			$(this).siblings('.zq').fadeIn(200);
			bol = true;//格式正确
		}
	})
	//请输入6-20位字符密码
	$('#password').blur(function(){
		var val = $.trim($(this).val());
		if(!regpass.test(val)){
			$(this).siblings('.miss2').show(200);
			$(this).siblings('.zq').hide();
			$(this).siblings('.miss').hide();
			bol = false;
		}else{
			$(this).siblings('.miss2').hide();
			$(this).siblings('.zq').fadeIn(200);
			bol = true;
		}
	})
	//该昵称已被注册，请重新输入
	$('#nickname').blur(function(){
		var val = $.trim($(this).val());
		//获取昵称 做判断昵称唯一性
		if(val && val != '123'){
			$(this).siblings('.miss2').hide(200);
			$(this).siblings('.zq').show(200);
			$(this).siblings('.miss').hide();
			bol = true;
		}
		if(val == '123'){
			$(this).siblings('.miss2').show();
			$(this).siblings('.miss').hide();
			$(this).siblings('.zq').hide();
			bol = false;
		}
	})
	//请输入正确的11位手机号码   手机不可以重复注册
	$('#phone').blur(function(){
		var val = $.trim($(this).val());
		if(!regphone.test(val)){
			$(this).siblings('.miss2').show(200);
			$(this).siblings('.zq').hide();
			$(this).siblings('.miss').hide();
			bol = false;
		}else{
			bol = true;
			$(this).siblings('.miss2').hide();
			$(this).siblings('.zq').fadeIn(200);
		}
		if(val == phone){
			$(this).siblings('.miss2').show(200);
			$(this).siblings('.zq').hide();
			bol = false;
			$(this).siblings('.miss2').children('span').html('手机号已注册，或'+'<a href="" style="color:deepskyblue">立即登录</a>')
		}
	})
	//验证码输入错误，请重新输入
	$('#registeImg').blur(function(){
		var val = $.trim($(this).val());
		//获取图片验证码 做判断
		if(val == imgYZ){
			$(this).siblings('.miss2').hide();
			$(this).siblings('.zq').show(200);
			$(this).siblings('.miss').hide();
			bol = true;
			bl = true;
		}else{
			$(this).siblings('.miss2').show(200);
			$(this).siblings('.zq').hide();
			$(this).siblings('.miss').hide();
			bol = false;
			bl = false;
		}
	})
	//请输入正确的短信验证码
	$('#registePhone').blur(function(){
		var val = $.trim($(this).val());
		//获取手机验证码 做判断
		if(val == phoneYz){
			$(this).siblings('.miss2').hide();
			$(this).siblings('.zq').show(200);
			$(this).siblings('.miss').hide();
			bol = true;
			bl = true;
		}else{
			$(this).siblings('.miss2').show(200);
			$(this).siblings('.zq').hide();
			$(this).siblings('.miss').hide();
			bol = false;
			bl = false;
		}
	})
	
	
	//点击获取手机验证码
	$('.get').click(function(){
		//获取图片验证码
		var valimg = $.trim($('#registeImg').val());
		var phone = $.trim($('#phone').val())
		var t = 60;
		var timer = null;
		if(!valimg || !bl){//没有填写或填写不正确
			layer.msg('请输入正确的图片验证码',{icon:5});
			$('#registeImg').focus();
			return false;
		}
		if(!phone || !bol){
			layer.msg('请输入正确的手机号码',{icon:5});
			$('#phone').focus();
			return false;
		}
		if(bol && bl){//手机格式和手机唯一 ，图片验证码正确
			$.ajax({
				type:"get",
				url:"",
				async:true,
				success: function(data){
//					console.log(data)
				}
			});
			var that = this;
			timer = setInterval(function(){
				t--;
				$(that).html('已发送'+t+'秒');
				if(t<=0){
					clearInterval(timer);
					$(that).attr('disabled',false);
					$(that).css('cursor','pointer');
					$(that).html('重新获取');
				}
			},1000)
			$(this).attr('disabled',true);
			$(this).css('cursor','wait');
		}
	})
	//点击更换图片验证码
	$('.imgbox').click(function(){
		$.ajax({
			type:"get",
			url:"",
			async:true,
			success: function(data){
				//更换图片验证码
			}
		});
	})
	//点击勾选注册协议或取消勾选
	$('.boll').click(function(){
		var state = $(this).is(':checked');
		boll = state;//状态保存
	})
	
})


