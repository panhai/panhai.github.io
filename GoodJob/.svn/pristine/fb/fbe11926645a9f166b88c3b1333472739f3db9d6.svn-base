/*
中心弹出层，页内页特效，需要包含文件effect/bg.js
可以附加data-active，为激活本层的元素JQ选择器字符串，在初始化时将会自动将本层的打开行为，绑定到对应元素的点击事件上
可以附加data-attrs，所需属性名列表，当本层打开时，会自动复制激活了本层的符合data-active的指定一个元素上的对应的data数据
	*****比如弹出层上写data-active=".Active a:eq(3)"，data-attrs="id,time"
	*****则层在点击任意一个.Active a:eq(3)时，会打开本层，并复制被点击元素上的data-id与data-time给本层
在CENTERDIV中的任意元素上附加data-attr=""，可以在打开时，自动将读取到的数据填充到元素内
	*****如果是input的话，则使用value属性；如果是其它元素，暂时全部使用text方法
	*****例，<em data-attr="name"></em>，当点击某个激活元素打开弹出层时，会将弹出层的data-name值附加给这个em元素
*/
var CENTERDIV = {
    init: function () {
        var center = this;
        //直接在层上获取激活行为对象的JQ选择器字符串，并绑定上打开行为
        var sJQ;
        if (sJQ = $(this).data("active")) {
            $(sJQ).each(function () {
                if (this.tagName.toLowerCase() == 'a') this.href = 'javascript:void(0)';
            });
            $("body").on('click', sJQ, function () {
                CENTERDIV.open.call(center, this);
                $(center).find("[data-attr]").each(function () {
                    var attr = $(this).data("attr"),
						value = $(center).data(attr);
                    switch (this.tagName.toLowerCase()) {
                        case 'input':
                        case 'textarea':
                            $(this).val(value);
                            break;
                        default:
                            $(this).text(value);

                    }
                });
            });
        }
        //给标题上的叉与内容中的取消，都绑上关闭行为
        if ($(this).data("init") === false) return true;
        $(this).find('.CENTERTOPIC q,.CENTERCONTENT .reset,.close').click(function () {
            CENTERDIV.close.call(center, true);
        });

        CENTERDIV.fixed.call(center);
        CENTERDIV.move.call(center, { move: 'both', hander: '.CENTERTOPIC' });
    },
    //将激活弹出行为的对象加入到open的参数中，以便复制目标上的data各项参数
    open: function (oActiveTarget) {
        var center = this;
        $(this).siblings(".CENTERDIV").hide();
        CHIbg.open(function () {
            $(center).show().closest(".CenterDivContainer").fadeIn(function () {
                var afteropen = $(center).data("afteropen");
                if (!afteropen) return;
                var fun = afteropen.substr(0, afteropen.indexOf(')') - 1);
                type = eval("typeof " + fun);
                if (type.toLowerCase() == 'function') {
                    eval(afteropen);
                }
            });
            //$(".CenterDivContainer").fadeIn();
        });
        //复制参数给弹出层
        var needAttrs = $(this).data("attrs");
        if (needAttrs && oActiveTarget) {
            needAttrs = needAttrs.split(',');
            for (var n = 0; n < needAttrs.length; n++) {//只复制已定义的参数
                var name = needAttrs[n],
					data = $(oActiveTarget).data(name);
                if (data !== undefined) {
                    if ($(this).data('t')) {
                        $(this).data(name, $(oActiveTarget).attr('data-' + name));

                    } else {

                        $(this).data(name, data);
                    }

                }
            }
        }
    },
    close: function (bBgOut) {
        var center = $(this).hide();
        $(this).closest(".CenterDivContainer").fadeOut(function () {
            if (bBgOut) CHIbg.close();
        });

        var afterClose = $(center).data("afterclose");
        if (!afterClose) return;
        var fun = afterClose.substr(0, afterClose.indexOf(')') - 1);
        type = eval("typeof " + fun);
        if (type.toLowerCase() == 'function') {
            eval(afterClose);
        }
    },
    move: function (data) {
        var $this = $(this);

        var xPage;
        var yPage;
        var X;//
        var Y;//
        var xRand = 0;//
        var yRand = 0;//

        var father = $this.closest('.FullScreenPlugin');
        var defaults = {
            move: 'both',
            randomPosition: true,
            hander: 1
        }

        var opt = $.extend({}, defaults, data);
        var movePosition = opt.move;
        var random = opt.randomPosition;

        var hander = opt.hander;

        if (hander == 1) {
            hander = $this;
        } else {
            hander = $this.find(opt.hander);
        }

        hander.css({ "cursor": "move" });

        var faWidth = father.width();
        var faHeight = father.height();
        var thisWidth = $this.width() + parseInt($this.css('padding-left')) + parseInt($this.css('padding-right'));
        var thisHeight = $this.height() + parseInt($this.css('padding-top')) + parseInt($this.css('padding-bottom'));

        var mDown = false;

        var positionX;
        var positionY;
        var moveX;
        var moveY;

        hander.mousedown(function (e) {
            mDown = true;
            X = e.pageX;
            Y = e.pageY;

            positionX = $this.position().left;
            positionY = $this.position().top;

            $(document).on('mousemove', mouseMove);
            $('body').on('selectstart', disableSelect);

            return false;
        });

        $(document).mouseup(function (e) {
            mDown = false;
            $(document).off('mousemove', mouseMove);
            $('body').off('selectstart', disableSelect);
        });

        function disableSelect() {
            return false;
        }

        function mouseMove(e) {
            xPage = e.pageX;//--
            moveX = positionX + xPage - X;

            yPage = e.pageY;//--
            moveY = positionY + yPage - Y;

            function thisAllMove() { //全部移动
                if (mDown == true) {
                    $this.css({ "left": moveX, "top": moveY });
                } else {
                    return;
                }

                if (moveX < 0) {
                    $this.css({ "left": "0" });
                }

                if (moveX > (faWidth - thisWidth)) {
                    $this.css({ "left": faWidth - thisWidth });
                }

                if (moveY > (faHeight - thisHeight)) {
                    $this.css({ "top": faHeight - thisHeight });
                }

                if (moveY < 0) {
                    $this.css({ "top": 0 });
                }
            }

            thisAllMove();
        }
    },
    fixed: function () {
        $(this).closest('.CenterDivContainer').show();

        var browserHeight = $(window).height();
        var browserWidth = $(window).width();

        var centerdivtop = (browserHeight - $(this).height()) / 2;  //计算元素距离页面顶部
        var centerdivleft = (browserWidth - $(this).width()) / 2;   //计算元素距离页面左边

        if (browserHeight < $(this).height()) {
            centerdivtop = 0;
        }

        if (browserWidth < $(this).width()) {
            centerdivleft = 0;
        }

        //---初始化
        $(this).css({
            position: "absolute",
            top: centerdivtop,
            left: centerdivleft,
            margin: ""
        });

        $(this).closest('.CenterDivContainer').hide();
    }
}
$(function () {
    if (typeof CHIbg == 'undefined') alert('需要包含文件effect/bg.js');
    $(".CENTERDIV").not(".CenterAlert,.CenterConfirm").map(function () {
        CENTERDIV.init.call(this);
    });
    $(".CenterDivContainer").hide();
})
var ALERT = function (topic, content, delay, onsubmit) {
    var jq = ALERT.JQ;
    jq.find(".CENTERTOPIC b:first").text(topic).end()
		.find(".ContentDynamic").html(content);
    ALERT.onsubmit = $.isFunction(onsubmit) ? onsubmit : $.noop;
    jq.stop(true).fadeIn();
    if (!isNaN(delay)) setTimeout(ALERT.close, delay);
}
ALERT.JQ = $('<table class="FullScreenPlugin fixed fixed-top CenterDivContainer black5 highest"><tr><td><dl class="CENTERDIV CenterTiny CenterAlert"><dt class="CENTERTOPIC"><b></b><q></q></dt><dd class="CENTERCONTENT"><div class="ContentDynamic"></div></dd></dl></td></tr></table>');
ALERT.JQ.appendTo("body").end().hide();
ALERT.close = function () {
    ALERT.JQ.stop().fadeOut(function () {
        ALERT.onsubmit();
    });
}
ALERT.JQ.find(".CENTERTOPIC q").click(ALERT.close);


