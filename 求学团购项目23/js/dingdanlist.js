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
//鼠标移入

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
		return false;
	})
	
})

//点击图片和标题打开二维码
	
$('body').on('click','.alert',function(){
	alertWx();//开始弹框
	
	return false;
})
setTimeout(function(){
	$('#closeid').click()
},180000)

//关闭二维码


//是否确定取消订单
$('.qx-btn').on('click', function() {
	layer.confirm('确定要取消订单吗？',{title:'取消订单'},function(index){
		//do
		setTimeout(function(){layer.msg('取消订单成功！')},2000)
		layer.close(index)
	})
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
//代理收费
$('.daili').click(function(){
	layer.confirm("请及时联系校园代理并确认收费，以免影响使用！",{btn:['好的']},function(index){
		
		
		layer.close(index)
	})
	return false;
})
//现场收费

$('.xianchang').click(function(){
	layer.confirm("请及时联系商家并前往商家门店现场交费并使用！",{btn:['好的']},function(index){
		
		
		layer.close(index)
	})
	return false;
})
//查看密码
$('.lookpassword').click(function(){
	$('#motai').fadeIn(200);
	$('#DialogDiv').show(200);
})

$('.close').click(function(){
	$('#motai').fadeOut(200);
	$('#DialogDiv').hide(200);
})

//完成状态下不可以申请退款 提示
$('.table-head-content-box-f .wc').on('click', function() {
	layer.open({
		type: 1,
		title:'<b>温馨提示<b>',
		content: '<div style="padding: 20px 20px;">抱歉，你已错过了申请退款的有效期（订单完成之前），<br/>前往<a href="" style="color:blue;display:inline-block;margin-top:-5px;margin-left:3px;">帮助中心</a>了解更多退款问题</div>',
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
	var num = 0; //次数
	$('.table-head-content-box-f .qx-btn-tui').on('click', function() {
		num++;
		console.log(num)
		if(num == 1) {
			layer.confirm('<div style="text-align:center">确定取消退款申请吗？<br>成功取消后<span style="color:#ed4141">3天内</span>可以再次申请</div>',{
				title:'<b>取消退款申请</b>',
				btn:['确认','取消']
				},
				function(index) {
				//do something
//				window.location.reload();
				setTimeout(function(){layer.msg('取消退款申请成功')},2000)
				layer.close(index);
			});
		}
		if(num > 1) {
			layer.confirm('<div style="text-align:center">是否确认撤销退款申请？<br/>撤销后将无法再次申请退款！</div>',{
				title:'<b>取消退款申请</b>',
				btn:['确认','取消']
				},
				function(index) {
				//do something
				layer.close(index);
			});
		}
	})
})
