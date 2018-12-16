function pageTabMenus(options) {
    options = options || {};
    if (!options.obj) return;
    if (typeof (options.obj) == "string") options.obj = document.getElementById(options.obj);
    if (!options.obj) return;
    options.tag = options.tag || "a";
    options.attrStart = options.attrStart || "href=\"";
    options.attrEnd = options.attrEnd || "\"";
    options.menus = options.menus || [];
    options.classItem = options.classItem || "menuItem";
    options.classActive = options.classActive || "menuActived";
    options.classTitle = options.classTitle || "menuTitle";
    options.menus = options.menus || [];
    options.activeIndex = options.activeIndex || -1;
    options.activeText = options.activeText || "";
    options.data = options.data || [];
    var str = "";
    var notEmptyStr = function (v) {
        if (!v || v == "" || JB.trim(v) == "") return null;
        return JB.trim(v);
    }
    var findAct = false;
    for (var i = 0; i < options.menus.length; i++) {
        if (options.menus[i][0] == "") continue;
        var txt = options.menus[i][0];
        var attr = options.menus[i][1];
        for (var j = 0; j < 20; j++) {
            txt = txt.replace("{" + j + "}", options.data[j] || "");
            attr = attr.replace("{" + j + "}", options.data[j] || "");
        }
        if (i == 0) str += "<span class=\"" + options.classTitle + "\">&nbsp;" + txt + "</span>";
        else if (attr == "htm" || attr == "html") str += txt;
        else {
            if (attr == "") attr = "#";
            var act = (i == options.activeIndex || txt == options.activeText);
            findAct = findAct || act;
            str += "<" + options.tag + " class=\""
                + (act ? options.classActive : options.classItem) + "\" "
                + options.attrStart + attr + options.attrEnd + ">" + txt + "</" + options.tag + ">";
        }
    }
    if (!findAct && options.activeText != "") str += "<" + options.tag + " class=\""
                + options.classActive + "\">" + options.activeText + "</" + options.tag + ">";
    options.obj.innerHTML = str;
    options.obj.style.display = "block";
}

function stepTabMenus(elm, arr, step) {
    if (typeof (elm) == "string") elm = document.getElementById(elm);
    if (elm == null) return;
    var str = "<table class=\"stepTabContainer\"><tr>";
    //str += "<td class=\"stepTabBg " + (step > 1 ? "stepTab01" : "stepTab02") + "\">&nbsp;</td>";
    for (var i = 1; i <= arr.length; i++) {
        str += "<td class=\"" + (step == i ? "stepTabActived" : "stepTab") + "\">" + arr[i - 1] + "</td>";
        if (i < arr.length) str += "<td class=\"stepTabBg " + ((step == i) ? "stepTab21" : (step == i + 1) ? "stepTab12" : "stepTab11") + "\">&nbsp;</td>";
    }
    //str += "<td class=\"stepTabBg " + (step < arr.length ? "stepTab10" : "stepTab20") + "\">&nbsp;</td>";
    elm.innerHTML = str;
    elm.style.display = "block";
}