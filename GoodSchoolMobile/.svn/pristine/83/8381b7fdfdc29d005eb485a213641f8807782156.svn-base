// 渐变弹出层
$(document).ready(function(){
  var speed = 600;//动画速度
  $(".search-ico,.search-ico01").click(function(event){//绑定事件处理
    event.stopPropagation();
    var offset = $(event.target).offset();//取消事件冒泡
    $(".header-menu").css({ top:offset.top + $(event.target).height() +23+ "px", right:5+"px" });//设置弹出层位置
    $(".header-menu").show(speed);//动画显示
    $(".transparent2").fadeIn(600);
  });
  $(".transparent2").click(function(event) { $(".header-menu").hide(speed),$(".transparent2").fadeOut(600); });//单击空白区域隐藏
  $(".header-menu").click(function(event) { $(".header-menu").hide(speed),$(".transparent2").fadeOut(600); });//单击弹出层则自身隐藏
});

// 首页
/*搜索框焦点事件*/
$('.search-text,.school-search01,.jg-select').click(function(){
    $(this).find("input").blur();
    $(".search-div").fadeIn(300);
    $(".search-div-T input").focus();
});
$(".search-div .close").click(function(){
    $(".search-div").fadeOut(300);
});





$(".menu-title .return,.transparent1").click(function(){
	$(".transparent1,.menu").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
})

function courseTab(index){
	$(".transparent1").show().animate({top:'0px',opacity:'1'},300);
	$("#chang"+index).show().animate({top:'0px',opacity:'1'},300).siblings(".menu").hide();
}

$(".menu-left p span").click(function(){
		$(this).parents(".menu-left").find("span").removeClass("now");
		$(this).addClass("now");
});

function classTab(index){
	$(".menu-right"+index).show().siblings("[class^=menu-right]").hide();
}

//城市点击
function City(){
	$(".transparent").show().animate({top:'0px',opacity:'1'},300);
	$(".city").show().animate({top:'0px',opacity:'1'},300);
}

$(".return_ico").click(function(){
	$(".transparent, .city").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
})

$(".city .listmove li a").click(function(){
    $(".top .search-area span,.top .school-area span").html($(this).html());
    $(".transparent, .city").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
})


// 高级搜索页
$(".search-nav01 li").click(function(){
	$(this).parents(".search-nav01").find("li").removeClass("search-now");
	$(this).addClass("search-now");
})
function searchTab(index){
	$(".search-chang"+index).show().siblings("[class^=search-chang]").hide();
	// 懒加载的图片
	$("img.lazy").lazyload();
}


$(".search-nav li").click(function(){
	$(".transparent,.search-menu").show().animate({top:'0px',opacity:'1'},300);
	$(".transparent,.search-return").one("click",function(){
		$(".transparent,.search-menu").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
	})
})
function searchnavTab(index){
	$(".search-menu0"+index).show().animate({top:'0px',opacity:'1'},300).siblings("[class^=search-menu0]").hide();
	$(".search-menu-nav li").removeClass("now");
	$(".search-menu-nav li").eq(index-1).addClass("now");
	setTimeout(function(){		
		$(".search-menu-nav li").eq(index-1).click();
	},200)
}
$(".search-nav-new li").click(function(){
    $(".transparent,.search-menu-new").show().animate({top:'0px',opacity:'1'},300);
    $(".transparent,.search-return").one("click",function(){
        $(".transparent,.search-menu-new").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
    })
})
function schoolnavTab(index){
    $(".school-menu0"+index).show().animate({top:'0px',opacity:'1'},300).siblings("[class^=school-menu0]").hide();
    $(".search-menu-nav-new li").removeClass("now");
    $(".search-menu-nav-new li").eq(index-1).addClass("now");
    setTimeout(function(){      
        $(".search-menu-nav-new li").eq(index-1).click();
    },200)
}



$(".search-menu-left p span").click(function(){
		$(this).parents(".search-menu-left").find("span").removeClass("now");
		$(this).addClass("now");
});
function searchcouseTab(index){
	$(".search-menu-right"+index).show().siblings("[class^=search-menu-right]").hide();
}



