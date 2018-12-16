// 有关于简历页面的方法
var InviteTemplates = [], NotmatchTemplates = [], RequestTemplates = [];//分别对应邀请面试模板，不合适模板，投简历邀请模板
$(function(){
	//点击日历后选择日期直接刷新页面,功能已在页面实现
	//$("#calendar,.calendar").click(function(){
	//	var dom=$("#calendar").get(0)
	//	JBCalendar.show(dom,{},function(){
	//		location.href='#'+$("#calendar").val();
	//	})
	//});
    //点击发送邀请按钮,功能已在页面实现
	//$(".Invitation .submit").click(function(){
	//	var id=$(this).closest(".CENTERDIV").data("id"),
	//		name=$(this).closest(".CENTERDIV").data("name");
	//	CONFIRM('发送面试邀请','<h6>真的要给 # '+ name +' # 发送面试邀请吗？</h6>','确认发送',function(){
	//		if(false)
	//		{//正常发送
	//			alert('发送过程');
	//			CENTERDIV.close.call(CONFIRM.JQ.get(0),true);
	//		}
	//		else
	//		{//余额不足
	//			CONFIRM('发送面试邀请','<h5>发送失败！</h5><samp>账户余额不足，请充值后再发邀请！</samp>','账户充值',function(){
	//				location.href='new-other-charge.html';
	//			});
	//		}
	//	});
	//});
    //点击发送拒绝按钮,功能已在页面实现
	//$(".NotMatch .submit").click(function(){
	//	var id=$(this).closest(".CENTERDIV").data("id"),
	//		name=$(this).closest(".CENTERDIV").data("name");
	//	CONFIRM('不合适','<h6>真的要给 # '+ name +' # 发送不合适通知吗？</h6>','确认发送',function(){
	//		if(true)
	//		{//正常发送
	//			alert('发送过程');
	//			CENTERDIV.close.call(CONFIRM.JQ.get(0),true);
	//		}
	//		else
	//		{//余额不足
	//			CONFIRM('不合适','<h5>发送失败！</h5><samp>账户余额不足，请充值后再发通知！</samp>','账户充值',function(){
	//				location.href='new-other-charge.html';
	//			});
	//		}
	//	});
	//});

    //点击调整时间,功能已在页面实现
	//$(".TimeChange .submit").click(function(){
	//	var CENTER=$(this).closest(".CENTERDIV"),
	//		id=CENTER.data("id"),
	//		name=CENTER.data("name"),
	//		date=$(".Date",CENTER).val(),
	//		hour=$(".Hour input[type=hidden]",CENTER).val(),
	//		minute=$(".Minute input[type=hidden]",CENTER).val(),
	//		time=date+' '+hour+':'+minute;
	//	CONFIRM('调整面试时间','<h6>确定将与 # '+ name +' # 的面试时间调整为'+ time +'</h6>','确定调整',function(){
	//		alert("调整过程");
	//	});
	//});
	
	//发投简历邀请改变模版时
    $(".Request .Templates").find("dt").click(function () {
        var _this = this;
        $.ajax({
            url: adminRootPath() + "/ajax.html",
            data: { cmd: "invitetemplate" },
            cache: false,
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    RequestTemplates = data.data;
                    $(_this).siblings("dd").html(function () {
                        var str = [];
                        for (var n = 0; n < RequestTemplates.length; n++)
                            str.push('<a href="javascript:void(0)" data-id="', RequestTemplates[n].id, '">', RequestTemplates[n].title, '</a>');
                        return str.join('');
                    });
                }
            }
        });
	}).end()
	.find("input[type='hidden']").change(function(){
		var id=$(this).val();
		for(var n=0;n<RequestTemplates.length;n++)
		{
			var temp=RequestTemplates[n];
			if(temp.id!=id) continue;
			$(".Request .Content").val(temp.content);
			break;
		}
	});
	//点击投简历邀请的发送邀请按钮，功能已在页面实现
	//$(".Request .submit").click(function(){
	//	var id=$(this).closest(".CENTERDIV").data("id"),
	//		name=$(this).closest(".CENTERDIV").data("name");
	//	CONFIRM('发邀请信','<h6>真的要给 # '+ name +' # 发送投简历邀请吗？</h6>','确认发送',function(){
	//		if(true)
	//		{//正常发送
	//			alert('发送过程');
	//			CENTERDIV.close.call(CONFIRM.JQ.get(0),true);
	//		}
	//		else
	//		{//余额不足
	//			CONFIRM('发邀请信','<h5>发送失败！</h5><samp>账户余额不足，请充值后再发通知！</samp>','账户充值',function(){
	//				location.href='new-other-charge.html';
	//			});
	//		}
	//	});
	//});
	//新增图标效果
	$(".profile h4").find("ins,kbd").hover(function(){
		$(this).addClass("on");
	},function(){
		$(this).removeClass("on");
	});
});
//$(window).load(function(){
//	CHIpros(".infors var,.Infors var",'','',true);
//});
