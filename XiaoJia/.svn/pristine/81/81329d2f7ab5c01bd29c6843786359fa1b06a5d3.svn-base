//点击过滤器组中的时间选择
(function () {
    $('input.time').on('click focus', function () {
        if ($(this).hasClass("seletetime")) {
            WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm' })
        } else {
            WdatePicker();
        }
    });
    $("input").prop('autocomplete', 'off');
})();

//填充行业大列表
(function () {
    if ($('.PROFESSIONS').length == 0 || typeof subjectArray == 'undefined') return false;
    var str = [], roots = GetTopSubjects();
    for (var i = 0; i < roots.length; i++) {
        str.push('<tr><th>', roots[i][0], '</th><td>');
        var kids = GetSubjects(roots[i][2]);
        for (var j = 0; j < kids.length; j++) {
            str.push('<a data-id="', kids[j][2], '">', kids[j][0], '</a>');
        }
        str.push('</td></tr>');
    }
    $(".PROFESSIONS tbody").empty().append(str.join(''));
})();

//填充职位大列表
(function () {
    if ($(".JOBPOSITIONS").length == 0 || typeof positionArray == 'undefined') return false;
    var strTH = [], strTD = [], roots = GetTopPositions();
    for (var x = 0; x < roots.length; x++) {
        strTH.push('<h3>', roots[x][0], '</h3>');
        var classes = GetPositions(roots[x][2]);
        strTD.push('<ul>');
        for (var y = 0; y < classes.length; y++) {
            strTD.push('<li><h4>', classes[y][0], '</h4>');
            var jobs = GetPositions(classes[y][2]);
            for (var z = 0; z < jobs.length; z++) {
                strTD.push('<a data-id="', jobs[z][2], '">', jobs[z][0], '</a>');
            }
            strTD.push('</li>');
        }
        strTD.push('</ul>');
    }
    $(".JOBPOSITIONS")
		.find("th").html(strTH.join(''))
			.find("h3").click(function () {
			    $(this).addClass("cur").siblings().removeClass("cur")
					.closest("tr").find("td").children().eq($(this).index()).show().siblings().hide();
			})
		.end()
		.siblings('td').html(strTD.join(''));
    $(".JOBPOSITIONS th").find("h3:first").click();
})();

//填充兼职职位列表
(function () {
    if ($('.JOBSPARTTIME').length == 0 || typeof positionParttimeArray == 'undefined') return false;
    var str = [];
    for (var i = 0; i < positionParttimeArray.length; i++) {
        str.push('<a data-id="', positionParttimeArray[i][1], '">', positionParttimeArray[i][0], '</a>');
    }
    $(".JOBSPARTTIME td").html(str.join(''));
})();

//表单记录原始值
(function () {
    $("input:text").each(function () {
        var text = this.value;
        $(this).data('value', text);
    });
    function reset() {
        this.value = $(this).data('value');
    }
    window.allInputsReset = function (sJQscope) {
        !sJQscope && (sJQscope = document);
        $("input:text", sJQscope).each(function () {
            //reset.call(this);
            this.value = '';
        });
    }
})();

