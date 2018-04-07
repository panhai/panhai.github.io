(function(){
	
	//楼梯导航
	$(function(){
		$(function(){
			var time = setTimeout(function(){
				$("img.lazy").lazyload({
					threshold :60,
					effect : "fadeIn",
					failure_limit : 0
				});
			},0)
		})
		
		
		$(window).resize(function(e){
			//左侧楼梯导航
			var lefNav = $(window).height()-150;
			var rightNav = $(window).height()-100;
			if(lefNav<=60){
				lefNav = 60;
			}else if(lefNav >= 150){
				lefNav = 150;
			}
			$('#leftNav').css('top',lefNav)
			if(top >=150){
				lefNav = top = 150;
			}
			//判断右侧
			if(rightNav <= 60){
				rightNav = 60;
			}else if(rightNav >=100){
				rightNav = 100;
			}
			$('#rightNav').css('top',rightNav)
		})
	})
})()


