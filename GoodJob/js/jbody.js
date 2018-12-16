// JScript 文件
// 版权所有 www.jbody.cn, 95864132@qq.com

function JBody() {
    var _this = this;
    var _JBody = this;
    var _ua = navigator.userAgent.toLowerCase();
    this.IE = _ua.indexOf('msie') > -1 && _ua.indexOf('opera') == -1;
    //this.IE_TRIDENT = this.IE && _ua.indexOf('trident') > 0; //无效
    this.GECKO = _ua.indexOf('gecko') > -1 && _ua.indexOf('khtml') == -1;
    this.WEBKIT = _ua.indexOf('applewebkit') > -1;
    this.OPERA = _ua.indexOf('opera') > -1;
    this.MOBILE = _ua.indexOf('mobile') > -1;
    this.IOS = /ipad|iphone|ipod/.test(_ua);
    var _matches = /(?:msie|firefox|webkit|opera)[\/:\s](\d+)/.exec(_ua);
    this.V = _matches ? _matches[1] : '0';
    this.IE8DocumentMode = (this.IE && this.V == 8) ? document.documentMode : 0;  //5怪异模式（即IE5模式）；7表示IE7仿真模式；8标准模式
    this.QUIRKS = this.IE8DocumentMode == 5 || document.compatMode != 'CSS1Compat';  //怪异模式
    var _st = window.setTimeout;
    this.support = new Object();
    this.support.boxShadow = (!this.IE || (this.IE && this.V > 8));
    this.support.borderRadius = (!this.IE || (this.IE && this.V > 8));
    this.support.html5 = (typeof (Worker) !== 'undefined' && typeof (window.applicationCache) !== 'undefined');
    this.isDate = function (dt) {
        return (dt == null && _this.isFunction(dt.getYear) && dt.getYear() > 0 &&
            _this.isFunction(dt.getFullYear) && _this.isFunction(dt.setFullYear)
            && _this.isFunction(dt.getUTCFullYear));
    }
    this.isElement = function (val) {
        if (!val) {
            return false;
        }
        var t = Object.prototype.toString.call(val);
        if (_this.IE && _this.V <= 8) {
            return _this.startWith(t, "[object Object") && val.tagName && val.getElementsByTagName;
        }
        return _this.startWith(t, "[object HTML") && _this.endWith(t, "Element]");
    };
    this.isArray = function (val) {
        if (!val) {
            return false;
        }
        return Object.prototype.toString.call(val) === '[object Array]';
    };
    this.isFunction = function (val) {
        if (!val) {
            return false;
        }
        return Object.prototype.toString.call(val) === '[object Function]';
    };
    this.indexOfArray = function (val, arr) {
        for (var i = 0, len = arr.length; i < len; i++) {
            if (val === arr[i]) {
                return i;
            }
        }
        return -1;
    };
    this.inArray = _this.indexOfArray;
    this.toArray = function (obj, offset) {
        return Array.prototype.slice.call(obj, offset || 0);
    };
    this.setTimeout = function (fn, mDelay) {   //JB.setTimeout(func,100,参数1,..,参数N)
        if (fn == null) return;
        if (_this.isFunction(fn)) {
            var argu = Array.prototype.slice.call(arguments, 2);
            var f = (function () { fn.apply(null, argu); });
            return _st(f, mDelay);
        }
        return _st(fn, mDelay);
    };
    this.lTrim = function (str) {
        return str.replace(/^\s*/g, "");
    };
    this.rTrim = function (str) {
        return str.replace(/\s*$/g, "");
    };
    this.trim = function (str) {
        return str.replace(/(^\s*)|(\s*$)/g, "");
    };
    this.startWith = function (str, sub) {
        if (str.indexOf(sub) >= 0) return str.substr(0, sub.length) == sub;
        return false;
    };
    this.endWith = function (str, sub) {
        if (str.indexOf(sub) >= 0) return str.substr(str.length - sub.length, sub.length) == sub;
        return false;
    };
    this.strFormat = function (str) {
        if (!str) return null;
        var str2 = str.valueOf();
        var argu = Array.prototype.slice.call(arguments, 1);
        for (var i = 0; i < argu.length; i++) { str2 = str2.replace(new RegExp("{" + i + "}", "g"), argu[i]); }
        return str2.replace(/\{\d+}/g, "");
    };
    this.strFormatJson = function (str) {
        if (!str) return null;
        var str2 = str.valueOf();
        var argu = Array.prototype.slice.call(arguments, 1);
        for (var i = 0; i < argu.length; i++) {
            for (var j in argu[i]) str2 = str2.replace(new RegExp("{" + j + "}", "g"), argu[i][j] || "");
        }
        return str2.replace(/\{[_\da-zA-Z]+}/g, "");
    };
    this.padLeft = function (str, len, c) {
        var s = str.valueOf();
        for (var i = 0; i < len; i++) s = c + "" + s;
        return s.substr(s.length - len);
    };
    this.padRight = function (str, len, c) {
        var s = str.valueOf();
        for (var i = 0; i < len; i++) s = s + "" + c;
        return s.substr(0, len);
    };
    this.getDoc = function (node) {
        if (!node) {
            return document;
        }
        return node.ownerDocument || node.document || node;
    };
    this.getWin = function (node) {
        if (!node) {
            return window;
        }
        var doc = _this.getDoc(node);
        return doc.parentWindow || doc.defaultView;
    };
    this.docElement = function (doc) {
        doc = doc || document;
        //return _this.QUIRKS ? doc.body : doc.documentElement;
        return doc.body || doc.documentElement || doc;
    };
    this.height = function (doc, val) {
        if (doc && val != null) _this.setOpt(doc, { w: val });
        return doc.offsetHeight;
    };
    this.width = function (doc, val) {
        if (doc && val != null) _this.setOpt(doc, { h: val });
        return doc.offsetWidth;
    };
    this.getScrollPos = function (doc) {
        if (doc == null) doc = document;
        var x, y;
        if (_this.IE || _this.OPERA) {
            doc = doc || document;
            doc = _this.QUIRKS ? doc.body : doc.documentElement;
            x = doc.scrollLeft;
            y = doc.scrollTop;
        } else {
            var win;
            if (doc == null) win = window;
            else {
                doc = doc.ownerDocument || doc.document || doc;
                win = doc.parentWindow || doc.defaultView;
            }
            x = win.scrollX;
            y = win.scrollY;
        }
        return { x: x, y: y };
    };
    this.scrollPos = function (args) {
        args = args || {};
        var pos2 = _this.getScrollPos(args.obj);
        if (args.x === null && args.y === null) return pos2;
        pos2.x = args.x || pos2.x;
        pos2.y = args.y || pos2.y;
        var obj = args.obj || window;
        if (obj == document) obj = window;
        if (obj == window) {
            window.scrollTo(pos2.x, pos2.y);
            return;
        }
        try {
            if (obj.scrollTo) {
                obj.scrollTo(pos2.x, pos2.y);
            } else {
                obj.scrollLeft = pos2.x;
                obj.scrollTop = pos2.y;
            }
        } catch (e) { }
    };
    this.getPageSize = function (frm) {
        var xScroll, yScroll;
        frm = frm || self;
        //if (!frm.window) alert(frm);
        var doc = null;
        if (doc == null && frm.document) doc = frm.document.documentElement;
        if (doc == null && frm.document) doc = frm.document.body;
        if (doc == null && frm.document) doc = frm.document;
        if (doc == null && frm.ownerDocument) doc = frm.ownerDocument.documentElement;
        if (doc == null && frm.ownerDocument) doc = frm.ownerDocument.body;
        if (doc == null && frm.ownerDocument) doc = frm.ownerDocument;
        if (doc == null) doc = document.documentElement;
        if (doc == null) doc = document.body;
        if (doc == null) doc = document;

        var scrollX = 0;
        var scrollY = 0;
        if (doc.scrollWidth) scrollX = Math.max(doc.scrollWidth, scrollX);
        if (doc.clientWeight) scrollX = Math.max(doc.clientWeight, scrollX);

        if (doc.scrollHeight) scrollY = Math.max(doc.scrollHeight, scrollY);
        if (doc.clientHeight) scrollY = Math.max(doc.clientHeight, scrollY);

        var windowWidth = 0;
        var windowHeight = 0;
        if (doc.innerWidth) windowWidth = Math.max(doc.innerWidth, windowWidth);
        if (doc.clientWidth) windowWidth = Math.max(doc.clientWidth, windowWidth);

        if (doc.innerHeight) windowHeight = Math.max(doc.innerHeight, windowHeight);
        if (doc.clientHeight) windowHeight = Math.max(doc.clientHeight, windowHeight);

        var pageWidth = Math.max(scrollX, windowWidth);
        var pageHeight = Math.max(scrollY, windowHeight);
        return { PageW: pageWidth, PageH: pageHeight, WinW: windowWidth, WinH: windowHeight, winW: windowWidth, winH: windowHeight, docW: pageWidth, docH: pageHeight };
    };
    this.ScreenSize = { h: window.screen.height, w: window.screen.width, avh: window.screen.availHeight, avw: window.screen.availWidth };
    this.getScreenSize = function () {
        return _this.ScreenSize;
    };
    this.each = function (elm, fun, falseBreak) {
        if (fun == null) return false;
        falseBreak = (falseBreak !== false);
        if (typeof (elm) == "string") elm = document.getElementById(elm);
        if (_this.isFunction(fun)) {
            var argu = Array.prototype.slice.call(arguments, 3);
            var argus = new Array();
            argus.push(elm);
            while (argu.length > 0) argus.push(argu.shift());
            if (elm.length > 0 && elm.tagName == null && elm.parentNode == null && elm != document && elm != window) {
                for (var i = 0; i < elm.length; i++) {
                    argus[0] = elm[i];
                    var v = fun.apply(this, argus);
                    if (falseBreak === true && v === false) return false;
                }
            }
            else {
                var v = fun.apply(this, argus);
                if (falseBreak === true && v === false) return false;
            }
        }
        return true;
    }
    this.attribute = function (el, key, val) {
        if (key == "class" || key == "className") return _this.setClass(el, val);
        if (val == null) return el.getAttribute(key);
        el.setAttribute(key, '' + val);
        return el;
    }
    this.attr = this.attribute;
    this.getAttr = function (el, key) {
        return _this.attribute(el, key);
    };
    this.setAttr = function (el, key, val) {
        return _this.attribute(el, key, val);
    };
    this.removeAttr = function (el, key) {
        if (key == "class" || key == "className") return _this.setClass(el, "");
        _setAttr(el, key, '');
        el.removeAttribute(key);
        return el;
    };
    this.containClass = function (el, cl) {
        return (" " + el.className + " ").indexOf(" " + cl + " ") >= 0;
    }
    this.addClass = function (el, cl) {
        if (!_this.containClass(el, cl)) el.className = el.className + " " + cl;
        return el;
    }
    this.removeClass = function (el, cl) {
        if (_this.containClass(el, cl)) el.className = (" " + el.className + " ").replace(" " + cl + " ", "");
        return el;
    }
    this.setClass = function (el, cl) {
        el.className = cl;
        return el;
    }
    this.setFloat = function (el, f) {
        if (_this.IE || el.style.styleFloat) el.style.styleFloat = f;
        else el.style.cssFloat = f;
        return el;
    };
    this._parseFloat = parseFloat;  //JS原生的parseFloat方法
    this.parseFloat = function (x, n, strict) {   //x要转换的对象,n保留的小数位数,strict是否严格要求位数
        var f_x = _this._parseFloat(x);
        if (isNaN(f_x)) return f_x;  //
        n = (n > 0 ? n : 0);
        f_x = Math.round(x * Math.pow(10, n)) / Math.pow(10, n);
        if (strict != true) return f_x;
        var s_x = f_x.toString();
        var pos_decimal = s_x.indexOf('.');
        if (pos_decimal < 0) {
            pos_decimal = s_x.length;
            s_x += '.';
        }
        while (s_x.length <= pos_decimal + n) {
            s_x += '0';
        }
        return s_x;
    };
    this.getEventSrc = function (e) {
        //var objEvent = window.event || arguments.callee.caller.arguments[0];
        e = window.event || e;
        var src = e.srcElement || e.target;
        return src;
    }
    this.attach = function (elm, evname, func, useCapture) {
        if (func == null) return;
        _this.each(elm, function (elm, evname, func) {
            if (elm.attachEvent) {
                if (typeof (func) == "string") elm.attachEvent("on" + evname, function () { eval(func); });
                else { elm.attachEvent("on" + evname, func); }
            } else if (elm.addEventListener) {
                if (typeof (func) == "string") elm.addEventListener(evname, function () { eval(func); }, useCapture === true);
                else { elm.addEventListener(evname, func, useCapture === true); }
            }
        }, false, evname, func);
    };
    this.detach = function (elm, evname, func, releaseCapture) {
        _this.each(elm, function (elm, evname, func) {
            try {
                if (window.detachEvent) {
                    if (typeof (func) == "string") elm.detachEvent("on" + evname, function () { eval(func); });
                    else elm.detachEvent("on" + evname, func);
                } else if (window.removeEventListener) {
                    if (typeof (func) == "string") elm.removeEventListener(evname, function () { eval(func); }, releaseCapture === true);
                    elm.removeEventListener(evname, func, releaseCapture === true);
                }
            } catch (e) { }
        }, false, evname, func);
    };
    this.attachEvent = this.attach;
    this.detachEvent = this.detach;
    this.addEventListener = this.attach;
    this.removeEventListener = this.detach;
    this.fireEvent = function (obj, ename) {
        if (obj.fireEvent) obj.fireEvent("on" + ename);
        else {
            var evt = document.createEvent('HTMLEvents');
            evt.initEvent(ename, true, true);
            obj.dispatchEvent(evt);
        }
    };
    this.hide = function (obj) { if (obj && obj.style) obj.style.display = "none"; return obj; };
    this.show = function (obj, v) {
        if (obj && obj.style) {
            if (v == null && obj.style.display == "none") obj.style.display = "";
            else if (v != null) obj.style.display = v;
            return obj;
        }
    }
    this.display = function (obj, v) { return _this.show(obj, v); };
    this.visiable = function (obj, v) {
        if (_this.isNullUndef(obj)) return false;
        if (_this.isNullUndef(v)) return obj.style.display != 'none';
        this.display(obj, v);
    };
    this.isHide = function (obj, checkParent) {
        if (!obj) return false;
        var curObj = obj;
        var v = (JB.getCurrentStyle(curObj, 'display') != 'none');
        while (checkParent && v && curObj.parentNode) {
            curObj = curObj.parentNode;
            v = (JB.getCurrentStyle(curObj, 'display') != 'none');
        }
        curObj = null;
        return !v;
    }
    this.getAbsoluteOffset = function (obj) {
        if (!obj || obj == document) return { x: 0, y: 0 };
        if (obj == window) return _this.scroll();
        var y = obj.offsetTop;
        var x = obj.offsetLeft;
        var fl = 0;   //fixed
        var ft = 0;
        var relateL = 0;   //fixed
        var relateT = 0;
        var fixed = (JBody.css(obj, "position") == "fixed");
        var relate = (JBody.css(obj, "position") == "fixed") || (JBody.css(obj, "position") == "relative") || (JBody.css(obj, "position") == "absolute");
        if (!fixed) {
            fl += obj.offsetLeft;
            ft += obj.offsetTop;
        }
        if (!relate) {
            relateL += obj.offsetLeft;
            relateT += obj.offsetTop;
        }
        while (obj = obj.offsetParent) {
            x += obj.offsetLeft; y += obj.offsetTop;
            fixed = fixed || (JBody.css(obj, "position") == "fixed");
            var relate = relate || ((JBody.css(obj, "position") == "fixed") || (JBody.css(obj, "position") == "relative") || (JBody.css(obj, "position") == "absolute"));
            if (!fixed) {
                fl += obj.offsetLeft;
                ft += obj.offsetTop;
            }
            if (!relate) {
                relateL += obj.offsetLeft;
                relateT += obj.offsetTop;
            }
        }
        if (fixed) {
            var scrlpos = _this.scroll(); x += scrlpos.x; y += scrlpos.y;
            return { l: x, t: y, fl: fl, ft: ft, relateL: relateL, relateT: relateT };
        }
        return { l: x, t: y, fl: fl, ft: ft, relateL: relateL, relateT: relateT };
    };
    this.getAbsolutePosition = function (objs) {
        if (!objs.push || !objs.pop) objs = [objs];
        var p = { l: 0, l2: 0, t: 0, t2: 0, w: 0, h: 0 };
        for (var i = 0; i < objs.length; i++) {
            var pt1 = _this.getAbsoluteOffset(objs[i]);
            var pt2 = { l: pt1.l + objs[i].offsetWidth, t: pt1.t + objs[i].offsetHeight };
            if (i == 0) p = { l: pt1.l, t: pt1.t, l2: pt2.l, t2: pt2.t };
            p.l = Math.min(p.l, pt1.l);
            p.t = Math.min(p.t, pt1.t);
            p.l2 = Math.max(p.l2, pt2.l);
            p.t2 = Math.max(p.t2, pt2.t);
        }
        p.w = p.l2 - p.l;
        p.h = p.t2 - p.t;
        return p;
    };
    this.topCanSee = function (opt) {  //检查是否可见 opt:{pos|obj[,win]}，未考虑非window元素的滚动条情况
        if (!opt) return true;
        if (!opt.obj && !opt.pos) return true;
        var win = opt.win || window;
        if (!opt.pos) opt.pos = _this.getAbsolutePosition(opt.obj) || {};
        if (!opt.pos.w) opt.pos.w = 1;
        if (!opt.pos.h) opt.pos.h = 1;
        if (opt.pos.l === null || opt.pos.t === null) { return true; }
        var pagesize = _this.getPageSize(win.frameElement);
        var scrpos = _this.getScrollPos(win.document);
        //alert(_this.objToStr(opt) + _this.objToStr(pagesize) + _this.objToStr(scrpos)+ (win == top.window));
        if (pagesize.WinW > opt.pos.w) {
            if (scrpos.x > opt.pos.l || (scrpos.x + pagesize.winW) < (opt.pos.l + opt.pos.w)) return false;
        } else {
            if (scrpos.x > (opt.pos.l + opt.pos.w) || (scrpos.x + pagesize.winW) < opt.pos.l) return false;
        }
        if (pagesize.WinH > opt.pos.h) {
            if (scrpos.y > opt.pos.t || (scrpos.y + pagesize.winH) < (opt.pos.t + opt.pos.h)) return false;
        } else {
            if (scrpos.y > (opt.pos.t + opt.pos.h) || (scrpos.y + pagesize.winH) < opt.pos.t) return false;
        }
        if (win == top.window) { return true; }
        var parentPos = _this.getAbsoluteOffset(win.frameElement);
        return _this.topCanSee({ win: win.parent, pos: { w: opt.pos.w, h: opt.pos.h, l: (opt.pos.l - scrpos.x + parentPos.l), t: (opt.pos.t - scrpos.y + parentPos.t) } });
    }
    this.tryTopCanSee = function (opt) {  //尽可能使对象或位置在顶层窗口可见 opt:{pos|obj[,win]}，未考虑非window元素的滚动条情况
        if (!opt) return true;
        if (!opt.obj && !opt.pos) return;
        var win = opt.win || window;
        if (!opt.pos) opt.pos = _this.getAbsolutePosition(opt.obj);
        if (!opt.pos.w) opt.pos.w = 1;
        if (!opt.pos.h) opt.pos.h = 1;
        if (opt.pos.l === null || opt.pos.t === null) return;
        var pagesize = _this.getPageSize(win.frameElement);
        var scrpos = _this.getScrollPos(win.document);
        //alert(_this.objToStr(opt.pos) + ";" + _this.objToStr(pagesize) + ";" + _this.objToStr(scrpos) + ";");
        if (pagesize.WinW > opt.pos.w) {
            if (scrpos.x > opt.pos.l || (scrpos.x + pagesize.winW) < (opt.pos.l + opt.pos.w)) { _this.scrollPos({ obj: win, x: opt.pos.l - 1, y: scrpos.y }); }
        } else {
            if (scrpos.x > (opt.pos.l + opt.pos.w) || (scrpos.x + pagesize.winW) < opt.pos.l) { _this.scrollPos({ obj: win, x: opt.pos.l - 1, y: scrpos.y }); }
        }
        if (pagesize.WinH > opt.pos.h) {
            if (scrpos.y > opt.pos.t || (scrpos.y + pagesize.winH) < (opt.pos.t + opt.pos.h)) { _this.scrollPos({ obj: win, x: scrpos.x, y: opt.pos.t - 1 }); }
        } else {
            if (scrpos.y > (opt.pos.t + opt.pos.h) || (scrpos.y + pagesize.winH) < opt.pos.t) { _this.scrollPos({ obj: win, x: scrpos.x, y: opt.pos.t - 1 }); }
        }
        if (win == top.window) return;
        var parentPos = _this.getAbsoluteOffset(win.frameElement);
        scrpos = _this.getScrollPos(win.document);
        return _this.tryTopCanSee({ win: win.parent, pos: { w: opt.pos.w, h: opt.pos.h, l: (opt.pos.l - scrpos.x + parentPos.l), t: (opt.pos.t - scrpos.y + parentPos.t) } });
    }
    this.newElm = this.newObj = function (tag, opt) {
        var obj = document.createElement(tag);
        if (arguments.length > 2) {
            for (var i = 1; i < arguments.length; i++) _this.setOpt(obj, arguments[i]);
        } else if (_this.isArray(opt)) {
            for (var i = 0; i < opt.length; i++) _this.setOpt(obj, opt[i]);
        } else _this.setOpt(obj, opt);
        return obj;
    };
    this.setOpt = this.setElmOpt = function (obj, opt) {
        if (arguments.length > 2) {
            for (var i = 1; i < arguments.length; i++) _this.setOpt(obj, arguments[i]);
            return;
        }
        if (_this.isArray(opt)) {
            for (var i = 0; i < opt.length; i++) _this.setOpt(obj, opt[i]);
            return;
        }
        _this.each(obj, function (obj, opt) {
            if (opt && opt != "") {
                if (typeof (opt) === "string") opt = eval("(" + opt + ")");
                if (_this.isArray(opt.attrs) && _this.isArray(opt.attrs[0])) for (var i = 0; i < opt.attrs.length; i++) _this.setAttr(obj, opt.attrs[i][0], opt.attrs[i][1]);
                else if (_this.isArray(opt.attrs)) _this.setAttr(obj, opt.attrs[0], opt.attrs[1]);
                if (_this.isArray(opt.css) && _this.isArray(opt.css[0])) for (var i = 0; i < opt.css.length; i++) _this.css(obj, opt.css[i][0], opt.css[i][1]);
                else if (_this.isArray(opt.css)) _this.css(obj, opt.css[0], opt.css[1]);
                if (opt.type != null || opt.tp != null) obj.type = opt.type || opt.tp;
                if (opt.w >= 0 || opt.width >= 0) obj.style.width = parseInt(opt.width != null ? opt.width : opt.w) + "px";
                if (opt.h >= 0 || opt.height >= 0) obj.style.height = parseInt(opt.height != null ? opt.height : opt.h) + "px";
                if (opt.t != null || opt.top != null) obj.style.top = parseInt(opt.top != null ? opt.top : opt.t) + "px";
                if (opt.l != null || opt.left != null) { obj.style.left = parseInt(opt.left != null ? opt.left : opt.l) + "px"; }
                if (opt.f || opt.float || opt.cssFloat || opt.styleFlost) _this.setFloat(obj, opt.cssFloat || opt.styleFlost || opt.f || opt.float);
                if (opt.v != null || opt.value != null) { obj.value = (opt.value != null ? opt.value : opt.v); }
                if (opt.pos || opt.position) obj.style.position = opt.pos || opt.position;
                if (opt.border || opt.bd) obj.style.border = opt.border || opt.bd;
                if (opt.borderTop || opt.bdT) obj.style.borderTop = opt.borderTop || opt.bdT;
                if (opt.borderLeft || opt.bdL) obj.style.borderLeft = opt.borderLeft || opt.bdL;
                if (opt.borderRight || opt.bdR) obj.style.borderRight = opt.borderRight || opt.bdR;
                if (opt.borderBottom || opt.bdB) obj.style.borderBottom = opt.borderBottom || opt.bdB;
                if (opt.cursor) obj.style.cursor = opt.cursor;
                if (opt.color) obj.style.color = opt.color;
                if (opt.bg || opt.background) obj.style.background = opt.bg || opt.background;
                if (opt.bgColor || opt.backgroundColor) {
                    var bgc = opt.bgColor || opt.backgroundColor;
                    if (bgc.length > 10 && _this.IE) obj.style.background = bgc;
                    else obj.style.backgroundColor = opt.bgColor || opt.backgroundColor;
                }
                if (opt.display != null) obj.style.display = opt.display;
                if (opt.readonly != null) { _this.setAttr(obj, "readOnly", opt.readonly); obj.readOnly = opt.readonly; }
                if (opt.textAlign || opt.align) obj.style.textAlign = opt.textAlign || opt.align;
                if (opt.disabled != null || opt.disa != null) obj.disabled = opt.disabled || opt.disa;
                if (opt.checked != null || opt.chk != null) obj.checked = opt.checked || opt.chk;
                if (opt.cssClass || opt.className || opt.clss) _this.setAttr(obj, "class", opt.cssClass || opt.className || opt.clss);
                if (opt.innerHTML != null || opt.innerhtml != null || opt.innerhtm != null || opt.html != null || opt.htm != null) obj.innerHTML = opt.innerHTML || opt.innerhtml || opt.innerhtm || opt.html || opt.htm;
                if (_this.isArray(opt.attach)) for (var i = 0; i < opt.attach.length; i++) _this.attach(obj, opt.attach[i].f, opt.attach[i].func);
                else if (opt.attach && opt.attach.f) _this.attach(obj, opt.attach.f, opt.attach.func);
                if (_this.isArray(opt.childs)) for (var i = 0; i < opt.childs.length; i++) _this.newChild(obj, opt.childs[i].tag, opt.childs[i].opt);
                else if (opt.childs && opt.childs.tag) _this.newChild(obj, opt.childs.tag, opt.childs.opt);
                if (_this.isArray(opt.children)) for (var i = 0; i < opt.children.length; i++) _this.newChild(obj, opt.children[i].tag, opt.children[i].opt);
                else if (opt.children && opt.children.tag) _this.newChild(obj, opt.children.tag, opt.children.opt);
            }
        }, false, opt);
        return obj;
    };
    this.opacity = function (obj, v) {
        if (!obj) return undefined;
        if (v != null) {
            _this.each(obj, function (obj, opt) {
                try { obj.style.opacity = (v / 100); } catch (e) { }
                try {
                    var reg = /Opacity=[\d]*/;
                    if (obj.style.filter) {
                        if (reg.test(obj.style.filter)) obj.style.filter = obj.style.filter.replace(/Opacity=[\d]*/, "Opacity=" + v);
                        else obj.style.filter += " Alpha(Opacity=" + v + ")";
                    }
                    else obj.style.filter = " Alpha(Opacity=" + v + ")";
                } catch (e) { }
                try { obj.style["mozOpacity"] = (v / 100); } catch (e) { }
            }, false, v);
            return obj;
        }
    };
    this.html = function (obj, v) {
        if (!obj) return undefined;
        if (v != null) return (obj.style.innerHTML = "" + v);
        return obj.style.innerHTML || undefined;
    };
    this.val = function (obj, v) {
        if (typeof (obj) == "string") obj = document.getElementById(obj);
        if (v != null) {
            obj.value = v;
            if (JBInputInnerTips) JBInputInnerTips.update(obj);
            _this.fireEvent(obj, "change");
        }
        else if (obj) {
            if (typeof (obj) == "string") obj = document.getElementById(obj);
            if (obj) return JBInputInnerTips.val(obj);
            return null;
        }
    }
    this.style = function (obj, value) {
        if (!obj) return undefined;
        if (value != null) return (obj.style.cssText = "" + value);
        return obj.style.cssText.toLowerCase() || undefined;
    };
    this.cssText = function (obj, val) {
        return _this.style(obj, val);
    }
    this.css = function (obj, n, v) {
        if (n == null || _this.trim(n) == "") return obj;
        if (v == null) {
            var v = _this.getCurrentStyle(obj, n);
            if (v !== null) return v;
            return obj.style[n] || "";
        }
        if (n == "float") { _this.setFloat(obj, v); return obj; }
        if (n == "cssText") return _this.cssText(obj, v);
        if (n == "opacity") {
            if (v == null) v = 1;
            v = parseInt(parseFloat(v) * 100);
            _this.opacity(obj, v); return obj;
        }
        try {
            if (n == "filter") {
                obj.style.filter += " " + v;
            }
            else {
                obj.style[n] = v;
            }
        }
        catch (e) { }
    };
    this.getCurrentStyle = function (obj, prop) {
        try {
            if (obj.currentStyle) {
                return prop ? obj.currentStyle[prop] : obj.currentStyle; //IE
            }
            else if (window.getComputedStyle) {
                if (prop) {
                    prop = prop.replace(/([A-Z])/g, "-$1");
                    prop = prop.toLowerCase();
                    return window.getComputedStyle(obj, null).getPropertyValue(prop);
                } else return window.getComputedStyle(obj, null);
            }
        } catch (e) { return null; }
        return null;
    };
    this.getMaxZIndex = function (obj) {
        var obj = obj || _this.docElement();
        var MaxZ = 0;
        if (obj && obj.childNodes)
            for (var i = 0; i < obj.childNodes.length; i++)
                MaxZ = Math.max(MaxZ, _this.getMaxZIndex(obj.childNodes.item(i)));

        var ObjZ = _this.getCurrentStyle(obj, "zIndex") || 1;

        if (isNaN(ObjZ)) ObjZ = 0;
        //if (obj.style && obj.style.zIndex && obj.style.zIndex != "") ObjZ = Math.max(ObjZ, parseInt(obj.style.zIndex));
        MaxZ = Math.max(ObjZ, MaxZ);
        return MaxZ;
    }
    this.borderRadius = function (obj, v, p) {
        obj = _this.css(obj, "mozBorderRadius" + p, parseInt(v) + "px");
        obj = _this.css(obj, "webkitBorder" + p + "Radius", parseInt(v) + "px");
        obj = _this.css(obj, "khtmlBorder" + p + "Radius", parseInt(v) + "px");
        obj = _this.css(obj, "border" + p + "Radius", parseInt(v) + "px");
        return obj;
    }
    this.newChild = function (obj, tag, opt) {
        if (obj == null || obj == undefined) return;
        if (tag.toLowerCase() == "tr" && obj.insertRow) return _this.insertCell(obj, opt);
        if (tag.toLowerCase() == "td" && obj.insertCell) return _this.insertCell(obj, opt);
        return obj.appendChild(_this.newElm(tag, opt));
    };
    this.insertCell = function (tr, opt) {
        if (tr == null) return null;
        var td = (tr.insertCell) ? tr.insertCell(tr.cells.length) : tr.appendChild(document.createElement("TD"));
        return _this.setOpt(td, opt);
    };
    this.insertRow = function (tb, opt) {
        if (tb == null) return null;
        var tr = (tb.insertRow) ? tb.insertRow(tb.rows.length) : tb.appendChild(document.createElement("TR"));
        return _this.setOpt(tr, opt);
    };
    this.containChinese = function (str) {
        var reg = /[\u0391-\uFFE5]+/;
        return reg.test(str);
    }
    this.getLengthDoubleChinese = function (str) {
        var len = str.length;
        for (var i = 0; i < str.length; i++) if (_this.containChinese(str.substr(i, 1))) len += 1;
        return len;
    };
    this.dateTimeToString = function (dt, fmt) {
        if (fmt == null || fmt == "") fmt = "yyyy-MM-dd HH:mm:ss";
        var fm = ["yyyy", "yy", "MM", "M", "dd", "d", "HH", "H", "hh", "h", "mm", "m", "ss", "s", "fff", "f"];
        if (dt == null || !_this.isFunction(dt.getFullYear)) return null;
        var funs = [dt.getFullYear(), dt.getFullYear(),
        "0" + (dt.getMonth() + 1), dt.getMonth() + 1,
        "0" + dt.getDate(), dt.getDate(),
        "0" + dt.getHours(), dt.getHours(),
        "0" + (dt.getHours() == 12 ? 12 : (dt.getHours() % 12)), (dt.getHours() == 12 ? 12 : (dt.getHours() % 12)),
        "0" + dt.getMinutes(), dt.getMinutes(),
        "0" + dt.getSeconds(), dt.getSeconds(),
        "00" + dt.getMilliseconds(), dt.getMilliseconds()];
        var str = "";
        while (fmt.length > 0) {
            for (var i = 0; i < fm.length; i++) {
                if (fmt.substr(0, fm[i].length) == fm[i]) {
                    var v = funs[i] + "";
                    if (fm[i].length > 1 && v.length > fm[i].length) v = v.substr(v.length - fm[i].length);
                    str += v;
                    fmt = fmt.substr(fm[i].length);
                }
            }
            if (fmt.length > 0) {
                str += fmt.substr(0, 1);
                fmt = fmt.substr(1);
            }
        }
        return str;
    };
    this.parseDateTime = function (str, fmt, timeonly, debug) {
        if (fmt == null || fmt == "") fmt = "yyyy-MM-dd HH:mm:ss";
        if (str == null || str == "") return null;
        str = _this.trim(str);
        fmt = _this.trim(fmt);
        if (debug) alert(str);
        var _y4 = "^([0-9]{4})";
        var _y2 = "^([0-9]{2})";
        var _M2 = "^(0[1-9]|1[0-2])";
        var _M1 = "^([1-9]|1[0-2])";
        var _d2 = "^(0[1-9]|[1-2][0-9]|30|31)";
        var _d1 = "^([1-9]|[1-2][0-9]|30|31)";
        var _H2 = "^([0-1][0-9]|20|21|22|23)";
        var _H1 = "^([0-9]|1[0-9]|20|21|22|23)";
        var _h2 = "^((0[0-9])|(1[0-2]))";
        var _h1 = "^([0-9]|1[0-2])";
        var _m2 = "^([0-5][0-9])";
        var _m1 = "^([0-9]|[1-5][0-9])";
        var _s2 = "^([0-5][0-9])";
        var _s1 = "^([0-9]|[1-5][0-9])";
        var ft = function (s) { while (s.length > 1 && s.substr(0, 1) == "0") s = s.substr(1); return s; };
        var fm = ["yyyy", "yy", "MM", "M", "dd", "d", "HH", "H", "hh", "h", "mm", "m", "ss", "s"];
        var fm2 = [_y4, _y2, _M2, _M1, _d2, _d1, _H2, _H1, _h2, _h1, _m2, _m1, _s2, _s1];
        var fm2b = [_y4, _y2, _M1, _M2, _d1, _d2, _H1, _H2, _h1, _h2, _m1, _m2, _s1, _s2];
        var fm3 = [1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        var d = new Date(2000, 1, 1, 0, 0, 0);
        while (fmt.length > 0 && str.length > 0) {
            for (var i = 0; i < fm.length; i++) {
                if (fmt.substr(0, fm[i].length) == fm[i]) {
                    var tst = new RegExp(fm2[i]).test(str);
                    if (!tst) tst = new RegExp(fm2b[i]).test(str);
                    if (tst) {
                        var vtemp = RegExp.$1;
                        if (i == 1) d.setFullYear(d.getFullYear() + parseInt(ft(vtemp)));
                        else {
                            var v = parseInt(ft(vtemp));
                            switch (i) {
                                case 0:
                                case 1: { d.setFullYear(v); break; }
                                case 2:
                                case 3: { d.setMonth(v - 1); break; }
                                case 4:
                                case 5: { d.setDate(v); break; }
                                case 6:
                                case 7:
                                case 8:
                                case 9: { d.setHours(v); break; }
                                case 10:
                                case 11: { d.setMinutes(v); break; }
                                case 12:
                                case 13: { d.setSeconds(v); break; }
                            }
                        }
                        fm3[i] = 0;
                        if (i == 1 || i == 3 || i == 5) fm3[i - 1] = 0;
                        str = str.substr(vtemp.length);
                        fmt = fmt.substr(fm[i].length);
                        if (debug) { alert("str=" + str + ",fmt=" + fmt); }
                        continue;
                    }
                    else { if (debug) alert("1:" + fmt); return null; }
                }
            }
            if (fmt.length > 0) {
                if (str.length > 0 && str.substr(0, 1) != fmt.substr(0, 1)) { if (debug) alert("2:" + fmt); return null; }
                if (str.length > 0) str = str.substr(1);
                fmt = fmt.substr(1);
            }
        }
        if (timeonly != true) for (var j = 0; j < fm3.length; j++) if (fm3[j] > 0) { if (debug) alert("3"); return null; }
        return d;
    };
    this.compareDateTime = function (d1, d2, p) {
        var v = function (d, p2) {
            var m = d.getFullYear() * Math.pow(10, 13);
            if (p2 == "y") return m;
            m += d.getMonth() * Math.pow(10, 11);
            if (p2 == "M") return m;
            m += d.getDate() * Math.pow(10, 9);
            if (p2 == "d") return m;
            m += d.getHours() * Math.pow(10, 7);
            if (p2 == "h") return m;
            m += d.getMinutes() * Math.pow(10, 5);
            if (p2 == "m") return m;
            m += d.getSeconds() * Math.pow(10, 3);
            if (p2 == "s") return m;
            return m + d.getUTCMilliseconds();
        }
        if (d1 == null && d2 == null) return null;
        else if (d1 == null && d2 != null) return null;
        else if (d1 != null && d2 == null) return null;
        else return (v(d1, p) == v(d2, p)) ? 0 : (v(d1, p) > v(d2, p)) ? 1 : -1;
    };
    this.daysInMonth = function (month, year) {
        var a = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (2 == month) {
            return ((0 == (year % 4)) && (0 != (year % 100)))
           || (0 == (year % 400)) ? 29 : 28;
        }
        else return a[month - 1];
    };
    var _dateTime = function () {
        var self = this;
        this.daysInMonth = _this.daysInMonth;
        this.ToString = _this.dateTimeToString;
        this.parse = _this.parseDateTime;
        this.compare = _this.compareDateTime;
    }
    this.dateTime = new _dateTime();
    this.emptyFunc = function () { return; }
    this.undef = function (v, dflt) {  //null也算
        return (v === false || v === 0 || v != null) ? v : dflt;  //null
    };
    this.isUndef = function (v1, v2) {
        if (typeof (v2) == "undefined") return (typeof (v1) == "undefined");
        else return (typeof (v1) == "undefined") ? v2 : v1;
    };
    this.isNullUndef = function (v1, v2) {
        if (typeof (v2) == "undefined") return (v1 === null || typeof (v1) == "undefined");
        else return (v1 === null || typeof (v1) == "undefined") ? v2 : v1;
    };
    this.defaultBool = function (v, dflt) {
        return dflt ? !(v === !dflt) : (v === !dflt);
    };
    this.latestdown = null;
    this.latestkeydown = { src: null, scroll: null, clientX: 0, clientY: 0 };
    this.latestmousedown = { src: null, scroll: null, clientX: 0, clientY: 0 };
    this.saveLatestMousedown = function () {
        _this.attach(_this.docElement(), "mousedown",
        function (e) {
            e = window.event || e;
            _this.latestmousedown.src = e.srcElement || e.target;
            _this.latestmousedown.scroll = _this.getScrollPos();
            _this.latestmousedown.clientX = e.clientX || 0;
            _this.latestmousedown.clientY = e.clientY || 0;
            _this.latestdown = _this.latestmousedown;
        });
    }
    this.saveLatestKeydown = function () {
        _this.attach(_this.docElement(), "keydown",
        function (e) {
            e = window.event || e;
            _this.latestkeydown.src = e.srcElement || e.target;
            _this.latestmousedown.scroll = _this.getScrollPos();
            _this.latestkeydown.clientX = e.clientX || 0;
            _this.latestkeydown.clientY = e.clientY || 0;
            _this.latestdown = _this.latestkeydown;
        });
    }
    this.saveLatestKeydownAndMouseDown = function () {
        _this.saveLatestKeydown();
        _this.saveLatestMousedown();
    };
    this.addStyle2 = function (content) {
        if (_this.IE && document.createStyleSheet) {
            var s = "";
            try {
                if (document.getElementsByTagName('style')[0]) s = document.getElementsByTagName('style')[0].innerHTML;
                var styleSheet = document.createStyleSheet();
                styleSheet.cssText = s + content;
            } catch (e) { alert("addStyle2错误" + e.description); }
        } else {
            var style = document.createElement("style");
            style.type = "text/css";
            //style.textContent = content;  //Safari、Chrome 下innerHTML只读
            style.innerHTML = content;
            _this.docElement().appendChild(style);
        }
    };
    this.addStyle = function () {
        var doc, cssCode;
        if (arguments.length == 1) {
            doc = document;
            cssCode = arguments[0]
        } else if (arguments.length == 2) {
            doc = arguments[0];
            cssCode = arguments[1];
        } else {
            alert("addStyle函数最多接受两个参数!");
        }
        var headElement = doc.getElementsByTagName("head")[0];
        var styleElements = headElement.getElementsByTagName("style");
        if (styleElements.length == 0) {//如果不存在style元素则创建
            if (doc.createStyleSheet) {    //ie
                doc.createStyleSheet();
                //alert("ie22");
            } else {
                var tempStyleElement = doc.createElement('style'); //w3c
                tempStyleElement.setAttribute("type", "text/css");
                headElement.appendChild(tempStyleElement);
            }
        }
        var styleElement = styleElements[0];
        var media = styleElement.getAttribute("media");
        if (media != null && !/screen/.test(media.toLowerCase())) {
            styleElement.setAttribute("media", "screen");
        }
        if (doc.getBoxObjectFor) {
            styleElement.innerHTML += cssCode; //火狐支持直接innerHTML添加样式表字串
        } else if (styleElement.styleSheet) {
            styleElement.styleSheet.cssText += cssCode;
            //alert("ie33");
        } else {
            styleElement.appendChild(doc.createTextNode(cssCode))
        }
    }
    this.loadCssStyle = function (src) {
        var headElement = document.getElementsByTagName("head")[0];
        var tempStyleElement = document.createElement('link');
        tempStyleElement.setAttribute("rel", "stylesheet");
        tempStyleElement.setAttribute("type", "text/css");
        tempStyleElement.setAttribute("src", src);
        headElement.appendChild(tempStyleElement);
        headElement = null;
        tempStyleElement = null;
    };
    this.isJson = function (obj) {
        //var isjson = typeof (obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]";
        try {
            var isjson = false;
            if (obj == document || obj == window) return false;
            if (obj) isjson = typeof (obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]";
            isjson = isjson && (!obj.push || !obj.pop || !(_this.isFunction(obj.pop) && _this.isFunction(obj.push)));
            if (_this.IE) isjson = (isjson && !obj.length);  //IE下还有一些问题
            return isjson;
        } catch (e) {
            return false;
        }
    }
    this.joinJsons = function () {
        if (arguments.length == 0) return {};
        if (arguments.length == 1) return arguments[0];
        var json = arguments[0];
        if (typeof (json) === "string" || typeof (json) === "number" || JBody.isArray(json) || JBody.isDate(json)) return json;
        for (var i = 1; i < arguments.length; i++) {
            for (var j in arguments[i]) {
                json[j] = (json[j] === null || json[j] === undefined) ? arguments[i][j] : _this.joinJsons(json[j], arguments[i][j]);
            }
        }
        return json;
    }
    this.objToStr = function (obj) { //不能处理function
        var v = "";
        if (_this.isJson(obj)) {
            v += "{";
            for (var a in obj) {
                if (v != "{") v += ",";
                v += a + ":" + _this.objToStr(obj[a]);
            }
            v += "}";
        } else if (_this.isArray(obj)) {
            v += "[";
            for (var i = 0; i < obj.length; i++) {
                if (v != "[") v += ",";
                v += _this.objToStr(obj[i]);
            }
            v += "]";
        } else if (typeof (obj) === "string") {
            return "\"" + obj.replace("\"", "\\\"") + "\"";
        } else {
            v += obj;
        }
        return v;
    }
    this.getQueryString = function (name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    };
    this.getQS = this.getQueryString;
    var readList = new Array();
    this.ready = function (fn, flag, index) {
        readList.push({ fn: fn, flag: flag || "undef", index: index || readList.length, called: false });
        readList = readList.sort(function (a, b) { return a.index > b.index ? 1 : a.index === b.index ? 0 : -1; });
        _this.bindReady();
    }
    this.fireReady = function () {
        for (var i = 0; i < readList.length; i++) {
            if (readList[i].called) continue;
            readList[i].fn.call();
            readList[i].called = true;
        }
        //while (readList.length > 0 && readList[0].called) readList.pop();
    }
    var hadBindedReady = false;
    this.bindReady = function () {
        if (document.readyState === "complete") return setTimeout(_this.fireReady, 1);
        if (!hadBindedReady) {
            if (document.addEventListener) {
                document.addEventListener("DOMContentLoaded", _this.fireReady, false);
                window.addEventListener("load", _this.fireReady, false);
            } else if (document.attachEvent) {
                document.attachEvent("onreadystatechange", _this.fireReady);
                window.attachEvent("onload", _this.fireReady);
            }
            hadBindedReady = true;
        }
    }
    this.includeStyle = function (url) {
        var style = document.createElement("link");
        style.type = "text/css";
        style.setAttribute("rel", "stylesheet");
        style.setAttribute("href", url);
        try {
            if (_this.IE) {
                _this.docElement().appendChild(style);
            }
            else if (document.getElementsByTagName("head") != null && document.getElementsByTagName("head").length > 0)
                document.getElementsByTagName("head")[0].appendChild(style);
            else _this.docElement().appendChild(style);
        } catch (e) { alert("includeStyle错误" + e.description); }
    };
    this.formToJson = function (opt) {
        var jumpEmpty = false;
        var obj;
        var dataJson = {};
        if (_this.isElement(opt)) {
            obj = opt;
        } else if (_this.isJson(opt)) {
            obj = opt.obj;
            dataJson = opt.data || {};
            jumpEmpty = _this.undef(opt.jumpEmpty, false);
        }
        var tags = ["INPUT", "SELECT", "TEXTAREA"];
        //try {
        for (var i = 0; i < tags.length; i++) {
            var elms = obj.getElementsByTagName(tags[i]);
            for (var j = 0; j < elms.length; j++) {
                var em = elms[j];
                var nm = ((em.name != "") ? em.name : em.id);
                if (nm) {
                    var element_value = "";
                    if (em.type == 'select-one') {
                        if (em.selectedIndex === null || em.selectedIndex < 0) continue;
                        element_value = em.options[em.selectedIndex].value;
                    }
                    else if (em.type == 'checkbox' || em.type == 'radio') {
                        if (em.checked == false) continue;
                        element_value = em.value;
                    }
                    else if (em.type == 'submit' || em.type == 'button' || em.type == 'reset') continue;
                    else {
                        if (JBInputInnerTips) element_value = JBInputInnerTips.val(em); //处理带有输入提示的元素
                        else element_value = em.value;
                    }
                    if (jumpEmpty && (element_value == null || element_value == "") && !(em.type == 'checkbox' || em.type == 'radio')) continue;
                    if (_this.attr(em, "data-valueHtmlEncode") == "true") element_value = JBody.htmlEncode(element_value);
                    if (_this.attr(em, "data-valueHtmlEncode") == "br") element_value = JBody.htmlEncode(element_value, true);
                    if (dataJson[nm] != null) {
                        if (!_JBody.isArray(dataJson[nm])) dataJson[nm] = [dataJson[nm]];
                        dataJson[nm].push(element_value);
                    }
                    else dataJson[nm] = element_value;
                    //alert("formToJson:" + nm + "=" + dataJson[nm]);
                }
            }
        }
        return dataJson;
        //} catch (e) { alert("formToJson错误" + e.description); return null; }
    }
    this.formToUrlStr = function (fc, jumpEmpty) {
        return _this.jsonToUrlStr(_this.formToJson({ obj: fc, jumpEmpty: jumpEmpty }));
    }
    this.jsonToUrlStr = function (json, options) {
        options = options || {};
        var a = options.and || "&";
        var eq = options.eq || "=";
        var i, query_string = "", and = "";
        try {
            for (var k in json) {
                if (!_JBody.isArray(json[k])) json[k] = [json[k]];
                for (var j = 0; j < json[k].length; j++) {
                    if (options.jumpEmpty === true && json[k][j] == "") continue;
                    query_string += and + k + eq + encodeURIComponent(json[k][j]);
                    and = a;
                }
            }
        } catch (e) { return ""; }
        return query_string;
    }
    this.getLocalUrl = function (clearLocalParm) {  //clearLocalParm 是否清除当前地址包含的参数
        var localUrl = location.href;
        if (clearLocalParm && localUrl.indexOf('?') >= 0) localUrl = (localUrl.indexOf('?') == 0 ? "" : localUrl.substr(0, localUrl.indexOf('?')));
        if (localUrl.substr(localUrl.length - 1, 1) == "#") localUrl = localUrl.substr(0, localUrl.length - 1);
        return localUrl;
    }
    this.createForm = function (obj, data, method, url, clearLocalParm, taget) {
        clearLocalParm = _this.defaultBool(clearLocalParm, true);  //是否清除当前地址包含的参数
        var localUrl = _this.getLocalUrl(clearLocalParm);
        var f = document.createElement("Form");
        f.style.display = "none";
        f.name = "from" + parseInt(Math.random() * 1000000);
        f.action = url || localUrl;
        f.method = method || "POST";
        if (taget) f.target = taget;  //提交到IFRAME或已打开页面
        if (obj) {
            f.appendChild(obj.cloneNode(true));  //textarea 动态select has a pro in firefox or ie       
            var objInputs = f.getElementsByTagName("TEXTAREA");
            var objInputs2 = obj.getElementsByTagName("TEXTAREA");
            for (var i = 0; i < objInputs.length; i++) {
                if (JBInputInnerTips) objInputs[i].value = JBInputInnerTips.val(objInputs2[i]);   //处理带有输入提示的元素
                else objInputs[i].value = objInputs2[i].value;
            }
            objInputs = f.getElementsByTagName("SELECT");
            objInputs2 = obj.getElementsByTagName("SELECT");
            for (var i = 0; i < objInputs.length; i++) objInputs[i].value = objInputs2[i].value;

            objInputs = f.getElementsByTagName("INPUT");
            objInputs2 = obj.getElementsByTagName("INPUT");
            for (var i = 0; i < objInputs.length; i++) {
                if (objInputs[i].type != "checkbox" && objInputs[i].type != "radio") {
                    if (JBInputInnerTips) objInputs[i].value = JBInputInnerTips.val(objInputs2[i]);   //处理带有输入提示的元素
                    continue;
                }
                objInputs[i].checked = objInputs2[i].checked;
                if (objInputs[i].checked && (objInputs[i].value == null || objInputs[i].value == "")) { objInputs[i].value = "on"; }
            }
        }
        if (data) for (var a in data) f.appendChild(_this.newObj((typeof (data[a]) == "string" && (data[a].length > 150 || data[a].indexOf("\r") >= 0 || data[a].indexOf("\n") >= 0)) ? "TEXTAREA" : "INPUT", { attrs: ["name", a], type: null, value: data[a] + "" }));
        return f;
    };
    //
    this.submit = function (obj, data, method, url, clearLocalParm, debug, taget) {
        if (arguments.length == 0) return;
        var f = _this.createForm(obj, data, method, url, clearLocalParm, taget);
        if (debug) {
            alert(f.innerHTML);
            alert(_this.formToUrlStr(f));
        }
        document.documentElement.appendChild(f);
        f.submit();
        document.documentElement.removeChild(f);
        f = null;
    };
    var _ajax = function () {
        var CBfunc, ObjSelf;
        ObjSelf = this;
        this.xmlReqObj = function () {
            var oXmlObj = null;
            try { oXmlObj = new XMLHttpRequest; }
            catch (e) {
                try { oXmlObj = new ActiveXObject("MSXML2.XMLHTTP"); }
                catch (e2) {
                    try { oXmlObj = new ActiveXObject("Microsoft.XMLHTTP"); }
                    catch (e3) { oXmlObj = false; }
                }
            }
            return oXmlObj;
        }
        var xmlObj = ObjSelf.xmlReqObj();
        var xmlObjNoCache = ObjSelf.xmlReqObj();
        if (!xmlObj) return false;
        if (arguments[0]) this.url = arguments[0]; else this.url = "";
        if (arguments[1]) this.callback = arguments[1]; else this.callback = function (obj) { return };
        if (arguments[2]) this.content = arguments[2]; else this.content = "";
        if (arguments[3]) this.method = arguments[3]; else this.method = "POST";
        if (arguments[4]) this.async = arguments[4]; else this.async = true;
        this.send = function () { //url,pc,callback,method,async,debug 或 {url,data,callbackData,callback,method,async,cache,debug,before,complete}
            var purl, pcbf, pcbfdt, pc, pm, pa, debug;
            var before = function () { };
            var complete = function () { };
            var cache = false;
            if (arguments[0] && _JBody.isJson(arguments[0])) {
                if (arguments[0].url) purl = arguments[0].url; else purl = ObjSelf.url;
                if (arguments[0].data) pc = arguments[0].data; else pc = ObjSelf.content;
                if (arguments[0].callbackData) pcbfdt = arguments[0].callbackData; else pcbfdt = null;
                if (arguments[0].callback) pcbf = arguments[0].callback; else pcbf = ObjSelf.callback;
                if (arguments[0].method) pm = arguments[0].method; else pm = ObjSelf.method;
                if (arguments[0].async !== null) pa = arguments[0].async; else pa = ObjSelf.async;
                cache = (arguments[0].cache === true);
                debug = (arguments[0].debug === true);
                if (arguments[0].before) before = arguments[0].before;
                if (arguments[0].complete) complete = arguments[0].complete;
            } else {
                if (arguments[0]) purl = arguments[0]; else purl = ObjSelf.url;
                if (arguments[1]) pc = arguments[1]; else pc = ObjSelf.content;
                if (arguments[2]) pcbf = arguments[2]; else pcbf = ObjSelf.callback;
                if (arguments[3]) pm = arguments[3]; else pm = ObjSelf.method;
                if (arguments[4]) pa = arguments[4]; else pa = ObjSelf.async;
                if ((arguments[5] !== null)) debug = (arguments[5] === true);
                if ((arguments[6] !== null)) cache = (arguments[6] === true);
            }
            if (!pm || !purl || !pa) return false;
            if (pc != null) {
                if (typeof (pc) != "string") pc = _JBody.jsonToUrlStr(pc);
                if (pm.toLowerCase() != "post") purl += (purl.indexOf("?") > 0 ? "&" : "?") + pc;
            }
            if (debug) alert(purl);
            if (debug) alert(pc);
            var xmlHttpObj = ObjSelf.xmlReqObj();
            xmlHttpObj.open(pm, purl, pa);
            if (pm.toLowerCase() == "post") xmlHttpObj.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            if (!cache) {
                xmlHttpObj.setRequestHeader("No-Cache", "1");
                xmlHttpObj.setRequestHeader("Pragma", "no-cache");
                xmlHttpObj.setRequestHeader("Cache-Control", "no-cache");
                xmlHttpObj.setRequestHeader("Expire", "0");
                xmlHttpObj.setRequestHeader("Last-Modified", "Wed, 1 Jan 1997 00:00:00 GMT");
                xmlHttpObj.setRequestHeader("If-Modified-Since", "-1");
            }
            xmlHttpObj.onreadystatechange = function () {
                if (xmlHttpObj.readyState == 4) {
                    if (xmlHttpObj.status == 200) {
                        pcbf(xmlHttpObj, pcbfdt);
                    }
                    else {
                        pcbf(null, pcbfdt);
                    }
                    complete();
                }
            }
            before();
            if (pm == "POST")
                xmlHttpObj.send(pc);
            else
                xmlHttpObj.send("");
        }
        this.get = function () { //url,callback,async, debug            
            if (arguments[0] && _JBody.isJson(arguments[0])) {
                var json = arguments[0];
                json.method = "GET";
                ObjSelf.send(json);
            } else {
                var purl, pcbf, debug;
                var async = true;
                if (arguments[0]) purl = arguments[0]; else purl = this.url;
                if (arguments[1]) pcbf = arguments[1]; else pcbf = this.callback;
                var async = !(arguments[2] === false);
                if (!purl && !pcbf) return false;
                ObjSelf.send(purl, "", pcbf, "GET", async, arguments[3]);
            }
        }
        this.postData = function (url, callback, data, async, debug) {
            if (arguments[0] && _JBody.isJson(arguments[0])) {
                var json = arguments[0];
                json.method = "POST";
                ObjSelf.send(json);
            } else {
                if (data == null) data = "";
                var pcbf = this.callback;
                async = !(async === false);
                if (callback != null) pcbf = callback;
                ObjSelf.send(url, typeof (data) == "string" ? data : this.jsonToUrlStr(data), pcbf, "POST", async, debug);
            }
        }
        this.post = function (url, callback, dataOrForm, method, async, debug) {
            if (!ObjSelf.postForm(dataOrForm, callback, url, method, async, debug))
                ObjSelf.postData(url, callback, dataOrForm, async, debug);
        }
        this.postForm = function (form, callback, url, method, async, debug) {  //form,callback,url,method,async,debug
            if (arguments[0] && _JBody.isJson(arguments[0])) {
                var json = arguments[0];
                json.method = "POST";
                if (_JBody.isJson(json.data)) json.data = _JBody.jsonToUrlStr(json.data);
                else if (typeof (json.data) != "string") { json.data = ""; }
                json.data += (json.data.indexOf("&") >= 0 ? "" : "&") + _JBody.formToUrlStr(json.form);
                ObjSelf.send(json);
            } else {
                var fo, pcbf, purl, pc, pm;
                if (form) fo = form; else return false;
                if (callback) pcbf = callback; else pcbf = this.callback;
                if (url) purl = url;
                else if (fo.action) purl = fo.action;
                else purl = this.url;
                if (method) pm = method;
                else if (fo.method) pm = fo.method.toLowerCase();
                else pm = "post";
                var async = !(async === false);
                if (!pcbf && !purl) return false;
                pc = _JBody.formToUrlStr(fo);
                if (!pc) return false;
                if (pm) {
                    if (pm.toLowerCase() == "post") ObjSelf.send(purl, pc, pcbf, "POST", async, debug);
                    else if (purl.indexOf("?") > 0) ObjSelf.send(purl + "&" + pc, "", pcbf, "GET", async, debug);
                    else ObjSelf.send(purl + "?" + pc, "", pcbf, "GET", async, debug);
                }
                else ObjSelf.send(purl, pc, pcbf, "POST", async, debug);
            }

        }
        this.postInputs = function (obj, callback, url, method, async, data, debug) {
            //var f = JB.createForm(obj, data, method, url);
            var newData = ObjSelf.formToJson({ obj: obj, data: data });
            ObjSelf.postData(url, callback, newData, async, debug);
        }
        this.jsonToUrlStr = _this.jsonToUrlStr;
        this.formToUrlStr = _this.formToUrlStr;
        this.formToJson = _this.formToJson;
    }
    this.ajax = new _ajax();
    var _json = function () {
        var _jsonSelf = this;
        this.test = function (obj) {
            var isjson = typeof (obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !(_JBody.isFunction(obj.pop) && _JBody.isFunction(obj.push));
            if (_JBody.IE) isjson = (isjson && !obj.length);  //IE下还有一些问题
            return isjson;
        }
        this.fromInputs = function (opt) {
            var jumpEmpty = false;
            var obj;
            var dataJson = {};
            if (_this.isElement(opt)) {
                obj = opt;
            } else if (_this.isJson(opt)) {
                obj = opt.obj;
                dataJson = opt.data || {};
                jumpEmpty = _this.undef(opt.jumpEmpty, false);
            }
            var tags = ["INPUT", "SELECT", "AREA"];
            try {
                for (var i = 0; i < tags.length; i++) {
                    var elms = obj.getElementsByTagName(tags[i]);
                    for (var j = 0; j < elms.length; j++) {
                        var em = elms[j];
                        var nm = ((em.name != "") ? em.name : em.id);
                        if (nm) {
                            var element_value = "";
                            if (em.type == 'select-one') {
                                element_value = em.options[em.selectedIndex].value;
                            }
                            else if (em.type == 'checkbox' || em.type == 'radio') {
                                if (em.checked == false) continue;
                                element_value = em.value;
                            }
                            else if (em.type == 'submit' || em.type == 'button' || em.type == 'reset') continue;
                            else {
                                if (JBInputInnerTips) element_value = JBInputInnerTips.val(em); //处理带有输入提示的元素
                                else element_value = em.value;
                            }
                            if (jumpEmpty && (element_value == null || element_value == "") && !(em.type == 'checkbox' || em.type == 'radio')) continue;
                            dataJson[nm] = element_value;
                        }
                    }
                }
                return dataJson;
            } catch (e) { alert("formToJson错误" + e.description); return null; }
        }
        return _jsonSelf;
    }
    this.json = new _json();
    var postback = function (objs, datas) {
        var url = document.location.href;
    }
    var _cookie = function () {
        var _selfThis = this;
        this.get = function (name) {
            var cookies = document.cookie.split(';');
            for (var i = 0, j = cookies.length; i < j; i++) {
                var str = cookies[i].replace(/^\s+|\s+$/g, '').split('=');
                if (str[0] == name) {
                    return decodeURIComponent(str[1]);
                }
            }
        };
        this.set = function (name, value, days, path, domain, secure) {
            var cookie = name + '=' + encodeURIComponent(value) + ';';
            if (typeof (days) == 'number') {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                cookie += 'expires=' + date.toGMTString() + ';';
            }
            path = (path) ? path : _selfThis._path;
            path = 'path=' + path + ';';
            cookie += path + ((domain) ? 'domain=' + domain + ';' : '') + ((secure) ? 'secure;' : '');
            document.cookie = cookie;
        };
        this.clear = function (name, path) {
            path = (path) ? path : _selfThis._path;
            this.set(name, '', 0, path);
        };
        this._path = '/';
    };
    this.cookie = new _cookie();
    this.htmlEncode = function (txt, lineToBr) {
        var t = txt.replace(/&/g, "&amp;").replace(/[ ]/g, "&nbsp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        if (lineToBr) {
            t = t.replace(/\r\n/g, "<br/>").replace(/\r/g, "<br/>").replace(/\n/g, "<br/>");
            t = t.replace(/&/g, "&amp;").replace(/[ ]/g, "&nbsp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");   //这里再次编码，注意了
        }
        return t;
    }
    this.htmlDecode = function (html, brToLine) {
        var h = html.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&nbsp;/g, " ").replace(/&amp;/g, "&");
        if (brToLine) {
            h = h.replace(/<br[\s]*[\/]?>/g, "\r\n");
            h = h.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&nbsp;/g, " ").replace(/&amp;/g, "&");   //这里再次解码，注意了
        }
        return h;
    }
    this.innerText = function (obj, txt) {
        if (_this.IE) {
            if (txt) obj.innerText = txt;
            else return obj.innerText;
        } else if (txt) {
            this.textContent = txt;
        } else {
            var anyString = "";
            var childS = obj.childNodes;
            for (var i = 0; i < childS.length; i++) {
                if (childS[i].nodeType == 1)
                    anyString += childS[i].tagName == "BR" ? '\n' : childS[i].textContent;
                else if (childS[i].nodeType == 3)
                    anyString += childS[i].nodeValue;
            }
            return anyString;
        }
    }
    var _scrollPos = null;
    var _scrollCallbackList = new Array();
    var _scrollCallback = function () {
        var spos = _this.getScrollPos();
        var diffX = spos.x - _scrollPos.x;
        var diffY = spos.y - _scrollPos.y;
        _scrollPos = spos;
        for (var i = 0; i < _scrollCallbackList.length; i++) {
            _scrollCallbackList[i](_scrollPos, diffX, diffY);
        }
    }
    this.scroll = function () {
        if (arguments.length == 0) return _this.getScrollPos();
        else if (_this.isFunction(arguments[0])) {
            _scrollCallbackList.push(arguments[0]);
            if (_scrollPos == null) {
                _scrollPos = _this.getScrollPos();
                _this.attach(window, "scroll", _scrollCallback);
            }
        } else {
            if (arguments.length == 1) window.scrollTo(arguments[0]);
            else window.scrollTo(arguments[0], arguments[1]);
        }
    }
    return _this;
}
var JB = J = JBody = new JBody();
//JB.loadCssStyle("/css/jbody.css");
//===============================================================================================
//可拖动元素
//===============================================================================================
function JBodyDragable() {
    //
    var JB = JBody;
    var _psize = JB.getPageSize();
    var isTest = true;
    var testTxt = "";
    var addTestMsg = function (msg) {
        if (isTest) testTxt += msg + "\r\n";
    }
    this.AlertText = function () {
        if (isTest) alert(testTxt);
    }
    //var callbacks = null;

    var init2 = function (mm, rt2) {  //转换坐标系
        mm.m = (mm.m == "obj") ? "obj" : (mm.m == "win") ? "win" : "doc"; //doc,win,obj
        if (mm.m == "win") {
            mm.target = window;
            var psz = JB.getPageSize();
            mm.l2 = mm.l > 0 ? mm.l : 0;
            mm.t2 = mm.t > 0 ? mm.t : 0;
            mm.r2 = mm.r > 0 && mm.r < psz.WinW ? mm.r : psz.WinW;
            mm.b2 = mm.b > 0 && mm.b < psz.WinH ? mm.b : psz.WinH;
            mm.l2 += document.documentElement.scrollLeft;
            mm.t2 += document.documentElement.scrollTop;
            mm.r2 += document.documentElement.scrollLeft;
            mm.b2 += document.documentElement.scrollTop;
        }
        else if (mm.m == "doc") {
            mm.target = document;
            var psz = JB.getPageSize();
            mm.l2 = mm.l > 0 ? mm.l : 0;
            mm.t2 = mm.t > 0 ? mm.t : 0;
            mm.r2 = mm.r > 0 && mm.r < psz.PageW ? mm.r : psz.PageW;
            mm.b2 = mm.b > 0 && mm.b < psz.PageH ? mm.b : psz.PageH;
        }
        else if (mm.m == "obj") {
            if (mm.target == null) mm.target = document.documentElement;
            if (!(mm.target.push)) mm.target = [mm.target];
            for (var j = 0; j < mm.target.length; j++) {
                if (typeof (mm.target[j]) === "string") mm.target[j] = document.getElementById(mm.target[j]);
            }
            var rt = absRectJoin(mm.target);
            mm.l2 = (mm.l > 0 || mm.l < 0) ? mm.l : 0;
            mm.t2 = (mm.t > 0 || mm.t < 0) ? mm.t : 0;
            mm.r2 = (mm.r > 0 || mm.r < 0) ? mm.r : rt.w;
            mm.b2 = (mm.h > 0 || mm.h < 0) ? mm.b : rt.h;
            mm.l2 += rt.l;
            mm.t2 += rt.t;
            mm.r2 += rt.l;
            mm.b2 += rt.t;
        }
        mm.l2 += rt2.l;
        mm.t2 += rt2.t;
        mm.r2 += rt2.r;
        mm.b2 += rt2.b;
        return mm;
    }
    this.dragStart = function (e) {
        e = e || window.event;
        if ((e.which && (e.which != 1)) || (e.button && (e.button != 1))) return;

        this.rect = absRectJoin(this.objs);
        this.dragObjRect = absRectJoin(this.objs[0]);
        var r2 = { l: this.dragObjRect.l - this.rect.l, t: this.dragObjRect.t - this.rect.t, r: this.dragObjRect.r - this.dragObjRect.w - this.rect.r, b: this.dragObjRect.b - this.dragObjRect.h - this.rect.b }
        this.opt.move = init2(this.opt.move, r2);   //转换成位移范围
        this.opt.sit = init2(this.opt.sit, r2);     //转换成位移范围

        addTestMsg(this.opt.move.m + "," + this.opt.move.l2 + "," + this.opt.move.t2 + "," + this.opt.move.r2 + "," + this.opt.move.b2);
        this.lastMousePos = { x: e.clientX + document.documentElement.scrollLeft, y: e.clientY + document.documentElement.scrollTop };
        this.mouseOffset = { x: 0, y: 0 };
        this.mOffset = { x: 0, y: 0 };

        this.dragOffset = { x: 0, y: 0 };
        this.dOffset = { x: 0, y: 0 };
        try {
            if (document.removeEventListener) {
                document.removeEventListener("mousemove", this.dragMove, true);
                document.removeEventListener("mouseup", this.dragEnd, true);
            }
            else {
                this.objs[0].detachEvent('onlosecapture', this.dragEnd);
                this.objs[0].detachEvent("onmousemove", this.dragMove);
                this.objs[0].detachEvent("onmouseup", this.dragEnd);
                this.objs[0].releaseCapture();
            }
        } catch (e) { }
        if (document.addEventListener) {
            document.addEventListener("mousemove", this.dragMove, true);
            document.addEventListener("mouseup", this.dragEnd, true);
        }
        else {
            this.objs[0].setCapture();
            this.objs[0].attachEvent("onlosecapture", this.dragEnd);
            this.objs[0].attachEvent("onmousemove", this.dragMove);
            this.objs[0].attachEvent("onmouseup", this.dragEnd);
        }
        this.stop(e);
    }
    this.dragMove = function (e) {
        e = e || window.event;
        var mousePos = { x: e.clientX + document.documentElement.scrollLeft, y: e.clientY + document.documentElement.scrollTop };
        this.mOffset = { x: mousePos.x - this.lastMousePos.x, y: mousePos.y - this.lastMousePos.y };
        this.lastMousePos = mousePos;
        this.mouseOffset.x += this.mOffset.x;
        this.mouseOffset.y += this.mOffset.y;

        var x = Math.max(this.opt.move.l2, Math.min(this.opt.move.r2, this.dragObjRect.l + this.mouseOffset.x));
        var y = Math.max(this.opt.move.t2, Math.min(this.opt.move.b2, this.dragObjRect.t + this.mouseOffset.y));

        //此处为新增的选项，允许直接指定范围
        if (this.opt.move.left && parseInt(this.opt.move.left) > 0 && this.opt.move.left < this.opt.move.r2)
            x = Math.max(this.opt.move.left, x);
        if (this.opt.move.right && parseInt(this.opt.move.right) > 0 && (this.opt.move.right - this.dragObjRect.w) > this.opt.move.l2)
            x = Math.min(this.opt.move.right - this.dragObjRect.w, x);
        if (this.opt.move.top && parseInt(this.opt.move.top) > 0 && parseInt(this.opt.move.top) < this.opt.move.b2)
            y = Math.max(this.opt.move.top, y);
        if (this.opt.move.bottom && parseInt(this.opt.move.bottom) > 0 && this.opt.move.bottom - this.dragObjRect.h > this.opt.move.t2)
            y = Math.min(this.opt.move.bottom - this.dragObjRect.h, y);

        this.dOffset = { x: x - this.dragObjRect.l - this.dragOffset.x, y: y - this.dragObjRect.t - this.dragOffset.y };
        this.dragOffset = { x: x - this.dragObjRect.l, y: y - this.dragObjRect.t };

        if (!(this.autosetMovePosition === false)) {
            for (var i = 0; i < this.objs.length; i++) {
                this.objs[i].style.left = (this.objs[i].offsetLeft + this.dOffset.x) + 'px';
                this.objs[i].style.top = (this.objs[i].offsetTop + this.dOffset.y) + 'px';
            }
        }
        this.pos = { l: this.dragObjRect.l + this.dragOffset.x, t: this.dragObjRect.t + this.dragOffset.y };
        this.stop(e);
        if (!this.callbacks) return;
        this.isout = (this.pos.l < this.opt.move.l2 || this.pos.l > this.opt.move.r2 || this.pos.t < this.opt.move.t2 || this.pos.t > this.opt.move.b2);
        this.isfullout = this.isout && (this.pos.l < this.sit.move.l2 || this.pos.l > this.opt.sit.r2 || this.pos.t < this.opt.sit.t2 || this.pos.t > this.opt.sit.b2);
        var pram = { mouseOffset: this.mouseOffset, mOffset: this.mOffset, dragOffset: this.dragOffset, dOffset: this.dOffset, objs: this.objs, data: this.opt.data };
        if (this.isfullout && JB.isFunction(this.callbacks.onmovefullout)) this.callbacks.onmovefullout(pram);
        if (this.isout && JB.isFunction(this.callbacks.onmoveout)) this.callbacks.onmoveout(pram);
        if (JB.isFunction(this.callbacks.onmove)) this.callbacks.onmove(pram);
    }
    this.dragEnd = function (e) {
        e = e || window.event;
        if ((e.which && (e.which != 1)) || (e.button && (e.button != 1))) return;

        try {
            if (document.removeEventListener) {
                document.removeEventListener("mousemove", this.dragMove, true);
                document.removeEventListener("mouseup", this.dragEnd, true);
            }
            else {
                this.objs[0].detachEvent('onlosecapture', this.dragEnd);
                this.objs[0].detachEvent("onmousemove", this.dragMove);
                this.objs[0].detachEvent("onmouseup", this.dragEnd);
                this.objs[0].releaseCapture();
            }
        } catch (e) { }
        this.stop(e);
        if (this.callbacks) {
            var pram = { mouseOffset: this.mouseOffset, dragOffset: this.dragOffset, objs: this.objs, data: this.opt.data };
            if (this.isfullout && JB.isFunction(this.callbacks.ondragfullout)) this.callbacks.ondragfullout(pram);
            if (this.isout && JB.isFunction(this.callbacks.ondragout)) this.callbacks.ondragout(pram);
            if (JB.isFunction(this.callbacks.ondrag)) this.callbacks.ondrag(pram);
        }
        if (this.pos == null) return;
        if (!(this.autosetSitPosition === false)) {
            var x = Math.max(this.opt.sit.l2, Math.min(this.opt.sit.r2, this.pos.l));
            var y = Math.max(this.opt.sit.t2, Math.min(this.opt.sit.b2, this.pos.t));

            //此处为新增的选项，允许直接指定范围
            if (this.opt.sit.left && parseInt(this.opt.sit.left) > 0 && parseInt(this.opt.sit.left) < this.opt.sit.r2)
                x = Math.max(this.opt.sit.left, x);
            if (this.opt.sit.right && parseInt(this.opt.sit.right) > 0 && this.opt.sit.right - this.dragObjRect.w > this.opt.sit.l2)
                x = Math.min(this.opt.sit.right - this.dragObjRect.w, x);
            if (this.opt.sit.top && parseInt(this.opt.sit.top) > 0 && parseInt(this.opt.sit.top) < this.opt.sit.b2)
                y = Math.max(this.opt.sit.top, y);
            if (this.opt.sit.bottom && parseInt(this.opt.sit.bottom) > 0 && this.opt.sit.bottom - this.dragObjRect.h > this.opt.sit.t2)
                y = Math.min(this.opt.sit.bottom - this.dragObjRect.h, y);

            var ofs = { x: x - this.pos.l, y: y - this.pos.t };
            for (var i = 0; i < this.objs.length; i++) {
                this.objs[i].style.left = (this.objs[i].offsetLeft + ofs.x) + 'px';
                this.objs[i].style.top = (this.objs[i].offsetTop + ofs.y) + 'px';
            }
        }
    }
    this.stop = function (e) {
        if (e.stopPropagation) { e.stopPropagation(); } else { e.cancelBubble = true; }
        if (e.preventDefault) { e.preventDefault(); } else { e.returnValue = false; }
    }
    this.create = function (bind) {
        var B = this;
        var A = bind;
        return function (e) { return B.apply(A, [e]); }
    }
    this.dragStart.create = this.create;
    this.dragMove.create = this.create;
    this.dragEnd.create = this.create;
    this.stop.create = this.create;

    this.rect = function (minL, maxL, minT, maxT) { return { l: minL, r: maxL, t: minT, b: maxT } };


    var absRectJoin = function (objs) {   //获取一组元素的绝对位置的范围
        var getRect = function (obj) {
            if (obj == null) return { l: 0, t: 0, r: 0, b: 0, w: 0, h: 0 };
            var ofs = JB.getAbsoluteOffset(obj);
            return { l: ofs.l, t: ofs.t, r: ofs.l + (obj.offsetWidth || obj.clientWidth), b: ofs.t + (obj.offsetHeight || obj.clientHeight), w: (obj.offsetWidth || obj.clientWidth), h: (obj.offsetHeight || obj.clientHeight) };
        }
        if (objs.push) {
            var ps = getRect(objs[0]);
            for (var i = 1; i < objs.length; i++) {
                var rt = getRect(objs[i]);
                ps = { l: Math.min(ps.l, rt.l), t: Math.min(ps.t, rt.t), r: Math.max(ps.r, rt.r), b: Math.max(ps.b, rt.b) }
                ps = { l: ps.l, t: ps.t, r: ps.r, b: ps.b, w: ps.r - ps.l, h: ps.b - ps.t };
            }
            return ps;
        } else return getRect(objs);
    }
    var dragList = new Array();
    this.initialize = function () {
        //{objs:"",opt:{move,sit,callbacks:[]}
        // move:{m:'doc'|'win'|'obj',target,l,r,t,b}
        // [,[]]
        for (var i = 0; i < arguments.length; i++) {
            var arg = arguments[i];
            if (arg == null) continue;
            if (!arg.objs) {
                var argTemp = new Object();
                argTemp.objs = (!arg.push) ? [arg] : arg;
                arg = argTemp;
            } else {
                if (!(arg.objs.push)) arg.objs = [arg.objs];
            }
            for (var j = 0; j < arg.objs.length; j++) {
                if (typeof (arg.objs[j]) === "string") arg.objs[j] = document.getElementById(arg.objs[j]);
            }
            if (!arg.objs[0]) continue;
            if (!arg.opt) arg.opt = new Object();
            arg.opt.move = arg.opt.move || arg.opt.sit || { m: "doc" }; //doc,win,obj
            arg.opt.sit = arg.opt.sit || arg.opt.move || { m: "doc" };
            arg.stop = this.stop.create(arg);
            arg.dragMove = this.dragMove.create(arg);
            arg.dragEnd = this.dragEnd.create(arg);
            arg.dragStart = this.dragStart.create(arg);
            if (arg.objs[0].addEventListener) {
                arg.objs[0].addEventListener("mousedown", arg.dragStart, false);
            }
            else {
                arg.objs[0].attachEvent("onmousedown", arg.dragStart);
            }
            dragList.push(arg);
        }
    }
    this.cancelDragable = function () {
        while (dragList.length > 0) {
            var arg = dragList.pop();
            if (arg.objs[0].removeEventListener) {
                arg.objs[0].removeEventListener("mousedown", arg.dragStart, false);
            }
            else {
                arg.objs[0].detachEvent("onmousedown", arg.dragStart);
            }
        }
    }
    this.initialize.apply(this, arguments);
};
function JBodyResizeable(option) {
    //option :{obj,rect:{l,r,t,b,obj},min:{w,h},max:{w,h},square:false,callbacks:{resizeing,after}}
    if (option == null) return;
    var _this = this;
    this.option = option;
    var obj = option.obj;
    if (typeof (obj) == "string") obj = document.getElementById(obj);
    this.obj = obj;
    var _emtyfun = function () { return; }
    this.resizeing = _emtyfun;
    this.after = _emtyfun;
    var _toolWidth = 2;
    var _zIndex = option.zIndex || null;
    this.min = { w: 4, h: 4 };
    this.max = { w: 0, h: 0 };
    this.limit = { l: 0, r: 0, t: 0, b: 0 };
    var _square = false;
    var _getScaling = function (sc) {
        var s = sc || "none";
        s = JB.trim(s.toLowerCase());
        if (s != "" && s != "none" && !(s.indexOf("left") > 0 || s.indexOf("right") > 0)) s += "leftright";
        if (s != "" && s != "none" && !(s.indexOf("top") > 0 || s.indexOf("bottom") > 0)) s += "topbottom";
        return s;
    }
    var _scaling = (_this.option && _this.option.scaling) ? _getScaling(_this.option.scaling) : "none";
    var _newBt = function (cur) {
        var obj = JB.opacity(JB.newObj("DIV", { w: 2, h: 2, bgColor: "#FFFFFF", css: [["position", "absolute"], ["cursor", cur]] }), 1);
        if (_zIndex > 0) JB.setOpt(obj, { css: ["zIndex", _zIndex] });
        return obj;
    }
    var _cus = ["n-resize", "s-resize", "e-resize", "w-resize", "nw-resize", "ne-resize", "sw-resize", "se-resize"];
    var _side = new Array();
    for (var kk = 0; kk < _cus.length; kk++) {
        _side.push(
        {
            w: _cus[kk].substr(0, 2).indexOf("w") >= 0,
            s: _cus[kk].substr(0, 2).indexOf("s") >= 0,
            e: _cus[kk].substr(0, 2).indexOf("e") >= 0,
            n: _cus[kk].substr(0, 2).indexOf("n") >= 0,
            c: _cus[kk].indexOf('-') > 1
        });
    }
    var _arrDiv = new Array();
    var _arrDrag = new Array();
    var _getDiv = function (s) {
        switch (s) {
            case "n": return _arrDiv[0];
            case "s": return _arrDiv[1];
            case "e": return _arrDiv[2];
            case "w": return _arrDiv[3];
            case "nw": return _arrDiv[4];
            case "ne": return _arrDiv[5];
            case "sw": return _arrDiv[6];
            case "se": return _arrDiv[7];
            default: { alert(s); return null; }
        }
    }
    this.builded = false;

    this.cancel = function () {
        for (var i = 0; i < _arrDrag.length; i++) try { _arrDrag[i].cancelDragable(); } catch (e) { }
        _arrDrag = new Array();
        for (var i = 0; i < _arrDiv.length; i++) if (_arrDiv[i].parentNode) _arrDiv[i].parentNode.removeChild(_arrDiv[i]);
        _arrDiv = new Array();
        _this.builded = false;
    }
    var _resetOption = function () {
        if (_this.option) {
            _this.resizeing = _this.option.resizeing || _emtyfun;
            _this.after = _this.option.after || _emtyfun;
            if (_this.option.min) {
                _this.min.w = Math.max(_this.option.min.w || 4, 4);
                _this.min.h = Math.max(_this.option.min.h || 4, 4);
            }
            if (_this.option.max) {
                _this.max.w = _this.option.max.w;
                _this.max.h = _this.option.max.h;
            }
            if (_this.option.limit) {
                _this.limit.l = _this.option.limit.l || _this.option.limit.left || 0;
                _this.limit.r = _this.option.limit.r || _this.option.limit.right || 0;
                _this.limit.t = _this.option.limit.t || _this.option.limit.top || 0;
                _this.limit.b = _this.option.limit.b || _this.option.limit.bottom || 0;
                if (_this.option.limit.obj) {
                    if (typeof (_this.option.limit.obj) === "string") _this.option.limit.obj = document.getElementById(_this.option.limit.obj);
                    if (_this.option.limit.obj) {
                        var p2 = JB.getAbsolutePosition(_this.option.limit.obj);
                        _this.limit.l = Math.max(_this.limit.l, p2.l);
                        _this.limit.r = Math.max(_this.limit.r, p2.l2);
                        _this.limit.t = Math.max(_this.limit.t, p2.t);
                        _this.limit.b = Math.max(_this.limit.b, p2.t2);
                    }
                }
            }
            _square = _this.option.square || false;
        }
    }
    var _isDireSide = function (i, s) { return _cus[i].substr(0, 2).indexOf(s) >= 0; };
    var _joinMaxMin = function (opt, rsObjPos, dragObjPos, side) {
        var o = { left: 0, right: 0, top: 0, bottom: 0 };
        if (!isNaN(parseInt(opt.left))) o.left = parseInt(opt.left);
        if (!isNaN(parseInt(opt.right))) o.right = parseInt(opt.right);
        if (!isNaN(parseInt(opt.top))) o.top = parseInt(opt.top);
        if (!isNaN(parseInt(opt.bottom))) o.bottom = parseInt(opt.bottom);
        //var side = { w: side.w, s: side.s, e: side.e, n: side.n, c: side.c }
        if (_this.option) {
            if (_this.option.max) {
                if (_this.option.max.w > 0) {
                    if (side.w) o.left = Math.max(o.left, rsObjPos.l - (_this.option.max.w - rsObjPos.w));
                    else if (side.e) o.right = Math.min(o.right, rsObjPos.l2 + (_this.option.max.w - rsObjPos.w));
                }
                if (_this.option.max.h > 0) {
                    if (side.n) o.top = Math.max(o.top, rsObjPos.t - (_this.option.max.h - rsObjPos.h));
                    else if (side.s) o.bottom = Math.min(o.bottom, rsObjPos.t2 + (_this.option.max.h - rsObjPos.h));
                }
            }
            if (_this.option.min) {
                if (_this.option.min.w > 0) {
                    if (side.w) o.right = Math.min(o.right, rsObjPos.l + (rsObjPos.w - _this.option.min.w) + dragObjPos.w);
                    else if (side.e) o.left = Math.max(o.left, rsObjPos.l2 - (rsObjPos.w - _this.option.min.w) - dragObjPos.w);
                }
                if (_this.option.min.h > 0) {
                    if (side.n) o.bottom = Math.min(o.bottom, rsObjPos.t2 - _this.option.min.h + dragObjPos.h);
                    else if (side.s) o.top = Math.max(o.top, rsObjPos.t + _this.option.min.h - dragObjPos.h);
                }
            }
        }
        if (!side.c) {
            if (side.w || side.e) {
                o.top = Math.max(dragObjPos.t, o.top);
                o.bottom = Math.min(dragObjPos.t2, o.bottom);
            } else {
                o.left = Math.max(dragObjPos.l, o.left);
                o.right = Math.min(dragObjPos.l2, o.right);;
            }
        }
        //考虑其他边的影响
        if (side.n) o.bottom = Math.min(rsObjPos.t2 - _toolWidth, o.bottom);
        if (side.w) o.right = Math.min(rsObjPos.l2 - _toolWidth, o.right);
        if (side.s) o.top = Math.max(rsObjPos.t + _toolWidth, o.top);
        if (side.e) o.left = Math.max(rsObjPos.l + _toolWidth, o.left);
        //比例缩放时考虑其他边的影响
        if (_scaling != "none") {

        }
        return { move: o };
    }
    this.dragmove = function (aParm) {
        var i = aParm.data;
        var x = aParm.dOffset.x;
        var y = aParm.dOffset.y;
        if (_square) {
            switch (i) {
                case 0://上
                case 5://右上
                    i = 5;
                    x = -y;
                    break;
                case 1://下
                case 7://右下
                    i = 7;
                    x = y;
                    break;
                case 2://右
                    i = 7;
                    y = x;
                    break;
                case 3://左
                case 6://左下
                    i = 6;
                    y = -x;
                    break;
                case 4://左上
                    y = x;
                    break;
            }

            var p = JB.getAbsolutePosition(_this.obj);
            var dragOpt = { left: _this.limit.l, right: _this.limit.r, top: _this.limit.t, bottom: _this.limit.b };
            if (x == 0 && y == 0) { return; }

            if (x > 0) {
                if (p.l2 + x > dragOpt.right) { x = dragOpt.right - p.l2; }
            }
            else if (x < 0) {
                if (p.l + x < dragOpt.left) { x = dragOpt.left - p.l; }
            }
            if (y > 0) {
                if (p.t2 + y > dragOpt.bottom) { y = dragOpt.bottom - p.t2; }
            } else if (y < 0) {
                if (p.t + y > dragOpt.top) { y = dragOpt.top - p.t; }
            }

            x = x > 0 ? Math.min(x, Math.abs(y)) : -Math.min(Math.abs(x), Math.abs(y));
            y = y > 0 ? Math.abs(x) : -Math.abs(x);
        }

        if (x != 0) {
            if (_side[i].w) {
                JB.setOpt(_this.obj, { w: _this.obj.clientWidth - x, l: _this.obj.offsetLeft + x });
                JB.setOpt(_getDiv("n"), { w: _getDiv("n").offsetWidth - x });
                JB.setOpt(_getDiv("s"), { w: _getDiv("s").offsetWidth - x });
                var ss = ["n", "s", "w", "nw", "sw"];
                for (var k = 0; k < ss.length; k++) {
                    if (_arrDiv[i] != _getDiv(ss[k])) JB.setOpt(_getDiv(ss[k]), { l: _getDiv(ss[k]).offsetLeft + x });
                }
            } else if (_side[i].e) {
                JB.setOpt(_this.obj, { w: _this.obj.clientWidth + x });
                JB.setOpt(_getDiv("n"), { w: _getDiv("n").offsetWidth + x });
                JB.setOpt(_getDiv("s"), { w: _getDiv("s").offsetWidth + x });
                var ss = ["e", "ne", "se"];
                for (var k = 0; k < ss.length; k++) {
                    if (_arrDiv[i] != _getDiv(ss[k])) JB.setOpt(_getDiv(ss[k]), { l: _getDiv(ss[k]).offsetLeft + x });
                }
            }
        }
        if (y != 0) {
            if (_side[i].n) {
                JB.setOpt(_this.obj, { h: _this.obj.clientHeight - y, t: _this.obj.offsetTop + y });
                JB.setOpt(_getDiv("w"), { h: _getDiv("w").offsetHeight - y });
                JB.setOpt(_getDiv("e"), { h: _getDiv("e").offsetHeight - y });
                var ss = ["w", "n", "e", "nw", "ne"];
                for (var k = 0; k < ss.length; k++) {
                    if (_arrDiv[i] != _getDiv(ss[k])) JB.setOpt(_getDiv(ss[k]), { t: _getDiv(ss[k]).offsetTop + y });
                }
            } else if (_side[i].s) {
                JB.setOpt(_this.obj, { h: _this.obj.clientHeight + y });
                JB.setOpt(_getDiv("w"), { h: _getDiv("w").offsetHeight + y });
                JB.setOpt(_getDiv("e"), { h: _getDiv("e").offsetHeight + y });
                var ss = ["s", "sw", "se"];
                for (var k = 0; k < ss.length; k++) {
                    if (_arrDiv[i] != _getDiv(ss[k])) JB.setOpt(_getDiv(ss[k]), { t: _getDiv(ss[k]).offsetTop + y });
                }
            }
        }
        _this.resizeing();
    }
    this.moveBars = function (parm) {  //当应用于可拖动元素时，这个有用
        if (!_this.builded) { return; }
        var x = parm.x || parm.dOffset.x || 0;
        var y = parm.x || parm.dOffset.y || 0;
        if (x != 0 || y != 0) {
            for (var i = 0; i < _arrDiv.length; i++) JB.setOpt(_arrDiv[i], { l: _arrDiv[i].offsetLeft + x, t: _arrDiv[i].offsetTop + y });
        }
    }
    this.fix = function (p) {
        if (_arrDiv.length < 8) return;
        var p = p || JB.getAbsolutePosition(_this.obj);
        JB.setOpt([_getDiv("n"), _getDiv("nw"), _getDiv("ne"), _getDiv("w"), _getDiv("e")], { t: p.t });
        JB.setOpt([_getDiv("s"), _getDiv("sw"), _getDiv("se")], { t: p.t2 - 2 });
        JB.setOpt([_getDiv("n"), _getDiv("w"), _getDiv("s"), _getDiv("nw"), _getDiv("sw")], { l: p.l });
        JB.setOpt([_getDiv("e"), _getDiv("ne"), _getDiv("se")], { l: p.l2 - 2 });
        JB.setOpt([_getDiv("n"), _getDiv("s")], { w: p.w });
        JB.setOpt([_getDiv("w"), _getDiv("e")], { h: p.h });
    };
    this.build = function () {
        var p = JB.getAbsolutePosition(_this.obj);
        if (p.w < 4 || p.h < 4) return;
        _this.cancel();
        _resetOption();
        for (var i = 0; i < _cus.length; i++) {
            _arrDiv.push(_newBt(_cus[i]));
            JB.docElement().appendChild(_arrDiv[i]);
        }
        _this.fix();
        for (var i = 0; i < _cus.length; i++) {
            var dragOpt = { left: _this.limit.l, right: _this.limit.r, top: _this.limit.t, bottom: _this.limit.b };
            if (p.l < dragOpt.left || p.l2 > dragOpt.right || p.t < dragOpt.top || p.t2 > dragOpt.bottom) {
                _arrDrag.push(new Object());  //已超出限制的区域
                continue;
            }
            var posDraObj = JB.getAbsolutePosition(_arrDiv[i]);
            dragOpt = _joinMaxMin(dragOpt, p, posDraObj, _side[i]);
            //alert(JB.jsonToUrlStr(_side[i])+"  ;; "+JB.jsonToUrlStr(dragOpt.move));
            dragOpt.data = i;
            try {
                _arrDrag.push(new JBodyDragable({ objs: _arrDiv[i], opt: dragOpt, callbacks: { onmove: _this.dragmove, ondrag: _this.toolDrag } }));
            } catch (e) {
                alert("build错误" + e.description);
            }
        }
        _this.builded = true;
    };
    this.toolDrag = function () {
        _this.after();
        _this.build();
    }
    this.rebuild = function () {
        _this.build();
    }
    this.build();
    return _this;
}
/*/
/*/
function JBFollowScroll(objs, opt, toObjs) {
    var _this = this;
    var _option = { d: "all", near: "left top", asMore: true }  //asMore优先于near
    this.before = function (spos) { return true; };
    if (opt && opt.d) _option.d = opt.d;
    if (opt && opt.near) _option.near = opt.near;
    if (opt && opt.asMore != null) _option.asMore = opt.asMore;
    if (opt && opt.before != null) this.before = opt.before;

    if (typeof (objs) === "string") objs = document.getElementById(objs);
    if (objs == null) return;
    if (!objs.push) objs = [objs];
    var objPos = JB.getAbsolutePosition(objs);

    var pgSz = JB.getPageSize();
    var limitPos = { l: 0, t: 0, l2: pgSz.PageW, t2: pgSz.PageH };
    if (typeof (toObjs) === "string") toObjs = document.getElementById(toObjs);
    if (toObjs != null) limitPos = JB.getAbsolutePosition(toObjs);

    var pointNearAsCan = { l: limitPos.l, t: limitPos.t };
    if (_option.near.indexOf("left") >= 0 && _option.near.indexOf("right") >= 0) {
        pointNearAsCan.l = (limitPos.l + limitPos.l2 - objPos.w) / 2;
    } else if (_option.near.indexOf("right") >= 0) {
        pointNearAsCan.l = limitPos.l2 - objPos.w;
    }
    if (_option.near.indexOf("top") >= 0 && _option.near.indexOf("bottom") >= 0) {
        pointNearAsCan.t = (limitPos.t + limitPos.t2 - objPos.h) / 2;
    } else if (_option.near.indexOf("bottom") >= 0) {
        pointNearAsCan.t = limitPos.t2 - objPos.h;
    }
    var _scrollPos = JB.getScrollPos();
    var _followScroll = function () {
        var spos = JB.getScrollPos();
        if (_this.before(spos) == false) return;
        var diffX = spos.x - _scrollPos.x;
        var diffY = spos.y - _scrollPos.y;
        _scrollPos = spos;
        objPos = JB.getAbsolutePosition(objs);
        var seeSize1 = (Math.min(spos.x + pgSz.WinW, objPos.l2) - Math.max(spos.x, objPos.l)) * (Math.min(spos.y + pgSz.WinH, objPos.t2) - Math.max(spos.y, objPos.t))
        var near1 = (objPos.l - pointNearAsCan.l) * (objPos.l - pointNearAsCan.l) + (objPos.t - pointNearAsCan.t) * (objPos.t - pointNearAsCan.t);
        objPos.l += diffX;
        objPos.l2 += diffX;
        objPos.t += diffY;
        objPos.t2 += diffY;
        var seeSize2 = (Math.min(spos.x + pgSz.WinW, objPos.l2) - Math.max(spos.x, objPos.l)) * (Math.min(spos.y + pgSz.WinH, objPos.t2) - Math.max(spos.y, objPos.t))
        var near2 = (objPos.l - pointNearAsCan.l) * (objPos.l - pointNearAsCan.l) + (objPos.t - pointNearAsCan.t) * (objPos.t - pointNearAsCan.t);
        var seeMore = seeSize2 - seeSize1;
        var isFarFromPointNearAsCan = near2 > near1;
        if (_option.asMore && seeMore < 0) return;
        if (isFarFromPointNearAsCan && seeMore == 0) return;

        if (!(objPos.l >= limitPos.l && objPos.l2 <= limitPos.l2)) {
            if (objPos.l <= limitPos.l && objPos.l2 >= limitPos.l2) { diffX = 0; }
            else if (objPos.l < limitPos.l) { diffX -= limitPos.l - objPos.l; }
            else if (objPos.l2 > limitPos.l2) { diffX -= objPos.l2 - limitPos.l2; }
            else { diffX = 0; }
        }
        if (!(objPos.t >= limitPos.t && objPos.t2 <= limitPos.t2)) diffY = 0;
        if (diffX != 0 || diffY != 0) {
            for (i = 0; i < objs.length; i++) {
                var l = parseInt(objs[i].style.left) + ((_option.d == "y") ? 0 : diffX);
                var t = parseInt(objs[i].style.top) + ((_option.d == "x") ? 0 : diffY);
                JB.setOpt(objs[i], { l: l, t: t });
            }
        }
    }
    var _destroy = function () {
        _this.detachAutoScroll();
        _this = null;
    }
    this.detachAutoScroll = function () { JB.detach(window, "scroll", _followScroll); };
    JB.attach(window, "scroll", _followScroll);
    //JB.attach(window, "unload", _destroy);
    return _this;
}

