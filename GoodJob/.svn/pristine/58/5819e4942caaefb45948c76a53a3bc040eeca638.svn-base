//附加标签
function CenterCheckboxList(JQstr)
{
	//点击学校筛选
	var CenterDiv=$(".CenterDiv").filter(JQstr);
	var Center=CenterDiv.get(0);
	var labels=$(".CenterContents label",CenterDiv);
	var boxes=$(".CenterContents :checkbox",CenterDiv);
	var addup=$(".addup").filter(JQstr);
	
	//存放学校ID列表的隐藏域
	var ids_input=addup.find("input");
	//因为这个是发布页，所以只在点击展开时才有初始化过程
	$(".CenterStart").filter(JQstr).click(function(){
		Center.open(this);
		var ids=','+ids_input.val()+',';
		boxes.map(function(ind,ele){
			ele.checked=ids.indexOf(','+ele.value+',')>=0;
		});
	});
	//点击某个复选框
	labels.click(function(){
		var input=$(this).find("input").get(0);
		if(isIE6()) input.checked=!input.checked;
		var value=input.value,checked=input.checked;
		boxes.map(function(ind,ele){
			if(ele.value==value)ele.checked=checked;
		});
	});
	//点击确定，才把新选的学校整理出来
	$(".CenterTailBtn",CenterDiv).click(function(){
		var ids=[];
		addup.find("a").remove();
		boxes.filter(":checked").map(function(ind,ele){
			var idstr=','+ids.join(',')+',',v=ele.value;
			if(idstr.indexOf(','+v+',')<0)
			{
				ids.push(v);
				addup.append('<a alt="'+ v +'"><span>'+ $(ele).parent().text() +'</span><q>&times;</q></a>');
			}
		});
		ids_input.val(ids.join(','));
		Center.close();
	});
	//在红色标签上点叉
	addup.delegate('a q','click',function(){
		var T=$(this).parent();
		var ids=','+ids_input.val()+',';
		var newIds=[];
		var id=','+T.attr('alt')+',';
		ids=ids.replace(id,',');
		ids=ids.substring(1,ids.length-1);
		if(ids==',')ids='';
		ids_input.val(ids);
		T.remove();
	});
	var curAlt='all',curKey='';
	var normalContent=$('.CenterContents,.CenterTail',CenterDiv);
	var emptyContent=$(".CenterEmpty",CenterDiv);
	function labelsFilter()
	{
		var rs=labels;
		if(curAlt!='all') rs=rs.filter("."+curAlt);
		if(curKey!='') rs=rs.filter(":contains('"+ curKey +"')");
		if(rs.size())
		{
			emptyContent.hide();
			normalContent.show();
			rs.show();
			labels.not(rs).hide();
		}
		else
		{
			emptyContent.show();
			normalContent.hide();
		}
	}
	//点击搜索按钮
	$(".CenterTopicBtn",CenterDiv).click(function(){
		curKey=$(this).siblings(".CenterTopicText").val();
		labelsFilter();
	});
	//点击下拉列表
	var selects=$(".CenterSelect",CenterDiv);
	selects.find("dd a").click(function(){
		curAlt=$(this).attr('alt');
		labelsFilter();
	});
	//无记录时的清空
	$(".CenterEmptyAction",CenterDiv).click(function(){
		$(".CenterTopicText",CenterDiv).val('');
		curKey='';
		selects.find("dt").html('<span>请选择</span><i></i>');
		curAlt='all';
		labelsFilter();
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
