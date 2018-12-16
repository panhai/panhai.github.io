// 点击发送验证码的倒计时效果
$(function(){
	var tip1=$(".SendVerify").val(),
		tip2='秒后重新获取';
	$(".SendVerify").click(function(){
		var O=this;
		if(O.disabled) return;
		var number=60;
		O.disabled=true;
		$(O).addClass("disabled").val(number+tip2);
		O.timer=setInterval(function(){
			number--;
			O.value=number+tip2;
			if(!number)
			{
				clearTimeout(O.timer);
				O.timer=0;
				O.disabled=false;
				$(O).removeClass("disabled").val(tip1);
			}
		},1e3);
	});
})
