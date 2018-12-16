

//设定平台后台的JBodyDialog的统一样式
JBodyDialogDefaultSetting = {
    colors: [/*border*/"#aaaaaa", /*bg*/"#ffffff", /*titleBg*/"url(/images/jbody/jbdialog/winTitleBg.png) 10px -102px no-repeat #ddd", /*title*/"#0153be", /*win*/"#333333", /*titleBorder*/"#aaaaaa", /*alphaBorder*/"#dddddd", /*shadow*/"#bbbbbb", /*modal*/"#bbbbbb"],
    btcolors: ["#333333", "#6eabfc", "#6eabfc", "#ffffff", "#005cd5", "#005cd5"],  //0,1bg,2bd:mouseout   3,4bg,5bd:mouseover
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
function trHoverOut(obj) {
    if ($(obj).get(0).className.indexOf("msover") >= 0) $(obj).removeClass("msover");
    else $(obj).addClass("msover");
}