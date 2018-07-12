//公用的弹框遮罩
//回到顶部、
function goTop(){
	 $("html,body").animate({scrollTop:0}, 400);
}

//工共的二维码弹框
/*
 * <!--二维码弹框-->
		<div style="width: 140px;height: 140px;position: relative;">
			<img src="img/close.png" class="closeid" style="position: absolute;right: -1px;top: -14px;"/>
			<img src="img/erweima2.png"/>
		</div>
 */
function alertWx(){
	$('#alertWx').fadeIn(300);
	$('#closeid').click(function(){
		$('#alertWx').fadeOut(200);
	})
}
//alertWx()

