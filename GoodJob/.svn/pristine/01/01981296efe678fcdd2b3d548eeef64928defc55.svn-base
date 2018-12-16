

function rotateFadein(objs) {
    var _this = this;
    var _objs = objs;
    var _parent = objs[0].parentNode;
    var _lastIdx = -1;
    var _crrnIdx = 0;
    var _waitingIdx = -1;
    var _crrnData = 0;
    var _lock = false; //并发锁
    var _timeoutObj = null;
    var _showStep = function() {
        if (_waitingIdx >= 0) {
            //解除锁
            _lock = false;
            return;
        }
        if (_crrnData >= 100) {  //结束
            _lock = false;
        } else {
            _crrnData = Math.min(_crrnData + 5, 100);
            JB.opacity(_objs[_crrnIdx], _crrnData);
            JB.opacity(_objs[_lastIdx], 100 - _crrnData + 0);
            _timeoutObj = setTimeout(_showStep, 50);
            //if (_crrnData == 80) alert(_crrnIdx + "," + _lastIdx);
            //alert(_crrnData);
        }
    }
    var _reqLockObj = null;
    var _reqLock = function() {
        if (_lock) {
            if (_reqLockObj != null) clearTimeout(_reqLockObj);
            _reqLockObj = setTimeout(_reqLock, 200);
        } else {  //锁已释放
            _lock = true;
            if (_lastIdx == _waitingIdx && _crrnData < 50) {  //回退
                JB.opacity(_objs[_crrnIdx], 0);
                _crrnIdx = _lastIdx;
                _lastIdx = -1;
                _lock = false;
            } else {
                JB.opacity(_objs[_crrnIdx], 100);
                JB.opacity(_objs[_waitingIdx], 0);
                JB.setOpt(_objs[_waitingIdx], { l: 0, t: 0 });
                //if (_waitingIdx >= 0) JB.css(_objs[_waitingIdx], "zIndex", "4");
                //JB.css(_objs[_crrnIdx], "zIndex", "3");
                //if (_lastIdx >= 0) JB.css(_objs[_lastIdx], "zIndex", "2");
                //for (var i = 0; i < _objs.length; i++) {
                //    if (i == _waitingIdx || i == _crrnIdx || i == _lastIdx) continue;
                //    JB.css(_objs[i], "zIndex", "1");
                //}
                _lastIdx = _crrnIdx;
                _crrnIdx = _waitingIdx;
                _waitingIdx = -1;
                _crrnData = 0;
                try { _parent.removeChild(_objs[_crrnIdx]); } catch (e) { }
                _parent.appendChild(_objs[_crrnIdx]);
                _showStep();
            }
        }
    }
    this.show = function(idx) {
        if (_waitingIdx == idx || (_waitingIdx < 0 && _crrnIdx == idx)) return;
        _waitingIdx = idx;
        _reqLock();  //申请锁
    }
}

function rotateDrag(objs, opt) {
    //opt{w,h,direct}
    var _this = this;
    var _objs = objs;
    var _parent = objs[0].parentNode;
    var _w = opt.w;
    var _h = opt.h;
    var _dir = { L: opt.direct == "left", T: opt.direct == "top", R: opt.direct == "right", B: opt.direct == "bottom", LR: false, LT: false };
    if (!(_dir.L || _dir.R || _dir.T || _dir.B)) _dir.T = true;
    _dir.LR = (_dir.L || _dir.R);
    _dir.LT = (_dir.L || _dir.T);
    var _step = parseInt(_h / 15);
    
    var _lastIdx = -1;
    var _crrnIdx = 0;
    var _waitingIdx = -1;
    var _crrnData = 0;
    var _lock = false; //并发锁
    var _timeoutObj = null;
    var _showStep = function() {
        if (_waitingIdx >= 0) {
            //解除锁
            _lock = false;
            return;
        }
        if (_crrnData >= (_dir.LR ? _w : _h)) {  //结束
            _lock = false;
        } else {
            _crrnData = Math.min(_crrnData + _step, (_dir.LR ? _w : _h));
            var _dd = _dir.LR ? (_w - _crrnData) : (_h - _crrnData);
            if (_dir.LT) _dd = -_dd;
            JB.css(_objs[_crrnIdx], _dir.LR ? "left" : "top", _dd + "px");
            _timeoutObj = setTimeout(_showStep, 30);
        }
    }
    var _reqLockObj = null;
    var _reqLock = function() {
        if (_lock) {
            if (_reqLockObj != null) clearTimeout(_reqLockObj);
            _reqLockObj = setTimeout(_reqLock, 200);
        } else {  //锁已释放
            _lock = true;
            if (_lastIdx == _waitingIdx && (_crrnData * 100 / (_dir.LR ? _w : _h)) < 50) {  //回退
                JB.setOpt(_objs[_crrnIdx], { l: _w, t: _h });
                _crrnIdx = _lastIdx;
                _lastIdx = -1;
                _lock = false;
            } else {
                JB.setOpt(_objs[_crrnIdx], { l: 0, t: 0 });
                JB.setOpt(_objs[_waitingIdx], _dir.T ? { l: 0, t: -_h} :
                    _dir.L ? { l: -_w, t: 0} :
                    _dir.B ? { l: 0, t: _h} : { l: _w, t: 0 });
                _lastIdx = _crrnIdx;
                _crrnIdx = _waitingIdx;
                _waitingIdx = -1;
                _crrnData = 0;
                try { _parent.removeChild(_objs[_crrnIdx]); } catch (e) { }
                _parent.appendChild(_objs[_crrnIdx]);
                _showStep();
            }
        }
    }
    this.show = function(idx) {
        if (_waitingIdx == idx || (_waitingIdx < 0 && _crrnIdx == idx)) return;
        _waitingIdx = idx;
        _reqLock();  //申请锁
    }
}

