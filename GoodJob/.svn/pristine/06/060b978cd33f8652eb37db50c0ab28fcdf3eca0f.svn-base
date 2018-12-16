/*
城市选择器，使用通用的自定义下拉列表结构
可附加data-matches，指定列表的最大选项，如不指定则显示所有输入的关键字匹配
*/
$(".CitiesPicker").map(function(){
	var oJQselect=$(this);
	//点击时先显示静态列表
	oJQselect.find("dt").click(function(){
		$(this).closest(".CitiesPicker").find(".CitiesStatic,.CitiesHot").eq(0).show()
			.siblings().hide();
	})
		//输入时进行匹配
		.find("input").keyup(function(event){
			var key=event.which;
			if($.inArray(key,[40,38,13])>=0) return true;
			key=this.value;
			var picker=$(this).closest(".CitiesPicker"),
				lists=picker.find(".CitiesStatic,.CitiesHot"),
				query=lists.siblings(".CitiesQuery"),
				tip=query.find(".tip"),
				result=query.find(".matches");
			if(!key)
			{//没关键字时显示静态列表
				lists.show();
				query.hide();
				return true;
			}
			if(typeof GetAreasByRegexp=='undefined')
			{
				alert("缺少包含文件area.js");
				return false;
			}
			var cities=GetAreasByRegexp(key),count=cities.length;
			if(count)
			{//最大选项数，如果不设置则显示全部
				var matches=picker.data("matches"),str=[];
				if(!matches) matches=count;
				var over=Math.min(matches,count);
				for(var n=0;n<over;n++)
				{
					var city=cities[n][0],id=cities[n][2];
					str.push('<a href="javascript:void(0)" title="', city ,'" data-id="', id ,'">', city ,'</a>');
				}
				result.html(str.join(''));
				tip.html(key+ '，若缩小范围，请输入全拼');
			}
			else
			{//保留最近一次的搜索结果
				tip.html('对不起，找不到符合'+ key +'的城市');
			}
			lists.hide();
			query.show();
			return true;
		})
		.end()
	//初始化标签列表
	.end()
	.find(".CitiesStatic").map(function(){
		$(this).find(".tabs").children().click(function(){
			var index=$(this).index();
			$(this).addClass("cur").siblings().removeClass("cur")
				.closest(".tabs").nextAll(".cities").eq(index).show()
				.siblings(".cities").hide();
			var oDOMselect=$(this).closest(".SELECT").get(0);
			SELECT.timerOff.call(oDOMselect);
		}).eq(0).click();
	});
});