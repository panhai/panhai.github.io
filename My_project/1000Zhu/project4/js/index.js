$(window).load (function () {
	setTimeout (function () {
		$(".welcome").css({zIndex:-1,opacity:0})
	},500)
	$(".header > a").css("top","85px");
})
.on ("resize", function (ev) {
	var minheight = $("body").height();
	minheight = ev.target.outerHeight;
})

$(function () {
		var num = 0;
		var off = true;
		var off2 = true;
		var height = $(".item").eq(1).height();
		var downX = 0, downY = 0, upX = 0, upY = 0;

		$(window)
		    /*判断鼠标滚动方向，让页面上下滚动*/
		.on("mousewheel DOMMouseScroll",function (ev) {
			var delta = ev.originalEvent.wheelDelta;
			            /*(ev.originalEvent.wheelDelta && (ev.originalEvent.wheelDelta > 0 ? 1 : -1)) ||
		                (ev.originalEvent.detail && (ev.originalEvent.detail > 0 ? -1 : 1));*/

		    if (off == false) return;
		    off = false;
		    setTimeout(function () {
		    	off = true;
		    },500);
			if (delta < 0) {
				num++;
				num = num > $(".item").size() - 1 ? $(".item").size() - 1 : num;
				$(".item").stop().animate({top:-num*height},500);
			} else {
				num--;
				num = num < 0 ? 0 :num;
				$(".item").stop().animate({top:-num*height},500);

			}

             // 判断页面是否滚动，改变header
			if (num <= 0) {
				$(".header-mune i").css("left",num*82 + 421 + "px");
				$(".header-mune li").removeClass("header-mune_active").eq(num).addClass("header-mune_active");

				$(".header > a").css("top","85px");
				$(".header").css("height","74px");
				$(".header-logo").css({width:"290px",top:"20px"});
				$(".header-mune").css("margin","36px 0 0 110px");
				$(".header-mune > i").css({width:"54px"});
				$(".header-mune li").css({margin:"0 12px",fontSize:"20px"});
				$(".header-hotline").css({top:"32px",right:"215px"});
				$(".header-hotline span").css("fontSize","26px");
				$(".header-hotline u").css({top:"35px",right:"230px"});
				$(".header-bg").css("height","0");
			};
			if (num > 0) {
				num = num > $(".header-mune li").size() -1 ? $(".header-mune li").size() -1 : num;
				$(".header-mune li").removeClass("header-mune_active").eq(num).addClass("header-mune_active");

				$(".header-mune i").css("left",num*70 + 454 + "px");

				$(".header > a").css("top","-50px")
				$(".header").css("height","70px");
				$(".header-logo").css({width:"210px",top:"14px"})
				$(".header-mune").css("margin","22px 0 0 85px");
				$(".header-mune > i").css({width:"46px"});
				$(".header-mune li").css({margin:"0 10px",fontSize:"16px"});
				$(".header-hotline").css({top:"20px",right:"185px"});
				$(".header-hotline span").css("fontSize","20px");
				$(".header-hotline u").css({top:"20px",right:"195px"});
				$(".header-bg").css("height","70px");
			};
		})

			// 页面上下滑动改变位置
		.on ("mousedown",function (ev) {

			/*处理兼容*/
			var oe = ev || window.event;

			/*获取鼠标位置*/
			 downX = oe.clientX;
			 downY = oe.clientY;

			 /*清除浏览器默认行为*/
			 return false;
		})
		.on ("mouseup",function (ev) {

			/*判断off不为true 时返回false*/
			if (!off2) return;

			/*off2为true时，再赋值为false*/
			 off2 = false;

			 /*处理兼容，获取鼠标坐标，计算差值*/
			var event = ev || window.event;
			upX = event.clientX;
			upY = event.clientY;
			var differX = downX - upX;
			var differY = downY - upY;

			/*判断如果在X方向移动小于200切Y方向移动超过200时页面改变位置*/
			if (Math.abs(differX) <= 200 && Math.abs(differY) >= 200) {
				if (differX < 0) {
					num ++;
					num = num > $(".item").size() - 1 ? $(".item").size() - 1 : num;
				} else {
					num--;
					num = num < 0 ? 0 : num;
				}
				$(".item").stop().animate({
					top:-num*height
				},500,function () {
					off2 = true;
				});
			} else {
				off2 = true;
			}
		})


		/*点击 header 标题改变页面位置*/
		$(".header-mune li").click (function () {
			num = $(this).index();
			$(".header-mune li").removeClass("header-mune_active").eq($(this).index()).addClass("header-mune_active");
			$(".item").stop().animate({top:-num*height},500);



			if (num <= 0) {
				$(".header-mune i").css("left",num*82 + 421 + "px");
				$(".header > a").css("top","85px");
				$(".header").css("height","74px");
				$(".header-logo").css({width:"290px",top:"20px"});
				$(".header-mune").css("margin","36px 0 0 110px");
				$(".header-mune > i").css({width:"54px"});
				$(".header-mune li").css({margin:"0 12px",fontSize:"20px"});
				$(".header-hotline").css({top:"32px",right:"215px"});
				$(".header-hotline span").css("fontSize","26px");
				$(".header-hotline u").css({top:"35px",right:"230px"});
				$(".header-bg").css("height","0");
			};
			if (num > 0) {
				$(".header-mune i").css("left",num*70 + 454 + "px");
				$(".header > a").css("top","-50px")
				$(".header").css("height","70px");
				$(".header-logo").css({width:"210px",top:"14px"})
				$(".header-mune").css("margin","22px 0 0 85px");
				$(".header-mune > i").css({width:"46px"});
				$(".header-mune li").css({margin:"0 10px",fontSize:"16px"});
				$(".header-hotline").css({top:"20px",right:"185px"});
				$(".header-hotline span").css("fontSize","20px");
				$(".header-hotline u").css({top:"20px",right:"195px"});
				$(".header-bg").css("height","70px");
			};
		})
		$(".header-mune li").mouseenter (function () {
			if (num <= 0) {
				$(".header-mune i").css("left",$(this).index()*82 + 421 + "px")
			} else {
				$(".header-mune i").css("left",$(this).index()*70 + 454 + "px");
			}
			$(".header-mune li").removeClass("header-mune_active").eq($(this).index()).addClass("header-mune_active");
			$(".header-mune li").eq(num).addClass("header-mune_active");
		})
		$(".header-mune").mouseleave (function () {
			if (num <= 0) {
				$(".header-mune i").css("left",num*82 + 421 + "px");
			} else {
				$(".header-mune > i").css("left",num*70 + 454 + "px");
			}
			$(".header-mune li").removeClass("header-mune_active").eq(num).addClass("header-mune_active");
		})

		/*右侧边栏*/
		$(".dock-list1").click (function () {
			num--;
			num = num < 0 ? 0 : num;

			$(".header-mune li").removeClass("header-mune_active").eq(num).addClass("header-mune_active");
			$(".item").stop().animate({top:-num*height},500);
			if (num <= 0) {
				$(".header-mune i").css("left",num*82 + 421 + "px");

				$(".header > a").css("top","85px");
				$(".header").css("height","74px");
				$(".header-logo").css({width:"290px",top:"20px"});
				$(".header-mune").css("margin","36px 0 0 110px");
				$(".header-mune > i").css({width:"54px"});
				$(".header-mune li").css({margin:"0 12px",fontSize:"20px"});
				$(".header-hotline").css({top:"32px",right:"215px"});
				$(".header-hotline span").css("fontSize","26px");
				$(".header-hotline u").css({top:"35px",right:"230px"});
				$(".header-bg").css("height","0");
			};
			if (num > 0) {
				$(".header-mune i").css("left",num*70 + 454 + "px");

				$(".header > a").css("top","-50px")
				$(".header").css("height","70px");
				$(".header-logo").css({width:"210px",top:"14px"})
				$(".header-mune").css("margin","22px 0 0 85px");
				$(".header-mune > i").css({width:"46px"});
				$(".header-mune li").css({margin:"0 10px",fontSize:"16px"});
				$(".header-hotline").css({top:"20px",right:"185px"});
				$(".header-hotline span").css("fontSize","20px");
				$(".header-hotline u").css({top:"20px",right:"195px"});
				$(".header-bg").css("height","70px");
			};
		})
		$(".dock-list5").click (function () {
			num++;
			num = num > $(".header-mune li").size() ? $(".header-mune li").size() : num;
			if (num <= $(".header-mune li").size() -1) {
				$(".header-mune i").css("left",num*82 + 421 + "px");
				$(".header-mune li").removeClass("header-mune_active").eq(num).addClass("header-mune_active");
				$(".item").stop().animate({top:-num*height},500);
			} else {
				$(".item").stop().animate({top:-num*height},500);
			}
			if (num <= 0) {
				$(".header-mune i").css("left",num*82 + 421 + "px");

				$(".header > a").css("top","85px");
				$(".header").css("height","74px");
				$(".header-logo").css({width:"290px",top:"20px"});
				$(".header-mune").css("margin","36px 0 0 110px");
				$(".header-mune > i").css({width:"54px"});
				$(".header-mune li").css({margin:"0 12px",fontSize:"20px"});
				$(".header-hotline").css({top:"32px",right:"215px"});
				$(".header-hotline span").css("fontSize","26px");
				$(".header-hotline u").css({top:"35px",right:"230px"});
				$(".header-bg").css("height","0");
			};
			if (num > 0) {
				num = num > $(".header-mune li").size() -1 ? $(".header-mune li").size() -1 : num;
				$(".header-mune i").css("left",num*70 + 454 + "px");

				$(".header > a").css("top","-50px")
				$(".header").css("height","70px");
				$(".header-logo").css({width:"210px",top:"14px"})
				$(".header-mune").css("margin","22px 0 0 85px");
				$(".header-mune > i").css({width:"46px"});
				$(".header-mune li").css({margin:"0 10px",fontSize:"16px"});
				$(".header-hotline").css({top:"20px",right:"185px"});
				$(".header-hotline span").css("fontSize","20px");
				$(".header-hotline u").css({top:"20px",right:"195px"});
				$(".header-bg").css("height","70px");
			};
		})
		$(".show-box-movedown").click (function () {
			num = 1;
			$(".item").stop().animate({top:-num*height},500);
			$(".header-mune li").removeClass("header-mune_active").eq(num).addClass("header-mune_active");

			if (num > 0) {
				$(".header-mune i").css("left",num*70 + 454 + "px");

				$(".header > a").css("top","-50px")
				$(".header").css("height","70px");
				$(".header-logo").css({width:"210px",top:"14px"})
				$(".header-mune").css("margin","22px 0 0 85px");
				$(".header-mune > i").css({width:"46px"});
				$(".header-mune li").css({margin:"0 10px",fontSize:"16px"});
				$(".header-hotline").css({top:"20px",right:"185px"});
				$(".header-hotline span").css("fontSize","20px");
				$(".header-hotline u").css({top:"20px",right:"195px"});
				$(".header-bg").css("height","70px");
			};
		})
})



