//提示信息tips  订单完成45天内可投诉商家，限1次

$('#tips').hover(function(){
	var that = this;
	layer.tips('订单完成45天内可投诉商家，限1次', '#tips', {
	  tips: 4
	});
},function(){
	layer.tips('订单完成45天内可投诉商家，限1次', '#tips', {
	  tips: 4,
	  time:10
	});
})



