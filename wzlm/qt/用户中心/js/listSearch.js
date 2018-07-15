layui.use('laydate', function() {
	var laydate = layui.laydate;
	//年选择器
	laydate.render({
		elem: '#year',
		type: 'year'
	});

})
//选择月份
$(function() {
	//获取当前月份，付给select作为默认值
	var datatime = new Date();
	var month = datatime.getMonth() + 1;
	$('select option').eq(month - 1).attr('selected', 'selected');
})