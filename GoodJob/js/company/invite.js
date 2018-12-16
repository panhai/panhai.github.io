//附加标签，当single=false时，condition是当前窗激活条件；当single=true时，condition是当前域的change事件处理程序
function CenterCheckboxList(JQstr,single,condition)
{
	var CenterDiv=$(".CenterDiv").filter(JQstr);//对应的中心层
	var AddupDiv=$(".addup").filter(JQstr);//对应的收集标签
	var IdsInput=AddupDiv.find("input");//对应的ID保存域
	if(single && condition) IdsInput.change(condition);
	var Contents=CenterDiv.find(".CenterContents li");//对应的内容区
	//点击对应的按钮，打开
	$(".CenterStart").filter(JQstr).click(function(){
		if(!single && condition)
		{
			var b=condition();
			if(!b)
			{
			    if ($(this).hasClass("jobs")) { alert("请先选择学校！"); }
			    else { alert("请先选择职位！"); }
				return;
			}
		}
		CenterDiv.closest(".form-line").show();
		CenterDiv.get(0).open(this);
		$(".CenterDiv").not(CenterDiv).map(function(){$(this).find("dt q").click()});
	});
	CenterDiv.find("dt q").click(function(){
		CenterDiv.closest(".form-line").hide();
	});
	
	var labelID,//未合作过/被拒绝过/取消合作过的标识
		typeID,//全部学校/高等院校/中等职业学校/教育培训学校/其它学校
		keyStr,//搜索的关键字
		pageNum;//页码
	
	//点击标签头，如果有内容则不刷新，如果没有内容则刷新（不清空其它标签页）
	var labels=CenterDiv.find(".CenterLabels li");
	if(labels.size())
	{
		labels.click(function(){
			labelID=$(this).attr("alt");
			var index=$(this).index();
			var con=Contents.eq(index);
			if(con.is(":empty")) AjaxLabels(false);
		});
		labelID=labels.eq(0).attr("alt");
	}
	else labelID=0;
	
	//点击下拉列表时刷新
	var opts=CenterDiv.find(".CenterSelect dd a");
	if(opts.size())
	{
		opts.click(function(){
			typeID=$(this).attr("alt");
			AjaxLabels(true);//需要清空未显示区
		}).attr('href','javascript:void(0)');
		typeID=opts.eq(0).attr("alt");
	}
	else typeID=0;
	
	//点击搜索时刷新
	CenterDiv.find(".CenterTopicBtn").click(function(){
		keyStr=CenterDiv.find(".CenterTopicText").val();
		AjaxLabels(true);//需要清空未显示区
	});
	keyStr='';
	
	//使用未来绑定分页，点击分页时刷新
	Contents.delegate(".pages2 a",'click',function(){
		pageNum=$(this).attr("alt");
		AjaxLabels(false);//不需要清空未显示区
	});
	Contents.find(".pages2 a").attr('href','javascript:void(0)');
	pageNum=1;
	
	//刷新当前标签页的内容区，同时刷新选项及分页
	function AjaxLabels(empty)
	{
		//这前边写调用数据的过程
		var content='<div class="CenterLabelsContainer">这里放调用出来的内容<br>lableID='+ labelID +'<br>typeID='+ typeID +'<br>keyStr='+ keyStr +'<br>pageNum='+ pageNum +'<br>empty='+ empty +'</div><div class="pages2">分页</div>';
		function FillIn()//直接将本函数调用于AJAX完成时
		{//只填充当前显示的标签内容
			Contents.filter(":visible").html(content)
				.find(".pages2 a").attr('href','javascript:void(0)');
			if(empty) Contents.filter(":hidden").empty();
			CheckAllIds();
		}//FillIn();
	}
	//根据隐藏域的值，选中所有应该被选中的框
	function CheckAllIds()
	{
		var ids=IdsInput.val();
		if(!ids)return;
		ids=','+ids+',';
		CenterDiv.find(":checkbox").map(function(ind,ele){
			var v=','+ele.value+',';
			if(ids.indexOf(v)>=0)
			{
				ele.checked=true;
				$(ele).parent().addClass("checked");
			}
			else
			{
				ele.checked=false;
				$(ele).parent().removeClass("checked");
			}
		});
	}
	//未来绑定所有标签，点击后插入新值或删除值
	CenterDiv.delegate("label",'click',function(){
		var input=$(this).prev("input").get(0);
		if (single && IdsInput.val() == input.value) {
		    CenterDiv.find("q").click();
		    return;
		}
		else input.checked = !input.checked;
		if(input.checked)
		{
			if(single)//单选模式下，取消同级选择，并关闭
			{
				$(this).closest(".single").find('label').removeClass('checked')
					.find("input").not(input).map(function(ind,ele){ele.checked=false;});
				CenterDiv.find("q").click();
			}
			$(this).addClass("checked");
			InsertId(input,single);
		}
		else
		{
			$(this).removeClass("checked");
			RemoveId(input.value,'label');
		}
	})//未来绑定所有复选框，点击后插入新值或删除值
	.delegate(':checkbox','click',function(){
		var label=$(this).next('label');
		if(this.checked)
		{
			label.addClass("checked");
			InsertId(this);
		}
		else
		{
			label.removeClass("checked");
			RemoveId(this.value,'label');
		}
	});
	//插入一个新的ID，一定是从label处触发
	function InsertId(checkbox,single)
	{
		var id=checkbox.value;
		if(single)
		{////新加的单选模式
			if(IdsInput.val!=id) IdsInput.change();
			IdsInput.val(id);
			AddupDiv.find("a").remove();
		}
		else
		{//多选模式
			var ids=IdsInput.val();
			if(!ids)IdsInput.val(id);
			else
			{//判断新旧ID以防止未知的错误
				if((','+ids+',').indexOf(','+id+',')>=0)return;
				IdsInput.val(ids+','+id);
			}
		}
		CenterDiv.find(":checkbox").map(function(ind,ele){
			if(ele.value==id)
			{
				ele.checked=true;
				$(ele).next("label").addClass("checked");
			}
		});
		AddupDiv.append('<a alt="'+ id +'"><span>'+ $(checkbox).next().text() +'</span><q>&times;</q></a>');
		AddupDiv.closest(".form-line").show();
	}
	//删除一个ID，可能是从label处触发，或从addup的标签上触发
	function RemoveId(id,from)
	{
		switch(from)
		{
			case "label":
				AddupDiv.find("a[alt="+ id +"]").remove();
			case "addup":
				CenterDiv.find(":checkbox").map(function(ind,ele){
					if(ele.value==id)
					{
						ele.checked=false;
						$(ele).next("label").removeClass("checked");
					}//不可强行终止遍历，因为可能有多个
				});
		}
		var ids=','+IdsInput.val()+',';
		ids=ids.replace(','+id+',','');
		ids=ids.substring(1,ids.length-1);
		if(ids==',')ids='';
		IdsInput.val(ids);
		if(!AddupDiv.find("a").size()) AddupDiv.closest(".form-line").hide();
	}
	//未来绑定，标签上点关闭，就删除一个ID
	AddupDiv.delegate('a q','click',function(){
		var a=$(this).parent();
		var id=a.attr('alt');
		a.remove();
		RemoveId(id,'addup');
	});
}

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
//先选学校/职位的切换
function LabelSwitch()
{
	var Schools=$("ul.form-schools");
	var Jobs=$("ul.form-jobs");
	$(".labels li").click(function(){
		var want=$(this).data("switch");
		$(this).addClass("cur").siblings().removeClass("cur");
		if(want=="schools")
			Schools.insertBefore(Jobs);
		else Jobs.insertBefore(Schools);
	}).eq(0).click();
}