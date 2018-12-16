//企业中心-充值
//所有的下拉列表行为
function AllSelect()
{//timer是在dl上的
	$(".select dt").click(function(){
		var p=$(this).parent().get(0);
		clearTimeout(p.timer);
		p.timer=0;
		var v=$(this).parent().find("input:hidden").val();
		$(this).parent().css('zIndex',222)
			.find("dd").addClass("on")
			.find("a").removeClass("cur")
			.filter("[alt='"+ v +"']").addClass("cur")
		//下边的是要把其它打开的下拉列表关掉，不关掉本身的
		.closest("dl").siblings().css('zIndex',111)
			.find("dd").removeClass("on")
		.closest(".tr").siblings().find("dl").css('zIndex',111)
			.find("dd").removeClass("on");
		;
	})
	//父级，离开要延迟500毫秒
	.parent().mouseleave(function(){
		var t=this;
		if(!t.timer) t.timer=setTimeout(function(){
			$(t).css('zIndex',111)
				.find("dd").removeClass("on")
			;
		},($(t).hasClass("JOBS") ? 1500 : 500));
	}).mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
	});
	//下边只初始化普通的下拉列表的点击行为，它们的内容不会变，地址列表额外初始化
	$(".select").not(".ADDList,.JOBS").find("dd a")
		.attr("href","javascript:void(0)")
		.click(function(){
			var a=$(this),
				DL=a.closest("dl"),
				DT=DL.find("dt"),
				DD=DL.find("dd"),
				input=DL.find("input")
			
			input.val(a.attr("alt"));
			//JB.fireEvent(input.get(0),"change");
			DT.html(a.html() + '<i></i>');
			DD.removeClass("on");
		});
}
//买币点个数
function Coins()
{
	$(".coins b").click(function(){
		var num=$(this).html().replace("个",'');
		$(this).parent().find("input").val(num).change();
		$(this).addClass("cur").siblings().removeClass("cur");
	});
	$(".coins input").change(function(){
		var num=parseInt(this.value);
		$(this).closest(".lr").find("em").html(num*100+'元');
	});
}