/**/
function JBodyDialogContainer() {
    var list = new Array();
    this.add = function (jbdlg) {
        for (var i = 0; i < list.length; i++) if (list[i] == jbdlg) return;
        list.push(jbdlg);
    };
    this.close = function (name) {
        for (var i = 0; i < list.length; i++) list[i].close(name);
    }
    this.pop = function (jbdlg) {
        for (var i = 0; i < list.length; i++) {
            if (list[0] == jbdlg) list.shift();
            else list.push(list.shift());
        }
    }
    var _maxZIndex = 100000;
    this.maxZIndex = function () { _maxZIndex++; return _maxZIndex; }
}
var JBodyDialogContainer = new JBodyDialogContainer();
/*
 JBDialog  可以直接使用的对象，也可以使用 new JBodyDialog(opt)新建对象
 */
var JBodyDialogDefaultSetting = {
    colors: [/*border*/"#2C7ECF", /*bg*/"#ffffff", /*titleBg*/"#5996DA", /*title*/"#ffffff", /*win*/"#333333", /*titleBorder*/"#2C7ECF", /*alphaBorder*/"#dddddd", /*shadow*/"#1472D6", /*modal*/"#dddddd"],
    btcolors: ["#333333", "#94BCE8", "#A4C7EE", "#ffffff", "#2C7ECF", "#eeeeee"],  //0,1bg,2bd:mouseout   3,4bg,5bd:mouseover
    alphaBorder: (JB.IE && JB.V < 8) ? 0 : 0,
    shadow: 2,
    padding: 5,
    titlePaddingLeft: 5,
    titleFontSize: 12,
    borderInner: 1,
    cssClass: { title: "", dialog: "", button: "" },
    corner: { tL: 2, tR: 2, bL: 4, bR: 4 },
    titleH: 27,
    buttonWH: 14
}
var JBodyPosition = (function () {
    var _this = this;
    var _parkOutsideSetting = [    //偏移设置
	    ["0,0,-1,0", "auto"],  //topLeft
	    ["-1,0,-1,0", "cornerTopLeft", "cornerLeftTop", "TopLeftcorner", "LeftTopcorner"], ["0,0,-1,0", "topLeft"], ["-0.5,0.5,-1,0", "top", "topCenter"], ["-1,1,-1,0", "topRight"], ["0,1,-1,0", "cornerTopRight", "cornerRightTop", "TopRightcorner", "RightTopcorner"],
	    ["-1,0,0,0", "leftTop"], ["0,1,0,0", "rightTop"],
	    ["-1,0,-0.5,0.5", "left", "leftCenter"], ["0,1,-0.5,0.5", "right", "rightCenter"],
	    ["-1,0,-1,1", "leftBottom"], ["0,1,-1,1", "rightBottom"],
	    ["-1,0,0,1", "cornerBottomLeft", "cornerLeftBottom", "BottomLeftcorner", "LeftBottomcorner"], ["0,0,0,1", "bottomLeft"],
	    ["-0.5,0.5,0,1", "bottom", "bottomCenter", "bottomMid", "bottomMiddle"], ["-1,1,0,1", "bottomRight"],
	    ["0,1,0,1", "cornerBottomRight", "cornerRightBottom", "BottomRightcorner", "RightBottomcorner"]
    ];
    var _parkInsideSetting = [  //偏移设置
	    ["-0.5,0.5,-0.5,0.5", "auto"],  //center
	    ["0,0,0,0", "topLeft"], ["-0.5,0.5,0,0", "top", "topcenter"], ["-1,1,0,0", "topRight", "rightTop"],
	    ["0,0,-0.5,0.5", "left", "leftcenter", "leftmiddle"], ["-0.5,0.5,-0.5,0.5", "center", "mid", "middle"], ["-1,1,-0.5,0.5", "right", "rightcenter", "rightmiddle"],
	    ["0,0,-1,1", "bottomLeft"], ["-0.5,0.5,-1,1", "bottom", "bottomcenter"], ["-1,1,-1,1", "bottomRight", "rightBottom"]
    ];
    this.createPosition = function (pos) {
        var ps = {
            to: "doc",    //auto,win,doc,elm,obj,downpos,selfwin,topwin,parentwin
            parent: "auto",    //auto|document|body|Object
            park: "inside",    //inside|outside  后面可以附加_parkInsideSetting或_parkOutsideSetting中的相关值  如 "win inside topLeft notsmart"
            parkInside: "auto",   //不建议使用，（建议直接在park 选项中设置此值）
            parkOutside: "auto",   //不建议使用，（建议直接在park 选项中设置此值）
            parkSmart: true,   //超出范围时是否可以智能调整, 兼容之前的版本，不建议使用（可以在park设置notsmart使此值为false）
            offset: { l: 0, t: 0 },
            posSet: "",
            topWin: true   //兼容之前的版本，不建议使用
        };
        pos = pos || {};
        if (typeof (pos.to) == "string" && ",,,win,doc,selfwin,parentwin,topwin,topdoc,downpos,,".indexOf("," + pos.to.toLowerCase() + ",") > 0) { ps.to = pos.to.toLowerCase(); ps.park = "inside"; }
        else if (pos.to == "obj" || pos.to == "elm") ps.to = "obj";
        else { ps.to = "doc"; ps.park = "inside"; }
        if (typeof (pos.park) == "string") {   //用一个字段表示，更加简洁，同时兼容以前的方式
            var parksp = pos.park.toLowerCase().split(/[ ,;]/g);
            for (var i = 0; i < parksp.length; i++) {
                if (",,,obj,win,doc,selfwin,parentwin,topwin,topdoc,downpos,,".indexOf("," + parksp[i] + ",") > 0) {
                    ps.to = parksp[i];  //这里优先级比直接设置pos.to要高
                    ps.park = "inside";
                }
            }
            for (var i = 0; i < parksp.length; i++) {
                if (parksp[i] == "inside" || (parksp[i] == "outside" && ps.to == "obj")) ps.park = parksp[i];
                if (parksp[i] == "notsmart") ps.parkSmart = false;
                if (parksp[i].indexOf(":") > 0) {
                    var parksp2 = parksp[i].split(":");  //可以直接在park项目中定义偏移值
                    if (JB.trim(parksp2[0]) == "left" && !isNaN(parseInt(parksp2[1]))) ps.offset.l = parseInt(parksp2[1]);
                    if (JB.trim(parksp2[0]) == "top" && !isNaN(parseInt(parksp2[1]))) ps.offset.t = parseInt(parksp2[1]);
                }
            }
            var _park_setting = (ps.park == "inside" ? _parkInsideSetting : _parkOutsideSetting);
            for (var i = 0; i < parksp.length; i++) {
                for (var j = 0; j < _park_setting.length; j++) {
                    for (var k = 1; k < _park_setting[j].length; k++) {
                        if (parksp[i] == _park_setting[j][k].toLowerCase()) {
                            if (ps.park == "inside") ps.parkInside = parksp[i];
                            else ps.parkOutside = parksp[i];
                            ps.posSet = _park_setting[j][0];
                        }
                    }
                }
            }
        }
        if (pos.parent) ps.parent = pos.parent;
        if (ps.parent == "document" || ps.parent == "doc" || ps.parent == "body" || ps.parent == document) ps.parent = JB.docElement();
        if (ps.parent != "auto") {
            if (typeof (ps.parent) == "string") {
                if (ps.parent == "doc") ps.parent = JB.docElement();
                else ps.parent = document.getElementById(parent);
            }
            //if (ps.parent.tagName == null) ps.parent = "auto";
        }
        if (typeof (pos.parkInside) == "string") {  //兼容之前的版本，不建议使用
            pos.parkInside = JB.trim(pos.parkInside.toLowerCase());
            for (var j = 0; j < _parkInsideSetting.length; j++) {
                for (var k = 1; k < _parkInsideSetting[j].length; k++) {
                    if (pos.parkInside == _parkInsideSetting[j][k].toLowerCase()) {
                        ps.parkInside = pos.parkInside;
                        ps.posSet = _parkInsideSetting[j][0];
                    }
                }
            }
        }
        if (typeof (pos.parkOutside) == "string") { //兼容之前的版本，不建议使用
            pos.parkOutside = JB.trim(pos.parkOutside.toLowerCase());
            for (var j = 0; j < _parkOutsideSetting.length; j++) {
                for (var k = 1; k < _parkOutsideSetting[j].length; k++) {
                    if (pos.parkOutside == _parkOutsideSetting[j][k].toLowerCase()) {
                        ps.parkInside = pos.parkOutside;
                        ps.posSet = _parkOutsideSetting[j][0];
                    }
                }
            }
        }
        if (pos.topWin === true || pos.topWin === false) ps.topWin = pos.topWin;     //兼容之前的版本，不建议使用
        if (pos.parkSmart === true || pos.parkSmart === false) ps.parkSmart = pos.parkSmart;     //兼容之前的版本，不建议使用
        if (pos.offset && !isNaN(parseInt(pos.offset.l))) ps.offset.l = parseInt(pos.offset.l);  //兼容之前的版本，不建议使用
        if (pos.offset && !isNaN(parseInt(pos.offset.t))) ps.offset.t = parseInt(pos.offset.t);  //兼容之前的版本，不建议使用
        if (ps.posSet == "") {
            var _park_setting = (ps.park == "inside" ? _parkInsideSetting : _parkOutsideSetting);
            var _park_v = (ps.park == "inside" ? ps.parkInside : ps.parkOutside);
            for (var j = 0; j < _park_setting.length; j++) {
                for (var k = 1; k < _park_setting[j].length; k++) {
                    if (_park_v == _park_setting[j][k].toLowerCase()) ps.posSet = _park_setting[j][0];
                }
            }
            if (ps.posSet == "") ps.posSet = "";
        }
        return ps;
    }
    return _this;
})();

