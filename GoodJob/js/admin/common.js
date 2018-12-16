function pageMainMenuCreater() {
    var _this = this;
    this.mainText = null;
    this.subText = null;
    this.mainIndex = 100;
    this.subIndex = 100;
    this.msoverIndex = 0;
    this.showEmptySubGroup = true;
    this.isOverMain = false;
    this.isOverSub = false;
    this.showSubNav = function (idx) {
        if (!_this.showEmptySubGroup && $("#pg-nav-sub ul").eq(idx).find("li").length == 0) {
            $("#pg-nav-sub").hide();
        }
        else $("#pg-nav-sub").show();
        $("#pg-nav-sub ul").hide();
        $("#pg-nav-sub ul").eq(idx).show();
    };
    this.timeoutObj = null;
    this.timeoutCheck = function () {
        if (!_this.isOverMain && !_this.isOverSub) {
            $("#pg-nav li").removeClass("mhover");
            _this.showSubNav(_this.mainIndex);
        }
    };
    this.mainItemOver = null;
    this.timeoutCheckMSOverObj = null;
    this.timeoutCheckMSOver = function () {
        if (_this.mainItemOver != null) {
            var lis = $("#pg-nav li").get();
            for (var i = 0; i < lis.length; i++) if (lis[i] == _this.mainItemOver) { _this.msoverIndex = i; break; }
            _this.showSubNav(_this.msoverIndex);
            $("#pg-nav li").removeClass("mhover");
            $(_this.mainItemOver).addClass("mhover");
        }
    };
    this.mainItemClick = null;
    this.timeoutCheckClickObj = null;
    this.timeoutCheckClick = function () {
        $("#pg-nav li").removeClass("mhover");
        _this.showSubNav(_this.mainIndex);
        $(this).addClass("mhover");
        if (_this.timeoutObj != null) clearTimeout(_this.timeoutObj);
        _this.timeoutObj = setTimeout(_this.timeoutCheck, 2000);
    };
    var inited = false;
    this.init = function () {
        if (inited) return;
        inited = true;
        $("#pg-nav ul li").mouseover(function () {
            _this.isOverMain = true;
            _this.mainItemOver = this;
            //$("#pg-nav li").removeClass("mhover");
            //$(this).addClass("mhover");
            if (_this.timeoutCheckMSOverObj != null) clearTimeout(_this.timeoutCheckMSOverObj);
            _this.timeoutCheckMSOverObj = setTimeout(_this.timeoutCheckMSOver, 100);
        }).mouseout(function () {
            if (_this.timeoutCheckMSOverObj != null) clearTimeout(_this.timeoutCheckMSOverObj);
            _this.mainItemOver = null;
            _this.isOverMain = false;
            if (_this.timeoutObj != null) clearTimeout(_this.timeoutObj);
            _this.timeoutObj = setTimeout(_this.timeoutCheck, 1000);
        });
        $("#pg-nav ul li").click(function () {
            $("#pg-nav li").removeClass("mhover");
            var lis = $("#pg-nav li").get();
            for (var i = 0; i < lis.length; i++) if (lis[i] == this) { _this.showSubNav(i);; break; }
            $(this).addClass("mhover");
            if (_this.timeoutObj != null) clearTimeout(_this.timeoutObj);
            _this.timeoutObj = setTimeout(_this.timeoutCheck, 3000);
        });
        $("#pg-nav-sub").mouseover(function () {
            _this.isOverSub = true;
        }).mouseout(function () {
            _this.isOverSub = false;
            if (_this.timeoutObj != null) clearTimeout(_this.timeoutObj);
            _this.timeoutObj = setTimeout(_this.timeoutCheck, 1000);
        });
        $("#pg-nav-sub-main ul li").mouseover(function () {
            if (!$(this).is(".active")) $(this).addClass("mhover");
        }).mouseout(function () {
            $(this).removeClass("mhover");
        });
    }
    this.setActive = function (optsss) {
        if (!inited) _this.init();
        optsss = optsss || {};
        _this.mainText = optsss.mainText || null;
        _this.subText = optsss.subText || null;
        _this.mainIndex = optsss.mainIndex || -1;
        _this.subIndex = optsss.subIndex || -1;
        if (_this.mainText) {
            var mainLis = $("#pg-nav ul li").get();
            for (var i = 0; i < mainLis.length; i++) if ($(mainLis[i]).text() == _this.mainText) _this.mainIndex = i;
        }
        if (_this.subText) {
            var subLis = $("#pg-nav-sub ul").eq(_this.mainIndex).find("li").get();
            for (var i = 0; i < subLis.length; i++) if ($(subLis[i]).text() == _this.subText) _this.subIndex = i;
        }
        if (_this.mainIndex >= 0) {
            $("#pg-nav ul li").eq(_this.mainIndex).addClass("active");
            _this.showSubNav(_this.mainIndex);
            if (_this.subIndex < 0 && _this.subText != null) {
                $("#pg-nav-sub ul").eq(_this.mainIndex).append("<li><a href='javascript:void(0);'>" + _this.subText + "</a></li>");
                $("#pg-nav-sub ul").eq(_this.mainIndex).find("li").last().addClass("active");
            } else $("#pg-nav-sub ul").eq(_this.mainIndex).find("li").eq(_this.subIndex).addClass("active");
        }
    }
}
var pageMainMenuCreater = new pageMainMenuCreater();
$(function() {
    pageMainMenuCreater.init();
    $(".tr0,.tr1").mouseover(function () { $(this).addClass("mOver"); }).mouseout(function () { $(this).removeClass("mOver"); });

    //日期控件的一些约定使用习惯
    $(".date input").each(function () {
        if ($(this).parent().data("autoinit") != "false") {
            if (JB.trim(JBInputInnerTips.val(this)) != "") { $(this).parent().find(".setdate").hide(); $(this).parent().find(".deldate").show(); }
            else { $(this).parent().find(".deldate").hide(); $(this).parent().find(".setdate").show(); }
            $(this).change(function () {
                if (JB.trim(JBInputInnerTips.val(this)) != "") { $(this).parent().find(".setdate").hide(); $(this).parent().find(".deldate").show(); }
                else { $(this).parent().find(".deldate").hide(); $(this).parent().find(".setdate").show(); }
            });
            $(this).focus(function () {
                JBCalendar.show(this);
            });
            $(this).parent().find(".setdate").click(function () {
                JBCalendar.show($(this).parent().find("input").get(0));
            });
            $(this).parent().find(".deldate").click(function () {
                $(this).parent().find("input").first().val("");
                //$(this).parent().find("input").first().change();
                JB.fireEvent($(this).parent().find("input").get(0), "change");
            });
        }
    });
});



