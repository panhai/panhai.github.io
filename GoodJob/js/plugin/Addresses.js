/*
地址联动，基于SELECT及area.js
	可以附加data-parent="上级DL的唯一选择器"，当本隐藏域为空时，会使用上级的隐藏域ID初始化自身列表选项
		如果不附加此项则默认为省级单位，会用所有省名来填充自身列表选项
	可以附加data-child="下级DL的唯一选择器"，当本项被选择时，会自动触发下级的初始化及点击事件
	可以附加data-init="true"，选项列表自动初始化，会根据自身或上级的值来填充本项的选项列表
		某些情况（城市选择器）是不需要初始化选项列表的，无此项则跳过选项的初始化过程，但行为的初始化（激活或初始化下级）过程不会跳过
	可以附加data-unlimited="true"，可以在最开始增加一个选项"不限"
	可以附加data-hot="true"，只显示热门的地名
ADDRESS中的this也指代的是DL.SELECT的DOM元素对象
init()，使用隐藏域的值初始化列表
fill，使用上级ID来填充本身选项列表
empty，将选项列表清空，并reset
*/
var ADDRESS={
	init:function(){
		if($(this).data("init")!='egnore')
		{//需要初始化自身选项列表
			var piID=$(this).find("input[type=hidden]").val(),
				piParID,bFill=true,
				oJQitemsContainer=$(this).find("dd");
			if(piID && piID!='000000')//如果本身有值，则查找同级ID
			{
				piParID=GetArea(piID)[1];
			}
			else//如果本身无值，则查找指定上级
			{
				if($(this).data("parent"))//如果指定了上级，则按上级初始化
				{
					var piParID=$($(this).data("parent")).find("input[type=hidden]").val();
					//上级无值（或找不到）则将本身置空
					if(!piParID)
					{
						ADDRESS.empty.call(this);
						SELECT.reset.call(this);
						bFill=false;
					}
					//找到上级则查找上级ID的所有下级ID
				}
				else//不指定上级，按省级单位对待
				{
					piParID=0;
				}
			}
			if(bFill) ADDRESS.fill.call(this,piParID);
		}
		//本级改变，下级自动填充，并重置
		$(this).find("input[type=hidden]").change(function(){
			var oJQselect=$(this).closest(".SELECT"),child=oJQselect.data("child");
			if(!$(child).size())return;
			//如果选择"不限"，下级直接完全重置
			if(this.value)
			{
				ADDRESS.fill.call($(child).get(0),this.value,true);
			}
			else
			{
				ADDRESS.empty.call($(child).get(0));
			}
			SELECT.reset.call($(child).get(0));
			$(child).find("input[type=hidden]").change();
		});
	},
	fill:function(piParID,bReset){
		var adds=GetAreas(piParID),
			str=[],
			oJQitemsContainer=$(this).find("dd"),
			piID=$(this).find("input[type=hidden]").val();
		//有data-unlimite的列表在最开始增加一个选项"不限"
		if($(this).data("unlimited")) adds.unshift(['不限','000000','000000',1]);
		for(var n=0;n<adds.length;n++)
		{
			if($(this).data("hot") && !adds[n][3]) continue;
			str.push('<a href="javascript:void(0)" data-id="', adds[n][2] ,'" title="'+ adds[n][0] +'">', adds[n][0] ,'</a>');
		}
		oJQitemsContainer.html(str.join(''));
		//如果强制重置，则将本身ID归零
		if(bReset) piID='';
		//点击与本身值相同的选项
		oJQitemsContainer.find("[data-id='"+ piID +"']").click();
	},
	empty:function(){
		$(this).find("dd").empty();
	}
};

$(function(){
	if(typeof GetAreas =='undefined') alert("缺少包含文件area.js");
	$(".ADDRESS").map(function(){
		ADDRESS.init.call(this);
	});
})