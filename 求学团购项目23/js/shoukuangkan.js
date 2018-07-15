//点击图片和标题打开二维码
	
$('body').on('click','.alert',function(){
	alertWx();//开始弹框
	
	return false;
})
setTimeout(function(){
	$('#closeid').click()
},180000)
//关闭二维码



//删除项目
$('.btnbox img.delete').click(function(){
//	var start = $(this).parent().parent().siblings('.kanjia-box-item-msg-a').find('input.chek').is(':checked');
//	console.log(start);
	
	var _this = this;
	layer.confirm('确定要删除收藏的项目吗？',function(index){
		$(_this).parent().parent().parent().parent().remove();
		layer.close(index)
	})
//	if(start){
//		layer.confirm('确定要删除收藏的项目吗？',function(index){
//			$(_this).parent().parent().parent().parent().remove();
//			layer.close(index)
//		})
//	}else{
////		layer.msg('请勾选删除的项目')
//	}
	
})
//选着全部
$('.select-box a.all').on('click',function(){
	$('input.chek').prop('checked',true);
})
//取消
$('.select-box a.reset').on('click',function(){
	$('input.chek').prop('checked',false);
})

//删除
$('.select-box a.delect').on('click',function(){
	
	var bol = $('input.chek').is(':checked');
//	console.log(bol)
	
	if(bol){
		layer.confirm('确定要删除收藏的项目吗？',function(index){
			$('input.chek').each(function(){
				var start = $(this).is(':checked');
				if(start){
					$(this).parent().parent().parent().parent().remove();
				}
			})
			
			layer.close(index)
		})
	}else{
		layer.msg('请勾选删除的项目')
	}
	
})





//点击查看，项目
$('.btnbox button').click(function(){
	$('.erweima').fadeIn(200)
})

//切换不同状态
$('.main3-to a').click(function(){
	$(this).addClass('acitve').siblings('a').removeClass('acitve');
})
//no yue all
$('.main3-to a.no').click(function(){
	$('.nostop').show(100);
	$('.stop').hide();
})
$('.main3-to a.yue').click(function(){
	$('.nostop').hide();
	$('.stop').show(100);
})
//all
$('.main3-to a.all').click(function(){
	$('.nostop').show(100);
	$('.stop').show(100);
})