function JBodyDialog() {
    var _this = this;
    var _version = "v1.3";
    var _name = "";
    var _containObj = null,
        _frameObj = null,
        _simulateShadowObj = null,
        _modalObj = null,
        _alphaBorderObj = null,
        _winObj = null,
        _titleObj = null,
        _closeBtElm = null,
        _timeOutId = null;
    _this.winObj = function () { return _winObj; }
    var _dragableObj = null;
    var _closeTitle,
        _title,
        _talign,
        _colors, _btcolors,
        _alphaBorder, _shadow, _corner,
        _padding, _titlePaddingLeft, _titleFontSize, _borderInner, _cssClass;
    var _width, _height, _minWidth, _minHeight, _maxWidth, _maxHeight, _titleH, _buttonWH, _modal, _moveable;
    var _zIndex = null;  //可以指定zIndex
    var _resizeable = false;
    var _resizeableWhenInit = true;  //初始化时是否可以微调大小
    var _showTitle = true;
    var _showCloseButton = true;
    var _autoClose = false;
    var _outerClickClose = false;
    var _hideOverfloat = true;
    var _mouseoutClose, _mouseoutAfterShow; //显示后默认状态是否鼠标移出
    var _fixSize = { msgclick: false, resetpos: false };
    var _scrollPos = { x: 0, y: 0 };
    //var _toElmAttr = { w: 0, h: 0, l: 0, t: 0 };
    var _pos;
    var _posList;   //特别注意 ： 如果在多个pos中的使用不同parent属性，目前未能处理，目前只认第一个设置的parent
    var _msg_parent;
    var _docType = 1;   //1=XHTML1,2=HTML4
    var _tgElm = null;
    var _resetPos = new Array();
    var _msg = null;
    var _msg_compute = null;
    var _title_compute = null;
    var _isCssPositionFixed = function () { return (_moveable == "fixed") && (!JB.IE || JB.V > 6); }
    var _dragable = function () { return (_moveable == "dragable" || _moveable == "dragable-win"); }
    var _autoscroll = function () { return _moveable == "autoscroll" || _moveable == "autoscroll-x" || _moveable == "autoscroll-y" || (_moveable == "fixed" && !_isCssPositionFixed()); }

    var _beforeClose = function () { return true; }
    var _afterClose = function () { }
    var _beforeShow = function () { return true; }
    var _afterShow = function () { }
    var _beforeAutoScroll = function () { return true; }
    var _onDragMove = function () { return true; }
    var _onDragEnd = function () { return true; }
    var _isClosed = true;
    var _isClosed2 = true;
    var _isHidden = false;
    this.isHidden = function () { return _isHidden == true; }
    var _DEBUG_CALLBACK = function () { return; };

    _this.isClosed = function () { return _isClosed == true || _isClosed2 == true; };
    var _absoluteBasePoint = { l: 0, t: 0 };  //相对的原点
    var lastOption = null;
    var _newPos = function (pos) {
        pos = pos || {};
        //pos.to = pos.to || "obj";
        pos = JBodyPosition.createPosition(pos);
        return pos;
    };
    var _defaultOption = function () {
        _closeTitle = "关闭";
        _title = "";
        _name = "";
        _talign = 'center';
        //_colors = ["#999999", "#ffffff", "#67A1E2", "#ffffff", "#333333", "#2C7ECF", "#dddddd", "#333333", "#dddddd"];    //0:border,1:bg,2:titleBg,3:title,4:win,5:titleBorder,6:alphaBorder,7:shadow,8:modal
        _colors = eval("(" + JB.objToStr(JBodyDialogDefaultSetting.colors) + ")");  //0:border,1:bg,2:titleBg,3:title,4:win,5:titleBorder,6:alphaBorder,7:shadow,8:modal
        _btcolors = eval("(" + JB.objToStr(JBodyDialogDefaultSetting.btcolors) + ")");   //0,1bg,2bd:mouseout   3,4bg,5bd:mouseover
        _alphaBorder = JBodyDialogDefaultSetting.alphaBorder;
        _shadow = JBodyDialogDefaultSetting.shadow;
        _padding = JBodyDialogDefaultSetting.padding;
        _borderInner = JBodyDialogDefaultSetting.borderInner;
        _cssClass = eval("(" + JB.objToStr(JBodyDialogDefaultSetting.cssClass) + ")");
        _corner = eval("(" + JB.objToStr(JBodyDialogDefaultSetting.corner) + ")");
        _width = 0;
        _height = 0;
        _minWidth = 0;
        _minHeight = 0;
        _maxWidth = 0;
        _maxHeight = 0;
        _titleH = JBodyDialogDefaultSetting.titleH;
        _titlePaddingLeft = JBodyDialogDefaultSetting.titlePaddingLeft;
        _titleFontSize = JBodyDialogDefaultSetting.titleFontSize;
        _buttonWH = JBodyDialogDefaultSetting.buttonWH;
        _modal = false;  //是否模拟模态
        _moveable = "dragable";  //none,dragable,fixed:新加的跟随滚动模式,autoscroll,autosrcoll-x,autoscroll-y跟随上下滚动
        _resizeable = false;
        _resizeableWhenInit = true;  //初始化时是否可以微调大小
        _showTitle = true;
        _showCloseButton = true;
        _autoClose = false;
        _outerClickClose = false;
        _mouseoutClose = 0;
        _mouseoutAfterShow = false;
        _hideOverfloat = true;
        _fixSize = { msgclick: false, resetpos: false };
        _zIndex = null;
        _scrollPos = { x: 0, y: 0 };
        //_toElmAttr = { w: 0, h: 0, l: 0, t: 0 };
        _posList = new Array()
        _pos = _newPos();
        _posList.push(_pos);
        _beforeClose = function () { return true; };
        _afterClose = function () { };
        _beforeShow = function () { return true; };
        _afterShow = function () { };
        _beforeAutoScroll = function () { return true; }
    }
    _defaultOption();
    var _getContainerObj = function () {
        if (_containObj == null) {
            _containObj = JB.docElement().appendChild(JB.newObj("DIV", { l: 0, t: 0, css: [["position", "absolute"], ["display", "block"]] }));   //relative
        }
        return _containObj;
    }
    var _getFrameObj = function () {
        if (_frameObj != null) return _frameObj;
        return _frameObj = _getContainerObj().appendChild(JB.newObj((JB.IE && JB.V <= 6 ? "IFRAME" : "DIV"), { w: 0, h: 0, l: 0, t: 0, bd: 0, bgColor: "#dddddd", attrs: [["frameBorder", "0"], ["src", "about:blank"]], css: [["position", "absolute"], ["opacity", "0.0"]] }));
    }
    var _getAlphaBorderObj = function () {
        if (_alphaBorderObj == null) _alphaBorderObj = _getContainerObj().appendChild(JB.newObj("DIV", { w: 0, h: 0, l: 0, t: 0, bd: 0, bgColor: _colors[6], css: [["position", "absolute"], ["opacity", "0.3"]] }));
        if (JB.support.borderRadius) JB.borderRadius(JB.borderRadius(_alphaBorderObj, _corner.bL, "BottomLeft"), _corner.bR, "BottomRight");
        if (JB.support.borderRadius) JB.borderRadius(JB.borderRadius(_alphaBorderObj, _corner.tL, "TopLeft"), _corner.tR, "TopRight");
        return JB.setOpt(_alphaBorderObj, { bgColor: _colors[0] });
    }
    var _getModalObj = function () {
        if (_modalObj == null) _modalObj = _getContainerObj().appendChild(JB.newObj("DIV", { l: 0, t: 0, bd: 0, bgColor: _colors[8], css: [["position", "absolute"], ["opacity", "0.3"]] }));
        return JB.setOpt(_modalObj, { bgColor: _colors[8] });
    }
    var _getSimulateShadowObj = function () {
        if (_simulateShadowObj == null) {
            _simulateShadowObj = _getContainerObj().appendChild(JB.newObj("DIV", { w: 0, h: 0, l: 0, t: 0, css: ["position", "absolute"] }));
        }
        while (_simulateShadowObj.childNodes.length > 0) _simulateShadowObj.removeChild(_simulateShadowObj.childNodes[0]);
        return _simulateShadowObj;
    }
    var _getWinObj = function () {
        if (_winObj == null) _getContainerObj().appendChild(_winObj = JB.newObj("DIV", { l: 0, t: 0, bd: 0, css: [["border", _borderInner + "px solid " + _colors[0]], ["textAlign", _talign], ["padding", _padding + "px"], ["fontSize", "12px"], ["backgroundColor", _colors[1]], ["textDecoration", "none"], ["position", "absolute"], ["lineHeight", "16px"]] }));
        JB.borderRadius(JB.borderRadius(_winObj, _corner.bL, "BottomLeft"), _corner.bR, "BottomRight");
        if (!_showTitle) JB.borderRadius(JB.borderRadius(_winObj, _corner.tL, "TopLeft"), _corner.tR, "TopRight");
        return (JB.setOpt(_winObj, { bgColor: _colors[1], color: _colors[4], bd: _borderInner + "px solid " + _colors[0], css: [["padding", _padding + "px"], ["borderTop", "0px"], ["textAlign", _talign], ["overflow", _hideOverfloat ? "hidden" : ""], ["display", "block"]] })); //["overflow","hidden"],
    }
    var _getTitleObj = function () {
        if (_titleObj == null) _titleObj = _containObj.appendChild(JB.newObj("DIV", { l: 0, t: 0, css: [["position", "absolute"], ["paddingLeft", _titlePaddingLeft + "px"], ["textAlign", "left"], ["overflow", "hidden"], ["textDecoration", "none"], ["lineHeight", _titleH + "px"], ["fontSize", _titleFontSize + "px"]] }));
        _titleObj.innerHTML = "";
        _title_compute = null;
        if (typeof (_title) == "string") {
            _title_compute = JB.newObj("TABLE", { bgColor: _colors[2], css: [["padding", "0px"], ["margin", "0px"], ["border", "0px"]] });
            var tr = JB.insertRow(_title_compute, { bgColor: _colors[2], css: [["padding", "0px"], ["margin", "0px"], ["border", "0px"]] });
            var td = JB.newObj("TD", { innerHTML: _title, bgColor: _colors[2], color: _colors[3], css: [["padding", "0px"], ["margin", "0px"], ["border", "0px"]] });
            tr.appendChild(td);
        }
        else if (_title.tagName) _title_compute = _title;
        _titleObj.appendChild(_title_compute);
        JB.borderRadius(JB.borderRadius(_titleObj, _corner.tL, "TopLeft"), _corner.tR, "TopRight");
        var opt = { background: _colors[2], color: _colors[3], border: _borderInner + "px solid " + _colors[5], bdB: "0px", css: [["fontWeight", "bold"], ["cursor", _dragable() ? "move" : "default"]] };
        return JB.setOpt(_titleObj, opt);
    }
    var _getCloseButton = function () {
        if (_closeBtElm == null) {
            _closeBtElm = _containObj.appendChild(JB.newObj("DIV",
            {
                w: _buttonWH, h: _buttonWH, l: 0, t: 0, bgColor: _btcolors[1], bd: ("solid 1px " + _btcolors[2]),
                css: [["position", "absolute"], ["color", _btcolors[0]],
            ["padding", "0px"], ["textAlign", "center"], ["overflow", "hidden"],
            ["textDecoration", "none"], ["cursor", "pointer"], ["lineHeight", _buttonWH + "px"], ["fontFamily", "Arial,Simsun"], ["fontSize", _buttonWH + ((JB.IE && JB.V < 8) ? 0 : 4) + "px"]]
            }));
            JB.borderRadius(JB.borderRadius(JB.borderRadius(JB.borderRadius(_closeBtElm, 2, "TopLeft"), 2, "TopRight"), 2, "BottomLeft"), 2, "BottomRight");
            _closeBtElm.innerHTML = "×";
            _closeBtElm.onmouseover = function (e) {
                _closeBtElm.style.color = _btcolors[3];
                _closeBtElm.style.backgroundColor = _btcolors[4];
                _closeBtElm.style.borderColor = _btcolors[5];
            };
            _closeBtElm.onmouseout = function (e) {
                _closeBtElm.style.color = _btcolors[0];
                _closeBtElm.style.backgroundColor = _btcolors[1];
                _closeBtElm.style.borderColor = _btcolors[2];
            };
            //JB.attach(_closeBtElm, "click", _this.close, false);
            _closeBtElm.onclick = function (e) {
                _this.close();
            };
        }
        _closeBtElm.title = _closeTitle;
        _closeBtElm.style.color = _btcolors[0];
        _closeBtElm.style.backgroundColor = _btcolors[1];
        _closeBtElm.style.borderColor = _btcolors[2];
        return _closeBtElm;
    }
    //设置参数
    var _setOption = function (opt) {
        if (opt == null) { _defaultOption(); return; }
        if (typeof (opt) == "string") opt = eval("(" + opt + ")");
        if (opt.useLastOptions != true) _defaultOption();
        if (opt.closeTitle) _closeTitle = opt.closeTitle;
        if (opt.name) _name = opt.name;
        if (opt.title) _title = opt.title;
        if (opt.talign) _talign = opt.talign;
        if (JB.isArray(opt.colors)) for (var i = 0; i < opt.colors.length; i++) if (opt.colors[i] && typeof (opt.colors[i]) == "string") _colors[i] = opt.colors[i];
        if (opt.colors_border) _colors[0] = opt.colors_border;
        if (opt.colors_bg) _colors[1] = opt.colors_bg;
        if (opt.colors_titleBg) _colors[2] = opt.colors_titleBg;
        if (opt.colors_title) _colors[3] = opt.colors_title;
        if (opt.colors_text) _colors[4] = opt.colors_text;
        if (opt.colors_titleBorder) _colors[5] = opt.colors_titleBorder;
        if (opt.colors_alphaBorder) _colors[6] = opt.colors_alphaBorder;
        if (opt.colors_shadow) _colors[7] = opt.colors_shadow;
        if (opt.colors_modal) _colors[8] = opt.colors_modal;
        if (JB.isArray(opt.btcolors)) for (var i = 0; i < opt.btcolors.length; i++) if (opt.btcolors[i] && typeof (opt.btcolors[i]) == "string") _btcolors[i] = opt.btcolors[i];
        if (opt.cssClass && opt.cssClass.title) _cssClass.title = opt.cssClass.title;
        if (opt.cssClass && opt.cssClass.dialog) _cssClass.dialog = opt.cssClass.dialog;
        if (opt.cssClass && opt.cssClass.button) _cssClass.button = opt.cssClass.button;
        if (opt.alphaBorder != null && parseInt(opt.alphaBorder) >= 0) _alphaBorder = parseInt(opt.alphaBorder);
        if (opt.shadow != null && parseInt(opt.shadow) >= 0) _shadow = parseInt(opt.shadow);
        if (opt.corner) _corner = opt.corner;
        if (opt.padding != null && parseInt(opt.padding) >= 0) _padding = parseInt(opt.padding);
        if (opt.borderInner != null && parseInt(opt.borderInner) >= 0) _borderInner = parseInt(opt.borderInner);
        if (opt && parseInt(opt.w) >= 0) _width = parseInt(opt.w);
        if (opt && parseInt(opt.h) >= 0) _height = parseInt(opt.h);
        if (opt && parseInt(opt.width) >= 0) _width = parseInt(opt.width);
        if (opt && parseInt(opt.height) >= 0) _height = parseInt(opt.height);
        if (opt && parseInt(opt.minWidth) >= 0) _minWidth = parseInt(opt.minWidth);
        if (opt && parseInt(opt.minHeight) >= 0) _minHeight = parseInt(opt.minHeight);
        if (opt && parseInt(opt.maxWidth) >= 0) _maxWidth = parseInt(opt.maxWidth);
        if (opt && parseInt(opt.maxHeight) >= 0) _maxHeight = parseInt(opt.maxHeight);
        if (opt && parseInt(opt.titleH) > 0) _titleH = parseInt(opt.titleH);
        if (opt && parseInt(opt.buttonWH) > 0) _buttonWH = parseInt(opt.buttonWH);
        if (opt.modal != null) _modal = (opt.modal == true);
        if (opt.moveable != null) _moveable = opt.moveable;
        if (opt.resizeable != null) _resizeable = (opt.resizeable == true);
        if (opt.resizeableWhenInit != null) _resizeableWhenInit = !(opt.resizeableWhenInit == false);
        if (opt.showTitle != null) _showTitle = (opt.showTitle == true);
        if (opt.showCloseButton != null) _showCloseButton = (opt.showCloseButton == true);
        if (opt.autoClose != null) _autoClose = (opt.autoClose === true ? 1000 : opt.autoClose > 0 ? opt.autoClose : 0);
        if (opt.outerClickClose != null) _outerClickClose = (opt.outerClickClose == true);
        if (opt && parseInt(opt.mouseoutClose) > 0) _mouseoutClose = parseInt(opt.mouseoutClose);
        if (opt.mouseoutAfterShow != null) _mouseoutAfterShow = (opt.mouseoutAfterShow === true);
        if (opt.fixSize && opt.fixSize.msgclick != null) _fixSize.msgclick = opt.fixSize.msgclick;
        if (opt.fixSize && opt.fixSize.resetpos != null) _fixSize.resetpos = opt.fixSize.resetpos;
        if (opt.hideOverfloat != null) _hideOverfloat = !(opt.hideOverfloat === false);
        if (opt.zIndex > 0) _zIndex = opt.zIndex;
        if (opt.pos) {
            while (_posList.length > 0) _posList.pop();
            if (JB.isArray(opt.pos)) { for (var i = 0; i < opt.pos.length; i++) _posList.push(_newPos(opt.pos[i])); }
            else _posList.push(_newPos(opt.pos));
            _pos = _posList[0];
        }
        if (opt.beforeClose) {
            if (JB.isFunction(opt.beforeClose)) _beforeClose = opt.beforeClose;
            else if (typeof (opt.beforeClose) == "string") _beforeClose = function () { eval(opt.beforeClose); }
        }
        if (opt.afterClose) {
            if (JB.isFunction(opt.afterClose)) _afterClose = opt.afterClose;
            else if (typeof (opt.afterClose) == "string") _afterClose = function () { eval(opt.afterClose); }
        }
        if (opt.beforeShow) {
            if (JB.isFunction(opt.beforeShow)) _beforeShow = opt.beforeShow;
            else if (typeof (opt.beforeShow) == "string") _beforeShow = function () { eval(opt.beforeShow); }
        }
        if (opt.afterShow) {
            if (JB.isFunction(opt.afterShow)) _afterShow = opt.afterShow;
            else if (typeof (opt.afterShow) == "string") _afterShow = function () { eval(opt.afterShow); }
        }
        if (opt.beforeAutoScroll) {
            if (JB.isFunction(opt.beforeAutoScroll)) _beforeAutoScroll = opt.beforeAutoScroll;
            else if (typeof (opt.beforeAutoScroll) == "string") _beforeAutoScroll = function () { eval(opt.beforeAutoScroll); }
        }
        if (opt.onDragMove) {
            if (JB.isFunction(opt.onDragMove)) _onDragMove = opt.onDragMove;
            else if (typeof (opt.onDragMove) == "string") _onDragMove = function () { eval(opt.onDragMove); }
        }
        if (opt.onDragEnd) {
            if (JB.isFunction(opt.onDragEnd)) _onDragEnd = opt.onDragEnd;
            else if (typeof (opt.onDragEnd) == "string") _onDragEnd = function () { eval(opt.onDragEnd); }
        }

        _DEBUG_CALLBACK = opt.debugCallback || function () { return; };
    }
    var _countWHLTSmart = function (pSize, alphaBdPos) {
        if (_pos.parkSmart) {
            var simulateShadowWidth = (JB.IE && JB.V < 9) ? _shadow : 0;
            var maxL = Math.max(Math.max(pSize.PageW, pSize.WinW) - alphaBdPos.w - simulateShadowWidth, 0);
            var maxT = Math.max(Math.max(pSize.PageH, pSize.WinH) - alphaBdPos.h - simulateShadowWidth, 0);
            if (alphaBdPos.l > maxL) alphaBdPos.l = maxL;
            if (alphaBdPos.t > maxT) alphaBdPos.t = maxT;
            if (alphaBdPos.l < 0) alphaBdPos.l = 0;
            if (alphaBdPos.t < 0) alphaBdPos.t = 0;
        }
        return _countWHLTSmart2(pSize, alphaBdPos);
    }
    var _countWHLTSmart2 = function (pSize, alphaBdPos) {
        //XHTML1 宽高不包含 Padding 和 border, HTML4 宽高包含 Padding 和 border
        var tt = { w: (alphaBdPos.w - (_docType == 1 ? _titlePaddingLeft : 0) - 2 * _alphaBorder - 2 * (_docType == 1 ? _borderInner : 0)), h: _titleH, l: alphaBdPos.l + _alphaBorder, t: (alphaBdPos.t + _alphaBorder) };
        var wn = {
            w: (alphaBdPos.w - 2 * _alphaBorder - 2 * (_docType == 1 ? (_padding + _borderInner) : 0)),
            h: (alphaBdPos.h - (_showTitle ? _titleH : 0) - 2 * (_alphaBorder + (_docType == 1 ? (_padding + _borderInner) : 0))),
            l: alphaBdPos.l + _alphaBorder,
            t: (alphaBdPos.t + _alphaBorder + (_showTitle ? _titleH : 0))
        };
        var bt = { l: alphaBdPos.l + alphaBdPos.w - _alphaBorder - _titleH + (parseInt((_titleH - _buttonWH) / 2)), t: (alphaBdPos.t + _alphaBorder + (parseInt((_titleH - _buttonWH) / 2))) };
        var fm = _modal ? { w: pSize.PageW, h: pSize.PageH, l: 0, t: 0 } : alphaBdPos;
        return { psize: pSize, frame: fm, shadow: alphaBdPos, win: wn, title: tt, button: bt };
    }
    this.ADD_DEBUG_MSG = function (msg) {
        if (!_this.debug) return;
        if (_this.debugMsg == null) _this.debugMsg = msg;
        else _this.debugMsg += "\r\n" + msg;
    }
    this.ALERT_DEBUG_MSG = function (msg) { if (_this.debug && (msg || _this.debugMsg)) alert(msg || _this.debugMsg); }
    var _setDraggabale = function () {
        if (_dragableObj != null) _dragableObj.cancelDragable();  //由于模态层可能发生改变，所以一律先清除再重设
        if (_dragable() && _showTitle) {
            var objs = new Array();
            objs.push(_titleObj);
            objs.push(_winObj);
            if (_shadow > 0 && !JB.support.boxShadow) {
                objs.push(_simulateShadowObj);
            }
            if (!_modal) objs.push(_frameObj);
            if (_alphaBorder > 0 || _shadow > 0) objs.push(_alphaBorderObj);
            if (_showCloseButton) objs.push(_closeBtElm);
            _dragableObj = new JBodyDragable({ objs: objs, callbacks: { onmove: _onDragMove, ondrag: _onDragEnd }, move: { m: ((_moveable == "dragable-win") ? "win" : "doc") } });
        }
    }
    var _getMsg = function (msg) {
        if (msg == null) msg = "";
        if (typeof (msg) == "string" || JB.isArray(msg)) {
            var tb = JB.newObj("TABLE", { bgColor: _colors[1], css: [["padding", "0px"], ["margin", "0px"], ["border", "0px"]] });
            var tr = JB.insertRow(tb, { bgColor: _colors[1], css: [["padding", "0px"], ["margin", "0px"], ["border", "0px"]] });
            var td = JB.newObj("TD", { bgColor: _colors[1], css: [["padding", "0px"], ["textAlign", _talign], ["margin", "0px"], ["border", "0px"]] });
            tr.appendChild(td);
            if (typeof (msg) == "string") td.innerHTML = msg;
            else for (var i = 0; i < msg.length; i++) td.appendChild(msg[i]);
            msg = tb;
            tb = null;
        }
        //_this.initWinSize(msg);
        return msg;
    }
    var _fixForTopWinTime = 0;
    var _fixForTopWin = function () {  //在IFRAME中模拟相对TOP窗口的位置(由于固有局限，只能尽量接近该位置)
        //alert(JB.objToStr(_pos));
        if (!_pos || _pos.to != "win" || window.top == window.self || _pos.topWin === false) return;
        if (_fixForTopWinTime > 0) { return; }
        //return;
        _fixForTopWinTime++;
        var _operateWin = window.self;
        var frmPos = { l: 0, t: 0 };
        var scrPos = { x: 0, y: 0 };
        while (_operateWin.window != window.top.window) {
            var w = JB.getAbsoluteOffset(_operateWin.window.frameElement);
            var s = JB.getScrollPos(_operateWin.window.document);
            frmPos.l += w.l;
            frmPos.t += w.t;
            if (_operateWin.window != window.self.window) {
                frmPos.l -= s.x;
                frmPos.t -= s.y;
            }
            _operateWin = _operateWin.parent;
            if (_operateWin.window == window.top.window) {
                s = JB.getScrollPos(_operateWin.document);
                frmPos.l -= s.x;
                frmPos.t -= s.y;
            }
            //alert(JB.objToStr(frmPos));
        }
        var selfSize = JB.getPageSize();
        var topSize = JB.getPageSize(top);

        var winPos = JB.getAbsoluteOffset(_alphaBorderObj);
        var winSize = { w: JB.width(_alphaBorderObj), h: JB.height(_alphaBorderObj) };
        var offs = { l: 0, t: 0 };
        var park = _pos.parkInside || "auto";
        park = park.toLowerCase();
        //var msg += JB.objToStr(selfSize) + JB.objToStr(topSize) + JB.objToStr(topScrollPos) + JB.objToStr(winPos) + JB.objToStr(winSize) + JB.objToStr(_pos);

        if (park == "left" || park == "topleft" || park == "bottomleft") offs.l = -frmPos.l;
        else if (park == "right" || park == "topright" || park == "bottomright") offs.l = topSize.winW - (selfSize.winW + frmPos.l);
        else offs.l = topSize.winW / 2 - (selfSize.winW / 2 + frmPos.l);
        //msg += JB.objToStr(offs);

        if (park == "top" || park == "topleft" || park == "topright") offs.t = -frmPos.t;
        else if (park == "bottom" || park == "bottomleft" || park == "bottomright") offs.t = topSize.winH - (selfSize.winH + frmPos.t);
        else offs.t = topSize.winH / 2 - (selfSize.winH / 2 + frmPos.t);
        //msg += JB.objToStr(offs);

        if (offs.l > 0) offs.l = Math.min(offs.l, selfSize.winW - winSize.w - winPos.l);
        if (offs.l < 0) offs.l = Math.max(offs.l, -winPos.l);

        if (offs.t > 0) offs.t = Math.min(offs.t, selfSize.winH - winSize.h - winPos.t);
        if (offs.t < 0) offs.t = Math.max(offs.t, -winPos.t);

        //msg += JB.objToStr(offs);
        //JBDialog.show(null, msg);
        if (!offs.l && !offs.t) return;
        if (!_modal && _frameObj) _moveObj(_frameObj, offs.l, offs.t);
        if (!_modal && _modalObj) _moveObj(_modalObj, offs.l, offs.t);
        if (_showTitle) _moveObj(_titleObj, offs.l, offs.t);
        if (_showCloseButton) _moveObj(_closeBtElm, offs.l, offs.t);
        _moveObj(_simulateShadowObj, offs.l, offs.t);
        _moveObj(_alphaBorderObj, offs.l, offs.t);
        _moveObj(_winObj, offs.l, offs.t);

    };
    var _closeFromOuter = function (e) {
        e = window.event || e;
        var src = e.srcElement || e.target;
        if (src == null) return;
        if (src == _tgElm) return;
        if (src == _modalObj || src == _alphaBorderObj || src == _winObj || src == _titleObj || src == _closeBtElm) return;
        while (src.parentNode != null) {
            src = src.parentNode;
            if (src == _winObj) return;
        }
        //alert(src);
        _this.detachOuterClickClose();
        _this.close();
    }
    var _clickModelObj = function () {
        //点击模态层将滚动到窗口可见位置
        if ((_showTitle && !JB.topCanSee({ obj: _titleObj })) || !JB.topCanSee(_winObj))
            JB.tryTopCanSee({ obj: _showTitle ? _titleObj : _winObj });
    }
    this.showCenter = function (msg, opt) {
        _setOption({ pos: { to: "win", park: "inside", parkInside: "canter" } });
        _this.show(null, msg, opt);
    }
    this.clickFixSizeFunc = function () {
        JB.setTimeout(_this.fixSize, 1, _fixSize.resetpos);
    }
    var _moveObj = function (obj, diffL, diffT) {
        if (obj == null || (diffL == 0 && diffT == 0) || (diffL == 0 && diffT == null) || (diffL == null && diffT == 0)) return;
        JB.setOpt(obj, { l: obj.offsetLeft + diffL, t: obj.offsetTop + diffT });
    }
    this.move = function (option) {
        option = option || { l: 0, t: 0 };
        if (!option.fast) {
            if (_this.isClosed()) return;
            option.l = isNaN(parseInt(option.l)) ? 0 : parseInt(option.l);
            option.t = isNaN(parseInt(option.t)) ? 0 : parseInt(option.t);
        }
        if (!_modal) _moveObj(_modalObj, option.l, option.t);
        _moveObj(_winObj, option.l, option.t);
        _moveObj(_titleObj, option.l, option.t);
        _moveObj(_closeBtElm, option.l, option.t);
        _moveObj(_alphaBorderObj, option.l, option.t);
        if (!_modal) _moveObj(_frameObj, option.l, option.t);
        _moveObj(_simulateShadowObj, option.l, option.t);
    }
    this.fixSize = function (fixPos) {
        var h = _msg_compute.offsetHeight + 2 * (_padding + _borderInner);
        var w = _msg_compute.offsetWidth + 2 * (_padding + _borderInner);
        var h2 = _winObj.offsetHeight
        var w2 = _winObj.offsetWidth;
        if (w != w2 || h != h2) {
            var p_old = { l: _winObj.offsetLeft, t: _winObj.offsetTop };
            _this.resize({ w: w, h: h + 2 * _alphaBorder + _shadow + (_showTitle ? _titleH : 0) });
            if (!fixPos && (p_old.l != _winObj.offsetLeft || p_old.l != _winObj.offsetLeft)) {
                var diff = { fast: true, l: p_old.l - _winObj.offsetLeft, t: p_old.t - _winObj.offsetTop };
                _this.move(diff);
            }
        }
    }
    this.resize = function (s) {
        if (_isClosed || _isClosed2) return;
        _fixForTopWinTime = 0;
        _countAndSetWH(s);
        _setPos();
        _fixForTopWin();
    };
    this.show = function (elm, msg, opt, debugMsg) {
        //alert(JB.objToStr(opt));
        if (opt && opt.outerClickClose) { JB.setTimeout(_this.showNow, 10, elm, msg, opt, debugMsg); } //等待可能存在的冒泡完毕
        else _this.showNow(elm, msg, opt, debugMsg);
    };
    var _countAndSetWH = function (size) {
        size = size || {};
        var _simulateShadow = (_shadow > 0 && !JB.support.boxShadow) ? _shadow : 0;
        var sz = {
            w: size.width || size.w || (_width + 0), h: size.height || size.h || (_height + 0),
            win_w: 0, win_h: 0,
            title_w: 0, title_h: _titleObj.offsetHeight,
            alpha_w: 0, alpha_h: 0,
            msg_w: _msg_compute.offsetWidth,
            padding: _padding
        };
        if (sz.w <= 0) {
            sz.w = _msg_compute.offsetWidth + 2 * _alphaBorder + _simulateShadow + 2 * _padding + 2 * _borderInner;
            if (_showTitle) sz.w = Math.max(Math.max(_titleObj.offsetWidth, _title_compute.offsetWidth) + 2 * _alphaBorder + _simulateShadow + (_showCloseButton ? (JBodyDialogDefaultSetting.titleH + 3) : 0), sz.w);
        }
        sz.w = Math.max(_minWidth, sz.w);
        if (_maxWidth > 0) sz.w = Math.min(_maxWidth, sz.w);
        sz.win_w = sz.w - 2 * _alphaBorder - 2 * _padding - _simulateShadow;
        sz.title_w = sz.w - _titlePaddingLeft - 2 * _alphaBorder - _simulateShadow;
        sz.alpha_w = sz.w - _simulateShadow + 2 * _borderInner;
        if (JB.QUIRKS) {  //怪异模式width包含padding和border
            sz.win_w = sz.win_w + 2 * _padding;
            sz.title_w = sz.win_w;
            sz.alpha_w = sz.win_w + 2 * _alphaBorder;
        }
        JB.css(_titleObj, "width", sz.title_w + "px");
        JB.css(_winObj, "width", sz.win_w + "px");
        JB.css(_alphaBorderObj, "width", sz.alpha_w + "px");
        JB.css(_frameObj, "width", sz.alpha_w + "px");
        JB.css(_simulateShadowObj, "width", sz.alpha_w + "px");
        //
        if (sz.h <= 0) {
            sz.h = _winObj.offsetHeight + (_showTitle ? _titleObj.offsetHeight : 0) + 2 * _alphaBorder + _simulateShadow;
        }
        sz.h = Math.max(_minHeight, sz.h);
        if (_maxHeight > 0) sz.h = Math.min(_maxHeight, sz.h);
        sz.win_h = sz.h - (_showTitle ? _titleObj.offsetHeight : 0) - 2 * _padding - 2 * _alphaBorder - _simulateShadow;
        sz.alpha_h = sz.h - _simulateShadow + 2 * _borderInner;
        if (JB.QUIRKS) {  //怪异模式width包含padding和border
            sz.win_h = sz.win_h + 2 * _padding;
            sz.alpha_h = sz.win_h + (_showTitle ? _titleObj.offsetHeight : 0) + 2 * _alphaBorder;
        }
        //alert(JB.objToStr(sz));
        JB.setOpt(_titleObj, { css: [["top", _alphaBorder + "px"], ["left", _alphaBorder + "px"]] });
        JB.setOpt(_winObj, { css: [["height", sz.win_h + "px"], ["top", (_alphaBorder + (_showTitle ? _titleObj.offsetHeight : 0)) + "px"], ["left", _alphaBorder + "px"]] });
        JB.setOpt(_alphaBorderObj, { css: [["height", sz.alpha_h + "px"], ["top", "0px"], ["left", "0px"]] });
        JB.setOpt(_frameObj, { css: [["height", sz.alpha_h + "px"], ["top", "0px"], ["left", "0px"]] });
        JB.setOpt(_simulateShadowObj, { css: [["height", sz.alpha_h + "px"], ["top", "0px"], ["left", "0px"]] });
        //alert(JB.objToStr(sz));
        //alert(_msg_compute.offsetWidth);
        if (_showTitle) {
            JB.show(_titleObj);
        } else {
            JB.hide(_titleObj);
        }
        if (_showCloseButton) {
            JB.setOpt(_closeBtElm, {
                css: [["top", (_alphaBorder + _borderInner + parseInt(((_showTitle ? _titleObj.offsetHeight : JBodyDialogDefaultSetting.titleH) - _closeBtElm.offsetHeight) / 2)) + "px"],
                    ["left", (_alphaBorder + _winObj.offsetWidth - _closeBtElm.offsetWidth
                        - parseInt(((_showTitle ? _titleObj.offsetHeight : JBodyDialogDefaultSetting.titleH) - _closeBtElm.offsetHeight) / 2) - _borderInner) + "px"]]
            });
            JB.show(_closeBtElm);
        } else JB.hide(_closeBtElm);

        if (_shadow > 0) {
            if (JB.support.boxShadow) {
                JB.setOpt(_alphaBorderObj, { css: ["boxShadow", _shadow + "px " + _shadow + "px " + _shadow + "px " + _colors[7]] });
                JB.setOpt(_alphaBorderObj, { css: ["webkitBoxShadow", _shadow + "px " + _shadow + "px " + _shadow + "px " + _colors[7]] });
                JB.setOpt(_alphaBorderObj, { css: ["mozBoxShadow", _shadow + "px " + _shadow + "px " + _shadow + "px " + _colors[7]] });
            } else {
                var alpa = JB._parseFloat(0.55 / (_shadow + 1), 3);
                var divs = _simulateShadowObj.getElementsByTagName("DIV");
                if (divs.length == 0) {
                    for (var i = 0; i < _shadow; i++) {
                        _simulateShadowObj.appendChild(JB.newObj("DIV",
                        {
                            w: _alphaBorderObj.offsetWidth, h: _alphaBorderObj.offsetHeight,
                            l: i + 1, t: i + 1, bgColor: _colors[7], css: [["position", "absolute"], ["opacity", alpa + ""]]
                        }));
                    }
                }
                var divs = _simulateShadowObj.getElementsByTagName("DIV");
                for (var i = 0; i < divs.length; i++) {
                    JB.setOpt(divs[i], { w: _alphaBorderObj.offsetWidth, h: _alphaBorderObj.offsetHeight, l: i + 1, t: i + 1 });
                }
            }
        }

        //alert(_widthNoContainShadowAndAlphaBorder);
    }
    var _getBasePoint = function () {
        var tempObj = JB.newObj("div", { w: 0, h: 0, l: 0, t: 0, css: ["position", "absolute"] });
        _msg_parent.appendChild(tempObj);
        var prt2 = tempObj.offsetParent;
        _msg_parent.removeChild(tempObj);
        tempObj = null;
        return JB.getAbsoluteOffset(prt2);
    }
    var _setPos = function () {
        var bestPos = null;
        var minMoveTop = null, minMoveLeft = null;
        var pSize = JB.getPageSize(); //{ PageW: , PageH: , WinW: , WinH:  };
        var p = {}; //与最近fixed/absolute/relative属性的父级的相对坐标
        var elm = _tgElm;
        if (elm) p = JB.getAbsoluteOffset(elm);
        var basePoint = _getBasePoint(); //最近fixed/absolute/relative属性的父级的坐标

        var pScroll = JB.getScrollPos();    //滚动条坐标

        var bestAlphaBorderPos = null;  //阴影层属性
        var fixLevel2 = false;

        var fixRect = {  //目标位置
            l1: 0,
            l2: pScroll.x,
            l3: Math.min(pSize.PageW, pSize.WinW + pScroll.x),
            l4: Math.max(pSize.PageW, pSize.WinW + pScroll.x),
            t1: 0,
            t2: pScroll.y,
            t3: Math.min(pSize.PageH, pSize.WinH + pScroll.y),
            t4: Math.max(pSize.PageH, pSize.WinH + pScroll.y)
        }

        for (var i = 0; i < _posList.length; i++) {  //自适应最佳位置
            var pos = _posList[i];
            pos.parent = _msg_parent;  //目前未能处理多个pos指定不同parent的情况，parent以第一个pos的parent为准
            var alphaBdPos = { w: _alphaBorderObj.offsetWidth, h: _alphaBorderObj.offsetHeight, l: pos.offset.l, t: pos.offset.t }; //阴影属性
            var toElmAttr = { w: 0, h: 0, l: 0, t: 0 };
            if (pos.to == "downpos") {
                if (JB.latestdown) toElmAttr.l = JB.latestdown.clientX + JB.latestdown.scroll.x;
                if (JB.latestdown) toElmAttr.t = JB.latestdown.clientY + JB.latestdown.scroll.y;
            }
            else if (pos.to == "win") {
                toElmAttr.w = pSize.WinW;
                toElmAttr.h = pSize.WinH;
                toElmAttr.l = pScroll.x || 0;
                toElmAttr.t = pScroll.y || 0;
            }
            else if (pos.to == "doc") {
                toElmAttr.w = pSize.PageW;
                toElmAttr.h = pSize.PageH;
                toElmAttr.l = p.l || 0;
                toElmAttr.t = p.t || 0;
            }
            else if (elm) {
                toElmAttr.w = elm.offsetWidth || 0;
                toElmAttr.h = elm.offsetHeight || 0;
                toElmAttr.l = p.l || 0;   //
                toElmAttr.t = p.t || 0;   //
            }
            var _offsetsetting = pos.posSet.split(',');

            alphaBdPos.l = parseInt(toElmAttr.l + alphaBdPos.l + alphaBdPos.w * parseFloat(_offsetsetting[0]) + toElmAttr.w * parseFloat(_offsetsetting[1]));
            alphaBdPos.t = parseInt(toElmAttr.t + alphaBdPos.t + alphaBdPos.h * parseFloat(_offsetsetting[2]) + toElmAttr.h * parseFloat(_offsetsetting[3]));

            var moveTop = 0, moveLeft = 0;
            //弹出框右下角的坐标
            var pBR = {
                l: alphaBdPos.l + alphaBdPos.w + _shadow - basePoint.l,
                t: alphaBdPos.t + alphaBdPos.h + _shadow - basePoint.t
            };

            //空间不足显示，弹出框需偏移的距离
            moveTop = (pBR.t > fixRect.t4) ? (pBR.t - fixRect.t4) :
                (pBR.t > fixRect.t3) ? (pBR.t - fixRect.t3) :
                (alphaBdPos.t < 0) ? (-alphaBdPos.t) : 0;
            moveLeft = (pBR.l > fixRect.l4) ? (pBR.l - fixRect.l4) :
                (pBR.l > fixRect.l3) ? (pBR.l - fixRect.l3) :
                (alphaBdPos.l < 0) ? (-alphaBdPos.l) : 0;
            
            var fixBest = (alphaBdPos.l >= fixRect.l2 && pBR.l <= fixRect.l3 && alphaBdPos.t >= fixRect.t2 && pBR.t <= fixRect.t3);
            //选择其中一个最好的位置显示（位置调整尽量小）
            if (bestPos == null || fixBest || (moveTop == 0 && moveLeft == 0 && !fixLevel2) || (moveTop * moveTop + moveLeft * moveLeft) < (minMoveLeft * minMoveLeft + minMoveTop * minMoveTop)) {
                bestPos = pos;
                minMoveLeft = moveLeft;
                minMoveTop = moveTop;
                bestAlphaBorderPos = alphaBdPos;
                fixLevel2 = fixLevel2 || (moveTop == 0 && moveLeft == 0);
            }
            if (fixBest) break;
        }
        _pos = bestPos;
        if (_isCssPositionFixed(_pos)) {   //fixed方式的参照物为窗口
            bestAlphaBorderPos.l = bestAlphaBorderPos.l - pScroll.x;
            bestAlphaBorderPos.t = bestAlphaBorderPos.t - pScroll.y;
        }
        if (_modal) {
            JB.setOpt(_getModalObj(), { w: Math.max(pSize.PageW, pSize.WinW), h: Math.max(pSize.PageH, pSize.WinH) });
        }
        //document.write(DDDDDDDDDD);
        _this.move({ fast: true, l: Math.max(0, bestAlphaBorderPos.l) - _alphaBorderObj.offsetLeft - basePoint.l, t: Math.max(0, bestAlphaBorderPos.t) - _alphaBorderObj.offsetTop - basePoint.t });
    }
    this.showNow = function (elm, msg, opt, debugMsg) {
        _fixForTopWinTime = 0;  //用于在IFRAME中模拟顶层窗口的位置（居中等）
        _DEBUG_CALLBACK("dialog close beforeshow!");
        _this.close();
        _setOption(opt);
        _DEBUG_CALLBACK("before showing!");
        if (_beforeShow(_this) === false) { _DEBUG_CALLBACK("beforeShow is false!"); return; }
        //JB.show(_containObj, "block");
        _tgElm = elm;
        if (_tgElm && typeof (_tgElm) == "string") _tgElm = document.getElementById(_tgElm);
        if (_tgElm == null) _tgElm = JB.docElement();
        if (_tgElm == null) return;

        while (_winObj && _winObj.childNodes && _winObj.childNodes.length > 0) _winObj.removeChild(_winObj.childNodes.item(0));
        _msg = msg;    //原始的记录    
        _resetPos = new Array();
        if (typeof (msg) !== "string") {  //用于恢复原来位置
            if (msg.length || msg.push) {
                for (var i = 0; i < msg.length; i++) {
                    if (msg[i].parentNode) {
                        var _reset_pos = new Object();
                        _resetPos.msg = msg[i];
                        _resetPos.parent = msg[i].parentNode;
                        _resetPos.before = msg[i].nextSibling;
                        _resetPos.push(_reset_pos);
                    }
                }
            } else if (msg.parentNode) {
                var _reset_pos = { msg: msg, parent: msg.parentNode, before: msg.nextSibling };
                _resetPos.push(_reset_pos);
            }
        }
        _msg_compute = _getMsg(msg);

        //要绑定的父对象
        _msg_parent = JB.docElement();
        var pgSize = JB.getPageSize();
        _pos = _pos || _posList[0];
        if (_pos.parent == "auto" && _tgElm.parentNode && _tgElm != JB.docElement()) {
            _msg_parent = _tgElm.parentNode;
        }
        else if (_pos.parent != JB.docElement() && _pos.parent != "auto") {
            _msg_parent = _pos.parent;
        }

        //JB.docElement().appendChild(_getContainerObj());
        //此处为了使服务器控件保持有效，有可能有些副作用
        _msg_parent.appendChild(_getContainerObj());
        //计算父对象位置
        _getFrameObj();
        _getAlphaBorderObj();
        _getSimulateShadowObj();
        _getModalObj();
        _getWinObj();
        _getTitleObj();
        if (_showCloseButton) JBody.show(_getCloseButton());
        else JBody.hide(_getCloseButton());
        JB.css(_getContainerObj(), "width", "100%");
        if (!JB.QUIRKS) {  //怪异模式不支持 initial
            JB.css(_getContainerObj(), "height", "initial");
            JB.css(_winObj, "width", "initial");
            JB.css(_winObj, "height", "initial");
            JB.css(_getTitleObj(), "width", "initial");
        }
        JB.css(_getTitleObj(), "height", JBodyDialogDefaultSetting.titleH + "px");
        _winObj.appendChild(_msg_compute);
        JB.show(_getContainerObj());
        //alert(_msg_compute.offsetWidth);
        //alert(_title_compute.offsetWidth);
        //return;
        _countAndSetWH();
        JB.css(_getContainerObj(), "width", "0px");
        _setPos();
        JB.setOpt(_getContainerObj(), { css: ["position", _isCssPositionFixed() ? "fixed" : "absolute"] });
        JB.setOpt(_containObj, { css: ["zIndex", _zIndex || JBodyDialogContainer.maxZIndex()] });

        _fixForTopWin();
        if (_autoClose > 0) _timeOutId = setTimeout(function () { _this.close(); }, _autoClose);
        if (_fixSize.msgclick) JB.attach(_msg_compute, "click", _this.clickFixSizeFunc);
        _setDraggabale();
        if (_autoscroll()) _this.attachAutoScroll();
        if (!_modal && _outerClickClose) _this.attachOuterClickClose();
        if (_mouseoutClose > 0) {
            _this.setMouseoutClose();
            if (_mouseoutAfterShow === true) _this.onMouseout();
        }
        if (_modal && !_autoscroll()) _this.attachModelClick();

        _isClosed = false;
        _isClosed2 = false;
        _isHidden = false;
        _afterShow(_this);
        _this.ALERT_DEBUG_MSG();
    }
    var _afterWinResize = function () {
        if (_winObj == null || _modalObj == null || _frameObj == null) return;
        if (_pos.to == "win") {

            JB.setTimeout(function () { _countAndSetWH(); _setPos(); }, 10);
        }
    }
    var _doAutoScroll = function () {
        var spos = JB.getScrollPos();
        var diffX = spos.x - _scrollPos.x;
        var diffY = spos.y - _scrollPos.y;
        if (!_beforeAutoScroll(spos, diffX, diffY)) return;
        _scrollPos = spos;
        if (_moveable == "autoscroll-y") diffX = 0;
        if (_moveable == "autoscroll-x") diffY = 0;
        _this.move({ l: diffX, t: diffY });
    }
    this.closeAll = function (name) {
        JBodyDialogContainer.close(name);
    }
    this.hide = function (name) {   //如果要解决多次show和close导致多次重新加载Iframe的问题，可以尝试使用此方法配合showHide方法
        if (name && name != _name) return;
        JB.hide(_getContainerObj());
        _isHidden = true;
    }
    this.showHide = function (name) {
        if (name && name != _name) return;
        //if (!_isHidden || _this.isClosed()) return;
        JB.show(_getContainerObj(), "block");
        _isHidden = false;
    }
    this.showObj = function (elm, msg, opt, debugMsg) {  //仅显示对象，没有标题，
        opt = opt || {};
        opt.showTitle = false;
        opt.showCloseButton = (opt.showCloseButton === true);  //可以定义是否显示关闭按钮
        opt.alphaBorder = 0;
        opt.shadow = 0;
        opt.padding = 0;
        opt.borderInner = 0;
        opt.hideOverfloat = false;
        opt.corner = { tL: 0, tR: 0, bL: 0, bR: 0 };
        _this.show(elm, msg, opt, debugMsg);
        JB.setOpt(_winObj, { bgColor: "transparent" });
    }
    this.close = this.hide = function (name) {
        if (_this.isClosed()) return;
        if (name && name != _name) return;
        _DEBUG_CALLBACK("before dialog closing!");
        if (JB.isFunction(_beforeClose) && !_this.isClosed()) {
            if (!_beforeClose(_msg, _this)) return;
        }
        _this.detachAutoScroll();
        _this.detachOuterClickClose();
        _this.clearAutoClose();
        _this.clearMouseoutClose();
        _this.detachModelClick();
        if (_fixSize.msgclick && _msg_compute != null) JB.detach(_msg_compute, "click", _this.clickFixSizeFunc);
        if (_containObj == null) { _isClosed = true; _isClosed2 = true; return; }
        JB.hide(_containObj);
        if (_resetPos.length == 0 && _msg_compute && _msg_compute.prentNode) _msg_compute.prentNode.removeChild(_msg_compute);
        for (var i = 0; i < _resetPos.length; i++) {
            if (_resetPos[i].msg != null) {
                //try {
                if (_resetPos[i].before != null) { _resetPos[i].parent.insertBefore(_resetPos[i].msg, _resetPos[i].before); }
                else _resetPos[i].parent.appendChild(_resetPos[i].msg);
                //} catch (e) { alert(e.description); }
            }
        }
        _resetPos = new Array();
        JB.docElement().appendChild(_getContainerObj());
        _isClosed = true;
        if (JB.isFunction(_afterClose) && !_isClosed2) { _afterClose(_msg); }
        _isClosed2 = true;  //双_isClosed解决_afterClose回调的时候IsClose()的结果问题
    };
    this.setAutoClose = function (ms) {
        _this.clearAutoClose();
        ms = ms || _autoClose;
        if (ms > 0) _timeOutId = setTimeout(function () { _this.close(); }, ms);
    };
    this.clearAutoClose = function () {
        if (_timeOutId != null) { window.clearTimeout(_timeOutId); _timeOutId = null; }
    };
    var _onMouseoutId = null;
    this.mouseover = function () {
        if (_onMouseoutId) { window.clearTimeout(_onMouseoutId); _onMouseoutId = null; }
    }
    this.onMouseover = this.mouseover;  //兼容旧代码
    this.mouseout = function () {
        _this.mouseover();
        if (_mouseoutClose > 0) _onMouseoutId = setTimeout(_this.close, _mouseoutClose);
    }
    this.onMouseout = this.mouseout;  //兼容旧代码
    this.setMouseoutClose = function (mouseoutClose) {
        _mouseoutClose = mouseoutClose || _mouseoutClose || 2000;
        _this.clearMouseoutClose();
        if (_containObj != null) {
            JB.attach(_containObj, "mouseover", _this.mouseover);
            JB.attach(_containObj, "mouseout", _this.mouseout);
        }
    }
    this.clearMouseoutClose = function () {
        try {
            if (_containObj != null) {
                JB.detach(_containObj, "mouseover", _this.mouseover);
                JB.detach(_containObj, "mouseout", _this.mouseout);
                if (_onMouseoutId) { window.clearTimeout(_onMouseoutId); _onMouseoutId = null; }
            }
        } catch (e) { }
    }
    this.detachAutoScroll = function () {
        JB.detach(window, "resize", _afterWinResize);
        JB.detach(window, "scroll", _doAutoScroll);
    };
    this.attachAutoScroll = function () {
        _this.detachAutoScroll();
        _scrollPos = JB.getScrollPos();
        JB.attach(window, "resize", _afterWinResize);
        JB.attach(window, "scroll", _doAutoScroll);
    };
    this.detachOuterClickClose = function () {
        JB.detach(document, "click", _closeFromOuter);
        JB.detach(document, 'keyup', _closeFromOuter);
    };
    this.attachOuterClickClose = function () {
        _this.detachOuterClickClose();
        JB.setTimeout(JB.attach(document, "click", _closeFromOuter), 5);
        JB.setTimeout(JB.attach(document, "keyup", _closeFromOuter), 5);
    };
    this.attachModelClick = function () {
        if (_modal && _modalObj) JB.setTimeout(JB.attach(_modalObj, "click", _clickModelObj), 5);
    }
    this.detachModelClick = function () {
        if (_modalObj) JB.detach(_modalObj, "click", _clickModelObj);
    }
    var _destroy = function () {
        try {
            _this.close();
            _alphaBorderObj = null;
            _containObj = null;
            _closeBtElm = null;
            _winObj = null;
            _dragableObj = null;
            _this = null;
        } catch (e) { }
    }
    //JB.attach(window, "unload", _destroy);
    JBodyDialogContainer.add(_this);
    return _this;
}
/*/
JBDialog  可以直接使用的对象，也可以使用 new JBodyDialog(opt)新建对象
/*/
var JBDialog = new JBodyDialog();