function rotatePush(objs, opt) {
    //opt{w,h,direct}
    var _this = this;
    var _objs = objs;
    var _parent = objs[0].parentNode;
    var _w = opt.w;
    var _h = opt.h;
    var _dir = { L: opt.direct == "left", T: opt.direct == "top", R: opt.direct == "right", B: opt.direct == "bottom", LR: false, LT: false };
    if (!(_dir.L || _dir.R || _dir.T || _dir.B)) _dir.T = true;
    _dir.LR = (_dir.L || _dir.R);
    _dir.LT = (_dir.L || _dir.T);
    var _step = parseInt(_h / 15);

    var _lastIdx = -1;
    var _crrnIdx = 0;
    var _waitingIdx = -1;
    var _crrnData = 0;
    var _lock = false; //并发锁
    var _timeoutObj = null;
    var _showStep = function() {
        if (_waitingIdx >= 0) {
            //解除锁
            _lock = false;
            return;
        }
        if (_crrnData >= (_dir.LR ? _w : _h)) {  //结束
            _lock = false;
        } else {
            _crrnData = Math.min(_crrnData + _step, (_dir.LR ? _w : _h));
            var _dd = _dir.LR ? (_w - _crrnData) : (_h - _crrnData);
            if (_dir.LT) _dd = -_dd;
            var _dd2 = (_dir.LT) ? _crrnData : -_crrnData;
            JB.css(_objs[_crrnIdx], _dir.LR ? "left" : "top", _dd + "px");
            JB.css(_objs[_lastIdx], _dir.LR ? "left" : "top", _dd2 + "px");
            _timeoutObj = setTimeout(_showStep, 30);
        }
    }
    var _reqLockObj = null;
    var _reqLock = function() {
        if (_lock) {
            if (_reqLockObj != null) clearTimeout(_reqLockObj);
            _reqLockObj = setTimeout(_reqLock, 200);
        } else {  //锁已释放
            _lock = true;
            if (_lastIdx == _waitingIdx && (_crrnData * 100 / (_dir.LR ? _w : _h)) < 50) {  //回退
                JB.setOpt(_objs[_crrnIdx], { l: _w, t: _h });
                JB.setOpt(_objs[_lastIdx], { l: 0, t: 0 });
                _crrnIdx = _lastIdx;
                _lastIdx = -1;
                _lock = false;
            } else {
                JB.setOpt(_objs[_crrnIdx], { l: 0, t: 0 });
                JB.setOpt(_objs[_waitingIdx], _dir.T ? { l: 0, t: -_h} :
                    _dir.L ? { l: -_w, t: 0} :
                    _dir.B ? { l: 0, t: _h} : { l: _w, t: 0 });
                _lastIdx = _crrnIdx;
                _crrnIdx = _waitingIdx;
                _waitingIdx = -1;
                _crrnData = 0;
                try { _parent.removeChild(_objs[_crrnIdx]); } catch (e) { }
                _parent.appendChild(_objs[_crrnIdx]);
                _showStep();
            }
        }
    }
    this.show = function(idx) {
        if (_waitingIdx == idx || (_waitingIdx < 0 && _crrnIdx == idx)) return;
        _waitingIdx = idx;
        _reqLock();  //申请锁
    }
}


