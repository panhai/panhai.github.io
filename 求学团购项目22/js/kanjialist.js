
//全部页面的弹框
$(function(){ //.alertWx
	
	$('body').on('click','.alertWx',function(){
		alertWx();//开始弹框
		return false;
	})
	setTimeout(function(){
		$('#closeid').click()
	},180000)
})
//回到顶部
$('.goTop').on('click',function(){
	goTop()
})
//右侧固定导航蓝  right-fixBox ul li 


//今日上线 轮播  newbox   contain-news-box

$(function(){
	var times = null;
	var num = 0;
	var step = $('.newbox>li').height();
	var len = $('.contain-news-box .newbox>li').length;
	var $newbox = $('.newbox');
	//控制显示5个
	
	function move(){
		times=setInterval(function(){
			num++;
			if(num > len-5){
				num = 0;
				$newbox.animate({top:0},400)
			}
			$newbox.animate({top:-num*step},1000)
		},2000)
	}
	if(len>5){
		move();//开始运动
	}
	
	//移入停止定时器
	$('.contain-news-box').hover(function(){
		clearInterval(times);
	},function(){
		move();
	})
	
})

//推荐轮播图 显示8张轮播

$(function(){  //swiper prev next swiperbox
	var step = $('.swiperbox>li').width();
	var len = $('.swiperbox>li').length;
	var times = null;
	var num = 0;
//	console.log(len)
	
	function move(){
		$('.swiperbox').animate({left:-step},function(){
			var m=$('.swiperbox>li').eq(num).remove()
			$('.swiperbox').append(m);
			$(this).css('left','0px')
		})
	}
	//开始运动
	times = setInterval(function(){
		move()
	},2500)
	
	
	//移入  swiper .prev .next
	$('.swiper').hover(function(){
		$('.prev').stop().animate({left:0})
		$('.next').stop().animate({right:0})
		clearInterval(times);
	},function(){
		$('.prev').stop().animate({left:-32})
		$('.next').stop().animate({right:-32})
		times = setInterval(function(){
			move()
		},2500)
	})
	
	//点击左右按钮 4张
	$('.prev').on('click',function(){
		num++;
		if(num > 1){
			num = 0;
			$('.swiperbox').css('left',$('.swiperbox').width()+'px')
		}
		$('.swiperbox').animate({left:-4*num*step})
	})
	$('.next').on('click',function(){
		num--;
		if(num <0){
			 num=1;
			$('.swiperbox').css('left',$('.swiperbox').width()+'px')
		}
		$('.swiperbox').animate({left:-4*num*step})
	})
})

//左侧固定导航tab切换
$(function(){
	$('.leftFix-tab .li').on('click',function(){
		$(this).addClass('acitve').siblings('.li').removeClass('acitve');
	})
	//tab切换
	$('.ulNav li').on('click',function(){
		$(this).addClass('acitve').siblings('li').removeClass('acitve');
	})
	//显示tabbox
	$('.nevgo').hover(function(){
		$('.goNav').stop(true,true).slideDown(400)
	},function(){
		$('.goNav').stop(true,true).slideUp(400)
	})
})

//模拟数据做渲染
$(function(){
	//清理缓存
	$.ajaxSetup ({ cache: false });
	
	//复制一份当作数据
	var num = 10;//每次渲染的数据条数
	//复制
	var html = $('.Lowestprice .Lowestprice-box .Lowes-item').eq(0).clone(true).prop("outerHTML");
//	console.log(html)
	//先显示10条
	var newhtml="";
	var m = "";
	var m2 = "";
	var m3 = "";
	for(var i=0;i<num;i++){
		newhtml+=html;
	}
	
	$('.Lowestprice .Lowestprice-box').html(newhtml);
//	console.log(newhtml)
	//懒加载内容
	var viewH,viewH,bHeight; //视口高度  //页面垂直的滚动条距离  //页面高度
	console.log($('.Lowestprice .Lowestprice-box .Lowes-item:visible').length)
	
	var code =0;// 模块数据识别 1 代表 疯狂热购 2 代表 口碑炸裂  3：--最新上线;
	
	 $(window).scroll(function(){
    	viewH = $(window).height();
    	scrollTops = $(window).scrollTop();
    	bHeight = $(document).height();
    	
    	if(scrollTops > bHeight - viewH-50){
    		//判断是否停止数据渲染  0 最低价
	    	if(code==0){
	    		if($('.LowesBox .Lowestprice-box .Lowes-item:visible').length>=20){
					code++;
	    			return false;//停止渲染
	    		}else{
	    			
	    			$('.LowesBox .Lowestprice-box').append($(newhtml));
	    		}
	    	}
    		if(code==1){//--疯狂热购--
    			$('.Crazily-hot-purchase').show();
    			if($('.Crazily-hot-purchase .Lowestprice-box .Lowes-item:visible').length>=20){
					code++;
	    			return false;//停止渲染
	    		}else{
	    			for(var i=0;i<10;i++){
	    				m+=html;
	    			}
	    			$('.Crazily-hot-purchase .Lowestprice-box').append($(m))
	    		}
    		}
    		
    		if(code==2){///*	<!口碑炸裂> */
    			$('.Word-of-mouth').show();
    			if($('.Word-of-mouth .Lowestprice-box .Lowes-item:visible').length>=20){
    				code++;
	    			return false;//停止渲染
    			}else{
    				for(var i=0;i<10;i++){
	    				m2+=html;
	    			}
    				$('.Word-of-mouth .Lowestprice-box').append($(m2))
    			}
    		}
    		if(code==3){//--最新上线  
    			$('.Latest-online').show();
    			if($('.Latest-online .Lowestprice-box .Lowes-item:visible').length>=20){
    				code++;
    				$('.Latest-online').children('.prompt-title').show();
    				$('#leftFix').show(200)//显示左侧固定导航
	    			return false;//停止渲染
    			}else{
    				for(var i=0;i<10;i++){
	    				m3+=html;
	    			}
    				$('.Latest-online .Lowestprice-box').append($(m3))
    			}
    		}
//  		console.log($('.LowesBox .Lowestprice-box .Lowes-item:visible').length)
    	}
    })
})


//tips - tips方向和颜色
$('.address').hover(function(){
	$(this).parent().parent().siblings('#tips').slideDown(200);
	var _this = this;
	setTimeout(function(){
		$(_this).parent().parent().siblings('#tips').slideUp(200);
	},3000)
},function(){
	
})


//楼层移动
$(function(){ 
	var $linew = $('.leftFix-tab>li');
	var $Lowestprice = $('.Lowestprice');
	var tH = 0;
	$linew.on('click',function(){
		var index = $(this).index()
		tH = $Lowestprice.eq(index).offset().top;
		$('html,body').animate({scrollTop:tH},400);
	})
})
