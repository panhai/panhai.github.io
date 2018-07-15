$(function() {
	//tab 切换广告
	/*
	 * 	1 点那个广告就显示哪个广告，标题换为点击的广告文本
	 * 
	 * indexTitle 
	 * 
	 */
	var titels = $('.title-line'); //标题广告
	var navList = $('.navbox-list li') //广告列表
	
	//过滤
	function filter(str){
		var newstr = '';
		for(var i=0;i<str.length;i++){
			if(i==0 || i==str.length-1){
				continue;
			}
			newstr+=str[i];
		}
		return newstr;
	}
		
	
	
	navList.click(function() {
		var indexTitle = $(this).text();
		$('.title-line').html($(this).text());
		var newstr = filter($(this).text())
		
		$('.indexTitle').text(newstr)
		
		 console.log(newstr)
	})

})