function rotatePushlink(objs, opt) {
    var _this = this;
    var _objs = objs;
    var _parent = objs[0].parentNode;
    var _w = opt.w;
    var _h = opt.h;
    var _dir = { L: opt.direct == "left", T: opt.direct == "top", R: opt.direct == "right", B: opt.direct == "bottom", LR: false, LT: false };
    if (!(_dir.L || _dir.R || _dir.T || _dir.B)) _dir.T = true;
    _dir.LR = (_dir.L || _dir.R);
    _dir.LT = (_dir.L || _dir.T);
    var _step = parseInt(_h / 15);

    var _lastIdx = -1;
    var _crrnIdx = 0;
    var _waitingIdx = -1;
    var _crrnData = 0;
    var _lock = false; //并发锁
    var _timeoutObj = null;
    var _showStep = function() {

        if (_crrnData == 0) _crrnData = 1;
        else _crrnData = _crrnData * 2; //加速
        var curOffset = (_dir.LR) ? parseInt(_parent.style.left.replace('px', '')) : parseInt(_parent.style.top.replace('px', ''));
        if (isNaN(curOffset)) curOffset = 0;
        var distance = (_dir.LR ? _w : _h) * _crrnIdx + curOffset;  //需向上或向左为正，需向下或向右为负
        if (_crrnData > Math.abs(distance)) _crrnData = Math.abs(distance);
        if (_waitingIdx >= 0) {
            //解除锁
            _lock = false;
            return;
        }

        if (distance == 0) {  //结束
            _lock = false;
            return;
        }
        else if (distance > 0) JB.css(_parent, _dir.LR ? "left" : "top", (curOffset - _crrnData) + "px");
        else JB.css(_parent, _dir.LR ? "left" : "top", (curOffset + _crrnData) + "px");
        _timeoutObj = setTimeout(_showStep, 30);
    }
    var _reqLockObj = null;
    var _reqLock = function() {
        if (_lock) {
            if (_reqLockObj != null) clearTimeout(_reqLockObj);
            _reqLockObj = setTimeout(_reqLock, 200);
        } else {  //锁已释放
            _lock = true;
            _lastIdx = _crrnIdx;
            _crrnIdx = _waitingIdx;
            _waitingIdx = -1;
            _crrnData = 0;
            try { _parent.removeChild(_objs[_crrnIdx]); } catch (e) { }
            _parent.appendChild(_objs[_crrnIdx]);
            _showStep();
        }
    }
    this.show = function(idx) {
        if (_waitingIdx == idx || (_waitingIdx < 0 && _crrnIdx == idx)) return;
        _waitingIdx = idx;
        _reqLock();  //申请锁
    }
}


function rotateAdvertise(adObj, opt) {
    //adObj的样式要求（position=relative，overflow=hidden）
    var _this = this;
    var _adObj = adObj;
    opt = opt || {};
    var _action = opt.action || "linkpush"; //simple,fadein,drag,push,linkpush
    if (!(",simple,fadein,drag,push,linkpush,".indexOf(',' + _action + ',') >= 0)) _action = "linkpush";
    var _actionFrom = opt.action || "right";   //top,left,bottom,right
    if (!(",top,left,bottom,right,".indexOf(',' + _actionFrom + ',') >= 0)) _actionFrom = "right";
    var _directLR = (_actionFrom == "left" || _actionFrom == "right");
    var _callback = opt.callback || function(msg) { return; };

    if (!_adObj || _adObj.children.length == 0) return;
    var _w = adObj.clientWidth || adObj.offsetWidth;
    var _h = adObj.clientHeight || adObj.offsetHeight;

    JB.setOpt(adObj, { css: [["position", "relative"], ["zIndex", "3"]] });
    JB.setOpt(adObj, { css: [["overflow", "hidden"]] });
    var _obj = _adObj.children[0];
    JB.css(_obj, "position", "relative");
    //JB.css(_obj, "width", (_w * _obj.children.length) + "px");
    //JB.css(_obj, "height", (_h * _obj.children.length) + "px");
    JB.css(_obj, "zIndex", "1");

    var _objs = [];
    for (var i = 0; i < _obj.children.length; i++) {
        JB.setOpt(_obj.children[i], { css: [["float", "none"], ["position", "absolute"], ["zIndex", "1"]] });
        JB.css(_obj.children[i], "left", _directLR ? ((i * _w) + "px") : "0px");
        JB.css(_obj.children[i], "top", _directLR ? "0px" : ((i * _h) + "px"));
        _objs.push(_obj.children[i]);
    }
    //for (var i = 0; i < _objs.length; i++) _obj.removeChild(_objs[i]);
    if (_objs.length == 0) return;

    var _hold = false;   //外部控制
    var _hold2 = false;  //执行中
    var _hold3 = false;  //鼠标悬停控制

    this.hold = function(v) { _hold = (v === false) ? false : true; }
    var _setHold3 = function() { _hold3 = true; }
    var _cancelHold3 = function() { _hold3 = false; }
    JB.attach(adObj, "mouseover", _setHold3);
    JB.attach(adObj, "mouseout", _cancelHold3);

    var _speed = 5000;
    var _speed2 = 300;
    var _msStep = 20;

    var _crrntIdx = 0;

    var _show_simple = function(idx) {  //simple,fadein,drag,push,linkpush
        if (_crrntIdx == idx) return;
        JB.setOpt(_objs[idx], { l: 0, t: 0 });
        JB.setOpt(_objs[_crrntIdx], { l: _w, t: _h });
        _crrntIdx = idx;
    }
    var _rotateBase = null;
    if (_action == "push") _rotateBase = new rotatePush(_objs, { w: _w, h: _h, direct: _actionFrom });
    if (_action == "linkpush") _rotateBase = new rotatePushlink(_objs, { w: _w, h: _h, direct: _actionFrom });
    if (_action == "drag") _rotateBase = new rotateDrag(_objs, { w: _w, h: _h, direct: _actionFrom });
    if (_action == "fadein") _rotateBase = new rotateFadein(_objs);

    this.show = function(idx) {
        if (_objs.length <= 1 || idx < 0) return;
        idx = (idx % _objs.length);
        _hold2 = true;
        _callback(idx);
        if (_action == "simple") _show_simple(idx);
        else {
            _crrntIdx = idx;
            _rotateBase.show(idx);
        }
    }
    var _rotate = function() {
        if (!_hold && !_hold2 && !_hold3 && _objs.length > 1) _this.show((_crrntIdx + 1) % _objs.length, _act);
        if (_objs.length > 1) setTimeout(_rotate, _speed);
    }
    if (opt.rotate === true) _rotate();
    return _this;
}




