// 学校中心通用行为
//左导航
function LeftMenu()
{
	$(".left .menus h3").click(function(){
		$(this).toggleClass("off")
			.next("p").slideToggle();
	});
	$(":button,:reset,:submit").focus(function(){
		$(this).blur();
	});
}
//顶下拉列表
function Selects()
{
	$(".form-select").map(function(ind,ele){
		var T=$(ele),ul=T.find("ul");
		T.mouseenter(function(){
			ul.show();
		}).mouseleave(function(){
			ul.hide();
		});
		ul.find("li a").click(function(){
			var s=$(this).text();
			T.find(".form-hidden").val(s);
			T.find("span").html(s);
			ul.hide();
		});
		
	});
}
//右顶提示
function H2tip()
{
	$(".right,.right2").find("h2 i").click(function(){
		$(".h2-tip").show();
	});
	$(".h2-tip q").click(function(){
		$(this).closest(".h2-tip").hide();
	});
}
//校企合作
function TopSelect()
{
	$(".top-select").mouseenter(function(){
		$(this).find("samp").stop(true,true).slideDown('fast');
	}).mouseleave(function(){
		$(this).find("samp").stop(true,true).slideUp('fast');
	});
}
//各种取消操作的询问
function ConfirmAsk(JQstr,CenterJQ)
{
	var CenterDiv=$(CenterJQ);
	var Center=CenterDiv.get(0);
	var id;
	$(JQstr).attr('href','javascript:void(0)').click(function(){
		Center.open();
		id=$(this).data("id");
	});
	$(".submit",CenterDiv).one('click',function(){
		alert(id);
	});
	$(".reset",CenterDiv).click(function(){
		CenterDiv.find("dt q").click();
	});
}
//各种拉黑操作的询问
function BlackAsk(JQstr,CenterJQ)
{
	var CenterDiv=$(CenterJQ);
	var Center=CenterDiv.get(0);
	var id,memory;
	$(JQstr).attr('href','javascript:void(0)').click(function(){
		Center.open();
		id=$(this).data("id");
	});
	$(".submit",CenterDiv).click(function(){
		memory=$('textarea',CenterDiv).val();
		alert(id+'\n'+memory);
	});
	$(".reset",CenterDiv).click(function(){
		CenterDiv.find("dt q").click();
	});
}
//查看黑名单备注
function CheckMemory(JQstr,CenterJQ)
{
	var CenterDiv=$(CenterJQ);
	var Center=CenterDiv.get(0);
	var memory;
	$(JQstr).attr('href','javascript:void(0)').click(function(){
		CenterDiv.find('textarea').val($(this).data("memory"))
		Center.open();
	});
}
//拒绝学生申请
function NameAsk(JQstr,CenterJQ)
{
	var CenterDiv=$(CenterJQ);
	var Center=CenterDiv.get(0);
	var id;
	$(JQstr).attr('href','javascript:void(0)').click(function(){
		Center.open();
		id=$(this).data("id");
		name=$(this).data("name");
		CenterDiv.find('h5').html(name);
	});
	$(".submit",CenterDiv).one('click',function(){
		alert(id);
	});
	$(".reset",CenterDiv).click(function(){
		CenterDiv.find("dt q").click();
	});
}
//删除文件操作的询问
function DeleteAsk(JQstr,CenterJQ)
{
	var CenterDiv=$(CenterJQ);
	var Center=CenterDiv.get(0);
	var id;
	$(JQstr).attr('href','javascript:void(0)').click(function(){
		Center.open();
		id=$(this).data("id");
	});
	$(".submit",CenterDiv).one('click',function(){
		alert(id);
	});
	$(".reset",CenterDiv).click(function(){
		CenterDiv.find("dt q").click();
	});
}




var ALERT=function(topic,content,delay,onsubmit){
	var jq=ALERT.JQ;
	jq.find(".CENTERTOPIC b:first").text(topic).end()
		.find(".ContentDynamic").html(content);
	ALERT.onsubmit=$.isFunction(onsubmit) ? onsubmit : $.noop;
	jq.stop(true).fadeIn();
	if(!isNaN(delay)) setTimeout(ALERT.close,delay);
}
ALERT.JQ=$('<table class="FullScreenPlugin fixed fixed-top CenterDivContainer black5 highest"><tr><td><dl class="CENTERDIV CenterTiny CenterAlert"><dt class="CENTERTOPIC"><b></b><q></q></dt><dd class="CENTERCONTENT"><div class="ContentDynamic"></div></dd></dl></td></tr></table>');
ALERT.JQ.appendTo("body").end().hide();
ALERT.close=function(){
	ALERT.JQ.stop().fadeOut(function(){
		ALERT.onsubmit();
	});
}
ALERT.JQ.find(".CENTERTOPIC q").click(ALERT.close);


var CONFIRM=function(topic,content,submitTip,onsubmit,resetTip,onreset){
	if(!submitTip) submitTip="确定";
	if(!resetTip) resetTip="取消";
	var jq=CONFIRM.JQ;
	jq.find(".CENTERTOPIC b:first").text(topic).end()
		.find(".ContentDynamic").html(content).end()
		.find(".submit").val(submitTip).click(function(){
			if($.isFunction(onsubmit)) onsubmit();
		    //else CONFIRM.close();
			CONFIRM.close();
		}).end()
		.find(".reset").val(resetTip).click(function(){
			if($.isFunction(onreset)) onreset();
		    //else CONFIRM.close();
			CONFIRM.close();
		});
	jq.stop(true).fadeIn();
}
CONFIRM.JQ=$('<table class="FullScreenPlugin fixed fixed-top CenterDivContainer black5 highest"><tr><td><dl class="CENTERDIV CenterSmall CenterConfirm"><dt class="CENTERTOPIC"><b></b><q></q></dt><dd class="CENTERCONTENT"><div class="ContentDynamic"></div><div class="CENTERBTNS"><input type="button" class="submit" value="确定"><input type="button" class="reset" value="取消"></div></dd></dl></td></tr></table>');
CONFIRM.JQ.appendTo("body").end().hide();
CONFIRM.close=function(){
	CONFIRM.JQ.stop().fadeOut()
		.find(".submit").unbind('click');
}
CONFIRM.JQ.find(".CENTERTOPIC q").click(CONFIRM.close);
