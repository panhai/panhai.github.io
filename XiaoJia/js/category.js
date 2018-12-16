//0类别名称 1父ID 2类别ID 3排序号 4是否启用
var categoryArray = [
    ["外语/小语种", 0, 1000, 0, 1],
    ["成人英语", 1000, 1001, 0, 1],
    ["少儿英语", 1000, 1002, 0, 1],
    ["出国语言", 1000, 1003, 0, 1],
    ["小语种", 1000, 1004, 0, 1],
    ["电脑/IT/设计", 0, 1005, 0, 1],
    ["电脑设计", 1005, 1006, 0, 1],
    ["IT考证", 1005, 1007, 0, 1],
    ["程序开发", 1005, 1008, 0, 1],
    ["办公软件", 1005, 1009, 0, 1],
    ["淘宝电商", 1005, 1010, 0, 1],
    ["职业技能", 0, 1011, 0, 1],
    ["餐饮", 1011, 1012, 0, 1],
    ["美业/保健", 1011, 1013, 0, 1],
    ["服装", 1011, 1014, 0, 1],
    ["技能维修", 1011, 1015, 0, 1],
    ["模具数控", 1011, 1016, 0, 1],
    ["口才/素质训练", 1011, 1017, 0, 1],
    ["驾驶考证", 1011, 1018, 0, 1],
    ["电工/特殊工种/其他", 1011, 1019, 0, 1],
    ["学历教育", 0, 1020, 0, 1],
    ["中专/技校", 1020, 1021, 0, 1],
    ["成人学历", 1020, 1022, 0, 1],
    ["在职研究生", 1020, 1023, 0, 1],
    ["考研", 1020, 1024, 0, 1],
    ["出国留学", 1020, 1025, 0, 1],
    ["资格考证", 0, 1026, 0, 1],
    ["财会金融", 1026, 1027, 0, 1],
    ["工程/建筑类", 1026, 1028, 0, 1],
    ["管理/贸易类", 1026, 1029, 0, 1],
    ["医学/保健类", 1026, 1030, 0, 1],
    ["其他职业资格", 1026, 1031, 0, 1],
    ["文体艺术", 0, 1032, 0, 1],
    ["竞技拳术", 1032, 1033, 0, 1],
    ["体育球类", 1032, 1034, 0, 1],
    ["形体舞蹈", 1032, 1035, 0, 1],
    ["声乐类", 1032, 1036, 0, 1],
    ["美术艺术", 1032, 1037, 0, 1],
    ["文娱表演", 1032, 1038, 0, 1],
    ["基础教育", 0, 1039, 0, 1],
    ["学前教育", 1039, 1040, 0, 1],
    ["K12辅导", 1039, 1041, 0, 1],
    ["复读", 1039, 1042, 0, 1],
    ["冬夏令营", 1039, 1043, 0, 1],
    ["其他类别", 0, 1044, 0, 1],
    ["公务员", 1044, 1045, 0, 1],
    ["企业内训", 1044, 1046, 0, 1],
];

function GetCategory(id) {
    for (var i = 0; i < categoryArray.length; i++) {
        if (categoryArray[i][2] == id) {
            return categoryArray[i];
        }
    }
    return null;
}

function GetRootCategorys() {
    var categorys = new Array();
    for (var i = 0; i < categoryArray.length; i++) {
        if (categoryArray[i][1] == 0) {
            categorys.push(categoryArray[i]);
        }
    }
    return categorys;
}

function GetCategorys(id) {
    var categorys = new Array();
    for (var i = 0; i < categoryArray.length; i++) {
        if (categoryArray[i][1] == id) {
            categorys.push(categoryArray[i]);
        }
    }
    return categorys;
}

function GetCategoryName(id) {
    var subj = GetCategory(id);
    if (subj == null) return "";
    return subj[0];
}

function GetCategorysByIds(ids) {
    var categorys = new Array();
    for (var i = 0; i < categoryArray.length; i++) {
        var pt = new RegExp(categoryArray[i][1]);
        if (categoryArray[i][1] != "0" && pt.test(ids)) {
            categorys.push(categoryArray[i]);
        }
    }
    return categorys;
}

function GetCategorysByNames(names) {
    var categorys = new Array();
    if (!names.pop) names = [names];
    for (var i = 0; i < categoryArray.length; i++) {
        for (var j = 0; j < names.length; j++) {
            if (categoryArray[i][0].toLowerCase() == names[j].toLowerCase()) categorys.push(categoryArray[i]);
        }
    }
    return categorys;
}