var CONFIRM = function (topic, content, submitTip, onsubmit, resetTip, onreset) {
    if (!submitTip) submitTip = "确定";
    if (!resetTip) resetTip = "取消";
    var jq = CONFIRM.JQ;
    jq.find(".CENTERTOPIC b:first").text(topic).end()
		.find(".ContentDynamic").html(content).end()
		.find(".submit").text(submitTip).each(function () {
		    $(this).removeAttr('href target');
		    if ($.isFunction(onsubmit)) CONFIRM.onsubmit = onsubmit;
		    else if (onsubmit instanceof String) $(this).attr('href', onsubmit);
		    else if ($.isPlainObject(onsubmit)) {
		        if ($.isFunction(onsubmit.callback)) CONFIRM.onsubmit = onsubmit.callback;
		        if (typeof onsubmit.href == 'string') $(this).attr('href', onsubmit.href);
		        if (typeof onsubmit.target == 'string') $(this).attr('target', onsubmit.target);
		    }
		}).end()
		.find(".reset").text(resetTip).each(function () {
		    $(this).removeAttr('href target');
		    if ($.isFunction(onreset)) CONFIRM.onreset = onreset;
		    else if (onreset instanceof String) $(this).attr('href', onreset);
		    else if ($.isPlainObject(onreset)) {
		        if ($.isFunction(onreset.callback)) CONFIRM.onreset = onreset.callback;
		        if (typeof onreset.href == 'string') $(this).attr('href', onreset.href);
		        if (typeof onreset.target == 'string') $(this).attr('target', onreset.target);
		    }
		});
    jq.stop(true).fadeIn();
}
CONFIRM.JQ = $('<table class="FullScreenPlugin fixed fixed-top CenterDivContainer black5 highest"><tr><td><dl class="CENTERDIV CenterSmall CenterConfirm"><dt class="CENTERTOPIC"><b></b><q></q></dt><dd class="CENTERCONTENT"><div class="ContentDynamic"></div><div class="CENTERBTNS"><a class="submit">确定</a><a class="reset">取消</a></div></dd></dl></td></tr></table>');
CONFIRM.JQ.appendTo("body").end().hide();
CONFIRM.JQ.click(function (event) {
    $(event.target).is(".submit,.reset,q")
	&& (
		$(event.target).is(".submit") && $.isFunction(CONFIRM.onsubmit) && (CONFIRM.onsubmit(), true),
		$(event.target).is(".reset") && $.isFunction(CONFIRM.onreset) && (CONFIRM.onreset(), true),
		CONFIRM.close()
	)
});
CONFIRM.close = function () {
    CONFIRM.JQ.stop().fadeOut();
    CONFIRM.onsubmit = null;
    CONFIRM.onreset = null;
}