/*/ 验证函数 /*/
function JBodyValidatorContainer() {
    var _this = this;
    var fireObjs = new Array();
    var autofireObjs = new Array();
    this.vlist = new Array();
    var _dialog = new JBodyDialog();
    this.afterSuccess = new Array();
    this.afterError = null;
    this.stopWhenError = false;//验证失败时是否停止检查后面的无素
    this.checkAllCustm = function (fireObj, autoAndCustm, showMsg, funAfterError, funAfterSuccess) {
        var modalMsg = "";
        var alertMsg = "";
        var modalCount = 0;
        var errorCount = 0;
        var maxLen = 0;
        var errMsgArray = new Array();
        for (var i = 0; i < _this.vlist.length; i++) {
            if (!_this.vlist[i].containFireObj(fireObj)) continue;
            if (_this.vlist[i].getCheckWhere().toLowerCase().indexOf("custm") >= 0 && autoAndCustm != true) continue;
            var b = _this.vlist[i].checkInputOnly();
            if (!b) { errorCount += 1; errMsgArray.push(_this.vlist[i].msg); }
            if (!b || _this.vlist[i].showSuccess()) {
                if (_this.vlist[i].msgAlwaysAlert) {
                    alertMsg += (alertMsg != "" ? "\r\n" : "") + _this.vlist[i].msg;
                }
                if (_this.vlist[i].getMsgShowType() == "Modal") {
                    modalMsg += (modalMsg != "" ? "<br />" : "") + _this.vlist[i].msg;
                    maxLen = Math.max(maxLen, JB.getLengthDoubleChinese(_this.vlist[i].msg));
                    modalCount += 1;
                }
                else if (_this.vlist[i].getMsgShowType() == "Alert" && !_this.vlist[i].msgAlwaysAlert) {
                    alertMsg += (alertMsg != "" ? "\r\n" : "") + _this.vlist[i].msg;
                }
                else if (showMsg == true) _this.vlist[i].showMsg();
            }
            if (!b && _this.stopWhenError) break;
        }
        if (modalMsg != "" && showMsg == true) {
            _dialog.show(null,
                [JB.newObj("P", { html: modalMsg, css: [["margin", "0px"], ["padding", "5px"]] }), JB.newObj("INPUT", { w: 50, v: "确定", tp: "button", attach: { f: "click", func: _dialog.close } })]
                , {
                    w: (maxLen * 7 + 16), h: (modalCount * 20 + 55),
                    showTitle: true, showCloseButton: true,
                    shadow: 1, borderInner: 1, modal: true,
                    colors_bg: "#ffffff", colors_text: (errorCount > 0 ? "red" : "green"),
                    autoClose: 0, padding: 1, talign: "center",
                    pos: {
                        to: "win",
                        park: "inside",
                        parkInside: "center",
                        parkSmart: true
                    }
                });
        }
        if (alertMsg != "" && showMsg == true) { alert(alertMsg); }
        if (errorCount == 0) {
            if (JB.isFunction(funAfterSuccess)) {
                if (funAfterSuccess.call(fireObj) === false) errorCount++;
            }
            else if (typeof (funAfterSuccess) == "string") {
                if (eval(funAfterSuccess) === false) errorCount++;
            }
            if (!JB.isArray(_this.afterSuccess)) _this.afterSuccess = [_this.afterSuccess];
            for (var i = 0; i < _this.afterSuccess.length; i++) {
                if (JB.isFunction(_this.afterSuccess[i])) {
                    if (_this.afterSuccess[i].call(fireObj) === false) {
                        errorCount++;
                        break;
                    }
                }
                else if (typeof (_this.afterSuccess[i]) == "string") {
                    if (eval(_this.afterSuccess[i]) === false) {
                        errorCount++;
                        break;
                    }
                }
            }
        }
        else {
            if (JB.isFunction(funAfterError)) funAfterError({ errorCount: errorCount, modalCount: modalCount, modalMsg: modalMsg, alertMsg: alertMsg, errMsgArray: errMsgArray });
            else if (typeof (funAfterError) == "string") eval(funAfterError);
        }
        return { errorCount: errorCount, modalCount: modalCount, modalMsg: modalMsg, alertMsg: alertMsg, errMsgArray: errMsgArray };
    }
    this.checkInputsCustm = this.checkAllCustm;
    this.checkAll = function (fireObj) {
        var errorCount = _this.checkAllCustm(fireObj, false, true, _this.afterError, _this.afterSuccess).errorCount;
        return (errorCount == 0);
    }
    this.checkInputs = this.checkAll;
    var _containFireObj = function (obj) {
        for (var i = 0; i < fireObjs.length; i++) if (fireObjs[i] == obj) return true;
        return false;
    }
    this.containFireObj = function (obj) { return _containFireObj(obj); }
    var _containAutoFireObj = function (obj) {
        for (var i = 0; i < autofireObjs.length; i++) if (autofireObjs[i] == obj) return true;
        return false;
    }
    this.containAutoFireObj = function (obj) { return _containAutoFireObj(obj); }
    this.bindCheck = function (fobj, custm) {
        if (!_containFireObj(fobj)) fireObjs.push(fobj);
        if (custm == true || _containAutoFireObj(fobj)) return;
        autofireObjs.push(fobj);
        JB.attach(fobj, fobj.tagName.toLowerCase() == "form" ? "submit" : "click",
                function (e) {
                    var v = _this.checkInputs(fobj);
                    if (!v && e && e.preventDefault) e.preventDefault();
                    return v;
                });
        //if (fobj.tagName.toLowerCase() == "form")  $(fobj).submit(function() { return _this.checkInputs(fobj); });
        //else $(fobj).click(function() { return _this.checkInputs(fobj); });
    }
    this.check = function () {
        var v = true;
        for (var j = 0; j < arguments.length; j++) {
            var pass = true;
            for (var i = 0; i < _this.vlist.length; i++) {
                var r = _this.vlist[i].tryCheck(arguments[j]);
                if (r.match) pass = r.pass;
            }
            v = v && pass;
        }
        return v;
    }
    this.checkAllChildren = function (parentObj) {
        var pass = true;
        for (var i = 0; i < _this.vlist.length; i++) {
            var r = _this.vlist[i].tryCheckForParent(parentObj);
            //alert(JB.objToStr(r));
            if (r.match) { pass = pass && r.pass; }
        }
        return pass;
    }
    this.closeMsg = function (objOrParent) {
        for (var i = 0; i < _this.vlist.length; i++) {
            _this.vlist[i].closeMsg(objOrParent);
        }
    }
    this.reShowShowingMsg = function (optn) {
        optn = optn || {};
        optn.scrollToSee = JB.undef(optn.scrollToSee, false);
        optn.styleFlash = JB.undef(optn.styleFlash, false);
        for (var i = 0; i < _this.vlist.length; i++) {
            _this.vlist[i].reShowShowingMsg(optn);
        }
    }
    this.appendCustmCheck = function (obj, fun) {
        for (var i = 0; i < _this.vlist.length; i++) {
            if (_this.vlist[i].tryAppendCustmCheck(obj, fun)) { return true; }
        }
        return false;
    }
    var _destroy = function () {
        try {
            _dialog.close();
            _dialog = null;
            autofireObjs = null;
            fireObjs = null;
            _this.vlist = null;
            _this = null;
        } catch (e) { }
    }
    this.add = function (jbVldtr) {
        _this.vlist.push(jbVldtr);
        _this.vlist = _this.vlist.sort(function (a, b) { return a.ValidateIndex() < b.ValidateIndex() ? 1 : a.ValidateIndex() == b.ValidateIndex() ? 0 : -1; });

    }
    this.getRegExs = function (t) {
        switch (t) {
            case "Account": return "^[a-zA-Z][_0-9a-zA-Z]+$";
            case "AccountOrMobileOrEmail": return "(" + _this.getRegExs("Account") + ")|(" + _this.getRegExs("Email") + ")|(" + _this.getRegExs("Mobile") + ")";
            case "MobileOrEmail": return "(" + _this.getRegExs("Email") + ")|(" + _this.getRegExs("Mobile") + ")";
            case "Chinease": return "^[\\u0391-\\uFFE5]+$";
            case "ChineaseAndNum": return "^[0-9\\u0391-\\uFFE5]+$";
            case "Date": return "^[\\d]{4}-[\\d]{1,2}-[\\d]{1,2}$";
            case "DateTime": return "^[\\d]{4}-[\\d]{1,2}-[\\d]{1,2}([\\s]+[\\d]{1,2}:[\\d]{1,2}(:[\\d]{1,2})?)?$";
            case "Email": return "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
            case "EnglishChar": return "^[a-zA-Z]+$";
            case "EnglishCharAndNum": return "^[a-zA-Z0-9]+$";
            case "Float": "^[-\\+]{0,1}[1-9][0-9]*(\\.[0-9]+){0,1}$";
            case "Identity": return "^[a-zA-Z][_0-9a-zA-Z]+$";
            case "Int": return "^[-\\+]{0,1}\\d+$";
            case "Mobile": return "^([0]{0,1}1[3,4,5,7,8]\\d{9})$";
            case "Number": return "^\\d+$";
            case "Password": return "^\\S{6,16}$";
            case "QQ": return "^\\d{5,10}$";
            case "Telephone": return "^((\\d{2,5}[\\s]?[-]{1}[\\s]?))?\\d{6,8}(([\\s]?[-]{1}[\\s]?)\\d{1,6})?$";
            case "TelephoneA_B": return "^((\\d{2,5}[\\s]?[-]{1}[\\s]?))\\d{6,8}$";
            case "TelephoneA_B_C": return "^((\\d{2,5}[\\s]?[-]{1}[\\s]?))\\d{6,8}(([\\s]?[-]{1}[\\s]?)\\d{1,6})$";
            case "TelephoneB": return "^\\d{6,8}$";
            case "Text": return "^[\\w\\W]*$";
            case "Time": return "^[\\d]{1,2}:[\\d]{1,2}:[\\d]{1,2}$";
            case "UFloat": return "^(0|([1-9][0-9]*))(\\.[0-9]+){0,1}$";
            case "UInt": return "^[\\+]?(0|([1-9]\\d*))$";
                //case "Url": return "^(http[s]{0,1}://)?([-0-9a-z\\u0391-\\uFFE5]{1,50}\\.){1,3}[-0-9a-z\\u0391-\\uFFE5]{2,4}(\\?[^\"><]*)?$";
            case "Url": return "^[^\"><]+$";  //URL采用特殊的验证方式，参看checkUrl方法
            default: return "^[~\\w\\W]+$";
        }
    }
    this.test = function (v, t) {
        var pt = _this.getRegExs(t);
        if (pt == null) return false;
        pt = new RegExp(pt);
        return pt.test(v);
    }
    this.parseUrl = function (parms) {
        var parms = JBody.joinJsons(parms || {}, {
            url: null,
            urlAllowRelate: false, //是否可以是相对地址
            urlAllowSpecialAbs: true, //是否可以是以“/”开头的地址
            urlAllowLocalPath: false,  //是否可以是本地文件
            urlAutoAddHttp: true, //是否自动添加http开头（可能将某些相对地址当做绝对地址分析）
            urlHostOnly: null, //允许的主机名，多个主机名用逗号或|分隔
            protocol: "http|https|ftp|rtsp|mms", //允许的协议，多个协议名用逗号或|分隔 ftp|gopher|http|https|mailto|mms|ed2k|flashget|thunder|news|tencent|uin|msnim|contact
            baseUrl: null,   //基地址
            pathStart: null
        });
        var _PARSE_DEBUG = parms.debug || function () { };
        //Url协议参考 protocol://hostA:username@password.hostB:port/path/parm?query#fragment
        var url = {
            protocol: "",
            username: "",
            password: "",
            host: "",
            hostA: "",
            hostB: "",
            port: "",
            path: "",
            paths: [],
            parm: "",
            query: "",
            fragment: ""
        };
        var obj = {
            state: false,
            isAbsUrl: false,
            isSpecialAbsUrl: false,
            isLocalFile: false,
            parms: parms,
            url: url
        };
        if (!parms.url || parms.url.length > 300) {
            _PARSE_DEBUG("地址过短或过长" + parms.url);
            return obj;
        }
        if (new RegExp("[><]+", "i").test(obj.parms.url)) {
            _PARSE_DEBUG("含有非法字符" + parms.url);
            return obj;
        }
        if (parms.urlHostOnly && !JBody.isArray(parms.urlHostOnly)) parms.urlHostOnly = parms.urlHostOnly.split(parms.urlHostOnly.indexOf("|") > 0 ? "|" : ",");
        if (parms.protocol && !JBody.isArray(parms.protocol)) parms.protocol = parms.protocol.split(parms.protocol.indexOf("|") > 0 ? "|" : ",");
        var urlTemp = obj.parms.url;
        if (urlTemp.indexOf("#") >= 0) {
            if (urlTemp.indexOf("#") < urlTemp.length - 1) url.fragment = urlTemp.substr(urlTemp.indexOf("#") + 1);
            urlTemp = urlTemp.substr(0, urlTemp.indexOf("#"));
        }
        if (urlTemp.indexOf("?") >= 0) {
            if (urlTemp.indexOf("?") < urlTemp.length - 1) url.query = urlTemp.substr(urlTemp.indexOf("?") + 1);
            urlTemp = urlTemp.substr(0, urlTemp.indexOf("?"));
        }
        urlTemp = urlTemp.replace(/\\\\+/g, "/");
        if (new RegExp("^(ftp|gopher|http|https|mailto|mms|ed2k|flashget|thunder|news|tencent|uin|msnim|contact)://", "i").test(urlTemp)) {
            url.protocol = RegExp.$1;
            obj.isAbsUrl = true;
            urlTemp = RegExp.rightContext;
        }
        if (new RegExp("^([a-z]):/", "i").test(urlTemp)) {
            url.protocol = RegExp.$1;
            obj.isLocalFile = true;
            urlTemp = RegExp.rightContext;
        }
        if (obj.isLocalFile && !parms.urlAllowLocalPath) {
            _PARSE_DEBUG("不接受本地路径" + parms.url);
            return obj;
        }
        if (obj.isLocalFile && new RegExp("[\\\\\|\"\\?\\*]+").test(obj.parms.url)) {
            _PARSE_DEBUG("本地文件名含有非法字符" + parms.url);
            return obj;
        }
        if (!obj.isAbsUrl && !obj.isLocalFile && JBody.startWith(urlTemp, "//")) {
            url.protocol = "http";
            obj.isAbsUrl = true;
            urlTemp = urlTemp.substr(2);
        }
        if (!obj.isAbsUrl && !obj.isLocalFile && JBody.startWith(urlTemp, "/")) {
            obj.isSpecialAbsUrl = true;
            urlTemp = urlTemp.substr(1);
        }
        if (obj.isSpecialAbsUrl && !parms.urlAllowSpecialAbs) {
            _PARSE_DEBUG("不接受特殊的绝对地址（以/开头的地址）" + parms.url);
            return obj;
        }
        if (!obj.isAbsUrl && !obj.isSpecialAbsUrl && !parms.urlAllowRelate) {
            if (parms.urlAutoAddHttp &&
                (new RegExp("^([a-z][-0-9a-z]{0,20})(\\.[a-z0-9][-0-9a-z]{0,20})*(\\.[a-z]{2,4})$", "i").test(urlTemp)
                || new RegExp("^([a-z][-0-9a-z]{0,20})(\\.[a-z0-9][-0-9a-z]{0,20})*(\\.[a-z]{2,4})/", "i").test(urlTemp))) {
                url.protocol = "http";
                obj.isAbsUrl = true;
            } else {
                _PARSE_DEBUG("不接受相对地址" + parms.url);
                return obj;
            }
        }
        if (obj.isAbsUrl) {
            if (new RegExp("^(?:([-0-9a-z]+):){0,1}([0-9a-z]+)@([0-9a-z]+)\\.", "i").test(urlTemp)) {
                url.username = RegExp.$3 ? RegExp.$2 : RegExp.$1;
                url.password = RegExp.$3 || RegExp.$2;
                url.hostA = RegExp.$3 ? RegExp.$1 : "";
                urlTemp = RegExp.rightContext;
            }
            if (new RegExp("^([-0-9a-z]+(?:\\.[-0-9a-z]+)+)(?::([0-9]{1,4})){0,1}", "i").test(urlTemp)) {
                url.port = RegExp.$2 || "";
                url.hostB = RegExp.$1;
                urlTemp = RegExp.rightContext;
            }
            if (!url.hostB || url.hostB == "") {
                _PARSE_DEBUG("IP或域名或主机名格式错误" + parms.url);
                return obj;
            }
            url.host = url.hostA + (url.hostA != "" ? "." : "") + url.hostB;
        }
        if (new RegExp("^([^\\?#/]*/)+", "i").test(urlTemp)) {
            url.path = RegExp.lastMatch;
            url.paths = url.path.split("/");
            urlTemp = RegExp.rightContext;
        }
        url.parm = urlTemp;

        if (!obj.isAbsUrl && parms.baseUrl && parms.baseUrl != "") {
            var baseObj = _this.parseUrl(JBody.joinJsons({ url: parms.baseUrl, urlAllowRelate: false, baseUrl: null }, parms));
            if (baseObj.state) {
                url.protocol = baseObj.url.protocol;
                url.username = baseObj.url.username;
                url.password = baseObj.url.password;
                url.hostA = baseObj.url.hostA;
                url.port = baseObj.url.port;
                url.hostB = baseObj.url.hostB;
                url.host = baseObj.url.host;
                for (var i = url.paths.length - 1; i >= 0; i--) {
                    if (url.paths[i] == ".." && baseObj.url.paths.length > 0) {
                        var v = "";
                        while (v == "" && baseObj.url.paths.length > 0) v = baseObj.url.paths.pop();
                        if (v != "") url.paths[i] = v;
                    }
                }
            }
        }
        //if (url.host == "" && location && location.hostname) url.host = location.hostname;
        if (url.host != "" && parms.urlHostOnly && JBody.inArray(url.host.toLowerCase(), parms.urlHostOnly) < 0) {
            _PARSE_DEBUG("主机不在接受范围" + parms.url);
            return obj;
        }
        if (url.protocol != "" && parms.protocol && JBody.inArray(url.protocol.toLowerCase(), parms.protocol) < 0) {
            alert(parms.protocol + "," + JBody.isArray(parms.protocol));
            _PARSE_DEBUG("协议" + url.protocol + "不在接受范围" + parms.url);
            return obj;
        }
        obj.url = url;
        obj.state = true;
        //alert(JB.objToStr(obj));
        return obj;

    }
    this.checkUrl = function (parms) {
        var o = _this.parseUrl(parms);
        return (o != null && o.state === true);
    }
    var _eventListenList = new Array();
    this.eventListen = function (opt) {
        opt = opt || {};
        if (JB.isFunction(opt.func)) {
            opt.eventName = opt.eventName || "all";
            for (var i = _eventListenList.length - 1; i >= 0; i--)
                if (_eventListenList[i].eventName == opt.eventName
                    && _eventListenList[i].name == opt.name
                    && _eventListenList[i].func == opt.func
                    && _eventListenList[i].obj == opt.obj) return;
            _eventListenList.push({ eventName: opt.eventName, name: opt.name, obj: opt.obj, func: opt.func });
        }
    }
    this.eventListenRemove = function (opt) {
        opt = opt || {};
        for (var i = _eventListenList.length - 1; i >= 0; i--)
            if ((opt.name != null && _eventListenList[i].name === opt.name)
                || (opt.func != null && _eventListenList[i].func == opt.func)
                || (opt.obj != null && _eventListenList[i].obj === opt.obj)) _eventListenList.splice(i, 1);
        return;
    }
    this.onEvent = function (opt) {
        opt = opt || {};
        if (opt.state !== null) {
            var isFalse = false;
            for (var i = _eventListenList.length - 1; i >= 0; i--) {
                if (_eventListenList[i].obj != null && opt.obj != _eventListenList[i].obj) continue;
                try {
                    isFalse = isFalse || (_eventListenList[i].func({ eventName: opt.eventName, obj: opt.obj || _eventListenList[i].obj, obj2: opt.obj2 || null, state: opt.state, msg: opt.msg, name: _eventListenList[i].name }) === false);
                } catch (e) { }
            }
            return !isFalse;
        }
        return true;
    };
    var styles = ".JBodyValidatorErrorExtendFlash input, .JBodyValidatorErrorExtendFlash textarea, .JBodyValidatorErrorExtendFlash select, "
                + "input.JBodyValidatorErrorExtendFlash, textarea.JBodyValidatorErrorExtendFlash, select.JBodyValidatorErrorExtendFlash, "
                + ".JBodyValidatorErrorExtendFlash input, .JBodyValidatorErrorExtendFlash textarea, .JBodyValidatorErrorExtendFlash select,"
                + "input.JBodyValidatorErrorExtendFlash, textarea.JBodyValidatorErrorExtendFlash, select.JBodyValidatorErrorExtendFlash{  border:solid 1px #ff0000;}"
                + ".JBodyValidatorErrorExtendFlash2 input,.JBodyValidatorErrorExtendFlash2 textarea, .JBodyValidatorErrorExtendFlash2 select, .JBodyValidatorErrorExtendFlash2 input, .JBodyValidatorErrorExtendFlash2 textarea, .JBodyValidatorErrorExtendFlash2 select,"
                + "input.JBodyValidatorErrorExtendFlash2,textarea.JBodyValidatorErrorExtendFlash2, select.JBodyValidatorErrorExtendFlash2, input.JBodyValidatorErrorExtendFlash2, textarea.JBodyValidatorErrorExtendFlash2, select.JBodyValidatorErrorExtendFlash2{  border:solid 1px #ff9900; }"
                + "";
    //JB.addStyle2(styles);
    //JB.attach(window, "resize", _this.reShowShowingMsg);  //不起作用
    //JB.attach(document, "resize", _this.reShowShowingMsg);
    //JB.attach(window, "unload", _destroy);
}
var JBValidatorContainer = new JBodyValidatorContainer();
function JBValidator(opt) {
    if (opt == null) return;
    var _this = this;
    var _setOption = function (option) {
        var _opt = new Object();
        _opt.obj = option.obj || null;
        _opt.varId = option.varId || null;
        _opt.tagName = option.tagName || "INPUT";
        _opt.exType = option.exType || "Text";
        if (!JB.isArray(_opt.exType)) _opt.exType = [_opt.exType];
        _opt.checkWhere = option.checkWhere || "auto";
        _opt.msgPosTo = option.msgPosTo;
        _opt.msgDocParent = option.msgDocParent;
        _opt.msgShowType = option.msgShowType || "Right";
        _opt.msgCloseType = option.msgCloseType || "NotClose";
        _opt.ptEncode = option.ptEncode || "None";
        _opt.ptEncodingName = option.ptEncodingName || "";
        _opt.jsPattern = option.jsPattern || null;
        _opt.erorrMsg = option.erorrMsg || null;
        _opt.successMsg = option.successMsg || null;
        _opt.dataTitle = option.dataTitle || "输入";
        _opt.inputTip = option.inputTip || null;
        _opt.inputTipLinkUrl = option.inputTipLinkUrl || null;
        _opt.innerTextTip = option.innerTextTip || null;
        _opt.tipShow = option.tipShow || "None";
        _opt.tipPos = option.tipPos || "Right";
        _opt.tipDocParent = option.tipDocParent;
        _opt.fireControlIDS = option.fireControlIDS;
        _opt.inCaseHidden = JB.defaultBool(option.inCaseHidden, false);
        _opt.hiddenTestObjID = option.hiddenTestObjID || null;
        _opt.checkAppendOnly = JB.defaultBool(option.checkAppendOnly, false);
        _opt.showSuccess = JB.defaultBool(option.showSuccess, false);
        _opt.checkOnFocusout = JB.defaultBool(option.checkOnFocusout, false);
        _opt.checkOnChange = JB.defaultBool(option.checkOnChange, false);
        _opt.ignoreCase = JB.defaultBool(option.ignoreCase, false);
        _opt.canNull = JB.defaultBool(option.canNull, true);
        _opt.checkAfterInit = JB.defaultBool(option.checkAfterInit, false);
        _opt.min = option.min != null ? option.min : null;
        _opt.max = option.max != null ? option.max : null;
        _opt.minLen = (option.minLen > 0 ? option.minLen : 0);
        _opt.maxLen = (option.maxLen > 0 ? option.maxLen : 65535);
        _opt.afterMSeconds = (option.afterMSeconds > 0 ? option.afterMSeconds : 0);
        _opt.cssClassTip = option.cssClassTip || "tipMsg";
        _opt.cssClassError = option.cssClassError || "errorMsg";
        _opt.cssClassErrorFlash = option.cssClassErrorFlash || "errorMsg2";  //闪动提示，轮换的样式
        _opt.cssClassSuccess = option.cssClassSuccess || "successMsg";
        _opt.cssTextTip = option.cssTextTip || "";
        _opt.cssTextError = option.cssTextError || "";
        _opt.cssTextSuccess = option.cssTextSuccess || "";
        _opt.validateIndex = option.validateIndex || null;    //验证的序号
        _opt.appendChecks = option.appendChecks || new Array();
        _opt.urlAllowRelate = JB.defaultBool(option.urlAllowRelate, false);
        _opt.urlHostOnly = option.urlHostOnly || null;
        if (typeof (_opt.urlHostOnly) == "string") _opt.urlHostOnly = _opt.urlHostOnly.split(',');
        return _opt;
    }
    var _opt = _setOption(opt);
    var _obj = null;
    var _dialog = new JBodyDialog();
    var _fireObjs = new Array();
    var _msgContainerOldCssText = "";
    var _msgContainerOldCssClass = "";
    var _msgContainerOldHtml = "";
    var _checkCount = 0;
    var _showing = false;
    var _DEBUG = opt.debugCallback || function (msg) { return true; };
    this.obj = function () { return _obj; }
    this.ValidateIndex = function () {
        var vIndex = _opt.validateIndex || 1;
        if (!_opt.validateIndex) {  //根据纵坐标做排序
            var obj = _obj;
            if (_opt.hiddenTestObjID != null && _opt.hiddenTestObjID != "") obj = document.getElementById(_opt.hiddenTestObjID);
            if (!_isObjOrParentDisplayNone(obj)) {
                try {
                    return 100 + 1 / JB.getAbsolutePosition(obj).t;  //倒数
                } catch (e) { }
            }
        }
        return _opt.validateIndex || 1;
    }
    this.containFireObj = function (obj) {
        for (var i = 0; i < _fireObjs.length; i++) {
            if (_fireObjs[i] == obj) return true;
        }
        return false;
    }
    this.onEvent = function (name) {

    }
    _this.status = 0;  //0:empty, 1:error, 2:success
    _this.msg = "";  //公开给外部调用
    var _getMsg = function (t) {
        switch (t) {
            case "Account": return "必须以字母开头，只能包含字母数字及下划线";
            case "AccountOrMobileOrEmail": return "（以字母开头的数字和字母或下划线）或手机或电子邮箱";
            case "Chinease": return "只能输入中文";
            case "ChineaseAndNum": return "只能输入中文及数字";;
            case "Date": return "格式错误，正确格式如2000-10-10";
            case "DateTime": return "格式错误，正确格式如2000-10-10 10:10:10";
            case "Email": return "格式不符";
            case "EnglishChar": return "只能输入英文字母";
            case "EnglishCharAndNum": return "只能输入英文字母和数字";
            case "Float": return "格式不符";
            case "Identity": return "必须以字母开头，只能包含字母数字及下划线";
            case "Int": return "只能输入整数";
            case "Mobile": return "格式不符";
            case "Number": return "只能输入数字";
            case "Password": return "应为6到16位字符";
            case "QQ": return "不是有效的QQ号码";
            case "Telephone": return "格式错误，正确格式如888888或020-888888或020-888888-123";
            case "TelephoneA_B": return "格式错误，正确格式如020-888888";
            case "TelephoneA_B_C": return "格式错误，正确格式如020-888888-123";
            case "TelephoneB": return "格式错误，正确格式如888888";
            case "Text": return "格式不符";
            case "Time": return "格式错误，正确格式如10:10:10";
            case "UFloat": return "只能是0或正小数";
            case "UInt": return "只能输入0或正整数";
            case "Url": return "格式无效";
            default: return "格式错误";
        }
    }
    var _isChinese = function (str) {
        var reg = /^[\u0391-\uFFE5]+$/;
        return reg.test(str);
    }
    var _getLength = function (str) {
        var len = str.length;
        for (var i = 0; i < str.length; i++) if (_isChinese(str.substr(i, 1))) len += 1;
        return len;
    }
    var _icon = function (t, opt) { }
    var _isObjOrParentDisplayNone = function (obj) {
        //while (obj) {
        //    if (obj.style && obj.style.display == "none") return true;
        //    obj = obj.parentNode;
        //}
        //return false;
        return JB.isHide(obj, true);
    }
    var _shouldJump = function () {
        var obj = _obj;
        if (_opt.hiddenTestObjID != null && _opt.hiddenTestObjID != "") obj = document.getElementById(_opt.hiddenTestObjID);
        return (_isObjOrParentDisplayNone(obj) && !_opt.inCaseHidden);
    }
    this.checkCount = function () { return _checkCount + 0; }
    this.showSuccess = function () { return _opt.showSuccess; }
    this.getMsgShowType = function () { return _opt.msgShowType; }
    this.getCheckWhere = function () { return _opt.checkWhere; }
    var _appendCheckArray = new Array();
    //this.checkInputCustmAppend = function() { return true; }
    this.tryAppendCustmCheck = function (obj, fun) {
        if (_obj != obj) return false;
        _appendCheckArray.push(fun);
        return true;
    }
    this.checkUrl = function (str) {
        return JBValidatorContainer.checkUrl(
            {
                url: str,
                urlHostOnly: _opt.urlHostOnly,
                urlAllowRelate: _opt.urlAllowRelate,
                urlAllowLocalPath: false,
                urlAllowSpecialAbs: true
            });
    }
    this.checkOnly = function () {
        //_DEBUG("checkOnly");
        _this.closeMsg();
        //try {
        if (_shouldJump()) { _this.status = 2; return true; }  //跳过
        _this.msg = _opt.erorrMsg || (_opt.dataTitle + _getMsg(_opt.exType[0]));
        _this.status = 2;
        if (_opt.checkAppendOnly) {
            //if (_this.checkInputCustmAppend(_this) !== true) _this.status = 1;
            for (var i = 0; i < _appendCheckArray.length; i++) {
                if (!JB.isFunction(_appendCheckArray[i])) continue;
                if (_appendCheckArray[i](_this) !== true) { _this.status = 1; break; }
            }
        } else {
            var v = JB.trim(_obj.value + "");
            if (_opt.innerTextTip) v = JB.trim(JBInputInnerTips.val(_obj)); //输入内容为提示信息(处理一些换行的兼容问题)
            if (v == "" && _opt.canNull === true) { }
            else if (v == "" && _opt.canNull === false) { _this.status = 1; _this.msg = _opt.erorrMsg || ("请填写" + _opt.dataTitle); }
            else if (v.length < _opt.minLen) { _this.status = 1; _this.msg = (_opt.dataTitle + "最小长度为" + _opt.minLen); }
            else if (v.length > _opt.maxLen) { _this.status = 1; _this.msg = (_opt.dataTitle + "最大长度为" + _opt.maxLen); }
            else {
                for (var i = 0; i < _opt.exType.length; i++) {
                    var _opt_exType = _opt.exType[i];
                    _this.msg = _opt.erorrMsg || (_opt.dataTitle + _getMsg(_opt_exType));
                    var pt = _opt.jsPattern;
                    if (pt == null) pt = JBValidatorContainer.getRegExs(_opt_exType);
                    else if (_opt.ptEncode == "UrlEncode") pt = decodeURI(pt);
                    else if (_opt.ptEncode == "Escape") pt = unescape(pt);
                    if (pt == null) {
                        _this.status = 1;
                    } else {
                        pt = new RegExp(pt, _opt.ignoreCase ? "i" : "");
                        _this.status = pt.test(v) ? 2 : 1;
                        if (_opt_exType == "Float" || _opt_exType == "Int" || _opt_exType == "UFloat" || _opt_exType == "UInt") {
                            if (_opt.max != null && !(parseFloat(v) <= _opt.max)) {
                                _this.status = 1;
                                _this.msg = _opt.dataTitle + "最大值不能超过" + _opt.max;
                            }
                            if (_opt.min != null && !(parseFloat(v) >= _opt.min)) {
                                _this.status = 1;
                                _this.msg = _opt.dataTitle + "最小值不能小于" + _opt.min;
                            }
                        }
                    }
                    if (_this.status == 2 && _opt_exType == "Url" && !_this.checkUrl(v)) _this.status = 1;
                    if (_this.status == 2 || _opt.jsPattern != null) break; //其中一个匹配即通过验证                        
                    //if (_this.status == 1) alert(v + ",##," + pt);
                }
            }
        }
        if (_this.status == 2) {
            if (_opt.checkAppendOnly != true) {
                for (var i = 0; i < _appendCheckArray.length; i++) {
                    if (!JB.isFunction(_appendCheckArray[i])) continue;
                    if (_appendCheckArray[i](_this) !== true) {
                        _this.status = 1;
                        break;
                    }
                }
            }
            if (_this.status == 2) _this.msg = (_opt.successMsg != null ? _opt.successMsg : (_opt.dataTitle + "输入正确"));
        }
        //} catch (e) {
        //    _this.msg = e.description;
        //    _this.status == 1;
        //    alert(e.description);
        //}
        JBValidatorContainer.onEvent({ obj: _obj, obj2: _opt.msgPosTo, msg: _this.msg, state: _this.status == 2 });
        return (_this.status == 2);
    }
    this.checkInputOnly = this.checkOnly;   //兼容之前的代码，checkInputOnly名称有局限，容易误解，不建议再使用
    this.showMsgAlert = function () {
        if (_opt.msgShowType == "Alert") alert(_this.msg);
    }
    var _getSuccessMsgOption = function () {
        var msgopt = { htm: (_opt.successMsg || "&nbsp;"), className: (_opt.cssClassSuccess || (_opt.successMsg ? "JBodyValidator_success" : "JBodyValidator_success2")) };
        if (!_opt.cssClassSuccess || _opt.cssTextSuccess) {
            msgopt.css = ["cssText", _opt.cssTextSuccess || (_opt.successMsg ? "border:solid 1px #CC0000; background-color:#FFE6E6; color:#666666; line-height:20px; padding-left:3px; padding-right:3px;"
                : "width:23px; height:23px; border:solid 1px #FFFFFF; background:#FFFFFF url(/images/collect.png) no-repeat; color:#666666; line-height:20px; height:20px;")];
        }
        return msgopt;
    }
    var _getErrorMsgOption = function () {
        var msgopt = { htm: _this.msg, className: (_opt.cssClassError || "JBodyValidator_error") };
        if (!_opt.cssClassError || _opt.cssTextError) {
            msgopt.css = ["cssText", _opt.cssTextError || "border:solid 1px #CC0000; background-color:#FFE6E6; color:#666666; line-height:20px; padding-left:3px; padding-right:3px;"];
        }
        return msgopt;
    }
    var _flashErrorMsgObj = null;
    this.flashErrorMsg = function (m) {
        if (m == null || m <= 0) return;
        if (_this.status != 1 || _opt.cssClassError == null || _opt.cssClassError == "" || _opt.cssClassErrorFlash == null || _opt.cssClassErrorFlash == "") return;
        if (_opt.msgShowType == "InnerText" && _opt.msgPosTo && _opt.msgPosTo != _obj) {
            //_opt.msgPosTo.className = _opt.msgPosTo.className == _opt.cssClassError ? _opt.cssClassErrorFlash : _opt.cssClassError;
            if (JB.containClass(_opt.msgPosTo, _opt.cssClassError)) {
                JB.removeClass(_opt.cssClassError);
                JB.addClass(_opt.cssClassErrorFlash);
            } else {
                JB.removeClass(_opt.cssClassErrorFlash);
                JB.addClass(_opt.cssClassError);
            }
        } else {
            var msg3 = _dialog.winObj();
            if (msg3) msg3 = msg3.getElementsByTagName("P");
            if (msg3) msg3 = msg3[0];
            if (msg3) msg3.className = msg3.className == _opt.cssClassError ? _opt.cssClassErrorFlash : _opt.cssClassError;
        }
        _flashErrorMsgObj = JB.setTimeout(_this.flashErrorMsg, 100, m - 150);
    }
    this.showMsg = function (optn) {
        //try {
        //_DEBUG("showMsg");
        optn = optn || {};
        optn.scrollToSee = JB.undef(optn.scrollToSee, true);
        optn.styleFlash = JB.undef(optn.styleFlash, true);
        _this.closeMsg();
        _showing = true;
        JBValidatorContainer.onEvent({ obj: _obj, obj2: _opt.msgPosTo, eventName: "showMsg", msg: _this.msg, state: _this.status == 2 });
        if (optn.tryScroll !== false) JBValidatorContainer.onEvent({ obj: _obj, obj2: _opt.msgPosTo, eventName: "scroll", msg: _this.msg, state: _this.status == 2 });
        if (_opt.msgShowType != "Alert" && _opt.msgShowType != "None") {
            if (_this.status == 2 && _obj.value != null && JB.trim(_obj.value) == "") return;
            var mmScrollTo = _opt.msgPosTo;
            if (_opt.msgShowType == "InnerText" && _opt.msgPosTo && _opt.msgPosTo != _obj) {
                var msgOption = (_this.status == 2) ? _getSuccessMsgOption() : _getErrorMsgOption();
                var className = msgOption.className || "";
                msgOption.className = null;
                JB.setOpt(_opt.msgPosTo, msgOption);
                if (className != "") JB.addClass(_opt.msgPosTo, className);
            } else {
                var dialogoption = {
                    w: 0, h: 20,
                    showTitle: false,
                    showCloseButton: (_opt.msgCloseType != "NotClose"),
                    shadow: 0,
                    alphaBorder: 0,
                    borderInner: 0,
                    modal: (_opt.msgShowType == "Modal"),
                    autoClose: (_opt.msgCloseType == "AfterMSeconds" ? _opt.afterMSeconds : 0),
                    padding: 0,
                    corner: { tL: 0, tR: 0, bL: 0, bR: 0 },
                    talign: "left",
                    pos: {
                        to: (_opt.msgShowType == "Modal" ? "win" : "obj"),
                        park: "outside", parkOutside: (_opt.msgShowType == "Modal" ? "Right" : _opt.msgShowType),
                        parkInside: "center",
                        parkSmart: false,
                        parent: "doc", //(_opt.msgDocParent || _obj.parentNode || "doc"),
                        offset: { l: (_opt.msgShowType.toLowerCase() == "right" ? 5 : 0), t: 0 }
                    }
                };
                var msgOption = (_this.status == 2) ? _getSuccessMsgOption() : _getErrorMsgOption();
                var className = msgOption.className || "";
                msgOption.className = null;
                var msgmsg = JB.newObj("P", msgOption);
                if (className != "") JB.addClass(msgmsg, className);
                _dialog.show(_opt.msgPosTo, msgmsg, dialogoption, false); //DEBUG
                mmScrollTo = msgmsg;
            }
            if (_this.status != 2) {
                if (optn.styleFlash) _flashErrorMsgObj = JB.setTimeout(_this.flashErrorMsg, 100, 800);
                if (!optn.scrollToSee) return;
                var pospos = JB.getAbsoluteOffset(mmScrollTo);

                //alert(JB.objToStr(_opt));  //调试
                var pagesize = JB.getPageSize();
                var scrpos = JB.getScrollPos();
                var mv = false;
                if (scrpos.x > pospos.l || (scrpos.x + pagesize.winW) < pospos.l) {
                    scrpos.x = Math.max(0, pospos.l - 5);
                    mv = true;
                }
                if (scrpos.y > pospos.t || (scrpos.y + pagesize.winH) < pospos.t) {
                    scrpos.y = Math.max(0, pospos.t - 5);
                    mv = true;
                }
                if (mv) {
                    window.scrollTo(scrpos.x, scrpos.y);  //滚动到提示位置
                }
                if (window != top) {  //上级窗口滚动到相应位置
                    JB.tryTopCanSee({ obj: mmScrollTo });
                }
            }
        }
        //} catch (e) {
        //    alert("showMsg错误" + e.description);
        //}
    }
    this.reShowShowingMsg = function (optn) {  //重置位置
        optn = optn || {};
        optn.scrollToSee = JB.undef(optn.scrollToSee, false);
        optn.styleFlash = JB.undef(optn.styleFlash, false);
        optn.tryScroll = false;  //仅仅调整位置，不调整滚动条
        if (!_showing) return;
        if (optn.objOrParent) {
            var tmp_obj = _obj;
            while (tmp_obj) {
                if (tmp_obj == optn.objOrParent) _this.showMsg(optn);
                tmp_obj = tmp_obj.parentNode;
            }
        } else { _this.showMsg(optn); }
    }
    this.tryCheck = function (obj, fun) {
        if (_obj != obj) return { match: false, pass: false };
        return { match: true, pass: _this.check() };
    }
    this.tryCheckForParent = function (parentObj) {
        var tmp_obj = _obj;
        while (tmp_obj) {
            if (tmp_obj == parentObj) return { match: true, pass: _this.check() };
            if (tmp_obj.parentNode == null) return { match: false, pass: false };
            tmp_obj = tmp_obj.parentNode;
        }
        return { match: false, pass: false };
    }
    this.check = function () {
        _checkCount++;
        try {
            //_DEBUG("check");
            if (_flashErrorMsgObj != null) clearTimeout(_flashErrorMsgObj);
            _this.checkOnly();
        } catch (e) {
            _this.status = 1;
            _this.msg = e.description;
            //alert("JBValidator.check错误" + _this.msg);
        }
        //JBValidatorContainer.onEvent({ obj: _obj, msg: _this.msg, state: _this.status == 2 });
        if (_shouldJump()) { return true; }  //跳过
        if ((_opt.showSuccess || _this.status == 1) && _opt.msgShowType != "NotAuto") {
            _this.showMsgAlert();
            _this.showMsg({ scrollToSee: false });
        }
        JBValidatorContainer.onEvent({ obj: _obj, obj2: _opt.msgPosTo, msg: _this.msg, state: _this.status == 2 });
        return (_this.status == 2);
    }
    this.checkInput = this.check;  //兼容之前的代码，checkInput名称有局限，容易误解，不建议再使用
    this.closeMsg = function (objOrParent) {
        if (objOrParent == null) {
            _showing = false;
            if (_opt.msgShowType == "InnerText" && _opt.msgPosTo && _opt.msgPosTo != _obj) {
                _opt.msgPosTo.innerHTML = _msgContainerOldHtml;
                _opt.msgPosTo.className = _msgContainerOldCssClass;
                _opt.msgPosTo.cssText = _msgContainerOldCssText;
            } else {
                _dialog.close();
            }
            JBValidatorContainer.onEvent({ eventName: "close", obj: _obj, obj2: _opt.msgPosTo, msg: _this.msg });
        } else {
            if (_flashErrorMsgObj) clearTimeout(_flashErrorMsgObj);
            var tmp_obj = _obj;
            while (tmp_obj) {
                if (tmp_obj == objOrParent) _this.closeMsg();
                tmp_obj = tmp_obj.parentNode;
            }
        }
    }
    var _getTipOption = function () {
        var tipopt = { htm: _opt.inputTip };
        if (_opt.inputTipLinkUrl) tipopt.htm = ("<a href=\"" + _opt.inputTipLinkUrl + "\" target='_blank'>" + tipopt.htm + "</a>");
        tipopt.className = _opt.cssClassTip || "JBodyValidator_tip";
        if (!_opt.cssClassTip || _opt.cssTextTip)
            tipopt.css = ["cssText", _opt.cssTextTip || "border:solid 1px #42B4FF; background-color:#F2FAFF; color:#666666; line-height:20px; padding-left:3px; padding-right:3px;"];
        return tipopt;
    }
    var _showTips = function () {
        if (_shouldJump()) return;  //跳过
        if (_flashErrorMsgObj != null) clearTimeout(_flashErrorMsgObj);
        if (_opt.tipPos == "InnerText" && _opt.msgPosTo != _obj) {
            var msgOption = _getTipOption();
            var className = msgOption.className || "";
            msgOption.className = null;
            JB.setOpt(_opt.msgPosTo, msgOption);
            JB.removeClass(_opt.msgPosTo, _opt.cssClassErrorFlash);
            JB.removeClass(_opt.msgPosTo, _opt.cssClassError);
            if (className != "") JB.addClass(_opt.msgPosTo, className);
        } else {
            var msgOption = _getTipOption();
            var className = msgOption.className || "";
            msgOption.className = null;
            var msgmsg = JB.newObj("P", msgOption);
            JB.removeClass(msgmsg, _opt.cssClassErrorFlash);
            JB.removeClass(msgmsg, _opt.cssClassError);
            if (className != "") JB.addClass(msgmsg, className);
            _dialog.show(_opt.msgPosTo, msgmsg,
            {
                w: 0, h: 22,
                showTitle: false, showCloseButton: false, shadow: 0, borderInner: 0,
                modal: false, autoClose: 0, padding: 0, talign: "left", alphaBorder: 0,
                corner: { tL: 0, tR: 0, bL: 0, bR: 0 },
                pos: {
                    park: "outside", parkOutside: (_opt.tipPos == "Right" ? "right" : (_opt.tipPos == "RightTop" ? "RightTop" : "bottomLeft")),
                    parkSmart: false,
                    parent: "doc", //(_opt.tipDocParent || _obj.parentNode || "doc"),
                    offset: { l: (_opt.tipPos.toLowerCase() == "right" ? 5 : 0), t: 0 }
                }
            });
        }
    }
    var _hidTip = function () {
        if (_this.status == 0 && JB.trim(_obj.value) == "") {
            if (_opt.tipShow == "StartAndOnfoucs") return;
            if (_opt.tipPos == "InnerText" && _opt.msgPosTo && _opt.msgPosTo != _obj) {
                _opt.msgPosTo.innerHTML = _msgContainerOldHtml;
                _opt.msgPosTo.className = _msgContainerOldCssClass;
                _opt.msgPosTo.cssText = _msgContainerOldCssText;
            } else _dialog.close();
        }
        else if (_opt.checkOnFocusout != true && _opt.msgShowType != "Modal"
        && _opt.msgShowType != "Alert" && _opt.msgShowType != "NotAuto") _this.checkInput();
    }
    this.showTip = _showTips;
    this.hideTip = _hidTip;
    var _init = function () {
        if (_opt.obj) _obj = _opt.obj;
        if (typeof (_obj) == "string") _obj = document.getElementById(_obj);
        if (_obj == null) {
            var ips = document.documentElement.getElementsByTagName("INPUT");
            for (var i = 0; i < ips.length; i++) if (ips[i].getAttribute("data-jbextendid") === _opt.varId) _obj = ips[i];
            if (_obj == null) ips = document.documentElement.getElementsByTagName("TEXTAREA");
            for (var i = 0; i < ips.length; i++) if (ips[i].getAttribute("data-jbextendid") === _opt.varId) _obj = ips[i];
            if (_obj == null) ips = document.documentElement.getElementsByTagName("SELECT");
            for (var i = 0; i < ips.length; i++) if (ips[i].getAttribute("data-jbextendid") === _opt.varId) _obj = ips[i];
            if (_obj == null && _opt.tagName) ips = document.documentElement.getElementsByTagName(_opt.tagName);
            for (var i = 0; i < ips.length; i++) if (ips[i].getAttribute("data-jbextendid") === _opt.varId) _obj = ips[i];
            if (_obj == null) return;
        }
        if (_opt.msgPosTo == null) _opt.msgPosTo = _obj;
        if (typeof (_opt.msgPosTo) == "string") _opt.msgPosTo = document.getElementById(_opt.msgPosTo);
        if (_opt.msgPosTo != null) {
            _msgContainerOldCssText = _opt.msgPosTo.style.cssText;
            _msgContainerOldHtml = _opt.msgPosTo.innerHTML;
            _msgContainerOldCssClass = _opt.msgPosTo.className;
        }
        if (_opt.fireControlIDS) {
            var fireids = _opt.fireControlIDS.split('|');
            for (var j = 0; j < fireids.length; j++) {
                var f = document.getElementById(fireids[j]);
                if (f == null || _this.containFireObj(f)) continue;
                _fireObjs.push(f);
            }
        }
        if (_fireObjs.length == 0) {
            var f = _obj;
            while (f.parentNode != null && f.parentNode != document) {
                f = f.parentNode;
                if (f.tagName.toLowerCase() == "form") {
                    _fireObjs.push(f);
                    break;
                }
            }
        }
        for (var i = 0; i < _opt.appendChecks.length; i++) _this.tryAppendCustmCheck(_obj, _opt.appendChecks[i]);
        if (_opt.checkOnChange) JB.attach(_obj, "change", _this.checkInput);
        if (_opt.checkOnFocusout) JB.attach(_obj, "blur", _this.checkInput);
        if (_opt.tipShow == "Onfoucs" || _opt.tipShow == "StartAndOnfoucs") {
            JB.attach(_obj, "focus", _showTips);
            JB.attach(_obj, "blur", _hidTip);
        }
        if (_opt.tipShow == "Start" || _opt.tipShow == "StartAndOnfoucs") _showTips();
        JBValidatorContainer.add(_this);
        for (var i = 0; i < _fireObjs.length; i++) JBValidatorContainer.bindCheck(_fireObjs[i]);
        if (_opt.checkAfterInit && _obj.value && JB.trim(_obj.value) != "" && JB.trim(_obj.value) != _opt.innerTextTip && _opt.checkWhere != "ClientCstum" && _opt.checkWhere != "ServerAndClientCustm") JB.ready(_this.checkInput);

    }
    var _winResize = function () {
        try { _dialog.fixSize(true); } catch (e) { }
    }
    //alert(JB.objToStr(_opt));
    _init();
}

