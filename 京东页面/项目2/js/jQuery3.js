/*
 * 1:头部城市部分
 * 2:轮播图左侧背景动画
 * 3:左侧导航列表显示内容
 * 4:头部搜索框
 * 5:轮播图右侧tab切换
 * 6:头部轮播图右侧注册下部分
 * 7:秒杀京东栏轮播图
 * 8:小轮播图
 * 9:爱生活移动动漫
 * 10：享生活右侧轮播图
 * 
 * 
 * 
 */

//1
$(document).ready(function(){
	//移入城市按钮显示城市移出隐藏
	$("#city").mouseenter(function(){
		$("#city_box").css({"display":"block"})
		$("#city_box li").click(function(){
			$(this).addClass("active").siblings().removeClass("active");
		})
	})
	
	$("#city").mouseleave(function(){
		$("#city_box").css({"display":"none"})
	})
	
	//点击交换城市和消失
	$("#city_box li a").click(function(){
		var cont = $(this).html();
		$("#city .city").html(cont)
		$("#city_box").css("display","none")
	})
})

//2
$(function(){
	$("#slideshow_content2").hover(function(){
		$("#slideshow_content2 .bg_box").animate({"width":"990px"},1000)
	},function(){
		$("#slideshow_content2 .bg_box").animate({"width":"0px"},1000)
	})
})

//3
$(function(){
	var arr = [
	"red",
	"blue",
	"yellow",
	"green",
	"#fac",
	"#ABoBo",
	"#877656",
	"#ffccbb",
	"#ccg",
	"#fgc",
	"pink",
	"#lmn",
	"a23456",
	"#545454",
	"#898989",
	"#123321"
	]
	$("#sidebar_box li").mouseenter(function(){
		var index = $(this).index();
		$("#sidebar_box .cont_list").eq(index).css("display","block").siblings(".cont_list").css("display","none");
		$("#sidebar_box .cont_list").eq(index).css({"border-color":arr[index]})
	})
	$("#sidebar_box").mouseleave(function(){
		$('#sidebar_box .cont_list').css("display","none");
	})
})

//4：
$(function(){
	var arrry = [
	"新款手机实惠价",
	"精品好货不错过",
	"时尚家居赶快买",
	"特价商品在京东",
	"二手价不错哦"
	];
	var now = 0;
	times = setInterval(function(){
		now++;
		if(now > arrry.length-1) now = 0;
		$("#user").attr({"placeholder":arrry[now]})
	},2000)
	
	$("#user").focus(function(){
		clearInterval(times);
	})
	$("#user").blur(function(){
		times = setInterval(function(){
		now++;
		if(now > arrry.length-1) now = 0;
			$("#user").attr({"placeholder":arrry[now]})
		},2000)
	})
})

//5 
$(function(){
	$("#Marketing_box .m1").mouseenter(function(){
		$("#MyMove").animate({"left":"0px"})
		$("#Marketing_box .Marketing_c").eq(0).addClass("showT").siblings(".Marketing_c").removeClass("showT");
	})
	$("#Marketing_box .m2").mouseenter(function(){
		$("#MyMove").animate({"left":"45px"})
		$("#Marketing_box .Marketing_c").eq(1).addClass("showT").siblings(".Marketing_c").removeClass("showT");
	})
})

//6
$(function(){
	//1:移入头部话费。。四个选项显示对应的内容选项框（同时显示删除框按钮）
	var onoff = false;
	var count = 0;
	$("#convenience_box .sj").mouseenter(function(){
		count++;
		if(count > 0 &&count < 2) {onoff==true}
		setTimeout(function(){
			onoff = true;
		},1500)
		
		var index = $(this).index();
		if(onoff==true){
			$("#convenience_box").animate({"top":-36},500);
			$("#remove_box").show();
			$("#moresearch_box").animate({"bottom":0},200)
			$("#moresearch_box .move_box").eq(index).show().siblings(".move_box").hide()
		}
	})
	
	$("#remove_box").click(function(){
		onoff = false;
		$("#convenience_box").animate({"top":0},500);
		$("#moresearch_box").stop().animate({"bottom":-180},200,function(){
			$("#remove_box").hide()
		});
		
	})
	
})


