var NAV = {
    show: function (parentNAV, items, list, index) {
        var jPrentNav = $(parentNAV), oDOMprent = jPrentNav.get(0);
        var oItems = jPrentNav.find(".NAV_MENU");
        var oLists = jPrentNav.find(list);
        var oitems = jPrentNav.find(items).eq(index);


        var oCurList = oLists.eq(index);
        oCurList.addClass('cur');
        oitems.addClass('on');

    },
    hide: function (parentNAV, items, list, index) {
        var jPrentNav = $(parentNAV), oDOMprent = jPrentNav.get(0);
        var oItems = jPrentNav.find(".NAV_MENU");
        var oLists = jPrentNav.find(list);
        var oitems = jPrentNav.find(items).eq(index);
        var oCurList = oLists.eq(index);
        oitems.removeClass('on')
        oCurList.removeClass('cur');
    }
}


$(".NAV .NAV_MENU").mouseenter(function () {

    NAV.show(".NAV", "h3.menu", "div.nav-head-menu", $(this).index(".NAV .NAV_MENU"));


}).mouseleave(function () {
    NAV.hide(".NAV", "h3.menu", "div.nav-head-menu", $(this).index(".NAV .NAV_MENU"));
})



$(".CRUMB-I > dt").mouseenter(function () {
    $(this).siblings('dl').show().end().addClass('cur');
    $(this).find("i:eq(0)").hide();
}).closest('.CRUMB-I').mouseleave(function () {
    $(this).find("i:eq(0)").show();
    $(this).find('dt').removeClass('cur').end().find('.NAV').hide();
})


$(".KEY-GUIDANCE").on('keyup focus click', function (event) {
    var key = event.which;
    var t = $(".TOSEARCH").find("input").val();
    var searchType = $(".TOSEARCH").find("input:hidden").val();

    if ($.inArray(key, [40, 38, 13]) >= 0 && event.type == 'keyup') return true;
    key = this.value;
    var dl = $(this).closest('dl'),
      dd = dl.find('dd'),
      tip = dd.find('.tip'),
      result = dd.find('.matches'),
      oDOMselect = $(this).closest(".SELECT").get(0);
    SELECT.open.call(oDOMselect);
    if (!key) { //无关键字则收回提示及匹配
        if (searchType == 2) tip.html('↑请输入相关学校名称').show();
        else tip.html('↑请输入相关专业名称').show();
        result.hide();
        return true;
    }
    if (searchType == 1) {
        if (typeof GetPositionsByKeywords == 'undefined') {
            alert('缺少包含文件jobPositions.js');
            return false;
        }
        var jobs = GetPositionsByKeywords(key), count = jobs.length;
        if (count) {//最大选项数，如果不设置则显示全部
            var matches = dl.data("matches"), str = [];
            if (!matches) matches = count;
            var over = Math.min(matches, count);
            for (var n = 0; n < over; n++) {
                var job = jobs[n][0], id = jobs[n][2];
                str.push('<a href="javascript:void(0)" title="', job, '" data-id="', id, '">', job, '</a>');
            }
            result.html(str.join('')).show();
            tip.hide();
            console.log(result)
        }
        else {//修改提示
            //tip.html('对不起，找不到符合'+ key +'的职位').show();
            result.hide();
            SELECT.close.call(oDOMselect, true);
        }
    }
    else {
        result.hide();
        SELECT.close.call(oDOMselect, true);
    }
});


$(function () {
    if (typeof (CHIfloat) != 'undefined' && isIE6())
        CHIfloat(
          ".TOOL",
          {
              bottom: 0,
              right: function () {
                  var width = $(".TOOL").outerWidth(),
                    ww = $(window).width()
                  if (ww < 1060 + parseInt(width * 2)) return 0;
                  else return Math.floor((ww - 1060) / 2 - width);
              }
          }
        );
    else {
        $(window).on('load resize', function () {
            $(".TOOL").css({
                right: function () {
                    var width = $(".TOOL").outerWidth(),
                      ww = $(window).width()
                    if (ww < 1060 + parseInt(width * 2)) return 0;
                    else return Math.floor((ww - 1060) / 2 - width);
                }
            });
        });
    }
})
$(window).on('load scroll', function () {
    $(".TOOL").css('visibility', ($(window).scrollTop() ? 'visible' : 'hidden'))
})