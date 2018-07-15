//单选效果实现 (复制html)
$(function() {
	$('.hp').click(function() {
//		$(this).children('.radioimg').html($('.radioimg .img1'))
//		$(this).children('.radioimg').siblings('.radioimg').html('');
		$(this).find('img').show();
		$(this).siblings('.hp').find('img').hide();
		
	})

})

//单选浮动广告类型
$(function() {
	//点击添加图，其他兄弟没有图
	$('.g').click(function() {
		$(this).children('.r').html($('.r img'));
		$(this).children('.r').siblings('.r').html('');
	})

})
//单选辅助功能类型
$(function() {
	$('.ff').click(function() {
		$(this).children('.rt').html($('.rt img'));
		$(this).children('.rt').siblings('.rt').html('');
	})
})


//图片放大插件
$(function() {
	options = {
		draggable: true,
		resizable: true,
		movable: true,
		keyboard: true,
		title: true,
		modalWidth: 540, //图片框宽度
		modalHeight: 420,
		fixedContent: true,
		fixedModalSize: false,
		initMaximized: false,
		gapThreshold: 0.02,
		ratioThreshold: 0.1,
		minRatio: 0.1,
		maxRatio: 16,
		headToolbar: [
			'maximize',
			'close'
		],
		footToolbar: [
			'zoomIn',
			'zoomOut',
			'prev',
			'fullscreen',
			'next',
			'actualSize',
			'rotateRight'
		],
		icons: {
			maximize: 'fa fa-window-maximize',
			close: 'fa fa-close',
			zoomIn: 'fa fa-search-plus',
			zoomOut: 'fa fa-search-minus',
			prev: 'fa fa-arrow-left',
			next: 'fa fa-arrow-right',
			fullscreen: 'fa fa-photo',
			actualSize: 'fa fa-arrows-alt',
			rotateLeft: 'fa fa-rotate-left',
			rotateRight: 'fa fa-rotate-right'
		}
	}
	$(".bigImg").magnify(options);
})
$(function(){
	$('.clickImg').click(function(){
		$('.zhanshi img').click();
		return false;
	})
})
