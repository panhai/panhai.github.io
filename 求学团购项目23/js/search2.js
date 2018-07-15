//辅助页面布局
function layou() {
	$('.shoping-box>div:visible').each(function() {
		var index = $(this).index();
		if((index + 1) % 4 == 0) {
			$(this).css('margin-right', '0px')
		}
	})
}
layou()

$(function() {
	var $shopingBox = $('.shoping-box').clone(true).html(''); //复制一个空盒子
	var $kanItem = $('.kanItem');     // 砍价的
	var $tuanItem = $('.tuanItem');   // 团购的
	
	//	console.log($shopingBox)
	
	//课程类型
	$('.coursetype a').click(function() {
		$(this).addClass('active').siblings('a').removeClass('active');
		var clsssname = $(this).attr('class');
		//判断是那种类型  all（全部）  tuan 团购   kan 砍价
		return false;
	})
	//那种类型显示  all（全部）  tuan 团购   kan 砍价
	$('.coursetype a.all').click(function() {
		$('.shoping-box').children('div').show();
		return false;
	})
	$('.coursetype a.tuan').click(function() { //.kanItem  tuanItem
		//只显示有团购标识的  shopall(表示团购)
//		$('.tuanItem').show();
//		$('.kanItem').hide()
		return false;
	})
	
	//选着价格课程 displaybox .prive  numprive .displaybox a.prive
	$('.displaybox a.prive').mouseenter(function() {
		$('.numprive').slideDown(100);
	})
	$('.numprive span.h').click(function(event) {
		var val = $(this).text(); //价格段选着
		$('.prive').children('span').html(val);
		$('.numprive').slideUp(100);
		event.stopPropagation();
		return false;
	})
	$('.numprive').mouseleave(function() {
		$(this).slideUp(100);
	})

	//输入价格选着
	$('.selectbtn').click(function(event) {
		var start = $.trim($('.shuru .start').val());
		var end = $.trim($('.shuru .end').val());

		if(end && start && (end-start>0)) {
			$('.prive').children('span').html(start + '-' + end + '元');
			$('.shuru .start').val('');
			$('.shuru .end').val('');
			$('.numprive').slideUp(100);
			$('.selectbtn').css({background:'#dcdcdc','cursor':'not-allowed'});
		}
		if(end-start<0){
			layer.msg('请输入正确的价格区间');
			return false;
		}
		event.stopPropagation();
		return false;
	})

	//选着价格排序 sort11 sort22 //选着价格排序 sort11 sort22
	$('.sort  img').click(function() {
		var name = $(this).attr('class');
		if(name == 'sort11') {
			$('.sort11').attr('src', 'img/sort2.png')
			$('.sort22').attr('src', 'img/sort22.png')
		} else {
			$('.sort11').attr('src', 'img/sort11.png')
			$('.sort22').attr('src', 'img/sort1.png')
		}
	})
	$('.displaybox .d').click(function() {
		$(this).addClass('active').siblings('.d').removeClass('active');
	})

	//分页
	var pagingnum = 1;
	$('.paging a.nums').click(function() {
		$(this).addClass('active').siblings('.nums').removeClass('active');
		pagingnum = $(this).text();
		return false;
	})
	//上一页
	$('.up').click(function() {
		if(pagingnum <= 1) {
			pagingnum = 1;
			$(this).addClass('show');
			$('.down').removeClass('show');
			return false;
		} else {
			pagingnum--;
			$('a.nums').each(function() {
				if($(this).text() == pagingnum) {
					$(this).addClass('active').siblings('.nums').removeClass('active');
				}
			})
			$(this).removeClass('show');
			$('.down').removeClass('show');
		}
	})
	//下一页
	$('.down').click(function() {
		if(pagingnum >= 4) {
			pagingnum = 4;
			$(this).addClass('show');
			$('.up').removeClass('show');
			return false;
		} else {
			pagingnum++;
			$('a.nums').each(function() {
				if($(this).text() == pagingnum) {
					$(this).addClass('active').siblings('.nums').removeClass('active');
					return false;
				}
			})
			$(this).removeClass('show');
			$('.up').removeClass('show');
		}
	})
})