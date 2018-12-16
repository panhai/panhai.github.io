//设定JBodyDialog的统一样式
JBodyDialogDefaultSetting = {
    colors: [/*border*/"#aaaaaa", /*bg*/"#ffffff", /*titleBg*/"url(/images/jbody/jbdialog/winTitleBg.png) 10px -145px no-repeat #ddd", /*title*/"#333", /*win*/"#333333", /*titleBorder*/"#aaaaaa", /*alphaBorder*/"#dddddd", /*shadow*/"#bbbbbb", /*modal*/"#bbbbbb"],
    btcolors: ["#666", "#bbb", "#bbb", "#ffffff", "#555", "#555"],  //0,1bg,2bd:mouseout   3,4bg,5bd:mouseover
    alphaBorder: (JB.IE && JB.V < 8) ? 0 : 0,
    shadow: 2,
    padding: 5,
    borderInner: 1,
    cssClass: { title: "", dialog: "", button: "" },
    corner: { tL: 2, tR: 2, bL: 4, bR: 4 },
    titleH: 38,
    titlePaddingLeft: 30,
    titleFontSize: 14,
    buttonWH: 18
}

function adminPageInit(options) {
    options = options || {};
    if (window.self != window.top) {
        $(".pg-top,.pg-header,.pg-nav,.footerOuter").hide();
        var frame = $(window.frameElement);
        if (options.unresize == "") {
            frame.removeAttr("height");
            JBFrameHelper.ResetHeight();
        }
    }
}

function checkboxOperate(chboxs, opt) {
    var v = "";
    if (!opt) opt = new Object();
    opt.spa = opt.spa || ",";
    for (var i = 0; i < chboxs.length; i++) {
        if (chboxs[i].type != "checkbox") continue;
        if (chboxs[i].disable == true) chboxs[i].checked = false;
        else if (opt.all) chboxs[i].checked = true;
        else if (opt.ref) chboxs[i].checked = !chboxs[i].checked;
        else if (opt.clear) chboxs[i].checked = false;
        if (chboxs[i].checked) v += (v == "" ? "" : opt.spa) + chboxs[i].value;
    }
    return v;
}

function SetMainMenu(opt) {
    var itemList = $("#pg-nav ul li").get();
    var idx = -1;
    if (opt.text) {
        for (var i = 0; i < itemList.length; i++) if ($(itemList[i]).text() == opt.text) {
            idx = i;
        }
    }
    if (idx < 0 && opt.index >= 0) idx = opt.index;
    if (itemList.length > idx) $("#pg-nav ul li").eq(idx).addClass("active");
}



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


function LoginHelper() {
    var _this = this;
    var _opt = {};
    var _dialog = new JBodyDialog();
    var _successCallback = null;
    var _successCallbackData = null;
    var htm = "<tr><th style='padding-top:20px;'>手机/邮箱：</th><td colspan='2' style='padding-top:20px;'><input name='useraccount' class='inputText' type='text' style='width:180px;'></td></tr>";
    htm += "<tr><th>密码：</th><td colspan='2'><input name='userpassword' class='inputText' type='password' style='width:180px;'></td></tr>";
    htm += "<tr class='vcode'><th style='width:85px;'>验证码：</th><td style='width:90px;'><input name='vcode' class='inputText' style='width:80px;' type='text'></td><td></td></tr>";
    htm += "<tr class='msg'><td colspan='3'><div></div></td></tr>";
    htm += "<tr class='lasttr'><td colspan='3' style='padding-bottom:25px;'><input type='button' onclick='LoginHelper.loginButtonClick(this)' class='btn-3d btn-3d-orange' value='登&nbsp;&nbsp;&nbsp;录' /><a href='/register/'>免费注册</a><a href='/forgetpassword/'>忘记密码？</a></td></tr>";
    var _table = JB.newObj("table", { className: "ajaxLoginBoxTable", html: htm });
    this.changePic = function () {
        $(_table).find("img").attr("src", "/vcode/vcode.aspx?sid="+new Date());
    }
    var _success = function () {
        if (_successCallback) _successCallback(_successCallbackData);
    }
    this.loginButtonClick = function (btn) {
        $(_table).find(".vcode td").last().html("");
        _dialog.close();
        var data = JB.formToJson(_table);
        data.cmd = "login";
        var aAjax = new JBodyCommonAjax({
            obj: null,
            data: data,
            debug: false,
            refresh: false,
            url: "/Ajax/Default.phtml",
            title: "用户登录",
            loadingMsg: "<img src='/images/common/loading/5.gif' alt='' />",
            afterSuccess: _success,
            afterFail: function (responeText, aJson) {
                if (aJson) {
                    aAjax.close();
                    _opt.msg = aJson.msg;
                    if (aJson.data && aJson.data.vcode) _opt.vcode = true;
                    _opt.vcode = true;
                    _opt.callbackData = _successCallbackData;
                    _this.show(_opt);
                }
            }
        });
    }
    this.show = function (opt) {
        _opt = opt || {};
        _successCallback = _opt.callback;   //同一时间应该只会有一个登录
        _successCallbackData = _opt.callbackData;
        var msg = JB.undef(_opt.msg, "");
        var title = JB.undef(_opt.title, "用户登录");
        var acc = JB.undef(_opt.acc, "");
        var vcode = JB.undef(_opt.vcode, false);
        if (acc != "") { $(_table).find("input").first().val(acc); }
        if (vcode === true) {
            $(_table).find(".vcode").show();
            $(_table).find(".vcode td").last().html("<img src='/vcode/vcode.aspx?sid="+new Date()+"' onclick='LoginHelper.changePic()' title='点击更换图片' />  <span onclick='LoginHelper.changePic()'>换一张图片？</span>")
            //_this.changePic();
        }
        else $(_table).find(".vcode").hide();
        if (msg != "") { $(_table).find(".msg").show().find("td div").html(msg); }
        else $(_table).find(".msg").hide();
        _dialog.show(null, _table, { title: title, modal: true, pos: { park: "win center" } });
    }
}
var LoginHelper = new LoginHelper();