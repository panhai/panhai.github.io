

var iScrollNav,iScrollMeun;
var GlobalScrollOptions={scrollX:false,scrollY:true,tap:'click'};

/*************搜索的筛选条件************/
(function(){
	var ddScroll,MainMenu,XiaoQu;
	var bg=$(".FilterBg"),
		scrollLists=[];
		
	bg.on("touchmove",function(event){
		event.preventDefault();
	}).click(function(){
		$(".search-filter .cur").click();
	});
	
	$('.search-filter .item').click(function(){
		
		var MainList=$("."+$(this).data("list"));
		var	MainMenu="."+$(this).data("list");
		var XiaoQu=$(this).data("xiaoqu") ? false : true ;  //判断是否是机构搜索的上课校区
		
		var oClosest=$(this).closest(".search-filter");	
		var oTop=oClosest.offset().top + oClosest.innerHeight()+1;
//		var bx=$(".tab-content .tab-menu .tab-list li").hasClass("bx");
		
						
		if(MainMenu==".FilterAreas" || MainMenu==".FilterMore"){
			if(XiaoQu){
				MainList.find(".tab-nav").css({"width":"45%"});
				MainList.find(".tab-menu").css({"width":"55%"});
			}else{
				MainList.find(".tab-nav").css({"width":"100%"});
			}
		};
		MainList.find(".tab-menu").css({"height":"100%"});
		MainList.find(".tab-nav").css({"height":"100%"});
		MainList.css({"position":"absolute","top":oTop,"height":"70%"});
		
		if($(this).hasClass("cur")){
			$(".FilterBg").hide();
			$(this).removeClass("cur");
			MainList.hide();
			
			return;
		}else{
			$(".FilterBg").show();
			$(this).addClass("cur").siblings().removeClass("cur");
			MainList.show().siblings(".tab-container").hide();
		}
//		//alert(bx);
//		if(bx){
//			alert(bx);
//			$('.search-filter .item[data-list="FilterAreas"]')
//				 	.removeClass("now")
//				 	.find("a span").text("上课校区");
//		}
		setTimeout(function(){
			if(XiaoQu){
				iScrollNav = new IScroll(MainMenu+' .tab-nav',GlobalScrollOptions);
			}; 
				iScrollMeun = new IScroll(MainMenu+' .tab-menu',GlobalScrollOptions) 
			
		},200);
		
		//FilterNav();
	});
	
//	function FilterNav(){
//		if( typeof MainMenu == "undefined" ) return; 
//		
//		$(MainMenu+" .tab-nav li").click(function(){
//			
//			var buxian=$(this).closest(".tab-nav").find("li").hasClass("bx");
//			var tabMenu=$(this).closest(".tab-nav").siblings(".tab-menu");
//			var index=buxian ? $(this).index()-1 :$(this).index();
//			var bx=$(this).hasClass("bx");
//			
//			if(bx){
//				$(this).next().addClass("cur").siblings().removeClass("cur");
//				
//				$(".search-filter .cur").click();	
//				return;
//			}
//	
//			$(this).addClass("cur").siblings().removeClass("cur");
//			tabMenu.find(".tab-li").eq(index).show().siblings().hide();
//			
//			if(MainMenu){
//				//alert(XiaoQu);
//				setTimeout(function(){
//					if(XiaoQu)	new IScroll(MainMenu+' .tab-menu',GlobalScrollOptions);
//				},100)
//			}
//			ddScroll && ddScroll.refresh();
//			
//		}).filter(".cur").click();
//	}

	
})();


/*************专业分类整屏************/
//var scrollMeun=new IScroll('.tab-content .tab-menu',GlobalScrollOptions);	
//var iScrollArray = new Array();
//$('.tab-content .tab-menu').each(function(){
//	var name=$(this).closest(".tab-container");
//	var is = new IScroll(this,GlobalScrollOptions);	
//	iScrollArray.push(is);
//});


function TabMenu(obj,oOptions){
	if (!oOptions) oOptions = {};
//	if(oOptions.oClick) setTimeout(function(){$(obj).click()},200) ;
	if($(obj).length==0) return;

	$(obj).click(function(){	
		
		var MainList=$("."+$(this).data("list"));
		var MainMenu="."+$(this).data("list");

		if(typeof oOptions.sHeight != "undefined"){
			var ScrollHeight=oOptions.sHeight;
		}else{
			var ScrollHeight=0;
		}
		
		$(MainMenu+" .tab-content").siblings().each(function() {
			ScrollHeight=ScrollHeight+$(this).innerHeight();
		});
		$(".tab-menu").height($(window).height()-ScrollHeight);
		$(".tab-nav").height($(window).height()-ScrollHeight);
		
		MainList.show();
		iScrollNav=new IScroll(MainMenu+' .tab-nav',GlobalScrollOptions);
		iScrollMeun=new IScroll(MainMenu+' .tab-menu',GlobalScrollOptions);
	})
}

