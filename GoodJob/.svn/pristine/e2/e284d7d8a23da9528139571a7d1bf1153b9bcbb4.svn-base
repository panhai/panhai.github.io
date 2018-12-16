
function MutiSelector(opts) {

}

function MutiPositionCreater2(opts) {
    var _this = this;
    var _opts = opts || {};
    var _thisObjName = _opts.objName;   //创建的对象名（方便编写代码而已，避免要使用对象绑定回调）
    var _maxSelect = _opts.maxSelect || 2;
    var _objHiddenId = _opts.objHiddenId;
    var _selectElement = _opts.selectElement;
    var _textWhenEmpty = _opts.textWhenEmpty;
    var _dialogTitle = _opts.dialogTitle;
    var _tempSelectedIds = "";
    this.checkBoxClick = function (elm) {
        var ids = _tempSelectedIds + "";
        var c = 0;
        var idsss = ids.split(',');
        for (var j = 0; j < idsss.length; j++) if (JB.trim(idsss[j]) != "") c++;
        if (elm.checked) {
            if (c >= _maxSelect) {
                alert("最多只能选" + _maxSelect + "项");
                elm.checked = false;
                return;
            }
            ids += ',' + elm.value + ',';
            $(elm).parent().css("fontWeight", "bold").css("color", "#007ab5");
            var sp = "<span style=\"float:left; width:auto; margin-left:5px; height:22px; text-align:left;font-weight:bold;color:#007ab5;\">";
            sp += "<input type=\"checkbox\" checked value=\"" + elm.value + "\" style=\"vertical-align:middle;\" /> " + $(elm).parent().text();
            sp += "</span>";
            $(elm).parentsUntil("table").find("tr").eq(0).find("td").eq(1).append(sp);
            $(elm).parentsUntil("table").find("tr").eq(0).find("td").eq(1).find("input").last().click(function () {
                var v = this.value;
                var ids = _tempSelectedIds + "";
                ids = ids.replace(',' + v + ',', "");
                _tempSelectedIds = ids;
                $(this).parentsUntil("table").find("tr").eq(1).find("input[value=" + v + "]").parent().css("fontWeight", "normal").css("color", "#333");
                $(this).parentsUntil("table").find("tr").eq(1).find("input[value=" + v + "]").get(0).checked = false;
                $(this).parent().remove();
            });
        } else {
            ids = ids.replace(',' + elm.value + ',', "");
            $(elm).parent().css("fontWeight", "normal").css("color", "#333");
            $(elm).parentsUntil("table").find("tr").eq(0).find("input[value=" + elm.value + "]").parent().remove();
        }
        _tempSelectedIds = ids;
    }
    this.checkBoxCancel = function (elm) {
        var v = elm.value;
        var ids = _tempSelectedIds + "";
        ids = ids.replace(',' + v + ',', "");
        _tempSelectedIds = ids;
        $(elm).parentsUntil("table").find("tr").eq(1).find("input[value=" + v + "]").parent().css("fontWeight", "normal").css("color", "#333");
        $(elm).parentsUntil("table").find("tr").eq(1).find("input[value=" + v + "]").get(0).checked = false;
        $(elm).parent().remove();
    }
    this.update = function () {
        var sbjs = GetPositionsByIds(JB.trim($(_objHiddenId).val()), false);
        var htm = "";
        for (var i = 0; i < sbjs.length; i++) {
            htm += sbjs[i][0] + ";&nbsp;";
            if (sbjs.length > 4 && i >= 3) {
                htm += "..等" + sbjs.length + "项";
                break;
            }
        }
        if (htm == "") htm = _textWhenEmpty;
        $(_selectElement).find("option").first().html(htm);
        $(_selectElement).parent().find("div").eq(1).width($(_selectElement).width());
    }
    this.update();
    this.set = function () {
        $(_objHiddenId).val(_tempSelectedIds);
        JBDialog.close();
        _this.update();
    }
    this.onmsover = function (elm, idx) {
        $(elm).parent().parent().find("td").eq(1).find("div").hide();
        $(elm).parent().parent().find("td").eq(1).find("div").eq(idx).show();
        $(elm).parent().find("div").css("borderRight", "solid 1px #bbb").css("background", "#eee");
        $(elm).css("borderRight", "solid 0px #bbb").css("background", "#fff");
    }
    this.show = function (elm) {
        _tempSelectedIds = JB.trim($(_objHiddenId).val());
        var htm = "<table style='width:550px;'><tr><td style='font-size:14px; vertical-align:top; line-height:30px; width:80px;'>已选中：</td><td style='padding-left:10px;' colspan='2'>{checkedObj}</td></tr><tr>";
        var td1 = "";
        var td2 = "";
        var checkedObj = "";
        var topsbjs = GetTopPositions();  //参看jobPositions.js
        for (var i = 0; i < topsbjs.length; i++) {
            td1 += "<div onmouseover='" + _thisObjName + ".onmsover(this," + i + ")' style='cursor:default;border-bottom:solid 1px #bbb;border-right:solid " + (i == 0 ? "0" : "1") + "px #bbb; line-height:30px;height:30px;font-size:14px;background:" + (i == 0 ? "#fff" : "#eee") + ";'>" + topsbjs[i][0] + "</div>";
            td2 += "<div style='display:" + (i == 0 ? "blcok" : "none") + "; margin:10px;'>";
            //htm+="<tr><td style='width:100px;vertical-align:top; padding-top:10px;'>"+topsbjs[i][0]+"</td><td style='padding-top:10px;'>";
            var childs = GetPositions(topsbjs[i][2]);
            for (var j = 0; j < childs.length; j++) {
                var chk = _tempSelectedIds.indexOf(',' + childs[j][2] + ',') >= 0;
                td2 += "<span style=\"float:left; width:300px;font-size:14px; height:30px; text-align:left;" + (chk ? "font-weight:bold;color:#007ab5;" : "color:#333;") + "\">";
                td2 += "<input type=\"checkbox\" onclick=\"" + _thisObjName + ".checkBoxClick(this)\" " + (chk ? "checked" : "") + " value=\"" + childs[j][2] + "\" style=\"vertical-align:middle;\" /> " + childs[j][0];
                td2 += "</span>";
                if (chk) {
                    checkedObj += "<span style=\"float:left; width:auto; margin-left:5px; height:22px; text-align:left;" + (chk ? "font-weight:bold;color:#007ab5;" : "color:#333;") + "\">";
                    checkedObj += "<input type=\"checkbox\" onclick=\"" + _thisObjName + ".checkBoxCancel(this)\" " + (chk ? "checked" : "") + " value=\"" + childs[j][2] + "\" style=\"vertical-align:middle;\" /> " + childs[j][0];
                    checkedObj += "</span>";
                }
            }
            td2 += "</div>";
            //htm+="</td></tr>";
        }
        htm += "<td style='border-top:solid 1px #bbb;border-left:solid 1px #bbb;' colspan='2'>" + td1 + "</td><td style='vertical-align:top;border:solid 1px #bbb;border-left:0px;'>" + td2 + "</td></tr>";
        htm += "<tr><td style='width:80px;'>&nbsp;</td><td style='width:150px;'>&nbsp;</td><td style='height:60px;'><div onclick='" + _thisObjName + ".set()' class=\"CommonButtonSmall CommonButtonOrange60\">确定</div></td></tr>";
        htm += "</table>";
        htm = htm.replace("{checkedObj}", checkedObj);
        JBDialog.show(elm, htm, { title: _dialogTitle + "（最多可选<span style='color:orange;'>" + _maxSelect + "</span>项）", modal: true, pos: { to: "win", parent: "doc" } });
    }
}