$(".search-menu-nav li").click(function(){
	$(this).parents(".search-menu-nav").find("li").removeClass("now");
	$(this).addClass("now");
	$(".search-menu-nav li div").removeClass("search-menu-nav-angle");
	$(this).find("div").addClass("search-menu-nav-angle");
	var xxx,re;
	xxx=$(this).position().left;
		$(".search-menu-line").animate({left:xxx})
		clearTimeout(re);
})
$(".search-menu-nav-new li").click(function(){
    $(this).parents(".search-menu-nav-new").find("li").removeClass("now");
    $(this).addClass("now");
    $(".search-menu-nav-new li div").removeClass("search-menu-nav-angle");
    $(this).find("div").addClass("search-menu-nav-angle");
    var xxx,re;
    xxx=$(this).position().left;
        $(".search-menu-line-new").animate({left:xxx})
        clearTimeout(re);
})
function searchmenuTab(index){
	$(".search-menu0"+index).show().siblings("[class^=search-menu0]").hide();
    $(".school-menu0"+index).show().siblings("[class^=school-menu0]").hide();
}


$(".search-school04-right").click(function(){
	setTimeout(function(){		
		$(".search-menu-nav li").eq(index-1).click();
	},200)
})

//课程页面
$(".course_head-bottom").click(function(){
    $(".course_heart").addClass("course_heart-now");
    $(".course_head-bottom01 span").removeClass().addClass("now");
})

//课程点评页面
$(".course-dp-nav div").click(function(){
    $(this).addClass("now").siblings("div").removeClass("now");
})

// 登入页面
$("#login-nav01").click(function(){
	$(".login-nav li,.find-nav li").removeClass();
	$(this).addClass("login-nav01");
	$("#login-nav02").addClass("login-nav02");
})
$("#login-nav02").click(function(){
	$(".login-nav li,.find-nav li").removeClass();
	$(this).addClass("login-nav02-new");
	$("#login-nav01").addClass("login-nav01-new");
})
function loginTab(index){
	$("#login-change"+index).show().siblings("[class^=login-main]").hide();
}

// 注册页面
function regTab(index){
	if(index==1){
		$("#registration-nav01").removeClass().addClass("registration-nav01");
		$("#registration-nav02,#registration-nav03").removeClass().addClass("registration-nav02");
		}
	if(index==2){
		$("#registration-nav01,#registration-nav02").removeClass().addClass("registration-nav01");
		$("#registration-nav03").removeClass().addClass("registration-nav02");
		}
	if(index==3){
		$("#registration-nav02,#registration-nav02,#registration-nav03").removeClass().addClass("registration-nav01");
		}
	$("#registration-main"+index).show().siblings(".registration-main").hide();
	$("#reg-img"+index).show().siblings("[id^=reg-img]").hide();
}

//短信倒计时
$(".registration-dx-btn").click(function(){
    var o=$(this);
    if(o.hasClass("now")) return;
    var step=59;
    o.addClass("now").html("60秒后重发验证号");
    var _res = setInterval(function()
            {   
                o.html(step+'秒后重发验证号');
                step-=1;
                if(step <= 0){
                o.removeClass("now").html('获取验证码');
                clearInterval(_res);//清除setInterval
                }
            },1000);
});


//忘记密码
function findTab(index){
	$("#find-img"+index).show().siblings("[id^=find-img]").hide();
	$("#find-main"+index).show().siblings(".find-main").hide();
}



$(".forget-phone").click(function(){
    if($(".forget-phone.now").css("display")=="none"){ 
        $(".forget-phone.now").show().animate({height:$(this).height(),opacity:1},200);
    }
    else{
        $(".forget-phone.now").animate({height:0,opacity:0},200,function(){$(this).hide();});
    }
})
$(".forget-phone.now").click(function(){
    $(".data-a").html($(".forget-phone .text").html());
    $(".forget-phone .text").html($(".forget-phone.now .phone-yz").html());
    $(".forget-phone.now").animate({height:0,opacity:0},200,function(){$(this).hide();});
    $(".forget-phone.now .phone-yz").html($(".data-a").html());
    });

