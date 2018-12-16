
//调用方式一：
//<div style="width:10px; height:10px;" onclick="twoDateCalendar.show(this,'cbcb')"></div>
//其中'cbcb'为回调方法的名称

//调用方式二：
//twoDateCalendar.show(null,function(v){});
//
function TowDateCalendar() {
    var _this = this;
    var _dialog = new JBodyDialog();
    var _calendar = new JBodyCalendar();
    var _calendar2 = new JBodyCalendar();
    var _options = {};
    var JB = JBody;
    var _container = JB.newObj("DIV", { w: 370, h: 230, type: "text" });
    var _div1 = JB.newObj("DIV", { w: 180, h: 200, f: "left" });
    var _div2 = JB.newObj("DIV", { w: 180, h: 200, f: "left" , css: ["marginLeft", "10px"] });
    var _ip1 = JB.newObj("INPUT", { type: "text", readonly: true, w: 70, f: "right" });
    var _span1 = JB.newObj("SPAN", { w: 20, html: "至", f: "right" });
    var _ip2 = JB.newObj("INPUT", { type: "text", readonly: true, w: 70, f: "right", css: ["marginLeft", "5px"] });
    var _btCancel = JB.newObj("INPUT", { type: "button", value: "取消", w: 45, f: "right", css: ["marginLeft", "5px"] });
    var _btSubmit = JB.newObj("INPUT", { type: "button", value: "确认", w: 45, f: "right", css: ["marginLeft", "5px"] });
    _container.appendChild(_div1);
    _container.appendChild(_div2);
    _container.appendChild(_btCancel);
    _container.appendChild(_btSubmit);
    _container.appendChild(_ip2);
    _container.appendChild(_span1);
    _container.appendChild(_ip1);
    var _checkTime = function() {
        if (_ip1.value != "" && _ip2.value != "") {
            if (JB.parseDateTime(_ip1.value, "yyyy-MM-dd") > JB.parseDateTime(_ip2.value, "yyyy-MM-dd")) {
                _ip2.value = _ip1.value;
            }
        }
    };
    var _clickObjFun = function(e) {
        e = window.event || e;
        var src = e.srcElement || e.target;
        if (src == null) return;
        if (src == _btCancel) _dialog.close();
        if (src == _btSubmit) {
            var v = { d1: JB.trim(_ip1.value), d2: JB.trim(_ip2.value), parm: _this.parms };
            if (v.d1 != "" || v.d2 != "") _this.callback(v);
            _dialog.close();
        }
    }
    var _startDateChange = function (d) {
        if (d) _ip1.value = JB.dateTimeToString(d, 'yyyy-MM-dd');
        var opt = { isStart: false, showBetweenStyle: true, min: _options.min, max: _options.max };
        if (_ip2.value != "") opt.current = _ip2.value;
        if (d && d != "") opt.other = _ip1.value;
        if (d && d != "") opt.min = _ip1.value;
        _calendar2.show(_div2, opt, _endDateChange);
    }
    var _endDateChange = function (d) {
        if (d) _ip2.value = JB.dateTimeToString(d, 'yyyy-MM-dd');
        var opt = { isStart: true, showBetweenStyle: true, min: _options.min, max: _options.max };
        if (_ip1.value != "") opt.current = _ip1.value;
        if (d && d != "") opt.other = _ip2.value;
        if (d && d != "") opt.max = _ip2.value;
        _calendar.show(_div1, opt, _startDateChange);
    }
    JB.attach(_btCancel, "click", _clickObjFun);
    JB.attach(_btSubmit, "click", _clickObjFun);  
    this.callback = function() { };
    this.parms = null;
    this.show = function (elm, cbFunc, parm, options) {  //elm, cbFunc, parm, options:{start:当前开始日,end:当前结尾日,min,max,winOpt}
        this.parms = parm;
        _options = options || {};
        _options.min = _options.min || null;
        _options.max = _options.max || null;
        _options.start = _options.start || "";
        _options.end = _options.end || "";
        _this.callback = cbFunc || function() { };
        if (typeof (_this.callback) == "string") {
            if (_this.callback.indexOf("(") >= 0) _this.callback = function() { eval(cbFunc); }
            else _this.callback = function(v) { eval(cbFunc + "({d1:\"" + v.d1 + "\",d2:\"" + v.d2 + "\",parm:\"" + _this.parms + "\"})"); }
        }
        _startDateChange(_options.start);
        _endDateChange(_options.end);
        var pos = [{ to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft" }, { to: "obj", parent: "doc", park: "outside", parkOutside: "topLeft" }];
        if (!elm) pos = [{ to: "win", parent: "doc", park: "inside", parkInside: "center" }];
        var winOpt = _options.winOpt || {};
        winOpt.pos = winOpt.pos || pos;
        winOpt.w = 380;
        winOpt.hideOverfloat = false;
        winOpt.title = winOpt.title || "设置起止日期";
        _dialog.show(elm, _container, winOpt);
    }
}
var twoDateCalendar = new TowDateCalendar();