//7
$(function(){
	var $oPrevL = $("#prveL");
	var $oNext = $("#nextR");
	var $oBox = $("#kill_jingdong .killsop_left");
	var $oimg_Ul = $("#killsop_list");
	var $aLi = $("#killsop_list li");
	
	var timer = 0;
	var timer2 = 0;
	var now = 0;
	var nWidth = $aLi.eq(0).innerWidth();
	
	
	
	//移入 大盒子
	$oBox.mouseenter(function(){
		$oPrevL.show();
		$oNext.show();
		clearInterval(timer);
	})
	$oBox.mouseleave(function(){
		$oPrevL.hide();
		$oNext.hide();
		
		timer = setInterval(function(){
			$oPrevL.click()
		},2000)
	})
	//左右按钮
	$oPrevL.click(function(){
		now++;
		if(now > 4) {
			$oimg_Ul.css("left",-nWidth);
			now =1;
		}
		
		Timer2 = setTimeout(function(){
			$oimg_Ul.animate({left:-5*now*nWidth},500)
		},100)
	})
	
	$oNext.click(function(){
		now--;
		if(now < 0) {
			now =4;
			$oimg_Ul.css("left",-4*5*nWidth);
			console.log(now)
		}
		
		Timer2 = setTimeout(function(){
			$oimg_Ul.animate({left:-5*now*nWidth},500)
		},100)
	})
	
	timer = setInterval(function(){
		$oPrevL.click()
	},2000)
	
})

//8
$(function(){
	var index = 0;
	var timer = 0;
	var $aImg = $(".killsop_right a");
	var $aBtn = $(".killsop_right_tollge p");
	$aBtn.mouseenter(function(){
		index = $(this).index();
		$(this).addClass("activeBtn").siblings().removeClass("activeBtn");
		$aImg.eq(index).addClass("showL").siblings("a").removeClass("showL");
	})
	timer = setInterval(function(){
		index++;
		if(index >$aImg.size() ) index = 0;
		$aImg.eq(index).addClass("showL").siblings("a").removeClass("showL");
		$aBtn.eq(index).addClass("activeBtn").siblings("p").removeClass("activeBtn");
	},2000)
	
	//移入移出
	$(".killsop_right").mouseenter(function(){
		clearInterval(timer)
	})
	
	$(".killsop_right").mouseleave(function(){
		timer = setInterval(function(){
			index++;
			if(index >$aImg.size() ) index = 0;
			$aImg.eq(index).addClass("showL").siblings("a").removeClass("showL");
		},2000)
	})
	
})

//9
$(function(){
	var $three_btn1 = $("#three_btn1");
	var $three_btn2 = $("#three_btn2");
	var $three_ul = $("#three_ul");
	var Width = $("#three_ul li").eq(0).width();
	var $three = $(".three");
	var now = 0;
	var timer = null;
	
	$three.mouseenter(function(){
		$three_btn1.show();
		$three_btn2.show();
	})
	$three.mouseleave(function(){
		$three_btn1.hide();
		$three_btn2.hide();
	})
	
	$three_btn1.click(function(){
		now++;
		if(now > 3){
			now =1;
			$three_ul.css("left","0px",function(){
				$three_ul.animate({left:-6*now*Width},900,"easeOutBounce")
			})
		}
		timer = setTimeout(function(){
			$three_ul.animate({left:-6*now*Width},900,"easeOutBounce")
		},100)
	})
	
	$three_btn2.click(function(){
		now--;
		if(now <0){
			now = 2;
			$three_ul.css("left",-6*now*Width,function(){
				$three_ul.animate({left:-(now+1)*6*Width},900,"easeOutBounce")
			})
		}
		timer = setTimeout(function(){
			$three_ul.animate({left:-6*now*Width},900,"easeOutBounce")
		},100)
	})
	
})
//10
$(function(){
	var $three_btn11 = $("#three_btn11");
	var $three_btn22 = $("#three_btn22");
	var $three_ul2 = $("#three_ul2");
	var Width = $("#three_ul li").eq(0).width();
	var $three = $(".three");
	var now = 0;
	var timer = null;
	
	$three.mouseenter(function(){
		$three_btn11.show();
		$three_btn22.show();
	})
	$three.mouseleave(function(){
		$three_btn11.hide();
		$three_btn22.hide();
	})
	
	$three_btn11.click(function(){
		now++;
		if(now > 3){
			now =1;
			$three_ul.css("left","0px",function(){
				$three_ul2.animate({left:-6*now*Width},900,"easeOutBounce")
			})
			
		}
		timer = setTimeout(function(){
			$three_ul2.animate({left:-6*now*Width},900,"easeOutBounce")
		},100)
	})
	
	$three_btn22.click(function(){
		now--;
		if(now <0){
			now = 2;
			$three_ul2.css("left",-6*now*Width,function(){
				$three_ul.animate({left:-(now+1)*6*Width},900,"easeOutBounce")
			})
		}
		timer = setTimeout(function(){
			$three_ul2.animate({left:-6*now*Width},900,"easeOutBounce")
		},100)
	})
	
})