function adTitleCreator(tobj, opt) {
    var _this = this;
    var _obj = tobj;   
    if (!_obj || _obj.children.length == 0 || _obj.children[0].children.length < 2) return;
    _obj = _obj.children[0];
    if (_debug) alert(_obj);
    var _hold = false;
    var _hold2 = false;
    var _hold3 = false;
    if (!opt) opt = {};
    var _offset = opt.offset || 0;
    var _fixtarsize = (opt.fixtarsize == true);
    var _speedPower = opt.speedPower || 2; //加速度    
    var _callback = opt.callback || function(msg) { return; };
    var _defaultIndex = opt.index || 0;
    var _defaultText = opt.text || "";  //比_defaultText优先
    var _delayShow = (opt.delayShow == false) ? 0 : opt.delayShow > 0 ? opt.delayShow : 300;   //延迟反应
    var _outreset = (opt.outreset == true);
    var _tarTagName = opt.tarTagName || "DIV";
    var _itemTagName = opt.itemTagName || "A";   //如果TAR与ITEM标签名相同，则TAR应为第一个元素
    var _debug = opt.debug || false;
    
    var _crrntIdx = 0;
    var _pos = [];  //高或宽组成的数组
    var _objs = [];
    var _tar = opt.tar;
    this.showDefault = function() {
        if (_hold3 === false) _this.show(_defaultIndex);
    }
    var _mouseoverIdx = -1;
    var _mouseoverTimeoutObj = null;
    var _mouseoverDelayAction = function() {
        if (_mouseoverIdx >= 0) _this.show(_mouseoverIdx);
    }
    var _mouseover = function(e) {
        var aObj = JB.getEventSrc(e);
        if (!aObj) return;
        _hold3 = true;
        for (var i = 0; i < _objs.length; i++) {
            if (_objs[i] == aObj) {
                if (_delayShow > 0) {
                    _mouseoverIdx = i;
                    _mouseoverTimeoutObj = setTimeout(_mouseoverDelayAction, _delayShow); //延迟执行，以免鼠标无意移过时跳动
                } else _this.show(i);
            }
        }
    }
    var _mouseout = function(e) {
        _hold3 = false;
        if (_mouseoverTimeoutObj != null) clearTimeout(_mouseoverTimeoutObj);
        _mouseoverIdx = -1;
        if (_outreset) setTimeout(_this.showDefault, 100);
    }

    for (var i = 0; i < _obj.children.length; i++) {
        if (_obj.children[i] && _obj.children[i].tagName == _tarTagName && !_tar) {
            if (!_tar) _tar = _obj.children[i];
        } else if (_obj.children[i] && _obj.children[i].tagName == _itemTagName) {
            if (_defaultText!='' && $(_obj.children[i]).text() == _defaultText) _defaultIndex = _objs.length;
            _objs.push(_obj.children[i]);
            var whs = _obj.children[i].offsetWidth;
            var offs = (_pos.length == 0) ? 0 : (_pos[_pos.length - 1].whs + _pos[_pos.length - 1].offs);
            _pos.push({ whs: whs, offs: offs });
            JB.attach(_obj.children[i], "mouseover", _mouseover);
            JB.attach(_obj.children[i], "mouseout", _mouseout);
        }
    }
    if (_tar) JB.css(_tar, "left", "0px");

    var _speed = opt.rotateSpeed || 2000;
    var _speed2 = 500;
    var _msStep = 30;
    this.hold = function(v) {
        _hold = (v === false) ? false : true;
    }
    var _lastOffset = 0;
    var _showSpeedTimeOut = null;
    var _showSpeed = function() {
        if (_lastOffset == 0) _lastOffset = 1;
        else _lastOffset = _lastOffset * _speedPower; //加速
        var curOffset = parseInt(_tar.style.left.replace('px', ''));
        if (isNaN(curOffset)) {
            curOffset = 0;
        }
        var distance = curOffset - _pos[_crrntIdx].offs + _offset;  //需向左为正，需向右为负
        if (_lastOffset > Math.abs(distance)) _lastOffset = Math.abs(distance);
        if (distance == 0) {
            _hold2 = false;
            if (_fixtarsize) _tar.children[0].style.width = _pos[_crrntIdx].whs + "px";
            return;
        }
        else if (distance > 0) _tar.style.left = (curOffset - _lastOffset) + "px";
        else _tar.style.left = (curOffset + _lastOffset) + "px";

        if (_showSpeedTimeOut != null) clearTimeout(_showSpeedTimeOut);
        _showSpeedTimeOut = setTimeout(_showSpeed, _msStep);
    }
    this.show = function(idx) {
        if (_objs.length <= 1 || idx < 0) return;
        idx = (idx % _objs.length);
        _crrntIdx = idx;
        //_hold2 = true;
        _callback(_crrntIdx, _objs);
        if (_tar) {
            _hold2 = true;
            _showSpeed();
        }
    }
    this.rotate = function() {
        //if (_debug) alert("rotate：" + _hold + "," + _hold2 + "," + _hold3 + ",");
        if (!_hold && !_hold2 && !_hold3 && _objs.length > 1) _this.show((_crrntIdx + 1) % _objs.length);
        if (_objs.length > 1) setTimeout(_this.rotate, _speed);
    }
    if (_debug) alert("debug:opt.rotate：" + opt.rotate);
    _this.showDefault();
    if (opt.rotate === true) setTimeout(_this.rotate, _speed);
    return _this;
}

