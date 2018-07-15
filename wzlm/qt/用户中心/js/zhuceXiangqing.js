layui.use('laydate', function() {
	var laydate = layui.laydate;
	//年选择器
	laydate.render({
		elem: '#time',
		type: 'year',
		value:new Date().getFullYear()
	});
	laydate.render({
		elem: '#month',
		type: 'month',
		value:(new Date().getFullYear()) + '-'+( new Date().getMonth()+1)
	});

})
//显示当前时间

//选中查询类型
$(function() {
	$('.fg').click(function() {
		$(this).children('.q').html($('.q img'))
		$(this).siblings().children('.q').html('');
	})
})
//点击查看明细若无明细显示提示框
$(function() {
	$('.look').click(function() {
		var bol = true;
		if(bol) {
			$('.nomsg').show();
			$('.nomsg-box').show();
		}
		return false;
	})
})
//关闭删除无信息消息框
$(function() {
	$('.nomsg i').click(function() {
		$('.nomsg').hide();
		$('.nomsg-box').hide()
	})
})
//查询不到数据显示的提示栏目信息
$(function() {
//	$('.nonetable').show();
})