//扩展的出错消息样式，类似气泡消息的形式显示
(function () {
    JB.addStyle(".JBodyValidator_PopoTip_Sub{ "
    + "-webkit-background-clip: border-box; -webkit-background-origin: padding-box; -webkit-background-size: auto; "
    + "background-attachment: scroll;  background-clip: border-box;  background-color: transparent; "
    + "background-image: none;  background-origin: padding-box;background-size: auto; "
    + "border-bottom-color: transparent;  border-bottom-style: solid;  border-bottom-width: 4px; "
    + "border-left-color: transparent; border-left-style: solid; border-left-width: 4px; "
    + "border-right-color: transparent; border-right-style: solid; border-right-width: 4px; "
    + "border-top-color: white; border-top-style: solid; border-top-width: 4px; "
    + "color: white;  cursor: auto; display: inline-block; "
    + "float: none; font-family: Tahoma, 宋体, Arial, Helvetica, Arial, sans-serif; "
    + "font-size: 12px; height: 0px; left: 4px; line-height: 0px; "
    + "list-style-image: none; list-style-position: outside; list-style-type: none; "
    + "margin-right: 0px; overflow-x: hidden; overflow-y: hidden; "
    + "padding-bottom: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px; "
    + "position: relative; text-align: center; text-decoration: none; "
    + "top: 2px; vertical-align: middle; width: 0px; }");
})();
function JBodyValidatorPopoTipExtendBase(optn) {
    if (!optn || !optn.obj) return null;
    var _this = this;
    _this.obj = optn.obj;
    if (typeof (_this.obj) == "string") _this.obj = document.getElementById(_this.obj);
    if (!_this.obj) return null;
    var _dialog = new JBodyDialog();
    var _msg = optn.obj || "";
    var _hide = true;
    var _msgShowType = optn.msgShowType || "alway";  //focus,mouseover,click,alway,none 在哪种情况下显示消息（前提是有消息要显示），除none外可随意组合，其中alway优先
    var _pos = optn.pos || {};
    _pos.to = "obj";
    _pos.parent = _pos.parent || (_msgShowType.indexOf("alway") >= 0 ? "auto" : "doc");
    _pos.park = _pos.park || optn.park || "topleft";
    _pos.park = _pos.park.toLowerCase();
    _pos.offset = _pos.offset || { l: 0, t: 0 };
    _pos.offset.l = JB.undef(_pos.offset.l, 0);
    _pos.offset.t = JB.undef(_pos.offset.t, 0);
    var _offs = JBodyValidatorPopoTipExtend.getParkPos(_pos.park).split(",");
    _pos.offset.l += parseInt(_offs[6]);
    _pos.offset.t += parseInt(_offs[7]);
    _pos.park = _pos.park + " outside";
    var _borderColor = optn.borderColor || "#ff3000";
    var _bgColor = optn.bgColor || ((JB.IE && JB.V < 8) ? "#fa3200" : "rgba(255,50,0,0.8)");
    var _color = optn.color || "#fff";
    var _cssClass = optn.cssClass || JBodyValidatorPopoTipExtend.cssClassNameOfFlash;
    var _cssClass2 = optn.cssClass2 || JBodyValidatorPopoTipExtend.cssClassNameOfFlash2;
    var _zIndex = optn.zIndex || null;
    var _flashTimeoutObj = null;
    this.flash = function (m) {
        if (m == null || m <= 0) { return; }
        var clssName = _this.obj.className;
        var c2 = clssName.indexOf(_cssClass2) >= 0;
        clssName = ("  " + clssName + "  ").replace(" " + _cssClass + " ", " ").replace(" " + _cssClass2 + " ", " ").replace("  ", " ").replace("  ", " ").replace("  ", " ");
        clssName = (c2 ? _cssClass : _cssClass2) + " " + clssName;
        //alert(m + "," + c1 + "," + clssName);
        _this.obj.className = JB.trim(clssName);
        //_flashTimeoutObj = JB.setTimeout(_this.flash, 100, m - 150);
    }
    this.eventCallback = function (opt) {
        if (opt.obj != _this.obj && opt.obj2 != _this.obj) { return; }
        if (opt.state || opt.eventName == "close") { _hide = true; _this.cancel(opt); return; }
        if (opt.eventName == "scroll") { _topScrollToSee(); }
        else {
            if (JB.isHide(_this.obj, true)) return;  //不可见
            _hide = opt.state;
            _msg = opt.msg;
            _this.flash(1000);
            if (!_hide && _msgShowType == "alway") _this.showHideMsg();
        }
        //_topScrollToSee();
    }
    var _topScrollToSee = function () {
        var pospos = JB.getAbsoluteOffset(_this.obj);
        var pagesize = JB.getPageSize();
        var scrpos = JB.getScrollPos();
        var mv = false;
        if (scrpos.x > pospos.l || (scrpos.x + pagesize.winW) < pospos.l) {
            scrpos.x = Math.max(0, pospos.l - 5);
            mv = true;
        }
        if (scrpos.y > pospos.t || (scrpos.y + pagesize.winH) < pospos.t) {
            scrpos.y = Math.max(0, pospos.t - 5);
            mv = true;
        }
        if (mv) window.scrollTo(scrpos.x, scrpos.y);  //滚动到提示位置
        if (window != top) JB.tryTopCanSee({ obj: _this.obj });  //上级窗口滚动到相应位置
    }
    this.cancel = function (opt) {
        if (_flashTimeoutObj != null) clearTimeout(_flashTimeoutObj);
        var clssName = _this.obj.className;
        clssName = (" " + clssName + " ").replace(" " + _cssClass + " ", " ").replace(" " + _cssClass2 + " ", " ").replace("  ", " ");
        _this.obj.className = JB.trim(clssName);
        //_this.showHideMsg();
        _dialog.close();
    }
    var _afterShow = function () {
        var sub = _dialog.winObj().getElementsByTagName("sub")[0];
        var sizeA = { w: sub.offsetWidth, h: sub.offsetHeight };
        var sizeB = { w: _dialog.winObj().offsetWidth, h: _dialog.winObj().offsetHeight };
        var offs = _offs;
        JB.setOpt(sub, {
            css: [["left", parseInt(sizeB.w * parseFloat(offs[0]) + sizeA.w * parseFloat(offs[2]) + parseInt(offs[4])) + "px"],
                ["top", parseInt(sizeB.h * parseFloat(offs[1]) + sizeA.h * parseFloat(offs[3]) + parseInt(offs[5])) + "px"]]
        });
        sub = null;
        return true;
    }
    var _showFlag = 0;
    this.showHideMsg = function () {
        if (_hide || (_showFlag <= 0 && _msgShowType != "alway")) { _dialog.close(); return; }
        var objmsg = JB.newObj("div", { html: "<div style='position:relative;width:0px; height:0px;'></div><div style='padding-left:10px; padding-right:10px; line-height:22px; background-color:transparent;'>" + _msg + "</div>" });
        var p = _pos.park.substr(0, 1).toLowerCase();

        var sub = JB.newObj("sub", { cssClass: "JBodyValidator_PopoTip_Sub", css: [["position", "absolute"], ["borderWidth", "6px"], ["borderColor", "transparent"]] });
        JB.setOpt(sub, { css: ["border" + (p == "l" ? "Left" : p == "r" ? "Right" : p == "t" ? "Top" : "Bottom") + "Color", _borderColor] });
        objmsg.getElementsByTagName("DIV")[0].appendChild(sub);
        sub = null;
        var offs = JBodyValidatorPopoTipExtend.getParkPos(_pos.park).split(",");
        _dialog.show(_this.obj, objmsg, {
            showCloseButton: false,
            showTitle: false,
            shadow: 0,
            colors_border: _borderColor,
            colors_bg: _bgColor,
            colors_text: _color,
            corner: { tL: 3, tR: 3, bL: 3, bR: 3 },
            hideOverfloat: false,
            padding: 0,
            talign: "left",
            pos: _pos,
            zIndex: _zIndex,
            afterShow: _afterShow
        });
    }
    this.focus = function () { _showFlag = (_showFlag | 1); _this.showHideMsg(); }
    this.blur = function () { _showFlag = (_showFlag & (~(1))); _this.showHideMsg(); }
    this.mouseover = function () { _showFlag = (_showFlag | 2); _this.showHideMsg(); }
    this.mouseout = function () { _showFlag = (_showFlag & (~(2))); _this.showHideMsg(); }
    this.click = function () { _showFlag = (_showFlag | 4); _this.showHideMsg(); setTimeout(_this.clickTimeout, 3000); }
    this.clickTimeout = function () { _showFlag = (_showFlag & (~(4))); _this.showHideMsg(); }
    if (!(_msgShowType.indexOf('alway') >= 0)) {
        if ((_msgShowType).indexOf('focus') >= 0) {
            JB.attach(_this.obj, "focus", _this.focus);
            JB.attach(_this.obj, "blur", _this.blur);
        }
        if ((_msgShowType).indexOf('mouseover') >= 0) {
            JB.attach(_this.obj, "mouseover", _this.mouseover);
            JB.attach(_this.obj, "mouseout", _this.mouseout);
        }
        if ((_msgShowType).indexOf('click') >= 0) {
            JB.attach(_this.obj, "click", _this.click);
        }
    }
    return _this;
}
var JBodyValidatorPopoTipExtend = (function () {
    var _this = this;
    var _list = new Array();
    this.eventCallback = function (opt) {
        for (var i = 0; i < _list.length; i++) {
            if (_list[i] != null) _list[i].eventCallback(opt);
        }
    }
    this.add = function (opt) {  //opt:{obj:element|elementId [,park:string] [,color:color] [,borderColor:color] [,bgColor:color] [,flashOnly:bool]}
        _list.push(new JBodyValidatorPopoTipExtendBase(opt));
        return _this;
    }
    var _parkPos = "top,topleft,topright,bottom,bottomleft,bottomright,right,righttop,rightbottom,left,lefttop,leftbottom".split(',');
    var _parkPosOffset = ("0.5,1,-0.5,0,0,-1,0,-5;0,1,0.5,0,0,-1,0,-5;1,1,-1.5,0,0,-1,0,-5;"
        + "0.5,0,-0.5,-1,0,0,0,5;0,0,0.5,-1,0,0,0,5;1,0,-1.5,-1,0,0,0,5;"
        + "0,0.5,-1,-0.5,-1,0,6,0;0,0,-1,0.5,-1,0,6,0;0,1,-1,-1.5,-1,0,6,0;"
        + "1,0.5,0,-0.5,-1,0,-5,0;1,0,0,0.5,-1,0,-5,0;1,1,0,-1.5,-1,0,-5,0").split(';');
    this.getParkPos = function (pos) {
        pos = pos || "topleft";
        for (var i = 0; i < _parkPos.length; i++) if (_parkPos[i] == pos) return _parkPosOffset[i];
        return _parkPosOffset[1];
    }
    this.cssClassNameOfFlash = "JBodyValidatorErrorExtendFlash";
    this.cssClassNameOfFlash2 = "JBodyValidatorErrorExtendFlash2";
    var styles = ".JBodyValidatorErrorExtendFlash input,.JBodyValidatorErrorExtendFlash textarea,.JBodyValidatorErrorExtendFlash select, \r\n"
                 + ".JBodyValidatorErrorExtendFlash input,.JBodyValidatorErrorExtendFlash textarea,.JBodyValidatorErrorExtendFlash select{ border:solid 1px #ff0000;}\r\n"
                 + ".JBodyValidatorErrorExtendFlash2 input,.JBodyValidatorErrorExtendFlash2 textarea,.JBodyValidatorErrorExtendFlash2 select, \r\n"
                 + ".JBodyValidatorErrorExtendFlash2 input,.JBodyValidatorErrorExtendFlash2 textarea,.JBodyValidatorErrorExtendFlash2 select{ border:solid 1px #ff0000;}\r\n"
                 + "";
    JB.addStyle2(styles);
    JBValidatorContainer.eventListen({ func: _this.eventCallback });
    return _this;
})();
//
//=======================================================================
//=======================================================================
(function () {
    JB.addStyle(""
        //下拉年月的翻页
       + "div.jb_calendar_drg_bt { width:36px; height:12px; float:left; background-color:#d0d0d0; border:solid 1px #d0d0d0; line-height:12px; cursor:pointer;  }"
       + "div.jb_calendar_drg_bt_msOver { background-color:#d0d0d0; border:solid 1px #d0d0d0;  }"
       + "div.jb_calendar_drg_year { width:36px; height:16px; line-height:12px; float:left; border:solid 1px #fff; cursor:pointer;  }"
       + "div.jb_calendar_drg_month { width:26px; height:16px;line-height:12px; float:left; border:solid 1px #fff; cursor:pointer;  }"
       + "div.jb_calendar_drg_msOver { background-color:#ffffff; }"
       //时分秒的时间选择
       + ".jb_calendar_timeui_main { width:180px; height:21px; border:solid 0px #000000; float:left; margin-top:5px; }"
       + ".jb_calendar_timeui_hmsobj { width: 20px; height: 19px; float: left; text-align: center; background-color:#ffffff; border:solid 1px #cccccc; }"
       + ".jb_calendar_timeui_timeobjclick_hmsobj { background-color:#ffffff; border:solid 1px #cccccc; }"
       + ".jb_calendar_timeui_timeobjclick_obj { background-color:#FFFCD6; border:solid 1px #D96100; }"
       + ".jb_calendar_timeui_timeobjclick_childNodes { width: 23px;height:19px; line-height:19px; cursor:pointer; float:left; background-color:#ffffff; border:solid 1px #cccccc; }"
       + ".jb_calendar_timeui_timeselect_item { width: 20px; height: 18px; float:left; cursor:pointer; text-align:center; margin-left:2px; margin-top:2px; ling-height:18px; }"
       + ".jb_calendar_timeui_timeselect_itemOver { background-color: #D7EFFF; }"
       + ".jb_calendar_timeui_timeselect_itemOut { background-color: #FFFFFF; }"
       + ".jb_calendar_timeui_bts_main {  width:22px; height:19px; float:left; border; solid 0px #cccccc; }"
       + ".jb_calendar_timeui_bts_up { width:22px; height:9px; text-align:center; line-height:10px; font-size:10px; overflow:hidden; }"
       + ".jb_calendar_timeui_bts_dowm { width:22px; height:9px; text-align:center; line-height:10px; font-size:10px; overflow:hidden; }"
       + ".jb_calendar_timeui_bts_submit {  width:50px;  height:19px; float:left; text-align:center; margin-left:10px; line-height:19px; }"
       + ".jb_calendar_timeui_bts_splitor { width:6px; height:19px; float:left; text-align:center; font-weight:bold; overflow:hidden; }"
       + ".jb_calendar_timeui_btsover_updownsumit { cursor:auto; border:solid 1px #CCC; background-color: #dddddd; color:#aaa; }"
       + ".jb_calendar_timeui_btsover_submit { cursor:pointer; border:solid 1px #264159; background-color: #1B67CC; color:#A8D4FC; }"
       + ".jb_calendar_timeui_btsover_editUpDown { width:22px; height:9px;line-height:10px;text-align:center; cursor:pointer; border:solid 1px #264159; background-color: #1B67CC; color:#A8D4FC; }"
       + ".jb_calendar_timeui_btsover_up { border-bottom:0px; }"
       + ".jb_calendar_timeui_btsover_overobj { border:solid 1px #264159; background-color: #3D81DC; color:#fff; }"
       //标题
       + ".jb_calendar_title_main { height:26px; background-color:#004FB8; margin:2px; padding:0px; margin-bottom:3px; margin-top:0px; }"
       + ".jb_calendar_title_leftmain { height: 24px; float:left; margin-left:20px; }"
       + "div.jb_calendar_title_ymobj { height: 24px; cursor:pointer; color:#ffffff; font-weight:bold; line-height:24px; margin-top:0px; }"
       + "div.jb_calendar_title_bts { width: 18px; height: 18px; border:solid 1px #86A0C3; background-color:#1B67CC; text-align:center; color:#A8D4FC; cursor:pointer; font-size:14px; margin:3px; line-height:18px;}"
       + "div.jb_calendar_title_bts_over { border:solid 1px #86A0C3; background-color:#3D81DC; color:#BDE0FF; }"

       + ".jb_calendar_container {  width: 212px; height: 180px; border:solid 0px #000000; float:left; padding:0px; margin:0px; font-family:Arial,Simsun; }"
       + ".jb_calendar_tablecell {  }"
       + "div.jb_calendar_day_title { width: 28px; height: 22px; float: left; text-align:center; color:#666666; border:solid 1px #ECECEC; background-color:#ECECEC; font-weight:normal; line-height:22px; }"
       + "div.jb_calendar_day_title_weekend { color:#FF9900; font-weight:bold; }"
       + "div.jb_calendar_day { width: 28px; height: 22px; float: left; text-align:center; color:#666666; border:solid 1px #FFF; margin:0px; font-weight:bold; line-height:22px; overflow:hidden; }"
       + "div.jb_calendar_day.color_isout { color:#DBDBDB; }"
       + "div.jb_calendar_day.color_special { color:#CC0000; }"
       + "div.jb_calendar_day.color_currentmonth_weekend { color:#FF9900; }"
       + "div.jb_calendar_day.color_selected_day { color:#FFFFFF; }"
       + "div.jb_calendar_day.color_currentmonth { color:#005EAD; }"
       + "div.jb_calendar_day.color_othermonth { color:#DBDBDB; }"

       + "div.jb_calendar_day.border_today { border:solid 1px #FFE4A9; }"
       + "div.jb_calendar_day.border_selected_day { border:solid 1px #36557B; }"
       + "div.jb_calendar_day.border_mouseover_special { border:solid 1px #FFE4A9; }"
       + "div.jb_calendar_day.border_mouseover { border:solid 1px #71B0E6; }"
       + "div.jb_calendar_day.border_isout { border:solid 1px #FFFFFF; }"
       + "div.jb_calendar_day.border_between_mouseover_n_other_special { border:solid 1px #FFF5D1; }"
       + "div.jb_calendar_day.border_between_mouseover_n_other { border:solid 1px #FD9E5F4; }"
       + "div.jb_calendar_day.border_between_seleted_n_other_special { border:solid 1px #FFF5D1; }"
       + "div.jb_calendar_day.border_between_seleted_n_other { border:solid 1px #F0F5FB; }"
       + "div.jb_calendar_day.border_other { border:solid 1px #FFFFFF; }"
       + "div.jb_calendar_day.border_none { border:solid 1px #FFFFFF; }"

       + "div.jb_calendar_day.bgcolor_selected_day { background-color:#598DCC; }"
       + "div.jb_calendar_day.bgcolor_mouseover_special { background-color:#FFF5D1; }"
       + "div.jb_calendar_day.bgcolor_mouseover { background-color:#E3F3FF; }"
       + "div.jb_calendar_day.bgcolor_between_mouseover_n_other_special { background-color:#FFF5D1; }"
       + "div.jb_calendar_day.bgcolor_between_mouseover_n_other { background-color:#FD9E5F4; }"
       + "div.jb_calendar_day.bgcolor_between_seleted_n_other_special { background-color:#FFF5D1; }"
       + "div.jb_calendar_day.bgcolor_between_seleted_n_other { background-color:#F0F5FB; }"
       + "div.jb_calendar_day.bgcolor_other { background-color:#FFFFFF; }"
       + "div.jb_calendar_day.bgcolor_empty { background-color:#FFFFFF; }"
       + "div.jb_calendar_day.empty { background-color:#FFFFFF; cursor:default; }"

       + ""
       + "");
})()