function JBodyDetailShower(obj, opt) {
    //opt{ title,htm, titleH,titleFontSize,bgopacity,bgcolor }
    var _this = this;
    if (typeof (obj) === "string") obj = document.getElementById(obj);
    if (!obj) return;
    opt = opt || {};
    var _bg = null;
    var _htm = null;
    var _title = null;
    var _titleH = opt.titleH || Math.max(20, parseInt(obj.clientHeight / 10));
    var _titleFontSize = opt.titleFontSize;
    if (!_titleFontSize || isNaN(parseInt(_titleFontSize))) _titleFontSize = _titleH > 45 ? 18 : _titleH > 35 ? 16 : _titleH > 28 ? 14 : 12;

    var _bgopacity = opt.bgopacity || 100;
    var _bgcolor = opt.bgcolor;

    var _randColor = function() {
        var randCl = function() {
            var cs = "0123456789ABCDEF";
            return cs.substr(parseInt(Math.random() * 16), 1);
        }
        var cs = "0123456789ABCDEF";
        var v = [randCl() + randCl(), randCl() + randCl(), randCl() + randCl()];
        if (Math.random() < 0.3) v[0] = "00";
        else if (Math.random() < 0.5) v[1] = "00";
        else v[2] = "00";
        return "#" + v[0] + v[1] + v[2];
    }
    if (!_bgcolor) _bgcolor = _randColor();
    if (opt.title) {
        _title = JB.newObj("DIV", { w: obj.clientWidth, h: _titleH, css: [["position", "relative"], ["zIndex", "1"]] });
        obj.appendChild(_title);
        var oa = JB.getAbsoluteOffset(obj);
        var ob = JB.getAbsoluteOffset(_title);
        if ((ob.t + _titleH) != (oa.t + obj.offsetHeight)) JB.css(_title, "top", (oa.t - ob.t + obj.offsetHeight - _titleH) + "px");
        var ttBg = JB.newObj("DIV", { w: obj.clientWidth, h: _titleH, css: [["position", "absolute"], ["zIndex", "1"], ["left", "0px"], ["top", "0px"], ["backgroundColor", "#000000"]] });
        JB.opacity(ttBg, 30);
        _title.appendChild(ttBg);
        var tt = JB.newObj("DIV", { w: obj.clientWidth, h: _titleH, htm: opt.title, css: [["position", "absolute"], ["zIndex", "1"], ["left", "0px"], ["top", "0px"], ["color", "#ffffff"], ["textAlign", "center"], ["lineHeight", _titleH + "px"], ["fontSize", _titleFontSize + "px"]] });
        _title.appendChild(tt);
    }
    if (opt.htm) {
        _htm = JB.newObj("DIV", { w: obj.clientWidth, h: 0, css: [["position", "relative"], ["zIndex", "1"], ["overflow", "hidden"], ["left", "0px"], ["top", obj.clientHeight + (_title == null ? 0 : -_titleH) + "px"]] });
        var htmBg = JB.newObj("DIV", { w: obj.clientWidth, h: obj.clientHeight, css: [["position", "absolute"], ["zIndex", "1"], ["overflow", "hidden"], ["left", "0px"], ["top", "0px"], ["backgroundColor", _bgcolor]] });
        if (_bgopacity > 0 && _bgopacity < 100) JB.opacity(htmBg, _bgopacity);
        _htm.appendChild(htmBg);
        var htm = JB.newObj("DIV", { w: obj.clientWidth, h: obj.clientHeight, htm: opt.htm, css: [["position", "absolute"], ["zIndex", "1"], ["overflow", "hidden"], ["left", "0px"], ["top", "0px"], ["color", "#ffffff"]] });
        _htm.appendChild(htm);
        obj.appendChild(_htm);
    }
    var _msover = false;
    var _h = obj.clientHeight;
    var _step = parseInt(obj.clientHeight / 15);
    var _doStepTimeOut = null;
    var _doStep = function() {
        if (_msover) {
            if (_htm.clientHeight >= _h) return;
            JB.setOpt(_htm, { h: Math.min(_h, _htm.clientHeight + _step) });
        } else {
            if (_htm.clientHeight <= 0) return;
            JB.setOpt(_htm, { h: Math.max(0, _htm.clientHeight - _step) });
        }
        JB.css(_htm, "top", (JB.IE ? -2 : 0) - (_htm.clientHeight - (_title == null ? 0 : -_titleH)) + "px");
        _doStepTimeOut = setTimeout(_doStep, 30);
    }
    var _onmouseover = function() {
        if (_doStepTimeOut != null) clearTimeout(_doStepTimeOut);
        _msover = true;
        _doStepTimeOut = setTimeout(_doStep, 30);
    }
    var _onmouseout = function() {
        if (_doStepTimeOut != null) clearTimeout(_doStepTimeOut);
        _msover = false;
        _doStepTimeOut = setTimeout(_doStep, 30);
    }
    if (!_htm) return this;
    JB.attach(obj, "mouseover", _onmouseover);
    JB.attach(obj, "mouseout", _onmouseout);
    return this;
}


