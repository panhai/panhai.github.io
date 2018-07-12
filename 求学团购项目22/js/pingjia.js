function enty(str){//去掉空格
	var newstr = '';
	for(var i=0;i<str.length;i++){
		if(str[i]!=' '){
			newstr+=str[i];
		}
	}
	return newstr;
}

//修改评价 只能修改一次  评价30内只能修改一次
$('.xiu').on('click',function(){
	//未超过修改评价的有效期、没有修改过评价
	//已超过修改评价的有效期，没有修改过评价
	//已修改过评价（不管有没有超过修改评价的有效期）
	
	var num = $(this).attr('data-num');//修改次数
	var _this = this;
	console.log($(this).attr('data-num'))
	var day =new Date().getTime();
	var datastr = $(this).parent().siblings('p').find('.time').text();
	var datatime = enty(datastr).substring(0,10) + ' '+enty(datastr).substring(11,enty(datastr).length)
	var pday = new Date(datatime);
	var zdate = 30*24*60*60*1000;//30天的毫秒数
	var times = day - pday;//现在时间 减去 评价的时间 即评价的时间间隔
	
	if(num>0){//已经修改过一次
		layer.confirm('抱歉,您已修改1次评价！<br>了解<a href="" style="color:blue">关于评价的常见问题</a>',{title:'<b>温馨提示</b>',btn:['好的']},function(index){
			//do ...
			
			layer.close(index);
		})
		return false;
	}
	
	if(times<zdate){//在时间内没有修改过评价提示
		layer.confirm('评价成功后30天内可以修改评价，仅1次修改机会<br/>确定前往修改评价吗？',{title:'<b>温馨提示</b>'},function(index){
			//do ... 确定后做的事情
			$(_this).attr('data-num','1');
			layer.close(index);
		})
		return false;
	}
	
	if(times>zdate){// 时间过期
		layer.confirm('抱歉,您错过了修改评价的有效期(即评价成功后30天内)<br/>了解<a href="" style="color:blue">关于评价的常见问题</a>',{title:'<b>温馨提示</b>'},function(index){
			//do ... 确定后做的事情
			num++;
			layer.close(index);
		})
		return false;
	}
	
	
	console.log(times,zdate,times<zdate)
	return false;
})
//删除评价
$('.deletebox img').on('click',function(){
	var _this = this
	layer.confirm('确定删除收藏的项目吗？',{title:'温馨提示'},function(index){
		$(_this).parent().parent().parent().remove();
		layer.close(index)
	})
})
