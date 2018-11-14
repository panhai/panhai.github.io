;(function(global,$){

	/**
	*  单例模式
	*  @param autoPlay 为真，创建分享层后立即显示
	*  @return 返回一个创建显示分享层的函数，第一次调用，autoPlay为真创建并显示，后续调用只显示
	*/
	function createShareCover(){

		var shareCover = null;

		return function(){
			return function( autoPlay ){

				if( shareCover == null ){
					shareCover =  $('<div class="share-cover mask-wrap animated"></div>');
					shareCover.addClass('fadeIn');

					$(document.body).append(shareCover);

					if( autoPlay ) shareCover.show();

					shareCover.click(function(){
						var self = $(this);
						$(this).removeClass('fadeIn').addClass('fadeOut');
						// 延迟400毫秒,等动画完成再隐藏
						setTimeout(function(){
							self.hide();
						},400);
					});
				}else{
					shareCover.removeClass('fadeOut').addClass('fadeIn').show();
				}

			}
		}
	}

	/*赚取现金，助学券邀请页面分享弹窗*/
	function bindShareEvent(){
		var wrap = $('.codeWin-wrap');

		$('.erweima-btn,.icon-erweima').click(function(event){
			wrap.fadeIn(300);
		});

		$('.close').click(function(){
			//wrap.removeClass('fadeIn').addClass('fadeOut');
			setTimeout(function(){
				wrap.fadeOut(300);
			},300);
		});

		$('.next-btn').click(function(){
			$('.share-foot-wrap').fadeIn(300);
		});
		$('.qq-btn, .weixin-btn, .shareCover').click(function(){
			(createShareCover())()(1);
		});


		var shareWrap = $('.share-foot-wrap'),
			shareBox = shareWrap.find('.share-foot-box');

		$('.share-foot-wrap .close').click(function(){
			//shareBox.removeClass('slideInUp').addClass('slideOutDown');
			setTimeout(function(){
				shareWrap.fadeOut(300);
			//	shareBox.removeClass('slideOutDown');
			},300)
		})

	}

	/**
	* 下拉加载
	*  @param  wraperCls 为加在列表的父元素
	*		   list 	 为加载列表元素
	*		   callback  是滚到条到底回调函数
	*
	**/
	function dropDownLoading (wraperCls,list,callback){
		var args = arguments;

        function _l(event){
            event.preventDefault();

        	var bottom = $('.not-more'),
        	    docHeight = $(document).height(),
                scrollTop = $(document).scrollTop(),
            	windowHeight =  $(window).height();

            if( docHeight - windowHeight <= scrollTop ){
            	callback.call(this,args);
            }

            return false;
        }

        $(document).on('scroll' ,_l);

	}

	//写入自定义确认窗
	(function(){
		var strVar = "";
			strVar += "<table class=\"FullScreenPlugin black5 mask-wrap\"><tr><td>";
			strVar += "    <div class=\"CONFIRM\">";
			strVar += "    <span class=\"close\"></span>";
			strVar += "        <h6>拒绝面试<\/h6>";
			strVar += "        <div><p>一旦拒绝，本条简历反馈将移除，确定吗？<\/p><\/div>";
			strVar += "        <span class=\"clear\"><a class=\"confirm\">好的，删吧<\/a><a class=\"cancel\">再等等<\/a><\/span>";
			strVar += "    <\/div>";
			strVar += "<\/td><\/tr><\/table>";
			strVar += "";
		/*
		oDOM，被点击激活确认窗的一个DOM对象
		setOptions集合中可使用的配置键名有
			topic，字符串，窗体标题，默认为“请您确认”
			content，字符串，HTML内容，默认与topic一样
			confirm，字符串，确认字样，默认为“确认”
			cancel，字符串，取消字样，默认为“取消”
			timer，毫秒整数，默认为0不自动关闭，否则经过毫秒数之后将自动关闭
			onconfirm，函数，点击确认事件，默认为空
			oncancel，函数，点击取消事件，默认为空
				 onconfirm及oncancel的参数，第一为custom即窗体的JQ对象，第二为datas数据集合
				 也就是在两个回调中，使用this可以控制窗体的JQ对象
			datas，逗号连接字符串序列，需要从oJQ上读取的data集合名
		*/
		var custom=$(strVar);
		custom.appendTo("body");
		window.CONFIRM=function(oDOM,setOptions){
			var datas={};
			if(!$.isPlainObject(setOptions)) setOptions={};
			if(oDOM && setOptions.datas)
			{
				var keys=setOptions.datas;
				!$.isArray(keys) && (keys=keys.split(','));
				for(var n in keys)
				{
					var key=keys[n];
					datas[key]=$(oDOM).data(key);
				}
			}
			var topic=setOptions.topic || '请您确认';
			custom.find("h6").text(topic)
				.siblings("div").html(setOptions.content || topic)
				.siblings("span")
					.find(".confirm").text(setOptions.confirm || '确认')
					.siblings(".cancel").text(setOptions.cancel || '取消');
			$.isFunction(setOptions.onconfirm) && custom.find(".confirm").unbind('click').one('click',function(){
				setOptions.onconfirm.call(custom,datas);
			});
			$.isFunction(setOptions.oncancel) && custom.find(".cancel").unbind('click').one('click',function(){
				if($.isFunction(setOptions.oncancel))
				setOptions.oncancel.call(custom,datas);
				else custom.fadeOut();
			});
			custom.find('.close').unbind('click').one('click',function(){
				if($.isFunction(setOptions.onclose)){
					setOptions.onclose.call(custom,datas);
				}
				custom.fadeOut();
			});
			setOptions.timer>0 && setTimeout(function(){
				custom.fadeOut();
			},setOptions.timer);
			custom.fadeIn();


			this.close=function(){
				if($.isFunction(setOptions.onclose)){
					setOptions.onclose.call(custom,datas);
				}
				custom.fadeOut();
			}
			return this;
		}

		var strCancel = "";
			strCancel += "<table class=\"FullScreenPlugin black5 mask-wrap\"><tr><td>";
			strCancel += "    <div class=\"CONFIRM\">";
			strCancel += "        <h6>拒绝面试<\/h6>";
			strCancel += "        <div><p>一旦拒绝，本条简历反馈将移除，确定吗？<\/p><\/div>";
			strCancel += "        <span class=\"clear\"><a class=\"ok\">再等等<\/a><\/span>";
			strCancel += "    <\/div>";
			strCancel += "<\/td><\/tr><\/table>";
			strCancel += "";
		var html=$(strCancel);
		html.appendTo("body");
		window.ALERT=function(oDOM,setOptions){
			var datas={};
			if(!$.isPlainObject(setOptions)) setOptions={};
			if(oDOM && setOptions.datas)
			{
				var keys=setOptions.datas;
				!$.isArray(keys) && (keys=keys.split(','));
				for(var n in keys)
				{
					var key=keys[n];
					datas[key]=$(oDOM).data(key);
				}
			}
			var topic=setOptions.topic || '请您确认';
			html.find("h6").text(topic)
				.siblings("div").html(setOptions.content || topic)
				.siblings("span")
					.find(".ok").text(setOptions.ok || '确认');

			if ($.isFunction(setOptions.onclose)) {
			    html.find(".ok").unbind('click').one('click', function () {
			        setOptions.onclose.call(html, datas);
			    });
			} else {
			    html.find(".ok").unbind('click').one('click', function () {
			        html.fadeOut();
			    });
			}

			setOptions.timer>0 && setTimeout(function(){
				html.fadeOut();
			},setOptions.timer);
			html.fadeIn();
			return this;
		}
	})();

	global.createShareCover = createShareCover();
	global.bindShareEvent = bindShareEvent;
	global.dropDownLoading = dropDownLoading
})(window,jQuery);



