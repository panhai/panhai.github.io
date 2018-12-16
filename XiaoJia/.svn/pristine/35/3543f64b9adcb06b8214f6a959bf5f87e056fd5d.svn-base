/*
* @Author: Marte
* @Date:   2016-12-09 15:16:33
* @Last Modified by:   Marte
* @Last Modified time: 2016-12-12 11:21:50
*/

/*
初始化所有自定义下拉列表的基本行为
所有含类.SELECT的DL元素
    可以附加data-active='click'|'mouseenter'，改变下拉列表的激活行为，默认为click
    可以附加data-delay='毫秒数'，改变下拉列表的收回延迟，默认为300
    可以附加data-choices='正整数'，改变下拉列表的最大选项，默认为1，设置成0的话则无限制
        多选模式，要指定
        .SELECT-CHOICES，选项容器的类名，此容器内的所有a才会被当作是可选选项
        .SELECT-COLLECTOR，采集容器的类名，此容器内的所有a被当成已选项
    可以附加data-placeholder='字符串'，改变下拉列表无选项时的提示，相当于placeholder属性，默认为'请选择'
    可以附加data-leave='close'|'egnore'，改变下拉列表失去鼠标指向时的行为，默认为'close'
    可以附加data-anchor='save'，保留链接地址，默认会将a元素的href设置成void0，如果设置在a标签上，保留该a标签的链接地址
    可以附加data-empty='init'|'egnore'，当初始的隐藏域值为空时，也会初始化列表，为egnore时会留空列表头
    可以附加data-type='id'|'string'，列表的数据类型，默认是id，还可以是字符串类型的值
    可以附加data-autofill='intFrom,intTo,intStep[,fillBit]'，数字型列表，可以自动填充选项，直接生成a标签放入.SELECT-CHOICES中（或直接放入dd中），第四参如果是正整数则用来限制左补零补位
    可以附加data-child='下级的JQ选择器字符串'，当本级被点击时，可以自动展开下级下拉列表
    可以附加data-options='外露的选项数量'，当只使用一列时使用，默认为0不限制，超出选项数量显示滚动条
    可以附加data-trigger='一个选择器'，在可输入匹配列表中，如果列表匹配项未展开时，触发本选择器对应元素的click事件
    可以附加data-close='egnore'，失去鼠标指向时的行为，默认为空，用于解决因选项动态变化导致失去鼠标自动关闭的问题，需用延时器清除此值，否则会影响控件自动关闭功能
    可以附加data-custom='false'，是否添加自定义功能输入
     可以附加data-unit='岁'，添加自定义输入时的单位，如，元、岁
DL中要包含一个input[type=hidden]元素，来存放选项的ID或ID列表，如果不保存则不需要
DT元素中可以包含
    span，默认提示，相当于placeholder属性，会显示成浅一些的字
    b，选项，被选择的选项的显示内容，与input[type=hidden]一一对应
    i，箭头，装饰用
    input:text，输入框，有些下拉列表是带有关键字搜索的功能
DD元素中可以包含
    a，每一个a都是一个选项，无论是否复选，a标签上必须附加上data-id=""
    当a被选中时，会附加一个类.checked，来标识选中的项目
    其它标签可用作特殊格式的布局元素，但不可作为选项
*/
/*
所有的SELECT的通用方法，使用命名空间，以防污染
里边的所有this都要代表DL.SELECT的DOM对象
    .text(str)，设置列表头的文字内容
    .id(id)，设置隐藏域的id
    .reset()，重置下拉列表为默认提示
    .open()，下拉列表展开
    .close(bAtonce)，下拉列表关闭，bAtonce=true时立即关闭，忽略延时
    .void0()，将所有的选项的href都置为void(0)
    .value()，以隐藏域的值来初始化自身（dt内容及dd中被选项）
    .init()，初始化列表
在dt的input:text上
    可以附加data-list='arrow'，给input加键盘监听，监听上下箭头及回车键
在dd内对应的选项容器元素上
    附加data-list='datas'，将键盘监听指定到此列表的选项上
    上下箭头用于调节选中项目的位置，回车则等于点击选项
*/

