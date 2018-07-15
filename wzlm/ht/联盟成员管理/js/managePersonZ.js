//删除信息
$(function() {
	$('.delete').click(function() {
		var _this = this;
		layer.confirm('确定删除吗？', {icon: 3, title:'提示'}, function(index){
			$(_this).parent().parent().remove();
			layer.close(index);
			return false;
			 
		});
		return false;
	})
})
//单选等级或是否通过
$(function() {
	$('.kin input').click(function() {
		$(this).siblings('.tg').addClass('show').parent().siblings().children('.tg').removeClass('show');
	})
})

//修改推广网站信息
$(function() {
	//关闭弹框
	$('.fa-close').click(function() {
		$('.change').hide();
		$('.motai').hide();

	})

	//获取推广网站信息赋值为修改框

	//修改后对信息验证

	//提交

	$('.resize').click(function() {

		//点击修改弹出修改信息框
		$('.change').show();
		$('.motai').show();
		//获取推广网站信息赋值为修改框	

		var webname = $(this).parent().parent().children('td').eq(0).text();
		var webUrl = $(this).parent().parent().children('td').eq(1).text();
		var webPerson = $(this).parent().parent().children('td').eq(2).text();
		var Phone = $(this).parent().parent().children('td').eq(3).text();

		
		$('.webname').val(webname);
		$('.webUrl').val(webUrl);
		$('.webPerson').val(webPerson);
		$('.Phone').val(Phone);
		
		return false;
	})
	
	//修改数据提交
	$('.change button').click(function(e){
		
		var webname = $('.webname').val();
		var webUrl = $('.webUrl').val();
		var webPerson = $('.webPerson').val();
		var Phone = $('.Phone').val();
		
		var regPhone =/^1[0-9]{10}/;
		var regUrl = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		var bol = true;
		
		$('.change input').each(function(){
			if(!$(this).val()){
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})
		
		if(bol){
			if(!regPhone.test(Phone)){
				layer.msg('手机号码格式不正确！');
				$('.Phone').focus();
				bol = false;
				return false;
			}
			if(!regUrl.test(webUrl)){
				layer.msg('请输入正确网址格式！');
				$('.webUrl').focus();
				bol = false;
				return false;
			}
			
			
			$('.change').hide();
			$('.motai').hide();
			layer.msg('提交成功！')
			return false;
			e.preventDefault();
		}
		
		return false;
	})

})
//保存到帐银行信息以及审核不通过
$(function(){
	$('.tj .btn').click(function(){
		
		
		layer.alert('确定保存吗？')
		return false;
	})
})
function getSr(str){
	var newstr = str.substring(0,str.length-4);
	var newstr2 = str.substring(str.length-4,str.length);
	var strs="";
	for(var i=0;i<newstr.length;i++){
		strs+="*";
	}
	
	return (strs + newstr2);
//	console.log(newstr2)
}
//显示卡号四位数字
$(function(){
	var bankNum = $('.num').text();
	var Jnum = getSr(bankNum);//假值
	$('.newnum').text(Jnum);//显示后四位数据
})

//选择不通过和通过时候显示原因
$(function(){
	 $('.Notong').click(function(){
	 	$('.why').show();
	 })
	 $('.tong').click(function(){
	 	$('.why').hide();
	 })
})