//10享品质右侧轮播图
$(function(){
	var $oBox = $("#Jingdong-live");
	var $oul = $("#Jingdong-live .Img_b");
	var $Img = $("#Jingdong-live .Img_b li img");
	var $Btn_ul = $("#Jingdong-live .btn_box");
	var $Left = $("#Jingdong-live .preveA");
	var $Right = $("#Jingdong-live .nextB");
	var $Shade = $("#Jingdong-live .shadeB");
	
	var $li = '';
	var now = 0;
	var timer = null;
	var timer2 =null;
	var onoff = true;
	var Imgarray = ["shiping1.jpg","shiping2.jpg","shiping3.jpg","shiping4.jpg","shiping5.jpg",];
	
	//显示第一张图片
	$Img.attr("src","img/"+Imgarray[0])
	//动态创建切换圆点
	$.each(Imgarray,function(i,itemr) {
		$li += "<li>"+"</li>"
	})
	$Btn_ul.html($li);
	//开始显示第一个圆点为红色
	$Btn_ul.children("li").eq(0).addClass("activeB").siblings("li").removeClass("activeB");
	
	//圆点切换each（）方法两个参数：数组（集合），2回调函数
	$.each($Btn_ul.children("li"),function(i,itemr) {
		$Btn_ul.children("li").eq(i).mouseenter(function(){
			var index = $(this).index();
			now = index;
			$(this).addClass("activeB").siblings("li").removeClass("activeB");
			$Img.attr("src","img/"+Imgarray[now])
		})
	})
	$Shade.mouseleave(function(){
		$Img.css({"opacity":".5"})
		timer = setInterval(function(){
			move(1)
		},1000);
	})
	$Shade.mouseenter(function(){
		clearInterval(timer);
	})
	
	timer = setInterval(function(){
		move(1)
	},1000);
	
	$Left.click(function(){
		clearInterval(timer);
		clearTimeout(timer2)
		if(onoff){
			move(-1)
			onoff = false;
		}
		timer2 = setTimeout(function(){
			onoff = true;
		},500)
	})
	$Right.click(function(){
		clearInterval(timer);
		clearTimeout(timer2)
		if(onoff){
			move(1)
			onoff = false;
		}
		timer2 = setTimeout(function(){
			onoff = true;
		},500)
	})
	
	
	//轮播函数
	function move (num) {
		now +=num;
		if(num==1) {
			if(now > Imgarray.length -1) now =0;
			$Btn_ul.children("li").eq(now).addClass("activeB").siblings("li").removeClass("activeB");
			$Img.attr("src","img/"+Imgarray[now])
			$Img.animate({"opacity":.9},1000)
		}
		if(num==-1) {
			now = now < 0? Imgarray.length -1 : now;
			$Btn_ul.children("li").eq(now).addClass("activeB").siblings("li").removeClass("activeB");
			$Img.attr("src","img/"+Imgarray[now])
			$Img.animate({"opacity":.9},1000)
		}
	}
	
	
})
