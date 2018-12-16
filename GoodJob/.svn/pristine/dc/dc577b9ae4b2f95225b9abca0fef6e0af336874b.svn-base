// JScript 文件


//-------------------------------------------
//-------------------------------------------
//
//-------------------------------------------
//-------------------------------------------
function JBodyComboxSettingBase() {
    return {
        styles: ".JBodyCombox2_select{  vertical-align:middle; }"
                     + "\r\n .JBodyCombox2_input{ border:solid 1px #999999;border-right:0px; padding:0px; vertical-align:middle; }"
                     + "\r\n .JBodyCombox2_input2{ border:solid 1px #999999; padding:0px; vertical-align:middle; }"
                     + "\r\n .JBodyCombox2_button{  border:solid 1px #999999; border-left:0px; padding:0px;background-color:#EEEEEE; vertical-align:middle; }"
                     + "\r\n .JBodyCombox2_options{ border:solid 1px #2C7ECF;background-color:#eeeeee; }"
                     + "\r\n .JBodyCombox2_option{ border:solid 0px #999999; padding-left:3px; background-color:#ffffff; font-size:12px;text-align:left; overfloat:hidden; white-space:nowrap;  }"
                     + "\r\n .JBodyCombox2_optionover{ border:solid 0px #999999; padding-left:3px;background-color:#C6DFF0; font-size:12px;text-align:left; overfloat:hidden; white-space:nowrap; }"
                     + "",
        input: {
            option: { css: [["border", "solid 1px #cccccc"], ["padding", "0px"], ["paddingLeft", "5px"], ["verticalAlign", "middle"]] },
            optionHasButton: { css: [["border", "solid 1px #cccccc"], ["padding", "0px"], ["paddingLeft", "5px"], ["verticalAlign", "middle"], ["borderRight", "0px"]] }
        },
        button: {
            option: { css: [["border", "solid 1px #cccccc"], ["borderLeft", "0px"], ["padding", "0px"], ["backgroundColor", "#EEEEEE"], ["verticalAlign", "middle"]] },
            bg: "/images/select/sl_c_20x22.png"
        },
        item: {
            option: { css: [["border", "solid 0px #999999"], ["paddingLeft", "3px"], ["backgroundColor", "#ffffff"], ["fontSize", "12px"], ["textAlign", "left"], ["overfloat", "hidden"], ["whiteSpace", "nowrap"]] },
            activeOption: { css: [["border", "solid 0px #999999"], ["paddingLeft", "3px"], ["backgroundColor", "#DFEFFF"], ["fontSize", "12px"], ["textAlign", "left"], ["overfloat", "hidden"], ["whiteSpace", "nowrap"]] }
        },
        itemOuterContainer: {
            option: { css: [["overflow", "hidden"], ["border", "solid 1px #2C7ECF"], ["backgroundColor", "#eeeeee"]] }
        }
    };
}
var JBodyComboxSetting = JBodyComboxSettingBase();
function JBodyComboxBase(sl, options) {
    if (sl == null) return;
    if (sl.style.display == "none") return;
    var _destroyed = true;
    _this = this;
    var JB = JBody;
    var _option = {
        enabled: true,
        disabled: false,
        mode: "span",         //div或span
        attrname: "data-jbcombox",
        w: sl.offsetWidth,
        h: 22,
        btW: 20,
        inputRborder: "auto",
        editable: false,
        showButton: true,
        listMax: 10,
        listSmart: true,  //是否可以向上显示
        fixOptionWidth: true,
        enterCallBack: function() { return; },
        btImg: JBodyComboxSetting.button.bg,
        css: { select: "", input: "", input2: "", button: "",
            options: "", option: "", optionactived: ""
        }
    };
    var _setOpts = function(opt) {
        if (opt.enabled === false || opt.enabled === true) _option.enabled = opt.enabled;
        if (opt.mode == "div" || opt.mode == "span") _option.mode = opt.mode;
        _option.attrname = opt.attrname || _option.attrname;
        if (opt.w > 0) _option.w = opt.w;
        if (opt.h > 0) _option.h = opt.h;
        if (opt.btW > 0) _option.btW = opt.btW;
        if (opt.inputRborder) _option.inputRborder = opt.inputRborder;
        if (opt.editable === true) _option.editable = true;
        if (opt.showButton === false) _option.showButton = false;
        if (opt.listMax > 0) _option.listMax = opt.listMax;
        if (opt.listSmart === false) _option.listSmart = false;
        if (opt.fixOptionWidth === false) _option.fixOptionWidth = false;
        if (opt.enterCallBack && JB.isFunction(opt.enterCallBack)) {
            _option.enterCallBack = opt.enterCallBack;
        }
        if (opt.enterCallBack && typeof (opt.enterCallBack) === "string" && opt.enterCallBack != "") {
            _option.enterCallBack = function() { eval(opt.enterCallBack); };
        }
        if (opt.btImg) _option.btImg = opt.btImg;
        if (opt.css) {
            _option.css.select = opt.css.select || _option.css.select;
            _option.css.button = opt.css.button || _option.css.button;
            _option.css.input = opt.css.input || _option.css.input;
            _option.css.input2 = opt.css.input2 || _option.css.input2;
            _option.css.options = opt.css.options || _option.css.options;
            _option.css.option = opt.css.option || _option.css.option;
            _option.css.optionactived = opt.css.optionactived || _option.css.optionactived;
        }
    }
    if (options) _setOpts(options);
    var slopts = sl.getAttribute(_option.attrname);
    if (slopts != null && JB.trim(slopts) != "") {
        slopts = eval("({" + slopts + "})");
        _setOpts(slopts);
    }
    _this.destroy = function() { }
    _this.tryDestroy = function() { }
    if (_option.enabled === false || _option.disabled) return;
    if (_option.editable) JB.setOpt(sl, { w: _option.w }); //设置固定宽度阻止该元素变宽

    //var _dialog = new JBodyDialog();
    var _dialogItems = new JBodyDialog();


    var _container = JB.newObj(_option.mode.toUpperCase(), { h: _option.h, attrs: ["class", _option.css.select] });
    if (_option.mode == "div") {
        JB.setOpt(_container, { w: _option.w, css: ["verticalAlign", "middle"] });
    }
    var _input = JB.newObj("INPUT", { tp: "text", w: _option.w - _option.btW, h: _option.h, css: [["lineHeight", (_option.h - 2) + "px"]], value: sl.options[sl.selectedIndex].text });
    JB.setOpt(_input, _option.showButton ? JBodyComboxSetting.input.optionHasButton : JBodyComboxSetting.input.option);
    if (_option.inputRborder != "auto") JB.setOpt(_input, { css: ["borderRight", _option.inputRborder] });
    var _bt = JB.newObj("IMG", { w: _option.btW, h: _option.h, attrs: [["src", _option.btImg]] });
    JB.setOpt(_bt, JBodyComboxSetting.button.option);
    if (!_option.editable) _input.readOnly = true;
    _container.appendChild(_input);
    if (_option.showButton) _container.appendChild(_bt);
    
    if (sl.parentNode) sl.parentNode.insertBefore(_container, sl);
    sl.style.display = "none";

    while (_input.offsetWidth != (_option.w - _bt.offsetWidth)) {  //修复一些由padding及边框带来的宽度问题
        JB.setOpt(_input, { w: (parseInt(_input.style.width.replace("px","")) + ((_input.offsetWidth > (_option.w - _bt.offsetWidth)) ? -1 : 1)) });
    }
    
    if (_option.showButton) {
        var posA = JB.getAbsoluteOffset(_input);
        var posB = JB.getAbsoluteOffset(_bt);
        if (posA.t != posB.t) {
            JB.setOpt(_bt, { css: ["marginTop", (posA.t - posB.t) + "px"] });
        }
    }

    if (sl.length <= 0 && !_option.editable) return; //-----------

    var _activedItem = null;
    var _setActived = function(it) {
        if (_activedItem != null) JB.setOpt(_activedItem, JBodyComboxSetting.item.option);
        _activedItem = it;
        JB.setOpt(it, JBodyComboxSetting.item.activeOption);
    }
    var _moverItem = function(e) {
        e = window.event || e;
        var src = e.srcElement || e.target;
        _setActived(src);
    }
    var _setScrollTop = function(i) {
        if (_items_Array.length <= _option.listMax) return;
        var st = parseInt(_items.scrollTop);
        if (st > (i - 1) * _items_Array[i].offsetHeight) {
            _items.scrollTop = i * _items_Array[i].offsetHeight;
        } else if ((st + _items.offsetHeight) < (i + 1) * _items_Array[i].offsetHeight) {
            _items.scrollTop = (i + 1) * _items_Array[i].offsetHeight - _items.offsetHeight + 16;
        }
    }
    
    var _firebythis = false;
    var _clickItem = function(e) {
        e = window.event || e;
        var src = e.srcElement || e.target;
        _detachOuterClickClose();
        _dialogItems.close();
        if (sl == null) return false;
        _input.value = src.innerHTML.replace("&nbsp;", "");
        for (var i = 0; i < sl.length; i++) {
            if (sl[i].text == _input.value) sl[i].selected = true;
            //_firebythis = true;
        }
        JB.fireEvent(sl, "change");
    }
    var _items_temp = new Array();
    var _items_Array = new Array();
    var _tempContainer = JB.newObj("DIV", { w: 0, h: 0, l: 0, t: 0, css: [["position", "absolute"], ["overflow", "hidden"]] });
    document.documentElement.appendChild(_tempContainer);
    var _itemsOuterContainer = JB.newObj("DIV", { w: _option.w - 6, display: "none", attrs: ["class", _option.css.options] });
    JB.setOpt(_itemsOuterContainer, JBodyComboxSetting.itemOuterContainer.option);
    var _items = JB.newObj("DIV", { w: _container.offsetWidth - 4, css: ["overflow", "scroll"] });
    _tempContainer.appendChild(_itemsOuterContainer);
    _itemsOuterContainer.appendChild(_items);
    var _firstClick = true;
    var maxWidth = _option.w - 2;
    var newOption = function(txt, selected, atfirst) {
        var item = JB.newObj("DIV", { htm: (txt == "" ? "&nbsp;" : txt) });
        JB.setOpt(item, { h: _option.h, css: ["lineHeight", _option.h + "px"] });
        JB.setOpt(item, JBodyComboxSetting.item.option);
        _tempContainer.appendChild(item);
        if (_option.fixOptionWidth) maxWidth = Math.max(item.offsetWidth, maxWidth);
        if (atfirst && _items_Array.length > 0) {
            _items.insertBefore(item, _items.childNodes[0]);
            while (_items_Array.length > 0) _items_temp.push(_items_Array.pop());
            _items_Array.push(item);
            while (_items_temp.length > 0) _items_Array.push(_items_temp.pop());
        }
        else {
            _items.appendChild(item);
            _items_Array.push(item);
        }
        if (selected) _setActived(item);
        JB.attach(item, "mouseover", _moverItem);
        JB.attach(item, "click", _clickItem);
        if (_option.fixOptionWidth) maxWidth = Math.max(item.offsetWidth, Math.max(maxWidth, parseInt((JB.getLengthDoubleChinese(txt) * parseInt(item.style.fontSize || 12)) / 2)));
        _firstClick = true;
    }
    for (var i = 0; i < sl.length; i++) newOption(sl[i].text, i == sl.selectedIndex);
    for (var i = 0; i < _items_Array.length; i++) JB.setOpt(_items_Array[i], { w: maxWidth });
    _tempContainer.removeChild(_itemsOuterContainer);

    var _pos = { to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft", parkSmart: false };
    if (_option.listSmart) _pos = [{ to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft", parkSmart: false }, { to: "obj", parent: "doc", park: "outside", parkOutside: "topLeft", parkSmart: false}]
    JB.show(_itemsOuterContainer);
    var onclick = function() {
        if (sl == null) return;
        _dialogItems.show(_input, _itemsOuterContainer, { w: _itemsOuterContainer.offsetWidth, h: _itemsOuterContainer.offsetHeight, showTitle: false, showCloseButton: false, hideOverfloat: false,
            padding: 0, borderInner: 0, shadow: 2, pos: _pos, corner: { tL: 0, tR: 0, bL: 0, bR: 0 }
        });
        _attachOuterClickClose();
        if (_firstClick) {
            _firstClick = false;
            JB.setOpt(_items, { w: maxWidth + 20 });
            JB.setOpt(_itemsOuterContainer, { w: maxWidth });
            var maxHeight = 0;
            for (var j = 0; j < _items_Array.length && j < _option.listMax; j++) maxHeight += _items_Array[j].offsetHeight;
            JB.setOpt(_itemsOuterContainer, { h: maxHeight });
            JB.setOpt(_items, { h: maxHeight + 16 });
            if (_items_Array.length > _option.listMax) JB.setOpt(_items, { w: maxWidth });
            onclick();  //可能变更了高度，需要重新寻找位置
        }
        if (sl.length > 0 && sl.selectedIndex >= 0) {
            _setActived(_items_Array[sl.selectedIndex]);
            _setScrollTop(sl.selectedIndex);
        }
    }
    var _inputChanged = function(fire) {
        if (sl == null) return;
        var ind = -1;
        for (var i = 0; i < sl.length; i++) {
            if (sl[i].text == _input.value) {
                ind = i;
                sl[i].selected = true;
            }
        }
        if (ind < 0 && _option.editable) {
            if (sl.length == 0) sl.appendChild(new Option(_input.value, _input.value));
            else sl.insertBefore(new Option(_input.value, _input.value), sl[0]);
            newOption(_input.value, true, true);
            sl[0].selected = true;
        }
        if (fire !== false) JB.fireEvent(sl, "change");
    }
    var _selectChanged = function() {
        _inputChanged(false);
    }
    //JB.attach(sl, "change", _selectChanged);
    JB.attach(_input, "change", _inputChanged);
    var _closeFromOuter = function(e) {
        e = window.event || e;
        var src = e.srcElement || e.target;
        if (src == null) return;
        while (src) {
            if (src == _container || src == _itemsOuterContainer) return;
            src = src.parentNode;
        }
        _detachOuterClickClose();
        _dialogItems.close();
    }
    var _selectPreItem = function() {
        for (var i = 0; i < _items_Array.length; i++) {
            if (_items_Array[i] == _activedItem && i > 0) {
                _setActived(_items_Array[i - 1]);
                _setScrollTop(i - 1);
                return;
            }
        }
    }
    var _selectNextItem = function() {
        for (var i = 0; i < _items_Array.length; i++) {
            if (_items_Array[i] == _activedItem && i < (_items_Array.length - 1)) {
                _setActived(_items_Array[i + 1]);
                _setScrollTop(i + 1);
                return;
            }
        }
    }
    var _keyUpFun = function(e) {
        e = window.event || e;
        var currKey = e.which || e.keyCode || e.charCode;
        if ((currKey > 7 && currKey < 14) || (currKey > 31 && currKey < 47)) {
            switch (currKey) {
                case 13: { JB.fireEvent(_activedItem, "click"); JB.setTimeout(_option.enterCallBack, 50); break; }
                case 37: { _selectPreItem(); break; }
                case 38: { _selectPreItem(); break; }
                case 39: { _selectNextItem(); break; }
                case 40: { _selectNextItem(); break; }
                default: { _closeFromOuter(e); break; }
            }
        }
    }
    var _detachOuterClickClose = function() {
        JB.detach(document, "click", _closeFromOuter);
        JB.detach(document, 'keyup', _keyUpFun);
    };
    var _attachOuterClickClose = function() {
        _detachOuterClickClose();
        JB.setTimeout(JB.attach(document, "click", _closeFromOuter), 100);
        JB.setTimeout(JB.attach(document, "keyup", _keyUpFun), 100);
    };
    JB.attach(_container, "click", onclick);
    JB.attach(_input, "focus", onclick);
    JB.attach(_input, "blur", _closeFromOuter);
    _destroyed = false;
    var _destroy = function() {
        if (_destroyed) return;
        _destroyed = true;
        _detachOuterClickClose();
        //JB.detach(sl, "change", _selectChanged);
        JB.detach(_input, "change", _inputChanged);
        JB.detach(_container, "click", onclick);
        JB.detach(_input, "focus", onclick);
        JB.detach(_input, "blur", _closeFromOuter);
        _dialogItems.close();
        _dialogItems = null;
        _option = null;
        document.documentElement.removeChild(_tempContainer);
        if (_container.parentNode) _container.parentNode.removeChild(_container);
        _tempContainer = null;
        _items_Array = null; _itemsOuterContainer = null; _container = null;
        sl.style.display = "";
        sl = null;
    }
    _this.tryHide = function(slt) {
        if (_destroyed || slt != sl) return;
        _container.style.display = "none";
    }
    _this.destroy = function() { _destroy(); }
    _this.tryDestroy = function(slt) { if (slt == sl) _destroy(); }
    JB.attach(window, "unload", _destroy);
    if (_option.enabled === false || _option.disabled) _destroy();
}
function JBodyCombox() {
    var JB = JBody;
    var _this = this;
    var styles = JBodyComboxSetting.styles;
    //JB.addStyle(styles);
    var comboxArray = new Array();
    var _get = function(obj) {
        if (typeof (obj) == "string") return document.getElementById(obj);
        return obj;
    }
    this.create = function(opt, sl) {
        if (sl == null) {
            var sls = document.getElementsByTagName("select");
            for (var i = 0; i < sls.length; i++) _this.create(opt, sls[i]);
            sls = null;
        }
        else {
            _this.tryDestroy(_get(sl));
            comboxArray.push(new JBodyComboxBase(_get(sl), opt));
        }
    }
    this.tryDestroy = function(sl) {
        sl = _get(sl);
        for (var i = 0; i < comboxArray.length; i++) comboxArray[i].tryDestroy(sl);
    }
    this.destroy = this.tryDestroy;
    this.tryHide = function(sl) {
        sl = _get(sl);
        for (var i = 0; i < comboxArray.length; i++) comboxArray[i].tryHide(sl);
    }
    var _desdroy = function() { comboxArray = null; }
    //JB.attach(window, "unload", _desdroy);    
}
var JBodyCombox = new JBodyCombox();


function JBodyCommonAjax(option) {
    if (option == null) return;
    //{obj,winOpt,url,method,data,debug,jsvcode,inputs:[{name,title,tag,opt}],htm,refresh,afterSuccess,afterFail,before}
    //参考位置，winOpt，url，方法，需要传输的参数，需要输入的参数标题和名称（一个或多个），是否需要确认(确认标题)，成功是否需要刷新页面，成功时回调，失败时回调
    var _this = this;
    var _reload = function() { window.location.href = window.location.href; }
    this.reload = JB.undef(option.reload, _reload);  //实施刷新的方法
    this.dialog = new JBodyDialog();
    this.winPosToObj = option.obj;
    this.refresh = JB.undef(option.refresh, true);  //操作成功是否刷新页面
    this.jsvcode = JB.undef(option.jsvcode, false); //是否需要验证码
    if (this.jsvcode === true) this.jsvcode = 3;
    this.jsvcode = parseInt(this.jsvcode);
    if (this.jsvcode > 0) {
        if (this.jsvcode > 8) this.jsvcode = 8;
        this.jsvcode = parseInt(JB.padRight("1", this.jsvcode, '0')) + parseInt(Math.random() * parseInt(JB.padRight("8", this.jsvcode, '9')));
    }
    this.method = JB.undef(option.method, "POST");
    this.url = option.url;
    this.debug = option.debug;
    this.beforeAjax = option.before || option.beforeAjax || function() { return true; }    //开始提交之前的操作，如果返回false则表示取消提交
    this.suceessCallback = option.afterSuccess || function() { }
    this.errorCallback = option.afterFail || function () { }
    this.waitCloseAfterFail = JB.undef(option.waitCloseAfterFail, true);  //出错时是否等待手工关闭
    this.data = option.data || new Object();
    this.data.ajaxrandomparm = (Math.random() * 1000000); //随机参数（防止获得缓存数据）
    this.inputs = option.inputs || new Array();
    this.winOpt = option.winOpt || { showTitle: true, title: (option.title || "操作"), autoClose: 2000, showCloseButton: true, modal: true, talign: "left" };
    if (this.winOpt.title == null) this.winOpt.title = (option.title || "操作");
    if (this.winOpt.pos == null) this.winOpt.pos = (option.obj != null ? { to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft" } : { to: "win", parent: "doc", parkInside: "center" });
    if (this.winOpt.minWidth == null) this.winOpt.minWidth = 150;
    if (this.winOpt.minHeight == null) this.winOpt.minHeight = 50;
    this.htm = option.htm;
    this.loadingMsg = option.loadingMsg || "操作中，请稍候...";
    this.buttons = option.buttons || {};
    this.buttons.submit = this.buttons.submit || {};
    this.buttons.cancel = this.buttons.cancel || {};
    this.buttons.submit.cssClass = this.buttons.submit.cssClass || "CommonButtonSmallSmallShadow CommonButtonOrange30";
    this.buttons.submit.text = this.buttons.submit.text || "确定";
    this.buttons.cancel.cssClass = this.buttons.cancel.cssClass || "CommonButtonSmallSmallShadow CommonButtonGray30";
    this.buttons.cancel.text = this.buttons.cancel.text || "取消";
    
    this.vcodeInput = null;
    var _htmIsStringOrNull = (_this.htm == null || typeof (_this.htm) == "string");
    this.appendList = new Array(); //用于恢复原状
    this.removeAppend = function() {
        while (_this.appendList.length > 0) {
            try {
                var a = _this.appendList.pop();
                if (a.parentNode) a.parentNode.removeChild(a);
            } catch (e) { }
        }
    }
    this.appendObj = function(obj) {
        if (_this.htm == null || typeof (_this.htm) == "string") _this.htm = JB.newObj("DIV", { htm: _this.htm });
        if (obj == null) return;
        if (_this.htm == null) _this.htm = JB.newObj("DIV", { htm: _this.htm });
        _this.htm.appendChild(obj);
        _this.appendList.push(obj);
    }
    for (var i = 0; i < _this.inputs.length; i++) {
        if (i > 0) this.appendObj(JB.newObj("BR"));
        if (_this.inputs[i].title) _this.appendObj(JB.newObj("SPAN", { htm: _this.inputs[i].title }));
        var o = JB.newObj(_this.inputs[i].tag || "INPUT", _this.inputs[i].opt);
        if (_this.inputs[i].name) JB.setOpt(o, { attrs: ["name", _this.inputs[i].name], type: _this.inputs[i].type || "text", value: _this.inputs[i].value || "" });
        this.appendObj(o);
        if (_this.inputs[i].tip) _this.appendObj(JB.newObj("SPAN", { htm: _this.inputs[i].tip }));
    }
    if (typeof (this.htm) == "string") this.htm = JB.newObj("DIV", { htm: this.htm });

    this.aCallback = function(xmlhttp) {
        try {
            if (_this.debug) alert(xmlhttp.responseText);
            var v = eval("(" + xmlhttp.responseText.replace(/[\r]+/g, "\\r").replace(/[\n]+/g, "\\n") + ")");
            if (v.status || v.success) {
                _this.winOpt.autoClose = 2600;
                _this.winOpt.showCloseButton = false;
                _this.dialog.show(_this.winPosToObj, v.msg, _this.winOpt);
                JB.setTimeout(_this.suceessCallback, 300, xmlhttp.responseText, v);
                //_this.suceessCallback(xmlhttp.responseText, v);
                if (_this.refresh) setTimeout(_this.reload, 1800);
            } else {
                _this.winOpt.autoClose = 0;
                _this.winOpt.showCloseButton = true;
                _this.dialog.show(_this.winPosToObj, v.msg, _this.winOpt);
                JB.setTimeout(_this.errorCallback, 300, xmlhttp.responseText, v);
                //_this.errorCallback(xmlhttp.responseText);
            }
        } catch (e) {
            _this.winOpt.autoClose = 0;
            _this.winOpt.showCloseButton = true;
            _this.dialog.show(_this.winPosToObj, "操作失败！", _this.winOpt);
            if (_this.debug) {
                alert(e.description || "未知错误");
            }
            _this.errorCallback();
        }
    }
    this.worknow = function () {
        var f = null;
        if (_this.jsvcode > 0 && parseInt(_this.vcodeInput.value) != _this.jsvcode) {
            alert("确认码错误");
            return;
        }
        try {
            f = JB.createForm(_this.htm, _this.data, _this.method, _this.url, true);
            if (_this.debug) alert("(" + f.action + ")" + JB.formToUrlStr(f));
        } catch (e) { alert(e.description); }
        if (_this.beforeAjax() === false) return;
        JB.ajax.postForm(f, _this.aCallback, null, "POST", null, _this.debug);

        _this.winOpt.autoClose = 50000; //最长50秒
        _this.winOpt.showCloseButton = false;
        _this.dialog.show(_this.winPosToObj, _this.loadingMsg, _this.winOpt);
    }
    this.close = function() {
        _this.dialog.close();
    }
    this.bt = JB.newObj("INPUT", { type: "button", value: _this.buttons.submit.text, cursor: "pointer", className: _this.buttons.submit.cssClass, css: ["marginLeft", "3px"] });
    this.bt2 = JB.newObj("INPUT", { type: "button", value: _this.buttons.cancel.text, cursor: "pointer", className: _this.buttons.cancel.cssClass, css: ["marginLeft", "3px"] });

    if (this.jsvcode > 0) {
        this.vcodeInput = JB.newObj("INPUT", { type: "text", w: 40 });
        this.appendObj(JB.newObj("BR"));
        this.appendObj(JB.newObj("SPAN", { html: "请输入确认码<span style='font-weight:bold; color:red;'>" + this.jsvcode + "</span>" }));
        this.appendObj(this.vcodeInput);
    }

    if (this.htm != null) {
        JB.attach(_this.bt, "click", _this.worknow);
        JB.attach(_this.bt2, "click", _this.close);
        _this.appendObj(_this.bt);
        _this.appendObj(_this.bt2);
        _this.winOpt.autoClose = 0;
        _this.winOpt.showCloseButton = true;
        if (!_htmIsStringOrNull) _this.winOpt.afterClose = _this.removeAppend;
        _this.dialog.show(_this.winPosToObj, _this.htm, _this.winOpt);
    }
    else this.worknow();
}

function JBFrameHelper() {
    var winWinList = new Array();
    var _this = this;
    var _frame = window.frameElement || {};
    _this.frameKey = _frame.id || MD5_32(location.href);
    this.close = function(key) {  //本页调用 JBFrameHelper.signReloadParent();
        if (self != top) {
            top.JBFrameHelper.close(_this.frameKey);
            return;
        }
        else if (key && key != "") {
            for (var i = 0; i < winWinList.length; i++) if (winWinList[i].key == key) winWinList[i].win.close();
        }
    }
    this.showWinListInfo = function(){
        if (self != top) {  top.JBFrameHelper.showListInfo(); }
        else {
            var txt = "";
            for (var i = 0; i < winWinList.length; i++) { txt += "parentKey=" + winWinList[i].parentKey + ", key=" + winWinList[i].key + ", url=" + winWinList[i].url +"\r\n"; }
            alert(txt);
        }
    }
    this.signReloadParent = function(key) {  //本页调用 JBFrameHelper.signReloadParent();
        if (self != top) {
            top.JBFrameHelper.signReloadParent(_this.frameKey);
            return;
        }
        else {
            key = key || _this.frameKey;
            for (var i = 0; i < winWinList.length; i++) if (winWinList[i].key == key) {
                winWinList[i].reloadParent++;
                top.JBFrameHelper.signReloadParent(winWinList[i].parentKey);  //所有父链中的窗口都注册刷新
            }
        }
    }
    this.reloadPageByFrameId = function(frameId) {  //不要在其他地方调用此方法
        if (frameId == top.JBFrameHelper.frameKey) {
            location.reload(true);
            return;
        }
        try {
            document.getElementById(frameId).contentWindow.reloadPage();
        } catch (e) {
            try { document.getElementById(frameId).contentWindow.location.reload(true); } catch (e) { }
        }
    };
    this.iframeHeightUpdate = function(ky) {
        if (self != top) {
            top.JBFrameHelper.iframeHeightUpdate(ky || window.frameElement.id);
            return;
        }
        for (var i = 0; i < winWinList.length; i++) {
            if (winWinList[i].key == ky && !winWinList[i].win.isClosed()) {
                winWinList[i].win.fixSize(false);  //可能有拖动，更新大小即可
            }
        }
    };
    this.ResetHeight = function() {  //此方法在具体页面中调用 JBFrameHelper.ResetHeight();
        var height = $(document).height();
        //if (height < 400) { height = 400; }
        var h = $(window.frameElement).height();
        if (h != height && (h > height + 30 || h < height)) {
            $(window.frameElement).attr("height", height + 5);
            try {
                top.JBFrameHelper.iframeHeightUpdate(window.frameElement.id); //回调（以便更新模拟窗口大小）
            } catch (e) { }
        }
        setTimeout(JBFrameHelper.ResetHeight, 1000);
    };
    this.iframeClosed = function() {
        var n = winWinList.length + 0;
        for (var i = 0; i < n; i++) {
            var w = winWinList.shift();
            if (w.win.isClosed()) {
                try { w.closeCallback(); } catch (e) { }
                if (w.reloadParent > 0) {
                    _this.reloadPageByFrameId(w.parentKey);
                }
            } else winWinList.push(w);
        }
    };
    var showWin = function(obj, opt, key, url, parentKey, reloadParentAfterClosed, closeCallback) {
        opt = opt || {};
        opt.width = JB.undef(opt.width || opt.w, 200);
        opt.modal = JB.undef(opt.modal, true);
        if (opt.pos == null) opt.pos = { to: "win", parkInside: "center" };
        opt.afterClose = top.JBFrameHelper.iframeClosed;
        parentKey = parentKey || _this.frameKey;
        reloadParentAfterClosed = JB.undef(reloadParentAfterClosed, false);
        var oo = { win: new JBodyDialog(), key: key, url: url, parentKey: parentKey, reloadParent: reloadParentAfterClosed ? 1 : 0, closeCallback: closeCallback || function() { } };
        winWinList.push(oo);
        oo.win.show(opt.obj || null, obj, opt);
    }
    this.showPage = function(url, opt, loadedFixHeight, reloadParentAfterClosed, closeCallback, parentKey) {
        if (self != top) {
            top.JBFrameHelper.showPage(url, opt, loadedFixHeight, reloadParentAfterClosed, closeCallback, parentKey || _this.frameKey);
            return;
        }
        if (!url || url == "") return;
        opt = opt || {};
        var w = opt.w || opt.width || 200;
        var h = opt.h || opt.height || 100;
        opt.padding = opt.padding || 0;
        loadedFixHeight = JB.undef(loadedFixHeight, true);
        var scrll = (opt.scroll || "auto");  //no
        var key = MD5_32(url);
        url += (url.indexOf("?") >= 0 ? "&" : "?") + (loadedFixHeight ? "" : "unResizeIframe=" + loadedFixHeight);
        var ifrm = "<div><div style='position:relative; width:1px; height:1px;'><div style='position:absolute;width:" + w + "px; height:" + h + "px;'><img src='/images/common/loading/5.gif' /></div></div>";
        ifrm += "<iframe onload='JBFrameHelper.pageloaded(this);' src=\"" + url + "\" id=\"" + key + "\" scrolling=\"" + scrll + "\" width=\"" + w + "px\" height=\"" + h + "\" frameborder=\"0\" allowtransparency=\"false\"></iframe>";
        ifrm += "</div>";
        showWin(ifrm, opt, key, url, parentKey || _this.frameKey, reloadParentAfterClosed, closeCallback);
    }
    this.pageloaded = function (ifr) {
        ifr.parentNode.getElementsByTagName("DIV")[0].style.display = "none";
    }
    return _this;
}
var JBFrameHelper = new JBFrameHelper();

function JBodyInputAjaxValidator(options) {  //需要用到AJAX的输入检查
    var _this = this;
    options = options || {};
    var _url = options.url || JB.getLocalUrl(true);
    var _data = options.data || {};                     //附件参数
    _data.cmd = _data.cmd || options.cmd || "";
    var _cache = JB.defaultBool(options.cache, false);  //是否使用缓存
    var _async = JB.defaultBool(options.async, true);   //是否异步
    var _debug = JB.defaultBool(options.debug, false);   //是否调试
    var _defaultSuccess = JB.defaultBool(options.defaultSuccess, false);   //是否默认检查成功（当网络检查超时或者网络检查出错时）
    var _loadingMsgObj = options.loadingMsgObj || null;  //
    var _msgObj = options.msgObj || null;  //
    var _msgChecking = options.msgChecking || "检测中......";
    var _msgFalse = options.msgFalse || "不可用，请输入另一个值";
    var _before = options.before || function () { return true; };
    var _complete = options.before || function () { };   //检查完的操作
    var _beforeSend = function () {
        if (_before() === false) return false;
        if (_loadingMsgObj) JB.display(_loadingMsgObj, '');
        if (_msgObj) JB.display(_msgObj, 'none');
        return true;
    }
    var _afterSend = function () {
        if (_loadingMsgObj) JB.display(_loadingMsgObj, 'none');
        if (_msgObj) JB.display(_msgObj, '');
        _complete();
    }
    var _lastValue = null;
    var _checkResult = (options.defaultResult === false || options.defaultResult === -1) ? -1 : 1;   //0：检查中， 1成功， -1失败  默认成功
    this.check = function (jbv) {
        if (_debug) alert(_checkResult);
        if (_checkResult == 0) {
            jbv.msg = _msgChecking;
            return false;
        }
        else if (_checkResult < 0) {
            jbv.msg = _msgFalse;
            return false;
        }
        return true;
    }
    this.onchange = function (elm) {
        var v = JBInputInnerTips.val(elm);
        if (v == "") {
            JBValidatorContainer.check(elm);
            return;
        }
        _lastValue = v;
        _checkResult = 0;
        _data.v = v;
        JB.ajax.get({
            url: _url,
            data: _data,
            callback: function (xmlHttpObj) {
                if (_debug) alert(xmlHttpObj.responseText);
                try {
                    var v = eval("(" + xmlHttpObj.responseText + ")");
                    _checkResult = (v.status || v.success) ? 1 : -1;
                    _msgFalse = v.msg || _msgFalse || "不可用，请输入另一个值";
                } catch (e) {
                    _checkResult = _defaultSuccess ? 1 : -1;
                }
                JBValidatorContainer.check(elm);
            },
            cache: _cache,
            async: _async,
            debug: _debug,
            before: _beforeSend,
            complete: _afterSend
        });
    }
}
var JBodyIdentInputValidator = JBodyInputAjaxValidator;  //兼容改名之前的代码（以后将被取消）

function JBodyInputResetor(options) {  //支持页面表单项部分重置（对于初始化后变更的内容无法重置）
    var _this = this;
    var opt = {};
    this.callback = function () { };
    var objArray = new Array();
    this.initOption = function (optn) {
        opt = optn || {};
        opt.autoCloseMsg = (opt.autoCloseMsg === true);
        opt.objs = opt.objs || document.body || document;
        if (!JB.isArray(opt.objs)) opt.objs = [opt.objs];
        _this.callback = opt.callback || function () { };
    }
    if (options) _this.initOption(options);
    var initObj = function (obj) {
        if (!obj || !obj.tagName) return;
        if (",INPUT,SELECT,TEXTAREA,".indexOf(obj.tagName.toUpperCase()) > 0) {
            var tagName = obj.tagName.toUpperCase();
            var tp = (tagName == "INPUT") ? JB.type : "";
            var checked = (tp == "RADIO" || tp == "CHECKBOX") ? obj.checked : null;
            var value = (tp == "RADIO" || tp == "CHECKBOX") ? null : JBInputInnerTips.val(obj);
            objArray.push({
                obj: obj,
                tag : tagName,
                checked:checked,
                value: value
            });
        } else {
            var chlds = obj.getElementsByTagName("INPUT");
            for (var i = 0; i < chlds.length; i++) initObj(chlds[i]);
            chlds = obj.getElementsByTagName("SELECT");
            for (var i = 0; i < chlds.length; i++) initObj(chlds[i]);
            chlds = obj.getElementsByTagName("TEXTAREA");
            for (var i = 0; i < chlds.length; i++) initObj(chlds[i]);
        }
    }
    this.reset = function () {
        for (var i = 0; i < objArray.length; i++) {
            if (objArray[i].checked !== null) {
                objArray[i].obj.checked = objArray[i].checked;
            }
            else if (JBInputInnerTips.val(objArray[i].obj) != objArray[i].value) {
                //alert(objArray[i].tag + ":" + JBInputInnerTips.val(objArray[i].obj) + ",<>," + objArray[i].value);
                objArray[i].obj.value = objArray[i].value;
                JB.fireEvent(objArray[i].obj, 'change');
            }
        }
        _this.callback(opt.objs);
        if (opt.autoCloseMsg) for (var i = 0; i < opt.objs.length; i++) if (JBValidatorContainer) JBValidatorContainer.closeMsg(opt.objs[i]);
    }
    this.save = function (options) {
        while (objArray.length > 0) objArray.pop();
        if (options) _this.initOption(options);
        if (opt.objs) for (var i = 0; i < opt.objs.length; i++) initObj(opt.objs[i]);
    }
    this.save();
}