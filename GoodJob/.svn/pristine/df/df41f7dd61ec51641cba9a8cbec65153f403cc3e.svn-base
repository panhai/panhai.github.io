// 中心静止层
function CenterDiv(embed)
{
	var divs=$(".CenterDiv");
	/////////////////////////////////
	if(!embed)//静止化效果
		divs.map(function(ind,ele){
			//IE6下的静止化需要使用margin来定位，而不是常规的
			var t=($(window).width() - $(ele).width())/2+'px',
				l=($(window).height() - $(ele).height())/2+'px'
			if(isIE6())$(ele).css({
				marginLeft:t
				,marginTop:l
			});
			else $(ele).css({
				left:t
				,top:l
			});
			ele.open=function(){
				if(alphabg) alphabg.open(function(){
					$(ele).fadeIn();
					alphabg.focus(ele);
				});
				else $(ele).fadeIn();
			}
			ele.close=function(){
				$(ele).fadeOut('','',function(){
					if(alphabg)alphabg.close();
				});
			}
		});
	//////////////////////////////////
	else//仿嵌入的效果
		divs.map(function(ind,ele){
			$(ele).css('position','relative');
			ele.open=function(target){
				//var offset=target ? $(target).offset() : {left:0,top:0}
				$(this)/*.css({
					left:offset.left+'px',
					top:(offset.top+$(target).height())+'px'
				})*/.show().closest(".form-line").show();
			}
			ele.close=function(){
				$(this).hide().closest(".form-line").hide();
			}
		});
	//////////////////////////////////
	/*关闭按钮*/
	divs.find("dt q").click(function(){
		$(this).closest('.CenterDiv').get(0).close();
	});
	/*下拉菜单*/
	divs.find(".CenterSelect").find("dt").click(function(){
		var par=$(this).closest(".CenterSelect");
		par.addClass("on")
			.closest(".CenterDiv").find(".CenterSelect").not(par).removeClass("on");
	})
	.end().mouseleave(function(){
		$(this).removeClass("on");
	})
	.find("dd").delegate("a",'click',function(){
		var par=$(this).closest(".CenterSelect");
		var i=par.find("input:hidden");
		if(i.size())i.val($(this).attr("alt"));
		var str=par.IN(".CenterTopic") ?
				('<b>'+ $(this).html() + '</b><i></i>')
				:('<b>'+ $(this).html() + '</b><s><i></i></s>');
		par.find("dt").html(str);
		par.removeClass("on");
	}).find("a").attr("href","javascript:void(0)");
	/*标签页*/
	divs.find(".CenterLabels").map(function(ind,ele){
		var theContent=$(ele).closest(".CenterDiv").find(ele.title);
		$(ele).children().click(function(){
			var ind=$(this).index();
			$(this).addClass("cur").siblings().removeClass("cur");
			theContent.children().eq(ind).show().siblings().hide();
		}).eq(0).click();
	});
	/*相关下拉框*/
	divs.find(".CenterDrop").click(function(){
		divs.find(".CenterDropDown").slideToggle();
	});
	divs.find(".CenterDropDown .CenterDropUp").click(function(){
		$(this).closest(".CenterDropDown").slideUp();
	});
}