
//公司地址提示
var cookie=new cookies();
cookie.add("CompanyAddress","遍历集合中的每一个元素|遍历任何对象|删除对应的元素|或一般的JSON对象")

$(function(){
	$(".COMPANYADDRESS").on('keyup focus click',function(event){
		var key=event.which,
			//cookie=new cookies(),
			addresses=cookie.select("CompanyAddress");
			//console.log(addresses);
		if($.inArray(key,[40,38,13])>=0 && event.type=='keyup' || !addresses)return true;
		addresses=addresses.split('|');
		key=this.value;
		var dl=$(this).closest('dl'),
			dd=dl.find('dd');
			tip=dd.find('.tip'),
			result=dd.find('.matches')
		var univs=$.grep(addresses,function(ele){
			return ele.match(new RegExp(key,'i'))
		}),count=univs.length;
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
	}).attr("autocomplete",'off')
	.closest(".SELECT").data('type','string');
});