// 弹出地图层
function map(){
    $(".map").fadeIn(300);
    $(".map-return").click(function(){
        $(".map").fadeOut(300);
    })
	var i=$(".map-infor");
	if(!i.attr("minH"))
	{
		i.attr({
			"minH":50
			,"maxH":function(){return Math.min(i.height(),$(window).height()-45-21-12);}
		}).height(i.attr("minH"));
		$(".map-infor-expand").click(function(){
			var x,cn;
			if(i.height()==i.attr("minH"))
			{
				x="maxH";
				cn="arrow-up";
			}
			else
			{
				x="minH";
				cn="arrow-down"
			}
			x=i.attr(x);
			i.animate({"height":x + "px"});
			$(this).find("i").removeClass().addClass(cn);
		});
	}
}


// 高级搜索课程传参
$(".search-menu01 .listmove a").click(function(){
    $(".kclb").html($(this).html()).addClass("now");
    $(this).addClass("search-menu-red").siblings(".search-menu01 .listmove a").removeClass();
    $(".transparent,.search-menu").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
});
$(".search-menu02 .listmove a").click(function(){
    $(".qxwz").html($(this).html()).addClass("now");
    $(this).addClass("search-menu-red").siblings(".search-menu02 .listmove a").removeClass();
    $(".transparent,.search-menu").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
});
$(".search-menu03 .listmove a").click(function(){
    $(this).siblings().removeClass().end().addClass("search-menu-red");
    $(".transparent,.search-menu").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
});


$(".school-menu01 .listmove a").click(function(){
    if($(this).html().trim()!="不限"){
        $(".xzq").html($(this).html()).addClass("now");
        $(this).addClass("search-menu-red").siblings(".school-menu01 .listmove a").removeClass("search-menu-red");
    }
    $(".transparent,.search-menu-new").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});     
    $(".dtx").removeClass("now").text("行政区").trim();
});
$(".school-menu02 .listmove a").click(function(){
    if($(this).html().trim()!="不限"){
        $(".dtx").html($(this).html()).addClass("now");
        $(this).addClass("search-menu-red").siblings(".school-menu02 .listmove a").removeClass("search-menu-red");
    }
    $(".transparent,.search-menu-new").animate({top:'255px',opacity:'0'},300,function(){$(this).hide()});
    $(".xzq").removeClass("now").text("地铁线").trim();
});


//我的申请试听
$(".mylisten-track-btn02").click(function(){
    $(".mylisten-track-btn01,.mylisten-track-btn02").hide();
    $(".mylisten-track-bottom").show();
})

$(".mylisten-return").click(function(){
    $(".mylisten-track-btn01,.mylisten-track-btn02").show();
    $(".mylisten-track-bottom").hide();
})


//待点评
function commentTab(index){
    var css=$("#comment-msdp"+index).css("display");
    if(css=="block"){
            $("#comment-msdp"+index).hide();
        }else if(css=="none"){
           $("#comment-msdp"+index).show();
        }
}


//热点推荐
$(".recommend-nav p").click(function(){
    $(this).addClass("now").siblings(".recommend-nav p").removeClass("now");
    var xxx,re;
    xxx=$(this).position().left;
        $(".recommend-nav .line").animate({left:xxx})
        clearTimeout(re);
})
function recommendTab(index){
    $(".recommend-nav p").eq([index-1]).click(function(){
        $(".recommend-main-"+index).show().siblings("[class^=recommend-main-]").hide();
        // 懒加载的图片
        $("img.lazy").lazyload();

    })
}
function MycollectionTab(index){
    recommendTab(index);
    $(".mylisten-check,.mylisten-check-n,.mylisten-body .delete").hide();
        $(".pager").css({"margin-bottom":"0"});
        $(".edit").text("编辑").trim();
}

//我的收藏编辑
$(".edit").click(function(){
    if($(this).text().trim()=="编辑"){
        $(".mylisten-check,.mylisten-check-n,.mylisten-body .delete").show();
        $(".pager").css({"margin-bottom":"49px"});
        $(this).text("取消").trim();
    }
    else{
        $(".mylisten-check,.mylisten-check-n,.mylisten-body .delete").hide();
        $(".pager").css({"margin-bottom":"0"});
        $(this).text("编辑").trim();
    }
})


