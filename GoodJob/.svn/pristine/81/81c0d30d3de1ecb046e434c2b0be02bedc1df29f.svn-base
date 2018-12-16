//指向分享
//with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion=' + ~(-new Date() / 36e5)];
//window._bd_share_config = {
//		common : {
//			//bdText : document.title,	
//			bdDesc : $(".Intros dd:first p:first").text(),	
//			bdUrl : location.href,
//			bdPic : 'http://i5.qhimg.com/dr/200__/t01ab315289f5dfbcaa.jpg;http://i6.qhimg.com/dr/200__/t018e48dc37ea481c32.gif'
//		},
//		share : {}
//	}

with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];

var SHARE={
	open:function(){
		clearTimeout(this.timer);
		this.timer=0;
		$(this).addClass("share-on");
	},
	close:function(){
		if(!this.timer)
		{
			var obj=$(this);
			this.timer=setTimeout(function(){
				obj.removeClass("share-on");
			},100);
		}
	},
	init:function(){
		this.timer=0;
		var share=$(this),
			shares=share.find("cite");
		share.add(shares).mouseenter(function(){
			var oDOM=this;
			if(this.tagName.toLowerCase()=='cite')
			oDOM=$(this).closest(".BaiduShare").get(0);
			SHARE.open.call(oDOM);
		}).mouseleave(function(){
			var oDOM=this;
			if(this.tagName.toLowerCase()=='cite')
			oDOM=$(this).closest(".BaiduShare").get(0);
			SHARE.close.call(oDOM);
		});
	}
};
$(function(){
	$(".BAIDUSHARE").map(function(){
		SHARE.init.call(this);
	});
});
