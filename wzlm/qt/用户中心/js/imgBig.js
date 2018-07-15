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
	$("img").magnify(options)
	$('.clickImg').click(function(){
		$('.bigImg').click();
		
	})
})