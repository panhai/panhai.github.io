// 全站通用JS
//判断IE版本
function isIE6(){return isIEX(6);}
function isIE7(){return isIEX(7);}
function isIE8(){return isIEX(8);}
function isIE9(){return isIEX(9);}
function isIEX(x){return navigator.appVersion.indexOf("MSIE "+x+".0")>0;}
function isLow(){return isIE6() || isIE7() || isIE8();}
var needPlaceholder=isLow() || isIE9();
function isIE(){return navigator.appVersion.indexOf("MSIE")>0;}
/*常用数字判别式*/

/*
初始化所有自定义下拉列表的基本行为
所有含类.SELECT的DL元素
	可以附加data-active='click'|'mouseenter'，改变下拉列表的激活行为，默认为click
	可以附加data-delay='毫秒数'，改变下拉列表的收回延迟，默认为300
	可以附加data-choices='正整数'，改变下拉列表的最大选项，默认为1，设置成0的话则无限制
		多选模式，要指定
		.SELECT-CHOICES，选项容器的类名，此容器内的所有a才会被当作是可选选项
		.SELECT-COLLECTOR，采集容器的类名，此容器内的所有a被当成已选项
	可以附加data-placeholder='字符串'，改变下拉列表无选项时的提示，相当于placeholder属性，默认为'请选择'
	可以附加data-leave='close'|'egnore'，改变下拉列表失去鼠标指向时的行为，默认为'close'
	可以附加data-anchor='save'，保留链接地址，默认会将a元素的href设置成void0
	可以附加data-empty='init'|'egnore'，当初始的隐藏域值为空时，也会初始化列表，为egnore时会留空列表头
	可以附加data-type='id'|'string'，列表的数据类型，默认是id，还可以是字符串类型的值
	可以附加data-autofill='intFrom,intTo,intStep[,fillBit]'，数字型列表，可以自动填充选项，直接生成a标签放入.SELECT-CHOICES中（或直接放入dd中），第四参如果是正整数则用来限制左补零补位
	可以附加data-child='下级的JQ选择器字符串'，当本级被点击时，可以自动展开下级下拉列表
	可以附加data-options='外露的选项数量'，当只使用一列时使用，默认为0不限制，超出选项数量显示滚动条
	可以附加data-trigger='一个选择器'，在可输入匹配列表中，如果列表匹配项未展开时，触发本选择器对应元素的click事件
DL中要包含一个input[type=hidden]元素，来存放选项的ID或ID列表，如果不保存则不需要
DT元素中可以包含
	span，默认提示，相当于placeholder属性，会显示成浅一些的字
	b，选项，被选择的选项的显示内容，与input[type=hidden]一一对应
	i，箭头，装饰用
	input:text，输入框，有些下拉列表是带有关键字搜索的功能
DD元素中可以包含
	a，每一个a都是一个选项，无论是否复选，a标签上必须附加上data-id=""
	当a被选中时，会附加一个类.checked，来标识选中的项目
	其它标签可用作特殊格式的布局元素，但不可作为选项
*/
/*
所有的SELECT的通用方法，使用命名空间，以防污染
里边的所有this都要代表DL.SELECT的DOM对象
	.text(str)，设置列表头的文字内容
	.id(id)，设置隐藏域的id
	.reset()，重置下拉列表为默认提示
	.open()，下拉列表展开
	.close(bAtonce)，下拉列表关闭，bAtonce=true时立即关闭，忽略延时
	.void0()，将所有的选项的href都置为void(0)
	.value()，以隐藏域的值来初始化自身（dt内容及dd中被选项）
	.init()，初始化列表
在dt的input:text上
	可以附加data-list='arrow'，给input加键盘监听，监听上下箭头及回车键
在dd内对应的选项容器元素上
	附加data-list='datas'，将键盘监听指定到此列表的选项上
	上下箭头用于调节选中项目的位置，回车则等于点击选项
*/
var SELECT={
	text:function(str,oOptions){
		var oJQdt=$(this).children('dt'),
			oJQinput=oJQdt.find("input:text"),
			oJQspan=oJQdt.find("span"),
			oJQb=oJQdt.find("b");
		if(!$.isPlainObject(oOptions)) oOptions={};
		if(!('focus' in oOptions)) oOptions.focus=false;

		if(oJQinput.size())
		{//如果是输入框，则值置于input的value属性上
		    if (oOptions.focus) oJQinput.focus();//提前执行，以便失去焦点可以触发onchange事件
			var oldstr=oJQinput.val();
			if(oldstr!=str) oJQinput.val(str).change();
			if(str)oJQinput.attr('title',str);
			else oJQinput.removeAttr('title');
			if(!needPlaceholder)INPUT.hold.call(oJQinput.get(0),str=='');
		}
		else if(oJQspan.size())
		{//如果有span，则将span元素转换成b元素，并加上内容
			var classes=oJQspan.get(0).className;
			oJQspan.replaceWith('<b class="'+ classes +'" title="'+ str +'">'+ str +'</b>');
		}
		else if(oJQb.size())
		{//如果有b，则将b中内容直接替换
			oJQb.text(str).attr('title',str);
		}
	},
	id:function(id){
		var input=$(this).find("input[type=hidden]");
		if(!input.size())
		{
			return;
		}
		var oldid=input.val();
		id=id+"";
		if (oldid !== id) {
		    input.val(id);
		    if (typeof (JBody) != "undefined") JBody.fireEvent(input.get(0), "change"); //非JQ的绑定，用于输入格式验证等
            else input.change();
		}
	},
	reset:function(bChange,bSaveValue){
		var placeholder=$(this).data('placeholder'),
			oJQhidden=$(this).find("input[type=hidden]"),
			oJQdt=$(this).children('dt'),
			oJQinput=oJQdt.find("input:text"),
			oJQspan=oJQdt.find("span"),
			oJQb=oJQdt.find("b");
		oJQhidden.val('');
		if(oJQinput.size())
		{//如果有输入框，则置空输入框内容，低版本再触发输入框的reset()方法
			if(!bSaveValue) oJQinput.val('').blur();
			INPUT.hold.call(oJQinput.get(0),oJQinput.val()=='');
		}
		else if(oJQspan.size()) oJQspan.text(placeholder);
		else if(oJQb.size())
		{//有b则将其替换成span，内容放置默认提示
			var classes=oJQb.get(0).className;
			oJQb.replaceWith('<span class="'+ classes +'">'+ placeholder +'</span>');
		}
		if ($(this).find("caption a q").size()) $(this).find("caption a q").click();
		else $("dd a", this).removeClass("checked");
		//强制触发CHANGE事件，通过点击选项而触发的重置才会使用
		if(bChange) oJQhidden.change();
	},
	timerOff:function(){
		clearTimeout(this.timer);
		this.timer=0;
	},
	open:function(){
		SELECT.timerOff.call(this);
		//此处会引发注册页帐号输入自动清空，只能注释掉
		//SELECT.init.call(this);
		$(this).addClass("SELECT-on").find("dd").each(function() {
            $(this)[$(this).children().length?'removeClass':'addClass']('empty');
        });
		$(".SELECT").not(this).map(function(){
			SELECT.close.call(this,true);
		});
	},
	close:function(bAtonce){
		var oJQselect=$(this);
		if(!this.timer && !bAtonce)
		{//自由关闭，需要计时器
			this.timer=setTimeout(function(){
				oJQselect.removeClass("SELECT-on");
			},$(this).data('delay'));
		}
		else if(bAtonce)
		{//立即关闭，不通过计时器
			SELECT.timerOff.call(this);
			$(this).removeClass("SELECT-on");
		}
	},
	void0:function(){
		$(this).find("dd a").attr({
			href:'javascript:void(0)',
			title:function(){return this.title ? this.title : $(this).text();}
		});
	},
	//以input的值来初始化选项状态，点击取消也会使用本方法
	value: function () {
		var oInputHidden=$(this).find("input[type=hidden]");
		//如果找不到隐藏域，或许dt中有输入框，则不需要初始化
		if(!oInputHidden.size())return;
		var sIds=oInputHidden.val(),
			aIds=sIds.split(','),
			oJQcollector=$(this).find(".SELECT-COLLECTOR"),
			oJQchoicesList=$(this).find(".SELECT-CHOICES");
		if(!oJQchoicesList.size()) oJQchoicesList=$(this).children("dd");
		var selector=[],items=[];
		for(var n=0;n<aIds.length;n++) selector.push('a[data-id="'+ aIds[n] +'"]');
		var oItems=oJQchoicesList.find(selector.join(',')),
			sTexts=[],
			sChoices=oItems.map(function(){
				return '<a href="javascript:void(0)" data-id="'+ $(this).data("id") +'"><span>'+ $(this).text() +'</span><q></q></a>';
			}).get().join('');
		oItems.each(function(){
			$(this).addClass("checked");
			var text=$(this).text();
			if($.inArray(text,sTexts)==-1)sTexts.push(text);
		});

		sTexts=sTexts.join(',');
		oJQchoicesList.find("a").not(oItems).removeClass("checked");
		if(sIds) SELECT.text.call(this,sTexts);
		else SELECT.reset.call(this);
		if(oJQcollector.size()) oJQcollector.find("a").remove().end().find(":button:first").before(sChoices);
	},
	next:function(){
		var nextSelect=$(this).data("child");
		if(nextSelect) $(nextSelect).find("dt").click();
	},
	init:function(){
		var oJQselect=$(this);
		if(!$(this).data('active')) $(this).data('active','click');
		if(!$(this).data('delay')) $(this).data('delay',300);
		if($(this).data('choices')===undefined) $(this).data('choices',1);
		if(!$(this).data('placeholder')) $(this).data('placeholder','请选择');
		if(!$(this).data('leave')) $(this).data('leave','close');
		if(!$(this).data('empty')) $(this).data('empty','init');
		if(!$(this).data('type')) $(this).data('type','id');
		if(!$(this).data('inited')) $(this).data('inited',false);
		if(!$(this).data('options')) $(this).data('options',0);
		var inited=$(this).data('inited');

		this.timer=0;
		if(!inited)
		{
			//离开菜单则隐藏
			$(this).mouseleave(function(){
				var leave=$(this).data('leave');
				if(leave!='egnore') SELECT.close.call(this);
			})
			//迅速回到菜单则不隐藏
			.mouseenter(function(){
				SELECT.timerOff.call(this);
			})
			//点击表头则显示
			.find("dt").on($(this).data('active'),function(event){
				var DL=$(this).closest(".SELECT").get(0),
					action='open';
				switch(event.target.tagName.toLowerCase())
				{
					case 'span': case 'b':break;
					case 'i':
						if($(DL).hasClass("SELECT-on")) action='close';
						break;
					default:;
				}
				SELECT[action].call(DL,true);
			})
			//列表头中的输入框的事件
			//.find("input").on('focus keyup keydown keypress',function(){
			.find("input").on('keyup keydown keypress',function(event){
				if(event.which!=13)
				SELECT.open.call($(this).closest(".SELECT").get(0));
			})
			.on('blur',function(){
				SELECT.close.call($(this).closest(".SELECT").get(0));
			});
			//最大外露选项设置
			if($(this).data('options'))
			{
				var maxh=$(this).data('options') * $(this).find("dd a").height()
				$(this).find("dd").css({
					maxHeight:maxh,
					overflow:'auto',
					height: isIE6() ? maxh:'auto'
				});
			}
			//如果dl.SELECT的data-anchor='save'则所有链接保留，否则才按选项处理
			if($(this).data('anchor')!='save')
			{
				SELECT.void0.call(this);
				//先找指定的选项列表容器，如果没有才找直接子元素dd
				var oJQchoicesList=$(this).find(".SELECT-CHOICES"),
					oJQcollector=$(this).find(".SELECT-COLLECTOR"),
					piChoices=$(this).data("choices");
				if(!oJQchoicesList.size()) oJQchoicesList=$(this).children("dd");
				//点击选项，可能是未来元素
				oJQchoicesList.delegate('a','click',function(){
					var oJQselect=$(this).closest(".SELECT"),
						oJQcollector=oJQselect.find(".SELECT-COLLECTOR"),
						oDOMselect=oJQselect.get(0),
						sText=$(this).text(),
						piID=$(this).data('id'),
						piChoices=oJQselect.data('choices');
					if(piChoices==1)
					{//单选，将自己设置为选中状态，其它所有选项取消选中

						$(this).addClass('checked');
						var par;
						(par=$(this).closest("tbody")).length && par.closest(".SELECT").length && (par.find("a").not(this).removeClass("checked"),true)
						|| $(this).siblings("a").removeClass("checked");
						if(piID!=='')
						{//有ID直接保存ID及字符串
							SELECT.text.call(oDOMselect,sText,{focus:true});
							SELECT.id.call(oDOMselect,piID);
						}
						else if($(oJQselect).data("type")=='id')
						{//无ID，如果保存的是ID的话，可能是“不限”选项
							SELECT.reset.call(oDOMselect,true);
						}
						else
						{//无ID，如果保存的是字符串的话，直接将字符串写入
							SELECT.text.call(oDOMselect,sText,{focus:true});
						}
						SELECT.close.call(oDOMselect,true);
						SELECT.next.call(oDOMselect);
					}
					else
					{//多选
						var oCollectedItem=oJQcollector.find("a[data-id='"+ piID +"']");
						if(oCollectedItem.size())
						{//已经存在，则删除
							oCollectedItem.remove();
							$(this).removeClass("checked");
						}
						else
						{//不存在
							var oItems=oJQcollector.find("a");
							if(oItems.size()>=piChoices && piChoices)
							{//数量满，则提示
								alert("最多选择"+ piChoices +"项");
							}
							else
							{//数量未满，则加入
								oJQcollector.find(":button:first").before('<a href="javascript:void(0)" data-id="'+ piID +'"><span>'+ sText +'</span><q></q></a>');
								$(this).addClass("checked");
							}
						}
					}
				});
				//点击“不限”按钮
				oJQcollector.find(".nolimit").click(function(){
					var oDOMselect=$(this).closest(".SELECT").get(0);
					SELECT.close.call(oDOMselect,true);
					SELECT.reset.call(oDOMselect);
				});
				oJQcollector.find(".close").click(function(){
					SELECT.close.call($(this).closest(".SELECT").get(0),true);
				});
				//多选则给采集器中选项绑定事件，还有按钮事件
				if(piChoices!=1)
				{
					oJQcollector.delegate('a q','click',function(){
						var oJQa=$(this).parent(),
							piID=oJQa.data("id");
						oJQa.remove();
						oJQchoicesList.find('a[data-id="'+ piID +'"]').removeClass("checked");
					})
					//点击确定
					.find(".submit").click(function(){
						var oItems=$(this).siblings("a"),
							oDOMselect=$(this).closest(".SELECT").get(0),
							sTexts=oItems.map(function(){return $(this).text();}).get().join(','),
							sIds=oItems.map(function(){return $(this).data("id");}).get().join(',')
						;
						//有选择则放值，无选择则置空
						if(sIds) SELECT.text.call(oDOMselect,sTexts);
						else SELECT.reset.call(oDOMselect,true);
						SELECT.id.call(oDOMselect,sIds);
						SELECT.close.call(oDOMselect,true);
						SELECT.next.call(oDOMselect);
					})
					//点击取消
					.siblings(".reset")/*.remove().click(function(){
						var oDOMselect=$(this).closest(".SELECT").get(0);
						SELECT.close.call(oDOMselect,true);
						SELECT.value.call(oDOMselect);
					})*/
					;
				}
				//数字型列表，自动填充选项
				var fillOption;
				if((fillOption=$(this).data("autofill")) && /^[\+\-]?[\d]+\,[\+\-]?[\d]+\,[\+\-]?[\d]+(\,[\d]+)?$/.test(fillOption))
				{
					var arr=fillOption.split(','),
						from=parseInt(arr[0]),
						to=parseInt(arr[1]),
						step=parseInt(arr[2]),
						fillBit=arr.length==4 ? parseInt(arr[3]) : 0,
						str=[];
					if(step && (to-from)/step>0) //从from到to的方向，要与step一致，不然会死循环
					for(var n=from;n<=to;n+=step)
					{
						var id=n;
						if(fillBit>1 && id.toString().length<fillBit)
						{
							for(var x=id.toString().length;x<fillBit;x++)
								id='0'+id
						}
						str.push('<a href="javascript:void(0)" data-id="',id,'">',id,'</a>');
					}
					oJQchoicesList.html(str.join(''));
				}
			}
		}

		//不指定忽略的，且含有隐藏域的，都需要初始化显示值
		if($(this).data("empty")!='egnore' && $(this).find("input[type=hidden]").size())
		{
			var value=$(this).find("input[type=hidden]").val();
			if(value!=='')
			{
				SELECT.value.call(this);
			}
			else
			{
				SELECT.reset.call(this,false,true);
			}
		}
		var input=$(this).find("dt input");

		//给没有placeholder属性，且不使用图片做占位符的输入框，添加下拉列表指定的占位字符串
		input.not("[data-holdway='image'],[placeholder]").attr('placeholder',$(this).data('placeholder'));

		//键盘监听，上下箭头与回车
		if(input.size() && input.data("list")=='arrow' && !inited)
		{
			input.keydown(function(event){
				var key=event.which;
				if($.inArray(key,[40,38,13])>=0)
				{
					var theSelect=$(this).closest('.SELECT'),
						list=theSelect.find("[data-list='datas']"),
						anchors=list.find("a"),count=anchors.size(),
						curA=anchors.filter("a.cur"),curIndex=curA.size() ? curA.index() : -1,
						trigger;
					switch(key)
					{
						case 38://上箭头
							curIndex=curIndex==-1 ? count-1 : (curIndex-1+count)%count;
							anchors.eq(curIndex).addClass('cur').siblings().removeClass('cur');
							break;
						case 40://下箭头
							curIndex=(curIndex+1)%count;
							anchors.eq(curIndex).addClass('cur').siblings().removeClass('cur');
							break;
						case 13://回车
							if(curIndex!=-1) curA.click();
							else if((trigger=theSelect.data('trigger'))) $(trigger).click();
							break;
					}
					return false;
				}
			});
			//鼠标移上去的时候，只有一个反色选项
			$(this).find("[data-list='datas']").delegate('a','mouseenter',function(){
				$(this).addClass("cur").siblings().removeClass("cur");
			}).delegate('a','mouseleave',function(){
				$(this).removeClass("cur");
			});
		}
		$(this).data('inited',true);
	}
};
$(function(){
	$(".SELECT").not("[data-init='false']").map(function(){
		SELECT.init.call(this);
	});
});
/*
所有的input的基本行为，同样使用命名空间来防止污染
方法中的this同样指代input的DOM对象
	.hold()，文本框启用占位符，高端中的placeholder会起作用，但低端的需要使用JS来人为控制，但使用背景图片的话就只能用JS控制
可以附加data-holdway='image'|'text'，使用图片/文本作为占位符（有的时候输入框同时拥有占位符及背景图片）
可以附加data-savevalue='true'，当输入框在SELECT中时，保留输入框中的原有值
*/
var INPUT={
	hold:function(bool){
		var holdway=$(this).data('holdway'),
			placeholder=$(this).data('placeholder');
		if(!holdway)return;
		if(bool)
		{//如果占位的话，有背景则显示背景，有字（低端）则将输入框的值放置成占位字符串
			if(holdway=='image')
			$(this).css('backgroundImage',placeholder);
			else if(needPlaceholder)
			{
				 //if(this.type!='password') $(this).val(placeholder);
				 //else
				 //{
					$(this).val('').data("placeholderDiv").css({
					}).show();
				 //}
			}
		}
		else
		{//取消占位，将背景放空，（低端）将值清空
			if(holdway=='image')
			$(this).css('backgroundImage','none');
			else if(needPlaceholder)
			{
				/*if(this.type=='password')*/ $(this).data("placeholderDiv").hide();
				//else this.value='';
			}
		}
	},
	init:function(){
		//如果拥有placeholder属性，则直接使用它；如果没有则使用背景图片
		var placeholder=$(this).attr('placeholder'),holdway='text';
		if(!placeholder){ placeholder=$(this).css('backgroundImage');holdway='image';}
		if(!placeholder) return true;
		if(!$(this).data('inited')) $(this).data('inited',false);

		$(this).data({
			holdway:holdway,//占位方法，text或image
			placeholder:placeholder//占位内容，图片路径或字符串
		});

		if(!$(this).data('inited'))
		{
			$(this).on('keydown keyup change',function(){
				if($(this).data('holdway')=='image' || needPlaceholder) INPUT.hold.call(this,this.value=='');
			})
			.blur(function(){
				if(this.value=='' && $(this).data('holdway')=='text')
				{
					INPUT.hold.call(this,true);//此句适应低端
				}
				else if($(this).data('holdway')=='image')
				{
					INPUT.hold.call(this,this.value=='');
				}
			})
			.focus(function(){
				//if(needPlaceholder && $(this).data('holdway')=='text' && this.value==$(this).data('placeholder')) this.value='';
			});
			if(needPlaceholder && holdway!='image')
			{
				var parent=$(this).parent().css({
					zIndex:GLOBALZ--
				});
				/*if(parent.get(0).tagName!='TD')*/parent.css({position:'relative'});
				var div=$("<div/>").css({
					fontSize:$(this).css("fontSize"),
					//color:$(this).css("color"),
					position:'absolute',
					//left:$(this).position().left + parseInt($(this).css("borderTopWidth")),
					//top:$(this).position().top + parseInt($(this).css("borderLeftWidth")),
					width:$(this).width(),
					height:$(this).height(),
					lineHeight:$(this).css("lineHeight"),
					paddingLeft:$(this).css("paddingLeft"),
					paddingRight:$(this).css("paddingRight"),
					paddingTop:$(this).css("paddingTop"),
					paddingBottom:$(this).css("paddingBottom"),
					marginLeft:$(this).css("marginLeft"),
					marginTop:$(this).css("marginTop"),
					marginRight:$(this).css("marginRight"),
					marginBottom:$(this).css("marginBottom")
				}).text(placeholder).addClass("PLACEHOLDER")
				.data("password",this).click(function(){
					$(this).data("password").focus();
				}).prependTo(parent);
				$(this).data("placeholderDiv",div.hide());
			}
		}
		//低端及IE9下，放置占位字符串
		if(needPlaceholder && holdway=='text' && !this.value)
		{
			this.value=placeholder;
			$(this).removeAttr('placeholder');
		}

		INPUT.hold.call(this,this.value=='' || needPlaceholder && this.value==placeholder);
		$(this).data('inited',true);
	}
};
var GLOBALZ=99;
$(function(){
	if(typeof(INPUTINIT)=='undefined' || INPUTINIT===true)
	{
		setTimeout(function(){
			$(":text[data-init='true'],:password[data-init='true'],textarea[data-init='true']").map(function(){
				INPUT.init.call(this);
			});
		},100);
	}
	$("input").prop('autocomplete','off');
});
//在IE6下用JS的方法强制实现文字溢出遮挡效果
function TextOverflow(sJQ,num)
{
	$(sJQ).map(function(){
		var text=$(this).text(),fontSize=parseInt($(this).css('fontSize')),
			maxWidth=num*fontSize;
		//if(text.length>num) $(this).text(text.substr(0,num-1)+'...');
		if($(this).width()>maxWidth) $(this).width(maxWidth);
		else $(this).width('auto');
	})
}
/*
普通的单/复选框，可能使用特殊的样式代替
sJQcontainer，是包含了选框组的容器的JQ选择器字符串
所有需要本效果的选框都要被唯一地包裹在label标签中
被选定的项目的label会被附加.checked类
*/
function Boxes(sJQcontainer)
{
	$(sJQcontainer).delegate("label",'click',function(){
		var oJQcontainer=$(this).closest(sJQcontainer);
		if(!$(this).hasClass("checked"))
		{//没选中的就选中
			$(this).addClass("checked")
				.find("input").get(0).checked=true;
			if($(this).has(":radio").size())
			{
				$(this).siblings().removeClass("checked");
			}
		}
		else if($(this).has(":checkbox").size())
		{//选中的话，如果是复选框才需要取消
			$(this).removeClass("checked")
				.find(":checkbox").get(0).checked=false;
		}
		return false;
	})
	.find(":checked").parent().addClass("checked")
	.end().end()
	.find("input:not(:checked)").parent().removeClass("checked");
}
function regSelect(sJQcontainer)
{
   $(sJQcontainer).delegate("label","click", function(){
       var oJQcontainer = $(this).closest(sJQcontainer);
       if(!$(this).hasClass("checker")){
         $(this).addClass("checker").find("input").get(0).checked = true;
         $(this).siblings().removeClass("checker");
       }
   })
   .find(":checked").parent().addClass("checker")
   .end().end()
   .find("input:not(:checked)").parent().removeClass("checker");
}
//带大拇指图标的提示
$(function(){
	var THUMBTIP=$("<div/>").attr('id','ThumbTip').html("好工作指数：<b></b><br><span>（建议投递指数较高的职位）</span>").hide()
		.appendTo("body");
	$("h4 i,.Attribs small").mouseenter(function(){
		if($(this).css('background-image').indexOf('icons/push')==-1) return;
		var off=$(this).offset();
		THUMBTIP.css({
			left: off.left + $(this).outerWidth(),
			top: off.top + $(this).outerHeight()
		}).find("b").text($(this).text())
		.end().show();
	}).mouseleave(function(){
		THUMBTIP.hide();
	});
});