/**
* 列表滚动
*/
//$.fn.listMove = function (opr) {
//    if (this.length == 0) { return; }
//    var _touchStart = function (e) {
//        this.y = $(this).offset().top - $(this).parent().offset().top;
//        this.startY = e.screenY;
//        this.startTop = this.y || 0;
//        this.startTime = e.timeStamp;
//        this.moved = false;
//        var _this = this;
//        if (!this.maxScrollY) {
//            this.maxScrollY = $(this).parent().height() - $(this).height();
//            if (this.maxScrollY > 0) { this.maxScrollY = 0; }
//            $(window).resize(function () {
//                _this.maxScrollY = $(_this).parent().height() - $(_this).height();
//                if (_this.maxScrollY > 0) { _this.maxScrollY = 0; }
//            });
//        }
//        $(this).css({
//            "transform": "translate3d(0," + this.y + "px, 0)",
//            "transition-duration": "0"
//        });
//    };
//    var _touchMove = function (e) {
//        e.preventDefault();
//        e.stopPropagation();
//        this.moving = true;
//        this.y = e.screenY - this.startY + this.startTop;
//        if (this.y > 0 || this.y < this.maxScrollY) {
//            var newY = this.y - (e.screenY - this.startY) * 2 / 3;
//            this.y = this.y > 0 ? 0 : this.maxScrollY;
//            if (newY > 0 || newY < this.maxScrollY) { this.y = newY; }
//        }
//        $(this).css({
//            "transform": "translate3d(0," + this.y + "px, 0)",
//            "transition-duration": "0"
//        });
//        var timeStamp = e.timeStamp;
//        if (timeStamp - this.startTime > 300) {
//            this.startTime = timeStamp;
//            this.startY = e.screenY;
//            this.startTop = this.y;
//        }
//    };
//    var _touchEnd = function (e) {
//        if (this.moving) {
//            this.moving = false;
//
//            if (this.y > 0 || this.y < this.maxScrollY) {
//                _scrollTo(this, this.y, this.maxScrollY, 600);
//                this.y = this.y > 0 ? 0 : this.maxScrollY;
//                return;
//            }
//
//            this.endTime = e.timeStamp;
//            var duration = this.endTime - this.startTime;
//            if (duration < 300) {
//                var move = _calculateMoment(this.y, this.startTop, duration, this.maxScrollY, $(this).parent().height());
//                this.y = move.destination;
//                var time = move.duration;
//                $(this).css({
//                    "transform": "translate3d(0, " + this.y + "px, 0)",
//                    "transition-timing-function": "cubic-bezier(0.1, 0.3, 0.5, 1)",
//                    "transition-duration": time + "ms"
//                });
//                var _this = this;
//                setTimeout(function () { _scrollTo(_this, _this.y, _this.maxScrollY, 600); }, time + 100);
//                return;
//            }
//        } 
//    };
//    var _scrollTo = function (obj, y, maxY, time) {
//        if (y > 0 || maxY > 0) { y = 0 }
//        else if (y < maxY) { y = maxY }
//        $(obj).css({
//            "transform": "translate3d(0, " + y + "px, 0)",
//            "transition-timing-function": "cubic-bezier(0.25, 0.46, 0.45, 0.94)",
//            "transition-duration": time + "ms"
//        });
//    };
//    var _calculateMoment = function (current, start, time, lowerMargin, wrapperSize) {
//        var distance = current - start,
//		    speed = Math.abs(distance) / time,
//		    destination,
//		    duration;
//        deceleration = 6e-4;
//        destination = current + speed * speed / (2 * deceleration) * (distance < 0 ? -1 : 1);
//        duration = speed / deceleration;
//        if (destination < lowerMargin) {
//            destination = wrapperSize ? lowerMargin - wrapperSize / 2.5 * (speed / 8) : lowerMargin;
//            distance = Math.abs(destination - current);
//            duration = distance / speed
//        } else if (destination > 0) {
//            destination = wrapperSize ? wrapperSize / 2.5 * (speed / 8) : 0;
//            distance = Math.abs(current) + destination;
//            duration = distance / speed
//        }
//        return {
//            destination: Math.round(destination),
//            duration: duration
//        }
//    };
//    this.on("vmousedown", _touchStart).on("vmousemove", _touchMove).on("vmouseup", _touchEnd);;
//
//    return this;
//};

//$(".listmove").listMove();
$(".menu").on("vmousemove",function(e){
    e.preventDefault();
    e.stopPropagation();
});



