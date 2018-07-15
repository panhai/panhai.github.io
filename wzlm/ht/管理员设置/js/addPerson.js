
//设置虚线
$(function(){
	$('.powers  .fisrt').siblings('td').css('border-bottom','1px dashed #dcdcdc');
})
//角色选着
$(function(){
	$('.role .inp').click(function(){
		$(this).siblings('.j').html($('.j img'));
	})
})

//必须选中一级否则点击二级无权限
$(function(){
	//点击一级
	$('.powers .line input').on('click',function(){
		var stars = $(this).is(':checked');
		
		if(stars){
			$(this).siblings('.tg').children('img').show();
			$(this).parent().siblings('td').find('img').show();
			$(this).parent().siblings('td').children('input').attr('checked',true);
		}else{
			$(this).siblings('.tg').children('img').hide();
			$(this).parent().siblings('td').find('img').hide();
			$(this).parent().siblings('td').children('input').attr('checked',false);
		}
	})
	//点击二级  、//判断是否一级被选了
	$('.powers .line').siblings('td').children('input').on('click',function(){
		var stars = $(this).parent().siblings('.line').children('input').is(':checked');
		var thisStart = $(this).is(':checked');
		if(stars){
			if(thisStart){
				$(this).siblings('.tg').children('img').show();
			}else{
				$(this).siblings('.tg').children('img').hide();
			}
		}else{
			if(thisStart){
				$(this).siblings('.tg').children('img').show();
			}else{
				$(this).siblings('.tg').children('img').hide();
			}
		}
		
	})
})

//一级权限无勾选，不可以进入对应的导航navVolor

$(function(){
	//选着不是navvolor的一类元素
	$('.home').click(function(){
		var start = $('.line-home').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	$('.cengyuan').click(function(){
		var start = $('.line-cengyuan').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	$('.dengji').click(function(){
		var start = $('.line-dengji').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	$('.jiesuan').click(function(){
		var start = $('.line-jiesuan').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	$('.guanggao').click(function(){
		var start = $('.line-guanggao').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	$('.zhinan').click(function(){
		var start = $('.line-zhinan').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	$('.gonggao').click(function(){
		var start = $('.line-gonggao').is(':checked');
		if(!start){
			layer.msg('无权限！')
			return false;
		}
	})
	
})


//set cengyuan dengji jiesuan guanggao zhinan gonggao
//确定添加
$('.explain .btn').click(function(){
	
	var password1 = $('.password').val();
	var password2 = $('.password2').val();
	
	if(password1 !== password2){
		layer.msg('两次输入密码不一致!');
		$('.password2').focus();
		return false;
	}
	
	layer.msg('添加成功!');
	return false;
})