function rotateBanner(objId, opt) {
    var _this = this;
    opt = opt || {};
    var _picsClassName = opt.picsClassName || "pics";
    var _tagsClassName = opt.tagsClassName || "tags";
    var _itemTagName = opt.itemTagName || "SPAN";
    var blockPics = new rotateAdvertise($("#" + objId + " ." + _picsClassName).get(0), { rotate: false, outreset: false, action: "fadein" });
    var blockTitle = new adTitleCreator($("#" + objId + " ." + _tagsClassName).get(0),
        { rotate: true, rotateSpeed: 6000, outreset: false, debug: false, itemTagName: _itemTagName, callback: function(idx, objs) {
            blockPics.show(idx);
            for (var i = 0; i < objs.length; i++) objs[i].className = (i == idx ? "tt act" : "tt");
        }
        });
    return _this;
}


function IndexBlock(objId, opt) {
    var _this = this;
    opt = opt || {};
    var _picsClassName = opt.picsClassName || "pics";
    var _listSetClassName = opt.listSetClassName || "listSet";
    var _tagsClassName = opt.tagsClassName || "tags";
    var _showPics = (opt.showPics === false) ? false : true;
    var _msoverTimeout = opt.msoverTimeout || 200;
    var _push = (opt.push !== false); //是否使用动画
    var _listOnly = (opt.listOnly === true) ? true : false;
    var blockPics = null;
    if (_showPics) blockPics = new rotateAdvertise($("#" + objId + " ." + _picsClassName).get(0), { rotate: false, outreset: false });
    var blockContents = new rotateAdvertise($("#" + objId + " ." + _listSetClassName).get(0), { rotate: false, outreset: false });
    var blockTitle = new adTitleCreator($("#" + objId + " ." + _tagsClassName).get(0),
        { rotate: false, outreset: false, callback: function(idx, objs) {
            if (_showPics) blockPics.show(idx);
            blockContents.show(idx);
            for (var i = 0; i < objs.length; i++) objs[i].className = (i == idx ? "tt act" : "tt");
        }
        });
    var _maxH = $("#" + objId + " ." + _listSetClassName + " .lists .msover").first().height();
    var _minH = $("#" + objId + " ." + _listSetClassName + " .lists .msout").first().height();
    //alert(_itemMaxH + "," + _itemMinH);

    var lastOverObj = null;
    var _setClass = function() {
        $(lastOverObj).parent().find(".li").removeClass("msover").addClass("msout");
        $(lastOverObj).parent().find(".li2").removeClass("msover2").addClass("msout2");
        if ($(lastOverObj).is(".li2")) $(lastOverObj).removeClass("msout2").addClass("msover2");
        else $(lastOverObj).removeClass("msout").addClass("msover");
    }
    var showSpeedTimeoutObj = null;
    var showSpeed = function() {
        if (showSpeedTimeoutObj != null) clearTimeout(showSpeedTimeoutObj);
        showSpeedTimeoutObj = setTimeout(showSpeed, 30);
        if (!lastOverObj || $(lastOverObj).is(".msover") || $(lastOverObj).is(".msover2")) return;
        var _h = $(lastOverObj).first().height();
        var distance = _maxH - _h;
        if (distance == 0) {
            _setClass();
            $(lastOverObj).parent().find(".msout,.msout2").height(_minH);
            if (showSpeedTimeoutObj != null) clearTimeout(showSpeedTimeoutObj);
        }
        else if (distance > 0) {
            var step = Math.max(0, Math.min(8, distance));
            $(lastOverObj).first().height(_h + step);
            $(lastOverObj).parent().find("li").each(function() {
                if (this == lastOverObj) return true;
                var _h1 = $(this).height();
                var _step2 = Math.max(0, Math.min(step, _h1 - _minH));
                if (_step2 >= 0) {
                    step = step - _step2;
                    $(this).height(_h1 - _step2);
                    if (step == 0) return false;
                }
            });
        }
    }
    var timeoutObj = null;
    var mouseOver = function() {
        if (_push) showSpeed();  //动画显示
        else _setClass();
    }
    var mouseOver2 = function() {
        if (timeoutObj != null) clearTimeout(timeoutObj);
        lastOverObj = this;
        timeoutObj = setTimeout(mouseOver, _msoverTimeout);
    }
    var mouseOut = function() {
        if (lastOverObj == this) clearTimeout(timeoutObj);
    }
    if (!_listOnly) {
        $("#" + objId + " .listSet .lists .li").mouseover(mouseOver2);
        $("#" + objId + " .listSet .lists .li2").mouseover(mouseOver2);
        $("#" + objId + " .listSet .lists .li").mouseout(mouseOut);
        $("#" + objId + " .listSet .lists .li2").mouseout(mouseOut);
    } else {
        $("#" + objId + " .listSet .lists .li").removeClass("msover").addClass("msout");
        $("#" + objId + " .listSet .lists .li2").removeClass("msover2").addClass("msout2");
    }
    return _this;
}