function JBodyExtendDateInfo() {
    var _this = this;
    _this.getInfo = function (theDate) {
        var _year = theDate.getFullYear();
        var _month = theDate.getMonth();
        var _date = theDate.getDate();
        if (_year < 1900 || _year > 2049) return null;
        var value = new Object();
        value.baseDate = theDate;
        value.baseInfo = { year: _year + 0, month: _month + 0, date: _date + 0 };
        var ymSum = new Array( //1900-2049
        0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
        0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977,
        0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970,
        0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950,
        0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557,
        0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950, 0x06aa0,
        0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0,
        0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
        0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570,
        0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0,
        0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5,
        0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930,
        0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530,
        0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45,
        0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0);
        var ShengQiao = ("鼠,牛,虎,兔,龙,蛇,马,羊,猴,鸡,狗,猪").split(',');
        var TianGan = ("甲,乙,丙,丁,戊,己,庚,辛,壬,癸").split(',');
        var DiZhi = ("子,丑,寅,卯,辰,巳,午,未,申,酉,戌,亥").split(',');

        var ganZhi = function (num) { return (TianGan[num % 10] + DiZhi[num % 12]); }
        var totalDaysOfYear = function (y) {
            var i, sum = 348;
            for (i = 0x8000; i > 0x8; i >>= 1) sum += (ymSum[y - 1900] & i) ? 1 : 0;
            return (sum + leapDays(y));
        }
        var leapDays = function (y) {
            if (getLeapMonth(y)) return ((ymSum[y - 1900] & 0x10000) ? 30 : 29);
            else return (0);
        }
        var getLeapMonth = function (y) { return (ymSum[y - 1900] & 0xf); }
        var monthDays = function (y, m) { return ((ymSum[y - 1900] & (0x10000 >> m)) ? 30 : 29); }

        //==== 返回{year:int,month:int,day:int,isLeap:bool,yearGZ:int,dayGZ:int,monGZ:int}
        var cDateInfo = function (objDate) {
            var i, leap = 0, temp = 0;
            var baseDate = new Date(1900, 0, 31);
            var offset = (objDate - baseDate) / 86400000;
            var dayGZ = offset + 40;
            var monGZ = 14;
            for (i = 1900; i < 2050 && offset > 0; i++) {
                temp = totalDaysOfYear(i);
                offset -= temp;
                monGZ += 12;
            }
            if (offset < 0) {
                offset += temp;
                i--;
                monGZ -= 12;
            }
            var year = i;
            var yearGZ = i - 1864;
            leap = getLeapMonth(i);
            var isLeap = false;

            for (i = 1; i < 13 && offset > 0; i++) {
                if (leap > 0 && i == (leap + 1) && isLeap == false) {
                    --i; isLeap = true; temp = leapDays(year);
                }
                else {
                    temp = monthDays(year, i);
                }
                if (isLeap == true && i == (leap + 1)) isLeap = false;

                offset -= temp;
                if (isLeap == false) monGZ++;
            }
            if (offset == 0 && leap > 0 && i == leap + 1) {
                if (isLeap) { isLeap = false; }
                else { isLeap = true; --i; --monGZ; }
            }
            if (offset < 0) { offset += temp; --i; --monGZ; }
            var month = i;
            var day = offset + 1;
            var date = Math.floor(day / 10) * 10 + Math.floor(day % 10);
            return { year: year, month: month, day: day, date: date, isLeap: isLeap, yearGZ: yearGZ, monGZ: monGZ, dayGZ: dayGZ };
        }
        value.DateInfo = cDateInfo(theDate);
        value.MonthDays = monthDays(value.DateInfo.year, value.DateInfo.month);
        var cDayName = function (m, d) {
            var d1 = ("日,一,二,三,四,五,六,七,八,九,十").split(',');
            var d2 = ('初,十,廿,卅,　').split(',');
            var s;
            if (m == 1) { s = "正"; }
            else if (m > 10) { s = '十' + d1[m - 10] } else { s = d1[m] }
            s += '月';
            switch (d) {
                case 10: s += '初十'; break;
                case 20: s += '二十'; break;
                case 30: s += '三十'; break;
                default: s += d2[Math.floor(d / 10)]; s += d1[Math.floor(d % 10)];
            }
            return (s);
        }
        value.ShengQiao = ShengQiao[(_year - 4) % 12];
        value.GanZhi = { y: ganZhi(_year - 1900 + 36), m: ganZhi(value.DateInfo.monGZ), d: ganZhi(value.DateInfo.dayGZ + 1) };
        value.Name = (value.DateInfo.isLEAP ? "闰" : "") + cDayName(value.DateInfo.month, value.DateInfo.day);
        var cQiJie = function () {
            var qjInfo = new Array(0, 21208, 42467, 63836, 85337, 107014, 128867, 150921, 173149, 195551, 218072, 240693, 263343, 285989, 308563, 331033, 353350, 375494, 397447, 419210, 440795, 462224, 483532, 504758)
            var qjNames = new Array("小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "冬至")
            var aName = '', tmp1, tmp2;
            tmp1 = new Date((31556925974.7 * (_year - 1900) + qjInfo[_month * 2 + 1] * 60000) + Date.UTC(1900, 0, 6, 2, 5));
            tmp2 = tmp1.getUTCDate();
            if (tmp2 == _date) aName = qjNames[_month * 2 + 1];
            tmp1 = new Date((31556925974.7 * (_year - 1900) + qjInfo[_month * 2] * 60000) + Date.UTC(1900, 0, 6, 2, 5));
            tmp2 = tmp1.getUTCDate();
            if (tmp2 == _date) aName = qjNames[_month * 2];
            return aName;
        }
        value.QiJie = cQiJie();
        return value;
    }
    return _this;
}
var JBExtendDateInfo = new JBodyExtendDateInfo();

function JBodyCalendarBase() {
    var _this = this;
    var JB = JBody;
    var _format = { date: "yyyy-MM-dd", time: "HH:mm:ss", datetime: "yyyy-MM-dd HH:mm:ss" };
    var _options = null;
    var _initOptions = function () {
        _options = {
            min: JB.parseDateTime("1920-01-01", _format.date),
            max: JB.parseDateTime("2099-12-31", _format.date),
            current: null,
            other: null,
            isStart: true,
            canSelectedOutsideMinMax: false,
            showDayInPreOrNextMonth: true,
            showSpecialDay: true,
            showBetweenStyle: false,
            showChineseDateInfo: true
        };
    };
    _initOptions();
    var _overNd = null;
    var _obj = null;
    var _colors = ["", ""];
    var _bgColors = ["", ""];
    var _borderColors = ["", ""];
    var _textColors = ["", ""];
    var _btText = ["◄", "►", "▼"];
    var _days = "日一二三四五六";
    var _specialdays = {
        std: [["0101", "元旦", "元旦"], ["0214", "Love", "情人节"], ["0308", "妇女", "妇女节"], ["0312", "", "植树节"], ["0315", "", "消费者权益日"], ["0401", "愚人", "愚人节"], ["0501", "五一", "劳动节"], ["0504", "五四", "青年节"], ["0512", "", "护士节"], ["0601", "六一", "儿童节"], ["0701", "香港", "建党节 香港回归纪念"], ["0801", "八一", "建军节"], ["0910", "教师", "教师节"], ["0928", "孔诞", "孔子诞辰"], ["1001", "国庆", "国庆节"], ["1006", "", "老人节"], ["1024", "", "联合国日"], ["1112", "", "孙中山诞辰"], ["1220", "澳门", "澳门回归纪念"], ["1225", "圣诞", "圣诞节"]],
        chn: [["0101", "春节", "春节"], ["0102", "初二", "年初二"], ["0103", "初三", "年初三"], ["0115", "元宵", "元宵节"], ["0505", "端午", "端午节"], ["0707", "七夕", "七夕情人节"], ["0715", "中元", "中元节"], ["0815", "中秋", "中秋节"], ["0909", "重阳", "重阳节"], ["1208", "腊八", "腊八节"], ["1224", "小年", "小年"], ["1200", "除夕", "除夕"]],
        wd: [["0150", "", "世界麻风日"], ["0520", "母亲", "国际母亲节"], ["0530", "", "全国助残日"], ["0630", "父亲", "父亲节"], ["0730", "", "被奴役国家周"], ["0932", "", "国际和平日"], ["0940", "", "国际聋人节 世界儿童日"], ["0950", "", "世界海事日"], ["1011", "", "国际住房日"], ["1013", "", "国际减轻自然灾害日(减灾日)"], ["1144", "感恩", "感恩节"]]
    };
    var _daysInMonth = function (month, year) {
        var a = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (2 == month) {
            return ((0 == (year % 4)) && (0 != (year % 100)))
           || (0 == (year % 400)) ? 29 : 28;
        }
        else return a[month - 1];
    };
    var _getSpecialday = function (reg, arr) {
        var a = "", b = "";
        for (var i = 0; i < arr.length; i++) {
            for (var r in reg) {
                if (reg[r] != "" && arr[i][0] == reg[r]) {
                    a = ((a == "") ? arr[i][1] : a);
                    b += (b == "" ? "" : " ") + arr[i][2];
                }
            }
        }
        return { a: a, b: b };
    };
    var _getWeekSpecialday = function (d) {
        //var ws = new Date(d.getFullYear(), d.getMonth(), 1).getDay();  //当月第一天是星期几
        //var w = Math.floor((ws + d.getDate() + 6) / 7);  //第几个
        //var islast = (w == Math.floor((ws + _daysInMonth(d.getMonth() + 1, d.getFullYear()) + 6) / 7));  //是否最后一周
        var day = d.getDay();
        var days = _daysInMonth(d.getMonth() + 1, d.getFullYear());
        var islast = (d.getDate() > (days - 7));
        var w = Math.floor((d.getDate() + 6) / 7);
        var reg = JB.padLeft((d.getMonth() + 1) + "", 2, '0') + w + "" + day;
        var reg2 = "";
        if (islast) reg2 = JB.padLeft((d.getMonth() + 1) + "", 2, '0') + "0" + day;  //最后一周的正则
        return _getSpecialday([reg, reg2], _specialdays.wd);
    };
    var _getChnSpecailday = function (cmm, cdd, ds) {
        var reg = JB.padLeft(cmm + "", 2, '0') + JB.padLeft(cdd + "", 2, '0');
        var reg2 = "";
        if (cdd == ds) reg2 = JB.padLeft(cmm + "", 2, '0') + "00"; //最后一天
        return _getSpecialday([reg, reg2], _specialdays.chn);
    };
    var _getStdSpecailday = function (d) {
        var reg = JB.padLeft((d.getMonth() + 1) + "", 2, '0') + JB.padLeft(d.getDate() + "", 2, '0');
        var reg2 = "";
        if (d.getDate() == _daysInMonth(d.getMonth() + 1, d.getFullYear())) reg2 = JB.padLeft((d.getMonth() + 1) + "", 2, '0') + "00"; //最后一天
        return _getSpecialday([reg, reg2], _specialdays.std);
    };
    var _checkSpecialdays = function (d) {
        var dInfo = JBExtendDateInfo.getInfo(d);
        var a = "", b = "";
        var s = new Object();
        if (dInfo != null) s = _getChnSpecailday(parseInt(dInfo.DateInfo.month), parseInt(dInfo.DateInfo.day), dInfo.MonthDays);
        if (a == "" && s && s.a != "") a = s.a;
        if (s && s.b != "") b += (b == "" ? "" : " ") + s.b;
        s = _getStdSpecailday(d);
        if (a == "" && s && s.a && s.a != "") a = s.a;
        if (s && s.b && s.b != "") b += (b == "" ? "" : " ") + s.b;
        s = _getWeekSpecialday(d);
        if (a == "" && s && s.a != "") a = s.a;
        if (s && s.b != "") b += (b == "" ? "" : " ") + s.b;
        if (dInfo.QiJie == "清明" || dInfo.QiJie == "冬至") {
            a = "" + dInfo.QiJie;
            b += (b == "" ? "" : " ") + a;
        }
        return { dInfo: dInfo, a: a, b: b };
    };

    var _setOptions = function (opt) {
        if (opt == null) return;
        _options.dateFormat = opt.dateFormat || _options.dateFormat;
        _options.timeFormat = opt.timeFormat || _options.timeFormat;
        _options.min = opt.min || _options.min;
        _options.max = opt.max || _options.max;
        if (opt.current) _options.current = opt.current;
        if (opt.other) _options.other = opt.other;
        _options.isStart = JB.defaultBool(opt.isStart, false);
        _options.canSelectedOutsideMinMax = JB.undef(opt.canSelectedOutsideMinMax, false);
        _options.showDayInPreOrNextMonth = JB.undef(opt.showDayInPreOrNextMonth, false);
        _options.showSpecialDay = JB.undef(opt.showSpecialDay, true);
        _options.showBetweenStyle = JB.undef(opt.showBetweenStyle, false);
        _options.showChineseDateInfo = JB.undef(opt.showChineseDateInfo, true);
        if (typeof (_options.min) == "string") _options.min = JB.parseDateTime(_options.min, _format.datetime);
        if (typeof (_options.max) == "string") _options.max = JB.parseDateTime(_options.max, _format.datetime);
        if (typeof (_options.current) == "string") _options.current = JB.parseDateTime(_options.current, _format.datetime);
        if (typeof (_options.other) == "string") _options.other = JB.parseDateTime(_options.other, _format.datetime);
    }
    var _isBetween = function (d, d1, d2, d1IsStart) {
        if (d1IsStart == false) return (JB.compareDateTime(d, d1, "d") < 0 && JB.compareDateTime(d, d2, "d") > 0);
        else return (JB.compareDateTime(d, d1, "d") > 0 && JB.compareDateTime(d, d2, "d") < 0);
    }
    var _isEqaul = function (d1, d2) {
        if (d1 == null || d2 == null) return false;
        else return (JB.compareDateTime(d1, d2, "d") === 0);
    }
    this.clickcallback = function (nd) { }
    this.onmouseover = function (nd) { }
    this.onmouseout = function () { }

    var _callbackfun = function (e, fn) {
        e = window.event || e;
        var src = e.srcElement || e.target;
        fn(_findNd(src), true);
        src = null;
    }
    var _onclick = function (e) {
        _callbackfun(e, _this.doclick);
        return false;
    }
    this.doclick = function (nd, fire) {
        if (nd.enable !== true || nd.clickable !== true) return;
        _options.current = nd.dt;
        _setStyle();
        if (JB.isFunction(_this.clickcallback) && (fire === true)) _this.clickcallback(nd);
    }
    var _mouseover = function (e) {
        _callbackfun(e, _this.mouseover);
    }
    this.mouseover = function (nd, fire) {
        if (nd.enable !== true) return;
        _overNd = nd;
        _setStyle(_options.showBetweenStyle ? nd.index : -1);
        _overNd = null;
        if (JB.isFunction(_this.onmouseover) && (fire === true)) _this.onmouseover(nd);
    }
    var _mouseout = function (e) {
        _callbackfun(e, _this.mouseout);
    }
    this.mouseout = function (nd, fire) {
        if (nd == null || nd.enable !== true) return;
        _overNd = null;
        _setStyle(_options.showBetweenStyle ? nd.index : -1);
        if (JB.isFunction(_this.onmouseout) && (fire === true)) _this.onmouseout();
    }
    this.desdroy = function () {
        _overNd = null;
        _obj = null;
    }

    var _data_array = new Array();
    var _UI_divs = new Array();
    var _UI_table = JB.newObj("TABLE", { w: "100%", bgColor: "#FFFFFF", attrs: [["cellPadding", "0"], ["cellSpacing", "1"]], css: [["padding", "0px"], ["margin", "0px"]] });
    for (var i1 = 0; i1 < 7; i1++) {
        var tableCell = JB.insertCell(JB.insertRow(_UI_table));
        for (var i2 = 0; i2 < 7; i2++) {
            if (i1 == 0) {
                tableCell.appendChild(JB.setOpt(JB.newObj("DIV", { htm: _days.charAt(i2) }),
                    { cssClass: ((i2 == 0 || i2 == 6) ? "jb_calendar_day_title jb_calendar_day_title_weekend" : "jb_calendar_day_title") }));
            }
            else {
                var div = JB.newObj("DIV", { htm: "&nbsp;", cssClass: "jb_calendar_day" });
                JB.attach(div, "click", _onclick);
                JB.attach(div, "mouseover", _mouseover);
                JB.attach(div, "mouseout", _mouseout);
                tableCell.appendChild(div);
                _UI_divs.push(div);
                _data_array.push({ index: ((i1 - 1) * 7) + i2, enable: false, clickable: false, dt: null, isToday: false, weekend: false, isCurrentM: false, isout: false, isSpecial: false });
            }
        }
    }

    var _setStyle = function (i) {
        if (i == null || i < 0) {
            for (var i = 0; i < _data_array.length; i++) _setStyle(i);
            return;
        }
        var nd = _data_array[i];
        if (nd.enable !== true) return;
        var opt = new Object();
        opt.color =
            nd.isout ? "color_isout" :
            nd.isSpecial ? "color_special" :
            (nd.weekend && nd.isCurrentM) ? "color_currentmonth_weekend" :
            (_isEqaul(nd.dt, _options.current) || _isEqaul(nd.dt, _options.other)) ? "color_selected_day" :
            (nd.isCurrentM) ? "color_currentmonth" : "color_othermonth";

        opt.border = nd.isToday ? "border_today" :
                   (_isEqaul(nd.dt, _options.current) || _isEqaul(nd.dt, _options.other)) ? "border_selected_day" :
                   (nd == _overNd) ? (nd.isSpecial ? "border_mouseover_special" : "border_mouseover") :
                   (nd.isout) ? "border_isout" :
                   (_options.showBetweenStyle && _overNd && _isBetween(nd.dt, _overNd.dt, _options.other, _options.isStart)) ? (nd.isSpecial ? "border_between_mouseover_n_other_special" : "border_between_mouseover_n_other") :
                   (_options.showBetweenStyle && _isBetween(nd.dt, _options.current, _options.other, _options.isStart)) ? (nd.isSpecial ? "border_between_seleted_n_other_special" : "border_between_seleted_n_other") :
                   "border_other";
        opt.bgColor = (_isEqaul(nd.dt, _options.current) || _isEqaul(nd.dt, _options.other)) ? "bgcolor_selected_day" :
                   (nd == _overNd) ? (nd.isSpecial ? "bgcolor_mouseover_special" : "bgcolor_mouseover") :
                   (_options.showBetweenStyle && _overNd && _isBetween(nd.dt, _overNd.dt, _options.other, _options.isStart)) ? (nd.isSpecial ? "bgcolor_between_mouseover_n_other_special" : "bgcolor_between_mouseover_n_other") :
                   (_options.showBetweenStyle && _isBetween(nd.dt, _options.current, _options.other, _options.isStart)) ? (nd.isSpecial ? "bgcolor_between_seleted_n_other_special" : "bgcolor_between_seleted_n_other") :
                   "bgcolor_other";
        if (!_options.showDayInPreOrNextMonth && !nd.isCurrentM) {
            opt.border = "border_none";
            opt.bgColor = "bgcolor_empty";
        }
        JB.setOpt(_UI_divs[i], { cssClass: "jb_calendar_day" });
        JB.addClass(_UI_divs[i], opt.bgColor);
        JB.addClass(_UI_divs[i], opt.border);
        JB.addClass(_UI_divs[i], opt.color);
    }
    var _findNd = function (div) {
        for (var i = 0; i < _UI_divs.length; i++) {
            if (_UI_divs[i] == div) return _data_array[i];
        }
        return null;
    };
    var _newDate = function (dt, isCurrentMonth, aIndex) {
        var div = _UI_divs[aIndex];
        var nd = _data_array[aIndex];
        nd.enable = (isCurrentMonth || _options.showDayInPreOrNextMonth);
        nd.isout = (JB.compareDateTime(dt, _options.min, "d") < 0 || JB.compareDateTime(dt, _options.max, "d") > 0);
        nd.clickable = nd.enable && (!nd.isout || _options.canSelectedOutsideMinMax);
        if (nd.enable !== true) {
            JB.setOpt(div, { htm: "&nbsp;", cssClass: "jb_calendar_day", attrs: ["title", ""] });
            return;
        }
        var tip = (dt.getMonth() + 1) + "月" + dt.getDate() + "日，星期" + _days.charAt(dt.getDay());
        var sphtm = _checkSpecialdays(dt);
        if (_options.showChineseDateInfo && sphtm.dInfo) tip += "\r\n农历" + sphtm.dInfo.Name + ((sphtm.dInfo.QiJie == "") ? "" : (" (" + sphtm.dInfo.QiJie + ")"));
        if (sphtm.b != "" && _options.showSpecialDay) tip += "\r\n" + sphtm.b;
        var htm = (sphtm.a != "" && _options.showSpecialDay) ? sphtm.a : (dt.getDate() + "");

        //if (sphtm.a != "" && _options.showSpecialDay) {
        //    JB.setOpt(div, { css: ["fontSize", JB.IE ? "11px" : "10px"] });
        //    JB.setOpt(div, { css: ["webkitTextSizeAdjust", "none"] });
        //    //alert(JB.IE ? "10px" : "11px");
        //}
        //else JB.setOpt(div, { css: ["fontSize", "12px"] });

        nd.dt = dt;
        nd.isToday = JB.compareDateTime(dt, new Date(), "d") == 0;
        nd.weekend = (dt.getDay() == 0 || dt.getDay() == 6);
        nd.isCurrentM = isCurrentMonth;
        nd.isSpecial = (sphtm.a != "" && _options.showSpecialDay);
        JB.setOpt(div, { htm: htm, cursor: "pointer", attrs: ["title", tip] });
    }
    this.getUi = function (y, m, opt) {
        _obj = null;
        _initOptions();
        _setOptions(opt);
        if (y > _options.max.getFullYear()) y = _options.max.getFullYear();
        if (y < _options.min.getFullYear()) y = _options.min.getFullYear();

        m = m - 1;
        if (m < 0) m = 0;
        if (m > 11) m = 11;
        if (y == _options.max.getFullYear() && m > _options.max.getMonth()) m = _options.max.getMonth();
        if (y == _options.min.getFullYear() && m < _options.min.getMonth()) m = _options.min.getMonth();
        m = m + 1;

        var thisMonthDayCount = _daysInMonth(m, y);
        var preM = { y: y, m: (m - 1) };
        if (preM.m < 1) { preM.m = 12; preM.y = y - 1; }
        var nextM = { y: y, m: (m + 1) };
        if (nextM.m > 12) { nextM.m = 1; nextM.y = y + 1; }

        var day = new Date(y, m - 1, 1).getDay();
        var lastMonthDayCount = _daysInMonth(preM.m, preM.y);
        var rows = Math.floor((thisMonthDayCount + day + 6) / 7);
        _obj = JB.newObj("DIV", { cssClass: "jb_calendar_container" });
        var k = 0;
        //last month
        for (i = 0; i < day; i++) _newDate(new Date(preM.y, preM.m - 1, (lastMonthDayCount - (day - 1)) + i), false, k++); //上一月的日期
        //this month
        for (i = 1; i <= thisMonthDayCount; i++) _newDate(new Date(y, m - 1, i), true, k++);
        //next month
        day = new Date(nextM.y, nextM.m - 1, 1).getDay();
        if (day > 0) for (i = day; i <= 6; i++) _newDate(new Date(nextM.y, nextM.m - 1, (i + 1) - day), false, k++); //下一月的日期
        for (i = k; i < _data_array.length; i++) {
            _data_array[i].enable = false;
            JB.setOpt(_UI_divs[i], { htm: "&nbsp;", border: "solid 1px #ffffff", bgColor: "#ffffff" });
        }
        _setStyle();
        _obj.appendChild(_UI_table);
        return _obj;
    }
}
function JBodyCalendar() {
    var _this = this;
    var JB = JBody;
    var cssClassNames = {
        //下拉年月的翻页
        jb_calendar_drg_bt: "jb_calendar_drg_bt",
        jb_calendar_drg_bt_msOver: "jb_calendar_drg_bt_msOver",
        jb_calendar_drg_year: "jb_calendar_drg_year",
        jb_calendar_drg_month: "jb_calendar_drg_month",
        jb_calendar_drg_msOver: "jb_calendar_drg_msOver",
        //标题
        jb_calendar_title_main: "jb_calendar_title_main",
        jb_calendar_title_leftmain: "jb_calendar_title_leftmain",
        jb_calendar_title_ymobj: "jb_calendar_title_ymobj",
        jb_calendar_title_bts: "jb_calendar_title_bts",
        jb_calendar_title_bts_over: "jb_calendar_title_bts_over",
        //时间选择
        jb_calendar_timeui_main: "jb_calendar_timeui_main",
        jb_calendar_timeui_hmsobj: "jb_calendar_timeui_hmsobj",
        jb_calendar_timeui_timeobjclick_hmsobj: "jb_calendar_timeui_timeobjclick_hmsobj",
        jb_calendar_timeui_timeobjclick_obj: "jb_calendar_timeui_timeobjclick_obj",
        jb_calendar_timeui_timeobjclick_childNodes: "jb_calendar_timeui_timeobjclick_childNodes",
        jb_calendar_timeui_timeselect_item: "jb_calendar_timeui_timeselect_item",
        jb_calendar_timeui_timeselect_itemOver: "jb_calendar_timeui_timeselect_itemOver",
        jb_calendar_timeui_timeselect_itemOut: "jb_calendar_timeui_timeselect_itemOut",
        jb_calendar_timeui_bts_main: "jb_calendar_timeui_bts_main",
        jb_calendar_timeui_bts_up: "jb_calendar_timeui_bts_up",
        jb_calendar_timeui_bts_dowm: "jb_calendar_timeui_bts_dowm",
        jb_calendar_timeui_bts_submit: "jb_calendar_timeui_bts_submit",
        jb_calendar_timeui_bts_splitor: "jb_calendar_timeui_bts_splitor",
        jb_calendar_timeui_btsover_updownsumit: "jb_calendar_timeui_btsover_updownsumit",
        jb_calendar_timeui_btsover_submit: "jb_calendar_timeui_btsover_submit",
        jb_calendar_timeui_btsover_editUpDown: "jb_calendar_timeui_btsover_editUpDown",
        jb_calendar_timeui_btsover_up: "jb_calendar_timeui_btsover_up",
        jb_calendar_timeui_btsover_overobj: "jb_calendar_timeui_btsover_overobj"
    }
    var Config = {
        timeUi: {
            bts: {
                up: { css: [["fontSize", JB.IE ? "8px" : "10px"]] },
                dowm: { css: [["fontSize", JB.IE ? "8px" : "10px"]] },
                submit: { htm: "确定" },
                splitor: { htm: ":" }
            }
        },
        title: {
            bts: {
                left: { f: "left", css: [["marginLeft", (JB.IE && JB.V < 8) ? "1px" : "3px"]], attrs: ["title", "上一月"] },
                right: { f: "right", css: [["marginRight", (JB.IE && JB.V < 8) ? "1px" : "3px"]], attrs: ["title", "下一月"] }
            }
        }
    };
    var _obj = null;
    var _dialog = new JBodyDialog();
    var _calendars = new Array();
    var _main = null;
    var _calendarUi = new Array();
    _calendars.push(new JBodyCalendarBase());
    _calendars.push(new JBodyCalendarBase());
    var _format = { date: "yyyy-MM-dd", time: "HH:mm:ss", datetime: "yyyy-MM-dd HH:mm:ss" };
    var _options = null;
    var _initOptions = function () {
        _options = {
            type: 1,   //1单月,2双月,3单行
            inner: true,  //obj为非input对象时有意义，清空对象的原有元素
            year: new Date().getFullYear(),
            month: ((new Date().getMonth()) + 1),
            min: JB.parseDateTime("1920-01-01", _format.date),
            max: JB.parseDateTime("2099-12-31", _format.date),
            current: null,
            other: null,
            time: null,
            isStart: true,
            autoSetValue: true,
            closeAfterDateSelected: true,
            outerClickClose: true,
            selectTime: "none",  //none,h,m,s
            selectYearMonth: "none",  //none,y,m
            canSelectedOutsideMinMax: false,
            showDayInPreOrNextMonth: false,
            showSpecialDay: true,
            showBetweenStyle: false,
            showChineseDateInfo: true,
            selectTimeMustSubmit: true,  //选择时间时必须点击确定按钮
            showToDoc: true,    //绑定到document对象，可以减少一些IE的兼容性问题
            colors: ["", ""],
            bgColors: ["", ""],
            borderColors: ["", ""],
            textColors: ["", ""],
            btText: ["◄", "►", "▲", "▼"]
        };
    };
    _initOptions();
    var _clearFrontZero = function (s) { while (s.length > 1 && s.substr(0, 1) == "0") s = s.substr(1); return s; };

    var _onclick = function (dt) { }
    var _click = function (nd, i) {
        _options.current = nd.dt;
        var waitSelectTime = (_options.selectTime.toLowerCase() != "none" && _options.selectTimeMustSubmit);

        //if (_options.type == 2 || i == 0) _calendars[i].doclick(nd);
        if (_options.closeAfterDateSelected && !waitSelectTime) _this.close();
        else _calendars[i].doclick(nd);

        if (waitSelectTime) { _setTimeBtsStyle(); return; }

        if (_options.autoSetValue && _obj != null && _obj.tagName != null && _obj.tagName.toLowerCase() == "input") {
            _obj.value = JB.dateTimeToString(_options.current, _format.date);
            JB.fireEvent(_obj, "change");
        }
        if (JB.isFunction(_onclick)) JB.setTimeout(_onclick, 10, _options.current);
    };
    _calendars[0].clickcallback = function (nd) { _click(nd, 1); };
    _calendars[1].clickcallback = function (nd) { _click(nd, 0); };
    var _defaultBool = function (v, df) {
        return df ? !(v === !df) : (v === !df);
    };
    var _setOption = function (opt) {
        if (opt == null) opt = new Object();
        _options.type = (opt.type > 0 && opt.type < 3) ? opt.type : _options.type;
        _options.parent = opt.parent || null;
        if (typeof (_options.parent) == "string") _options.parent = document.getElementById(_options.parent);
        _options.dateFormat = opt.dateFormat || _options.dateFormat;
        _options.timeFormat = opt.timeFormat || _options.timeFormat;
        _options.min = opt.min || _options.min;
        _options.max = opt.max || _options.max;
        if (opt.current) _options.current = opt.current;
        if (opt.other) _options.other = opt.other;
        _options.time = opt.time || _options.time || _options.current;
        _options.isStart = !(opt.isStart === false);
        _options.autoSetValue = !(opt.autoSetValue === false);
        _options.closeAfterDateSelected = !(opt.closeAfterDateSelected === false);
        _options.outerClickClose = !(opt.outerClickClose === false);
        _options.selectTime = (opt.selectTime == "h" || opt.selectTime == "m" || opt.selectTime == "s") ? opt.selectTime : "none";  //none,h,m,s
        _options.selectYearMonth = (opt.selectYearMonth == "y" || opt.selectYearMonth == "m") ? opt.selectYearMonth : "none";  //none,y,m
        _options.canSelectedOutsideMinMax = (opt.canSelectedOutsideMinMax === true);
        _options.showDayInPreOrNextMonth = (opt.showDayInPreOrNextMonth === true);
        _options.showSpecialDay = !(opt.showSpecialDay === false);
        _options.showBetweenStyle = (opt.showBetweenStyle === true);
        _options.showChineseDateInfo = !(opt.showChineseDateInfo === false);
        _options.showToDoc = !(opt.showToDoc === false);
        if (typeof (_options.min) == "string") _options.min = JB.parseDateTime(_options.min, _format.datetime);
        if (typeof (_options.max) == "string") _options.max = JB.parseDateTime(_options.max, _format.datetime);
        if (typeof (_options.current) == "string") _options.current = JB.parseDateTime(_options.current, _format.datetime);
        if (typeof (_options.other) == "string") _options.other = JB.parseDateTime(_options.other, _format.datetime);
        if (typeof (_options.time) == "string") { _options.time = JB.parseDateTime(_options.time, opt.time != null ? _format.time : _format.datetime, opt.time != null); }
        if (_options.current != null) {
            _options.year = _options.current.getFullYear();
            _options.month = _options.current.getMonth() + 1;
        }
        _options.time = _options.time || new Date();
    };
    var _setBorderRadius = function (obj, v) {
        JB.borderRadius(obj, v, "TopLeft");
        JB.borderRadius(obj, v, "TopRight");
        JB.borderRadius(obj, v, "BottomLeft");
        JB.borderRadius(obj, v, "BottomRight");
        JB.borderRadius(obj, v);
    };
    var _titleObj = { left: { main: null, yobj: null, mobj: null }, right: { main: null, yobj: null, mobj: null }, bts: { left: null, right: null } };
    var _isMinMonth = function (y, m) {
        var ismin = _options.year < _options.min.getFullYear();
        return (ismin || (y == _options.min.getFullYear() && m <= (_options.min.getMonth() + 1)));
    }
    var _isMaxMonth = function (y, m) {
        var ismax = y > _options.max.getFullYear();
        ismax = ismax || (y == _options.max.getFullYear() && m >= (_options.max.getMonth() + 1));
        if (_options.type == 2) {
            m += 1;
            if (m > 12) { y = y + 1; m = 1; }
            ismax = ismax || y > _options.max.getFullYear();
            ismax = ismax || (y == _options.max.getFullYear() && m >= (_options.max.getMonth() + 1));
        }
        return ismax;
    }
    var _titleBtsClick = function (bt) {
        if ((bt == _titleObj.bts.right && _isMaxMonth(_options.year, _options.month)) || (bt == _titleObj.bts.left && _isMinMonth(_options.year, _options.month))) return;
        else {
            _options.month = _options.month + (bt == _titleObj.bts.right ? 1 : (-1));
            if (_options.month == 0) { _options.year = _options.year - 1; _options.month = 12; }
            if (_options.month == 13) { _options.year = _options.year + 1; _options.month = 1; }
            _getUi();
        }
    }
    var _yearMonthSelector = {
        dialog: new JBodyDialog(),
        mainYear: JB.newObj("DIV", { w: 38 }),
        mainMonth: JB.newObj("DIV", { w: 28 }),
        yStart: 0,
        yEnd: 0,
        isLeftObj: true,
        nextPg: JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_drg_bt }, { htm: _options.btText[3] }),
        prePg: JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_drg_bt }, { htm: _options.btText[2] })
    }
    var _yearSelectClick = function (e) {
        var src = JB.getEventSrc(e);
        if (src == _yearMonthSelector.nextPg) {
            _showYearSelector(_yearMonthSelector.yEnd + 1);
        } else if (src == _yearMonthSelector.prePg) {
            _showYearSelector(_yearMonthSelector.yStart - 10);
        } else {
            _options.year = parseInt(src.innerHTML);
            _getUi();
            JB.setTimeout(_yearMonthSelector.dialog.close, 100);
        }
    }
    var _mOverItemStyle = function (e) {
        var src = JB.getEventSrc(e);
        var isBt = (src == _yearMonthSelector.nextPg || src == _yearMonthSelector.prePg);
        JB.addClass(src, isBt ? cssClassNames.jb_calendar_drg_bt_msOver : cssClassNames.jb_calendar_drg_msOver);
    }
    var _mOutItemStyle = function (e) {
        var src = JB.getEventSrc(e);
        var isBt = (src == _yearMonthSelector.nextPg || src == _yearMonthSelector.prePg);
        JB.removeClass(src, isBt ? cssClassNames.jb_calendar_drg_bt_msOver : cssClassNames.jb_calendar_drg_msOver);
    }
    var _newYearItem = function (y) {
        if (y < _options.min.getFullYear() || y > _options.max.getFullYear()) return false;
        var it = JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_drg_year }, { htm: y + "" });
        _yearMonthSelector.mainYear.appendChild(it);
        JB.attach(it, "mouseover", _mOverItemStyle);
        JB.attach(it, "mouseout", _mOutItemStyle);
        JB.attach(it, "click", _yearSelectClick);
        return true;
    }
    var _showYearSelector = function (startYear) {
        for (var i = _yearMonthSelector.mainYear.childNodes.length - 1; i >= 0; i--) {
            JB.detach(_yearMonthSelector.mainYear.childNodes[i], "click", _yearSelectClick);
            JB.detach(_yearMonthSelector.mainYear.childNodes[i], "mouseover", _mOverItemStyle);
            JB.detach(_yearMonthSelector.mainYear.childNodes[i], "mouseout", _mOutItemStyle);
            _yearMonthSelector.mainYear.removeChild(_yearMonthSelector.mainYear.childNodes[i]);
        }
        _yearMonthSelector.mainYear.appendChild(_yearMonthSelector.prePg);

        if (startYear < _options.min.getFullYear()) startYear = _options.min.getFullYear();
        _yearMonthSelector.yStart = startYear;
        var k = 0;
        while (k < 10) {
            if (!_newYearItem(startYear)) {
                _yearMonthSelector.yEnd = startYear - 1;
                break;
            }
            startYear = startYear + 1;
            k++;
            if (k >= 10) _yearMonthSelector.yEnd = startYear - 1;
        }
        _yearMonthSelector.mainYear.appendChild(_yearMonthSelector.nextPg);
        _yearMonthSelector.dialog.show(_yearMonthSelector.isLeftObj ? _titleObj.left.yobj : _titleObj.right.yobj, _yearMonthSelector.mainYear, { showTitle: false, showCloseButton: false, outerClickClose: true, padding: 0, pos: { to: "obj", parent: "auto", park: "outside", parkOutside: "bottomLeft" } });
        JB.attach([_yearMonthSelector.prePg, _yearMonthSelector.nextPg], "mouseover", _mOverItemStyle);
        JB.attach([_yearMonthSelector.prePg, _yearMonthSelector.nextPg], "mouseout", _mOutItemStyle);
        if (!_isMinMonth(_yearMonthSelector.yStart, 1)) JB.attach(_yearMonthSelector.prePg, "click", _yearSelectClick);
        if (!_isMaxMonth(_yearMonthSelector.yEnd, 12)) JB.attach(_yearMonthSelector.nextPg, "click", _yearSelectClick);
    }
    var _selectYear = function (e) {
        _yearMonthSelector.isLeftObj = !(JB.getEventSrc(e) == _titleObj.right.yobj);
        _showYearSelector(_options.year);
    }
    var _monthSelectClick = function (e) {
        var src = JB.getEventSrc(e);
        _options.month = parseInt(src.innerHTML);
        _getUi();
        JB.setTimeout(_yearMonthSelector.dialog.close, 100);
    }
    var _selectMonth = function (e) {
        _yearMonthSelector.isLeftObj = !(JB.getEventSrc(e) == _titleObj.right.mobj);
        for (var i = _yearMonthSelector.mainMonth.childNodes.length - 1; i >= 0; i--) {
            JB.detach(_yearMonthSelector.mainMonth.childNodes[i], "click", _monthSelectClick);
            JB.detach(_yearMonthSelector.mainMonth.childNodes[i], "mouseover", _mOverItemStyle);
            JB.detach(_yearMonthSelector.mainMonth.childNodes[i], "mouseout", _mOutItemStyle);
            _yearMonthSelector.mainMonth.removeChild(_yearMonthSelector.mainMonth.childNodes[i]);
        }
        for (var i = 1; i <= 12; i++) {
            if (_isMinMonth(_options.year, i) && !(_options.year == _options.min.getFullYear() && i == (_options.min.getMonth() + 1))) continue;

            var it = JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_drg_month }, { htm: i + "" });
            _yearMonthSelector.mainMonth.appendChild(it);
            JB.attach(it, "mouseover", _mOverItemStyle);
            JB.attach(it, "mouseout", _mOutItemStyle);
            JB.attach(it, "click", _monthSelectClick);
            if (_isMaxMonth(_options.year, i)) break;
        }
        _yearMonthSelector.dialog.show(_yearMonthSelector.isLeftObj ? _titleObj.left.mobj : _titleObj.right.mobj, _yearMonthSelector.mainMonth, { showTitle: false, showCloseButton: false, outerClickClose: true, padding: 0, pos: { to: "obj", parent: "auto", park: "outside", parkOutside: "bottomLeft" } });
    }

    var _getMainWidth = function () {
        return ((_options.type == 2) ? ((JB.IE && JB.V < 8) ? 395 : 390) : ((JB.IE && JB.V < 9) ? 226 : 220));  //+4*7=28
    };
    var _setTitle = function () {
        var w = _getMainWidth() - ((JB.IE && JB.V < 8) ? 16 : 12);
        if (_titleObj.main == null) {
            _titleObj.main = JB.newObj("DIV", { w: w, cssClass: cssClassNames.jb_calendar_title_main });
            _setBorderRadius(_titleObj.main, 3);
            _titleObj.left.main = JB.newObj("DIV", { w: Math.floor(w / 2) - (_options.type == 1 ? -10 : 95), cssClass: cssClassNames.jb_calendar_title_leftmain });
            _titleObj.right.main = JB.newObj("DIV", { w: Math.floor(w / 2) - 95, h: 24, f: "right", css: ["marginRight", "20px"] });
            _titleObj.bts.left = JB.newObj("DIV", { htm: _options.btText[0], cssClass: cssClassNames.jb_calendar_title_bts }, Config.title.bts.left);
            _titleObj.bts.right = JB.newObj("DIV", { htm: _options.btText[1], cssClass: cssClassNames.jb_calendar_title_bts }, Config.title.bts.right);
            _setBorderRadius(_titleObj.bts.left, 3);
            _setBorderRadius(_titleObj.bts.right, 3);
            JB.attach(_titleObj.bts.left, "mouseover", function () { JB.addClass(_titleObj.bts.left, cssClassNames.jb_calendar_title_bts_over) });
            JB.attach(_titleObj.bts.left, "mouseout", function () { JB.removeClass(_titleObj.bts.left, cssClassNames.jb_calendar_title_bts_over) });
            JB.attach(_titleObj.bts.right, "mouseover", function () { JB.addClass(_titleObj.bts.right, cssClassNames.jb_calendar_title_bts_over) });
            JB.attach(_titleObj.bts.right, "mouseout", function () { JB.removeClass(_titleObj.bts.right, cssClassNames.jb_calendar_title_bts_over) });
            JB.attach(_titleObj.bts.left, "click", function () { _titleBtsClick(_titleObj.bts.left); });
            JB.attach(_titleObj.bts.right, "click", function () { _titleBtsClick(_titleObj.bts.right); });
            _titleObj.left.yobj = JB.newObj("DIV", { w: 55, f: "left", css: ["marginLeft", "5px"], cssClass: cssClassNames.jb_calendar_title_ymobj });
            _titleObj.left.mobj = JB.newObj("DIV", { w: 40, f: "left", cssClass: cssClassNames.jb_calendar_title_ymobj });
            _titleObj.left.main.appendChild(_titleObj.left.yobj);
            _titleObj.left.main.appendChild(_titleObj.left.mobj);
            _titleObj.right.yobj = JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_title_ymobj, f: "right" });
            _titleObj.right.mobj = JB.newObj("DIV", { css: ["marginRight", "5px"], cssClass: cssClassNames.jb_calendar_title_ymobj, f: "right" });
            _titleObj.right.main.appendChild(_titleObj.right.mobj);
            _titleObj.right.main.appendChild(_titleObj.right.yobj);
            JB.attach([_titleObj.left.yobj, _titleObj.right.yobj], "click", _selectYear);
            JB.attach([_titleObj.left.mobj, _titleObj.right.mobj], "click", _selectMonth);
        }
        JB.setOpt(_titleObj.main, { w: w });
        while (_titleObj.main.childNodes.length > 0) _titleObj.main.removeChild(_titleObj.main.childNodes.item(0));
        _titleObj.main.appendChild(_titleObj.bts.left);
        _titleObj.main.appendChild(_titleObj.bts.right);
        _titleObj.main.appendChild(_titleObj.left.main);
        if (_options.type == 2) _titleObj.main.appendChild(_titleObj.right.main);

        var y = _options.year;
        var m = _options.month;
        if (y > _options.max.getFullYear()) y = _options.max.getFullYear();
        if (y < _options.min.getFullYear()) y = _options.min.getFullYear();
        m = m - 1;
        if (m < 0) m = 0;
        if (m > 11) m = 11;
        if (y == _options.max.getFullYear() && m > _options.max.getMonth()) m = _options.max.getMonth();
        if (y == _options.min.getFullYear() && m < _options.min.getMonth()) m = _options.min.getMonth();
        m = m + 1;

        JB.setOpt(_titleObj.left.yobj, { htm: y + "年" });
        JB.setOpt(_titleObj.left.mobj, { htm: m + "月" });

        m = m + 1;
        if (m == 0) { y = y - 1; m = 12; }
        if (m == 13) { y = y + 1; m = 1; }
        JB.setOpt(_titleObj.right.yobj, { htm: y + "年" });
        JB.setOpt(_titleObj.right.mobj, { htm: m + "月" });
    };
    var _timeUiObj = {
        main: null, editnow: null, hObj: null, mObj: null, sObj: null,
        bts: { main: null, up: null, down: null, submit: null },
        selt: { y: null, m: null, s: null },
        dialog: new JBodyDialog()
    };
    var _submitTime = function () {
        if (_options.current == null || _options.selectTime.toLowerCase() == "none") return;
        _options.current.setHours(parseInt(_clearFrontZero(_timeUiObj.hObj.innerHTML)));
        _options.current.setMinutes(parseInt(_clearFrontZero(_timeUiObj.mObj.innerHTML)));
        _options.current.setSeconds(parseInt(_clearFrontZero(_timeUiObj.sObj.innerHTML)));
        if (_options.autoSetValue && _obj != null && _obj.tagName != null && _obj.tagName.toLowerCase() == "input") {
            _obj.value = JB.dateTimeToString(_options.current, _format.datetime);
        }
        _this.close();
        if (JB.isFunction(_onclick)) JB.setTimeout(_onclick, 200, _options.current);
    };
    var _setTimeObjValue = function (obj, v) {
        v = "0" + v;
        if (v.length > 2) v = v.substr(1);
        JB.setOpt(obj, { htm: v });
    }
    var _desdroyTimeUI = function () {
        JB.detach(_timeUiObj.hObj, "click", _timeObjClick_h);
        JB.detach(_timeUiObj.mObj, "click", _timeObjClick_m);
        JB.detach(_timeUiObj.sObj, "click", _timeObjClick_s);
        JB.detach(_timeUiObj.bts.up, "click", _timeObjClick_u);
        JB.detach(_timeUiObj.bts.down, "click", _timeObjClick_d);

        JB.detach(_timeUiObj.bts.up, "mouseover", _setTimeBtsStyle_up);
        JB.detach(_timeUiObj.bts.down, "mouseover", _setTimeBtsStyle_down);
        JB.detach(_timeUiObj.bts.submit, "mouseover", _setTimeBtsStyle_submit);
        JB.each([_timeUiObj.bts.submit, _timeUiObj.bts.up, _timeUiObj.bts.down],
                    function (obj) { JB.detach(obj, "mouseout", _setTimeBtsStyle) }, false);
        JB.detach(_timeUiObj.bts.submit, "click", _setTimeBtsStyle_mouseout);
    }
    var _timeObjClick = function (obj) {
        if (obj == _timeUiObj.hObj || obj == _timeUiObj.mObj || obj == _timeUiObj.sObj) {
            _timeUiObj.editnow = null;
            _setTimeBtsStyle();
            JB.addClass([_timeUiObj.hObj, _timeUiObj.mObj, _timeUiObj.sObj], cssClassNames.jb_calendar_timeui_hmsobj);
            var showT = _options.selectTime.toLowerCase();
            if (showT == "h" && obj == _timeUiObj.mObj) return;
            if (showT != "s" && obj == _timeUiObj.sObj) return;
            JB.removeClass(_timeUiObj.hObj, cssClassNames.jb_calendar_timeui_timeobjclick_obj);
            JB.removeClass(_timeUiObj.mObj, cssClassNames.jb_calendar_timeui_timeobjclick_obj);
            JB.removeClass(_timeUiObj.sObj, cssClassNames.jb_calendar_timeui_timeobjclick_obj);
            JB.addClass(obj, cssClassNames.jb_calendar_timeui_timeobjclick_obj);
            _timeUiObj.editnow = obj;
            _setTimeBtsStyle();
            var msg = (obj == _timeUiObj.hObj ? _timeUiObj.selt.h : obj == _timeUiObj.mObj ? _timeUiObj.selt.m : _timeUiObj.selt.s);
            JB.setOpt(msg.childNodes, { cssClass: cssClassNames.jb_calendar_timeui_timeobjclick_childNodes });
            var dlgopt = new Object();
            dlgopt.w = parseInt(msg.style.width) + (JB.IE ? 4 : 0);
            dlgopt.h = parseInt(msg.style.height) + (JB.IE ? 4 : 0);
            dlgopt.padding = 0;
            dlgopt.alphaBorder = JB.IE ? 2 : 0;
            dlgopt.pos = [{ park: "outside", parkOutside: "bottomLeft", parkSmart: true }, { park: "outside", parkOutside: "topLeft", parkSmart: true }];
            dlgopt.outerClickClose = true;
            dlgopt.autoClose = 3000;
            dlgopt.showTitle = false;
            dlgopt.showCloseButton = false;
            _timeUiObj.dialog.show(obj, msg, dlgopt);
        } else if (obj == _timeUiObj.bts.up || obj == _timeUiObj.bts.down) {
            if (_timeUiObj.editnow == null) return;
            var vv = parseInt(_clearFrontZero(_timeUiObj.editnow.innerHTML)) + ((obj == _timeUiObj.bts.up) ? 1 : (_timeUiObj.editnow == _timeUiObj.hObj) ? 23 : 59);
            vv = (vv % ((_timeUiObj.editnow == _timeUiObj.hObj) ? 24 : 60));
            _setTimeObjValue(_timeUiObj.editnow, vv);
        }
    }
    var _timeObjClick_h = function () { _timeObjClick(_timeUiObj.hObj); }
    var _timeObjClick_m = function () { _timeObjClick(_timeUiObj.mObj); }
    var _timeObjClick_s = function () { _timeObjClick(_timeUiObj.sObj); }
    var _timeObjClick_u = function () { _timeObjClick(_timeUiObj.bts.up); }
    var _timeObjClick_d = function () { _timeObjClick(_timeUiObj.bts.down); }

    var _selectTimeItem = function (v) {
        if (_timeUiObj.editnow != null) _setTimeObjValue(_timeUiObj.editnow, v);
        _timeUiObj.dialog.setAutoClose(100);
    }
    var _newTimeSeltItem = function (obj, v) {
        var itm = JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_timeui_timeselect_item });
        _setTimeObjValue(itm, v);
        JB.attach(itm, "mouseover",
        function () {
            JB.addClass(itm, cssClassNames.jb_calendar_timeui_timeselect_itemOver);
            _timeUiObj.dialog.clearAutoClose();
        }
        );
        JB.attach(itm, "mouseout", function () { JB.removeClass(itm, cssClassNames.jb_calendar_timeui_timeselect_itemOver); _timeUiObj.dialog.setAutoClose(1000); });
        JB.attach(itm, "click", function () { _selectTimeItem(v); });
        obj.appendChild(itm);
    }
    var _setTimeBtsStyle = function (e, overObj) {
        JB.addClass(_timeUiObj.bts.up, cssClassNames.jb_calendar_timeui_btsover_updownsumit);
        JB.addClass(_timeUiObj.bts.down, cssClassNames.jb_calendar_timeui_btsover_updownsumit);
        JB.addClass(_timeUiObj.bts.submit, cssClassNames.jb_calendar_timeui_btsover_updownsumit);
        if (_options.current != null) JB.addClass(_timeUiObj.bts.submit, cssClassNames.jb_calendar_timeui_btsover_submit);
        else JB.removeClass(_timeUiObj.bts.submit, cssClassNames.jb_calendar_timeui_btsover_submit);
        if (_timeUiObj.editnow != null) JB.setOpt([_timeUiObj.bts.up, _timeUiObj.bts.down], { cssClass: cssClassNames.jb_calendar_timeui_btsover_editUpDown });
        JB.addClass(_timeUiObj.bts.up, cssClassNames.jb_calendar_timeui_btsover_up);
        if (_options.current == null && overObj == _timeUiObj.bts.submit) return;
        if ((overObj == _timeUiObj.bts.up || overObj == _timeUiObj.bts.down) && _timeUiObj.editnow == null) return;
        if (overObj != null) JB.addClass(overObj, cssClassNames.jb_calendar_timeui_btsover_overobj);
        JB.addClass(_timeUiObj.bts.up, cssClassNames.jb_calendar_timeui_btsover_up);
    }
    var _setTimeBtsStyle_mouseout = function (e) { _setTimeBtsStyle(e, null); }
    var _setTimeBtsStyle_up = function (e) { _setTimeBtsStyle(e, _timeUiObj.bts.up); }
    var _setTimeBtsStyle_down = function (e) { _setTimeBtsStyle(e, _timeUiObj.bts.down); }
    var _setTimeBtsStyle_submit = function (e) { _setTimeBtsStyle(e, _timeUiObj.bts.submit); }
    var _setTimeUi = function () {
        if (_timeUiObj.main == null) {
            _timeUiObj.main = JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_timeui_main });
            _timeUiObj.hObj = JB.newObj("DIV");
            _timeUiObj.mObj = JB.newObj("DIV");
            _timeUiObj.sObj = JB.newObj("DIV");
            //JB.setOpt([_timeUiObj.hObj, _timeUiObj.mObj, _timeUiObj.sObj], { w: 16, h: 19, f: "left", textAlign: "center" })
            _timeUiObj.bts.main = JB.newObj("DIV", { cssClass: cssClassNames.jb_calendar_timeui_bts_main });
            _timeUiObj.bts.up = JB.newObj("DIV", Config.timeUi.bts.up, { htm: _options.btText[2] }, { cssClass: cssClassNames.jb_calendar_timeui_bts_up });
            _timeUiObj.bts.down = JB.newObj("DIV", Config.timeUi.bts.dowm, { htm: _options.btText[3] }, { cssClass: cssClassNames.jb_calendar_timeui_bts_dowm });
            _timeUiObj.bts.main.appendChild(_timeUiObj.bts.up);
            _timeUiObj.bts.main.appendChild(_timeUiObj.bts.down);
            _timeUiObj.main.appendChild(_timeUiObj.hObj);
            _timeUiObj.bts.submit = JB.newObj("DIV", Config.timeUi.bts.submit, { cssClass: cssClassNames.jb_calendar_timeui_bts_submit });
            _setTimeBtsStyle();
            _timeUiObj.main.appendChild(JB.newObj("DIV", Config.timeUi.bts.splitor, { cssClass: cssClassNames.jb_calendar_timeui_bts_splitor }));
            _timeUiObj.main.appendChild(_timeUiObj.mObj);
            _timeUiObj.main.appendChild(JB.newObj("DIV", Config.timeUi.bts.splitor, { cssClass: cssClassNames.jb_calendar_timeui_bts_splitor }));
            _timeUiObj.main.appendChild(_timeUiObj.sObj);
            _timeUiObj.main.appendChild(JB.newObj("DIV", Config.timeUi.bts.splitor, { cssClass: cssClassNames.jb_calendar_timeui_bts_splitor }));
            _timeUiObj.main.appendChild(_timeUiObj.bts.main);
            _timeUiObj.main.appendChild(_timeUiObj.bts.submit);
            _timeUiObj.selt.h = JB.newObj("DIV", { w: 100, h: 125 });
            _timeUiObj.selt.m = JB.newObj("DIV", { w: 50, h: 125 });
            _timeUiObj.selt.s = JB.newObj("DIV", { w: 50, h: 125 });
            for (var i = 0; i < 24; i += 1) _newTimeSeltItem(_timeUiObj.selt.h, i);
            for (var i = 0; i < 60; i += 5) _newTimeSeltItem(_timeUiObj.selt.m, i);
            for (var i = 0; i < 60; i += 5) _newTimeSeltItem(_timeUiObj.selt.s, i);
            _setBorderRadius(_timeUiObj.bts.submit, 3);
            JB.borderRadius(_timeUiObj.bts.up, 3, "TopLeft");
            JB.borderRadius(_timeUiObj.bts.up, 3, "TopRight");
            JB.borderRadius(_timeUiObj.bts.down, 3, "BottomLeft");
            JB.borderRadius(_timeUiObj.bts.down, 3, "BottomRight");

            JB.attach(_timeUiObj.hObj, "click", _timeObjClick_h);
            JB.attach(_timeUiObj.mObj, "click", _timeObjClick_m);
            JB.attach(_timeUiObj.sObj, "click", _timeObjClick_s);
            JB.attach(_timeUiObj.bts.up, "click", _timeObjClick_u);
            JB.attach(_timeUiObj.bts.down, "click", _timeObjClick_d);

            JB.attach(_timeUiObj.bts.up, "mouseover", _setTimeBtsStyle_up);
            JB.attach(_timeUiObj.bts.down, "mouseover", _setTimeBtsStyle_down);
            JB.attach(_timeUiObj.bts.submit, "mouseover", _setTimeBtsStyle_submit);
            JB.each([_timeUiObj.bts.submit, _timeUiObj.bts.up, _timeUiObj.bts.down],
                    function (obj) { JB.attach(obj, "mouseout", _setTimeBtsStyle_mouseout) }, false);
            JB.attach(_timeUiObj.bts.submit, "click", _submitTime);
        }
        _timeUiObj.editnow = null;
        JB.setOpt([_timeUiObj.hObj, _timeUiObj.mObj, _timeUiObj.sObj], { cssClass: cssClassNames.jb_calendar_timeui_hmsobj })
    };
    var _getUi = function () {
        var w = _getMainWidth();
        while (_calendarUi.length > 0) _calendarUi.pop();
        _calendarUi.push(_calendars[0].getUi(_options.year, _options.month, _options));
        _setTitle();
        _setTimeUi();
        while (_main.childNodes.length > 0) _main.removeChild(_main.childNodes.item(0));
        _main.appendChild(_titleObj.main);
        _main.appendChild(_calendarUi[0]);
        if (_options.type == 2) {
            _calendarUi.push(JB.newObj("DIV", { w: 5, h: 180, f: "left", css: [["borderLeft", "solid 2px #cccccc"], ["marginLeft", "3px"]] }));
            _calendarUi.push(_calendars[1].getUi(_options.month == 12 ? (_options.year + 1) : _options.year, _options.month == 12 ? 1 : (_options.month + 1), _options));
            _main.appendChild(_calendarUi[1]);
            _main.appendChild(_calendarUi[2]);
            _calendars[0].onmouseover = _calendars[1].mouseover;
            _calendars[0].onmouseout = _calendars[1].mouseout;
            _calendars[1].onmouseover = _calendars[0].mouseover;
            _calendars[1].onmouseout = _calendars[0].mouseout;
        } else {
            _calendars[0].onmouseover = function () { return; };
            _calendars[0].onmouseout = function () { return; };
            _calendars[1].onmouseover = function () { return; };
            _calendars[1].onmouseout = function () { return; };
        }
        var showT = _options.selectTime.toLowerCase();
        JB.setOpt(_main, { h: showT != "none" ? 220 : 190 });

        if (showT != "none") {
            _setTimeObjValue(_timeUiObj.hObj, _options.time.getHours());
            _setTimeObjValue(_timeUiObj.mObj, showT != "h" ? _options.time.getMinutes() : "00");
            _setTimeObjValue(_timeUiObj.sObj, showT == "s" ? _options.time.getSeconds() : "00");
            JB.setOpt(_timeUiObj.mObj, { color: showT == "h" ? "#cdcdcd" : "#333333" });
            JB.setOpt(_timeUiObj.sObj, { color: showT != "s" ? "#cdcdcd" : "#333333" });
            JB.setOpt(_timeUiObj.main, { css: ["marginLeft", _options.type == 2 ? ((JB.IE && JB.V < 8) ? "50px" : "100px") : ((JB.IE && JB.V < 8) ? "8px" : "15px")] });
            _setTimeBtsStyle();
            _main.appendChild(_timeUiObj.main);
        }
    };
    this.dialogopt = {
        w: 0, h: 0, padding: 3, hideOverfloat: false,
        pos: [{ parent: "auto", to: "obj", park: "outside", parkOutside: "bottomLeft", parkSmart: true },
        { parent: "auto", to: "obj", park: "outside", parkOutside: "topLeft", parkSmart: true },
        { parent: "auto", to: "obj", park: "outside", parkOutside: "rightTop", parkSmart: true },
        { parent: "auto", to: "obj", park: "outside", parkOutside: "rightBottom", parkSmart: true },
        { parent: "auto", to: "obj", park: "outside", parkOutside: "leftTop", parkSmart: true },
        { parent: "auto", to: "obj", park: "outside", parkOutside: "leftBottom", parkSmart: true }
        ],
        outerClickClose: true,
        showTitle: false,
        showCloseButton: false
    }
    var _DEBUG = false;
    var _DEBUG_MSG = ""; this.ADD_DEBUG_MSG = function (msg) {
        if (_DEBUG) _DEBUG_MSG += "\r\n" + JB.dateTimeToString(new Date(), "ss.fff") + "  " + msg;
    }
    this.SHOW_DEBUG_MSG = function (msg) {
        if (_DEBUG) alert(_DEBUG_MSG);
    }
    this.show = function (obj, opt, onclickfun, debug) {
        _obj = obj;
        _this = this;
        _initOptions();
        if (typeof (_obj) == "string") _obj = document.getElementById(_obj);
        if (_obj != null && _obj.tagName != null && _obj.tagName.toLowerCase() == "input" &&
             _obj.value != null && JB.trim(_obj.value) != "") {
            _options.current = _obj.value;
        }
        _setOption(opt);

        var w = _getMainWidth();
        _main = JB.newObj("DIV", { w: w - 12, h: 190, f: "left", textAlign: "left", css: [["fontFamily", "Arial,Simsun"], ["padding", "0px"], ["margin", "0px"]] });

        _DEBUG = (debug == true);
        _DEBUG_MSG = "";
        //_this.ADD_DEBUG_MSG("开始创建UI");
        _getUi();
        //_this.ADD_DEBUG_MSG("完成创建UI");      
        _this.dialogopt.w = w;
        _this.dialogopt.h = (_options.selectTime.toLowerCase() != "none" ? 255 : 227);
        if (opt) _this.dialogopt.pos = opt.pos || _this.dialogopt.pos;  //设置POS
        for (i = 0; i < _this.dialogopt.pos.length; i++) _this.dialogopt.pos[i].parent = (_options.showToDoc ? "doc" : "auto");
        _this.dialogopt.outerClickClose = _options.outerClickClose;
        if (_obj != null && _obj.tagName != null && _obj.tagName.toLowerCase() != "input") {
            _obj.innerHTML = "";
            _obj.appendChild(_main);
        }
        else _dialog.show(_obj, _main, _this.dialogopt, true);
        _onclick = null;
        if (JB.isFunction(onclickfun)) _onclick = onclickfun;
        else if (typeof (onclickfun) == "string") {
            if (onclickfun.indexOf("(") >= 0) _onclick = function () { eval(onclickfun); }
            else _onclick = function (dt) { eval(onclickfun + "(dt)"); }
        }
        _this.SHOW_DEBUG_MSG();
    };
    this.val = function () { return _options.current; }
    this.desdroy = function () {
    }
    this.close = function () { _dialog.close(); }
    this.attachOuterClickClose = function () { _dialog.attachOuterClickClose(); }
}
var JBCalendar = new JBodyCalendar();

