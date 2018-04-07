(function(){
	$(function(){
//		var url = [
//			"img/swipe1.jpg",
//			"img/swiper2.jpg",
//			"img/swiper3.jpg",
//			"img/swiper4.jpg"
//		]
		var bg = [
			"rgb(172,229,246)",
			"rgb(0,38,163)",
			"rgb(254,218,0)",
			"rgb(213,233,208)"
		]
		var now = 0;
		var times = null;
		//移入切换
		$('.radius li').mouseenter(function(){
			var index = $(this).index();
			now = index;
			$('#swiper-box').css('background-color',bg[now]);
			$('.swiperBox li').eq(now).fadeIn(200).siblings('li').hide();
			$(this).addClass('active').siblings('li').removeClass('active');
		})
		//左右点击
		$('#swiper-box .left').click(function(){
			toLeft()
		})
		$('#swiper-box .right').click(function(){
			toRight()
		})
		
		//定时播放
		times = setInterval(toLeft,2000)
		//移入移出
		$('#swiper-box').hover(function(){
			clearInterval(times);
		},function(){
			times = setInterval(toLeft,2000)
		})
		
		
		
		
		
		function toLeft(){
			now++;
			if(now > $('.swiperBox li').length-1){
				now = 0;
			}
			$('.swiperBox li').eq(now).fadeIn(200).siblings('li').hide();
			$('#swiper-box').css('background-color',bg[now]);
			$('.radius li').eq(now).addClass('active').siblings('li').removeClass('active');
		}
		function toRight(){
			now--;
			if(now < 0){
				now = $('.swiperBox li').length-1;
			}
			$('.swiperBox li').eq(now).fadeIn(200).siblings('li').hide();
			$('#swiper-box').css('background-color',bg[now]);
			$('.radius li').eq(now).addClass('active').siblings('li').removeClass('active');
		}
		
	})
})()
