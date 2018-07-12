// JavaScript Document
/*搜索选项*/
$(document).ready(function(){
	(function(){
		$(".jiancha li").click(function(){
			var _Me = $(this);
			_Me.parents(".check").siblings('input[type="hidden"]').val(_Me.html())
			.siblings('input[type="text"]').attr("placeholder","请输入您要搜索的"+_Me.html())
			.siblings('div.check').find('span').html(_Me.html());
			_Me.hide().siblings('li').show();
		})	

	})();

	//回到顶部
	(function(){
	  var $win = $(window);
	    $(".tubiao li").eq(0).css("visibility","hidden");
	  var goTop = function(){
	  	if($win.scrollTop()<= 0){
	  		$(".tubiao li").eq(0).css("visibility","hidden")
	  	}else{
	  		$(".tubiao li").eq(0).css("visibility", "visible")
	  	}
	  };
	  $(".tubiao li").click(function(){
	  	if($(this).index() == 0 ){
	  	 $("html,body").animate({scrollTop:0});
	  	}else {
	  	 goTop()
	  	}
	  });

	  $win.scroll(function(){goTop()});
	})();
})
