
function change () {
	var designWidth = 750, rem2px = 100;
	if(window.innerWidth >= 750){
		document.documentElement.style.fontSize = 100 + 'px';
	}else {
		document.documentElement.style.fontSize = (window.innerWidth / designWidth) * rem2px + 'px';
	}
};

/*页面刷新时执行函数*/
change ();

/*屏幕尺寸改变时执行*/
window.onresize = function () {
	change ();
}