function MutiPositionCreater(opts) {
    var _this = this;
    var _opts = opts || {};
    var _widths = {
        main: 880,
        headGroup: 175,
        head: 170,
        sub: 340,
        sub_item: 160
    };
    var _thisObjName = _opts.objName;   //创建的对象名（方便编写代码而已，避免要使用对象绑定回调）
    var _maxSelect = _opts.maxSelect || 2;
    var _objHiddenId = _opts.objHiddenId;
    var _selectElement = _opts.selectElement;
    var _textWhenEmpty = _opts.textWhenEmpty;
    var _dialogTitle = _opts.dialogTitle;
    var _tempSelectedIds = "";
    var _dialog = new JBodyDialog();
    this.debug = _opts.debug || function () { };
    this.confirmCallback = _opts.confirmCallback || function () { };
    this.onchange = _opts.onchange || [function () { }];
    this.mainTableID = "multisltable" + JB.dateTimeToString(new Date(), "yyyyMMddHHmmssfff");
    this.getValue = function () {
        return $(_objHiddenId).val();
    }
    this.hasValue = function () {
        return JB.trim(_this.getValue().replace(",", "")) != "";
    }
    this.setValue = function (v) {  //外部重设
        var chg = $(_objHiddenId).val() != v;
        $(_objHiddenId).val(v);
        _dialog.close();
        _this.update(chg);
    }
    this.update = function (change, cb) {
        var poss = GetPositionsByIds(JB.trim($(_objHiddenId).val()), false);
        var htm = "";
        var names = "";
        var tts = "";
        for (var i = 0; i < poss.length; i++) {
            htm += (i == 0 ? "" : "; ") + poss[i][0];
            names += (i == 0 ? "" : "; ") + poss[i][0];
            tts += poss[i][0] + "\r\n";
            if (poss.length > 4) {
                if (i > 4) continue;
                if (i >= 3) htm += "..等" + poss.length + "项";
            }
        }
        if (htm == "") htm = _textWhenEmpty;
        $(_selectElement).get(0).options[$(_selectElement).get(0).length] = new Option(htm, $(_objHiddenId).val(), null, true);
        $(_selectElement).attr("title", names);
        $(_selectElement).parent().find("div").eq(1).width($(_selectElement).width());
        if (cb) _this.confirmCallback({ ids: $(_objHiddenId).val(), names: names });
        if (change) for (var i = 0; i < _this.onchange.length; i++) _this.onchange[i]({ value: $(_objHiddenId).val(), names: names, tts: tts });
    }
    this.update();
    this.set = function () {
        var chg = $(_objHiddenId).val() != _tempSelectedIds;
        $(_objHiddenId).val(_tempSelectedIds);
        _dialog.close();
        _this.update(chg, true);
    }
    this.selectNone = function () {
        _tempSelectedIds = "";
        _this.set();
    }
    this.close = function () {
        _dialog.close();
    }
    this.cancel = function (elm, v) {
        $(elm).parent().remove();
        _tempSelectedIds = _tempSelectedIds.replace(',' + v + ',', "");
        var obj = $("input[value='" + v.substr(0, 4) + "00']").parentsUntil(".multi-select-option-group").find(".muti-opt-head").get(0);
        if (!(_tempSelectedIds.indexOf(',' + v.substr(0, 4)) >= 0)) {
            $(obj).removeClass("mover").addClass("normal");
            $(obj).attr("data-count", "0");
        }
    }
    this.updateSelectedView = function () {
        var poss = GetPositionsByIds(_tempSelectedIds, false);
        var htm = "";
        for (var i = 0; i < poss.length; i++) {
            htm += "<div class='multi-select-selected'><span style='float:left;'>" + poss[i][0] + "</span><span class='bt' title='移除' onclick=\"" + _thisObjName + ".cancel(this, '" + poss[i][2] + "')\" ></span></div>";
        }
        if (poss.length > 0) htm += "<div onclick='" + _thisObjName + ".set()' class=\"btn-3d btn-3d-mini btn-3d-orange floatL\" style='margin-left:08px;'>确定</div>";
        $("#" + _this.mainTableID).find("td").eq(1).html(htm);
    }
    this.checkboxclick = function (elm) {
        var ids = _tempSelectedIds + "";
        _tempSelectedIds = "";
        var c = 0;
        var parent = (elm.value.substr(4, 2) == "00") ? elm.value.substr(0, 4) : null;
        var idsss = ids.split(',');
        for (var j = 0; j < idsss.length; j++) {
            if (JB.trim(idsss[j]) != "" && idsss[j].substr(0, 4) != parent) {
                c++;
                _tempSelectedIds += ',' + idsss[j] + ',';
            }
        }
        if (elm.checked) {
            if (c >= _maxSelect) {
                alert("最多只能选" + _maxSelect + "项");
                elm.checked = false;
                return;
            }
            _tempSelectedIds += ',' + elm.value + ',';
        } else {
            _tempSelectedIds = _tempSelectedIds.replace(',' + elm.value + ',', "");
        }
        if (parent) {  //组
            $(elm).parentsUntil(".multi-select-option-group").find("table").eq(1).find("input:checkbox").attr("checked", elm.checked).attr("disabled", elm.checked);
        }
        $(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").attr("data-count", $(elm).parentsUntil(".multi-select-option-group").find("input:checked").length);
        _this.updateSelectedView();
    };
    this.addSubMenu = function (id, idx) {
        var aHtm = "<table><tr><td>";
        var childs = GetPositions(id);
        for (var i = 0; i < childs.length; i++) {
            var disab = _tempSelectedIds.indexOf(childs[i][2].substr(0, 4) + "00") > 0 ? "disabled" : "";
            var chked = (_tempSelectedIds.indexOf(childs[i][2]) > 0 || _tempSelectedIds.indexOf(childs[i][2].substr(0, 4) + "00") > 0) ? "checked" : "";
            aHtm += "<div style='width:" + _widths.sub_item + "px;'><input type='checkbox' value='" + childs[i][2] + "' " + disab + " " + chked + " onclick='" + _thisObjName + ".checkboxclick(this)'>&nbsp;" + childs[i][0] + "</div>";
        }
        aHtm += "</td></tr></table>";
        var aDiv = JB.newObj("DIV", { className: "sub-opts", w: _widths.sub, left: (parseInt(idx) % 4) > 1 ? -170 : 0, htm: aHtm });
        return aDiv;
    }
    this.mouttimeoutElm = null;
    this.mouttimeoutObj = null;
    this.show = function (elm) {
        _tempSelectedIds = JB.trim($(_objHiddenId).val());
        var htm = "<table style='width:" + _widths.main + "px;' id='" + _this.mainTableID + "' class='multi-select-main-table'><tr><td style='font-size:14px; vertical-align:top; line-height:30px; width:80px;background-color:#d9e9ff;'>已选中：</td><td style='text-align:left;background-color:#d9e9ff;' colspan='2'></td></tr>";
        var topsbjs = GetTopPositions();  //参看jobPositions.js
        for (var i = 0; i < topsbjs.length; i++) {
            htm += "<tr style='background-color:" + ((i % 2) == 0 ? "#fff" : "#eee") + "'><td style='width:180px;vertical-align:top;font-weight:bold;padding-top:5px;' colspan='2'>" + topsbjs[i][0] + "</td><td>";
            var childs = GetPositions(topsbjs[i][2]);
            for (var j = 0; j < childs.length; j++) {
                var chked = (_tempSelectedIds.indexOf(childs[j][2]) > 0) ? "checked" : "";
                var slcount = _tempSelectedIds.indexOf("," + childs[j][2].substr(0, 4)) >= 0 ? "1" : "0";
                var aDiv = "<div class='multi-select-option-group' style='width:" + _widths.headGroup + "px;'>";
                aDiv += "<div style='position:relative; left:0px; top:0px; z-index:1;'>";
                aDiv += "<div class='muti-opt-head " + (slcount == "0" ? "normal" : "mover") + "' data-count='" + slcount + "' style='width:" + _widths.head + "px;'>";
                aDiv += "<table data-posid='" + childs[j][2] + "' data-idx='" + j + "'><tr><td class='icn'><input type='checkbox' " + chked + " value='" + childs[j][2] + "' onclick='" + _thisObjName + ".checkboxclick(this)'/><span>&nbsp;</span></td><td>" + childs[j][0] + "</td>";
                aDiv += "</tr></table>";
                aDiv += "</div></div></div>";
                htm += aDiv;
            }
            htm += "</td></tr>";
        }
        htm += "<tr><td style='width:80px;'>&nbsp;</td><td style='width:100px;'>&nbsp;</td><td style='height:60px;'><div onclick='" + _thisObjName + ".set()' class=\"CommonButtonSmall CommonButtonOrange60\" style='float:left;'>确定</div><div onclick='" + _thisObjName + ".close()' class=\"CommonButtonSmall CommonButtonGray60\" style='float:left;margin-left:10px;'>取消</div><div onclick='" + _thisObjName + ".selectNone()' class=\"CommonButtonSmall CommonButtonGray60\" style='float:left;margin-left:10px;'>不限类别</div></td></tr>";
        htm += "</table>";
        _dialog.show(elm, htm, { title: _dialogTitle + "（最多可选<span style='color:orange;'>" + _maxSelect + "</span>项）", modal: true, hideOverfloat: false, pos: { park: "win center", parent: "doc" } });
        _this.updateSelectedView();
        $(".multi-select-option-group").mouseover(function () {
            if (_this.mouttimeoutElm == this && _this.mouttimeoutObj != null) clearTimeout(_this.mouttimeoutObj);
            if ($(this).find(".muti-opt-head").is(".active")) return;
            $(this).find(".muti-opt-head").removeClass("normal").addClass("mover");
            $(this).find("div").first().css("zIndex", "4");
            $(this).find(".muti-opt-head").css("zIndex", "5");
        }).mouseout(function () {
            _this.mouttimeoutElm = this;
            _this.mouttimeoutObj = JB.setTimeout(function (obj1) {
                if ($(obj1).find(".muti-opt-head").attr("data-count") == "0") $(obj1).find(".muti-opt-head").removeClass("mover").addClass("normal");
                else $(obj1).find(".muti-opt-head").addClass("mover");
                if ($(obj1).find(".muti-opt-head").is(".active")) $(obj1).find(".muti-opt-head").removeClass("active");
                $(obj1).find(".sub-opts").remove();
                $(obj1).find("div").first().css("zIndex", "1");
                $(obj1).find(".muti-opt-head").css("zIndex", "1");
            }, 200, this);
        });
        $(".multi-select-option-group input").mouseover(function () {
            if (_this.mouttimeoutElm == $(this).parentsUntil(".multi-select-option-group").find(".muti-opt-head").parent().parent() && _this.mouttimeoutObj != null) clearTimeout(_this.mouttimeoutObj);
            if ($(this).parentsUntil(".multi-select-option-group").find(".muti-opt-head").is(".active")) return;
            $(this).parentsUntil(".multi-select-option-group").find(".muti-opt-head").addClass("active").removeClass("mover").removeClass("normal");
        });
        $(".muti-opt-head table").click(function () {
            JB.setTimeout(function (obj1) {
                if ($(obj1).parentsUntil(".multi-select-option-group").find(".muti-opt-head").is(".active")) return;
                $(obj1).parentsUntil(".multi-select-option-group").find(".muti-opt-head").addClass("active").removeClass("mover").removeClass("normal");
                $(obj1).parent().parent().css("zIndex", "4");
                $(obj1).parent().css("zIndex", "5");
                $(obj1).parent().parent().append(_this.addSubMenu($(obj1).attr("data-posid"), $(obj1).attr("data-idx")));
            }, 100, this);
        });
    }
}

function MultiCityCreater(opts) {
    var _this = this;
    var _opts = opts || {};
    var _widths = {
        main: 350,
        headGroup: 85,
        head: 80,
        sub: 250,
        sub_item: 70
    };
    var _canSelectProvince = false;
    var _thisObjName = _opts.objName;   //创建的对象名（方便编写代码而已，避免要使用对象绑定回调）
    var _maxSelect = _opts.maxSelect || 2;
    var _objHiddenId = _opts.objHiddenId;
    var _selectElement = _opts.selectElement;
    var _textWhenEmpty = _opts.textWhenEmpty;
    var _dialogTitle = _opts.dialogTitle;
    var _tempSelectedIds = "";
    var _dialog = new JBodyDialog();
    this.debug = _opts.debug || function () { };
    this.confirmCallback = _opts.confirmCallback || function () { };
    this.onchange = _opts.onchange || [function () { }];
    this.mainTableID = "multisltable" + JB.dateTimeToString(new Date(), "yyyyMMddHHmmssfff");
    this.getValue = function () {
        return $(_objHiddenId).val();
    }
    this.hasValue = function () {
        return JB.trim(_this.getValue().replace(",", "")) != "";
    }
    this.setValue = function (v) {  //外部重设
        var chg = $(_objHiddenId).val() != v;
        $(_objHiddenId).val(v);
        _dialog.close();
        _this.update(chg);
    }
    this.update = function (change, cb) {
        var poss = GetAreasByIds(JB.trim($(_objHiddenId).val()), true);  //参看area.js
        var htm = "";
        var names = "";
        var tts = "";
        for (var i = 0; i < poss.length; i++) {
            names += (i == 0 ? "" : "; ") + poss[i][0];
            tts += poss[i][0] + "\r\n";
            if (poss.length > 4) {
                if (i >= 4) continue;
                htm += (i == 0 ? "" : "; ") + poss[i][0];
                if (i >= 3) htm += "..等" + poss.length + "市";
            } else htm += (i == 0 ? "" : "; ") + poss[i][0];
        }
        if (htm == "") htm = _textWhenEmpty;
        $(_selectElement).get(0).options[$(_selectElement).get(0).length] = new Option(htm, $(_objHiddenId).val(), null, true);
        $(_selectElement).attr("title", names);
        $(_selectElement).parent().find("div").eq(1).width($(_selectElement).width());
        if (cb) _this.confirmCallback({ ids: $(_objHiddenId).val(), names: names });
        if (change) for (var i = 0; i < _this.onchange.length; i++) _this.onchange[i]({ value: $(_objHiddenId).val(), names: names, tts: tts });
    }
    _this.update();
    this.set = function () {
        var chg = $(_objHiddenId).val() != _tempSelectedIds;
        $(_objHiddenId).val(_tempSelectedIds);
        _dialog.close();
        _this.update(chg, true);
    }
    this.selectNone = function () {  //选择不限城市
        _tempSelectedIds = "";
        _this.set();
    }
    this.close = function () {
        _dialog.close();
    }
    this.cancel = function (elm, v) {
        _tempSelectedIds = _tempSelectedIds.replace(',' + v + ',', "");
        var obj = $("input[value='" + v.substr(0, 2) + "0000']").parentsUntil(".multi-select-option-group").find(".muti-opt-head").get(0);
        if (!(_tempSelectedIds.indexOf(',' + v.substr(0, 2)) >= 0)) {
            $(obj).removeClass("mover").addClass("normal");
            $(obj).attr("data-count", "0");
        }
        JB.setTimeout(function (objaa) {
            objaa.parentNode.parentNode.removeChild(objaa.parentNode);
        }, 50, elm);
    }
    this.updateSelectedView = function () {
        var poss = GetAreasByIds(_tempSelectedIds, true);
        var htm = "";
        for (var i = 0; i < poss.length; i++) {
            htm += "<div class='multi-select-selected' style='margin-left:5px;'><span style='float:left;'>" + poss[i][0] + "</span><span class='bt' title='移除' onclick=\"" + _thisObjName + ".cancel(this, '" + poss[i][2] + "')\" ></span></div>";
        }
        if (poss.length > 0) htm += "<div onclick='" + _thisObjName + ".set()' class=\"btn-3d btn-3d-mini btn-3d-orange floatL mginL05\">确定</div>";
        $("#" + _this.mainTableID).find("td").eq(1).html(htm);
    }
    this.checkboxclick = function (elm) {
        var ids = _tempSelectedIds + "";
        _tempSelectedIds = "";
        var c = 0;
        var parent = (elm.value.substr(2, 2) == "00") ? elm.value.substr(0, 2) : null;
        var idsss = ids.split(',');
        for (var j = 0; j < idsss.length; j++) {
            if (JB.trim(idsss[j]) != "" && idsss[j].substr(0, 2) != parent) {
                c++;
                _tempSelectedIds += ',' + idsss[j] + ',';
            }
        }
        if (elm.checked) {
            if (c >= _maxSelect) {
                alert("最多只能选" + _maxSelect + "项");
                elm.checked = false;
                return;
            }
            _tempSelectedIds += ',' + elm.value + ',';
        } else {
            _tempSelectedIds = _tempSelectedIds.replace(',' + elm.value + ',', "");
        }
        if (parent) {  //组
            $(elm).parentsUntil(".multi-select-option-group").find("table").eq(1).find("input:checkbox").attr("checked", elm.checked).attr("disabled", elm.checked);
        }
        $(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").attr("data-count", $(elm).parentsUntil(".multi-select-option-group").find("input:checked").length);
        _this.updateSelectedView();
    };
    this.isProvinceLevelCity = function (id) {  //是否直辖市或特别行政区
        var a = GetArea(id);
        return "..北京上海天津重庆香港澳门..".indexOf(a[0]) > 0;
    }
    this.addSubMenu = function (id, idx) {
        var aHtm = "<table><tr><td>";
        var childs = GetAreas(id);
        for (var i = 0; i < childs.length; i++) {
            var disab = _tempSelectedIds.indexOf(childs[i][2].substr(0, 2) + "0000") > 0 ? "disabled" : "";
            var chked = (_tempSelectedIds.indexOf(childs[i][2]) > 0 || _tempSelectedIds.indexOf(childs[i][2].substr(0, 2) + "0000") > 0) ? "checked" : "";
            aHtm += "<div style='width:" + _widths.sub_item + "px;'><input type='checkbox' value='" + childs[i][2] + "' " + disab + " " + chked + " onclick='" + _thisObjName + ".checkboxclick(this)'>&nbsp;" + childs[i][0] + "</div>";
        }
        aHtm += "</td></tr></table>";
        var aDiv = JB.newObj("DIV", { className: "sub-opts", w: _widths.sub, left: (parseInt(idx) % 4) > 1 ? -170 : 0, htm: aHtm });
        return aDiv;
    }
    this.mouttimeoutElm = null;
    this.mouttimeoutObj = null;
    this.mouseovergroup = function (elm) {
        if (_this.mouttimeoutElm == elm && _this.mouttimeoutObj != null) clearTimeout(_this.mouttimeoutObj);
        if ($(elm).find(".muti-opt-head").is(".active")) return;
        if ($(elm).find(".muti-opt-head").is(".active2")) return;
        $(elm).find(".muti-opt-head").removeClass("normal").addClass("mover");
        $(elm).find("div").first().css("zIndex", "4");
        $(elm).find(".muti-opt-head").css("zIndex", "5");
    }
    this.mouseoutgroup = function (elm) {
        _this.mouttimeoutElm = elm;
        _this.mouttimeoutObj = JB.setTimeout(function (obj1) {
            if ($(obj1).find(".muti-opt-head").attr("data-count") == "0") $(obj1).find(".muti-opt-head").removeClass("mover").addClass("normal");
            else $(obj1).find(".muti-opt-head").addClass("mover");
            if ($(obj1).find(".muti-opt-head").is(".active")) $(obj1).find(".muti-opt-head").removeClass("active");
            if ($(obj1).find(".muti-opt-head").is(".active2")) $(obj1).find(".muti-opt-head").removeClass("active2");
            $(obj1).find(".sub-opts").remove();
            $(obj1).find("div").first().css("zIndex", "1");
            $(obj1).find(".muti-opt-head").css("zIndex", "1");
        }, 200, elm);
    }
    this.mouseovergroupinput = function (elm) {
        var ActiveClass = _this.isProvinceLevelCity($(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head table").first().attr("data-posid")) ? "active2" : "active";
        if (_this.mouttimeoutElm == $(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").parent().parent() && _this.mouttimeoutObj != null) clearTimeout(_this.mouttimeoutObj);
        if ($(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").is("." + ActiveClass)) return;
        $(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").addClass(ActiveClass).removeClass("mover").removeClass("normal");
    }
    this.showsubitems = function (elm) {
        JB.setTimeout(function (obj1) {
            var ActiveClass = _this.isProvinceLevelCity($(obj1).attr("data-posid")) ? "active2" : "active";
            if ($(obj1).parentsUntil(".multi-select-option-group").find(".muti-opt-head").is("." + ActiveClass)) return;
            $(obj1).parentsUntil(".multi-select-option-group").find(".muti-opt-head").addClass(ActiveClass).removeClass("mover").removeClass("normal");
            $(obj1).parent().parent().css("zIndex", "4");
            $(obj1).parent().css("zIndex", "5");
            if (!_this.isProvinceLevelCity($(obj1).attr("data-posid"))) $(obj1).parent().parent().append(_this.addSubMenu($(obj1).attr("data-posid"), $(obj1).attr("data-idx")));
        }, 100, elm);
    }
    this.show = function (elm) {
        _tempSelectedIds = JB.trim($(_objHiddenId).val());
        var htm = "<table style='width:" + _widths.main + "px;' id='" + _this.mainTableID + "' class='multi-select-main-table'><tr><td style='font-size:14px; vertical-align:top; line-height:30px; width:60px;background-color:#d9e9ff;'>已选中：</td><td style='text-align:left;background-color:#d9e9ff;' colspan='2'></td></tr>";
        var childs = GetAreas("0");  //参看area.js
        var i = 0;
        for (var j = 0; j < childs.length; j++) {
            if (j % 4 == 0) {
                if (j > 0) htm += "</td></tr>";
                htm += "<tr style='background-color:" + (parseInt(j / 4) % 2 == 0 ? "#fff" : "#eee") + "'><td colspan='2'>";
            }
            var chked = (_tempSelectedIds.indexOf(childs[j][2]) > 0) ? "checked" : "";
            var slcount = _tempSelectedIds.indexOf("," + childs[j][2].substr(0, 2)) >= 0 ? "1" : "0";
            var isProvCity = _this.isProvinceLevelCity(childs[j][2]);
            var disab = (!isProvCity && !_canSelectProvince) ? "disabled" : "";
            //var chkedObj = _this.isProvinceLevelCity($(obj1).attr("data-posid")) ? "active2" : "active";
            var aDiv = "<div class='multi-select-option-group' onmouseover='" + _thisObjName + ".mouseovergroup(this)' onmouseout='" + _thisObjName + ".mouseoutgroup(this)' style='width:" + _widths.headGroup + "px;'>";
            aDiv += "<div style='position:relative; left:0px; top:0px; z-index:1;'>";
            aDiv += "<div class='muti-opt-head " + (slcount == "0" ? "normal" : "mover") + "' data-count='" + slcount + "' style='width:" + _widths.head + "px;'>";
            aDiv += "<table onclick='" + _thisObjName + ".showsubitems(this)' data-posid='" + childs[j][2] + "' data-idx='" + j + "'><tr><td class='icn'><input onmouseover='" + _thisObjName + ".mouseovergroupinput(this)' type='checkbox' " + chked + " " + disab + " value='" + childs[j][2] + "' onclick='" + _thisObjName + ".checkboxclick(this)'/><span>&nbsp;</span></td><td>" + childs[j][0] + "</td>";
            aDiv += "</tr></table>";
            aDiv += "</div></div></div>";
            htm += aDiv;
        }
        htm += "</td></tr>";
        htm += "<tr><td>&nbsp;</td><td style='height:60px;'><div onclick='" + _thisObjName + ".set()' class=\"CommonButtonSmall CommonButtonOrange60\" style='float:left;'>确定</div><div onclick='" + _thisObjName + ".close()' class=\"CommonButtonSmall CommonButtonGray60\" style='float:left;margin-left:10px;'>取消</div><div onclick='" + _thisObjName + ".selectNone()' class=\"CommonButtonSmall CommonButtonGray60\" style='float:right;margin-right:20px;'>不限城市</div></td></tr>";
        htm += "</table>";
        _dialog.show(elm, htm, { title: _dialogTitle + "（最多可选<span style='color:orange;'>" + _maxSelect + "</span>项）", modal: false, outerClickClose: true, hideOverfloat: false, pos: [{ to: "obj", parent: "doc", park: "outside", parkOutside: "topLeft" }, { to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft" }] });
        setTimeout(_this.updateSelectedView, 200); //必须延迟显示
    }
}

function SingleCityCreater(opts) {
    var _this = this;
    var _opts = opts || {};
    var _widths = {
        main: 350,
        headGroup: 85,
        head: 80,
        sub: 250,
        sub_item: 70
    };
    var _canSelectProvince = false;
    var _thisObjName = _opts.objName;   //创建的对象名（方便编写代码而已，避免要使用对象绑定回调）
    var _objHiddenId = _opts.objHiddenId;
    var _selectElement = _opts.selectElement;
    var _textWhenEmpty = _opts.textWhenEmpty;
    var _dialogTitle = _opts.dialogTitle;
    var _tempSelectedIds = "";
    var _dialog = new JBodyDialog();
    this.debug = _opts.debug || function () { };
    this.onchange = _opts.onchange || [function () { }];
    this.mainTableID = "multisltable" + JB.dateTimeToString(new Date(), "yyyyMMddHHmmssfff");
    this.getValue = function () {
        return $(_objHiddenId).val();
    }
    this.hasValue = function () {
        return JB.trim(_this.getValue().replace(",", "")) != "";
    }
    this.setValue = function (v) {  //外部重设
        var chg = $(_objHiddenId).val() != v;
        $(_objHiddenId).val(v);
        _dialog.close();
        _update(chg, true);
    }
    var _update = function (change) {
        var poss = GetAreasByIds(JB.trim($(_objHiddenId).val()), true);  //参看area.js
        var htm = "";
        var names = "";
        var tts = "";
        for (var i = 0; i < poss.length; i++) {
            names += (i == 0 ? "" : "; ") + poss[i][0];
            tts += (i == 0 ? "" : "\r\n") + poss[i][0];
            htm += (i == 0 ? "" : "; ") + poss[i][0];
        }
        if (htm == "") htm = _textWhenEmpty;
        $(_selectElement).get(0).options[$(_selectElement).get(0).length] = new Option(htm, $(_objHiddenId).val(), null, true);
        $(_selectElement).attr("title", names);
        if (change) for (var i = 0; i < _this.onchange.length; i++) _this.onchange[i]({ value: $(_objHiddenId).val(), names: names, tts: tts });
    }
    _update();
    this.set = function () {
        var chg = $(_objHiddenId).val() != _tempSelectedIds;
        $(_objHiddenId).val(_tempSelectedIds);
        _dialog.close();
        _update(chg, true);
    }
    this.close = function () {
        _dialog.close();
    }
    this.updateSelectedView = function () {
        var poss = GetAreasByIds(_tempSelectedIds, true);
        var htm = "";
        for (var i = 0; i < poss.length; i++) {
            htm += "<div class='multi-select-selected'><span style='float:left;'>" + poss[i][0] + "</span></div>";
        }
        $("#" + _this.mainTableID).find("td").eq(1).html(htm);
    }
    this.radioclick = function (elm) {
        _tempSelectedIds = elm.value;
        _this.set();
    };
    this.isProvinceLevelCity = function (id) {  //是否直辖市或特别行政区
        var a = GetArea(id);
        return "..北京上海天津重庆香港澳门..".indexOf(a[0]) > 0;
    }
    this.addSubMenu = function (id, idx) {
        var aHtm = "<table><tr><td>";
        var childs = GetAreas(id);
        for (var i = 0; i < childs.length; i++) {
            var disab = _tempSelectedIds.indexOf(childs[i][2].substr(0, 2) + "0000") > 0 ? "disabled" : "";
            var chked = (_tempSelectedIds.indexOf(childs[i][2]) > 0 || _tempSelectedIds.indexOf(childs[i][2].substr(0, 2) + "0000") > 0) ? "checked" : "";
            aHtm += "<div style='width:" + _widths.sub_item + "px;'><input type='radio' value='" + childs[i][2] + "' " + disab + " " + chked + " onclick='" + _thisObjName + ".radioclick(this)'>&nbsp;" + childs[i][0] + "</div>";
        }
        aHtm += "</td></tr></table>";
        var aDiv = JB.newObj("DIV", { className: "sub-opts", w: _widths.sub, left: (parseInt(idx) % 4) > 1 ? -170 : 0, htm: aHtm });
        return aDiv;
    }
    this.mouttimeoutElm = null;
    this.mouttimeoutObj = null;
    this.mouseovergroup = function (elm) {
        if (_this.mouttimeoutElm == elm && _this.mouttimeoutObj != null) clearTimeout(_this.mouttimeoutObj);
        if ($(elm).find(".muti-opt-head").is(".active")) return;
        if ($(elm).find(".muti-opt-head").is(".active2")) return;
        $(elm).find(".muti-opt-head").removeClass("normal").addClass("mover");
        $(elm).find("div").first().css("zIndex", "4");
        $(elm).find(".muti-opt-head").css("zIndex", "5");
    }
    this.mouseoutgroup = function (elm) {
        _this.mouttimeoutElm = elm;
        _this.mouttimeoutObj = JB.setTimeout(function (obj1) {
            if ($(obj1).find(".muti-opt-head").attr("data-count") == "0") $(obj1).find(".muti-opt-head").removeClass("mover").addClass("normal");
            else $(obj1).find(".muti-opt-head").addClass("mover");
            if ($(obj1).find(".muti-opt-head").is(".active")) $(obj1).find(".muti-opt-head").removeClass("active");
            if ($(obj1).find(".muti-opt-head").is(".active2")) $(obj1).find(".muti-opt-head").removeClass("active2");
            $(obj1).find(".sub-opts").remove();
            $(obj1).find("div").first().css("zIndex", "1");
            $(obj1).find(".muti-opt-head").css("zIndex", "1");
        }, 200, elm);
    }
    this.mouseovergroupinput = function (elm) {
        var ActiveClass = _this.isProvinceLevelCity($(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head table").first().attr("data-posid")) ? "active2" : "active";
        if (_this.mouttimeoutElm == $(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").parent().parent() && _this.mouttimeoutObj != null) clearTimeout(_this.mouttimeoutObj);
        if ($(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").is("." + ActiveClass)) return;
        $(elm).parentsUntil(".multi-select-option-group").find(".muti-opt-head").addClass(ActiveClass).removeClass("mover").removeClass("normal");
    }
    this.showsubitems = function (elm) {
        JB.setTimeout(function (obj1) {
            var ActiveClass = _this.isProvinceLevelCity($(obj1).attr("data-posid")) ? "active2" : "active";
            if ($(obj1).parentsUntil(".multi-select-option-group").find(".muti-opt-head").is("." + ActiveClass)) return;
            $(obj1).parentsUntil(".multi-select-option-group").find(".muti-opt-head").addClass(ActiveClass).removeClass("mover").removeClass("normal");
            $(obj1).parent().parent().css("zIndex", "4");
            $(obj1).parent().css("zIndex", "5");
            if (!_this.isProvinceLevelCity($(obj1).attr("data-posid"))) $(obj1).parent().parent().append(_this.addSubMenu($(obj1).attr("data-posid"), $(obj1).attr("data-idx")));
        }, 100, elm);
    }
    this.show = function (elm) {
        _tempSelectedIds = JB.trim($(_objHiddenId).val());
        var htm = "<table style='width:" + _widths.main + "px;' id='" + _this.mainTableID + "' class='multi-select-main-table'><tr><td style='font-size:14px; vertical-align:top; line-height:30px; width:60px;background-color:#d9e9ff;'>已选中：</td><td style='padding-left:10px;text-align:left;background-color:#d9e9ff;' colspan='2'></td></tr>";
        var childs = GetAreas("0");  //参看area.js
        var i = 0;
        for (var j = 0; j < childs.length; j++) {
            if (j % 4 == 0) {
                if (j > 0) htm += "</td></tr>";
                htm += "<tr style='background-color:" + (parseInt(j / 4) % 2 == 0 ? "#fff" : "#eee") + "'><td colspan='2'>";
            }
            var chked = (_tempSelectedIds.indexOf(childs[j][2]) > 0) ? "checked" : "";
            var slcount = _tempSelectedIds.indexOf(childs[j][2].substr(0, 2)) == 0 ? "1" : "0";
            var isProvCity = _this.isProvinceLevelCity(childs[j][2]);
            var disab = (!isProvCity && !_canSelectProvince) ? "disabled" : "";
            //var chkedObj = _this.isProvinceLevelCity($(obj1).attr("data-posid")) ? "active2" : "active";
            var aDiv = "<div class='multi-select-option-group' onmouseover='" + _thisObjName + ".mouseovergroup(this)' onmouseout='" + _thisObjName + ".mouseoutgroup(this)' style='width:" + _widths.headGroup + "px;'>";
            aDiv += "<div style='position:relative; left:0px; top:0px; z-index:1;'>";
            aDiv += "<div class='muti-opt-head " + (slcount == "0" ? "normal" : "mover") + "' data-count='" + slcount + "' style='width:" + _widths.head + "px;'>";
            aDiv += "<table onclick='" + _thisObjName + ".showsubitems(this)' data-posid='" + childs[j][2] + "' data-idx='" + j + "'><tr><td class='icn'><input onmouseover='" + _thisObjName + ".mouseovergroupinput(this)' type='radio' " + chked + " " + disab + " value='" + childs[j][2] + "' onclick='" + _thisObjName + ".radioclick(this)'/><span>&nbsp;</span></td><td>" + childs[j][0] + "</td>";
            aDiv += "</tr></table>";
            aDiv += "</div></div></div>";
            htm += aDiv;
        }
        htm += "</td></tr>";
        htm += "</table>";
        _dialog.show(elm, htm, { title: _dialogTitle, modal: false, outerClickClose: true, hideOverfloat: false, pos: [{ to: "obj", parent: "doc", park: "outside", parkOutside: "topLeft" }, { to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft" }] });
        setTimeout(_this.updateSelectedView, 200); //必须延迟显示
    }
}

function SingleYearSelector(opts) {
    var _this = this;
    var _opts = opts || {};
    var _max = _opts.max || new Date().getFullYear();
    var _min = _opts.min || 1900;
    var _start = 0;
    var _thisObjName = _opts.objName;   //创建的对象名（方便编写代码而已，避免要使用对象绑定回调）
    var _objHiddenId = _opts.objHiddenId;
    var _selectElement = _opts.selectElement;
    var _textWhenEmpty = _opts.textWhenEmpty;
    var _dialogTitle = _opts.dialogTitle;
    var _dialog = new JBodyDialog();
    this.debug = _opts.debug || function () { };
    this.onchange = _opts.onchange || [function () { }];
    this.mainTableID = "multisltable" + JB.dateTimeToString(new Date(), "yyyyMMddHHmmssfff");
    var _elm = null;  //参照对象，show()方法传入的参数

    this.getValue = function () {
        return $(_objHiddenId).val();
    }
    this.hasValue = function () {
        return JB.trim(_this.getValue().replace(",", "")) != "";
    }
    this.setValue = function (v) {  //外部重设
        var chg = $(_objHiddenId).val() != v;
        $(_objHiddenId).val(v);
        _dialog.close();
        _this.update(chg);
    }
    this.update = function (change) {
        var year = JB.trim($(_objHiddenId).val());
        var htm = year;
        var names = year;
        var tts = year;
        if (htm == "") htm = _textWhenEmpty;
        $(_selectElement).get(0).options[$(_selectElement).get(0).length] = new Option(htm, $(_objHiddenId).val(), null, true);
        $(_selectElement).attr("title", names);
        if (change) for (var i = 0; i < _this.onchange.length; i++) _this.onchange[i]({ value: $(_objHiddenId).val(), names: names, tts: tts });
    }
    _this.update();
    this.set = function (v) {
        var chg = $(_objHiddenId).val() != v;
        $(_objHiddenId).val(v);
        _dialog.close();
        _this.update(chg);
    }
    this.close = function () {
        _dialog.close();
    }
    this.mover = function (elm) {
        JB.css(elm, "backgroundColor", elm.tagName.toLowerCase() == "div" ? "#47a7d6" : "#def4ff");
        JB.css(elm, "border", elm.tagName.toLowerCase() == "div" ? "solid 1px #0084c5" : "solid 1px #aee4ff");
    }
    this.mout = function (elm) {
        JB.css(elm, "backgroundColor", elm.tagName.toLowerCase() == "div" ? "#6cbde4" : "#fff");
        JB.css(elm, "border", elm.tagName.toLowerCase() == "div" ? "solid 1px #0084c5" : "solid 1px #fff");
    }
    this.showPrev = function () {
        _start = _start - 10;
        _this.showStart();
    }
    this.showNext = function () {
        _start = _start + 10;
        _this.showStart();
    }
    this.showStart = function () {
        var year = JB.trim($(_objHiddenId).val());
        var MSEVENT = " onmouseover='" + _thisObjName + ".mover(this)' onmouseout='" + _thisObjName + ".mout(this)' ";
        var htm = "<table style='width:200px;' id='" + _this.mainTableID + "'>";
        htm += "<tr><td>";
        if (_start > _min) htm += "<div style='float:left;width:48px;height:20px;line-height:20px;cursor:pointer;border:solid 1px #0084c5;background-color:#6cbde4;text-align:center;color:#fff;' " + MSEVENT + " onclick='" + _thisObjName + ".showPrev()'>上一页</div>";
        if (_start + 19 < _max) htm += "<div style='float:right;width:48px;height:20px;line-height:20px;cursor:pointer;border:solid 1px #0084c5;background-color:#6cbde4;text-align:center;color:#fff;' " + MSEVENT + " onclick='" + _thisObjName + ".showNext()'>下一页</div>";
        htm += "</td></tr><tr><td style='padding-top:3px;padding-bottom:8px;'>";
        for (var i = 0; i < 20; i++) {
            var eventAA = ((i + _start) >= _min && (i + _start) <= _max) ? ("" + MSEVENT + " onclick='" + _thisObjName + ".set(" + (_start + i) + ")'") : "";
            var styleA = ((i + _start) >= _min && (i + _start) <= _max) ? "cursor:pointer;" : "color:#ddd;";
            htm += "<span style='float:left;display:block;" + (((_start + i) + "") == year ? "font-weight:bold;color:#ff8d1b;" : "") + "width:48px;height:20px;line-height:20px;margin-top:5px;border:solid 1px #fff;text-align:center;" + styleA + "' " + eventAA + ">" + (_start + i) + "</span>";
        }
        htm += "</td></tr>";
        htm += "</table>";
        _dialog.show(_elm, htm, { title: _dialogTitle, modal: false, outerClickClose: true, hideOverfloat: false, pos: [{ to: "obj", parent: "doc", park: "outside", parkOutside: "topLeft" }, { to: "obj", parent: "doc", park: "outside", parkOutside: "bottomLeft" }] });
    }
    this.show = function (elm) {
        _elm = elm;
        var year = JB.trim($(_objHiddenId).val());
        var base = (year == "" ? new Date().getFullYear() : year);
        _start = base - (base % 10);
        _this.showStart();
    }
}

function MultiSubjectCreater(opts) {
    var _this = this;
    var _opts = opts || {};
    var _widths = {
        main: 880,
        headGroup: 205,
        head: 200,
        sub: 340,
        sub_item: 130
    };
    var _thisObjName = _opts.objName;   //创建的对象名（方便编写代码而已，避免要使用对象绑定回调）
    var _maxSelect = _opts.maxSelect || 2;
    var _objHiddenId = _opts.objHiddenId;
    var _selectElement = _opts.selectElement;
    var _textWhenEmpty = _opts.textWhenEmpty;
    var _canSelectTopLevel = JB.undef(_opts.canSelectTopLevel, true);  //是否可以选择顶层行业
    var _mode = JB.undef(_opts.mode, "single");  //单选或多选 single , multi
    if (_mode != "single") _mode = "multi";
    var _dialogTitle = _opts.dialogTitle;
    var _tempSelectedIds = "";
    var _dialog = new JBodyDialog();
    this.debug = _opts.debug || function () { };
    this.confirmCallback = _opts.confirmCallback || function () { };
    this.onchange = _opts.onchange || [function () { }];
    this.mainTableID = "multisltable" + JB.dateTimeToString(new Date(), "yyyyMMddHHmmssfff");
    this.getValue = function () {
        return $(_objHiddenId).val();
    }
    this.hasValue = function () {
        return JB.trim(_this.getValue().replace(",", "")) != "";
    }
    this.setValue = function (v) {  //外部重设
        var chg = $(_objHiddenId).val() != v;
        $(_objHiddenId).val(v);
        _dialog.close();
        _this.update(chg);
    }
    this.update = function (change, cb) {
        var subjs = GetSubjectsByIds(JB.trim($(_objHiddenId).val()), true);
        var htm = "";
        var names = "";
        var tts = "";
        for (var i = 0; i < subjs.length; i++) {
            htm += (i == 0 ? "" : "; ") + subjs[i][0];
            names += (i == 0 ? "" : "; ") + subjs[i][0];
            tts += subjs[i][0] + "\r\n";
            if (subjs.length > 4) {
                if (i > 4) continue;
                if (i >= 3) htm += "..等" + subjs.length + "项";
            }
        }
        if (htm == "") htm = _textWhenEmpty;
        //$(_selectElement).find("option").first().html(htm);
        //$(_selectElement).find("option").first().attr("title", names);
        //$(_selectElement).find("option").first().attr("value", $(_objHiddenId).val());
        $(_selectElement).get(0).options[$(_selectElement).get(0).length] = new Option(htm, $(_objHiddenId).val(), null, true);
        $(_selectElement).attr("title", names);
        $(_selectElement).parent().find("div").eq(1).width($(_selectElement).width());
        if (cb) _this.confirmCallback({ ids: $(_objHiddenId).val(), names: names });
        if (change) for (var i = 0; i < _this.onchange.length; i++) _this.onchange[i]({ value: $(_objHiddenId).val(), names: names, tts: tts });
    }
    _this.update();
    this.set = function () {
        var chg = $(_objHiddenId).val() != _tempSelectedIds;
        $(_objHiddenId).val(_tempSelectedIds);
        _dialog.close();
        _this.update(chg, true);
    }
    this.close = function () {
        _dialog.close();
    }
    this.cancel = function (elm, v) {
        $(elm).parent().remove();
        _tempSelectedIds = _tempSelectedIds.replace(',' + v + ',', "");
        $("input[value='" + v.substr(0, 2) + "00']").parent().parent().parent().find("input").each(function () {
            if (_tempSelectedIds.indexOf(',' + this.value.substr(0, 4)) >= 0) {
                $(this).parent().removeClass("multi");
                $(this).parent().addClass("multiChked");
                this.checked = true;
            } else {
                $(this).parent().removeClass("multiDisabChked");
                $(this).parent().removeClass("multiChked");
                $(this).parent().addClass("multi");
                this.checked = false;
            }
        });
        if (!(_tempSelectedIds.indexOf(',' + v.substr(0, 4)) >= 0)) {
            $(obj).removeClass("mover").addClass("normal");
            $(obj).attr("data-count", "0");
        }
    }
    this.updateSelectedView = function () {
        var subjs = GetSubjectsByIds(_tempSelectedIds, true);
        var htm = "";
        for (var i = 0; i < subjs.length; i++) {
            htm += "<div class='multi-select-selected'><span style='float:left;'>" + subjs[i][0] + "</span><span class='bt' title='移除' onclick=\"" + _thisObjName + ".cancel(this, '" + subjs[i][2] + "')\" ></span></div>";
        }
        if (subjs.length > 0) htm += "<div onclick='" + _thisObjName + ".set()' class=\"btn-3d btn-3d-orange btn-3d-mini floatL mginL05 mginT01\" style='float:left;'>确定</div>";
        $("#" + _this.mainTableID).find("td").eq(1).html(htm);
    }
    this.itemclick = function (elm) {
        if (_mode == "multi" && elm.className.indexOf("Disab") > 0) return;
        elm = $(elm).find("input").get(0);
        elm.checked = !elm.checked;  //反转选择
        if (_mode == "single") {
            _tempSelectedIds = "," + elm.value + ",";
            _this.set();
            return;
        }
        var ids = _tempSelectedIds + "";
        _tempSelectedIds = "";
        var c = 0;
        var parent = (elm.value.substr(2, 2) == "00") ? elm.value.substr(0, 2) : null;
        var idsss = ids.split(',');
        for (var j = 0; j < idsss.length; j++) {
            if (JB.trim(idsss[j]) != "" && idsss[j].substr(0, 2) != parent) {
                c++;
                _tempSelectedIds += ',' + idsss[j] + ',';
            }
        }
        if (elm.checked) {
            if (c >= _maxSelect) {
                alert("最多只能选" + _maxSelect + "项");
                elm.checked = false;
                return;
            }
            _tempSelectedIds += ',' + elm.value + ',';
            $(elm).parent().removeClass("multi");
            $(elm).parent().addClass("multiChked");
        } else {
            _tempSelectedIds = _tempSelectedIds.replace(',' + elm.value + ',', "");
            $(elm).parent().removeClass("multiChked");
            $(elm).parent().addClass("multi");
        }
        if (parent) {  //组
            $(elm).parent().parent().parent().find("input").each(function () {
                if (this != elm) {
                    $(this).attr("checked", elm.checked).attr("disabled", elm.checked);
                    if (elm.checked) {
                        $(this).parent().removeClass("multi");
                        $(this).parent().removeClass("multiChked");
                        $(this).parent().addClass("multiDisabChked");
                    } else {
                        $(this).parent().removeClass("multiDisabChked");
                        $(this).parent().addClass("multi");
                    }
                }
            });
        }
        _this.updateSelectedView();
    };
    this.show = function (elm) {
        var tp = (_mode == "single") ? "radio" : "checkbox";
        _tempSelectedIds = JB.trim($(_objHiddenId).val());
        var htm = "<table style='width:" + _widths.main + "px;' id='" + _this.mainTableID + "' class='multi-select-main-table'>";
        if (_mode != "single") htm += "<tr><td style='font-size:14px; vertical-align:top; line-height:30px; width:80px;background-color:#d9e9ff;'>已选中：</td><td style='padding-left:10px;text-align:left;background-color:#d9e9ff;' colspan='2'></td></tr>";
        var topsbjs = GetTopSubjects();  //参看subjects.js
        for (var i = 0; i < topsbjs.length; i++) {
            var chked = (_tempSelectedIds.indexOf(topsbjs[i][2]) > 0) ? "checked" : "";
            var action = chked == "" ? "" : "";
            var clss = _mode + (chked == "" ? "" : "Chked");
            htm += "<tr class='tr" + (i % 2) + "'><td style='width:180px;vertical-align:top;font-weight:bold; text-align:left;padding-left:2px;' " + (_mode != "single" ? " colspan='2'" : "") + ">";
            if (_canSelectTopLevel) htm += "<div class='item " + clss + "' onclick='" + _thisObjName + ".itemclick(this)' style='width:170px;'><input type='" + tp + "' " + chked + " value='" + topsbjs[i][2] + "'/>"
            htm += topsbjs[i][0];
            if (_canSelectTopLevel) htm += "</div>";
            htm += "</td><td>";
            var childs = GetSubjects(topsbjs[i][2]);
            for (var j = 0; j < childs.length; j++) {
                var disab = (_tempSelectedIds.indexOf(childs[j][2].substr(0, 2) + "00") > 0) ? "disabled" : "";
                chked = (disab != "" || _tempSelectedIds.indexOf(childs[j][2]) > 0) ? "checked" : "";
                clss = _mode + (disab == "" ? "" : "Disab") + (chked == "" ? "" : "Chked");
                var aDiv = "<div class='item " + clss + "' style='text-align:left;width:" + _widths.headGroup + "px;' onclick='" + _thisObjName + ".itemclick(this)'>";
                aDiv += "<input type='" + tp + "' " + chked + " " + disab + " value='" + childs[j][2] + "'/>" + childs[j][0] + "";
                aDiv += "</div>";
                htm += aDiv;
            }
            htm += "</td></tr>";
        }
        if (_mode != "single") htm += "<tr><td style='width:80px;'>&nbsp;</td><td style='width:100px;'>&nbsp;</td><td style='height:60px;'><div onclick='" + _thisObjName + ".set()' class=\"CommonButtonSmall CommonButtonOrange60\" style='float:left;'>确定</div><div onclick='" + _thisObjName + ".close()' class=\"CommonButtonSmall CommonButtonGray60\" style='float:left;margin-left:10px;'>取消</div></td></tr>";
        htm += "</table>";
        _dialog.show(elm, htm, { title: _dialogTitle + "（最多可选<span style='color:orange;'>" + _maxSelect + "</span>项）", modal: true, hideOverfloat: false, pos: { to: "win", parent: "doc" } });
        if (_mode != "single") _this.updateSelectedView();
        $(".item").mouseover(function () {
            if ($(this).is(".singleChked")) return;
            if ($(this).is(".multiDisabChked")) return;
            $(this).addClass("item-mover");
        }).mouseout(function () {
            $(this).removeClass("item-mover");
        });
    }



}
