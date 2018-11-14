// JavaScript Document

//导航条有下划线滑动
var grTotal=$(".gr-common-nav .tab").length;
var grTabWidth=100/grTotal+"%";
//$(".common-nav .tab").css("width",tabWidth)
$(".gr-common-nav .tab-slider").css({"width":grTabWidth})

$(".gr-common-nav .tab").click(function(){
	var s=parseFloat(grTabWidth),
		index=$(this).index(),
		distance=index*s+"%";
	$(".gr-list").children().eq(index).show().siblings().hide();
	$(this).addClass("now").siblings().removeClass("now");
	$(".gr-common-nav .tab-slider").animate({left:distance},150);
})

var total02=$(".gr-common-nav02 .tab").length;
var tabWidth02=100/total02+"%";
$(".gr-common-nav02 .tab-slider").css({"width":tabWidth02});
$(".gr-common-nav02 .tab").click(function(){
	var s=parseFloat(tabWidth02),
		index=$(this).index(),
		distance=index*s+"%";
	$(".gr-list").children().eq(index).show().siblings().hide();
	$(this).addClass("now").siblings().removeClass("now");
	$(".gr-common-nav02 .tab-slider").animate({left:distance},150);
})

$(".gr-details02 .gr-more").click(function(){
	if($(".timeline").height()==185) $(".timeline").height('auto');
	else{
		$(".timeline").height(185);
	}
})


//点击增加减少数量
	var exchangeValue=0;
$(".gr-changenumber .plus").click(function(){
	exchangeValue++;
	$(".gr-changenumber .number").html(exchangeValue);
	//console.log(exchangeValue);
})
$(".gr-changenumber .reduction").click(function(){
	exchangeValue--;
	if(exchangeValue>=0) $(".gr-changenumber .number").html(exchangeValue);
})

//MB兑现
$(".gr-mbexchange .close").click(function(){
	$(this).parent().fadeOut();
	$(".background").fadeOut();
})

$(".gr-mbexchange .select").click(function(){
	$("#background01").show();
	$(this).siblings(".MBcash-tc").slideDown();
	$(this).find(".i").addClass("i1");
})
$("#background01").click(function(){
	$(".MBcash-tc").slideUp(300);
	$(".gr-mbexchange .select .i").removeClass("i1");
	$(this).fadeOut();
})
$(".gr-mbexchange .return_ico").click(function(){
	$(".MBbank-choice").slideUp(500);
})
$(".gr-mbexchange #yh").click(function(){
	$(".MBbank-choice").slideDown(500);
})

$(".MBbank").click(function(){
    $(".gr-mbexchange #yh").val($(this).find(".name").html());
    $(".MBbank-choice").slideUp(500);
})

$(".gr-mbexchange .choose").click(function(){
	$(this).addClass("now").siblings().removeClass("now");
})

$(".MBcash-phone .phone-yz").click(function(){
    $(".black01").fadeIn(300);
    $(".MBcash-yz").slideDown(300);
})
$(".black01").click(function(){
    $(".black01").fadeOut(300);
    $(".MBcash-yz").slideUp(300);
})
$(".MBcash-yz01").click(function(){
    $(".now").removeClass().addClass("MBcash-ico02");
    $(this).find(".MBcash-ico02").removeClass().addClass("now");
    $(".black01").click();
    $(".phone-yz input").val($(this).find(".yz").html());
})

$(".MBcash-btn").click(function(){
    $(".tishi").fadeIn(300);
    $(".MBcash-tishi01").slideDown(300);
})

$(".h_p_upload span a").click(function()
{
	$("#head div").addClass("loadpic");
})


/*我的收藏*/
$(".gr-collection01").click(function(){
    if($(this).text().trim()=="编辑"){
        $(".gr-collection .label,.gr-collection .delete").show();
        $(".gr-collection .gr-coursebox").addClass("p-l30");
		$(".pager").css({"margin-bottom":"49px"});
        $(this).text("取消").trim();
    }
    else{
        $(".gr-collection .label,.gr-collection .delete").hide();
        $(".gr-collection .gr-coursebox").removeClass("p-l30");
		$(".gr-collection .gr-coursebox .checkbox").prop("checked", false)
		$(".pager").css({"margin-bottom":"0"});
        $(this).text("编辑").trim();
    }
})

function MycollectionTab(){
    $(".gr-collection .label,.gr-collection .delete").hide();
	$(".gr-collection .gr-coursebox").removeClass("p-l30");
	$(".gr-collection .gr-coursebox .checkbox").prop("checked", false)
	$(".pager").css({"margin-bottom":"0"});
	$(".gr-collection01").text("编辑").trim();
}


/*咨询详情底按钮*/
function grDetailsBtn(){
	$(".gr-details").css({"padding-bottom":"30px"})
	$(".gr-b-btn").slideDown()
}


/*热点推销*/
$(".gr-optionbox .option").click(function(){
	$(this).addClass("now").siblings(".option").removeClass("now");
})


/*星星点击*/
$(".commentStar a").click(function(){
	 var span = $(this).parent();
		var index = span.find("a").index($(this)) + 1;
		span.removeClass().addClass('commentStar star'+index+'0');
		span.siblings(".fenshu").html(index);
	
		var root = span.parent().parent().parent();
		var score1 = parseFloat(root.find(".teachers .fenshu").html());
		var score2 = parseFloat(root.find(".environment .fenshu").html());
		var score3 = parseFloat(root.find(".Service .fenshu").html());
		var all = (score1 + score2 + score3) / 3;
	
		$(".c-orange").html(all.toFixed(1));
});




















































