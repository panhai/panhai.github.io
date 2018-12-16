// 前台要用到的效果
//页顶关键字输入，在职位内匹配
$(".KEY-GUIDANCE").on('keyup focus click',function(event){
	var key=event.which;
	if($.inArray(key,[40,38,13])>=0 && event.type=='keyup')return true;
	key=this.value;
	var dl=$(this).closest('dl'),
		dd=dl.find('dd'),
		tip=dd.find('.tip'),
		result=dd.find('.matches'),
		oDOMselect=$(this).closest(".SELECT").get(0);
	SELECT.open.call(oDOMselect);
	if(!key)
	{//无关键字则收回提示及匹配
		tip.html('↑请输入（全职/实习）相关职位或公司名称').show();
		result.hide();
		return true;
	}
	if(typeof GetPositionsByKeywords =='undefined')
	{
		alert('缺少包含文件jobPositions.js');
		return false;
	}
	var jobs=GetPositionsByKeywords(key),count=jobs.length;
	if(count)
	{//最大选项数，如果不设置则显示全部
		var matches=dl.data("matches"),str=[];
		if(!matches) matches=count;
		var over=Math.min(matches,count);
		for(var n=0;n<over;n++)
		{
			var job=jobs[n][0],id=jobs[n][2];
			str.push('<a href="javascript:void(0)" title="', job ,'" data-id="', id ,'">', job ,'</a>');
		}
		result.html(str.join('')).show();
		tip.hide();
	}
	else
	{//修改提示
		//tip.html('对不起，找不到符合'+ key +'的职位').show();
		result.hide();
		SELECT.close.call(oDOMselect,true);
	}
});
//$("input.TOP-SUBMIT").click(function(){alert('goto search...')})