function JBodyInputInnerTips() {
    var _this = this;
    var _attrName = "data-jbtips";
    var _objs = new Array();
    var _tips = new Array();
    var _colors = new Array();
    var _getIndex = function (obj) {
        for (var i = 0; i < _objs.length; i++) if (_objs[i] == obj) return i;
        return -1;
    }
    var _contain = function (obj) {
        return _getIndex(obj) >= 0;
    }
    var _eqInnerTip = function (i) {
        if (i < 0) return false;
        return (_objs[i].value == _tips[i] || JB.trim(_objs[i].value) == _tips[i].replace(/\r\n/g, "\n"))
    }
    var _hideTip2 = function (i) {
        if (i < 0) return;
        if (_eqInnerTip(i)) {
            _objs[i].value = "";
            _objs[i].style.color = _colors[i];
        }
    }
    var _hideTip = function (e) {
        _hideTip2(_getIndex(JB.getEventSrc(e)));
    }
    var _showTip2 = function (i) {
        if (JB.support.html5) return;
        if (i < 0) return;
        if (JB.trim(_objs[i].value) == "" || _eqInnerTip(i)) {
            _objs[i].value = _tips[i];
            _objs[i].style.color = "#999999";
        } else {
            _objs[i].style.color = _colors[i];
        }
    }
    var _showTip = function (e) {
        _showTip2(_getIndex(JB.getEventSrc(e)));
    }
    this.update = function (obj) {
        if (obj) _showTip2(_getIndex(obj));
        else _this.showAll();
    }
    this.showAll = function () {
        for (var i = 0; i < _objs.length; i++) _showTip2(i);
    }
    var _timeoutShowObj = null;
    this.hideAll = function (timeoutShow) {
        if (JB.support.html5) return;
        for (var i = 0; i < _objs.length; i++) _hideTip2(i);
        if (timeoutShow > 0) {
            if (_timeoutShowObj != null) clearTimeout(_timeoutShowObj);
            _timeoutShowObj = setTimeout(_this.showAll, timeoutShow);
        }
    }
    this.val = function (obj, v) {
        if (v != null) {
            obj.value = v;
            if (!JB.support.html5) _showTip2(_getIndex(obj));
        } else {
            if (!JB.support.html5 && _eqInnerTip(_getIndex(obj))) return "";
            return obj.value;
        }
    }
    this.value = this.val;
    this.getValue = this.val;
    this.create = function (option) {
        var atName = _attrName;
        var objs = null;
        var defaultEnable = true;
        if (option != null) {
            if (option.attrName) atName = option.attrName;
            defaultEnable = JB.defaultBool(option.defaultEnable, true);
            objs = option.objs || null;
            if (typeof (objs) === "string") objs = document.getElementById(objs);
            if (objs == null && option.objs == null && option.tagName
                && (option.tagName.toLowerCase() == "input" || option.tagName.toLowerCase() == "textarea")
                && option.parentNode) {
                objs = option;
            }
        } else {
            objs = document.getElementsByTagName("INPUT");
        }
        if (objs == null) { return; }
        if (!(objs.length || objs.push)) objs = [objs];
        for (var i = 0; i < objs.length; i++) {
            if (objs[i].tagName.toLowerCase() != "textarea" && objs[i].type != "text" && objs[i].type != "password") continue;
            var tip = JB.attribute(objs[i], atName);
            tip = tip.replace(/\\r\\n/g, "\r\n");
            tip = tip.replace(/\\n\\r/g, "\r\n");
            tip = tip.replace(/\\r/g, "\r\n");
            tip = tip.replace(/\\n/g, "\r\n");
            if (_contain(objs[i])) continue;
            if (tip == null || tip == "") { continue; }
            var color = objs[i].style.color;
            _objs.push(objs[i]);
            _tips.push(tip);
            _colors.push(color);
            if (objs[i].type == "password") continue;
            JB.attr(objs[i], "placeholder", tip);
            if (JB.support.html5) continue;
            JB.attach(objs[i], "focus", _hideTip);
            JB.attach(objs[i], "blur", _showTip);
            JB.attach(objs[i], "change", _showTip);
            _showTip2(_objs.length - 1);
        }
    }
}
var JBInputInnerTips = new JBodyInputInnerTips();

