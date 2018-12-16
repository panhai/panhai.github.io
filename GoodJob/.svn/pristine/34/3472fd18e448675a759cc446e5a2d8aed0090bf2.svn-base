//职位管理
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
//清除所有列表中最后一个元素的下边框
function ClearBorder(JQstr)
{
	$(JQstr).children().last().css("border","0")
}

//附加下拉框
function Blockquote()
{
	$("kbd samp").click(function(){
		var t=$(this);
		if(t.hasClass('on'))
		{
			t.removeClass().closest("dd").find("blockquote").hide()//.slideUp();
		}
		else
		{
			t.addClass('on').closest("dd").find('blockquote').show()//.slideDown();
		}
	});
}

//各种取消操作的询问
function ConfirmAsk(JQstr, CenterJQ, option) {
    var CenterDiv = $(CenterJQ);
    var Center = CenterDiv.get(0);
    if (typeof (option) == "undefined") { option = {}; }
    var id;
    $(JQstr).attr('href', 'javascript:void(0)').click(function () {
        if (option.beforeShow) { option.beforeShow(); }
        Center.open();
        id = $(this).data("id");
    });
    $(".reset", CenterDiv).click(function () {
        CenterDiv.find("dt q").click();
    });
}

function CombindCenterDiv(FireJQ,CenterJQ)
{
	$(FireJQ).attr("href","javascript:void(0)").click(function(){
		$(CenterJQ).get(0).open();
	});
}

//校企合作取消
function CancelsInit()
{
	var T=$(".Cancels");
	var choices=T.find(".CenterChoices");
	var tags=T.find('.CenterTags');
	//标签上点击叉
	tags.delegate('a q','click',function(){
		var id=$(this).parent().find("input").val();
		choices.find("input").map(function(ind,ele){
			if(ele.value==id)
			{
				ele.checked=false;
				return false;
			}
		})
		$(this).parent().remove();
	});
	//列表中选中及取消
	choices.delegate("label",'click',function(){
		var box=$(this).find("input").get(0);
		var id=box.value;
		var title=$(this).text();
		if(box.checked)
		{
			tags.append('<a><input type="hidden" value="'+ id +'">'+ title +'<q>&times;</q></a>');
		}
		else
		{
			tags.find('input').map(function(ind,ele){
				if(ele.value==id)
				{
					$(ele).parent().remove();
					return false;
				}
			});
		}
	});
	//点击“取消合作”，将对应的信息塞入中心层中
	$("ins p a").click(function(){
		var VAR=$(this).closest("dd").find("var")
		var jobID=VAR.data("id");
		var jobName=VAR.text();
		T.find("h3").html("职位："+jobName)
			.end().find(".jobID").val(jobID);
		choices.empty().append(VAR.nextAll("blockquote").find("span").map(function(ind,ele){
			return '<li><label><input type="checkbox" value="'+ $(ele).data("id") +'"> '+ $(ele).text() +'</label></li>';
		}).get().join(''));
	});
	//在过滤框中输入
	T.find(".filter-text").keyup(function(){
		var key=this.value;
		choices.find("li").not(":contains("+ key +")").hide();
		choices.find("li:contains("+ key +")").show();
	});
	//点击确定，返回ID串
	T.find(".submit").click(function(){
		var ids=tags.find("input").map(function(){return this.value;}).get().join(',');
		alert(ids);
	});
	T.find(".reset").click(function(){
		T.find(".CenterTopic q").click();
	});
}
//推荐职位……
function PushSet()
{
	var PushDiv=$(".PushDiv"),ConfirmDiv=$(".ConfirmDiv");
	var Push=PushDiv.get(0);
	var id,money,message;//分别代表职位的ID，出价，是否需要短信通知
	$("ins p a:last-child").attr('href','javascript:void(0)').click(function(){
		id=$(this).data("id");
		function SetItems()
		{
			$(".hour",PushDiv).html();//小时
			$(".minute",PushDiv).html();//分
			$(".second",PushDiv).html();//秒
			$(".area",PushDiv).html();//区域
			$(".sort",PushDiv).html();//职能
			$(".reference",PushDiv).html();//参考价格
			$(".lowest",PushDiv).html();//最低起价
			$(".charge",PushDiv).html();//余额
			Push.open();
		}
		SetItems();
	});
	PushDiv.find(".reset").click(Push.close);
	PushDiv.find(".submit").click(function(){
		money=$("input.money").val();//价格
		message=$(".message").get(0).checked;//是否要短信通知
		ConfirmDiv.find(".money").html(money);
		PushDiv.hide();
		ConfirmDiv.get(0).open();
	});
	ConfirmDiv.find(".reset").click(ConfirmDiv.get(0).close);
	ConfirmDiv.find(".submit").click(function(){
		
	});
}