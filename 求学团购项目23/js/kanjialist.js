
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
//	times = setInterval(function(){
//		move()
//	},2500)
//	
	
	//移入  swiper .prev .next
	$('.swiper').hover(function(){
		$('.prev').stop().animate({left:0})
		$('.next').stop().animate({right:0})
		clearInterval(times);
	},function(){
		$('.prev').stop().animate({left:-32})
		$('.next').stop().animate({right:-32})
//		times = setInterval(function(){
//			move()
//		},2500)
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
	$('.ulNav li').mouseenter(function(){ //listBoxfixshow
		$(this).addClass('acitve').siblings('li').removeClass('acitve');
		var index = $(this).index();
//		var content = $(this).text();
//		$('.nevgo .a').html(content);//把自己的内容替换$('.nevgo .a') 的内容
		$('.listBoxfix').eq(index).addClass('listBoxfixshow').siblings('.listBoxfix').removeClass('listBoxfixshow');
	})
	//显示tabbox
	$('.nevgo').hover(function(){
		$('.goNav').stop(true,true).slideDown(400)
	},function(){
		$('.goNav').stop(true,true).slideUp(400)
	})
	$('.listBoxfix a').on('click',function(){  //ulNav li a   (nevgo .a)
		$(this).addClass('acitve').siblings('a').removeClass('acitve');
		$(this).parent().parent().siblings('.listBoxfix').find('a').removeClass('acitve');
		var index = $(this).parent().parent().index();
		console.log(index)
		var contA = $('.ulNav li a').eq(index-1).text();
		console.log(contA)
		var content = $(this).text();
		$('.nevgo .b').html(content);//把自己的内容替换$('.nevgo .b') 的内容
		$('.nevgo .a').html(contA)
		return false;
	})
	
	
	// 热 炸 新  点击获取数据 模拟数据    Crazily-hot-purchase  Word-of-mouth  Latest-online  leftFix-tab
	var html = $('.Lowestprice .Lowestprice-box .Lowes-item').eq(0).clone(true).prop("outerHTML");

	$('.leftFix-tab li').eq(1).on('click',function(){
		var newhtml = '';
		for(var i=0;i<10;i++){
			newhtml+=html;
		}
		$('.Crazily-hot-purchase').show();
		$(newhtml).appendTo($('.Crazily-hot-purchase .Lowestprice-box'))
	})
	
	$('.leftFix-tab li').eq(2).on('click',function(){
		var newhtml = '';
		for(var i=0;i<10;i++){
			newhtml+=html;
		}
		$('.Word-of-mouth').show();
		$(newhtml).appendTo($('.Word-of-mouth .Lowestprice-box'))
	})
	$('.leftFix-tab li').eq(3).on('click',function(){
		var newhtml = '';
		for(var i=0;i<10;i++){
			newhtml+=html;
		}
		$('.Latest-online').show();
		$(newhtml).appendTo($('.Latest-online .Lowestprice-box'))
	})
	
	//根据左侧导航二级分类列，点击获取分类的数据，再根据他是否是哪种数据类型 （低0   热1    炸2  新3）定位显示
	$('.listBoxfix a').on('click',function(){  // LowesBox  Crazily-hot-purchase  Word-of-mouth  Latest-online
		var dataType = $(this).attr('data-type');
		console.log(dataType=="0")
		if(dataType=='0'){
			//获取数据
			//定位显示
			$('html,body').scrollTop($('.LowesBox').offset().top);
		}
		if(dataType=='1'){
			$('html,body').scrollTop($('.Crazily-hot-purchase').offset().top);
		}
		if(dataType=='2'){
			$('html,body').scrollTop($('.Word-of-mouth').offset().top);
		}
		if(dataType=='3'){
			$('html,body').scrollTop($('.Latest-online').offset().top);
		}
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
//	console.log($('.Lowestprice .Lowestprice-box .Lowes-item:visible').length)
	
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
var timeout = null;
$('.address,.ellips').mouseenter(function(){
	$(this).parent().parent().siblings('.tips').slideDown(200);
})
$('.address,.ellips').mouseleave(function(){
	var _this = this;
	timeout = setTimeout(function(){
		$(_this).parent().parent().siblings('.tips').hide(200);
	},500)
})
$('.tips').hover(function(){
	$(this).show()
	clearTimeout(timeout);
},function(){
	$(this).hide()
})



//楼层移动
$(function(){ 
	var $linew = $('.leftFix-tab>li');
	var $Lowestprice = $('.Lowestprice');
	var tH = 0;
	$linew.on('click',function(){
		var index = $(this).index()
		tH = $Lowestprice.eq(index).offset().top;
//		console.log(tH)
		$('html,body').animate({scrollTop:tH+'px'},400);
		console.log(index)
	})
//	console.log($Lowestprice)
	$(window).scroll(function(){//判断滚动条移动  #leftFix 
		//判断移动到最低低价模块显示固定滚动条    LowesBox  Crazily-hot-purchase  Word-of-mouth  Latest-online
		var top = $('.LowesBox').offset().top;
		var top2 = $('.Crazily-hot-purchase').offset().top;
		var top3 = $('.Word-of-mouth').offset().top;
		var top4 = $('.Latest-online').offset().top;
		
		
		var scrolltop = $(document).scrollTop();
		
		if(scrolltop>top-30){
			$('#leftFix').show()
		}else{
			$('#leftFix').hide()
		}
		
//		if(scrolltop>top){//leftFix-tab
//			$('.leftFix-tab li').eq(0).addClass('acitve').siblings('li').removeClass('acitve');
//		}
//		if(scrolltop>top2){
//			$('.leftFix-tab li').eq(1).addClass('acitve').siblings('li').removeClass('acitve');
//		}
//		if(scrolltop>top3){
//			$('.leftFix-tab li').eq(2).addClass('acitve').siblings('li').removeClass('acitve');
//		}
//		if(scrolltop>top4){
//			$('.leftFix-tab li').eq(3).addClass('acitve').siblings('li').removeClass('acitve');
//		}
		
	})
	
})
