

/*
 * 步骤2
 */

$(function(){
	var boll = true; //注册协议是否勾选
	var stepbol = true;//判断填写状态
	var stepboll = true;//判断内容填写格式是否正确
	var regName =/^[\u4e00-\u9fa5]{2,10}$/;//验证姓名
	var regemail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;//邮箱
	var regqq = /^\d{5,11}$/;//qq
	
	//点击注册成功前往认证
	$('.btnStep2').click(function(){
		//每项必填写 
		$('.tbody-two .bx').each(function(){
			if(!$.trim($(this).val())){ //内容为空
				$(this).siblings('.miss').show(200);
				$(this).siblings('.zq').hide();
				stepbol = false;
			}else{
				stepbol = true;
			}
		})
		if(!boll){
			layer.open({
				type:0,
				title:'<h2>提示</h2>',
				content:'您未勾选注册协议，请阅读并勾选注册协议<br><br><span style="color:red;margin-left:90px">2</span>秒后自动关闭',
				time:2000
			})
		}
		console.log(stepbol,stepboll,boll)
		if(stepbol && stepboll && boll){
			
			layer.msg("成功注册商家账户，前往学校资质认证")
		}
	})
	
	//验证格式 realname emial qq province city address   ()
	//请输入4-20字的中文字符
	
	//输入过程中提示信息不可见
	$('.tbody-two .bx').focus(function(){
		$(this).siblings('.miss2').hide();
		$(this).siblings('.miss').hide();
		$(this).siblings('.zq').hide();
	})
	
	$('#realname').blur(function(){
		var val = $.trim($(this).val());
		if(val){
			if(!regName.test(val)){
				$(this).siblings('.miss2').show(200);
				$(this).siblings('.miss').hide();
				$(this).siblings('.zq').hide();
				stepboll = false;
			}else{
				stepboll = true;
				$(this).siblings('.miss2').hide();
				$(this).siblings('.miss').hide();
				$(this).siblings('.zq').show(200);
			}
		}else{
			$(this).siblings('.miss').show(200);
		}
	})
	//请输入正确的邮箱格式
	$('#email').blur(function(){
		var val = $.trim($(this).val());
		if(val){
			if(!regemail.test(val)){
				$(this).siblings('.miss2').show(200);
				$(this).siblings('.miss').hide();
				$(this).siblings('.zq').hide();
				stepboll = false;
			}else{
				stepboll = true;
				$(this).siblings('.miss2').hide();
				$(this).siblings('.miss').hide();
				$(this).siblings('.zq').show(200);
			}
		}else{
			$(this).siblings('.miss').show();
		}
		
	})
	//请输入正确形式的QQ号
	$('#qq').blur(function(){
		var val = $.trim($(this).val());
		if(val){
			if(!regqq.test(val)){
				$(this).siblings('.miss2').show(200);
				$(this).siblings('.miss').hide();
				$(this).siblings('.zq').hide();
				stepboll = false;
			}else{
				stepboll = true;
				$(this).siblings('.miss2').hide();
				$(this).siblings('.miss').hide();
				$(this).siblings('.zq').show(200);
			}
		}else{
			$(this).siblings('.miss').show();
		}
	})
	//地址
	$('#province,#city').blur(function(){
		var valp = $('#province').val();
		var valc = $('#city').val();
		
		if(valp && valc){
			$(this).siblings('.miss').hide();
			$(this).siblings('.zq').show(200);
			stepboll = true;
			console.log('都有指')
		}else{
			$(this).siblings('.miss').show(200);
			$(this).siblings('.zq').hide();
			stepboll = false;
		}
	})
	$('#address').blur(function(){
		var val =$.trim($(this).val());
		if(val){
			$(this).siblings('.miss').hide();
			$(this).siblings('.zq').show(200);
			stepboll = true;
		}else{
			$(this).siblings('.miss').show(200);
			$(this).siblings('.zq').hide();
			stepboll = false;
		}
	})
	//点击勾选注册协议或取消勾选
	$('.boll').click(function(){
		var state = $(this).is(':checked');
		boll = state;//状态保存
	})
})