function urlTransfer(opt) {
    if (!opt) return location.href;
    var area = JB.undef(opt.area, null);
    var area2 = JB.undef(opt.area2, null);
    var area3 = JB.undef(opt.area3, null);
    var subj = JB.undef(opt.subj, null);
    var subj2 = JB.undef(opt.subj2, null);
    var subj3 = JB.undef(opt.subj3, null);
    var act = JB.undef(opt.act, null);
    var act2 = JB.undef(opt.act2, null);
    var searchKey = JB.undef(opt.searchKey, null);
    var speKey = JB.undef(opt.speKey, null);
    var search = JB.undef(opt.search, null);
    var reg1 = /^((lvshi)|(lvsuo)|(weituo)|(zixun)|(anli)|(fa)|(zui)|(wenji)|(zhuanti)|(spe))$/;
    var reg2 = /^((weituo)|(zixun)|(anli)|(fa)|(zui)|(wenji)|(honour))$/;

    var urlspA = location.href.split("?");
    while (urlspA[0].substr(urlspA[0].length - 1, 1) == "#") urlspA[0] = urlspA[0].substr(0, urlspA[0].length - 1);
    while (urlspA[0].substr(urlspA[0].length - 1, 1) == "/") urlspA[0] = urlspA[0].substr(0, urlspA[0].length - 1);
    var urlsplit = urlspA[0].split('/');
    for (var i = 3; i < urlsplit.length; i++) {
        if (urlsplit[i] == "") continue;
        if (search === null && urlsplit[i] == "s") { search = true; continue; }
        if (act === null && reg1.test(urlsplit[i])) { act = urlsplit[i]; continue; }
        if (act2 === null && reg2.test(urlsplit[i])) { act2 = urlsplit[i]; continue; }
        var sss = urlsplit[i].split(',');
        var smch = false;
        for (var j = 0; j < sss.length; j++) {
            if (area === null && AreaContainPinyinKey(sss[j])) { area = sss[j]; smch = true; continue; }
            if (area2 === null && AreaContainPinyinKey(sss[j])) { area2 = sss[j]; smch = true; continue; }
            if (area3 === null && AreaContainPinyinKey(sss[j])) { area3 = sss[j]; smch = true; continue; }
            if (subj === null && SubjectContainPinyinKey(sss[j])) { subj = sss[j]; smch = true; continue; }
            if (subj2 === null && SubjectContainPinyinKey(sss[j])) { subj2 = sss[j]; smch = true; continue; }
            if (subj3 === null && SubjectContainPinyinKey(sss[j])) { subj3 = sss[j]; smch = true; continue; }
        }
        if (smch == false) {
            if (searchKey === null) searchKey = urlsplit[i];
            if (speKey === null && act == "spe") speKey = urlsplit[i];
        }
    }
    function parm(v) {
        if (v == null || v == "") return "";
        return "/" + v;
    }
    function parm2(v) {
        if (v == null || v == "") return "";
        return "," + v;
    }
    return urlsplit[0] + "//" + urlsplit[2] + parm(act) + parm(act2) + parm(search ? "s" : "")
        + parm(area) + parm2(area2) + parm2(area3)
        + parm(subj) + parm2(subj2) + parm2(subj3) 
        + parm(searchKey) + parm(speKey);
}

