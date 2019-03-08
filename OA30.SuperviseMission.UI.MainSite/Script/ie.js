'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

; (function (global, factory) {
    (typeof exports === 'undefined' ? 'undefined' : _typeof(exports)) === 'object' && typeof module !== 'undefined' ? module.exports = factory() : typeof define === 'function' && define.amd ? define(factory) : global.moment = factory();
})(undefined, function () {
    //if (navigator.userAgent.toUpperCase().indexOf('MSIE 8') >= 0) {
    //    $("input[disabled='disabled']").each(function () {
    //        $(this).removeAttr('disabled');
    //        $(this).attr('unselectable', 'on');
    //    });
    //};
})