function JBodyInputSuggestion(option) {
    var _this = this;
    if (option == null) return;

    var JB = JBody;
    var _dialog = new JBodyDialog();
    var _tObj = option.textObj || null;
    var _vObj = option.valueObj || null;
    if (typeof (_tObj) == "string") _tObj = document.getElementById(_tObj);
    if (typeof (_vObj) == "string") _vObj = document.getElementById(_vObj);

    var _actionType = (option.actionType == "function" ? "function" : option.actionType == "txt" ? "txt" : "ajax");
    var _action = option.action || null;
    if (_tObj == null || _action == null) return;
    var _debug = JB.defaultBool(option.debug, false);
    var _DEBUG_CALLBACK = JB.undef(option.debugCallback, function () { return; });
    var _itemH = JB.undef(option.itemH, _tObj.offsetHeight);
    var _titleH = JB.undef(option.titleH, _itemH);
    var _titleFmt = option.title || "";
    var _title = "";
    var _showTitle = JB.undef(option.showTitle, false);
    var _titleFormat = JB.defaultBool(option.titleFormat, true);
    this.setTitle = function (txt, format, show) {
        _titleFmt = JB.undef(txt, _titleFmt);
        _titleFormat = JB.undef(format, _titleFormat);
        _showTitle = JB.undef(show, _showTitle);
    }
    var _beforeAjax = function (action, v) { return action + escape(v) + "&t=" + new Date(); };
    if (JB.isFunction(option.beforeAjax)) _beforeAjax = option.beforeAjax;

    var _afterAjax = function (txt) { return txt; };
    if (JB.isFunction(option.afterAjax)) _afterAjax = option.afterAjax;

    var _beforeAction = function (v) { return true; };
    if (JB.isFunction(option.beforeAction)) _beforeAction = option.beforeAction;

    var _beforeShow = function (v) { return v; };
    if (JB.isFunction(option.before)) _beforeShow = option.before;
    if (JB.isFunction(option.beforeShow)) _beforeShow = option.beforeShow;
    var _afterShow = function () { return; };
    if (JB.isFunction(option.afterShow)) _afterShow = option.afterShow;
    var _afterClose = function () { return; };
    if (JB.isFunction(option.afterClose)) _afterClose = option.afterClose;
    var _afterSelected = function (t, v) { return; };
    if (JB.isFunction(option.afterSelected)) _afterSelected = option.afterSelected;
    var _css = { item: "", mover: "", iv: "" };
    if (option.css && option.css.item) _css.item = option.css.item;
    if (option.css && option.css.mover) _css.mover = option.css.mover;
    if (option.css && option.css.iv) _css.iv = option.css.iv;
    var _mouseSelectSubmit = JB.defaultBool(option.mouseSelectSubmit, false);  //鼠标选中是否提交表单（主动提交）
    var _enterSelectSubmit = JB.defaultBool(option.enterSelectSubmit, false);;  //回车选中是否提交表单

    var _keyValues = new Array();
    var _lastKey = "";
    var _maxWidth = 0;
    var _overItem = null;
    var _lineHeight = JB.undef(option.lineHeight, "18px");

    var _formObj = null;
    var _getForm = function () {
        if (_formObj != null) return _formObj;
        var p = _tObj;
        while (p) { p = p.parentNode; if (p && p.tagName && p.tagName.toLowerCase() == "form") break; }
        if (p) _formObj = p;
        else _formObj = 0;
        return _formObj;
    }

    var _getClientSize = function (obj, w) {
        if (obj == null) obj = "";
        if (typeof (obj) == "string") {
            obj = JB.newObj("P", { innerHTML: obj });
            if (_css.item != "") JB.setOpt(obj, { className: _css.item });
            else JB.setOpt(obj, { css: [["paddingLeft", "3px"], ["paddingRight", "3px"]] });
        }
        var tb = JB.newObj("TABLE", { css: ["position", "absolute"] });
        var td = JB.insertCell(JB.insertRow(tb), { css: ["padding", "3px"] });
        if (w > 0) JB.setOpt([tb, td], { w: w });
        if (obj.length) for (var i = 0; i < obj.length; i++) td.appendChild(obj[i].cloneNode(true));
        else td.appendChild(obj.cloneNode(true));
        JB.opacity(tb, 10);
        JB.docElement().appendChild(tb);
        var tdw = Math.max(Math.max(1, td.clientWidth || 1), td.offsetWidth);
        var tdh = Math.max(Math.max(1, td.clientHeight || 1), td.offsetHeight);
        JB.docElement().removeChild(tb);
        return { w: tdw, h: tdh };
    }
    var _mouseOver2 = function (obj) {
        if (_overItem) {
            if (_css.item != "") JB.setOpt(_overItem, { className: _css.item });
            else JB.setOpt(_overItem, { bgColor: "#ffffff", css: ["fontWeight", "normal"] });
        }
        _overItem = obj;
        _DEBUG_CALLBACK("当前选中:" + _overItem.innerHTML);
        if (_overItem == null) return;
        if (_css.mover != "") JB.setOpt(_overItem, { className: _css.mover });
        else JB.setOpt(_overItem, { bgColor: "#DFEFFF", css: ["fontWeight", "normal"] });
    }
    var _mouseOver = function (e) {
        _mouseOver2(JB.getEventSrc(e));
    }
    var _itemClick2 = function (obj, mclick) {
        _tObj.value = JB.innerText(obj);
        if (_vObj) _vObj.value = obj.v;
        _afterSelected(_tObj.value + "", obj.v + "");
        _dialog.close();
        _DEBUG_CALLBACK("_overItem = null");
        _overItem = null;
        if (mclick && _mouseSelectSubmit && _getForm() != 0) _getForm().submit();
    }
    var _itemClick = function (e) {
        _itemClick2(JB.getEventSrc(e), true);
    }
    var _newItem = function (t, v) {
        var it = JB.newObj("P", { htm: t });
        if (_css.item != "") JB.setOpt(it, { className: _css.item });
        else JB.setOpt(it, { textAlign: "left", css: [["paddingLeft", "3px"], ["paddingRight", "3px"], ["lineHeight", _lineHeight]] });
        it.v = v;
        _maxWidth = Math.max(_maxWidth, _getClientSize(it).w);
        JB.attach(it, "mouseover", _mouseOver);
        JB.attach(it, "click", _itemClick);
        return it;
    }
    this.show = function (v) {  //v为数组对象或字符串，如 [{t:‘一’,v:'1'},{t:‘二’,v:'2'},{t:‘三’,v:'3'}]” 或 “[{t:'一'},{t:'二'}]
        try {
            if (!JB.isArray(v)) v = eval("(" + v + ")");
            var items = JB.newObj("DIV");
            _maxWidth = _tObj.offsetWidth;
            //_overItem = null;
            var a_overItem = null;
            v = _beforeShow(v);
            for (var i = 0; i < v.length; i++) {
                var it = _newItem(v[i].t, v[i].v || v[i].t);
                if (i == 0) a_overItem = it;
                items.appendChild(it);
            }
            if (_showTitle) {
                _title = _titleFormat ? JB.strFormat(_titleFmt, _lastKey) : _titleFmt;
                _maxWidth = Math.max(_maxWidth, _getClientSize("<b>" + _title + "</b>").w);
            }
            for (var i = 0; i < items.childNodes; i++) {
                if (items.childNodes.item[i].innerHTML != "") {
                    JB.setOpt(items.childNodes.item[i], { w: _maxWidth });
                }
            }
            if (v.length == 0) {
                _dialog.close();
                _DEBUG_CALLBACK("没有建议");
                return;
            }
            _DEBUG_CALLBACK("showing");
            _dialog.show(_tObj, items, {
                w: _maxWidth, showCloseButton: false, padding: 0, showTitle: _showTitle, titleH: _titleH, title: _title, outerClickClose: true,
                pos: { to: "obj", parent: _tObj.parentNode, park: "outside", parkOutside: "bottomLeft", parkSmart: false },
                afterClose: function () { _DEBUG_CALLBACK("_dialogClose, _overItem = null"); _overItem = null; _afterClose(_this); },
                debugCallback: _DEBUG_CALLBACK,
                afterShow: function () { _overItem = a_overItem; }
            });
            _mouseOver2(a_overItem);
            _afterShow(_this);
            _DEBUG_CALLBACK("列表完毕！");
        } catch (e) {
            _DEBUG_CALLBACK("出错:" + e.description);
        }
    }
    this.close = function () {
        _dialog.close();
    }
    var _callback2 = function (txt, isnew) {
        try {
            if (_debug) alert(txt);
            var v = eval("(" + txt + ")");
            _this.show(v);
            if (isnew) _keyValues.push({ k: _lastKey, v: txt });
        } catch (e) { }
    }
    var _callback = function (xmlhttp) {
        try {
            var txt = _afterAjax(xmlhttp.responseText);
            _callback2(txt, true);
        } catch (e) { }
    };
    var _timeoutId = null;
    var _delayAjax = function (v) {
        if (_timeoutId != null) clearTimeout(_timeoutId);
        _timeoutId = JB.setTimeout(JB.ajax.get, 500, _action + escape(v) + "&t=" + new Date(), _callback);
    }
    var _onkeyup = function () {
        var v = JB.trim(_tObj.value);
        if (v != _lastKey) {
            if (_vObj) _vObj.value = "";
            if (v == "") return;
            _lastKey = v;
            for (var i = 0; i < _keyValues.length; i++) {
                if (_keyValues[i].k == v) {
                    _callback2(_keyValues[i].v);
                    return;
                }
            }
            try {
                if (!_beforeAction(v)) return;  //前置检查
                switch (_actionType) {
                    case "txt":
                        {
                            _callback2(_action);
                            break;
                        }
                    case "function":
                        {
                            if (JB.isFunction(_action)) _callback2(_action(v));
                            break;
                        }
                    case "ajax":
                        {
                            //_delayAjax(v);
                            var ac = _beforeAjax(_action, v);
                            if (ac) {
                                if (ac === true) ac = action + escape(v) + "&t=" + new Date();
                                if (_debug) alert(ac);
                                JB.ajax.get(ac, _callback);
                            }
                            break;
                        }
                    default: break;
                }
            } catch (e) { }
        }
    }
    var _selectPreItem = function () {
        if (_overItem == null) { alert(_overItem); return; }
        var it = _overItem.previousSibling;
        while (it) {
            if (it.innerHTML != "") {
                _mouseOver2(it);
                return;
            }
            it = it.previousSibling;
        }
    }
    var _selectNextItem = function () {
        if (_overItem == null) { alert(_overItem); return; }
        var it = _overItem.nextSibling;
        while (it) {
            if (it.innerHTML != "") {
                _mouseOver2(it);
                return;
            }
            it = it.nextSibling;
        }
    }
    var _enterDown = false;
    var _forbitSubmit = function (e) {
        e = e || window.event;
        if (_enterDown && e && e.preventDefault) e.preventDefault();
        return !_enterDown;
    }
    if (_getForm() !== 0) JB.attach(_formObj, "submit", _forbitSubmit);

    var _cancelBubble = function (e) {
        e = e || window.event;
        if (e && e.stopPropagation) e.stopPropagation();
        else window.event.cancelBubble = true;  //IE
        if (e && e.preventDefault) e.preventDefault();
    }
    var _keyUpFun = function (e) {
        e = window.event || e;
        var currKey = e.which || e.keyCode || e.charCode;
        //if ((currKey > 7 && currKey < 14) || (currKey > 31 && currKey < 47)) {
        switch (currKey) {
            case 13: { break; }
            case 37: { _selectPreItem(); break; }
            case 38: { _selectPreItem(); break; }
            case 39: { _selectNextItem(); break; }
            case 40: { _selectNextItem(); break; }
            default: { _onkeyup(); }
        }
    }
    var _keyDownFun = function (e) {
        if (JB.getEventSrc(e) == _tObj) {
            e = window.event || e;
            var currKey = e.which || e.keyCode || e.charCode;
            if (currKey == 13) {
                if (_overItem != null) {
                    if (_enterSelectSubmit != true) _cancelBubble(e);
                    else _enterDown = true;
                    _itemClick2(_overItem);
                }
            }
        } else _enterDown = false;
    }
    var _mouseDownFun = function (e) { _enterDown = false; }
    JB.attach(_tObj, "keyup", _keyUpFun);
    JB.attach(document, "keydown", _keyDownFun);
    JB.attach(document, "mousedown", _mouseDownFun);
    _DEBUG_CALLBACK("inited");
    //return _this;
}



typeof define == "function" && define("/js/jbody.js?20140712");