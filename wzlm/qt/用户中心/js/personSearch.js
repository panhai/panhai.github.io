layui.use('laydate', function() {
	var laydate = layui.laydate;
	//年选择器
	laydate.render({
		elem: '#year',
		type: 'year',
		value:new Date().getFullYear()
	})
	
	laydate.render({ 
	  elem: '#Month'
	  ,type: 'month',
	  value:(new Date().getFullYear()) + "-"+(new Date().getMonth()+1)
	});
})

//$(function() {
//	var datetime = new Date();
//	var Year = datetime.getFullYear();
//	var Month = datetime.getMonth() + 1;
//
////	$('#month').val(Month);
//})