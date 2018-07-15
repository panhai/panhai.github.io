	
//判断是否生效，显示文本颜色

$(function(){
	var list = $('.listBox tr td');
	list.each(function(){
		if($(this).text()=='即将生效'){
			$(this).addClass('tored');
		}
		if($(this).text()=='生效中'){
			$(this).addClass('toblue');
		}
	})
//	console.log(list)
})


//等级设置
$(function(){
	//点击设置按钮出现模态和框
	$('.r').click(function(){
		$('.motai').show();
		$('.Tk').show();
		//获取原来的等级
		var dj1 = $('.dj1 span').text();
		var dj2 = $('.dj2 span').text();
		var dj3 = $('.dj3 span').text();
		
		
		$('.se1').val(dj1);
		$('.se2').val(dj2);
		$('.se3').val(dj3);
		//获取原来的百分比
		var b1 = $('.dj1 .b1').text();
		var b2 = $('.dj2 .b2').text();
		var b3 = $('.dj3 .b3').text();
		
		$('.inp1').val(b1);
		$('.inp2').val(b2);
		$('.inp3').val(b3);
		
		
	})
	//关闭模态框
	$('.fa-close').click(function(){
		$('.motai').hide();
		$('.Tk').hide();
	})
	
	//限制比列必须为百分比数
	$('.submit').click(function(){
		var reg = /^(100(\.0{1,2})?|(([1-9]\d|\d)(\.\d{1,2})?))%$/;
		var num1 = $('.Tk .inp1').val();
		var num2 = $('.Tk .inp2').val();
		var num3 = $('.Tk .inp3').val();
		
		var dj1 = $('.se1').val();
		var dj2 = $('.se2').val();
		var dj3 = $('.se3').val();
		
		
		
		
		var bol = true;
		console.log(num1,num2,num3,dj1,dj2,dj3);
		$('.Tk input').each(function(){
			if(!$(this).val()){
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bol = false;
				return false;
			}
		})
		
		if(bol){
			if(!reg.test(num1)){
				layer.msg('比例必须填写1-100之间的百分比！');
				$('.Tk .inp1').focus();
				bol = false;
				return false;
			}
		}
		if(bol){
			if(!reg.test(num2)){
				layer.msg('比例必须填写1-100之间的百分比！');
				$('.Tk .inp2').focus();
				bol = false;
				return false;
			}
		}
		if(bol){
			if(!reg.test(num3)){
				layer.msg('比例必须填写1-100之间的百分比！');
				$('.Tk .inp3').focus();
				bol = false;
				return false;
			}
		}
		if(bol){
			layer.msg('设置修改成功！');
			$('.Tk').hide();
			$('.motai').hide();
		}
		
	
		return false;
	})
	
})