/*
页顶导航头的一二级导航
	首页的导航头的根没有i元素，一级导航不需要伸缩
	内页的导航头的根没有i元素，一级导航需要伸缩
*/
var NAV={
	timer:0,
	show:function(sJQnav,sJQitem,sJQlist,index){
		var oJQnav=$(sJQnav),oDOMnav=oJQnav.get(0);
		if(oDOMnav.timer)
		{
			clearTimeout(oDOMnav.timer);
			oDOMnav.timer=0;
		}
		var oItems=oJQnav.find(sJQitem),
			oCurItem=oItems.eq(index),
			oLists=oJQnav.find(sJQlist),
			oCurList=oLists.eq(index);
		oItems.not(oCurItem).removeClass("cur");
		oCurItem.addClass("cur");
		oLists.not(oCurList).hide();
		oCurList.show();
	},
	hide:function(sJQnav,sJQitem,sJQlist,index){
		var oJQnav=$(sJQnav),oDOMnav=oJQnav.get(0);
		if(oDOMnav.timer)return;
		oDOMnav.timer=setTimeout(function(){
			oJQnav.find(sJQitem).eq(index).removeClass("cur");
			oJQnav.find(sJQlist).eq(index).hide();
		},100);
	}
};
if($(".NAV-HEAD").find(".NAV-HEAD-ROOT i").size())
{
	var oJQmenu=$(".NAV-HEAD"),oDOMmenu=oJQmenu.get(0);
	$(".NAV-HEAD").mouseenter(function(){
		SELECT.open.call(oDOMmenu);
	}).mouseleave(function(){
		SELECT.close.call(oDOMmenu);
	});
	if(!oJQmenu.data('delay'))oJQmenu.data('delay',100);
}
$(".NAV-HEAD .NAV-HEAD-MENU").find("a.menu").mouseenter(function(){
	NAV.show(
		".NAV-HEAD .NAV-HEAD-MENU",
		"a.menu",
		"ul.NAV-HEAD-SUBMENU",
		$(this).index(".NAV-HEAD-MENU a.menu")
	);
}).mouseleave(function(){
	NAV.hide(
		".NAV-HEAD .NAV-HEAD-MENU",
		"a.menu",
		"ul.NAV-HEAD-SUBMENU",
		$(this).index(".NAV-HEAD-MENU a.menu")
	);
})
.end()
.find("ul.NAV-HEAD-SUBMENU").mouseenter(function(){
	NAV.show(
		".NAV-HEAD .NAV-HEAD-MENU",
		"a.menu",
		"ul.NAV-HEAD-SUBMENU",
		$(this).index(".NAV-HEAD-MENU ul.NAV-HEAD-SUBMENU")
	);
}).mouseleave(function(){
	NAV.hide(
		".NAV-HEAD .NAV-HEAD-MENU",
		"a.menu",
		"ul.NAV-HEAD-SUBMENU",
		$(this).index(".NAV-HEAD-MENU ul.NAV-HEAD-SUBMENU")
	);
});
/*导航尾下拉菜单*/
$(".NAV-FOOT").mouseenter(function(){
	$(this).addClass("SELECT-on");
}).mouseleave(function(){
	$(this).removeClass("SELECT-on");
});
/*额外下拉菜单*/
if($(".NAV-BODY").size())
$(".NAV-BODY").get(0).timer=0;
$(".NAV-BODY li[data-extra]").map(function(){
	var THIS=this,oDOMnav=$(".NAV-BODY").get(0);
	$(this).mouseenter(function(){
		$(this).addClass("on");
		clearTimeout(oDOMnav.timer);
		oDOMnav.timer=0;
		var index=$(this).data("extra");
		$(".NAV-EXTRA p[data-extra='"+ index +"']").show()
			.siblings().hide();
	}).mouseleave(function(){
		if(!oDOMnav.timer)
		{
			oDOMnav.timer=setTimeout(function(){
				$(THIS).removeClass("on");
				var index=$(THIS).data("extra");
				$(".NAV-EXTRA p[data-extra='"+ index +"']").hide();
			},100);
		}
	});
});
$(".NAV-EXTRA p").map(function(){
	var THIS=this,oDOMnav=$(".NAV-BODY").get(0);
	$(this).mouseenter(function(){
		var index=$(this).data("extra");
		$(".NAV-BODY li[data-extra='"+ index +"']").mouseenter();
	}).mouseleave(function(){
		var index=$(this).data("extra");
		$(".NAV-BODY li[data-extra='"+ index +"']").mouseleave();
	});
});
$(function(){
	if(typeof(CHIfloat)!='undefined' && isIE6())
	CHIfloat(
		".TOOL",
		{
			bottom:0,
			right:function(){
				var width=$(".TOOL").outerWidth(),
					ww=$(window).width()
				if(ww<1060 + parseInt(width*2)) return 0;
				else return Math.floor((ww-1060)/2 - width);
			}
		}
	);
	else
	{
		$(window).on('load resize',function(){
			$(".TOOL").css({
				right:function(){
					var width=$(".TOOL").outerWidth(),
						ww=$(window).width()
					if(ww<1060 + parseInt(width*2)) return 0;
					else return Math.floor((ww-1060)/2 - width);
				}
			});
		});
	}
	$(window).on('load scroll',function(){
		$(".TOOL").css('visibility',($(window).scrollTop() ? 'visible':'hidden'))
	})
	
	//$(".Feedback.CENTERDIV .submit").click(function(){
	//	var FeedBackTable=$(this).closest("dl.CENTERDIV").closest(".CenterDivContainer");
	//	if(true)
	//	{
	//		ALERT("反馈成功！","<h5>感谢您的建议！</h5>");
	//	}
	//	else
	//	{
	//		ALERT("反馈失败！","<h5>请重新提交表单！</h5>",null,function(){
	//			ALERT.JQ.hide().closest(".CenterDivContainer").hide();
	//			FeedBackTable.show();
	//		});
	//	}
    //});
	
	//前台意见反馈验证
	$("#txtContent").blur(function () {
	    var content = $("#txtContent").val().trim();
	    if (content == "") {
	        $("#codeContent").addClass("errorMsg").text("内容不能为空");
	        return false;
	    } else {
	        $("#codeContent").removeClass("errorMsg").text("");
	        return false;
	    }
	});
	$("#txtAccount").blur(function () {
	    var account = $("#txtAccount").val().trim();

	    var remoile = /^([0]{0,1}1\d{10})$/
	    var reemail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
	    if (!(remoile.test(account) || reemail.test(account))) {
	        $("#codeNewAccount").addClass("errorMsg").text("手机或邮箱格式不正确");
	        return false;
	    }

	    if (account != "") {
	        $("#codeNewAccount").removeClass("errorMsg").text("");
	        return false;
	    }
	});
	
});

function fbsubmit() {
    var content = $("#txtContent").val().trim();
    var account = $("#txtAccount").val().trim();

    if (content == "") {
        $("#codeContent").addClass("errorMsg").text("内容不能为空");
        return false;
    }
    if (content.length > 500) {
        $("#codeContent").addClass("errorMsg").text("字数不能大于500");
        return false;
    }
    if (account == "") {
        $("#codeNewAccount").addClass("errorMsg").text("联系方式不能为空");
        return false;
    }

    var remoile = /^([0]{0,1}1\d{10})$/
    var reemail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
    if (!(remoile.test(account) || reemail.test(account))) {
        $("#codeNewAccount").addClass("errorMsg").text("手机或邮箱格式不正确");
        return false;
    }


    var data = { content: content, account: account };
    $.ajax({
        url: "/Ajax/AddFeedBack.aspx",
        data: data,
        cache: false,
        dataType: "html",
        success: function (ajson) {
            var jsonobj = eval("(" + ajson + ")");
            if (!jsonobj.success) {
                ALERT("反馈失败！", "<h5>请重新提交表单！</h5>", null, function () {
                    ALERT.JQ.hide().closest(".CenterDivContainer").hide();
                    FeedBackTable.show();
                });
            } else {
                ALERT("反馈成功！", "<h5>感谢您的建议！</h5>");
            }
        },
        error: function () {
            alert("参数错误");
        }
    });
}

//新增IE6下的顶部鼠标行为
$(".TOP-LOGIN .codes span").hover(function(){
	$(this).find("p").show();
},function(){
	$(this).find("p").hide();
});