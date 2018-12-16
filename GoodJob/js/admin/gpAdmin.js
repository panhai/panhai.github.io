var pageTabMenusArray = new Array();
pageTabMenusArray[0] = [["{0}", "#"],
            ["院校资料", "Default.phtml?id={1}"],
            ["院校介绍", "Introduce.phtml?id={1}"],
            ["管理员角色", "CustmRoles.phtml?id={1}"],
            ["管理员", "Users.phtml?id={1}"],
            ["求职学生", "Introduce.phtml?id={1}"],
            ["特聘导师", "Introduce.phtml?id={1}"],
            ["合作企业", "Introduce.phtml?id={1}"],
            ["正在招聘", "Introduce.phtml?id={1}"]];
pageTabMenusArray[1] = [["{0}", "#"],
            ["企业资料", "Default.phtml?id={1}"],
            ["企业介绍", "Intro.phtml?id={1}"],
            ["管理员角色", "CustmRoles.phtml?id={1}"],
            ["管理员", "Users.phtml?id={1}"],
            ["合作院校", "Schools.phtml?id={1}"],
            ["正在招聘", "Jobs.phtml?id={1}"]];

//设定平台后台的JBodyDialog的统一样式
JBodyDialogDefaultSetting = {
    colors: [/*border*/"#aaaaaa", /*bg*/"#ffffff", /*titleBg*/"url(/images/jbody/jbdialog/winTitleBg.png) 10px -58px no-repeat #ddd", /*title*/"#008c81", /*win*/"#333333", /*titleBorder*/"#aaaaaa", /*alphaBorder*/"#dddddd", /*shadow*/"#bbbbbb", /*modal*/"#bbbbbb"],
    btcolors: ["#333333", "#92ccc7", "#78beb8", "#ffffff", "#45b7ae", "#25aca1"],  //0,1bg,2bd:mouseout   3,4bg,5bd:mouseover
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