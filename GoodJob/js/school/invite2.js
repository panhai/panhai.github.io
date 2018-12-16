picker-confirm// 新增校企合作-邀请合作
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
		},200);
	}).mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
	});
	//下边只初始化普通的下拉列表的点击行为，它们的内容不会变，地址列表额外初始化
	$(".select").not(".ADDList").find("dd a")
		.attr("href","javascript:void(0)")
		.click(function(){
			if($(this).closest(".multiple").size()==0)
			{//单选的效果
				$(this).closest(".select")
					.find("input:hidden").val($(this).data('id'))
					.end().find("dt").html($(this).html()+'<i></i>')
					.siblings("dd").mouseleave();
			}
			else
			{//多选的效果
				var picker=$(this).closest(".multiple").find(".picker");
				var list=picker.find(".picker-list");
				if($(this).hasClass("has"))
				{//已经选中的取消
					$(this).removeClass("has");
					if($(this).IN("p"))
					{
						if($(this).siblings(".has").size()==0)
						$(this).parent().siblings("var").removeClass("has");
					}
					list.find("[data-id='"+ $(this).data("id") +"']").remove();
				}
				else
				{//没选中的，看情况
					if(list.children().size()==3) alert("最多选择3个");
					//else if(list.find("[data-id='"+ $(this).data("id") +"']").size()>0) alert("该项目已经选中！");
					else
					{
						$(this).addClass("has");
						if($(this).IN("p")) $(this).parent().siblings("var").addClass("has");
						list.append('<li data-id="'+ $(this).data('id') +'"><span>'+ $(this).html() +'</span><q>&times;</q></li>');
					}
				}
			}
		});
	//多选采集的初始化
	if($(".picker").size())
	$(".picker").find(".picker-confirm").click(function(){
		//点击确定按钮
		var list=$(this).siblings(".picker-list");
		var ids=[],names=[];
		list.find("li").map(function(){
			ids.push($(this).data("id"));
			names.push($(this).find("span").text());
		});
		names=names.length ? names.join(',') : '不限';
		ids=ids.length ? ids.join(',') : '';
		$(this).closest(".select").find("input:hidden").val(ids)
			.end().find("dt").html(names+'<i></i>')
			.attr("title",names)
			.siblings("dd").mouseleave();
	})
	.siblings(".picker-unlimit").click(function(){
		$(this).siblings(".picker-list").find("li q").click()
		$(this).closest(".subbie").find("input[type='hidden']").val('')
			.end().find(".picker-confirm").click();
	})
	.siblings(".picker-list").delegate('li q','click',function(){
		var id=$(this).closest("li").data("id");
		$(this).closest(".multiple").find("[data-id='"+ id +"']").click();
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
	    var key = this.value;
	    blurTimeout = setTimeout(function () {
	        var cityId = getAreaIDByCityName(key);
	        Root.find("input:hidden").val(cityId);
	        MainList.removeClass("on");
	    }, 200);
	});
}

////已在页面实现
//function InviteLetter()
//{
//	var CenterDiv=$(".Invitation");
//	var Center=CenterDiv.get(0);
//	$(".last a").click(function(){
//		var ids;
//		if(this.tagName.toLowerCase()=='a') ids=$(this).data("id");
//		else ids=$(":checked").map(function(){
//			return this.value;
//		}).get().join(',');
//		Center.open();
//		$(".InviteIds").val(ids);
//	});
//	CenterDiv.find(".reset").click(function(){
//		CenterDiv.find("dt q").click();
//	});
//}

////已在页面实现
//function Invitation()
//{
//	var CenterDiv=$(".Invitation");
//	var Center=CenterDiv.get(0);
//	$(".last a,.Batch").click(function(){
//		var ids;
//		if(this.tagName.toLowerCase()=='a') ids=$(this).data("id");
//		else ids=$(":checked").map(function(){
//			return this.value;
//		}).get().join(',');
//		Center.open();
//		$(".InviteIds").val(ids);
//	});
//	CenterDiv.find(".reset").click(function(){
//		CenterDiv.find("dt q").click();
//	});
//}