// HR收藏夹
//顶下拉列表
function Selects()
{
	$(".form-select").map(function(ind,ele){
		var T=$(ele),ul=T.find("ul"),div=T.children("div");
		T.mouseenter(function(){
			ul.show();
			div.show();
		}).mouseleave(function(){
			ul.hide();
			div.hide();
		});
		ul.find("li a").click(function(){
		    var s = $(this).text();
		    var v = $(this).data("id");
		    //T.find(".form-hidden").val(s);
		    T.find(".form-hidden").val(v);
		    T.find("span").html(s);
			ul.hide();
		});
		
	});
}

//全选动作，参数为复选组的name值，不带参则选中页面所有
function CheckAll(name)
{
	$("#check-all").click(function(){
		var ts;
		if(name) ts=document.getElementsByName(name);
		else ts=$(":checkbox").toArray();
		for(var n in ts)
		{
			ts[n].checked=this.checked;
		}
	});
}

//显示添加删除分类
function ShowCenter()
{
	$(".f_add,.f_del").click(function(){
		display(this.className.replace("f_","."));
	});
	$(".cover .reset").click(function(e){close(e);});
	var W=$(window);
	
	function display(name)
	{
		alphabg.open(function(){
			var T=$(".cover").has(name);
			var nt=(W.height() - T.height())/2 +'px';
			var nl=(W.width() - T.width())/2 +'px';
			var it=isIE6() ? 'marginTop': 'top';
			T.css(it,nt).css("left",nl).fadeIn();
		});
	}
	
	function close(e)
	{
		var t=$(e.target);
		var T=t.closest(".cover");
		T.fadeOut('',function(){
			alphabg.close();
		});
	}
}

//触发添加分类
function FireAdd()
{
	$(".add .submit").click(function(e){
		e.preventDetault();
		var newName=$(".newone").val();
		var OK=true;
		if(OK)
		{
			alert("添加成功")
		}
		else
		{
			alert("添加失败");
		}
		$(this).siblings(".reset").click();
	});
}

//触发删除分类
function FireDel()
{
	$(".del .submit").click(function(e){
		e.preventDefault();
		var ids=$(".del :checked").map(function(){return this.value;}).get().join(',');
		var OK=true;
		if(OK)
		{
			alert("删除成功")
		}
		else
		{
			alert("删除失败");
		}
		$(this).siblings(".reset").click();
	});
}
//地址列表的行为
function ADDList()
{
    var blurTimeout = null;
	var Root=$(".ADDList");
	var MainList=Root//$("dd",Root);
	var Static=$(".AddressStatic");
	var Dynamic=$(".AddressDynamic");
	var tabs=$(".ADDTabs");
	var lists=$(".ADDLists");
	var input=$(".address_tip");
	var idinput=Root.closest(".form-select").find("input:hidden");
//	Static.find("a").click(function(){
//		input.val($(this).html());
//		idinput.val($(this).attr('alt'));
//		Root.mouseleave();
//	});
	tabs.find("b").click(function(){
		clearTimeout(blurTimeout);
		blurTimeout=0;
		var ind=$(this).index();
		$(this).addClass("cur").siblings().removeClass("cur");
		lists.eq(ind).show().siblings(".ADDLists").hide();
	}).eq(0).click();
	lists.find("div:last-child").css('border',0);
	MainList.delegate("a",'click',function(){
		input.val($(this).html());
		idinput.val($(this).attr('alt'));
		Root.mouseleave();
//	    if (blurTimeout) { clearTimeout(blurTimeout); }
//		Root.find("input:hidden").val($(this).attr("alt"));
//		input.val($(this).text());
//		MainList.removeClass("on");
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