//全局自定义下拉列表，配置方法与前台略有不同
(function () {
    /*
	可以配置在dl元素上的有
		data-leave="-1|0|1|2|..."，鼠标离开列表时，-1为不收回，0为立即收回，正整数为收回延迟毫秒数
		data-child="唯一的JQ选择器字符串"，下级下拉列表的选择器，本级的选项被选后会自动打开下级下拉列表

	可以配置在dt元素上的有
		data-placeholder=""，为空时的占位字符串，默认为“请选择”

	可以配置在dd元素上的有（含有类normal的dd是普通的下拉列表）
		data-options="0|1|2|..."，普通下拉列表中，露在外边的选项数量，0为不限制，默认为5
		data-choices="0|1|2|..."，下拉列表最大可选选项数量，0为不限制，默认为1单选
	*/
    //缩回
    function close(atonce) {
        if ($(this).data('timer')) return;
        var n = atonce ? 0 : $(this).data('leave');
        if (n == -1) return;
        (isNaN(n) || n < 0) && (n = 0);
        var THIS = this;
        $(this).data({
            timer: setTimeout(function () {
                $(THIS).removeClass("on");
                clear.call(THIS);
            }, n)
        });
    }
    //清除缩回计时器
    function clear() {
        clearTimeout($(this).data('timer'));
        $(this).data({ timer: 0 });
    }
    //复位数据
    function reset() {
        $(this).each(function () {
            var input = $(this).find("input[type=hidden]"),
                oldid = input.data('id');
            if (!oldid) {
                setID.call(this, '');
                setText.call(this, '');
                //清理多选的已选项
                $(this).find("caption p").empty()
                    .end()
                    .find("tbody a").removeClass("checked");
                return;
            }
            var oldids = oldid.split(','),
                filter = (function () {
                    var str = [];
                    for (var i = 0; i < oldids.length; i++)
                        str.push('[data-id="' + oldids[i] + '"]');
                    return str.join(',');
                })(),
                as = $(this).find("dd > a,tbody a"),
                as_checked = as.filter(filter),
                texts = as_checked.map(function () {
                    return $(this).text();
                }).get().join(',');
            setID.call(this, oldid);
            setText.call(this, texts);
            //清理多选的已选项
            $(this).find("caption p").empty().append(as_checked.clone());
            as.not(as_checked).removeClass("checked");
        });
    }
    //设置字符串
    function setText(text) {
        //如果找到dt中的input:text则设置为其value
        var dt = $(this).find("dt"),
			input = dt.find("input:text");
        input.length && (input.val(text).change(), true)
		|| dt.text(text).attr('title', text) && text === '' && dt.empty();
    }
    function empty() {
        setID.call(this, '');
        setText.call(this, '');
        $(this).find("dd").find("a").removeClass("checked").end()
			.find("caption p").empty();
    }
    //设置id
    function setID(id, isChange) {
        //如果找到dl中的input[type=hidden]则设置id
        var input = $(this).find("input[type=hidden]"),
			oldid = input.val() || '';
        if (oldid.toString() == id.toString() && !isChange) return true;
        input.val(id).change();
    }
    //点击非下拉列表的地方时，关闭当前下拉列表（如果是小表的话）
    $(document).click(function (event) {
        var tar = event.target;
        if ($(tar).closest('.on').length) return;
        close.call($('.SELECT.on:not([data-leave="-1"])').get(0), true);
    });
    function SelectEventBind() {
        var dl = $(this);
        dl.mouseenter(function () {
            clear.call(this);
        })
        .mouseleave(function () {
            close.call(this);
        })
    //点击列表头可以打开/关闭下拉列表
    .find("dt").click(function () {
        var dl = $(this).closest("dl").toggleClass("on"),
            dd = dl.find("dd");
        dl.hasClass("on") && $(".SELECT").not(dl).each(function () {
            close.call(this, true);
        });

        // 下拉框超出屏幕时重新调整位置
        var offsetNum = (dl.offset().left + dd.width()) - $(window).width();

        var maxHeight = dl.closest(".maxHeight");
        var maxHeightLeft = maxHeight.length && maxHeight.offset().left;
        var r = (dl.offset().left + dd.width()) - (maxHeightLeft + maxHeight.width()) + 20;

        if (dl.hasClass('on') && maxHeight.length && r > 90) {
            dd.css({
                left: -r + "px"
            })
        }

        if (dl.hasClass('on') && (!maxHeight.length) && offsetNum > 0) {

            dd.css({
                left: -(offsetNum + 2) + "px"
            });
        }

    }).each(function () {
        //占位符设置
        var placeholder = $(this).data('placeholder'),
            input = $(this).find("input:text");
        //有输入框的要加入键盘响应
        if (input.length) {
            input.on('keydown', function (event) {
                var key = event.which;
                if ($.inArray(key, [38, 40, 13]) == -1) return;
                var dd = $(this).parent().next("dd"),
                    dl = dd.parent(),
                    as = dd.find("a"),
                    allnum = as.length,
                    curA = as.filter(".checked"),
                    current = curA.length ? curA.index() : -1;
                if (!dl.hasClass("on")) dl.addClass("on");
                switch (key) {
                    case 38:
                        current = current == -1 ? 0 : (current - 1 + allnum) % allnum;
                        as.eq(current).addClass("checked").siblings().removeClass("checked");
                        break;
                    case 40:
                        current = (current + 1) % allnum;
                        as.eq(current).addClass("checked").siblings().removeClass("checked");
                        break;
                    case 13:
                        if (current != -1) {
                            var a = as.eq(current),
                                dl = $(this).closest("dl");
                            setText.call(dl, a.text());
                            setID.call(dl, a.data("id"));
                            close.call(dl, true);
                        }
                        break;
                }
            });
        }
            //为了css表现正常，这里要设置成HTML属性的data-placeholder
        else placeholder === undefined && $(this).attr('data-placeholder', '请选择');

    })
    //下拉列表清单
    .siblings("dd").each(function () {
        //普通下拉列表中的选项初始化，采用事件委托
        $(this).css('max-height', function () {
            if (!$(this).hasClass("normal")) return 'auto';
            var n = $(this).data('options');
            n === undefined && (n = 5);
            return 30 * n;
        })
        .filter(".normal").click(function (event) {
            var choice = event.target,
                dl = $(this).closest("dl"),
                nextDL = $(dl.data('child'));
            $(choice).addClass("checked").siblings().removeClass("checked");
            switch (choice.tagName.toLowerCase()) {
                case 'a':
                    var id = $(choice).data('id'),
                        text = $(choice).text();
                    setText.call(dl, id !== '' ? text : '');
                    if (id !== undefined) setID.call(dl, id);
                    close.call(dl, true);
                    break;
                default:;
            }
            if (nextDL.length) nextDL.find("dt").click();
        })
        .end()
        .not(".normal")
            .find("caption")
                //点击已选列表中的项目，将项目删除
                .find("p").click(function (event) {
                    var a = event.target;
                    if (a.tagName != 'A') return;
                    var id = $(a).data('id');
                    $(this).closest("table").find("tbody a[data-id='" + id + "']").removeClass("checked");
                    $(a).remove();
                })
                .end()
                //点击确定将值写入
                .find(".confirm").click(function () {
                    var dl = $(this).closest("dl"),
                        input = dl.find("input[type=hidden]"),
                        as = dl.find("caption p a"),
                        ids = as.map(function () { return $(this).data("id"); }).get().join(','),
                        text = as.map(function () { return $(this).text(); }).get().join(',');
                    setID.call(dl, ids);
                    setText.call(dl, text);
                    close.call(dl, true);
                })
                .end()
            //选项列表中的点击
            .siblings("tbody").click(function (event) {
                var a = event.target;
                if (a.tagName != 'A') return;
                var maxnum = $(this).siblings("caption").data("choices");
                maxnum = isNaN(maxnum) ? 1 : maxnum;
                if (maxnum == 1) {//大选择器也有使用单选的时候，比如说公司资料选行业
                    $(a).addClass("checked")
                        .closest("tbody").find("a").not(a).removeClass("checked")
                        .closest("table").find("caption").find("p").empty().append($(a).clone())
                        .end()
                        .find(".confirm").click();
                    return;
                }
                if ($(a).hasClass('checked')) return;
                var id = $(a).data('id'),
                    text = $(a).text(),
                    dl = $(this).closest("dl"),
                    caption = dl.find("caption"),
                    p = caption.find("p"),
                    as = p.find("a");
                if (as.length >= maxnum && maxnum != 0) { alert('最多选择' + maxnum + '项'); return; }
                p.append('<a data-id="' + id + '" class="checked">' + text + '</a>');
                $(a).addClass("checked");
            })
    })
    //隐藏域的初始值，并将初始值设置成data-id
    .siblings("input[type=hidden]").each(SelectInit);
    }
    //初始化过程
    $(".SELECT").data({
        timer: 0//缩回计时器
    }).each(SelectEventBind);

    function SelectInit() {
        var ids = $(this).val(),
			dl = $(this).closest("dl");
        $(this).data('id', ids);
        if (ids === '') { return true; }
        empty.call(dl);
        ids = ids.split(',');
        var filter = [], as = [],
        caption = dl.find("caption");

        for (var i = 0; i < ids.length; i++) {
            as.push(dl.find('dd [data-id="' + ids[i] + '"]').addClass("checked").get(0));
        }

        if (!as.length) return true;
        var text = $(as).map(function () {
            return $(this).text();
        }).get().join(',');
        setText.call(dl, text);
        setID.call(dl, ids.join(','), true);
        $(as).each(function (index, el) {
            caption.find("p").append($(el).clone());
        });

    }

    window.SelectInit = SelectInit;
    window.SelectEventBind = SelectEventBind;
    //外部可用的全复位效果
    window.allSelectsReset = function (sJQscope) {
        !sJQscope && (sJQscope = document);
        $(".SELECT", sJQscope).each(function () {
            //reset.call(this);
            empty.call(this);
        });
    }

    //初始化地名联动列表
    /*
	地名下拉列表，需要有类ADDRESS，目前的地址列表一律为普通列表
	可以使用在dl上的配置有
		data-parent="唯一的JQ选择器字符串"，上级下拉列表的选择器，会自动根据上级的当前选项初始化本级下拉列表的选项
		*****当有data-child配置时，本级地址改变，会自动初始化对应的下级列表，更下级的被置空
		data-unlimit="true|false"，是否含有“不限”选项，默认为false
	*/
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
			str = [],
			areas;

        if (ids.length == 1 && ids[0] != '') {//如果本级有id则自动填充同级地址
            var me = GetArea(id);
            areas = GetAreas(me[1]);
            setText.call(this, me[0]);
        }
        else if (parent && $(parent).length || ids.length > 1) {//如果本级没有id，则找上级id的子级填充本级地址
            parent = $(parent);
            var parid = parent.find("input[type=hidden]").val();
            parid && (areas = GetAreas(parid));
        }
        else if (addressFun) {//如果没有任何可获取的，则直接从配置中调用查询函数
            areas = eval(addressFun + '();');
        }
        if (areas && areas.length) {
            fill.call(this, areas);
            $(this).find("dd a[data-id='" + id + "']").addClass("checked");
        }

        //本级变化时给下级填充列表
        child && $(child).length && input.change(function () {
            var id = this.value,
				areas = id !== '' ? GetAreas(id) : '',
				child = $($(this).closest("dl").data('child'));
            setID.call(child, '');
            setText.call(child, '');
            fill.call(child, areas);
        });
    }

    //切换全职（实习）或兼职或不限时，不同的职位列表
    $(".JobType").change(function () {
        var parent = $(this).closest(".Filter");
        if (parent.length == 0) parent = $(this).closest("dd");

        var fulltime = $(".JOBPOSITIONS", parent).parent(),
			parttime = $(".JOBSPARTTIME", parent).parent(),
            professions = $(".PROFESSIONS", parent).parent(),
			salary = $(".Salary", parent);
        reset.call(fulltime);
        reset.call(parttime);
        reset.call(salary);
        switch (this.value * 1) {
            case 0:
                fulltime.hide();
                parttime.hide();
                professions.hide();
                salary.css('visibility', 'hidden');
                break;
            case 1:
            case 4:
                fulltime.show();
                parttime.hide();
                professions.show();
                salary.css('visibility', 'visible');
                break;
            case 2:
                parttime.show();
                fulltime.hide();
                professions.hide();
                salary.css('visibility', 'hidden');
                break;
        }
    }).change();

    window.setText = setText;
    window.setID = setID;
    window.AddressInit = AddressInit;
})();

$(".ADDRESS").each(function (idx, el) {
    AddressInit.call(el)
});

//搜索条件重置
$('#searchForm [type=reset]').click(function () {
    window.location = $(this).closest('form').prop('action');
});