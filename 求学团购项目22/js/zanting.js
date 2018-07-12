/*
 * 顶部导航
 */
$(function(){
	$('ul.h-top-nav li').hover(function(){
		$(this).children('.fix').stop().slideDown(200);
	},function(){
		$(this).children('.fix').stop().slideUp(200);
	})
})

/*
 * 搜索框
 */
$(function(){
	$('.search-inp').focus(function(){
		$(this).val('');
	})
	$('.search-inp').blur(function(){
		$(this).val('请输入您要搜索的课程名称');
	})
	$('.search-tab span').hover(function(){
		$(this).addClass('active').siblings('span').removeClass('active');
		var index = $(this).index();
		$('.tab-item').eq(index).addClass('show').siblings('.tab-item').removeClass('show'); //对应下标显示
	},function(){
		$(this).addClass('active').siblings('span').removeClass('active');
		var index = $(this).index();
		$('.tab-item').eq(index).addClass('show').siblings('.tab-item').removeClass('show'); //对应下标显示
	})
	
})

//分类列表
$(function(){
	$('.main-a-nav li a.by').click(function(){
		$(this).addClass('acitve')
			.parent().siblings('li')
			  .children('a').removeClass('acitve');
			  return false;
	})
})


//<!-- 营业中而且是上线的门店 显示课程 --> 控制显示个数 
//只显示5个  超出显示  按钮还剩多少个     2 点击可以显示全部  （按钮内容改为收起）3 点击收起 回到原来的显示状态

$(function(){    //模拟数据显示
	
	var data = [
		{list1:9,start:1},
		{list2:3,start:1},
		{list3:3,start:0}
	]
	
	var num = data[0].list1;  //数据总数
	var numshow = (data[0].list1>5) ? 5: data[0].list1;  //开始显示的数据个数
	var numde = (data[0].list1>5) ? data[0].list1-5: 0;  //剩余不显示的数据个数
	var start = false; //数据超过5的状态 
	
//	console.log(data[0].list1)
	
	
	if(data[0].list1>5){
		start = true;
	}
	// 1 列表数据1
	var htmls = ''; //前5条显示的数据
	var htmls2 = '';//后5条显示的数据
	var html = $('.one li').prop('outerHTML');
	var btnhtml = $('.show-num').html(); //按钮内容
	
	
	for(var i=0; i<numshow;i++){
		htmls+=html;
	}
	
	for(var i=0; i<numde;i++){
		htmls2+=html;
	}
	
	//开始显示数据  list1
	$('.Business-list1 .one').html(htmls);
	//渲染超出5个的数据
	($('.Business-list1 .stwo').html(htmls2)).appendTo($('.fendian-box .one'));
	//显示还剩多少个
	$('.Business-list1 .show-num .num').html(numde + '个');
	//判断是否显示剩余按钮
	if(start){
		$('.Business-list1 .show-num').show();
	}
	
	
	// 2列表数据2
	var htms = ''; //前5条显示的数据
	var htm2 = '';//后5条显示的数据
	
	var num2 = data[1].list2;  //数据总数
	var numshow2 = (data[1].list2>5) ? 5: data[1].list2;  //开始显示的数据个数
	var numde2 = (data[1].list2>5) ? data[1].list2-5: 0;  //剩余不显示的数据个数
	var start2 = false; //数据超过5的状态 
	if(data[1].list2>5){
		start = true;
		$('.Business-list2 .show-num').show();
	}else{
		$('.Business-list2 .show-num').hide();
	}
	console.log(numshow2)
	for(var i=0; i<numshow2;i++){
		htms+=html;
	}
	
	for(var i=0; i<numde2;i++){
		htm2+=html;
	}
	
	//开始显示数据  list2
	$('.Business-list2 .one').html(htms);
	//渲染超出5个的数据
	($('.Business-list2 .stwo').html(htm2)).appendTo($('.Business-list2 .one'));
	//显示还剩多少个
	$('.Business-list2 .show-num .num').html(numde2 + '个');
	//判断是否显示剩余按钮
	if(start2){
		$('.Business-list2 .show-num').show();
	}
//	console.log(start2)
	
//	
//	console.log($('.one').html())
//	console.log(btnhtml);
	
	//点击显示完全
	$('.Business-list1 .show-num').on('click',function(){
		if($('.Business-list1 .stwo').css('display')=='none'){
			$('.Business-list1 .stwo').slideDown(400)
			$(this).html('收起')
		}else{
			$('.Business-list1 .stwo').slideUp(200);
			$(this).html(btnhtml);
			$(this).children('span.num').html(numde +'个')
		}
	})
	$('.Business-list2 .show-num').on('click',function(){
		if($('.Business-list2 .stwo').css('display')=='none'){
			$('.Business-list2 .stwo').slideDown(400)
			$(this).html('收起')
		}else{
			$('.Business-list2 .stwo').slideUp(200);
			$(this).html(btnhtml);
			$(this).children('span.num').html(numde2 + '个')
		}
	})
})

//分页{}
$(function(){
	$('.paging a').on('click',function(){
		$(this).addClass('acitve').siblings('a').removeClass('acitve');
		return false;
	})
	//下一页
	$('.paging span').on('click',function(){
		//获取有active的a标签下标  再加1 
		var index = $('.paging a.acitve').index();
		var len = $('.paging a').length;//页总数
		var indexs = index+1
		//然后显示下一页
		if( indexs >len - 1){//判断是否是最后一页了
			return false;
		}else{
			$('.paging a').eq(indexs).addClass('acitve').siblings('a').removeClass('acitve');
		}
//		console.log(index)
	})
})
