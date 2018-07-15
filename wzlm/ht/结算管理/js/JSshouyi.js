//退款原因
$(function() {
	$('.tuiWhy').click(function() {
		$('.motai').show();
		$('.tuiWhyBox').show();
	})
	$('.inbtn .submit').click(function(){
		alert('确定退款吗？');
		$('.motai').hide();
		$('.tuiWhyBox').hide();
		return false;
	})
})

//关闭
$(function() {
	$('.fa-close').click(function() {
		$('.tuiWhyBox').hide();
		$('.motai').hide();
	})
})

//退款详情
$(function() {
	$('.tuiMsg').click(function() {
		$('.tuiMsgBox').show();
		$('.motai').show();
	})
	$('.fa-close').click(function() {
		$('.tuiMsgBox').hide();
		$('.motai').hide();
	})
})

$(function(){
	layui.use('laydate',function() {
		var laydate = layui.laydate;
		//年选择器
		laydate.render({
			elem: '.Year',
			type: 'year',
			value:new Date().getFullYear()
		});
	})
	function getStr(a) {
		if(a < 10) {
			return "0" + a;
		} else {
			return "" + a;
		}
	}

	//选着月份
	$(function() {
		$('.month').click(function() {
			$('.month-box').show();
			return false;
		})
		$('.month-box li').click(function() {
			$('.month').val(getStr(parseInt($(this).text())))
			return false;
		})
		$('.qd').click(function() {
			$('.month-box').hide();
		})
		$('body').click(function() {
			$('.month-box').hide();
		})
	})
	//显示当前月份
	$(function(){
		var times = new Date();
		var month = getStr(times.getMonth()+1);
		$('.month').val(month);
	})

})

function getStr(a) {
	if(a < 10) {
		return "0" + a;
	} else {
		return "" + a;
	}
}