/*show轮播图*/
$(function () {
	var num = 1;
	var now = 0;
	var width = $(".show-col4").width();
	var len = $(".show-col").size();
	var timer = null;
	var off = true;
	var imgW = $(".show-col").width();
	var downX = 0, ulPosition = 0, moveX = 0;

	/*点击拖拽图片*/
	$(".show-col").mousedown (function (ev) {

		/*每次点击把开关关闭*/
		if (!off) return;
		off = false;

		now = $(this).index() - 1;

		/*每次点击将前一次的数值清零*/
		var difference = 0;

		/*关闭定时器*/
		clearInterval (timer);

		/*获取鼠标与轮播图位置*/
		dowmX = ev.clientX;
		ulPosition = $(".show > ul").position().left;


		/*移动鼠标*/
		$(document).mousemove (function (ev) {
			moveX = ev.clientX;

			/*鼠标在x坐标移动的距离*/
			difference = moveX - dowmX;

			$(".show > ul").css({left:ulPosition + difference})
		})

		/*放开鼠标*/
		$(document).mouseup (function (ev) {

			/*开启定时器*/
			timer = setInterval (move,5000);

			/*解绑鼠标点击与拖动效果*/
			$(document).off("mousemove");
			$(document).off("mouseup");

			/*拖动的距离大于图片的一半时移动改变位置*/
			if (Math.abs(difference) > imgW/2) {
				if (difference > 0) {
					num--;
					now--;
					if (num < 1) {
						num = len -2;
						$(".show > ul").css("left",num*-imgW)
					} else {
						$(".show > ul").animate({left:num*-imgW},300)
					}
				$(".show-box-swicth a").removeClass("show-box-swicth-active").eq(now).addClass("show-box-swicth-active");
				} else {
					num++;
					now++;
					if (num > len - 2) {
						num  = 1;
						$(".show > ul").css("left",num*-imgW)
					} else {
						$(".show > ul").animate({left:num*-imgW},300)
					}
					now = now >= len - 2 ? 0 : now;
					$(".show-box-swicth a").removeClass("show-box-swicth-active").eq(now).addClass("show-box-swicth-active");
				}
			} else {
				$(".show > ul").animate({left:ulPosition},300);
				$(".show-box-swicth a").removeClass("show-box-swicth-active").eq(now).addClass("show-box-swicth-active");
			}

			/*延时器等动画效果停止时才能再次点击*/
			setTimeout (function () {
				off = true;
			},300);

		})
	})




	/*自动轮播*/
	function move () {
		num++;
		if (num > len-1) {
			num = 2;
			$(".show > ul").css ("left",-width);
		}
		$(".show > ul").stop().animate ({left:-num*width});
		if (num > len-2) {
			$(".show-box-swicth a").removeClass("show-box-swicth-active").eq(0).addClass("show-box-swicth-active");
		} else{
			$(".show-box-swicth a").removeClass("show-box-swicth-active").eq(num-1).addClass("show-box-swicth-active");
		}
	}

	/*定时器*/
	timer = setInterval (move,5000)

	/*鼠标在轮播点上*/
	$(".show-box-swicth a").mouseenter (function () {
		clearInterval (timer);
		num = $(this).index();
		$(".show > ul").animate({left:-width*(num+1)});
		$(".show-box-swicth a").removeClass("show-box-swicth-active");
		$(this).addClass("show-box-swicth-active");
	})

	// /*鼠标离开轮播点*/
	$(".show-box-swicth a").mouseleave (function () {
		timer = setInterval (move,5000)
	})
})




