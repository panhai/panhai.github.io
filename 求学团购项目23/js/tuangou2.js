$(document).ready(function(){
	//图片切换
	var Ind = 0;
	var Siz = $('.tuList img').size();
	$('.le-ch,.ri-ch').click(function(){
		if($(this).hasClass('le-ch')){
			Ind--;
			if(Ind < 0){
				Ind = Siz-1;
			}
			$('.tuList img').eq(Ind).parent('li').css('border','solid 1px #a20812').siblings('li').removeAttr("style");
			$('.le-im img').attr("src",$('.tuList img').eq(Ind).attr("src"));
		}else{
			Ind++;
			if(Ind >= Siz){
			  Ind = 0;
			}
			$('.tuList img').eq(Ind).parent('li').css('border','solid 1px #a20812').siblings('li').removeAttr("style");
			$('.le-im img').attr("src",$('.tuList img').eq(Ind).attr("src"));
		}
	});
	
   $(".tuList li").hover(function(){
	    Ind = $(this).index();
        $(this).css('border','solid 1px #a20812').siblings('li').removeAttr("style")
		$(this).parents("ul").siblings("div").find("img").attr("src",$(this).find("img").data("src"))
	});
	
	
  //商品数量选择
  (function(){
    var 
    btn1 = $(".button1"),
    btn2 = $(".button2"),
    coum = btn1.siblings('input'),
    init = coum.val()||1;
    max  = parseInt(coum.attr("maxLength"));

    var setData = function(){
      init = coum.val() || 1;
    }

    btn1.click(function(){
      setData();
      init--;
      if(init <= 0){ 
        init = 1 ; 
        $('.ri-d p').show();
      }else if(init >= 1)
      {
        $('.ri-d p').hide();
      }
      coum.val(init);
      $('.ri-d b').hide();
    });

     btn2.click(function(){
      setData();
      init++;
      if(init > max)
        { 
          init = max ;
          $('.ri-d b').show();
        }else if(init >= 1)
        {
          $('.ri-d p').hide();
        }
      coum.val(init);
    })

  })();

  //数量下拉
  var shuliang=$('.show li').length;
  $('.shuoqi1 span').html(shuliang);  
           
  $('.shuoqi1').click(function(){
    $('.show').show();
    $(this).hide();
    $('.shuoqi2').show();
  });
  $('.shuoqi2').click(function(){
    $('.show').hide();
    $(this).hide();
    $('.shuoqi1').show();
  });

  
 //评价
 $('.yongfu .ul-a li').click(function(){
	 $(this).addClass('new').siblings().removeClass('new');
	 var hdw=$('.yongfu .ul-a li');
	 $('.daliuyan').eq(hdw.index(this)).show().siblings('.daliuyan').hide();
 }); 

   
 //分享到
  $('.ri-e .e-a').click(function(){
	  $(this).find('span').toggle();
  });  
  
     //商家顶部固定
   (function(){
    var $win = $(window);
    var $nav = $(".main-nav");
    var didu = $('#weizhi');
    var guomai = $('#zhi');
    var xianqing = $('#xian');
    var taoqian = $('#jie');
    var xiaofei = $('#yong');
    $nav.find('ul').removeClass('active')

    $win.scroll(function(){
      if($win.scrollTop() >= $nav.offset().top){
        $nav.find('ul').addClass('active')
      } else{
        $nav.find('ul').removeClass('active')
      }

      //滚动条
      if($win.scrollTop() >= didu.offset().top && $win.scrollTop() < guomai.offset().top){
        $('.nav-fi1').addClass('nav-fi').parents().siblings('li').find('a').removeClass('nav-fi')
        
      }else if($win.scrollTop() >= guomai.offset().top && $win.scrollTop() < xianqing.offset().top){
        $('.nav-fi2').addClass('nav-fi').parents().siblings('li').find('a').removeClass('nav-fi')
        
      }else if($win.scrollTop() >= xianqing.offset().top && $win.scrollTop() < taoqian.offset().top){
        $('.nav-fi3').addClass('nav-fi').parents().siblings('li').find('a').removeClass('nav-fi')
        
      }else if($win.scrollTop() >= taoqian.offset().top && $win.scrollTop() < xiaofei.offset().top){
        $('.nav-fi4').addClass('nav-fi').parents().siblings('li').find('a').removeClass('nav-fi')
        
      }else if($win.scrollTop() >= xiaofei.offset().top){
        $('.nav-fi5').addClass('nav-fi').parents().siblings('li').find('a').removeClass('nav-fi')
        
      }
	  //跳到对应的位置
	  $('.main-nav li').click(function(){
		  var ind = $('.main-nav li');
		$("html,body").stop(true);
		$("html,body").animate({scrollTop: $('.scroll').eq(ind.index(this)).offset().top}, 500);
	  });

    })
    //X,继续浏览
    $('.x,.but1').click(function(){
      $('#BgDiv').hide();
      $('.shopCh').hide();
      $('.shouchang').hide();
    });

    $('.chakan').click(function(){
      $('#BgDiv').show();
      $("#BgDiv").css({ display: "block", height: $(document).height() });
      $('#ditu').show();
    });

    //close2
     $('.close2').click(function(){
      $('#BgDiv').hide();
      $('#ditu').hide();
    });

   })();

   //图片放大
   $('.liuyan-img img').click(function(){
     $(this).parent('li').css('border','2px solid #FA6F15').siblings('li').removeAttr('style');
     console.log($(this).parent('li'))
     $(this).parents('.liuyan-ri').find('.datu').show();
     $(this).parents('.liuyan-ri').find('.datu').find('img').attr('src',$(this).data('src'));

   });
})


//提示疑问
$('.wen').mouseenter(function(){
	$('#tips').fadeIn(200)
})
$('.wen').mouseleave(function(){
	$('#tips').fadeOut(200)
})

//查看地图
$('.looks').click(function(){
	$('#ditu').show();
	$('##BgDiv').show()
})

//查看各店情况 mouseenter
$('.ditu-ri-item').mouseenter(function(){
	$(this).children('.item-msg').slideDown(200);
	$(this).siblings('.ditu-ri-item').children('.item-msg').slideUp(200)
	$(this).children('.itme').children('img').attr('src','img/xiala_1.png')
	$(this).siblings('.ditu-ri-item').children('.itme').children('img').attr('src','img/xiala_2.png')
})