//机构图片触摸切换
 $.fn.yxMobileSlider = function(settings){
        var defaultSettings = {
            width: 240, //容器宽度
            height: 240, //容器高度
            during: 5000, //间隔时间
            speed:30 //滑动速度
        }
        settings = $.extend(true, {}, defaultSettings, settings);
        return this.each(function(){
            var _this = $(this), s = settings;
            var startX = 0, startY = 0; //触摸开始时手势横纵坐标 
            var temPos; //滚动元素当前位置
            var iCurr = 0; //当前滚动屏幕数
            var timer = null; //计时器
            var oMover = $("ul", _this); //滚动元素
            var oLi = $("li", oMover); //滚动单元
            var num = oLi.length; //滚动屏幕数
            var oPosition = {}; //触点位置
            var moveWidth = s.width; //滚动宽度
            //初始化主体样式
            _this.width(s.width).height(s.height).css({
                position: 'relative',
                overflow: 'hidden',
                margin:'0 auto'
            }); //设定容器宽高及样式
            oMover.css({
                position: 'absolute',
                left: 0,
            });
            oLi.css({
                float: 'left',
                display: 'inline'
            });
            $("img", oLi).css({
                width: '100%',
                height: '100%'
            });
            //初始化焦点容器及按钮
            _this.append('<div class="focus"><div></div></div>');
            var oFocusContainer = $(".focus");
            for (var i = 0; i < num; i++) {
                $("div", oFocusContainer).append("<span></span>");
            }
            var oFocus = $("span", oFocusContainer);
            oFocusContainer.css({
                minHeight: $(this).find('span').height() * 2,
                position: 'absolute',
                bottom: 0,
                background: 'rgba(0,0,0,0.5)'
            })
            $("span", oFocusContainer).css({
                display: 'block',
                float: 'left',
                cursor: 'pointer'
            })
            $("div", oFocusContainer).width(oFocus.outerWidth(true) * num).css({
                position: 'absolute',
                right: 10,
                top: '50%',
                marginTop: -$(this).find('span').width() / 2
            });
            oFocus.first().addClass("current");
            //页面加载或发生改变
            $(window).bind('resize load', function(){
                if (isMobile()) {
                    mobileSettings();
                    bindTochuEvent();
                }
                oLi.width(_this.width()).height(_this.height());//设定滚动单元宽高
                oMover.width(num * oLi.width());
                oFocusContainer.width(_this.width()).height(_this.height() * 0.15).css({
                    zIndex: 2
                });//设定焦点容器宽高样式
                _this.fadeIn(300);
            });
            //页面加载完毕BANNER自动滚动
            stopMove();
            //PC机下焦点切换
            if (!isMobile()) {
                oFocus.hover(function(){
                    iCurr = $(this).index() - 1;
                    stopMove();
                    doMove();
                }, function(){
                    stopMove();
                })
            }
            //自动运动
            function autoMove(){
                timer = setInterval(doMove, s.during);
            }
            //停止自动运动
            function stopMove(){
                clearInterval(timer);
            }
            //运动效果
            function doMove(){
                iCurr = iCurr >= num - 1 ? 0 : iCurr + 1;
                doAnimate(-moveWidth * iCurr);
                oFocus.eq(iCurr).addClass("current").siblings().removeClass("current");
            }
            //绑定触摸事件
            function bindTochuEvent(){
                oMover.get(0).addEventListener('touchstart', touchStartFunc, false);
                oMover.get(0).addEventListener('touchmove', touchMoveFunc, false);
                oMover.get(0).addEventListener('touchend', touchEndFunc, false);
            }
            //获取触点位置
            function touchPos(e){
                var touches = e.changedTouches, l = touches.length, touch, tagX, tagY;
                for (var i = 0; i < l; i++) {
                    touch = touches[i];
                    tagX = touch.clientX;
                    tagY = touch.clientY;
                }
                oPosition.x = tagX;
                oPosition.y = tagY;
                return oPosition;
            }
            //触摸开始
            function touchStartFunc(e){
                clearInterval(timer);
                touchPos(e);
                startX = oPosition.x;
                startY = oPosition.y;
                temPos = oMover.position().left;
            }
            //触摸移动 
            function touchMoveFunc(e){
                touchPos(e);
                var moveX = oPosition.x - startX;
                var moveY = oPosition.y - startY;
                if (Math.abs(moveY) < Math.abs(moveX)) {
                    e.preventDefault();
                    oMover.css({
                        left: temPos + moveX
                    });
                }
            }

            //触摸结束
            function touchEndFunc(e){
                touchPos(e);
                var moveX = oPosition.x - startX;
                var moveY = oPosition.y - startY;
                if (Math.abs(moveY) < Math.abs(moveX)) {
                    if (moveX > 0) {
                        iCurr--;
                        if (iCurr >= 0) {
                            var moveX = iCurr * moveWidth;
                            doAnimate(-moveX, stopMove);
                        }
                        else {
                            doAnimate(0, stopMove);
                            iCurr = 0;
                        }
                    var str=$(".s_number").html().split('/');
                    if (parseInt(str[0])>1) {
                       $(".s_number").html(parseInt(str[0])-1+'/'+str[1]);
                       };
                    }
                    else {
                        iCurr++;
                        if (iCurr < num && iCurr >= 0) {
                            var moveX = iCurr * moveWidth;
                            doAnimate(-moveX, stopMove);
                        }
                        else {
                            iCurr = num - 1;
                            doAnimate(-(num - 1) * moveWidth, stopMove);
                        }
                    var str=$(".s_number").html().split('/');
                    if(parseInt(str[0])<$(".s_i_c_box>li").length){
                       $(".s_number").html(parseInt(str[0])+1+'/'+str[1]);
                       }
                    }
                    oFocus.eq(iCurr).addClass("current").siblings().removeClass("current");
                }
            }
            
            $(".s_number").html("1/"+$(".s_i_c_box>li").length);
            
            //移动设备基于屏幕宽度设置容器宽高
            function mobileSettings(){
                moveWidth = s.width;
                _this.height(s.height).width(s.width);
                oMover.css({
                    left: -iCurr * moveWidth
                });
            }
            //动画效果
            function doAnimate(iTarget, fn){
                oMover.stop().animate({
                    left: iTarget
                }, _this.speed , function(){
                    if (fn) 
                        fn();
                    $(window).scroll();
                });
            }
            //判断是否是移动设备
            function isMobile(){
                if (navigator.userAgent.match(/Android/i) || navigator.userAgent.indexOf('iPhone') != -1 || navigator.userAgent.indexOf('iPod') != -1 || navigator.userAgent.indexOf('iPad') != -1) {
                    return true;
                }
                else {
                    return false;
                }
            }
        });
    };