function CommonIframeSubmitHelper() {  //适用于后台不需要面向搜索引擎的提交或分页加载
    var _this = this;
    var dialog = new JBodyDialog();
    var callback = function () { };
    var resetor = new JBodyInputResetor();
    var key = new Date();
    var _opt = {};   //{obj,jqSelector（成功后需要更新的Dom对象的JQ选择表达式）, 
                     // data,method,url,target,clearLocalParm,callback,debug }
    this.submit = function (opt) {
        opt = opt || _opt || {};
        opt.obj = opt.obj || _opt.obj || null;
        opt.data = opt.data || _opt.data || {};
        opt.data.commomIframeSubmitHelper = "commomIframeSubmitHelper";  //回发标志
        opt.url = opt.url || _opt.url || null;
        opt.method = opt.method || _opt.method || null;
        opt.target = opt.target || _opt.target || "_postTargetIframe";
        opt.clearLocalParm = opt.clearLocalParm === false ? false : _opt.clearLocalParm === false ? false : true;
        opt.debug = opt.debug === true ? true : _opt.debug === true ? true : false;
        if(!opt.obj) return;
        opt.saveForReset = JB.undef(opt.saveForReset, true);
        callback = opt.callback || _opt.callback || function () { };
        dialog.show(null, "<img src='/images/common/loading/5.gif' />", { title: "加载中，请稍候...", talign: "center", w: 200, h: 90, modal: true, pos: { park: "win center" } });
        if (opt.saveForReset) { resetor.save({ objs: opt.obj }); } //记录最近提交值，
        JB.submit(opt.obj, opt.data, opt.method || "post", opt.url, JB.undef(opt.clearLocalParm, true), JB.undef(opt.debug, false), opt.target);
    }
    this.resetAndSubmit = function (opt) {  //此方法常用于分页
        //alert(JB.objToStr(opt));
        opt = opt || _opt || {};
        resetor.reset();
        opt.saveForReset = false;
        _this.submit(opt);
    }
    this.save = function (opt) {
        opt = opt || _opt || {};
        resetor.save({ objs: opt.obj }); //记录最近提交值，
    }
    this.done = function (opt) {  //iframe提交完成后更新内容
        opt = opt || _opt || {};
        var jqSelector = opt.jqSelector || _opt.jqSelector;
        if (opt.htm) {
            //alert(htm);
            $(jqSelector).html(opt.htm);
            dialog.close();
            callback();
            return;
        } else if (self != top) {
            //alert("iframe");
            if (JB.isArray(jqSelector)) for (var i = 0; i < jqSelector.length; i++) parent.CommonIframeSubmitHelper.done({ jqSelector: jqSelector[i], htm: $(jqSelector[i]).html() });
            else parent.CommonIframeSubmitHelper.done({ jqSelector: jqSelector, htm: $(jqSelector).html() });
        } else {
            dialog.close();
            callback();
        }
    }
    this.init = function (opt) { 
        _opt = opt || {};
        callback = _opt.callback || function () { };
        if (window.self != window.top) _this.done();
        else _this.save();
    }
}
CommonIframeSubmitHelper = new CommonIframeSubmitHelper();