/*show -> news轮播
*/$(function () {
	var num = 0;
	var timer = setInterval (function () {
		num -= 20;
		if (num < -80 ) {
			num = 0;
		}
		$(".show-box-news-content ul").css("top",num + "px")
	},3000)
	$(".show-box-news-content").hover (function () {
		clearInterval (timer)
	},function () {
		timer = setInterval (function () {
			num -= 20;
			if (num < -80 ) {
				num = 0;
			}
			$(".show-box-news-content ul").css("top",num + "px")
		},3000)
	})
})


// dock 隐藏
$(function () {
	$(".dock .dock-cl").click (function () {
		if ($(this).attr("class") == "dock-cl") {
			$(this).removeClass("dock-cl").addClass("dock-c2");
			$(".dock ul").css("right","-70px");
			$(".dock").css("opacity","0.5");
		} else {
			$(this).removeClass("dock-c2").addClass("dock-cl");
			$(".dock ul").css("right","0px");
			$(".dock").css("opacity","0.7");
		}
	})
})


// dock 电话输入
$(function () {
	$(".dock-list3 input").focus (function () {
		$(this).css("background-position","8px -674px");
	})
	$(".dock-list3 input").blur (function () {
		$(this).css("background-position","8px -706px");
	})
})


 // clients
$(function () {
	$(".clients-item").hover(function () {
		var oneLeft = $(this).position().left;
		var oneTop = $(this).position().top;
		$(".clients-bg-one").css({display : "block", top : oneTop + "px", left : oneLeft + "px"});
		$(this).css("background-positionY","-150px");
	},function () {
		$(".clients-bg-one").css("display","none");
		$(this).css("background-positionY","0");
	})

})


