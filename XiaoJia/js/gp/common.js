(function () {
    //设置菜单
    window.pageMenu = new (function () {
        var _this = this;
        this.setActive = function (option) {
            option = option || {};
            _this.mainText = option.mainText || null;
            _this.subText = option.subText || null;
            var i = 0;
            $("#mainMenu nav li").each(function () {
                if ($("a", this).text() == option.mainText) {
                    $(this).addClass("cur");
                    var menu = $("menu:eq(" + i + ")");
                    if (menu.children().length > 0) { menu.removeClass("hidden"); }
                    if (option.subText) {
                        $("li", menu).each(function () {
                            if ($("a", this).text() == option.subText) {
                                $(this).addClass("cur");
                                return false;
                            }
                        });
                    }
                    return false;
                }
                i++;
            });
        }

        return this;
    })();
})();