$(".s_i_context").yxMobileSlider({width:240,height:240,during:3000});


$(".s_i_c_box li").click(function(){
    $(".school-img").fadeIn(300);
    $(".school-img .close").click(function(){
        $(".school-img").fadeOut(300);
    })
})


// 懒加载的图片
if( $("img.lazy").length>0) $("img.lazy").lazyload();


//悬浮置顶
//function courseTop() {
//        var navH = 0;
//          navH = $(".c_i_contentTab,.s_i_contentTab,.school-address,.search-nav").offset().top;
//          $(window).scroll(function() {
//              var scroH = $(this).scrollTop();
//              if (scroH >= navH) {
//                $(".c_i_contentTab,.s_i_contentTab").addClass("scrollTop");
//                $(".search-nav-new,.search-nav,#c_i_option").addClass("bfffae4");
//                $(".s_i_address").css({'margin-top':'46px'});
//              } else {
//                $(".c_i_contentTab,.s_i_contentTab").removeClass("scrollTop");
//                $(".search-nav-new,.search-nav,#c_i_option").removeClass("bfffae4");
//              }
//          });
//    };
//courseTop();


//置顶
function GoToTop()
{
	$('body').append('<div class="GoToTop" onClick="$(window).manhuatoTop();"><i></i></div>');
	var t=$(".GoToTop");
	var w=0;
	function hns()
	{
		if($(window).scrollTop()>(screen.availHeight*0.2)) t.show();
		else t.hide();
	}
	$(window).load(hns).scroll(hns);
	t.click(function(){
		w=0;clearInterval(w);
		w=setInterval(slideTop,30);
	});
	function slideTop()
	{
		var wst=$(window).scrollTop();
		if(wst==0) {clearInterval(w); w=0;}
		else $(window).scrollTop(Math.max(0,wst/10));
	}
}
$(function(){
	GoToTop();
});