TabMenu(".bigclass-box li.item");
TabMenu(".classmenu .more");




$(".tab-content .tab-menu .tab-list li").click(function(){
	var oMore=$(this).closest(".tab-container").hasClass("FilterMore");
	var oText=$(this).find("a").text();
	var bx=$(this).hasClass("bx");
	
	if(bx){
		//alert(bx);
		$('.search-filter .item[data-list="FilterAreas"]')
				.removeClass("now")
				.find("a span").text("上课校区");
	}
	if(!oMore){
		
		$(this).closest(".tab-menu").find(".tab-list li").removeClass("cur");
		$(".search-filter .cur a span").text(oText);
	}
	$(this).addClass("cur").siblings().removeClass("cur");

	$(".search-filter .cur a span").closest("li").addClass("now");
	
	$(".search-filter .cur").click();	
	return;
});

$(".tab-content .tab-nav li").click(function(){
	var index , 
		oAreas = $(this).closest(".tab-container").hasClass("FilterAreas"),
		oMore = $(this).closest(".tab-container").hasClass("FilterMore"),
		bx = $(this).is(".bx"),
		tab_menu = $(this).closest(".tab-container").find("tab-content .tab-menu"),
		buxian = $(this).parent().find(":eq(0)").hasClass("bx");
		
	if(buxian){
		index=$(this).index()-1;
		
		if(bx){
			
			if(oAreas){
				 $('.search-filter .item[data-list="FilterAreas"]')
				 	.removeClass("now")
				 	.find("a span").text("上课校区");
			}
			if(oMore){
				 $('.search-filter .item[data-list="FilterMore"]').removeClass("now");
			}
			
			$(".search-filter .cur").click();	
			return;
		}
		
	}else{
		index=$(this).index();
	}
	var scrollX=0;
	var t=$(".tab-class.cur,.tab-row.cur",tab_menu);
	if(t.length>0) scrollX = t[0].offsetTop;
	
	$(this).addClass("cur").siblings().removeClass("cur");
	$(this).closest(".tab-content").find(".tab-ul .tab-li").eq(index).show().siblings().hide();
	if(typeof iScrollMeun != "undefined"){
		iScrollMeun.scrollTo(0,-scrollX < iScrollMeun.maxScrollY ? iScrollMenu.maxScrollY : -scrollX);
		iScrollMeun && iScrollMeun.refresh();
	};
}).filter(".cur").click();








$(".h_p_upload span a").click(function()
{
	$("#head div").addClass("loadpic");
});



//签到弹出
$(function(){
	var speed=300;
	//event.stopPropagation();
	$(".Signin a").click(function(){
		$(".Signin_Success").show(speed);
		$(".transparent").show().animate({top:'0px',opacity:'0.5'},600);
	})
	$(".s_s_lose").click(function(){
		$(".Signin_Success").hide(speed);
		$(".transparent").hide().animate({top:'0px',opacity:'0'},600);
	})
});



	
	
$(".tab-container").find(".left").click(function(){
	$(this).closest(".tab-container").hide();
});

/*************半透明背景切换************/
var toggleBJ=function(){
		$(".background").fadeToggle();
	}  







/*************选择城市************/
$(".Cities .Header .left a").click(function(){
	$(this).closest(".Cities").hide();
});

$(".search-box .city-link").click(function(){
	showCity()
});
$(".course-details .city-link").click(function(){
	showCity()
});
function showCity(){
	$(".cities-content").height($(window).height()-40);
	$(".Cities").show();
	new IScroll('.Cities .cities-content',{scrollX:false,scrollY:true,tap:'click'/* ,click:true*/});
}
	
$("#Letter .cities-list li").click(function(){
	var index=$(this).index();
	var position=$(".Cities .cities-item").eq(index+2).offset().top-40;
	setTimeout(function(){
		new IScroll('.Cities .cities-content',{scrollX:false,scrollY:true,/*tap:'click',*/startY:-position});
	},200)	
//	var startY=0;
//	var ABC=$(this).text();
//	var result=$(".Cities .cities-item");
//
//	for(var i=0; i<result.length; i++){
//
//		if(ABC == result.eq(i).find(".title").text()){
//			startY = result.eq(i).find(".title").offset().top-40;
//			

//		}
//	}
});

$(".Cities .cities-list li").click(function(){
	var Letter=$(this).closest(".cities-item").attr("data-list");
	if(!Letter){
		$(".Cities .cities-list li a").css({"background":"#fff","color":"#333"});
		$(this).find("a").css({"background":"#40a1f2","color":"#fff"});	
		$(this).closest(".Cities").hide();
		$(".city-link i").text($(this).find("a").text())
	}
});

$(".BACK").click(function(){
	$(this).closest(".Header").parent().fadeOut(300);
});