function areaDialogSelectorCreate(opt) {
    if (!opt || !opt.obj) return;
    var _this = this;
    var opt = opt;
    this.obj = opt.obj;
    var areaName = "";
    try {
        areaName = GetArea(opt.areaId || "")[0];
    } catch (e) { }
    this.callback = opt.callback || function(id, key, name) {
        //window.location.href = urlTransfer({ act2: "", area: key, area2: "", area3: "", searchKey: "", speKey: "" });
        window.location.href = "/" + key;
    };
    var colors = ["red", "red", "orange", "blue", "orange", "#336699", "#666666", "#666666", "#666666", "#666666"];
    this.itemInit = opt.itemInit || function(aary) {
    return "<a style=\"color:" + colors[aary[3]] + ";font-weight:" + ((aary[3] <= 2 && aary[3] != 1) ? "bold" : "normal") + ";\" href=\"/" + aary[5] + "\" data-id=\"" + aary[2] + "\" data-key=\"" + aary[5] + "\">" + aary[0] + "</a>";
    }
    this.selectAreaMouseover = [false, false];
    this.selectAreaMouseoutTimeoutObj = null;
    this.isSelectAreaMouseover = function() { for (var i = 0; i < _this.selectAreaMouseover.length; i++) if (_this.selectAreaMouseover[i]) return true; $(_this.obj).parent().addClass("msOut").removeClass("msOver"); }
    this.initLogoCitySelector = function() {
        var arearry = new Array();
        for (var i = 0; i < areaArray.length; i++) {
            if ("，北京，上海，天津，重庆，香港，澳门".indexOf(areaArray[i][0]) > 0 && areaArray[i][1] != "0") continue;
            if (areaArray[i][4] != "") arearry.push(areaArray[i]);
        }
        var selectCitys = JB.newObj("DIV", { className: "selectCity", htm: "<div>&nbsp;&nbsp;&nbsp;&nbsp;当前地区： " + areaName + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;选择省市<select></select><select></select></div>" });
        var selectBt = JB.newObj("A", { attrs: ["href", "#"], htm: "确定" });
        selectCitys.appendChild(selectBt);
        _this.obj.appendChild(selectCitys);
        _this.obj.appendChild(JB.newObj("DIV", { className: "clickCity" }));

        var htm = "";
        htm += "<div class=\"cityGroups\"><div class=\"items\"><div style=\"top:0px; left:0px; position:relative; width:1px;\"><div class=\"tar\" style=\"top:26px; left:0px;\">&nbsp;</div></div>";
        htm += "<span class=\"item\" style=\"margin-left:5px;_margin-left:0px;\">热门省市</span>";
        var aa = ["ABCDE", "FGHJ", "KLMNPQ", "RSTW", "XYZ"];
        for (var i = 0; i < aa.length; i++) htm += "<span class=\"item\">" + aa[i] + "</span>";
        htm += "</div></div><div style='clear:both;'></div>";
        htm += "<table style=\"display:none;\"><tr><td></td></tr>";
        htm += "</table>";
        for (var i = 0; i < aa.length; i++) {
            htm += "<table style=\"display:none;\">";
            for (var j = 0; j < aa[i].length; j++) {
                htm += "<tr><td class=\"tt\">" + aa[i].substr(j, 1) + "</td><td>";
                for (var k = 0; k < arearry.length; k++) {
                    if (arearry[k][1] != "0") continue;
                    if (arearry[k][4] != "" && arearry[k][4].toLowerCase().substr(0, 1) == aa[i].toLowerCase().substr(j, 1)) {
                        htm += _this.itemInit(arearry[k]);
                    }
                }
                for (var k = 0; k < arearry.length; k++) {
                    if (arearry[k][1] == "0") continue;
                    if (arearry[k][4] != "" && arearry[k][4].toLowerCase().substr(0, 1) == aa[i].toLowerCase().substr(j, 1)) {
                        htm += _this.itemInit(arearry[k]);
                    }
                }
                htm += "</td></tr>";
            }
            htm += "</table>";
        }
        $(_this.obj).find(".clickCity").html(htm);
        if (JBody.isFunction(_this.callback)) $(_this.obj).find(".clickCity a").click(function() { _this.callback($(this).attr("data-id"), $(this).attr("data-key"), this.innerHTML) });
        new adTitleCreator($(".cityGroups").get(0), { rotate: false, outreset: false, delayShow: 300, fixtarsize: true, index: 0, itemTagName: "SPAN", callback: function(idx, objs) {
            $(objs[idx]).parent().find("span").removeClass("active");
            $(objs[idx]).addClass("active");
            $(_this.obj).find(".clickCity table").hide();
            $(_this.obj).find(".clickCity table").get(idx).style.display = "";
        }
        });
        CreateAreaSelector({ slProv: $(selectCitys).find("select").get(0), slCity: $(selectCitys).find("select").get(1), titleCity: "全省（市）" });

        $(selectCitys).find("select").mouseover(function() { clearTimeout(_this.selectAreaMouseoutTimeoutObj); _this.selectAreaMouseover[1] = true; }).mouseout(function() {
            _this.selectAreaMouseover[1] = false;
            clearTimeout(_this.selectAreaMouseoutTimeoutObj);
            _this.selectAreaMouseoutTimeoutObj = setTimeout(_this.isSelectAreaMouseover, 600);
        });
        return this;
    }
    _this.headerLogoAreaSelector = null;
    _this.selectCityMouseOverFunctionTimeOutObj = null;
    _this.selectCityMouseOverFunction = function() {
        if (_this.selectAreaMouseover[0]) {
            $(_this.obj).parent().addClass("msOver").removeClass("msOut");
            clearTimeout(_this.selectAreaMouseoutTimeoutObj);
            if (_this.headerLogoAreaSelector == null) _this.headerLogoAreaSelector = new _this.initLogoCitySelector();
        }
    }
    $(_this.obj).parent().mouseover(function() {
        _this.selectAreaMouseover[0] = true;
        if (_this.selectCityMouseOverFunctionTimeOutObj != null) clearTimeout(_this.selectCityMouseOverFunctionTimeOutObj);
        _this.selectCityMouseOverFunctionTimeOutObj = setTimeout(_this.selectCityMouseOverFunction, 300);
    }
    ).mouseout(function() {
        _this.selectAreaMouseover[0] = false;
        if ($(_this.obj).parent().is("msOut")) return;
        clearTimeout(_this.selectAreaMouseoutTimeoutObj);
        _this.selectAreaMouseoutTimeoutObj = setTimeout(_this.isSelectAreaMouseover, 600);
    });
    return _this;
}
