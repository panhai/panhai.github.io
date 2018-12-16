// 后台通用行为，未做低端兼容

//点击过滤器组中的时间选择
(function () {
    $("input.time").click(function () {
        if ($(this).hasClass("seletetime")) JBCalendar.show(this, { selectTime: "m" });
        else JBCalendar.show(this);
    });
    $("input").prop('autocomplete', 'off');
})();


//填充行业大列表
(function () {
    if (typeof subjectArray == 'undefined') return false;
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
    if (typeof positionArray == 'undefined') return false;
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
    if (typeof positionParttimeArray == 'undefined') return false;
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
        //      var setting=$(this).data('autofill');
        //      if(setting && $(this).hasClass("normal"))
        //      {
        //          setting=setting.split(',');
        //          var from=setting[0]*1,
        //              to=setting[1]*1,
        //              delta=setting[2]*1,
        //              unlimit=setting[3],
        //              str=[];
        //          unlimit && str.push('<a data-id="">不限</a>');
        //          for(var i=from;i<=to;i+=delta)
        //          {
        //              str.push('<a data-id="', i ,'">', i ,'</a>');
        //          }
        //
        //          $(this).empty().html(str.join(''));
        //      }
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
            var item = dl.find('dd [data-id="' + ids[i] + '"]');
            if(item.length){
                as.push(item.addClass("checked").get(0));
            }
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
//大列表项的全选及反选
(function () {
    $(".List").find(".checkAll").click(function () {
        $(this).closest("table").find(":checkbox").prop('checked', true).change();
    }).siblings(".checkNeg").click(function () {
        $(this).closest("table").find(":checkbox").each(function () {
            $(this).prop('checked', !this.checked).change();
        });
    });
})();

//学校列表提示
(function () {
    if (typeof universities == 'undefined') return false;
    $(".SCHOOLS").on("input focus", function () {
        var key = this.value,
			schools = GetUniversitiesByKeyword(key, 5),
			dd = $(this).closest("dt").next("dd"),
			dl = dd.parent(),
			str = [];
        if (!dl.hasClass("on")) dl.addClass("on");
        for (var i = 0; i < schools.length; i++) {
            str.push('<a>', schools[i], '</a>');
        }
        dd.empty().html(str.join(''));
    });
})();

//邮箱的输入提示
(function () {
    var emails = '163.com,sina.com,yeah.net,sohu.com,21cn.com,139.com,tom.com,126.com,qq.com'.split(',');
    $(".EMAILS").on('input focus', function () {
        var address = this.value;
        if (!address) { $(this).closest("dl").removeClass("on"); return; }
        var at = address.indexOf('@'),
			user = at > 0 ? address.substring(0, at) : address,
			host = at > 0 ? address.substring(at + 1) : '',
			dl = $(this).closest("dl"),
			dd = dl.find("dd"),
			str = [];
        if (at == 0) { this.value = ''; return; }
        if (!dl.hasClass("on")) dl.addClass("on");
        for (var i = 0; i < emails.length; i++) {
            var hostname = emails[i];
            if (host && hostname.indexOf(host) >= 0) str.push('<a>', user, '@', hostname, '</a>');
            else if (!host) str.push('<a>', user + '@' + hostname, '</a>');
        }
        dd.empty().html(str.join(''));
    });
})();


//上传的框
(function () {
    if (typeof Raphael == 'undefined') return false;
    ///////////////////////////////////////新增LOGO上传部分的修改
    var paper = Raphael('LogoController', 340, 20);
    var mag_n = paper.path('M13,1A7,7,0,1,1,12.9,1M9,8H17M8,12L1,19').attr({ stroke: '#808080', 'stroke-width': 2, cursor: 'pointer', fill: '#fff' });
    var mag_p = paper.path('M13,1A7,7,0,1,1,12.9,1M9,8H17M13,4V12M8,12L1,19').attr({ stroke: '#808080', 'stroke-width': 2, transform: 'T320,0S-1,1', cursor: 'pointer', fill: '#fff' });
    var bg = paper.rect(28, 5, 285, 10, 5).attr({ stroke: '#f0f1fe', fill: '#ededed' })
    var progress = paper.rect(29, 6, 0, 8, 4).attr({ fill: '#686593', stroke: false });
    var slider = paper.circle(29, 10, 7).attr({ fill: '#fff', stroke: '#686593' })
		.drag(function (dx, dy) {
		    var cx = Math.min(Math.max(currentX + dx, startX), overX),
				barwidth = cx - startX;
		    sliding && this.attr({ cx: cx });
		    progress.attr({ width: barwidth });
		    currentRatio = (barwidth / (overX - startX)) * (maxRatio - minRatio) + minRatio;
		    clip.ratio = currentRatio;
		    var left = pivotX - primaryWidth * currentRatio / 2,
				top = pivotY - primaryHeight * currentRatio / 2,
				w = Math.floor(primaryWidth * currentRatio),
				h = Math.floor(primaryHeight * currentRatio),
				minL = minXY - w,
				minT = minXY - h;
		    IMAGE.css({
		        width: w,
		        height: h,
		        left: Math.max(Math.min(left, maxXY), minL),
		        top: Math.max(Math.min(top, maxXY), minT)
		    });
		    IMAGECLONE.css({
		        width: primaryWidth * currentRatio,
		        height: primaryHeight * currentRatio,
		        left: parseInt(IMAGE.css('left')) - maxXY,
		        top: parseInt(IMAGE.css('top')) - maxXY
		    });
		    clip.width = 190 * clip.ratio;
		    clip.height = 190 * clip.ratio;
		    clip.x = parseInt(IMAGECLONE.css('left')) * -1;
		    clip.y = parseInt(IMAGECLONE.css('top')) * -1;
		}, function (px, py) {
		    pivotX = IMAGE.width() / 2 + parseInt(IMAGE.css('left'));
		    pivotY = IMAGE.height() / 2 + parseInt(IMAGE.css('top'));
		    sliding = true;
		}, function (event) {
		    sliding = false;
		    currentX = this.attr('cx');
		});
    var startX = 29, overX = 312,//滑块起止位置
		pivotX, pivotY,//缩放中心点
		clip = {
		    x: 0,
		    y: 0,
		    width: 0,
		    height: 0,
		    ratio: 1
		},
		sliding = false, dragging = false,//滑动锁骨及拖拽锁
		currentX = 29,//当前滑块位置
		IMAGE,//这个要放在回调里边再获取对象
		IMAGECLONE,//小图的副本
		primaryWidth, primaryHeight,//原始尺寸
		moreWidth,//过宽标识
		currentRatio,//当前比例
		minRatio,//最小比例
		maxRatio = 1;//最大比例
    //上传完要执行一次getImage，以给IMAGE对象赋值
    getImage = function () {
        //获取图片对象，并将调节框初始化
        IMAGE = $(".largeImg.view img").eq(0);
        IMAGECLONE = IMAGE.clone();
        $(".thumbImg.view").empty().append(IMAGECLONE);
        primaryWidth = IMAGE.width();
        primaryHeight = IMAGE.height();
        moreWidth = primaryWidth > primaryHeight;
        IMAGE.add(IMAGECLONE).css({
            width: moreWidth ? 'auto' : 190,
            height: moreWidth ? 190 : 'auto'
        });
        var width = IMAGE.width(), height = IMAGE.height();
        IMAGE.css({
            left: (340 - width) / 2,
            top: (340 - height) / 2
        });
        IMAGECLONE.css({
            left: (190 - width) / 2,
            top: (190 - height) / 2
        });
        currentRatio = minRatio = 190 / (moreWidth ? primaryHeight : primaryWidth);
        slider.attr('cx', startX);
        progress.attr('width', 0);
        clip.ratio = currentRatio;
        clip.width = currentRatio * primaryWidth;
        clip.height = currentRatio * primaryHeight;
        clip.x = width - 190;
        clip.y = height - 190;
    };
    //图片拖拽点坐标及起始定位，XY=拖拽运算边界
    var dragX, dragY, dragLeft, dragTop,
		maxXY = (340 - 190) / 2,
		minXY = (340 + 190) / 2;
    $(".largeImg.view").mousedown(function (event) {
        dragging = true;
        dragX = event.clientX;
        dragY = event.clientY;
        dragLeft = parseInt(IMAGE.css('left'));
        dragTop = parseInt(IMAGE.css('top'));
    }).mousemove(function (event) {
        window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
        if (!dragging) return;
        var deltax = event.clientX - dragX,
			deltay = event.clientY - dragY,
			left = Math.min(Math.max(dragLeft + deltax, minXY - IMAGE.width()), maxXY),
			top = Math.min(Math.max(dragTop + deltay, minXY - IMAGE.height()), maxXY);
        IMAGE.css({
            left: left,
            top: top
        });
        IMAGECLONE.css({
            left: left - maxXY,
            top: top - maxXY
        });
        clip.x = maxXY - left;
        clip.y = maxXY - top;
    }).mouseup(function () {
        dragging = false;
    }).mouseleave(function () {
        dragging = false;
    });
})();

$(window).load(function () {
    if (typeof getImage != 'undefined')
        setTimeout(getImage, 5000);
});

function noFixed() {
    var noFixed = $('.noFixed'),
		subWindow = noFixed.find(".CENTERDIV");

    if (noFixed.size()) {
        var noFixedH = noFixed.height(),
			docH = $(document).height();
        noFixedH < docH ? noFixed.height(docH) : $(document.body).height(noFixedH);

        if (!subWindow.size()) return;

        var scrTop = $(window).scrollTop();
        subWindow.each(function (index, el) {
            $(el).css({
                position: "absolute",
                top: ($(window).height() - $(el).height()) / 2 + scrTop,
                //marginTop: -($(el).height()/2),
                left: $(window).width() / 2,
                marginLeft: -($(el).width() / 2),
            })
        });
    }
}
/*
 定义弹出层，调用方法：CENTERDIV.open.call(jquery.selector);
 */
var CENTERDIV = {
    init: function () {
        if ($(this).data("init")) return;
        var _this = this;
        $(this).find("dt q,.cancel").click(function () {
            CENTERDIV.close.call(_this);
        });
        $(this).data("init", true);
        CENTERDIV.move.call(this, { move: 'both', hander: 'dt:first' });
    },
    open: function (activeObject) {
        CENTERDIV.init.call(this);
        $(this).show().siblings().hide();
        $(this).closest("table").fadeIn();
        var datas;
        if (activeObject && (datas = $(this).data("datas")) && (datas = datas.split(' ')) && datas.length) {
            /*
			中心层在打开时，会将激活对象上的数据，绑定到自身，及自身内需要对应数据的元素中
			如果是SELECT或INPUT元素，则设置成其value，否则为其内的纯文本字符串
			激活对象上使用：data-某属性=""
			中心层上使用：data-datas="属性1 属性2 ...."
			中心层内的元素上使用：data-datas="对应属性1 对应属性2 "
			******属性列表data-datas，一定要用空格隔开，不要使用逗号，因为选择器~=是按空格计算的，没有按逗号算的选择器
			每次重新打开后，都会更换中心层的data-object属性为新打开的激活对象
			*/
            for (var i = 0; i < datas.length; i++) {
                var name = datas[i],
					data = $(activeObject).data(name);
                $(this).data(name, data)
					.find("[data-datas~='" + name + "']").each(function () {
					    if ('select,input,textarea'.match(this.tagName.toLowerCase()))
					        $(this).val(data).change();
					    else $(this).text(data);
					    $(this).attr('data-' + name, data);//这句是为了让F12上显示的属性也跟着变，以方便检查
					});
            }
            $(this).data('object', activeObject);
        }

        CENTERDIV.fixed.call(this);
        //noFixed();

        //CENTERDIV.move.call(this);
    },
    fixed: function () {
        var noFixed = $(this).closest("table");

        var browserHeight = $(window).height();
        var browserWidth = $(window).width();

        var centerdivtop = (browserHeight - $(this).height()) / 2;  //计算元素距离页面顶部
        var centerdivleft = (browserWidth - $(this).width()) / 2;   //计算元素距离页面左边

        if (browserHeight < $(this).height()) {
            centerdivtop = 0;
        }

        if (browserWidth < $(this).width()) {
            centerdivleft = 0;
        }

        if (noFixed.hasClass("noFixed")) {
            var noFixedH = noFixed.height(),
                docH = $(document).height();
            noFixedH < docH ? noFixed.height(docH) : $(document.body).height(noFixedH);

            var scrTop = $(window).scrollTop();
            var top = ($(window).height() - $(this).height()) / 2 + scrTop;
            if (top < 0) top = 0;
            $(this).css({
                position: "absolute",
                top: top,
                left: $(window).width() / 2,
                marginLeft: -($(this).width() / 2)
            });

            centerdivtop += $(window).scrollTop();
        }

        //---初始化
        $(this).css({
            position: "absolute",
            top: centerdivtop,
            left: centerdivleft,
            margin: ""
        });
    },
    close: function () {
        $(this).removeData('object').closest("table").fadeOut();
        $(this).find("input[type='hidden']")
            .each(function () {
                //不清除mvc生成checkbox所附带隐藏域，否则提交校验失败
                if ($(this).prop('name') && $(this).siblings('#' + $(this).prop('name')).length > 0) return true;
                $(this).val('');
            })
            .end()
		    .find(".CenterItems a").remove();
    },

    move: function (data) {
        var $this = $(this);
        var xPage;
        var yPage;
        var X;//
        var Y;//
        var xRand = 0;//
        var yRand = 0;//
        var father = $this.closest('.FullScreenPlugin');
        var defaults = {
            move: 'both',
            randomPosition: true,
            hander: 1
        }
        var opt = $.extend({}, defaults, data);
        var movePosition = opt.move;
        var random = opt.randomPosition;

        var hander = opt.hander;

        if (hander == 1) {
            hander = $this;
        } else {
            hander = $this.find(opt.hander);
        }
        hander.css({ "cursor": "move" });
        var faWidth = window.innerWidth;//元素移动的层大小
        var faHeight = window.innerHeight;
        var thisWidth = $this.width() + parseInt($this.css('padding-left')) + parseInt($this.css('padding-right'));
        var thisHeight = $this.height() + parseInt($this.css('padding-top')) + parseInt($this.css('padding-bottom'));

        var mDown = false;//
        var positionX;
        var positionY;
        var moveX;
        var moveY;

        hander.mousedown(function (e) {
            //在鼠标点击的时候重新获取当前浏览器尺寸
            faWidth = $(window).width();
            faHeight = $(window).height();

            thisWidth = $this.width();
            thisHeight = $this.height();

            mDown = true;
            X = e.pageX;
            Y = e.pageY;
            positionX = $this.position().left;
            positionY = $this.position().top;

            $(document).on('mousemove', mouseMove);
            $('body').on('selectstart', disableSelect);

            return false;
        });

        $(document).mouseup(function (e) {
            mDown = false;
            $(document).off('mousemove', mouseMove);
            $('body').off('selectstart', disableSelect);
        });

        function disableSelect() {
            return false;
        }

        function mouseMove(e) {
            xPage = e.pageX;//--
            moveX = positionX + xPage - X;

            yPage = e.pageY;//--
            moveY = positionY + yPage - Y;

            var scrollTop = null;

            if ($this.closest('.FullScreenPlugin').hasClass('noFixed')) {
                scrollTop = $(window).scrollTop();
            }

            function thisAllMove() { //全部移动
                if (mDown == true) {
                    $this.css({ "left": moveX, "top": moveY });
                } else {
                    return;
                }

                if (moveX < 0) {
                    $this.css({ "left": "0" });
                }

                if (moveX > (faWidth - thisWidth)) {
                    $this.css({ "left": faWidth - thisWidth });
                }

                if (scrollTop == null) {

                    if (moveY > (faHeight - thisHeight)) {
                        $this.css({ "top": faHeight - thisHeight });
                    }
                }

                if (moveY < 0) {
                    $this.css({ "top": 0 });
                }
            }

            thisAllMove();
        }
    }
};
$(".CENTERDIV").each(function () {
    var actives = $(this).data('active'),
        THIS = this;
    if (actives) {
        $(actives).click(function () {
            CENTERDIV.open.call(THIS, this);
        });
        $(this).find("dt q,.cancel").click(function () {
            CENTERDIV.close.call(THIS);
        });
    }
});
// 多选地址
$("dl[data-multiple]").delegate('input', 'click', function (event) {
    event.stopPropagation();

    var areaText = [], ids = [];

    var input = $(this).closest('dd').siblings(':hidden'),
        dt = $(this).closest('dd').siblings('dt');

    if ($.trim(input.val()) != '') {
        ids = $.trim(input.val()).split(',');
        areaText = $.trim(dt.text()).split(',');
    }

    var parentDl = $(this).closest('dl'),
        showTextDD = parentDl.find('dd'),
        hidentInput = parentDl.find('[type="hidden"]'),
        childA = $(this).siblings('a'),
        showText = childA.text(),
        infinite = showTextDD.find('[data-id=""]').siblings(),
        len = areaText.indexOf(showText),
        len2 = ids.indexOf(childA.data("id") + '');

    if (len == -1) {
        ids.push(childA.data("id"));
        areaText.push(showText);
    } else {
        ids.splice(len2, 1);
        areaText.splice(len, 1);
    }

    if (!childA.data("id")) {
        areaText = [];
        ids = [];
        showTextDD.find("input").not($(this)).prop("checked", false);
    } else {
        infinite.prop("checked", false);
    }
    setID.call(parentDl, ids.join(','));
    setText.call(parentDl, areaText.toString());
}).find('[type=hidden]').each(multAddressInit);
// 初始化多选地址
function multAddressInit() {
    var inIds = $(this).val() && $(this).val().split(','),
        showDL = $(this).closest('dl'),
        showDD = $(this).siblings('dd');

    var inAreaText = [];
    $(inIds).each(function (idx, id) {
        showDD.find('[data-id="' + id + '"]').siblings().prop("checked", true);
        if (id == "") return false;
        var me = GetArea(id);
        inAreaText.push(me[0]);
    });
    setText.call(showDL.get(0), inAreaText);
}
//写入自定义确认窗
(function () {
    var str = [];
    str.push("<table class=\"FullScreenPlugin black5\"><tr><td>");
    str.push("    <div class=\"CONFIRM\">");
    str.push("        <h6>确认窗标题<\/h6>");
    str.push("        <div><p>大段内容大段内容大段内容大段内容大段内容<\/p><\/div>");
    str.push("        <q class=\"clear\"><a class=\"confirm\">确认<\/a><a class=\"cancel\">取消<\/a><\/q>");
    str.push("    <\/div>");
    str.push("<\/td><\/tr><\/table>");
    str.push("");
    str = str.join('');
    /*
	oDOM，被点击激活确认窗的一个DOM对象
	setOptions集合中可使用的配置键名有
		topic，字符串，窗体标题，默认为“请您确认”
		content，字符串，HTML内容，默认与topic一样
		confirm，字符串，确认字样，默认为“确认”
		cancel，字符串，取消字样，默认为“取消”
		timer，毫秒整数，默认为0不自动关闭，否则经过毫秒数之后将自动关闭
		onconfirm，函数，点击确认事件，默认为空
		oncancel，函数，点击取消事件，默认为空
			 onconfirm及oncancel的参数，第一为custom即窗体的JQ对象，第二为datas数据集合
			 也就是在两个回调中，使用this可以控制窗体的JQ对象
		datas，逗号连接字符串序列，需要从oJQ上读取的data集合名
	*/
    var custom = $(str);
    custom.appendTo("body");
    window.CONFIRM = function (oDOM, setOptions) {
        var datas = {};
        if (!$.isPlainObject(setOptions)) setOptions = {};
        if (oDOM && setOptions.datas) {
            var keys = setOptions.datas;
            !$.isArray(keys) && (keys = keys.split(','));
            for (var n in keys) {
                var key = keys[n];
                datas[key] = $(oDOM).data(key);
            }
        }
        var topic = setOptions.topic || '请您确认';
        custom.find("h6").text(topic)
			.siblings("div").html(setOptions.content || topic)
			.siblings("q")
				.find(".confirm").text(setOptions.confirm || '确认')
				.siblings(".cancel").text(setOptions.cancel || '取消');
        $.isFunction(setOptions.onconfirm) && custom.find(".confirm").off('click').click(function () {
            setOptions.onconfirm.call(custom, datas);
        });
        custom.find(".cancel").off('click').click(function () {
            if ($.isFunction(setOptions.oncancel))
                setOptions.oncancel.call(custom, datas);
            else custom.fadeOut();
        });
        setOptions.timer > 0 && setTimeout(function () {
            custom.fadeOut();
        }, setOptions.timer);
        custom.fadeIn();
    };
    window.CONFIRM.close = function () {
        custom.fadeOut();
    }

})();


//先检查大列表中的被选项数量，然后再决定批量处理按钮是否可用，可用时，所有的批量按钮上已经有了data-id="ID序列"
(function () {
    var boxes = $(".List :checkbox").change(function () {
        var checks = boxes.filter(":checked");
        $(".batch").prop('disabled', checks.length == 0)
			.each(function () {
			    var need = $(this).data("need"),
					ids = [];
			    checks.each(function () {
			        var id = $(this).data(need);
			        if ($.inArray(id, ids) == -1) ids.push(id);
			    });
			    ids = ids.join(',');
			    $(this).data('id', ids).attr('data-id', ids);
			})
        ;
    });
    boxes.eq(0).change();
})();

/*
含有模板弹出窗的初始化功能，
参数arrays为直接放入模板数据数组名的数组，例如[array1,array2...]
参数selectors为弹出窗的类名（不加“.”）字符串数组，例如['Class1','Class2'...]
*/
function InitTemplates(arrays, selectors) {
    if (arrays.length != selectors.length) alert('初始化模板参数错误，数组长度不相等！');
    for (var i = 0; i < arrays.length; i++) {
        var datas = arrays[i],
			center = $("." + selectors[i]),
			list = center.find(".Templates").data('template', datas),
			option = [];
        for (var j = 0; j < datas.length; j++) {
            var temp = datas[j];
            option.push('<a data-id="', temp.id, '" data-content="', escape(temp.content), '">', temp.title, '</a>');
        }
        list.find("dd").empty().html(option.join(''));
        list.find("input[type=hidden]").change(function () {
            var id = this.value,
				textarea = $(this).closest(".CENTERDIV").find(".TemplateContent"),
				content = $(this).closest(".SELECT").find("dd a.checked").data("content");
            textarea.val(unescape(content));
        });
    }
}
//含有发送邮件/发送邀请/职位推荐等功能的初始化行为
(function () {
    //在CENTERDIV获取了被选中的id之后，隐藏域改变，顺便把统计数放入显示统计的位置
    $(".checkedIds").change(function () {
        var ids = this.value.split(',');
        $(this).closest("td").find(".IdsCounter").text(ids.length);
    });
    //粘贴ID的时候全选，方便直接覆盖已有内容
    $(".JobId").focus(function () {
        this.select();
    });
    //(移动至页面)
    //粘贴职位信息ID时，要异步获取对应的职位名称，如果正确的话，显示在标签搜集器中，并将ID加入隐藏域
    //$(".JobIdAdd").click(function(){
    //	var JobId=$(this).prev(".JobId"),
    //		id=JobId.val();
    //	if(!id || !id.match(/^\d+$/)) {alert('请填写正确的职位信息的ID');return false;}
    //	var JobIds=$(this).next(".JobIds"),
    //		ids=JobIds.val().split(','),
    //		items=$(this).closest("tbody").find(".CenterItems");
    //	if($.inArray(id,ids)>=0){
    //		alert('此职位信息已经存在！');
    //		//此为已存在的项目，先变大后变小的效果，以方便提示是哪个
    //		items.find('[data-id="'+ id +'"]').transit({scale:1.2},300,'linear',function(){
    //			$(this).transit({scale:1});
    //		});
    //		return false;
    //	}
    //	!ids[0] && ids.splice(0,1);
    //	ids.push(id);
    //	var title,//='临时测试标题',//异步获取职位信息标题
    //		THIS=this;
    //    //将AJAX的succes配置指向这个匿名函数
    //	function success(data) {
    //	    title = data.title;
    //	    items.prepend('<a data-id="' + id + '">' + title + '</a>');
    //	    JobIds.val(ids.join(','));
    //	    JobId.val('');
    //	}
    //	$.ajax({
    //	    url: "/Admin/Resumes/ajax.html",
    //	    data: { cmd: "getoffername", offerid: id },
    //	    cache: false,
    //	    dataType: "json",
    //	    success: function (data) {
    //	        if (data.success) {
    //	            success(data.data)
    //	        }
    //	        else {
    //	            alert(data.msg);
    //	        }
    //	    }
    //	});
    //});
    //职位搜索器中点叉，对应的标签删除，但ID返回到输入框，以防误操作后可以容易加回
    $(".CenterItems").click(function (event) {
        var a = event.target;
        if (a.tagName != 'A') return;
        var id = $(a).data('id'),
			JobIds = $(this).closest("tbody").find(".JobIds"),
			ids = JobIds.val().split(','),
			index = $.inArray(id, ids);
        $(a).remove();
        ids.splice(index, 1);
        JobIds.val(ids.join(','));
        JobIds.siblings(".JobId").val(id);
    });

    //点击复制ID
    if (typeof ZeroClipboard != 'undefined') {
        ZeroClipboard.config({ swfPath: "/js/zeroclipboard/ZeroClipboard.swf" });
        var client = new ZeroClipboard($("th label + i")),
			id;
        client.on('copy', function (event) {
            id = $(event.target).prev("label").find("input").val()
            event.clipboardData.setData('text/plain', id);
        });
        client.on('aftercopy', function (event) {
            alert("成功复制【" + id + "】");
        });
    }
})();

//相同的处理方式，点击下架（此方法已移动到页面上）
//$(".offline").click(function(){
//	var id=$(this).data('id'),
//		name=$(this).data('name') || '',
//		content=$(this).data('content') || '';
//	CONFIRM(this,{
//		topic:'备注信息（下架原因）',
//		content:'<p class="ConfirmTip">职位：'
//			+ (id.toString().indexOf(',')>0 ? (id.split(',').length+'个'): name)
//			+'</p>'
//			+'<textarea class="ConfirmTextarea">'+ content +'</textarea>',
//		onconfirm:function(){
//			alert('确认下架');
//		}
//	});
//});
//相同的处理方式，点击备注
$(".memory").click(function () {
    var id = $(this).data('id'),
		name = $(this).data('name'),
		content = $(this).data('content') || '';
    CONFIRM(this, {
        topic: '备注信息',
        content: '<p class="ConfirmTip">职位：' + name + '</p><textarea class="ConfirmTextarea">' + content + '</textarea>',
        onconfirm: function () {
            alert('确认');
        }
    });
});



//上传更新企业相册

//更新上传企业相册，src为图片路径，idx为要更新图片或插入图片的位置，如8张图片中具体哪一张
function upImg(src, obj) {



    if (src) {
        var figure = $('.albums').find('.clipAttrs');
        var figure_val = figure.val();

        $img = $('<img src=' + src + ' width="158" height="118">')
        obj.find('p').hide();
        if (obj.find('img').length != 0) {


            var oldSrc = obj.find('img').attr("src");
            obj.find('img').attr("src", src)
            figure.val(figure_val.replace(oldSrc, src))

        } else {
            obj.prepend($img);
            figure.val(figure_val + "," + src);
        }

        obj.append($("<q></q>"))
        obj.find('q').click(function (event) {
            var src = $(this).closest('.figure').find('img').attr("src");
            figure_val = figure.val();
            figure.val(figure_val.replace(src, ""))
            obj.find('img').remove();
            $(this).remove();
            $(this).closest('p').show();
        });
    }



}


$("body").on('mouseenter.figureGo', ".figure:has(img[src!=''])", function () {
    $(this).find("p").show();
}).on('mouseleave.figureTo', ".figure:has(img)", function () {
    $(this).find("p").hide();
}).find(".figure:has(img) p").hide();

//添加职位类别
$(".KEY-GUIDANCE").on('keyup focus click', function (event) {
    var key = event.which;
    if ($.inArray(key, [40, 38, 13]) >= 0 && event.type == 'keyup') return true;
    key = this.value;
    var dl = $(this).closest('dl'),
			dd = dl.find('dd'),
			tip = dd.find('.tip'),
			result = dd.find('.matches'),
			oDOMselect = $(this).closest(".SELECT").get(0);
    SELECT.open.call(oDOMselect);
    if (!key) {//无关键字则收回提示及匹配
        tip.html('↑请输入相关职位类别').show();
        result.hide();
        return true;
    }
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
    }
    else {//修改提示
        //tip.html('对不起，找不到符合'+ key +'的职位').show();
        result.hide();
        SELECT.close.call(oDOMselect, true);
    }
});

//拨打电话
var phoneNum = "";
var seatNum = "";
function gpCallPhoe(phone, seat) {
    if (!phone) {
        alert("请输入电话号码!");
        return;
    }
    if (!seat) {
        alert("未设置电话坐席号!");
        return;
    }

    phoneNum = phone;
    seatNum = seat;
    var regMobile = new RegExp("^1\\d{10}");

    if (regMobile.test(phoneNum)) {
        $.ajax({
            url: "http://apis.juhe.cn/mobile/get?callback=getPhoneNumInfoExtCallback&phone=" + phoneNum + "&dtype=jsonp&key=982be6053f7994e704ab62b0c6ad682f",
            dataType: "jsonp",
            type: "get",
            jsonp: "getPhoneNumInfoExtCallback"
        });
    } else {
        phoneNum = phoneNum.replace("-", "");
        if (new RegExp("^020\\d+").test(phoneNum)) {
            phoneNum = phoneNum.substr(3);
        }
        getPhoneNumInfoExtCallback();
    }
}
function getPhoneNumInfoExtCallback(data) {
    if (data && data.result && data.result.city != "广州") {
        phoneNum = "0" + phoneNum;
    }
    var url = "http://192.168.1.200:90/dail.php?ch=" + seatNum + "&telephone=" + phoneNum;
    $.ajax({
        url: url,
        dataType: "jsonp",
        async: false,
        type: "get",
        jsonp: "callStudentCallback"
    });
}
function callStudentCallback(data) {
    if (!data.state) {//失败
        alert(data.msg);
    } else {//成功
        alert(data.msg);
    }
} $(".KEY-GUIDANCE").on('keyup focus click', function (event) {
    var key = event.which;
    if ($.inArray(key, [40, 38, 13]) >= 0 && event.type == 'keyup') return true;
    key = this.value;
    var dl = $(this).closest('dl'),
			dd = dl.find('dd'),
			tip = dd.find('.tip'),
			result = dd.find('.matches'),
			oDOMselect = $(this).closest(".SELECT").get(0);
    SELECT.open.call(oDOMselect);
    if (!key) {//无关键字则收回提示及匹配
        tip.html('↑请输入相关职位类别').show();
        result.hide();
        return true;
    }
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
    }
    else {//修改提示
        //tip.html('对不起，找不到符合'+ key +'的职位').show();
        result.hide();
        SELECT.close.call(oDOMselect, true);
    }
});
var addTab = {
    dl: $(".addTabs"),
    addTabWin: $(".addTabWin"),

    init: function () {
        // 标签管理事件
        this.addTabs();
        // 选择标签事件
        this.selectTab();
        // 重置
        this.reset();
        return this;
    },
    reset: function () {
        // 初始化选中的标签
        var hiddenID = this.dl.find('[type="hidden"]'),
            ids = hiddenID.val() && hiddenID.val().split(','),
            tab = this.dl.find('.tab'),
            name = [];

        tab.find('span').removeClass('selected');
        if (!ids) return false;


        for (var i = 0, len = ids.length; i < len; i++) {
            name.push(tab.find('[data-id="' + ids[i] + '"]').addClass('selected').text());
        }
        this.dl.find('dt').text(name.join(','))
    },
    // 标签管理
    addTabs: function () {
        var tabIpt = this.addTabWin.find('.tabInput input'),
            tabs = this.addTabWin.find(".tabs"),
            hiddenID = this.dl.find('[type="hidden"]'),
            submit = this.addTabWin.find('.submit'),
            addTabObject = this;

        if (!(tabIpt[0] && tabs[0] && hiddenID[0] && submit[0])) return false;

        // 输入标签
        tabIpt.on("keyup", function (event) {
            if (event.keyCode === 13) {
                if ((this.value.length > 6) || (!this.value.length)) {
                    alert("请输入正确格式的标签!");
                    return false;
                }
                var tab = this.value;
                this.value = '';
                $.ajax({
                    url: '/admin/boctag/add',
                    data: { name: tab },
                    type: 'POST',
                    dataType: 'JSON',
                    beforeSend: ajaxBegin,
                    success: function (result) {
                        if (!result.success) {
                            alert(result.msg);
                            return;
                        }

                        span = "<span data-id=" + result.data.id + ">" + result.data.name + "</span>";
                        tabs.append(span);
                    },
                    error: function () {
                        alert('提交失败，请稍候再试');
                    },
                    complete: ajaxComplete
                });
            }
        });
        // 标签管理 —— 标签删除
        tabs.delegate('span', 'click', function (event) {

            var self = this;

            CONFIRM(this, {
                topic: "确定删除？",
                onconfirm: function () {
                    $.ajax({
                        url: '/admin/boctag/delete',
                        data: { id: $(self).data("id") },
                        type: 'POST',
                        dataType: 'JSON',
                        beforeSend: ajaxBegin,
                        success: function (result) {
                            if (!result.success) {
                                alert(result.msg);
                                return;
                            }

                            $(self).remove();
                            CONFIRM.close();
                        },
                        error: function () {
                            alert('提交失败，请稍候再试');
                        },
                        complete: ajaxComplete
                    });
                }
            })
        });
        // 标签管理 —— 保存标签
        submit.on("click", function (event) {
            var newTabs = tabs.find("[data-id]"),
                ajaxData = [];

            var tabSelect = addTabObject.dl;

            if (!newTabs.length) {
                alert('如果没有新增标签，请点击取消按钮');
                return false;
            }

            tabSelect.find(".tab").find("span:not('.add_btn')").remove().end().prepend(newTabs);
            CENTERDIV.close.call($(".addTabWin").get());
        });

    },
    // 岗位标签
    selectTab: function () {
        var addTabs = this.dl
        add_btn = addTabs.find('.add_btn'),
        tabs = this.addTabWin.find(".tabs"),
        selectTab = addTabs.find('.tab'),
        self = this;
        // 打开标签管理
        add_btn.on("click", function (event) {
            var spans = addTabs.find('.tab span:not(.add_btn)');
            tabs.html(spans.clone());
            CENTERDIV.open.call($(".addTabWin").get(), this);
        });

        // 选择标签
        selectTab.delegate('span:not(".add_btn")', 'click', function (event) {

            $(this).toggleClass('selected');
        });
        // 确定按钮
        addTabs.find('.confirm_btn').on("click", function (event) {
            var selected = selectTab.find('.selected'),
                hiddenID = addTabs.find("[type='hidden']"),
                ids = [], name = [];

            selected.each(function (index, el) {
                ids.push($(el).data("id"));
                name.push(el.innerText);
            });

            hiddenID.val(ids.join(','));
            addTabs.find('dt').text(name.join(',')).attr("title", name.join(','));

            addTabs.removeClass('on');
        });
        // 取消按钮
        addTabs.find('.cancel_btn').on("click", function (event) {
            addTabs.removeClass('on');
            self.reset();
        });
    }
}.init();
$('.markedTip').mouseenter(function (event) {
    var target = $(this).siblings('.markedTipWin'),
        thisHeight = target.height() + 35;
    target.css({ top: -thisHeight + 'px' }).show();
}).mouseleave(function (event) {
    $(this).siblings('.markedTipWin').hide();
});
//$(function () {
//    // 求职标签
//    var jobsTab = ["销售", "客服", "运营", "策划", "推广", "督导", "美导", "老师", "其他"];

//    var tmp = [];

//    for (var i = 0, len = jobsTab.length; i < len; i++) {
//        tmp.push("<a data-id=" + (i + 1) + ">" + jobsTab[i] + "</a>")
//    }
//    $(".jobsTab").find('dd tbody td').html(tmp.join(""));

//    // 标记简历状态
//    $(".reasonTxt").delegate('span', 'click', function (event) {
//        $(".reasonTxt").siblings('textarea').val($(this).text());
//    });
//})