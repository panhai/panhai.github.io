'use strict';

define(function (require) {
    var layer = require('toast');
    var baseValidate = {
        isEmpty: function (v) {
            if (v == "" || v == "undefined" || v == "null" || v == undefined) {
                return true;
            } else {
                return false;
            }
        }
    };
    
    /*
    Ajax调用通用方法
    */
    function Ajax(cfg) {
        var ret;
        //try {
        if (baseValidate.isEmpty(cfg.data)) {
            cfg.data = {};
        }

        $.ajax({
            type: "POST",
            url: "/SM/WebServices/SuperviseMissionWebServices.asmx/" + cfg.FunName + "?date=" + Date.parse(new Date()),
            data: JSON.stringify(cfg.data),
            timeout: 10000,
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            async: cfg.async || false,
            success: function (data) {
                if (data.d.status == "1") {
                    ret = data.d;
                    cfg.callback && cfg.callback(data.d, cfg);
                }
                else {
                    ret = { status: data.d.status, msg: data.d.msg };
                    cfg.callback && cfg.callback(ret, cfg);
                }
            },
            failure: function (msg) {
                ret = {};
                layer.msg('数据请求超时！');
                btnDisabled = false;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert("ajax调用出错了,textStatus:" + textStatus + " errorThrown " + errorThrown + "XMLHttpRequest" + XMLHttpRequest.responseText);
                //console.log(XMLHttpRequest);
                //console.log(XMLHttpRequest.responseText);
                //console.log(XMLHttpRequest.status);
                //console.log(XMLHttpRequest.readyState);
                //console.log(textStatus);
                //console.log(errorThrown);
            },
            complete: function (XMLHttpRequest, status) {
                if (status == 'timeout') {//超时重新加载
                    //myalert('数据请求超时！');
                    layer.msg('数据请求超时！');
                    btnDisabled = false;
                }
            }
        });
        //} catch (e) {
        //    alert(e.message);
        //}
        return ret;
    }
    return Ajax
})