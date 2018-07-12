//选着列表状态显示信息列表
$('#type_fk').change(function() {
	//do....
	$('#form').submit();
})

//左侧选中tab
$(function() {
	$('.aside-b ul li').on('click', function() {
		$(this).addClass('acitve').siblings('li').removeClass('acitve'); //旁边的li
		$(this).children('a').addClass('r')
		$(this).siblings('li').children('a').removeClass('r');
		$(this).parent().parent().siblings('.aside-b').find('li').removeClass('acitve'); //相邻祖父及下面的所有li
		$(this).parent().parent().siblings('.aside-b').find('a').removeClass('r');
	})
})

//返回上一页  下一页
//返回上一页  下一页
$(function() {
	var data = 112;
	var nums = 0;
	$('.pagings span').html('共' + data + '页');
	
	//上一页
	$('.prev').click(function(){
		data++;
		if(data>112){
			data=112;
			$(this).addClass('acitve').siblings('a').removeClass('acitve');
			$(this).attr('disabled',true)
			$(this).css('cursor','not-allowed').siblings('a').css('cursor','pointer')
			return false;
		}else{
			$(this).removeClass('acitve')
			$(this).attr('disabled',false)
			$(this).css('cursor','pointer')
		}
		return false;
	})
	$('.next').click(function(){
		data--;
		if(data<1){
			data=1;
			$(this).addClass('acitve').siblings('a').removeClass('acitve');
			$(this).attr('disabled',true)
			$(this).css('cursor','not-allowed').siblings('a').css('cursor','pointer')
			return false;
		}
		if(data<112){
			$(this).siblings('a').removeClass('acitve');
			$(this).attr('disabled',false)
			$(this).css('cursor','pointer')
		}
		return false;
	})
	
})

//点击图片和标题打开二维码
$('.alert').on('click', function() {
	$('.erweima').fadeIn(200)
})
//关闭二维码
$('img.close').on('click', function() {
	$('.erweima').fadeOut(200)
})

//是否确定取消订单
$('.qx-btn').on('click', function() {

})
//是否删除订单
$('.table-head-content-p .delete').on('click', function() {
	var _this = this;
	layer.confirm('确定删除订单吗？', {
		btn: ['确认', '取消'] //按钮
	}, function(index) {
		//确定
		$(_this).parent().parent().remove();

		layer.close(index)
	}, function() {
		//取消
	});
	return false;
})
//查看密码
$('.table-head-content-box-f .password').on('click', function() {
	//查看密码求学券密码框

})

//完成状态下不可以申请退款 提示
$('.table-head-content-box-f .wc').on('click', function() {
	layer.open({
		type: 1,
		title:'<b>温馨提示<b>',
		content: '<div style="padding: 20px 20px;">抱歉，您已错过了申请退款的有效期（即使用后15天内），<br/>查看<a href="" style="color:blue;display:inline-block;margin-top:-5px;margin-left:3px;">退款帮助</a></div>',
		btn: '好的',
		btnAlign: 'c' //按钮居中
			,
		yes: function() {
			layer.closeAll();
		}
	});
	return false;
})
//退款中的状态下 取消退款 两次弹框
$(function() {
	
	$('.table-head-content-box-f .qx-btn-tui').on('click', function() {
		var num = $(this).attr('data-num');//次数
		var _this = this;
		if(num == 0) {
			layer.confirm('<div style="text-align:center">是否确认撤销退款申请？</div>',{
				title:'<b>温馨提示</b>',
				btn:['确认','取消']
				},
				function(index) {
				//do something
				$(_this).attr('data-num','1');
				layer.close(index);
			});
		}
		if(num == 1) {
			layer.confirm('<div style="text-align:center">是否确认撤销退款申请？<br/>撤销后将无法再次申请退款？</div>',{
				title:'<b>温馨提示</b>',
				btn:['确认','取消']
				},
				function(index) {
				//do something
				
				layer.close(index);
			});
		}
		
	})
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
