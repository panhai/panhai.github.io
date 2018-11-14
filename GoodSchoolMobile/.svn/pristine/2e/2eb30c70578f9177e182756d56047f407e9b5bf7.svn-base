// JavaScript Document

//导航条有下划线滑动
var total=$(".common-nav .tab").length;
var tabWidth=100/total+"%";
//$(".common-nav .tab").css("width",tabWidth)
$(".common-nav .tab-slider").css({"width":tabWidth})

$(".common-nav .tab").click(function(){
	var s=parseFloat(tabWidth),
		index=$(this).index(),
		distance=index*s+"%";
	$(".jg-list").children().eq(index).show().siblings().hide();
	$(this).addClass("now").siblings().removeClass("now");
	$(".common-nav .tab-slider").animate({left:distance},150);
})



/*机构→学员点评 点评回复是*/
$(".jg-comment .text").focus(function(){
	$(this).prop("rows","4")
	$(".jg-comment .send").show();
}).blur(function(){
	$(this).prop("rows","1")
	$(".jg-comment .send").hide();
})

$(".top-navbar .right .set-edit01").click(function(){
	$(this).parents(".jg-set01").hide().siblings(".jg-set02").show();
})

$(".top-navbar .close,.top-navbar .set-edit02").click(function(){
	$(this).parents(".jg-set02").hide().siblings(".jg-set01").show();
})


$(".boxarea .select .option").click(function(){
	var Value=$(this).html();
		
	$(this).addClass("now").siblings().removeClass("now");
	$(this).parent().siblings(".textarea").append(Value);
})

$(".jg-chatinput .text").focus(function(){
	$(".jg-chatinput .btn01").show();
	$(".jg-chatinput .moble").hide();
}).blur(function(){
	$(".jg-chatinput .btn01").hide();
	$(".jg-chatinput .moble").show();
})

/*机构→咨询详情 */
$(".jg-details02 .text").focus(function(){
	$(this).prop("rows","4")
	$(".jg-details02 .btn01").css("background","#ff7f00");
}).blur(function(){
	$(this).prop("rows","1")
	if($(this).val().length>0) $(".jg-details02 .btn01").css("background","#ff7f00");
	else{
		$(".jg-details02 .btn01").css("background","#bebebe");
	}
})

if($(".jg-details02 .history .heightDiv").height()<$(".jg-details02 .history").height()) {
	$(".jg-details02 .history").height("auto").next().hide("more");
}

$(".jg-details02 .more").click(function(){
	var Height=$(".jg-details02 .history").height()
	if(Height==185){
		$(".jg-details02 .history").height("auto");
		$(this).html("<span class='icon'></span>");
		//$(this).children("span").addClass("icon");
	}
	else{
		$(".jg-details02 .history").height(185);
		$(this).html("查看全部回访情况")
		//$(this).children("span").removeClass("icon");
	}
})

if($(".jg-details03 .innerDiv").height()<$(".jg-details03").height()) {
	$(".jg-details03").height("auto").next().hide("more");
}
$(".jg-details .more02").click(function(){
	var Height=$(".jg-details03").height()
	if(Height==495){
		$(".jg-details03").height("auto");
		$(this).html("<span class='icon'></span>");
		//$(this).children("span").addClass("icon");
	}
	else{
		$(".jg-details03").height(495);
		$(this).html("查看全部回访情况");
		//$(this).children("span").removeClass("icon");
	}
}) 

/*机构后台→个人设置 手机邮箱*/
function MobileVal(){
	$(".jg-set .mobile .btn01").show().parent().next().show();	
}
function EmailVal(){
	$(".jg-set .email .btn01").show().parent().next().show();	
}

//点击弹出遮罩层
$(".jg-details03 .btn02,.jg-chat .btn01,.chat-nav .jilu,.jg-details02 .btn01,.jg-details02 .btn02").click(function (event) {
	event.stopPropagation();
	
	var Id=$(this).data("id")
	$(".background").css({
		display: "block", height: $(document).height()
	});
	$('.boxarea'+Id).show()
	
});

//点击关闭按钮的时候，遮罩层关闭
$(".boxarea .topbar .close").click(function () {
	$(".background,.boxarea").css("display", "none");
});


//消息中心提示
function InfoTips(){
	$(".infotips").slideDown();
}
InfoTips();
$(".infotips .close").click(function(){
	$(this).parent().slideUp();
})



























































