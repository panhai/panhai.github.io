window.onload = function (){
	/*
	 * 1头部删删除
	 * 2轮播图
	 * 3 京东计时器
	 * 4:滚动到秒杀京东位置时显示隐藏的搜索蓝
	 * 
	 */
	var oHead = document.getElementById('h_top');
	var oDel = oHead.getElementsByTagName('img')[0];
	
	var oCarBox = document.getElementById('carousel_top');
	var oImg_Ul = document.getElementById('img_box');
	var oBtn_Ul = document.getElementById('btn_box');
	var oPrev = document.getElementById('prve');
	var oNext = document.getElementById('next');
	var ali1 = oImg_Ul.getElementsByTagName('li');
	var ali2 = oBtn_Ul.getElementsByTagName('li');
	
	var oKill = document.getElementById('seckill_right');
	var aStime = document.getElementsByClassName('time');
//	console.log(aStime)
	var timer = 0;
	var nNow = 0;
	var timer2 = 0;
	var timer3 = 0;//京东定时器
	
	var oHide = document.getElementById('hideh');
	
	var oKill_Jd = document.getElementById("kill_jingdong");
	
	//点击删除头部
	oDel.onclick = function () {
		oHead.style.display = 'none';
	}
	
	//移入大盒子停止定时器
	oCarBox.onmouseenter = function () {
		clearInterval(timer);
		oPrev.style.display = "block";
		oNext.style.display = "block";
		
	}
	oCarBox.onmouseleave = function () {
		timer = setInterval(function(){
			show1(1);
		},1000)
		oPrev.style.display = "none";
		oNext.style.display = "none";
	}
	//远点切换
	for(var i=0; i<ali2.length; i++) {
		ali2[i].index = i;
		ali2[i].onclick = function () {
			nNow = this.index;
			fn();
		}
	}
	//左右按钮切换
	oPrev.onclick = function () {
		clearTimeout(timer2);
		timer2 = setTimeout(function(){
			show1(-1);
		},200)
	}
	oNext.onclick = function () {
		clearTimeout(timer2);
		timer2 = setTimeout(function(){
			show1(1);
		},200)
	}
	timer = setInterval(function(){
		show1(1);
	},2000)
	
	timer3 = setInterval(function(){
		var date = new Date();
		var h = Mytime(date.getHours());
		var f = Mytime(date.getMinutes());
		var m = Mytime(date.getSeconds());
	
		aStime[0].innerHTML = h;
		aStime[1].innerHTML = f;
		aStime[2].innerHTML = m;
		
	},1000)
	
	
	function show1 (n) {
		nNow+=n;
		if(n==1) {
			if(nNow > ali1.length-1) nNow = 0;
			fn ();
		}else if(n==-1) {
			if(nNow < 0) nNow = ali1.length-1;
			fn ();
		}
		
	}
	
	function fn () {
		for(var i=0; i<ali1.length; i++) {
			ali1[i].style.zIndex = 0;
			ali2[i].className = '';
			ali1[i].style.opacity = '.5';
		}
		ali1[nNow].style.zIndex = 1;
		ali2[nNow].className = 'active';
		ali1[nNow].style.opacity = '.9';
	}
	
	//不够十位数加上0
	function Mytime (t) {
		if(t<10){
			return "0" + t;
		}else{
			return ""+t;
		}
	}
	
	
	//4
	window.onscroll = function (ev) {
		var oE = ev || event;
		var scrollTop = document.documentElement.scrollTop||document.body.scrollTop;
		
		var killScrolltop = $( oKill_Jd).offset().top;
		//大于killScrolltop到顶部的距离时显示隐藏的搜索框
		if(scrollTop > killScrolltop) {
			oHide.style.top = "0px";
		}else{
			oHide.style.top = "-60px";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
}
