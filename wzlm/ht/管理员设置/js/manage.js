//操作删除
$(function(){
	//点击删除，删除当前的一行
	$('.deletes').click(function(){
		var _this = this;
		layer.confirm('确定删除吗？',{icon:3,title:'提示'},function(index){
			$(_this).parent().parent().remove();
			layer.close(index)
		})
		
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
		layer.confirm('确定删除吗？',{icon:3,title:'提示'},function(index){
			$('td input').each(function(){
				if($(this).prop('checked')==true){
					$(this).parent().parent().remove();
				}
			})
			
			layer.close(index)
		})
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
//确定提交
$(function(){
	$('.search .btn').click(function(){
		
		
		return false;
	})
})
