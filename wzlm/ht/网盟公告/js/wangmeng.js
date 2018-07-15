//操作删除
$(function(){
	//点击删除，删除当前的一行
	$('.deletes').click(function(){
		var _this = this;
		layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
			//do something
			$( _this).parent().parent().remove();
			layer.close(index);
		});
		
		return false;
	})
	//全部选择和删除
	var num = 0;
	var bol = false;
	$('.pageing .all').click(function(){
		num++;
		if(num % 2 == 0){
			$('input').prop('checked',false);
			 bol = false;
			$('.myTable td img').hide();
			
		}else{
			$('input').prop('checked',true)
			 bol = true;
			$('.myTable td img').show();
		}
	})
	//全部删除
	$('.delete').click(function(){
		//如果input checked ==true 则删除当前的行 
		var _this = this;
		layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
			$('td input').each(function(){
				if($(this).prop('checked')==true){
					$(this).parent().parent().remove();
				}
			})
			layer.close(index);
		});
		
	})
	//单项选择
	$('td input').click(function(){
		if($(this).prop('checked')==true){
			$(this).siblings('.tg').children('img').show();
		}else{
			$(this).siblings('.tg').children('img').hide();
		}
	})
})
//发布新公告
$(function(){
	$('.search .add').click(function(){
		$('.motai').show();
		$('.addTiltle').show();
		return false;
	})
	//关闭
	$('.fa-close').click(function(){
		$('.motai').hide();
		$('.addTiltle').hide();
	})
	//确定
	$('body').on('click','.qdBtn',function(){
		
		var titles = $('.cdinput').val();
		var ttexts = $('.btnbox textarea').val();
		var bol = true;
		
		if(!titles){
			layer.msg('请输入标题！');
			$('.cdinput').focus();
			bol = false;
			return false;
		}
		if(!ttexts){
			layer.msg('请输入公告内容！');
			$('.btnbox textarea').focus();
			bol = false;
			return false;
		}
		
		if(bol){
			
			layer.alert("确定发布吗？");
			$('.motai').hide();
			$('.addTiltle').hide();
			return false;
		}
		
		return false;
	})
})
//公告详情
$(function(){
	$('.look').click(function(){
		$('.motai').show();
		$('.ggxq').show();
	})
	$('.fa-close').click(function(){
		$('.motai').hide();
		$('.ggxq').hide();
	})
})
