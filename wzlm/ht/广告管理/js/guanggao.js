


//操作删除
$(function(){
	
	//点击删除，删除当前的一行
	$('.deletes').click(function(){
		var _this = this;
		layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
		  //do something
		  $(_this).parent().parent().remove();
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
			$('td input').prop('checked',false);
			 bol = false;
			$('.myTable td img').hide();
			
		}else{
			$('td input').prop('checked',true)
			 bol = true;
			$('.myTable td img').show();
		}
	})
	//全部删除
	$('.delete').click(function(){
		//如果input checked ==true 则删除当前的行 
		$('td input').each(function(){
			if($(this).prop('checked')==true){
				//批量修改状态
				
			}
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

//添加广告主
$(function(){
	$('body').on('click','.personbox li .xg',function(){
		var oltext = $(this).siblings('span').text();
		$(this).siblings('.bC').show();
		$(this).siblings('.qX').show();
		$(this).siblings('span').attr('contenteditable',true);
		$(this).siblings('span').focus();
		
		//保存
		$(this).siblings('.bC').click(function(){
			//保存数据，消失按钮
			$(this).hide().siblings('.qX').hide();
			layer.alert("确定要保存吗？");
		})
		//取消修改
		$(this).siblings('.qX').click(function(){
			$(this).siblings('span').text(oltext);
			layer.alert("确定要取消吗？");
		})
		
	})
	//删除广告主
	$('body').on('click','.del',function(){
		var _this = this;
		layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
		  //do something
		 $(_this).parent().remove();
		  layer.close(index);
		});
		return false;
	})
	
	
	
	var addhtml = $('.personList li').first().prop("outerHTML");//吧jq对象转换为原生元素结构html字符串	
	$('body').on('click','.addList',function(){
		//获取输入的值
        //把他值付给li并且添加到列表中
		var lists = $(this).siblings('.gList').val();
		
		if(lists==""){
			layer.msg('请填写广告主');
			return false;
		}
		var aalist = $(addhtml).clone(true);
		$('.personList').append(aalist);
		aalist.children('span').html("");
		aalist.children('span').html(lists);
		
		layer.alert("确定要添加吗？");
		return false;
	})
	
	//关闭
	$('.fa-close').click(function(){
		$('.addPerson').hide();
		$('.motai').hide();
	})
	
	//添加广告主
	$('#addlists').click(function(){
		$('.addPerson').show();
		$('.motai').show();
	})
})
//批量修改状态
$(function(){
	$('.PLXG').click(function(){
		$('td input').each(function(){
			if($(this).is(':checked')==true){
				$('.ztbox').show();
				return false;
			}
		})
		
	})
	//关闭框框
	$('.fa-close').click(function(){
		$('.ztbox').hide();
	})
	//确定
	$('.btn-box .btn').click(function(){
		var _this = this;
		 
		layer.confirm('确定修改吗？',{icon:3,title:'提示'},function(index){
			//做一些事情$(":checked").hide();
			var getDate = $('.ra input:checked').val();
			$('table .zt').each(function(){
				$(this).text(getDate);
			})
			
			layer.close(index);
			$('.ztbox').hide();
		})
		
		return false;
	})
})
//单个修改状态
$('table .down').on('click',function(){
	$(this).parent().siblings('.zt').text($(this).text())
})