//触摸缩放
var mc;
function UseHammer(img)
{
    var el=document.createElement("img");
    el.src=img.src;
    $(".school-img-1").append($(el)).fadeIn();
    mc=new Hammer.Manager(el);
    var par=$(el).parent()
        ,parw=par.width(),      parh=par.height()
        ,parx=par.offset().left,pary=par.offset().top
        ,rp=parw/parh,r
    ;
    $(el).load(function(){
        var w=$(el).width(),h=$(el).height();
        r=w/h;
        if(r>=rp && w>=parw)
        {
            $(el).width(parw)
                .height(parw/r)
                .offset({
                    left:parx
                    ,top:pary + (parh-parw/r)*0.5
                });
        }
        else if(r<=rp && h>=parh)
        {
            $(el).height(parh)
                .width(parh*r)
                .offset({
                    top:pary
                    ,left:parx + (parw-parh*r)*0.5
                });
        }
        else
        {
            $(el).offset({
                left:parx + (parw-w) * 0.5
                ,top:pary + (parh-h) * 0.5
            });
        }
        el.priW=$(el).width();
        el.priH=$(el).height();
        el.priX=$(el).offset().left
        el.priY=$(el).offset().top;
    });
    
    mc.add(new Hammer.Pan({ threshold: 0, pointers: 0 }));
    mc.add(new Hammer.Pinch({ threshold: 0 })).recognizeWith([mc.get('pan')]);;
    mc.add(new Hammer.Swipe()).recognizeWith(mc.get('pan'));
    mc.add(new Hammer.Tap({ event: 'doubletap', taps: 2 }));
    mc.add(new Hammer.Tap());
    
    mc.on("swipe",function(e){
        //滑动的函数
    });
    mc.on("panstart", function(e){
        //初始化移动
        el.lastX=parseInt($(el).offset().left);
        el.lastY=parseInt($(el).offset().top);
    });
    mc.on("panmove", function(e){
        //移动中
        var   tx=el.lastX + e.deltaX,     ty=el.lastY + e.deltaY,
               w=$(el).width(),            h=$(el).height(),
            minx=parx+parw-w,           miny=pary+parh-h
        ;
        tx=(w>=parw)?Math.max(Math.min(tx,parx),minx):(parx+(parw-w)*0.5);
        ty=(h>=parh)?Math.max(Math.min(ty,pary),miny):(pary+(parh-h)*0.5);
        $(el).offset({left:tx,top:ty});
    });
    mc.on("pinchstart", function(e){
        //初始化缩放
        el.lastW=$(el).width();
        el.lastH=$(el).height();
        el.lastX=parseInt($(el).offset().left);
        el.lastY=parseInt($(el).offset().top);
    });
    mc.on("pinchmove",function(e){
        //缩放中
        var scale=e.scale,
            w2=el.lastW * scale,    h2=el.lastH * scale,
            ox=el.lastX,            oy=el.lastY
            ;
        
        if(r>rp)
        {
            w2=Math.max(w2,el.priW);
            h2=w2/r;
        }
        else
        {
            h2=Math.max(h2,el.priH);
            w2=h2*r;
        }
        var minx=parx+parw-w2,  miny=pary+parh-h2;
            
        $(el).width(w2).height(h2);
        var pt1=e.pointers[0],  pt2=e.pointers[1],
            p1x=pt1.clientX,    p2x=pt2.clientX,
            p1y=pt1.clientY,    p2y=pt2.clientY
            ;
        var cx=(p1x*1+p2x*1)*0.5,   cy=(p1y*1+p2y*1)*0.5,
            px=cx*1+scale *(ox-cx), py=cy*1+scale *(oy-cy);

        px=(w2>=parw)?Math.max(Math.min(px,parx),minx):(parx+(parw-w2)*0.5);
        py=(h2>=parh)?Math.max(Math.min(py,pary),miny):(pary+(parh-h2)*0.5);
        
        $(el).offset({top:py,left:px});
    });
    mc.on("doubletap", function(e){
        //双击还原
        $(el).width(el.priW).height(el.priH).offset({top:el.priY,left:el.priX});
    });
}