//行业选项初始化
window.initSubject = function () {
    if ($('.PROFESSIONS').length == 0 || typeof subjectArray == 'undefined') return false;
    $('.PROFESSIONS').each(function () {
        var table = $(this).find('table').prop("outerHTML");
        $(this).html("");
        $(this).append(table);
    });

    var str = [], roots = GetTopSubjects();
    for (var i = 0; i < roots.length; i++) {
        str.push('<li' + (i == 0 ? ' class="cur"' : '') + '><p class="industry_title">', roots[i][0].replace(/\//g, '　'), '</p><div class="industry_tag">');
        var kids = GetSubjects(roots[i][2]);
        for (var a = 0; a < kids.length; a++) {
            str.push('<a data-id="', kids[a][2], '" href="javascript:void(0)">', kids[a][0], '</a>')
        }
        str.push('</div></li>');
    }
    $('.PROFESSIONS').append('<div class="industry_plug"><ul class="industrylist">' + str.join('') + '</ul></div>');
    $('.PROFESSIONS li').mouseenter(function () {
        $(this).addClass('cur').siblings('li').removeClass('cur');
    });
}

window.initSubject();

//岗位类型初始化
(function () {
    if ($('.JOBPOSITIONS').length == 0 || typeof positionArray == 'undefined') return false;
    var strTitle = [], strContent = [], roots = GetTopPositions();
    for (var i = 0; i < roots.length; i++) {
        strTitle.push('<li' + (i == 0 ? ' class="cur"' : '') + '>', roots[i][0].replace(/\|/g, '/'), '</li>');

        strContent.push('<div class="jobdiv"' + (i == 0 ? ' style="display:block;"' : '') + '>');
        var kids = GetPositions(roots[i][2]);
        for (var a = 0; a < kids.length; a++) {
            strContent.push('<div class="jobline">', '<h6>' + kids[a][0] + '</h6>', '<p>');

            var pos = GetPositions(kids[a][2]);
            for (var b = 0; b < pos.length; b++) {
                strContent.push('<a href="javascript:void(0)" data-id="' + pos[b][2] + '" title="' + pos[b][2] + '">' + pos[b][0] + '</a>');
            }

            strContent.push('</p></div>');
        }
        strContent.push('</div>');
    }

    $('.JOBPOSITIONS').html('<div class="joblist_plug"><ul class="big_type">' + strTitle.join('') + '</ul><div class="detail_type">' + strContent.join('') + '</div><div class="clear"></div></div>');
    $('.JOBPOSITIONS .big_type li').mouseenter(function () {
        var index = $(this).index();
        $(this).addClass('cur').siblings('li').removeClass('cur');
        $(this).closest('ul').siblings('.detail_type').find('.jobdiv:eq(' + index + ')').show().siblings().hide();
    });
})();

//区域选项初始化
//.CITY存在以下类时可选择不限：PROVINCEALL:省份-不限 CITYALL:城市-不限 REGIONALL:行政区-不限
//.CITY存在data-level可设置显示级别(1省 2市 3区)，默认为3
(function () {
    if ($('.CITY').length == 0 || typeof areaArray == 'undefined') return false;
    var str = [], roots = GetProvinces();

    roots.sort(function (a, b) {
        return a[4] < b[4] ? -1 : a[4] == b[4] ? 0 : 1;
    });

    $('.CITY').map(function () {
        if ($(this).data('level') == 1) {
            str = '<div class="City_list">\
                    <div class="type_list">\
                        <div class="letter_list provinces show">\
                        </div>\
                    </div>\
                </div>';
        } else if ($(this).data('level') == 2) {
            str = '<div class="City_list">\
                    <p class="region_type">\
                        <span class="provinceTitle cur">省份</span>\
                        <span class="cityTitle">城市</span>\
                    </p>\
                    <div class="type_list">\
                        <div class="letter_list provinces show">\
                        </div>\
                        <div class="option_list cities">\
                        </div>\
                    </div>\
                </div>';
        } else {
            str = '<div class="City_list">\
                    <p class="region_type">\
                        <span class="provinceTitle cur">省份</span>\
                        <span class="cityTitle">城市</span>\
                        <span class="regionTitle">区县</span>\
                    </p>\
                    <div class="type_list">\
                        <div class="letter_list provinces show">\
                        </div>\
                        <div class="option_list cities">\
                        </div>\
                        <div class="option_list region">\
                        </div>\
                    </div>\
                </div>';
        }

        $(this).append(str);
    });

    //省份-不限
    $('.CITY.PROVINCEALL .provinces').append('<div class="groupLine"><h4><a data-id="" href="javascript:void(0)">不限</a></h4><div class="clear"></div></div>');

    var prefix = ['a-g', 'h-k', 'l-s', 't-z'];
    for (var i = 0; i < prefix.length; i++) {
        var arr = prefix[i].split('-');
        var cont = '<div class="groupLine"><h4>' + prefix[i].toUpperCase() + '</h4><p>';
        for (var j = 0; j < roots.length; j++) {
            if (roots[j][4][0] >= arr[0] && roots[j][4][0] <= arr[1]) {
                cont += '<a data-id="' + roots[j][2] + '" href="javascript:void(0)">' + roots[j][0] + '</a>';
            }
        }
        cont += '</p><div class="clear"></div></div>';

        $('.CITY .provinces').append(cont);
    }

    //不触发选项选中事件
    $('.CITY').closest('.SELECT').data('anchor', 'save');

    //切换省市区
    $('.CITY .region_type span').click(function () {
        var container = $(this).closest('.region_type').siblings('.type_list').find('>div').eq($(this).index());
        if ($(container).find('a').length) {
            container.show().siblings().hide();
            $(this).addClass('cur').siblings().removeClass('cur');
        }
    });

    //选择省份
    $('.CITY .provinces a').click(function () {
        var container = $(this).closest('.provinces').siblings('.cities'),
              cities = GetAreas($(this).data('id'));
        $(this).closest('.provinces').siblings('.cities,.region').empty();

        if ($(this).data('id') == '') {
            SELECT.reset.call($(this).closest('.SELECT'), true);
            SELECT.close.call($(this).closest('.SELECT'), true);
        } else if ($(this).closest('.CITY').data('level') == 1 || cities.length == 0) {
            var id = $(this).data('id'),
                name = $.trim($(this).text()),
                select = $(this).closest('.SELECT');

            SELECT.text.call(select, name, { focus: true });
            SELECT.id.call(select, id);

            SELECT.close.call(select, true);
        } else {
            if ($(this).closest('.CITY').hasClass('CITYALL')) {
                container.append('<a data-id="0" href="javascript:void(0)">不限</a>');
            }

            for (var i = 0; i < cities.length; i++) {
                container.append('<a data-id="' + cities[i][2] + '" data-pid="' + cities[i][1] + '" href="javascript:void(0)">' + cities[i][0] + '</a>')
            }

            container.closest('.City_list').find('.cityTitle').click();

            //记录选中值
            $(this).closest('.provinces').data('id', $(this).data('id')).data('name', $.trim($(this).text()));

            //通过设置局部属性跳过mouseleave事件，然后延迟时间清除掉局部属性
            var sel = $(this).closest('.SELECT');
            sel.data('close', 'egnore');
            setTimeout(function () {
                sel.data('close', '');
            }, 100);
        }

    });

    //选择城市
    $('.CITY .cities').on('click', 'a', function () {
        var container = $(this).closest('.cities').siblings('.region'),
            areas = GetAreas($(this).data('id'));
        var pid = $(this).data("id");

        container.empty();
        if ($(this).data('id') == '0') {

            var id = $(this).closest('.cities').siblings('.provinces').data('id');
            name = $(this).closest('.cities').siblings('.provinces').data('name');
            var select = $(this).closest('.SELECT');

            SELECT.text.call(select, name, { focus: true });
            SELECT.id.call(select, id);
            SELECT.close.call($(this).closest('.SELECT'), true);
        } else if ($(this).closest('.CITY').data('level') == 2 || areas.length == 0) {//如果指定只选择到市或者没有下辖区则直接选中该区
            var id = $(this).data('id'),
                name = $(this).closest('.cities').siblings('.provinces').data('name') + $.trim($(this).text()),
                select = $(this).closest('.SELECT');

            SELECT.text.call(select, name, { focus: true });
            SELECT.id.call(select, id);

            SELECT.close.call(select, true);
        } else {
            if ($(this).closest('dd').hasClass('areaSEL')) {
                var regionlist = '';
                for (var i = 0; i < areas.length; i++) {
                    regionlist += ('<a data-id="' + areas[i][2] + '" href="javascript:void(0)">' + areas[i][0] + '</a>');
                }
                var regiondiv = '<div class="Multiselect"><p class="multilist "><a href="javascript:void(0)" data-id="0" class="unlimited">不限</a></p><p class="multilist state">'
                                + regionlist + '</p><p class="option_btn"><input type="button" value="确认" class="c_confirm" /><span class="c_cancel">取消</span></p></div>';
                container.append(regiondiv);
            } else {
                if ($(this).closest('.CITY').hasClass('REGIONALL')) {
                    container.append('<a data-id="0" href="javascript:void(0)">不限</a>');
                }

                for (var i = 0; i < areas.length; i++) {
                    container.append('<a data-id="' + areas[i][2] + '" data-pid="' + areas[i][1] + '" href="javascript:void(0)">' + areas[i][0] + '</a>')
                }
            }
            container.closest('.City_list').find('.regionTitle').click();

            //记录选中值
            $(this).closest('.cities').data('id', $(this).data('id')).data('name', $.trim($(this).text()));

            //通过设置局部属性跳过mouseleave事件，然后延迟时间清除掉局部属性
            var sel = $(this).closest('.SELECT');
            sel.data('close', 'egnore');
            setTimeout(function () {
                sel.data('close', '');
            }, 100);
        }
    });

    //选择区县
    $('.CITY .region').on('click', 'a', function () {

        if ($(this).closest('dd').hasClass('areaSEL')) {
            $(this).closest('dl').data('anchor', 'save');
            if ($(this).hasClass('unlimited')) {
                $(this).addClass('cur');
                $(this).parent().siblings('.state').children().removeClass('cur');
            } else {
                if ($(this).hasClass('cur')) {
                    $(this).removeClass('cur');
                } else {
                    $(this).addClass('cur');
                }
                $(this).parent().siblings('.multilist').children().removeClass('cur');
            }
            $(this).closest('.Multiselect').find('.option_btn .c_confirm').click(function () {
                var select = $(this).closest('.SELECT');
                var alist = select.find('a.cur');
                var idlist = '';
                var namelist = '';
                var name = $(this).closest('.region').siblings('.provinces').data('name')
                    + $(this).closest('.region').siblings('.cities').data('name');
                select.find('a.cur').each(function () {
                    if ($(this).hasClass('unlimited')) {
                        idlist = $(this).closest('.region').siblings('.cities').data('id') + ',';
                        return;
                    } else {
                        idlist += $(this).attr('data-id') + ',';
                        namelist += $(this).html() + '、';
                    }
                });
                idlist = idlist.substring(0, idlist.length - 1);
                namelist = namelist.substring(0, namelist.length - 1);

                SELECT.text.call(select, name + namelist, { focus: true });
                SELECT.id.call(select, idlist);

                SELECT.close.call(select, true);
            });
            $(this).closest('.Multiselect').find('.option_btn .c_cancel').click(function () {
                $(this).closest('.SELECT').removeClass('SELECT-on');
            });

        } else {

            var id = $(this).data('id'),
                name = $(this).closest('.region').siblings('.provinces').data('name')
                    + $(this).closest('.region').siblings('.cities').data('name'),
                select = $(this).closest('.SELECT');

            if (id == '0') {
                id = $(this).closest('.region').siblings('.cities').data('id');
            } else {
                name += $.trim($(this).text());
            }

            SELECT.text.call(select, name, { focus: true });
            SELECT.id.call(select, id);

            SELECT.close.call(select, true);
        }
    });
})();

//地名联动
//地名下拉列表，需要有类ADDRESS，目前的地址列表一律为普通列表
//可以使用在dl上的配置有
//data-parent="唯一的JQ选择器字符串"，上级下拉列表的选择器，会自动根据上级的当前选项初始化本级下拉列表的选项
//*****当有data-child配置时，本级地址改变，会自动初始化对应的下级列表，更下级的被置空
//data-unlimit="true|false"，是否含有“不限”选项，默认为false
(function () {
    //将地址数组填充到列表中
    function fill(arrayAreas) {
        if (!arrayAreas.length) {
            $(this).find("dd").empty();
            return;
        }

        var str = [],
			unlimit = $(this).data('unlimit');

        if ($(this).data("multiple")) {
            for (var i = 0; i < arrayAreas.length; i++) {
                str.push('<label><input type="checkbox"><a data-id="', arrayAreas[i][2], '">', arrayAreas[i][0], '</a></label>');
            }
            unlimit && str.unshift('<label><input type="checkbox"><a data-id="">不限</a></label>');
        } else {

            for (var i = 0; i < arrayAreas.length; i++) {
                str.push('<a data-id="', arrayAreas[i][2], '">', arrayAreas[i][0], '</a>');
            }
            unlimit && str.unshift('<a data-id="">不限</a>');
        }

        $(this).find("dd").empty().html(str.join('')).animate({ scrollTop: 0 }, 1);
    }

    function AddressInit() {
        var THIS = this,
			input = $(this).find("input[type=hidden]"),
			id = input.val(),
            ids = id.split(','),
			parent = $(this).data("parent"),
			addressFun = $(this).data("address"),
			child = $(this).data("child"),
			unlimit = $(this).data("unlimit"),
			areas;

        if (addressFun) {   //如果没有任何可获取的，则直接从配置中调用查询函数
            areas = eval(addressFun + '();');
        }
        else if (ids.length == 1 && ids[0] != '') { //如果本级有id则自动填充同级地址
            var me = GetArea(id);
            areas = GetAreas(me[1]);
        }
        else if (parent && $(parent).length || ids.length > 1) {    //如果本级没有id，则找上级id的子级填充本级地址
            parent = $(parent);
            var parid = parent.find("input[type=hidden]").val();
            parid && (areas = GetAreas(parid));
        }

        if (areas && areas.length) {
            fill.call(this, areas);

            var strArr = [];
            for (var i = 0; i < ids.length; i++) {
                if (ids[i]) {
                    for (var j = 0; j < areas.length; j++) {
                        if (areas[j][2] == ids[i]) {
                            strArr.push(areas[j][0]);
                        }
                    }
                }
            }

            var str = strArr.join(',');
            if (str) {
                var oJQdt = $(this).children('dt'),
                oJQinput = oJQdt.find("input:text"),
                oJQspan = oJQdt.find("span"),
                oJQb = oJQdt.find("b");

                if (oJQinput.size()) {//如果是输入框，则值置于input的value属性上
                    if (str) oJQinput.attr('title', str);
                    else oJQinput.removeAttr('title');
                }
                else if (oJQspan.size()) {//如果有span，则将span元素转换成b元素，并加上内容
                    var classes = oJQspan.get(0).className;
                    oJQspan.replaceWith('<b class="' + classes + '" title="' + str + '">' + str + '</b>');
                }
                else if (oJQb.size()) {//如果有b，则将b中内容直接替换
                    oJQb.text(str).attr('title', str);
                } else {
                    oJQdt.append('<b title="' + str + '">' + str + '</b>');
                }
            }
        }

        //本级变化时给下级填充列表
        child && $(child).length && input.change(function () {
            var id = this.value,
				areas = id !== '' ? GetAreas(id) : '',
				child = $($(this).closest("dl").data('child'));
            SELECT.text.call(child, '');
            SELECT.id.call(child, '');
            fill.call(child, areas);
        });
    }

    //地区级联初始化
    $(".ADDRESS").each(function (idx, el) {
        AddressInit.call(el)
    });
})();

//时间选项初始化，默认分钟项以5分钟为间隔，加上.MinuteAll可以显示所有分钟项(data-hourstart=10,data-hourend=20可以设置小时选项的起始结束值)

window.initTimeSelect = function (timedom) {
    if (timedom.length == 0) return false;

    //不触发选项选中事件
    timedom.closest('.SELECT').data('anchor', 'save').each(function () {
        if (!$(this).data('options')) {
            $(this).data('options', 8);
        }
    });

    //初始化小时选项
    timedom.each(function () {
        var str = new Array();
        var hourBegin = $(this).data('hourstart') || 0, hourEnd = $(this).data('hourend') || 24;
        for (var i = hourBegin; i < hourEnd; i++) {
            str.push('<a href="javascript:void(0)" data-id="' + (i < 10 ? '0' + i : i) + '">' + (i < 10 ? '0' + i : i) + '时</a>');
        }

        $(this).append('<div class="hourdiv" style="display:block;">' + str.join('') + '</div>');
    });

    //初始化分钟选项
    var str1 = new Array();
    for (var i = 0; i < 60; i = i + 5) {
        str1.push('<a href="javascript:void(0)" data-id="' + (i < 10 ? '0' + i : i) + '">' + (i < 10 ? '0' + i : i) + '分</a>');
    }

    var str2 = new Array();
    for (var i = 0; i < 60; i++) {
        str2.push('<a href="javascript:void(0)" data-id="' + (i < 10 ? '0' + i : i) + '">' + (i < 10 ? '0' + i : i) + '分</a>');
    }

    timedom.filter('.MinuteAll').append('<div class="minutediv" style="display:none;">' + str2.join('') + '</div>');
    timedom.not('MinuteAll').append('<div class="minutediv" style="display:none;">' + str1.join('') + '</div>');

    timedom.on('click', '.hourdiv a', function () {
        //选择小时
        $(this).closest('.hourdiv').data('id', $(this).data('id')).hide().siblings('.minutediv').show();
    }).on('click', '.minutediv a', function () {
        //选择分钟
        var min = $(this).data('id');
        var hour = $(this).closest('.minutediv').siblings('.hourdiv').data('id');

        var result = hour + ':' + min,
            select = $(this).closest('.SELECT');
        SELECT.text.call(select, result, { focus: true });
        SELECT.id.call(select, result);

        SELECT.close.call(select);

        var _this = this;
        setTimeout(function () {
            $(_this).closest('.minutediv').hide().siblings('.hourdiv').show();
        }, select.data('delay') || 0);
    });
}

window.initTimeSelect($('.TIMER'));
//岗位选项初始化
(function () {
    if ($('.DEPARTMENT').length == 0) return false;

    //选择部门
    $('.DEPARTMENT .deptlist span').click(function () {
        var deparment = $(this).data('id');
        $(this).closest('div').hide().siblings('.postlist').hide().filter('.list' + deparment).show();

        var select = $(this).closest('.SELECT');
        SELECT.timerOff.call(select.get(0));
        $('dt input', select).focus();
    });

    //返回部门选择
    $('.DEPARTMENT .head .dept').click(function () {
        $(this).closest('dd').find('.deptmian .deptlist').show().siblings('.postlist').hide();

        var select = $(this).closest('.SELECT');
        SELECT.timerOff.call(select.get(0));
        $('dt input', select).focus();
    });
})();

//简历状态多选初始化
(function () {
    if ($('.MultiSEL').length == 0) return false;

    function Init(selectors) {
        selectors.data('anchor', 'save');
        selectors.each(function () {
            var _this = $(this);
            var ids = _this.children('input[type=hidden]').val();
            if (ids == '' || ids.length == 0) {
                _this.find('a').removeClass('cur');
                _this.find('a.unlimited').addClass('cur');
            } else {
                var list = ids.split(',');
                for (var i = 0; i < list.length; i++) {
                    _this.find('.state').children('a[data-id="' + list[i] + '"]').addClass('cur');
                }
            }
        });
    }

    $('.MultiSEL .Multiselect .multilist .unlimited').click(function () {
        $(this).addClass('cur');
        $(this).parent().siblings('.state').children().removeClass('cur');
    });
    $('.MultiSEL .Multiselect').on("click", ".state a", function () {
        if ($(this).parent().find("a.cur").length >= $(this).closest(".SELECT").data("choice")) {
            layer.msg("最大只能选择" + $(this).closest(".SELECT").data("choice") + "项");
            return;
        }

        if ($(this).hasClass('cur')) {
            $(this).removeClass('cur');
        } else {
            $(this).addClass('cur');
        }
        $(this).parent().siblings('.multilist').children().removeClass('cur');
    });

    $('.MultiSEL .Multiselect .option_btn .c_confirm').click(function () {
        var SELECT = $(this).closest('.SELECT');
        var alist = SELECT.find('a.cur');

        var idlist = '';
        var namelist = '';
        SELECT.find('a.cur').each(function () {
            idlist += $(this).attr('data-id') + ',';
            namelist += $(this).html() + ',';
        });

        if (idlist != '') {
            idlist = idlist.substring(0, idlist.length - 1);
            namelist = namelist.substring(0, namelist.length - 1);
        }

        var placeholder = SELECT.data('placeholder') || '请选择',
            dtPlaceholder = SELECT.children('dt').data('placeholder');
        if (idlist != '') {
            SELECT.children('input[type=hidden]').val(idlist).change();
            SELECT.children('dt').html('<b class="" title="' + namelist + '">' + namelist + '</b>');
        } else {
            SELECT.children('input[type=hidden]').val('').change();

            if (dtPlaceholder) {
                SELECT.children('dt').html('');
            } else {
                SELECT.children('dt').html('<span>' + placeholder + '</b>');
            }
        }

        SELECT.removeClass('SELECT-on');
    });
    $('.MultiSEL .Multiselect .option_btn .c_cancel').click(function () {
        $(this).closest('.SELECT').removeClass('SELECT-on');
    });

    Init($('.MultiSEL'));

})();

var SELECT = {
    text: function (str, oOptions) {
        var oJQdt = $(this).children('dt'),
            oJQinput = oJQdt.find("input:text"),
            oJQspan = oJQdt.find("span"),
            oJQb = oJQdt.find("b");
        if (!$.isPlainObject(oOptions)) oOptions = {};
        if (!('focus' in oOptions)) oOptions.focus = false;

        if (oJQinput.size()) {//如果是输入框，则值置于input的value属性上
            if (oOptions.focus) oJQinput.focus();//提前执行，以便失去焦点可以触发onchange事件
            var oldstr = oJQinput.val();
            if (oldstr != str) oJQinput.val(str).change();
            if (str) oJQinput.attr('title', str);
            else oJQinput.removeAttr('title');
        }
        else if (oJQspan.size()) {//如果有span，则将span元素转换成b元素，并加上内容
            var classes = oJQspan.get(0).className;
            oJQspan.replaceWith('<b class="' + classes + '" title="' + str + '">' + str + '</b>');
        }
        else if (oJQb.size()) {//如果有b，则将b中内容直接替换
            oJQb.text(str).attr('title', str);
        } else {
            oJQdt.append('<b title="' + str + '">' + str + '</b>');
        }
    },
    id: function (id) {
        var input = $(this).find("input[type=hidden]");
        if (!input.size()) {
            return;
        }
        var oldid = input.val();
        id = id + "";
        if (oldid !== id) {
            input.val(id).change();
        }
    },
    reset: function (bChange, bSaveValue) {
        var placeholder = $(this).data('placeholder'),
            oJQhidden = $(this).find("input[type=hidden]"),
            oJQdt = $(this).children('dt'),
            oJQinput = oJQdt.find("input:text"),
            oJQspan = oJQdt.find("span"),
            oJQb = oJQdt.find("b");
        oJQhidden.val('');
        if (oJQinput.size()) {//如果有输入框，则置空输入框内容，低版本再触发输入框的reset()方法
            if (!bSaveValue) oJQinput.val('').blur();
        }
        else if (oJQspan.size()) oJQspan.text(placeholder);
        else if (oJQb.size()) {//有b则将其替换成span，内容放置默认提示
            var classes = oJQb.get(0).className;
            oJQb.replaceWith('<span class="' + classes + '">' + placeholder + '</span>');
        }
        if ($(this).find("caption a q").size()) $(this).find("caption a q").click();
        else $("dd a", this).removeClass("checked");

        //新增多选类型的重置代码
        if ($(this).hasClass('MultiSEL') || $(this).find('.areaSEL').length) {
            $('dd a.cur', this).removeClass('cur');
            $('.unlimited', this).addClass('cur');
        }

        //强制触发CHANGE事件，通过点击选项而触发的重置才会使用
        if (bChange) oJQhidden.change();
    },
    timerOff: function () {
        clearTimeout(this.timer);
        this.timer = 0;
    },
    open: function () {
        SELECT.timerOff.call(this);
        //此处会引发注册页帐号输入自动清空，只能注释掉
        //SELECT.init.call(this);
        $(this).addClass("SELECT-on").find("dd").each(function () {
            $(this)[$(this).children().length ? 'removeClass' : 'addClass']('empty');
        });
        $(".SELECT").not(this).map(function () {
            SELECT.close.call(this, true);
        });

        var dl = $(this);
        var dd = dl.find("dd");
        // 下拉框超出屏幕时重新调整位置
        var offsetNum = (dl.offset().left + dd.width()) - $(window).width();

        var maxHeight = dl.closest(".maxHeight");
        var maxHeightLeft = maxHeight.length && maxHeight.offset().left;
        var r = (dl.offset().left + dd.width()) - (maxHeightLeft + maxHeight.width()) + 20;

        if (dl.hasClass('SELECT-on') && maxHeight.length && r > 90) {
            dd.css({
                left: -r + "px"
            })
        }

        if (dl.hasClass('SELECT-on') && (!maxHeight.length) && offsetNum > 0) {

            dd.css({
                left: -(offsetNum + 2) + "px"
            });
        }
    },
    close: function (bAtonce) {
        var oJQselect = $(this);
        if (!this.timer && !bAtonce) {//自由关闭，需要计时器
            this.timer = setTimeout(function () {
                oJQselect.removeClass("SELECT-on");
            }, $(this).data('delay'));
        }
        else if (bAtonce) {//立即关闭，不通过计时器
            SELECT.timerOff.call(this);
            $(this).removeClass("SELECT-on");
        }
    },
    void0: function () {
        var attr = { title: function () { return this.title ? this.title : $(this).text(); } };
        if ($(this).data('href') != true) {
            attr.href = 'javascript:void(0)';
        }
        $(this).find("dd a:not([data-anchor=save])").attr(attr);
    },
    //以input的值来初始化选项状态，点击取消也会使用本方法
    value: function () {
        var oInputHidden = $(this).find("input[type=hidden]");
        //如果找不到隐藏域，或许dt中有输入框，则不需要初始化
        if (!oInputHidden.size()) return;
        var sIds = oInputHidden.val(),
            aIds = sIds.split(','),
            oJQcollector = $(this).find(".SELECT-COLLECTOR"),
            oJQchoicesList = $(this).find(".SELECT-CHOICES");
        if (!oJQchoicesList.size()) oJQchoicesList = $(this).children("dd");
        var selector = [], items = [];
        for (var n = 0; n < aIds.length; n++) selector.push('a[data-id="' + aIds[n] + '"]');
        var oItems = oJQchoicesList.find(selector.join(',')),
            sTexts = [],
            sChoices = oItems.map(function () {
                return '<a href="javascript:void(0)" data-id="' + $(this).data("id") + '"><span>' + $(this).text() + '</span><q></q></a>';
            }).get().join('');
        oItems.each(function () {
            $(this).addClass("checked");
            var text = $(this).text();
            if ($.inArray(text, sTexts) == -1) sTexts.push(text);
        });

        sTexts = sTexts.join(',');
        oJQchoicesList.find("a").not(oItems).removeClass("checked");
        if (!sTexts && $(this).data('custom')) {//如果根据value没有得到对应的文本值且是自定义数据则直接将value赋值给text
            if (sIds) {
                var vText = "";
                var unit = $(this).data('unit');
                if (sIds.split("~")[0] == 0) {
                    vText += sIds.split("~")[1] + unit + "以下";
                } else if (sIds.split("~")[1] == 100) {
                    vText += sIds.split("~")[0] + unit + "以上";
                } else {
                    vText = sIds;
                }
                SELECT.text.call(this, vText);
            }
        } else {
            if (sIds) SELECT.text.call(this, sTexts);
            else SELECT.reset.call(this);
        }
        if (oJQcollector.size()) oJQcollector.find("a").remove().end().find(":button:first").before(sChoices);
    },
    next: function () {
        var nextSelect = $(this).data("child");
        if (nextSelect) $(nextSelect).find("dt").click();
    },
    init: function () {
        var oJQselect = $(this);
        if (!$(this).data('active')) $(this).data('active', 'click');
        if (!$(this).data('delay')) $(this).data('delay', 300);
        if ($(this).data('choices') === undefined) $(this).data('choices', 1);
        if (!$(this).data('placeholder')) $(this).data('placeholder', '请选择');
        if (!$(this).data('leave')) $(this).data('leave', 'close');
        if (!$(this).data('empty')) $(this).data('empty', 'init');
        if (!$(this).data('type')) $(this).data('type', 'id');
        if (!$(this).data('inited')) $(this).data('inited', false);
        if (!$(this).data('options')) $(this).data('options', 0);
        if (!$(this).data('custom')) $(this).data('custom', false);
        var unit = $(this).data('unit');
        var inited = $(this).data('inited');

        this.timer = 0;
        if (!inited) {
            //离开菜单则隐藏
            $(this).mouseleave(function () {
                var leave = $(this).data('leave'),  //鼠标离开是否自动关闭
                    close = $(this).data('close');  //此值用于因数据变化导致鼠标离开而不自动关闭，需用延时清除此值
                if (leave != 'egnore' && close != 'egnore') SELECT.close.call(this);
            })
            //迅速回到菜单则不隐藏
            .mouseenter(function () {
                SELECT.timerOff.call(this);
            })
            //点击表头则显示
            .find("dt").on($(this).data('active'), function (event) {
                var DL = $(this).closest(".SELECT").get(0),
                    action = 'open';
                switch (event.target.tagName.toLowerCase()) {
                    case 'span': case 'b': break;
                    case 'i':
                        if ($(DL).hasClass("SELECT-on")) action = 'close';
                        break;
                    default:;
                }

                SELECT[action].call(DL, true);
            })
            //列表头中的输入框的事件
            //.find("input").on('focus keyup keydown keypress',function(){
            .find("input").on('keyup keydown keypress', function (event) {
                if (event.which != 13)
                    SELECT.open.call($(this).closest(".SELECT").get(0));
            })
            .on('blur', function () {
                SELECT.close.call($(this).closest(".SELECT").get(0));
            });
            //最大外露选项设置
            if ($(this).data('options')) {
                var maxh = $(this).data('options') * ($(this).find("dd a").height() || parseInt($(this).find("dd a").css('line-height')) || 30)
                $(this).find("dd").css({
                    maxHeight: maxh,
                    overflow: 'auto',
                    height: navigator.appVersion.indexOf("MSIE 6.0") > 0 ? maxh : 'auto'
                });
            }
            //如果dl.SELECT的data-anchor='save'则所有链接保留，否则才按选项处理
            if ($(this).data('anchor') != 'save') {
                SELECT.void0.call(this);
                //先找指定的选项列表容器，如果没有才找直接子元素dd
                var oJQchoicesList = $(this).find(".SELECT-CHOICES"),
                    oJQcollector = $(this).find(".SELECT-COLLECTOR"),
                    piChoices = $(this).data("choices");
                if (!oJQchoicesList.size()) oJQchoicesList = $(this).children("dd");
                //点击选项，可能是未来元素
                oJQchoicesList.delegate('a', 'click', function () {
                    var oJQselect = $(this).closest(".SELECT"),
                        oJQcollector = oJQselect.find(".SELECT-COLLECTOR"),
                        oDOMselect = oJQselect.get(0),
                        sText = $(this).text(),
                        piID = $(this).data('id'),
                        piChoices = oJQselect.data('choices');
                    if (piChoices == 1) {//单选，将自己设置为选中状态，其它所有选项取消选中

                        $(this).addClass('checked');
                        var par;
                        (par = $(this).closest("tbody")).length && par.closest(".SELECT").length && (par.find("a").not(this).removeClass("checked"), true)
                        || $(this).siblings("a").removeClass("checked");
                        if (piID !== '') {//有ID直接保存ID及字符串
                            SELECT.text.call(oDOMselect, sText, { focus: true });
                            SELECT.id.call(oDOMselect, piID);
                        }
                        else if ($(oJQselect).data("type") == 'id') {//无ID，如果保存的是ID的话，可能是“不限”选项
                            SELECT.reset.call(oDOMselect, true);
                        }
                        else {//无ID，如果保存的是字符串的话，直接将字符串写入
                            SELECT.text.call(oDOMselect, sText, { focus: true });
                        }
                        SELECT.close.call(oDOMselect, true);
                        SELECT.next.call(oDOMselect);
                    }
                    else {//多选
                        var oCollectedItem = oJQcollector.find("a[data-id='" + piID + "']");
                        if (oCollectedItem.size()) {//已经存在，则删除
                            oCollectedItem.remove();
                            oJQselect.find("a[data-id=" + piID + "]").removeClass("checked");
                            //$(this).removeClass("checked");
                        }
                        else {//不存在
                            var oItems = oJQcollector.find("a");
                            if (oItems.size() >= piChoices && piChoices) {//数量满，则提示
                                alert("最多选择" + piChoices + "项");
                            }
                            else {//数量未满，则加入
                                oJQcollector.find("p:first").before('<a href="javascript:void(0)" data-id="' + piID + '" class="checked">' + sText + '</a>');
                                $(this).addClass("checked");
                            }
                        }
                    }
                });
                //点击“不限”按钮
                oJQcollector.find(".nolimit").click(function () {
                    var oDOMselect = $(this).closest(".SELECT").get(0);
                    SELECT.close.call(oDOMselect, true);
                    SELECT.reset.call(oDOMselect);
                });
                oJQcollector.find(".close").click(function () {
                    SELECT.close.call($(this).closest(".SELECT").get(0), true);
                });
                //多选则给采集器中选项绑定事件，还有按钮事件
                if (piChoices != 1) {
                    oJQcollector.delegate('a q', 'click', function () {
                        var oJQa = $(this).parent(),
                            piID = oJQa.data("id");
                        oJQa.remove();
                        oJQchoicesList.find('a[data-id="' + piID + '"]').removeClass("checked");
                    })
                    //点击确定
                    .find(".submit").click(function () {
                        var oItems = $(this).parent().siblings("a"),
                            oDOMselect = $(this).closest(".SELECT").get(0),
                            sTexts = oItems.map(function () { return $(this).text(); }).get().join(','),
                            sIds = oItems.map(function () { return $(this).data("id"); }).get().join(',')
                        ;
                        //有选择则放值，无选择则置空
                        if (sIds) SELECT.text.call(oDOMselect, sTexts);
                        else SELECT.reset.call(oDOMselect, true);
                        SELECT.id.call(oDOMselect, sIds);
                        SELECT.close.call(oDOMselect, true);
                        SELECT.next.call(oDOMselect);
                    })
                    //点击取消
                    .siblings(".reset")/*.remove().click(function(){
                        var oDOMselect=$(this).closest(".SELECT").get(0);
                        SELECT.close.call(oDOMselect,true);
                        SELECT.value.call(oDOMselect);
                    })*/
                    ;
                }
                //数字型列表，自动填充选项
                var fillOption;
                if ((fillOption = $(this).data("autofill")) && /^[\+\-]?[\d]+\,[\+\-]?[\d]+\,[\+\-]?[\d]+(\,[\d]+)?$/.test(fillOption)) {
                    var arr = fillOption.split(','),
                        from = parseInt(arr[0]),
                        to = parseInt(arr[1]),
                        step = parseInt(arr[2]),
                        fillBit = arr.length == 4 ? parseInt(arr[3]) : 0,
                        str = [];
                    if (step && (to - from) / step > 0) //从from到to的方向，要与step一致，不然会死循环
                        for (var n = from; n <= to; n += step) {
                            var id = n;
                            if (fillBit > 1 && id.toString().length < fillBit) {
                                for (var x = id.toString().length; x < fillBit; x++)
                                    id = '0' + id
                            }
                            str.push('<a href="javascript:void(0)" data-id="', id, '">', id, '</a>');
                        }
                    oJQchoicesList.html(str.join(''));
                }
            }

            //如果有自定义则初始化自定义的事件
            if ($(this).data('custom')) {
                var self = $(this);
                $(this).find(".custom div.custom .confirm").on("click", function () {
                    var oJQselect = $(this).closest(".SELECT"),
                          oJQcollector = oJQselect.find(".SELECT-COLLECTOR"),
                          oDOMselect = oJQselect.get(0);
                    var min = self.find("div.custom input.min").val();
                    var max = self.find("div.custom input.max").val();
                    if (!min && !max) {
                        layer.msg("请输入自定义内容！");
                        return;
                    }
                    var piID, sText;
                    if (!min) {
                        piID = 0 + "~" + max;
                        sText = max + unit + "以下";
                    }
                    else if (!max) {
                        piID = min + "~" + 100;
                        sText = min + unit + "以上";
                    }
                    else {
                        piID = sText = min + "~" + max;
                    }
                    SELECT.text.call(oDOMselect, sText, { focus: true });
                    SELECT.id.call(oDOMselect, piID);
                });
            }
        }



        //不指定忽略的，且含有隐藏域的，都需要初始化显示值
        if ($(this).data("empty") != 'egnore' && $(this).find("input[type=hidden]").size()) {
            var value = $(this).find("input[type=hidden]").val();
            if (value !== '') {
                SELECT.value.call(this);
            }
            else {
                SELECT.reset.call(this, false, true);
            }
        }
        var input = $(this).find("dt input");

        //给没有placeholder属性，且不使用图片做占位符的输入框，添加下拉列表指定的占位字符串
        input.not("[data-holdway='image'],[placeholder]").attr('placeholder', $(this).data('placeholder'));

        //键盘监听，上下箭头与回车
        if (input.size() && input.data("list") == 'arrow' && !inited) {
            input.keydown(function (event) {
                var key = event.which;
                if ($.inArray(key, [40, 38, 13]) >= 0) {
                    var theSelect = $(this).closest('.SELECT'),
                        list = theSelect.find("[data-list='datas']"),
                        anchors = list.find("a"), count = anchors.size(),
                        curA = anchors.filter("a.cur"), curIndex = curA.size() ? curA.index() : -1,
                        trigger;
                    switch (key) {
                        case 38://上箭头
                            curIndex = curIndex == -1 ? count - 1 : (curIndex - 1 + count) % count;
                            anchors.eq(curIndex).addClass('cur').siblings().removeClass('cur');
                            break;
                        case 40://下箭头
                            curIndex = (curIndex + 1) % count;
                            anchors.eq(curIndex).addClass('cur').siblings().removeClass('cur');
                            break;
                        case 13://回车
                            if (curIndex != -1) curA.click();
                            else if ((trigger = theSelect.data('trigger'))) $(trigger).click();
                            break;
                    }
                    return false;
                }
            });
            //鼠标移上去的时候，只有一个反色选项
            $(this).find("[data-list='datas']").delegate('a', 'mouseenter', function () {
                $(this).addClass("cur").siblings().removeClass("cur");
            }).delegate('a', 'mouseleave', function () {
                $(this).removeClass("cur");
            });
        }
        $(this).data('inited', true);
    }
};

(function () {
    $(".SELECT").not("[data-init='false']").map(function () {
        SELECT.init.call(this);
    });

    //城市选择
    $('.CITY').each(function () {
        var hiddenVal = $(this).siblings('input[type=hidden]').val();
        if (hiddenVal) {
            if ($(this).hasClass('areaSEL')) {
                var arr = hiddenVal.split(',');
                if (arr.length > 0 && arr[0].length == 6) {
                    $('a[data-id=' + arr[0].substring(0, 2) + '0000]', this).click();

                    if (arr[0].substring(arr[0].length - 4) != '0000') {
                        $('a[data-id=' + arr[0].substring(0, 4) + '00]', this).click();

                        if (arr[0].substring(arr[0].length - 2) != '00') {
                            for (var i = 0; i < arr.length; i++) {
                                $('a[data-id=' + arr[i] + ']', this).click();
                            }

                            $('.c_confirm', this).click();
                        } else {
                            $('a.unlimited', this).click();
                            $('.c_confirm', this).click();
                        }
                    }
                }
            }
            else {
                var name = '';

                var provinceLink = $('a[data-id=' + hiddenVal.substring(0, 2) + '0000]', this);
                name = $.trim(provinceLink.text());
                $('.provinces', this).data('id', provinceLink.data('id')).data('name', name);
                provinceLink.click();

                if (hiddenVal.substring(hiddenVal.length - 4) != '0000') {
                    var cityLink = $('a[data-id=' + hiddenVal.substring(0, 4) + '00]', this);
                    name += $.trim(cityLink.text());
                    $('.cities', this).data('id', cityLink.data('id')).data('name', $.trim(cityLink.text()));
                    cityLink.click();

                    if (hiddenVal.substring(hiddenVal.length - 2) != '00') {
                        var regionLink = $('a[data-id=' + hiddenVal + ']', this);
                        name += $.trim(regionLink.text());
                    }
                }

                SELECT.text.call($(this).closest('.SELECT'), name, { focus: true });
            }
        }
    });
})();