/**
 * 跳转到登录页
 */
function TryLogin() {
    window.location = "/login";
}

/**
 * 管理后台根目录
 */
function adminRootPath() {
    var path = window.location.pathname.toLocaleLowerCase();
    var index = path.indexOf("/admin") + 6;
    return path.substring(0, index);
}


/**
    * Cookies操作类
    */
    function cookies() {
        /*
        * 添加或修改cookie
        */
        this.add = function (name, value, option) {
            var strCookie = name + "=" + escape(value); //设置键/值对
            if (option) {
                //判断是否设置过期时间
                if (option.expireHours) {
                    var date = new Date();
                    date.setTime(date.getTime() + option.expireHours * 3600 * 1000); //N小时后过期
                    strCookie += "; expires=" + date.toGMTString();
                }

                if (option.path) strCookie += "; path=" + option.path;       //设置可访问路径
                else strCookie += "; path=/";
                if (option.domain) strCookie += "; domain=" + option.domain; //设置访问主机
                if (option.secure) strCookie += "; secure";                  //设置安全性
            } else strCookie += "; path=/";
            document.cookie = strCookie;
        };
        /*
        * 获取指定名称的cookie值
        */
        this.select = function (name) {
            var strCookie = document.cookie; //获取整个cookie
            //分析整个cookie
            var arrCookie = strCookie.split("; ");
            for (var i = 0; i < arrCookie.length; i++) {
                var arr = arrCookie[i].split("=");
                if (arr[0] == name&&arr[1]){ return unescape(arr[1]);}
            }
            return "";
        };
        /*
        * 删除指定名称的cookie
        */
        this.del = function (name) {
            var date = new Date();
            date.setTime(date.getTime() - 10000);
            document.cookie = name + "=v; expires=" + date.toGMTString() + "; path=/";
        };
    }

    /*左右滑动开关*/
    function switchBtn(target, isOn, opts){
    	var textArr = ['已开启','已关闭'];
    	var dom = target,
    		domSwitch = $('<i>'),
    		domText = $('<span>').text(textArr[1]),
    		left = 0,
    		cls = '',
    		txt = '';

    	function clickEvent(left,cls,txt){

    		domSwitch.animate({
    			left: left
    		},200,'linear');
    		dom[cls]('on');
    		domText.text(txt);
    	}

    	dom.append(domSwitch).append(domText);

    	if( isOn ){
    		clickEvent( Math.floor(dom.width()) - Math.floor(domSwitch.width()),'addClass',textArr[0])
    	}

    	dom.click(function(){

    	    if (opts.before) {

    	        opts.before.call(dom, toggle);

    	    } else {

    	        toggle();

    	    }

    	})

    	function toggle() {
    	    if (dom.hasClass('on')) {
    	        left = 0;
    	        cls = 'removeClass';
    	        txt = textArr[1]
    	        clickEvent(left, cls, txt);
    	        opts.switchOff && opts.switchOff.call(dom);
    	    } else {
    	        left = Math.floor(dom.width()) - Math.floor(domSwitch.width());
    	        cls = 'addClass';
    	        txt = textArr[0]
    	        clickEvent(left, cls, txt);
    	        opts.switchOn && opts.switchOn.call(dom);
    	    }
    	}
    }