//输入邮箱地址时的自动提示
$(function(){
	var emails = 'qq.com,163.com,126.com,139.com,sohu.com,sina.com,21cn.com,yeah.net,tom.com'.split(',');
	$(".EMAILS").on('keyup focus click',function(event){
		var key=event.which;
		if($.inArray(key,[40,38,13])>=0 && event.type=='keyup')return true;
		key=this.value;
		var dl=$(this).closest('dl'),
			result=dl.find('.matches');
		//无关键字则收回提示及匹配
		if(!key)
		{
			result.hide();
			return true;
		}
		var results,passport;
		//如果输入了@则会过滤掉一些邮箱后缀
		if(key.indexOf('@')>0)
		{
			results=[];
			var arr=key.split('@'),suffix=arr[1];
			passport=arr[0];
			for(var n=0; n<emails.length;n++)
			{
				if(emails[n].indexOf(suffix)>=0) results.push(emails[n]);
			}
		}
		else
		{
			results=emails;
			passport=key;
		}
		var str=[];
		for(var n=0;n<results.length;n++)
		str.push('<a href="javascript:void(0)">', passport , '@' , results[n] ,'</a>');
		result.html(str.join('')).show();
	}).closest(".SELECT").data('type','string');
});
