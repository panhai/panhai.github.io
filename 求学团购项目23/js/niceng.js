$(function(){
	var bol = true;
	
	$('#nc').keyup(function(){
		var val = $(this).val()
		console.log(val.length)
		if(val.length>0){
			$('.submit').css('cursor','pointer');
			$('.submit').css('background-color','#ED4141');
			$('.submit').css('color','#fff');
			$('.submit').attr('disabled',false);
			bol  = true;
		}else{
			$('.submit').css('cursor','not-allowed');
			$('.submit').css('background-color','#ccc');
			$('.submit').attr('disabled',true)
			bol = false;
		}
	})
	
	$('.submit').click(function(){
		var val = $('#nc').val();
		if(!val){
			layer.msg('请输入昵称');
			$('#nc').focus();
			bol = false;
			return false;
		}
		if(bol){
			$('form').submit();
		}
	})
})