$(".get-info .search-box .search-word, .Index .search-box .search-word, .Search02 .search-box .search-word, .Search01 .search-box .search-word").click(function(){
	$(".search-popup").fadeIn(300);
	$(".search-popup .search-word").focus();
	$(this).blur();
});


/*************顶栏的更多下拉************/
$(".Header .icon-dots-three-horizontal").click(function(e){
	e.stopPropagation();
	$(".background").toggle();
	$(".Header-menu").toggle(600);
});

//点击背景的浮层跟着隐藏
$(".background").click(function(){
	$(".Header-menu").hide(600);
	$(this).hide();
	$(".TK-notice").hide();
	$(".foot-course").hide();
});

$(".open-class p a.seeMap, .contact-box .ditu").click(function(){
	$(".Map").show();
});

/*$(".open-class p a.seeMap, .consultation-content .see-jt, .contact-box .ditu").click(function(){
	$(".Map").show();
});*/

$(".Header .right .gj").click(function(){
	$(".Map .bus").slideToggle();
})

/*************预约登记地区  班级************/
$(".apply-list .i-area").click(function(){
	$(".apply-area").show();
});
$(".apply-list .i-time").click(function(){
	$(".apply-time").show();
});

/*************顶栏的更多下拉************/
function scrollBottom(obj){
	if($(obj).length == 0) return;
	$(window).scroll(function(){
		if(Math.round($("body").height()-$("body").scrollTop())<=document.documentElement.clientHeight){
			$(".bottomload").show();
		}
	});
}
scrollBottom(".bottomload");




/*************向下滚动正常 向上滚动时显示导航在悬浮在顶和置顶************/
$(".GoToTop").click(function(){
	$(window).scrollTop(0);
	$(this).hide();
});


var prevTop = 0,
    currTop = 0;
$(window).scroll(function() {
    currTop = $(window).scrollTop();
	
	if(currTop>$(window).height()/2){ 
		$(".GoToTop").show();
	}else{
		$(".GoToTop").hide();
	}
    if (currTop < prevTop) { //判断小于则为向上滚动
		$(".search-content").css({"margin-top":"80px"});
        $(".search-filter").addClass("fixed");
		$(".search-switch").addClass("fixed");

		if(currTop<115) {
			
			$(".search-filter").removeClass("fixed");
			$(".search-switch").removeClass("fixed");
			$(".search-content").css({"margin-top":0});
		}	
    } else {
		$(".search-content").css({"margin-top":0});
        $(".search-filter").removeClass("fixed");
		$(".search-switch").removeClass("fixed");
    }
    //prevTop = currTop; //IE下有BUG，所以用以下方式
    //setTimeout(function(){prevTop = currTop},0);
	prevTop = currTop;
});


/*************提示弹框************/
$(".TK-notice .close").click(function(){
	$(this).closest(".TK-notice").fadeOut();
	$(".background").fadeOut();
});
if($(".TK-notice").is(":visible")==true){
	$(".background").show();
}



/*************分享************/
with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion=' + ~(-new Date() / 36e5)];

function Share()
{	
//	alert();
	var bg=$(".background");
	var T=$(".Shares");
	T.find("dd input").click(function(){
		$(".icons-share").removeClass("on");
		shut();
	});
	var shut=function(){
		T.slideUp('','',function(){
			bg.fadeOut();
		})
	}
	bg.fadeIn('',function(){
		T.slideDown();
	}).click(shut);
}

/*************收藏************/
function oCollection(){
	$("#sc").fadeIn();
	$(".background").fadeIn();
	setTimeout(function(){
		$(".background").fadeOut();
		$("#sc").fadeOut();
	},2000);
}

/*************常见问题 .FAQ************/
$(".FAQ .f-title").click(function(){
	if($(this).siblings(".f-content").is(":visible")){
		$(this).siblings(".f-content").hide();
		return ;
	}
	$(".FAQ .f-content").hide();
	$(this).siblings(".f-content").show();
});



/*************首页大类菜单去掉下划线************/
$(".classmenu .count").each(function() {
	var i=Math.floor($(this).find("a").length/3);
	//$("a:gt("+(i*3-1)+")",this).css({"borderBottom":0});
	$(this).find("a:gt("+(i*3-1)+")").css({"borderBottom":0});

});



$(".contact-box .course").click(function(){
	
	if($(".foot-course").is(":hidden")){
		$(".contact-box").css({"zIndex":3});
			
	}else{
		$(".contact-box").css({"zIndex":1});	
	}
	
	//$(".foot-course .foot-ul").css({"zIndex":3});
	$(".foot-course").toggle();
	$(".background").toggle();
	$('.foot-course ul').height($(".foot-course li").length *　$('.foot-course li').outerHeight());
	var sss = new IScroll(".foot-course .foot-ul",{scrollX:false,scrollY:true,scrollbars:true,tap:'click'});
	//sss && sss.refresh();	
});