function GetCategorysByName(name) {
    if (name == '') return null;

    var categorys = new Array();
    for (var i = 0; i < categoryArray.length; i++) {
        if (categoryArray[i][0].toLowerCase() == name.toLowerCase()) {
            return categoryArray[i];
        }
    }

    return null;
}

function GetCategorysByRegexp(pattern) {
    var categorys = new Array();
    var pt = new RegExp(pattern, "i");
    for (var i = 0; i < categoryArray.length; i++) {
        if (categoryArray[i][5] == "")
            continue;
        if (pt.test(categoryArray[i][0])) {
            categorys.push(categoryArray[i]);
            continue;
        }
        if (pt.test(categoryArray[i][5])) {
            categorys.push(categoryArray[i]);
            continue;
        }
    }

    return categorys.sort(compare);

    function compare(a, b) {
        return a[5] > b[5];
    }
}

$(".CATEGORY").each(function () {
    $(this).attr("readonly", "readonly");
    var hid = $(this).siblings("input[type=hidden]");
    var selIds = null;
    var html = "";
    var selHtml = "";
    var categoryHtml = '<div class="job-menu"><div class="job-box">';
    if (hid.val()) {    //如果有选中需要初始化选中
        selIds = hid.val().split(",");
        $(selIds).each(function () {
            var category = GetCategory(this);
            selHtml += ' <a href="javascript:void(0)" data-id=' + this + '>' + category[0] + '</a>';
        });
    }

    var rootCategory = GetRootCategorys();
    for (var i = 0; i < rootCategory.length; i++) {
        var childs = GetCategorys(rootCategory[i][2]);
        categoryHtml += ' <div class="job-name"> ' + rootCategory[i][0] + '</div>';
        categoryHtml += '<div class="job-data">';
        for (var j = 0; j < childs.length; j++) {
            if (selIds) {
                if (selIds.indexOf(childs[j][2].toString()) != -1) {
                    categoryHtml += '<a href="javascript:void(0)" class="cur" data-id=' + childs[j][2] + '>' + childs[j][0] + '</a>';
                } else {
                    categoryHtml += '<a href="javascript:void(0)" class="" data-id=' + childs[j][2] + '>' + childs[j][0] + '</a>';
                }
            } else {
                categoryHtml += '<a href="javascript:void(0)" class="" data-id=' + childs[j][2] + '>' + childs[j][0] + '</a>';
            }
        }
        categoryHtml += ' </div>';
    }

    html += '<div class="theme-big-selectbox" style="display: none;">';
    html += '<div class="selected">';
    html += '<span>已选：</span>';
    html += '<div class="selected-box">';
    html += selHtml;
    html += ' </div>';
    html += ' <div class="subbtn">';
    html += ' <a href="javascript:void(0)" class="cur confirm">确认</a>';
    html += ' <a href="javascript:void(0)" class=cancel>取消</a>';
    html += ' </div>';
    html += ' </div>';
    html += categoryHtml;
    html += ' </div>';
    html += ' </div>';
    html += ' </div>';
    $(this).after(html);

    if (selHtml) {
        $(this).val($(this).siblings(".theme-big-selectbox").find(".selected-box a").map(function () { return $(this).text() }).get().join());
    }
});

var CATEGORY = {
    init: function () {
        var self = $(this);
        var container = $(this).siblings(".theme-big-selectbox");
        var hid = $(this).siblings("input[type=hidden]");
        self.click(function (e) {
            e.stopPropagation();            container.show()
        });

        $(document).click(function () {
            container.hide()
        });

        container.click(function (e) {
            e.stopPropagation()
        })

        container.find(".confirm").click(function () {
            self.val($(".selected-box a", container).map(function () { return $(this).text() }).get().join());
            hid.val($(".selected-box a", container).map(function () { return $(this).data("id") }).get().join());

            container.hide();
        });

        //选择/取消选择
        $(".job-data a", container).click(function () {
            var id = $(this).data("id");
            var text = $(this).text();
            if ($(this).hasClass("cur")) {
                $(this).removeClass("cur");
                $(".selected-box a[data-id=" + id + "]", container).remove();
            } else {
                if (self.data("selmax") && $(".selected-box a", container).length >= self.data("selmax")) {
                    alert("最多只能选择" + self.data("selmax") + "项");
                    return;
                }
                $(this).addClass("cur");
                $(".selected-box", container).append('<a href="javascript:void(0)" data-id=' + id + '>' + text + '</a>');
            }
        });

        container.find(".cancel").click(function () {
            container.hide();
        });
    }
};

$(".CATEGORY").each(function () {
    CATEGORY.init.call(this);
});
