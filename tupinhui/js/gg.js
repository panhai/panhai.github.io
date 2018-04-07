(function(){
	$(function(){
		$(".proct-item").hover(function(){
			var index = $(this).index();
		   $(this).find('.sc').stop().slideDown(200);
		   $(this).find('.xz').stop().slideDown(200);
		},function(){
		    $(this).find('.sc').stop().slideUp(200);
		    $(this).find('.xz').stop().slideUp(200);
		});
	})
})()
