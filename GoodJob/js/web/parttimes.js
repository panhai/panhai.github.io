// 主导航兼职
//所有的下拉列表行为
function AllSelect()
{//timer是在dl上的
	$(".select dt").click(function(){
		var p=$(this).parent().get(0);
		clearTimeout(p.timer);
		p.timer=0;
		$(this).parent().css('zIndex',222)
			.find("dd").addClass("on")
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
		},500);
	}).mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
	});
	//下边只初始化普通的下拉列表的点击行为，它们的内容不会变，地址列表额外初始化
	$(".select").not(".ADDList").find("dd").delegate('a','click',function(){
			var a=$(this),
				DL=a.closest("dl"),
				DT=DL.find("dt"),
				DD=DL.find("dd"),
				input=DL.find("input")
			
			input.val(a.data("id"));
			DT.html(a.html() + '<i></i>');
			DD.removeClass("on");
		})
		.find("a").attr("href","javascript:void(0)");
}
//简单的市区选择
function Districts()
{
	$(".cities input:hidden").change(function(){
		var newid=$(this).val();
		var adds=GetAreas(newid);
		$(".districts").find("dt").html('区域<i></i>')
		.end().find("input:hidden").val('')
		.end().find(".normal").html(function(){
			var str='';
			for(var n=0;n<adds.length;n++)
				str+='<a data-id="'+ adds[n][2] +'" href="javascript:void(0)">'+ adds[n][0] +'</a>';
			return str;
		}).end().find("dt").click();
	});
}
//隐藏信息
function ListHover()
{
	$(".infors li").mouseenter(function(){
		$(this).addClass("on");
	}).mouseleave(function(){
		$(this).removeClass("on");
	});
}
//地址列表的行为
function ADDList()
{
    var blurTimeout = null;
	var Root=$(".ADDList");
	var MainList=$("dd",Root);
	var Static=$(".AddressStatic");
	var Dynamic=$(".AddressDynamic");
	var tabs=$(".ADDTabs");
	var lists=$(".ADDLists");
	var input=Root.find(".address_tip");
	tabs.find("b").click(function(){
		clearTimeout(blurTimeout);
		blurTimeout=0;
		var ind=$(this).index();
		$(this).addClass("cur").siblings().removeClass("cur");
		lists.eq(ind).show().siblings(".ADDLists").hide();
	}).eq(0).click();
	lists.find("div:last-child").css('border',0);
	MainList.delegate("a",'click',function(){
	    if (blurTimeout) { clearTimeout(blurTimeout); }
		var idinput=Root.find("input:hidden");
		var oldid=idinput.val(),newid=$(this).attr("alt");
		idinput.val($(this).attr("alt"));
		if(newid!=oldid) idinput.change();
		input.val($(this).text());
		MainList.removeClass("on");
	});
	
	var normal=$("<div>").addClass("normal");
	
	input.focus(function(){
		this.select();
		Static.show();
		Dynamic.hide();
	}).keyup(function(){
		var key=this.value;
		if(!key)
		{
			Static.show();
			Dynamic.hide();
			return;
		}
		var ads=GetAreasByRegexp(key);
		var str='';
		Static.hide();
		if(ads.length)
		{
			var cnt=0;
			for(var n in ads)
			{
				cnt++;
				str+='<a href="javascript:void(0)" alt="'+ ads[n][2] +'">'+ ads[n][0] +'</a>';
				//if(cnt>5) break;
			}
			Dynamic.html(str);
		}
		else
		{
			Dynamic.html('对不起找不到，'+ key);
		}
		Dynamic.show();
	}).blur(function () {
	    var key = this.value;
	    blurTimeout = setTimeout(function () {
	        var cityId = getAreaIDByCityName(key);
	        Root.find("input:hidden").val(cityId);
	        MainList.removeClass("on");
	    }, 200);
	});
}