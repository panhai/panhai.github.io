//附加标签
function CenterCheckboxList(JQstr)
{
	var CenterDiv=$(".CenterDiv").filter(JQstr);//对应的中心层
	var AddupDiv=$(".addup").filter(JQstr);//对应的收集标签
	var IdsInput=AddupDiv.find("input");//对应的ID保存域
	var Contents=CenterDiv.find(".CenterContents li");//对应的内容区
	//点击对应的按钮，打开
	$(".CenterStart").filter(JQstr).click(function(){
		CenterDiv.get(0).open(this);
	});
	
	var labelID,//未合作过/被拒绝过/取消合作过的标识
		typeID,//全部学校/高等院校/中等职业学校/教育培训学校/其它学校
		keyStr,//搜索的关键字
		pageNum;//页码
	
	//点击标签头，如果有内容则不刷新，如果没有内容则刷新（不清空其它标签页）
	var labels=CenterDiv.find(".CenterLabels li").click(function(){
		labelID=$(this).attr("alt");
		var index=$(this).index();
		var con=Contents.eq(index);
		if(con.is(":empty")) AjaxLabels(false);
	});
	labelID=labels.eq(0).attr("alt");
	
	//点击下拉列表时刷新
	var opts=CenterDiv.find(".CenterSelect dd a").click(function(){
		typeID=$(this).attr("alt");
		AjaxLabels(true);//需要清空未显示区
	}).attr('href','javascript:void(0)');
	typeID=opts.eq(0).attr("alt");
	
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
		input.checked=!input.checked;
		if(input.checked)
		{
			$(this).addClass("checked");
			InsertId(input);
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
	function InsertId(checkbox)
	{
		var id=checkbox.value;
		var ids=IdsInput.val();
		if(!ids)IdsInput.val(id);
		else
		{//判断新旧ID以防止未知的错误
			if((','+ids+',').indexOf(','+id+',')>=0)return;
			IdsInput.val(ids+','+id);
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
		if(!ids)AddupDiv.closest(".form-line").hide();
	}
	//未来绑定，标签上点关闭，就删除一个ID
	AddupDiv.delegate('a q','click',function(){
		var a=$(this).parent();
		var id=a.attr('alt');
		a.remove();
		RemoveId(id,'addup');
	});
}

//地址列表的行为
function CitiesList()
{
	var Root=$(".CitiesList");
	var MainList=$("dd",Root);
	var Static=$(".AddressStatic");
	var Dynamic=$(".AddressDynamic");
	var tabs=$(".ADDTabs");
	var lists=$(".ADDLists");
	var input=Root.find(".address_tip");
	tabs.find("b").click(function(){
		var ind=$(this).index();
		$(this).addClass("cur").siblings().removeClass("cur");
		lists.eq(ind).show().siblings(".ADDLists").hide();
	}).eq(0).click();
	lists.find("div:last-child").css('border',0);
	MainList.undelegate('a','click').delegate("a",'click',function(){
		Root.find("input:hidden").val($(this).attr("alt"));
		input.val($(this).text());
		MainList.removeClass("on");
		Root.removeClass("on");
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
	});
}

//初始化地址，只根据各自input的值来初始化
function AddressInit()
{
	$(".ADDList").map(function(ind,ele){
		var T=$(ele),
			dt=T.find("dt"),
			dd=T.find("dd"),
			adds=T.find(".addresses"),
			input=T.find("input"),
			id=input.val();
		
		var key=[0,0];
		if(T.hasClass("province")) key=['p','省份'];
		else if(T.hasClass("cities")) key=['c','城市'];
		else if(T.hasClass("districts")) key=['d','区域'];
		else if(T.hasClass("hots")) key=['b','商圈'];
		
		ele.name=key[1];
		ele.key=key[0];
		//还原隐藏域及DT中的内容
		ele.reset=function(){
			$(this).find("input").val('').change();
			this.setDT();
		}
		//根据自身的隐藏域的值，设置DT中的内容
		ele.setDT=function(str){
			if(!str)
			{//参数为空就初始化文字
				str='<span>请选择'+ this.name +'</span><i></i>';
				$(this).find("dt").html(str).attr('title','');
			}
			else
			{//有地址名就显示地址名，并给提示
				$(this).find("dt").html(str + '<i></i>').attr('title',str);
			}
		}
		//用自身ID填充地址列表，并显示地名
		ele.fillWithMe=function(){
			var me=$(this).find("input").val();
			if(me)
			{
				var myArr=GetArea(me);
				this.setDT(myArr[0]);
				var par=myArr[1];
				this.fillWithPar(par);
			}
			else
			{
				$(this).find(".address").empty();
				this.setDT();
			}
		}
		//用上级ID填充地址列表，并初始化提示
		ele.fillWithPar=function(par){
			if(par!=undefined)
			{
				var arrs=this.key=='b' ? GetDistricts(par) : GetAreas(par);
				AddressFill(arrs,T);
				if(!par)this.setDT();
			}
			else $(this).find(".address").empty();
		}
		if(id) ele.fillWithMe();
		else if(key[0]=='p') ele.fillWithPar(0);
		else ele.reset();
	});
}
//填充地址列表，将参数arr中的内容，填充到DL的.addresses中
function AddressFill(arr,DL)
{
	var dl=DL.get(0);
	var ads=DL.find(".addresses");
	var str='';
	for(var n=0;n<arr.length;n++)
	{
		var add=arr[n];
		if(!add) continue;
		str+='<a href="javascript:void(0)" alt="'+ add[2] +'" title="'+ add[0] +'">'+ add[0] +'</a>';
	}
	ads.html(str);
	
	//给地址列表增加行为
	var input=DL.find('input'),
		DD=DL.find("dd");
	DL.find(".addresses a").click(function(){
		var priID=input.val();
		var a=$(this).blur(),
			newID=a.attr("alt"),
			remain=newID==priID;
		if(!remain)
		{
			input.val(newID).change();
			dl.setDT(a.html());
		}
		DD.removeClass("on");
		AddressNext(DL,remain);
	});
}
//初始化下级地址列表，DL是刚刚触发的dl的JQ对象
function AddressNext(DL,remain)
{//区域及商圈不涉及下级
	var dl=DL.get(0);
	if(!DL.next().size() || dl.name=='商圈')return;
	var NEXT=DL.next();
	if(dl.name!='区域')
	{
		var next=NEXT.get(0),
			par=DL.find("input").val();
		
		if(!remain)
		{//如果上级变化了，下级就要还原
			next.fillWithPar(par);
			DL.nextAll().map(function(ind,ele){
				//ele.setDT();
				if(ele.tagName.toLowerCase()=='dl')ele.reset();
			});
			if(DL.get(0).key=='p' && DL.nextAll(".districts").size())
			{//省值变，要清空区
				DL.nextAll(".districts").find(".addresses").empty();
			}
		}
	}
	NEXT.find("dt").click();
}
//所有的下拉列表行为
function AllSelect()
{//timer是在dl上的
	$(".select dt").click(function(){
		var p=$(this).parent().get(0);
		clearTimeout(p.timer);
		p.timer=0;
		var v=$(this).parent().find("input:hidden").val();
		$(this).parent().css('zIndex',222)
			.find("dd").addClass("on")
			.find("a").removeClass("cur")
			.filter("[alt='"+ v +"']").addClass("cur")
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
		},($(t).hasClass("JOBS") ? 1500 : 500));
	}).mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
	});
}
//附加福利
function AddUp(ItemClass)
{
	var I=$(".addup"+ ItemClass +" input");
	var LI=$(".addup"+ ItemClass).closest("li");
	function init(){
		if($(".addup"+ ItemClass +" a").size())
		{
			var x=$(".addup"+ ItemClass +" a span").map(function(){return $(this).text();});
			I.val(x.get().join(","));
			LI.show();
		}
		else{
			LI.hide();
			I.val('');
		}
	}
	init();
	$(".addup"+ ItemClass).delegate('a q','click',function(){
		var T=$(this).parent();
		var t=T.find("span").text();
		T.remove();
		init();
	});
	var N=$(".add-text"+ ItemClass);
	$(".add-btn"+ ItemClass).click(function(){
		var t=N.val();
		if(t)
		{
			var arr=I.val().split(',');
			for(var i=0;i<arr.length;i++)
			{
				if(arr[i]==t){alert('该项目已经存在！');return false;}
			}
			if(arr[0])arr.push(t);
			else arr[0]=t;
			I.val(arr.join(','));
			$('<a><span>'+ t +'</span><q>&times;</q></a>').appendTo(".addup"+ ItemClass);
			LI.show();
			N.val("");
		}
		else
		{
			alert("请输入名称！");
		}
	});
}
//点击添加企业 
function FormTip()
{
	$(".form-tip").click(function(){
		$(this).parent().hide().next().show();
		$(".CenterDiv").map(function(){this.close()});
	});
}
//地址列表的行为
function ADDList()
{
	var Root=$(".CenterDiv .ADDList");
	var MainList=$("dd",Root);
	var Static=$(".AddressStatic");
	var Dynamic=$(".AddressDynamic");
	var tabs=$(".ADDTabs");
	var lists=$(".ADDLists");
	var input=Root.find(".address_tip");
	tabs.find("b").click(function(){
		var ind=$(this).index();
		$(this).addClass("cur").siblings().removeClass("cur");
		lists.eq(ind).show().siblings(".ADDLists").hide();
	}).eq(0).click();
	lists.find("div:last-child").css('border',0);
	MainList.delegate("a",'click',function(){
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
			for(var n=0;n<ads.length;n++)
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
		Dynamic.show().closest("dd").css("width","auto");
	});
}