// aboutus
$(function () {
	var num = 0;
	var len = $(".aboutus-container-list").size();
	var timer = null;

	/*鼠标在标题上*/
	$(".aboutus-list").mouseenter (function () {
		num = $(this).index() + 1;
		$(".aboutus-list").css("color","#888").eq($(this).index()).css("color","#fff");
		$(".aboutus-one").css("top",$(this).position().top + "px");
		$(".aboutus-container-item").stop().animate({left:-480*num});
		clearInterval (timer);
	})

	/*鼠标离开标题*/
	$(".aboutus-list").mouseleave (function () {
		timer = setInterval(move,5000)
	})

	/*鼠标滑过开、关定时器*/
	$(".aboutus-container").hover (function () {
		clearInterval (timer);
	},function () {
		timer = setInterval(move,5000);
	})

	/*定时器*/
	timer = setInterval(move,5000);

	/*定时器函数*/
	function move () {
		num++;
		if (num > len) {
			num = 1;
			$(".aboutus-container-item").css("left",-480 + "px");
		}
		setTimeout (function () {
			$(".aboutus-container-item").animate({left:-480*num });
			if (num == len) {
				setTimeout (function () {
					$(".aboutus-one").css("top",0 + "px");
					$(".aboutus-list").css("color","#888").eq(0).css("color","#fff");
			},50)
			} else{
				$(".aboutus-one").css("top",42*(num-1) + "px");
				$(".aboutus-list").css("color","#888").eq(num - 1).css("color","#fff");
			}
		},50)
	}
	var moveW = $(".aboutus-container-list").width();
	var lens = $(".aboutus-container-item > li").size();
	var oneposition = 0;
	var place = 0;
	var now = 2;
	var onoff = true;
	var dowmX = 0, moveX = 0, x = 0;

	/*按下鼠标*/
	$(".aboutus-container-item > li").on("mousedown", function (ev) {

			dowmX = ev.clientX;
			place = $(".aboutus-container-item").position().left;
			oneposition = $(".aboutus-one").position().top;

			now = $(this).index();

			/*每次点击清零*/
			var difference = 0;

			$(document).on("mousemove",function (ev) {
				moveX = ev.clientX;
				difference = moveX - dowmX ;
				$(".aboutus-container-item").css("left",place + difference)
			})

		/*松开鼠标*/
		$(document).on("mouseup",function () {
			/*解绑事件*/
			$(document).off("mousemove");
			$(document).off("mouseup");


			if (Math.abs(difference) < moveW/2) {
				$(".aboutus-container-item").animate({left:-now*moveW})
				return;
			}
			if (difference > 0) {
				now--;
				console.log("xiangyou")
				console.log(now)
				if (now < 1) {
					$(".aboutus-container-item").css({left:-(lens-2)*moveW})
				} else{
					$(".aboutus-container-item").animate({left:-now*moveW});
				}
				if (oneposition <= 0) {
					$(".aboutus-one").css("top",84 + "px");
				} else {
					$(".aboutus-one").css("top",-42 + oneposition + "px");
				}
				if (now < 1) {
					$(".aboutus-list").css("color","#888").eq(2).css("color","#fff");
				} else {
					$(".aboutus-list").css("color","#888").eq(now-1).css("color","#fff");
				}
			} else {
				now++;
				console.log(now)
				if (now > lens-2) {
					$(".aboutus-container-item").css({left:-moveW})
				} else{
					$(".aboutus-container-item").animate({left:-now*moveW});
				}
				if (oneposition >= 84) {
					$(".aboutus-one").css("top",0 + "px");
				} else {
					$(".aboutus-one").css("top",42 + oneposition + "px");
				}
				if (now > lens - 2) {
					$(".aboutus-list").css("color","#888").eq(0).css("color","#fff");
				} else {
					$(".aboutus-list").css("color","#888").eq(now-1).css("color","#fff");
				}
			}
		})
	})

})