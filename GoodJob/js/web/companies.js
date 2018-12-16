// 知名企业
function BanCorrect()
{
	var ban=$(".ban");
	var p=ban.find("div");
	p.css('left',(ban.width()-p.width())/2)
}
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
	$(".select").not(".ADDList").find("dd a")
		.attr("href","javascript:void(0)")
		.click(function(){
			var a=$(this),
				DL=a.closest("dl"),
				DT=DL.find("dt"),
				DD=DL.find("dd"),
				input=DL.find("input")
			
			input.val(a.attr("alt"));
			DT.html(a.html() + '<i></i>');
			DD.removeClass("on");
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
		Root.find("input:hidden").val($(this).attr("alt"));
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
	    var key = $(this).val().trim();
	    if (key == "") {
	        Root.find("input:hidden").val("");
	    } else {
	        var cityId = getAreaIDByCityName(key);
	        Root.find("input:hidden").val(cityId);
	    }
	    setTimeout(function () { MainList.removeClass("on"); }, 200);
	    //blurTimeout = setTimeout(function () {
	    //    var cityId = getAreaIDByCityName(key);
	    //    Root.find("input:hidden").val(cityId);
	    //    MainList.removeClass("on");
	    //}, 200);
	});
}