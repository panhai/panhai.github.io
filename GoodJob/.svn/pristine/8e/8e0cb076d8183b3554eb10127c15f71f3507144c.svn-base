// 内容管理
//添加/删除导航栏目
function ManageMenus()
{
	var CenterDiv=$(".ManageMenus");
	var Center=CenterDiv.get(0);
	$("caption input").click(function(){
		Center.open();
	});
	CenterDiv.find(".reset").click(Center.close);
	CenterDiv.find("label").click(function(){
		var boxes=CenterDiv.find(":checked");
		var box=$(this).find(":checkbox").get(0);
		if(box.checked && boxes.filter(":checked").size()>4)
		{
			alert("最多选择4个栏目");
			box.checked=false;
		}
	});
	
	CenterDiv.find(".submit").click(function(){
		var boxes=CenterDiv.find(":checkbox");
		var ids_checked=boxes.filter(":checked").map(function(){return this.value;}).toArray().join(',');
		var ids_unchecked=boxes.not(":checked").map(function(){return this.value;}).toArray().join(',');
		//history.go(0);
	});
}
//添加友情链接或修改
function AddLink()
{
	var CenterDiv=$(".AddLink");
	var Center=CenterDiv.get(0)
	var Title=$(".LinkTitle");
	var Url=$(".LinkUrl");
	var curID=0;//当前正在编辑的信息的ID，如果没有则为0
	
	//点击添加按钮
	$(".Btn-AddLink").click(function(){
		Center.open();
		Title.val('');
		Url.val('');
	});
	//点击确定或取消
	$(".submit,.reset",CenterDiv).click(Center.close);
	//点击确定
	$(".submit",CenterDiv).click(function(){
		var title=Title.val(),url=Url.val(),id=curID;
		//异步保存过程
		history.go(0);
	});
	//点击编辑
	$(".last a:first-child").attr('href','javascript:void(0)').click(function(){
		curID=$(this).data("id");
		var tds=$(this).closest("tr").find("td");
		Title.val(tds.eq(0).text());
		Url.val(tds.eq(1).text());
		Center.open();
	});
}
//上传幻灯片
function UploadPPT()
{
	var CenterDiv=$(".UploadPPT");
	var Center=CenterDiv.get(0);
	$(".ppt caption input").click(Center.open);
}