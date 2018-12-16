
function SetMainMenu(opt) {
    var itemList = $("#pg-nav ul li").get();
    var idx = -1;
    if (opt.text) {
        for (var i = 0; i < itemList.length; i++) if ($(itemList[i]).text() == opt.text) {
            idx = i;
        }
    }
    if (idx < 0 && opt.index >= 0) idx = opt.index;
    if (itemList.length > idx) $("#pg-nav ul li").eq(idx).addClass("active");
}