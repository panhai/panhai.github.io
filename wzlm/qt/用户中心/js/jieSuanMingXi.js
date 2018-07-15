layui.use('laydate', function() {
	var laydate = layui.laydate;
	//年选择器
	laydate.render({
		elem: '#year',
		type: 'year',
		value:new Date().getFullYear()
	})
	laydate.render({
		elem: '#month',
		type: 'month',
		value:(new Date().getFullYear())+'-'+(new Date().getMonth()+1)
	})

})



//点击选择月份
$(function(){
	$('#month').click(function(){
		$('.monthChek').show(200);
		return false;//阻止时间冒泡和默认行为
	})
	$('body').click(function(){
		$('.monthChek').hide(200);
	})
	$('.monthChek li').click(function(){
		$('#month').val(parseInt($(this).text()))
	})
})
//选择来源类型
$(function(){
	$('.fg').click(function(){
		$(this).children('.t').html($('.t img'));
		$(this).siblings().children('.t').html("");
	})
})
//遍历有退款项为红色表示
$(function(){
	$('.myTable .re').each(function(){
		if(parseInt($(this).text()) != 0){
			$(this).addClass('red');
		}
	})
})


//点击提交查询
$(function() {
	var bol = true;
	$('.btn').click(function() {
		//提交数据
		
		return false;
	})
})
//点击重置$()
$(function(){
	$('.reset').click(function(){
		//来源类型重置
		$('.fg').eq(0).children('.t').html($('.t img')).siblings().children('.t').html("");;
		//订单状态重置
		$('.stas').children('option').val("");
		//显示当前时间
		var datatime = new Date();
		var month = datatime.getMonth() + 1;
		var Year= datatime.getFullYear();
		$('#year').val(Year)
		$('#month').val(month);
		
	})
})
