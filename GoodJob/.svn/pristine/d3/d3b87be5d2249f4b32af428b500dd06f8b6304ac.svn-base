//学校的输入提示
$(function(){
	$(".SCHOOLS").on('keyup focus click',function(event){
		var key=event.which;
		if($.inArray(key,[40,38,13])>=0 && event.type=='keyup')return true;
		key=this.value;
		var dl=$(this).closest('dl'),
			dd=dl.find('dd');
			tip=dd.find('.tip'),
			result=dd.find('.matches')
		if(!key)
		{//无关键字则收回提示及匹配
			tip.html('请输入关键字').show();
			result.hide();
			return true;
		}
		if(typeof GetUniversitiesByKeyword =='undefined')
		{
			alert('缺少包含文件universities.js');
			return false;
		}
		var univs=GetUniversitiesByKeyword(key),count=univs.length;
		if(count)
		{//最大选项数，如果不设置则显示全部
			var matches=dl.data("matches"),str=[];
			if(!matches) matches=count;
			var over=Math.min(matches,count);
			for(var n=0;n<over;n++)
			{
				var university=univs[n];
				str.push('<a title="', university ,'">', university ,'</a>');
			}
			result.html(str.join('')).show();
			tip.hide();
		}
		else
		{//修改提示
			tip.html('对不起，找不到符合'+ key +'的学校').show();
			result.hide();
		}
	}).closest(".SELECT").data('type','string');
});
