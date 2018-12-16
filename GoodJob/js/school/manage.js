// 系统管理
/*
编辑学院下的科系
*/
function Profession()
{
	//点击“编辑”
	$(".prof .odd .last a").attr('href','javascript:void(0)')
		.filter(":nth-of-type(2)").click(function(){
			var td=$(this).closest(".odd").next().find("td:only-child");
			var tags=td.find(".tags");
			var container=td.find(".clear");
			var i=container.find("i");
			if(tags.IN(container)) return;
			tags.insertAfter(i);
			container.show();
		});
	//每个标签点叉
	$(".prof .even").delegate('span q','click',function(){
		var input=$(this).closest(".clear").find("input").get(0);
		var id=$(this).parent().data("id");
		if(!input.value) input.value=id;
		else input.value+=','+id;
		$(this).parent().hide();
	});
	//按钮地址归空
	$(".prof .btns a").attr('href','javascript:void(0)');
	//点击“确定”，将隐藏者删除
	$(".prof .submit").click(function(){
		$(this).closest(".clear").find("span:hidden").remove();
		var ids=$(this).closest(".clear").find("input").val();
		/*
			这里放删除的过程
		*/
		reTidy(this);
	});
	//点击“取消”，将隐藏者显示
	$(".prof .reset").click(function(){
		$(this).closest(".clear").find("span:hidden").show();
		reTidy(this);
	});
	//无论点击“确定”或“取消”，都将域值清空，并将标签容器移出背景层，并隐藏背景层
	function reTidy(target)
	{
		var par=$(target).closest(".clear");
		par.find("input").val('')
			.end()
			.find(".tags").insertBefore(par);
		par.hide();
	}
}
//点击添加专业
function AddProf()
{
	var CenterDiv=$(".AddProf");
	var Center=CenterDiv.get(0);
	var AddFrom='';
	var theID;//院校的ID
	$(".prof .odd .last a").filter(":nth-of-type(1)").click(function(){
		Center.open();
		theID=$(this).data("id");
		//AddFrom=$(this).closest(".odd").next().find(".tags");
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			var newName=CenterDiv.find(".text").val();//添加的名字
			history.go(0);//刷新页面
		});
}
//点击添加院校
function AddCollege()
{
	var CenterDiv=$(".AddColl");
	var Center=CenterDiv.get(0);
	var AddFrom='';
	$(".Btn-AddColl").click(function(){
		Center.open();
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			var newName=CenterDiv.find(".text").val();//添加的名字
			history.go(0);//刷新页面
		});
}
//点击修改院校
function EditCollege()
{
	var CenterDiv=$(".EditColl");
	var Center=CenterDiv.get(0);
	var AddFrom='';
	var theID;
	$(".prof .odd .first img").click(function(){
		Center.open();
		theID=$(this).data("id");
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			var newName=CenterDiv.find(".text").val();//添加的名字
			history.go(0);//刷新页面
		});
}
//点击修改院校
function DeleteCollege()
{
	var CenterDiv=$(".DelColl");
	var Center=CenterDiv.get(0);
	var AddFrom='';
	var theID;
	var theName;
	$(".prof .odd .last a").filter(":last-of-type").attr('href','javascript:void(0)').click(function(){
		Center.open();
		theID=$(this).data("id");
		theName=$(this).closest(".odd").find(".first strong").text();
		CenterDiv.find(".CenterTip b").html(theName);
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			//删除过程
			history.go(0);//刷新页面
		});
}
//点击添加管理员
function AddAdmin()
{
	var CenterDiv=$(".AddAdmin");
	var Center=CenterDiv.get(0);
	$(".Btn-AddAdmin").click(function(){
		Center.open();
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			//这块就序列化后提交吧……
			history.go(0);//刷新页面
		});
}
//修改管理员密码
function EditPassword()
{
	var CenterDiv=$(".Password");
	var Center=CenterDiv.get(0);
	var theID;
	$(".admins .last a.password").attr('href','javascript:void(0)').click(function(){
		Center.open();
		theID=$(this).data("id");
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			var newPass=CenterDiv.find(".text").val();
			history.go(0);//刷新页面
		});
}
//解除绑定
function Unbind()
{
	var CenterDiv=$(".Unbind");
	var Center=CenterDiv.get(0);
	var AddFrom='';
	var theID;
	var theName;
	$(".admins .last a").filter(":last-of-type").attr('href','javascript:void(0)').click(function(){
		Center.open();
		theID=$(this).data("id");
		theName=$(this).closest("tr").find("h3").text();
		CenterDiv.find(".CenterTip b").html(theName);
	});
	CenterDiv.find(".reset").click(Center.close)
		.end()
		.find(".submit").click(function(){
			//解绑过程
			history.go(0);//刷新页面
		});
}