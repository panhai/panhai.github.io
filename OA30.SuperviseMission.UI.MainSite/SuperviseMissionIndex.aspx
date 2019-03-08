<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionIndex.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查系统</title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <link rel="stylesheet" type="text/css" href="Css/bootstrap-select.css" />
    <style type="text/css">
        .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 100%;
        }

        .search-part .search-control .dropdown-menu {
            width: 96%;
            margin-left: -15px;
        }

        .search-part .search-control .dc .dropdown-menu {
            padding-left: 0;
            width: 100%;
            margin-left: -15px;
        }

        .search-part .search-control .row + .row + .form-group {
            padding-bottom: 15px;
        }

        .search-part .search-control .col-sm-9, .dc, .search-part .search-control .col-sm-3 + .col-sm-4 {
            padding-left: 0;
        }

        .form-group .bootstrap-select {
            width: 100%;
        }
        .list-part .list-box li .ffd span.l {
            width:auto;
        }
        .list-part .list-box li {
            padding-bottom: 0;
            padding-top: 0;
            line-height: 30px;
            height: 35px;
            border-bottom: 1px dashed #ededed;
            position:relative;
        }
            .list-part .list-box li .ffd {
                    width: 95%;
                    text-overflow: ellipsis;
                    overflow: hidden;
                    white-space: nowrap;
            }
                .list-part .list-box li .ffd em {
                    position:absolute;
                    right:0;
                    top:30px;
                }
        .main {
            min-height: 600px;
        }

        .list-part {
            height: 980px;
            margin-top: -10px;
            padding-top: 0;
            margin-left: -10px;
        }

        .search-part .search-control .col-one .col-lg-3 {
            padding-right: 10px;
        }

        .search-part .search-control .dropdown-menu label {
            margin-left: 0;
        }

        .search-part .search-control label {
            text-align: right;
            margin-left: -20px;
            padding-right: 10px;
        }

        .search-part {
            margin-bottom: -10px;
        }
    </style>
</head>
<body>
    <div class="main">
        <div class="list-part">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#year" aria-controls="year" smtype="1" role="tab" data-toggle="tab">年度重点工作任务 <span class="badge badge-default year"></span></a></li>
                <li role="presentation"><a href="#leader" aria-controls="leader" role="tab" smtype="2" data-toggle="tab">领导行政例会督查任务 <span class="badge badge-default leader"></span></a></li>
                <li role="presentation"><a href="#manage" aria-controls="manage" role="tab" smtype="3" data-toggle="tab">总经理办公会督查任务 <span class="badge badge-default manage"></span></a></li>
                <li role="presentation"><a href="#other" aria-controls="other" role="tab" smtype="4" data-toggle="tab">其他重要工作任务 <span class="badge badge-default other"></span></a></li>
            </ul>
            <div class="search-part">
                <div class="form-group has-feedback">
                    <label class="control-label sr-only" for="inputSuccess5"></label>
                    <input type="hidden" class="form-control" aria-describedby="inputSuccess5Status" />
                    <span class="form-control" id="search-input"></span>
                    <span class="iconfont icon-sv-search form-control-feedback" aria-hidden="true"></span>
                    <div class="search-filter">
                    </div>
                </div>
                <div class="search-control" style="display: none;">
                    <div class="row">
                        <div class="col col-lg-10 col-md-10 col-sm-10 col-xs-10 col-one">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-3 col-md-3 col-xs-3 col-lg-3 control-label">关键字</label>
                                <div class="col-sm-9 col-md-9 col-xs-9 col-lg-9">
                                    <input type="text" class="form-control" name="keyWord" id="keyWord" placeholder="请输入关键字搜索" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col col-lg-5 col-md-5 col-sm-5 col-xs-5">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-3 col-md-3 col-xs-3 col-lg-3 control-label">主办单位</label>
                                <div class="col-sm-9 col-md-9 col-xs-9 col-lg-9 dropdown dc">
                                    <select name="unit" data-live-search="true" class="selectpicker form-control">
                                    </select>
                                    <!--<input name="unit" type="text" class="form-control" data-toggle="dropdown" placeholder="请选择主办单位" />-->
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-3 col-md-3 col-xs-3 col-lg-3 control-label">创建时间</label>
                                <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4">
                                    <input type="text" class="form-control input-time" name="beginDate" id="beginDate" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" placeholder="请选择创建时间" readonly="readonly" />
                                </div>
                                <label class="col-sm-1 col-md-1 col-xs-1 col-lg-1" style="width: 20px; text-align: center; padding: 0; margin-left: 2px; margin-right: 3px;">至</label>
                                <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4" style="width: 36.3333%">
                                    <input type="text" class="form-control input-time" name="endDate" id="endDate" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" placeholder="请选择创建时间" readonly="readonly" />
                                </div>
                            </div>
                        </div>
                        <div class="col col-lg-5 col-md-5 col-sm-5 col-xs-5">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-3 col-md-3 col-xs-3 col-lg-3 control-label">文档ID</label>
                                <div class="col-sm-9 col-md-9 col-xs-9 col-lg-9 dropdown">
                                    <input type="text" id="smId" class="form-control" name="smId" placeholder="请输入文档ID" />
                                </div>
                            </div>
                            <div class="form-group clearfix status-col dropdown">
                                <label for="" class="col-sm-3 col-md-3 col-xs-3 col-lg-3 control-label">选择状态</label>
                                <div class="col-sm-9 col-md-9 col-xs-9 col-lg-9 stb">
                                    <input type="text" class="form-control " id="inputStatus" placeholder="请选择状态" data-toggle="dropdown" role="button" data-status="more" readonly="readonly" />
                                    <span class="iconfont icon-sv-add form-control-feedback" aria-hidden="true" data-toggle="dropdown" role="button" data-status="more"></span>
                                    <ul class="list-unstyled dropdown-menu dmst">
                                        <li>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="FJ" />
                                                    任务分解中</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="TJ" />
                                                    任务推进中</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="BJ" />
                                                    任务办结</label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col col-lg-2 col-md-2 col-sm-2 col-xs-2" style="margin-top: -15px;">
                            <div class="form-group">
                                <button class="btn btn-primary btn-primary-c search-btn">查询</button>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary btn-default-c reset-btn">重置</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="year">
                    <ul class="list-box list-unstyled" id="box-0">
                    </ul>
                    <div class="tar">
                        <nav aria-label="Page navigation" class="pagination" id="page1">
                        </nav>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane " id="leader">
                    <ul class="list-box list-unstyled" id="box-1">
                    </ul>
                    <div class="tar">
                        <nav aria-label="Page navigation" class="pagination" id="page2">
                        </nav>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane " id="manage">
                    <ul class="list-box list-unstyled" id="box-2">
                    </ul>
                    <div class="tar">
                        <nav aria-label="Page navigation" class="pagination" id="page3">
                        </nav>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane " id="other">
                    <ul class="list-box list-unstyled" id="box-3">
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script>
        require.config({
            baseUrl: "Script",
            paths: {
                jquery: 'jquery'
            },
            shim: {
                jquery: {
                    exports: 'jquery'
                },
                bootstrap: {
                    deps: ['jquery']
                }
            }
        });
        require(['jquery','cs-page','AJAX','bootstrap','picker','bootstrap-select'], function ($,csPage,Ajax) {
            $(function () {
                //搜索框
                $(document).on('click', function (e) {
                    var statusCheck = [];
                    var target = $(e.target);
                    $('.search-control').show();
                    if (target.closest('.search-part').length === 0) {
                        $('.search-control').hide();
                        $('.status-list').hide();
                    }
                    if (target.closest('.status-col').length === 0) {
                        $('.status-list').hide();
                    }

                    if (target.closest('.stb').length === 1) {
                        $('#inputStatus').dropdown('toggle')
                        target.closest('.stb').addClass('open')
                    }
                    if (target.closest('.status-list').length === 1) {
                        var checkObj = target.closest('.status-list');
                        if (target.is(':checked') && statusCheck.indexOf(target.next().text()) === -1) {
                            statusCheck.push(target.next().text());
                        } else {
                            statusCheck.splice(statusCheck.indexOf(target.next().text()), 1);
                        }
                    }
                })
                //日历
                $('.input-time').datetimepicker({
                    language: 'zh-CN',
                    weekStart: 1,
                    autoclose: 1,
                    todayHighlight: 1,
                    startView: 2,
                    minView: 2,
                    clearBtn: true,
                    forceParse: 0
                });
                $(document).on('click', '.input-time', function () {
                    $(this).datetimepicker('show');
                })

                $(document).on('change', '.dropdown-menu input', function (e) {
                    var event = $(e.target);
                    if (event.closest('.checkbox').hasClass('checkbox')) {
                        var status = [];
                        event.closest('.dropdown-menu').find('input').each(function (item) {
                            var text = event.closest('label').text().trim()
                            if ($(this).is(':checked')) {
                                status.push($(this).closest('label').text().trim())
                            }
                        })
                        event.closest('.dropdown').find('.form-control').val(status.toString())
                    } else {
                        thatPage.deptId = event.val()
                        event.closest('.dropdown').find('.form-control').val(event.closest('label').text().trim())
                    }
                })
                var flterArray = []


                //改变状态
                $(document).on('click', '.cbMissionStatus', function (e) {
                    var $this = $(e.target)
                    var value = $this.val()
                    var status = thatPage.status
                    if ($this.is(':checked') && !status.hasOwnProperty(value)) {
                        thatPage.status[value] = $this.parent().text().trim()
                    } else {
                        delete thatPage.status[value]
                    }
                })

                //重置搜索条件
                $(document).on('click', '.reset-btn', function (e) {
                    var event = $(e.target)
                    event.closest('.search-control').find('input[type="text"]').each(function () {
                        $(this).val('')
                    })
                    event.closest('.search-control').find('input[type="checkbox"],input[type="radio"]').each(function () {
                        $(this).prop('checked', false)
                    })
                    $('.selectpicker').selectpicker('val', '');
                    thatPage.beginDate = ''
                    thatPage.deptId = ''
                    thatPage.endDate = ''
                    thatPage.keyWord = ''
                    thatPage.company = ''
                    thatPage.missionStatus = []
                    thatPage.smId = ''
                    thatPage.unit = ''
                    thatPage.status = {}
                    $('.search-filter').html('')
                    SearchPageData(1, true);
                })
                //删除搜索条件
                $(document).on('click', '.search-filter span', function (e) {
                    var event = $(e.target)
                    var text = ''
                    var type = event.parent().data('type')
                    var key = event.parent().data('key')
                    if ($(e.target).hasClass('iconfont')) {
                        text = event.closest('span').text()
                        event.closest('span').remove()
                    } else {
                        text = event.text()
                        event.remove()
                    }
                    if (type) {
                        if (type === 'status') {
                            delete thatPage.status[key]
                            if (thatPage.missionStatus.indexOf(key) > -1) {
                                thatPage.missionStatus.splice(thatPage.missionStatus.indexOf(key), 1)
                            }
                            $('input[value="' + key + '"]').prop('checked', false)
                            var status = ''
                            $.each(thatPage.status, function (key, item) {
                                status += item + ','
                            })
                            $('#inputStatus').val(status)
                        } else {
                            if (type === 'unit') {
                                $(".selectpicker").selectpicker('val', '');
                                $('[name="company"]').prop('checked', false)
                            }
                            thatPage[type] = ''
                            $('[name="' + type + '"]').val('')
                        }
                    }
                    $('.search-filter').html(resetFilter())
                    SearchPageData(1, true);
                })
            
            var pager = [
                {
                    page: 1,
                    type: 1,
                    beginDate: '',
                    deptId: '',
                    endDate: '',
                    keyWord: '',
                    company: '',
                    missionStatus: [],
                    smId: '',
                    unit: '',
                    status: {},
                    searchText: '',
                },
                {
                    page: 1,
                    type: 1,
                    beginDate: '',
                    company: '',
                    deptId: '',
                    endDate: '',
                    keyWord: '',
                    unit: '',
                    missionStatus: [],
                    smId: '',
                    status: {},
                    searchText: ''
                },
                {
                    page: 1,
                    type: 1,
                    beginDate: '',
                    deptId: '',
                    company: '',
                    unit: '',
                    endDate: '',
                    keyWord: '',
                    status: {},
                    missionStatus: [],
                    smId: '',
                    searchText: ''
                },
                {
                    page: 1,
                    type: 1,
                    beginDate: '',
                    deptId: '',
                    endDate: '',
                    keyWord: '',
                    unit: '',
                    status: {},
                    company: '',
                    missionStatus: [],
                    smId: '',
                    searchText: ''
                }
            ]
            //第一次加载
            var pageSize = 20;
            //当前tab的页数和类型
            var thatPage = pager[0]
            //绑定部门下拉列表
            var ViewDept = function (data, cfg) {
                //var el = $("#company").empty();
                var el = $('.selectpicker').empty()
                var list = JSON.parse(data.data);
                if (list && list.length > 0) {
                    var lihtml = '<option name="company" value="">--请选择部门--</option>';
                    for (var i = 0; i < list.length; i++) {
                        var item = list[i];
                        //var lihtml = '<li><div class="radio"><label>';
                        //lihtml += '<input data-menu="dropdown" type="radio" name="company" value="' + (item.DeptName == "全部" ? "" : (item.DeptId || "")) + '"/>' + (item.DeptName || "");
                        //lihtml += '</label></div></li>';
                        lihtml += '<option name="company" value="' + (item.DeptName == "全部" ? "" : (item.DeptId || "")) + '">' + (item.DeptName || "") + '</option>';
                    }
                    el.append(lihtml);
                }
                //筛选控件
                $('.selectpicker').selectpicker('refresh');
            }
            //填充具体哪个类型的督查任务数据列表
            var ViewListData = function (data, cfg) {

                var smtypeid = $(".nav.nav-tabs").find("[smtype = '" + SmTypeToNumber(cfg.data.smType) + "']").attr("aria-controls");
                
                //显示任务数量
                var badgeSize = data.TotalCount
                $(".nav.nav-tabs ."+smtypeid).text(badgeSize)


                var el = $("#" + smtypeid + " >ul").empty();
                if (data.SmMainList && data.SmMainList.length > 0) {
                    for (var i = 0; i < data.SmMainList.length; i++) {
                        var item = data.SmMainList[i];
                        appendSM(el, item);
                    }
                    //$('.search-control').hide()
                    //初始化分页
                    if (cfg.isFristSearch) {
                        if (data.TotalCount > cfg.data.pageSize) {
                            $('#page' + SmTypeToNumber(cfg.data.smType)).show()
                            
                            $('#page' + SmTypeToNumber(cfg.data.smType)).csPage({
                                totalCounts: data.TotalCount,
                                pageSize: pageSize,
                                currentPage: thatPage.page,
                                onPageChange: function (num, type) {
                                    thatPage.page = num
                                    //分页事件
                                    if (type !== 'init') {
                                        SearchPageData(thatPage.page, false);
                                    }
                                }
                            });
                        } else {
                            $('#page' + SmTypeToNumber(cfg.data.smType)).hide()
                        }
                    }
                }
                else {
                    $('#page' + SmTypeToNumber(cfg.data.smType)).hide()
                    appendNone(el);
                }
            }
            //回车查询
            $(document).keydown(function (event) {
                var $this = $(event.target)
                if (event.keyCode == 13 && $this.closest('.search-part').find('.search-control').is(':visible')) {
                    $('.search-btn').trigger('click')
                }
            });
            //无数据展示
            var appendNone = function (el) {
                var html = '<li><div class="no-page"><div class="no-page-icon"></div><p>您好~~您还没有督查任务O(∩_∩)O</p></div></li>';
                $(el).append(html);
            }
            function toDetail() {

            }
            //添加SMmain记录
            var appendSM = function (el, obj) {
                var status = "";
                switch (obj.MissionStatus) {
                    case "TJ": { status = "任务推进中"; break; }
                    case "FJ": { status = "任务分解中"; break; }
                    case "JS": { status = "结束"; break; }
                    default: { status = "任务分解中"; break; }
                }
                var subTypeNmae = "";
                switch (obj.SubType) {
                    case "BJ": { subTypeNmae = "办结"; break; }
                    case "TZ": { subTypeNmae = "调整"; break; }
                    case "YQ": { subTypeNmae = "延期"; break; }
                    case "ZZ": { subTypeNmae = "中止"; break; }
                    default: { subTypeNmae = ""; break; }
                }
                var detailUrl = '';
                if (obj.SmType == "ND") {
                    detailUrl = 'SuperviseMissionDetail.aspx';
                }
                else if (obj.SmType == "LD") {
                    detailUrl = 'LeaderMeetingMissionDetail.aspx';
                }
                var lihtml = '<li><a target="_blank" class="ffd" href="' + detailUrl + '?smid=' + obj.SmId + '&smtype=' + obj.SmType + '&pagetype=FormPage"  title="' + obj.TaskContent + '" ><b class="ffs"><ins>【' + status + '】</ins>&nbsp;' + obj.SpNumberName + '【' + obj.SpNumberYear + '】' + obj.SpNumberCode + '号</b>';
                if (obj.SubType == "BJ" || obj.SubType == "TZ" || obj.SubType == "YQ" || obj.SubType == "ZZ") {
                    if (obj.SmType == "ND") {
                        lihtml =
                            '<li><a target="_blank" class="ffd" href="SuperviseMissionDelayModifyEndDetail.aspx?smid=' +
                            obj.SmId +
                            '&smtype=' +
                            obj.SmType +
                            '&subtype=' +
                            obj.SubType +
                            '&pagetype=FormPage"  title="' +
                            obj.TaskContent +
                            '" ><b class="ffs"><ins>【变更(' +
                            subTypeNmae +
                            ') ' +
                            status +
                            '】</ins>&nbsp;' +
                            obj.SpNumberName +
                            '【' +
                            obj.SpNumberYear +
                            '】' +
                            obj.SpNumberCode +
                            '号</b>';
                    } else {
                        lihtml = '<li><a target="_blank" class="ffd" href="LeaderMeetingMissionChangeModifyDetail.aspx?smid=' + obj.SmId + '&smtype=' + obj.SmType + '&subtype=' + obj.SubType + '&pagetype=FormPage"  title="' + obj.TaskContent + '" ><b class="ffs"><ins>【变更(' + subTypeNmae + ') ' + status + '】</ins>&nbsp;' + obj.SpNumberName + '【' + obj.SpNumberYear + '】' + obj.SpNumberCode + '号</b>';
                    }
                }
                //lihtml += '<i class="iconfont icon-sv-fav-s' + (obj.OrderValue == "" ? "hidden" : "") + '"></i>';
                //lihtml += '<ins>【' + (obj.MissionStatusName || "") + '】</ins>';
                lihtml += '<span class="l">' + obj.TaskContent + '</span>';
                lihtml += '<em>' + (obj.FinshPercent || "0") + '%</em>';
                lihtml += '</a></li>';
                $(el).append(lihtml);
            }

            //基础搜索函数
            var SearchPageData = function (pageIndex, isFristSearch, smType) {
                pageIndex = pageIndex || 1;
                var smType = smType || $(".nav.nav-tabs .active a").attr("smtype");
                var keyWord = $("#keyWord").val();
                //var deptId = $(".dropdown-menu input[name=company]:checked").val() || ""
                var deptId = $(".selectpicker").val() || ""
                var beginDate = $("#beginDate").val() || "";
                var endDate = $("#endDate").val() || "";
                var missionStatus = "";
                $.each($(".cbMissionStatus"), function (i, item) {
                    if (item.checked) {
                        missionStatus += item.value + "|";
                    }
                });
                var smId = $("#smId").val() || "";
                if (new Date(beginDate.replace(/-/g, "/")).getTime() > new Date(endDate.replace(/-/g, "/")).getTime()) {
                    alert('请假时间的开始时间不能大于结束时间');
                    result = false;
                }
                // smType = parseInt(smType, 10);
                for (s in thatPage.status) {
                    if (s && thatPage.missionStatus.indexOf(s) === -1) {
                        thatPage.missionStatus.push(s)
                    }
                }
                var postdata = {
                    pageIndex: pageIndex,
                    pageSize: pageSize,
                    deptId: thatPage.deptId,
                    keyWord: thatPage.keyWord,
                    beginDate: thatPage.beginDate,
                    endDate: thatPage.endDate,
                    missionStatus: thatPage.missionStatus.length > 0 ? thatPage.missionStatus.join(',') : '',
                    smId: thatPage.smId,
                    smType: NumberToSmType(smType),
                };

                var ret = Ajax({ FunName: 'GetIndexSMListByPage', async: true, callback: ViewListData, data: postdata, isFristSearch: (isFristSearch || false) });
            }

            //初次加载数据函数
            var defaultLoadData = function (smType) {
                var postdata = {
                    pageIndex: 1,
                    pageSize: pageSize,
                    deptId: "",
                    keyWord: "",
                    beginDate: "",
                    endDate: "",
                    missionStatus: "",
                    smId: "",
                    smType: NumberToSmType(smType),
                };
                var ret = Ajax({ FunName: 'GetIndexSMListByPage', async: true, callback: ViewListData, data: postdata, isFristSearch: true });
            }

            var getDeptListData = function () {
                Ajax({ FunName: 'DeptList', async: true, callback: ViewDept, data: null });
            }

            $(function () {
                //绑定数据列表
                for (var i = 1; i <= 4; i++) {
                    defaultLoadData(i);
                }
                //绑定部门
                getDeptListData();
            })

                $(".search-btn").click(function (e) {
                var $this = $(e.target)
                //thatPage.deptId = $(".dropdown-menu input[name=company]:checked").val() || ""
                $(".cbMissionStatus").each(function () {
                    if ($(this).is(':checked') && !thatPage.status[$(this).val()])
                        thatPage.status[$(this).val()] = $(this).parent().text().trim()
                })
                $this.closest('.search-control').find('input.form-control').each(function () {
                    var name = $(this).attr('name')
                    if (name)
                        thatPage[name] = $(this).val()
                })
                $('.search-filter').html(resetFilter())
                SearchPageData(1, true);
            })
            //选择状态
            $(document).on('click', '.dmst', function (e) {
                var $this = $(this)
                var $box = $this.closest('.checkbox label')
                if ($this.val() !== '')
                    thatPage.status[$this.val()] = $box.text()
            })
            //切换tab
            $('.nav-tabs').on('shown.bs.tab', function (e) {
                var event = $(e.target)
                var type = parseInt(event.attr('smtype'), 10)
                thatPage = pager[type - 1]
                if (typeof thatPage.beginDate === 'object') {
                    thatPage.beginDate = ''
                }
                SearchPageData(thatPage.page, true);
                loadControlData()
                $('.search-filter').html(resetFilter())
                
            })
            //加载数据到控件
            function loadControlData() {
                $.each(thatPage, function (key, item) {
                    if ((key === 'endDate' || key === 'beginDate' || key === 'keyWord' || key === 'unit' || key === '' || key === 'smId')) {
                        $('[name="' + key + '"]').val(item)
                        if (!thatPage.deptId) {
                            //$('input[name="company"]:checked').prop('checked', false)
                            $(".selectpicker").selectpicker('val', '')
                        } else {
                            // $('input[value="' + thatPage.deptId + '"]').prop('checked', true)
                            $(".selectpicker").selectpicker('val', thatPage.deptId)
                        }
                    }
                    if (key === 'status') {
                        var status = thatPage.status
                        var inputStatus = ''
                        $('.cbMissionStatus').each(function (item) {
                            $(this).prop('checked', false)
                        })
                        $.each(status, function (key, item) {
                            $('input[value="' + key + '"]').prop('checked', true)
                            inputStatus += item + ','
                        })
                        $('#inputStatus').val(inputStatus)
                    }
                })
            }
            //选择部门
            $('.selectpicker').on('changed.bs.select', function (e) {
                thatPage.unit = $(this).val() === '' ? '' : $(this).find("option:selected").text();
                thatPage.deptId = $(this).val();
            });
            //处理全局搜索参数
            function resetFilter() {
                thatPage.deptId = $('.selectpicker').val()
                var html = []
                $.each(thatPage, function (item) {
                    if ((item === 'beginDate' || item === 'endDate' || item === 'keyWord' || item === 'unit' || item === '' || item === 'smId') && thatPage[item]) {
                        html.push('<span ',
                            'data-type="',
                            item,
                            '">',
                            thatPage[item],
                            '<i class="iconfont icon-sv-close-s"></i></span>')
                        //thatPage.deptId = thatPage.unit ? thatPage.deptId : ''
                    }
                })
                var status = thatPage.status
                $.each(thatPage.status, function (key, st) {
                    html.push('<span data-type="status" data-key="', key, '">', st, '<i class="iconfont icon-sv-close-s"></i></span>')
                })
                //SearchPageData(1, true);
                return html.join('')
            }
            //任务类型代码转换数字，为了适应页面本身确定的数字来定类型的
            var SmTypeToNumber = function (smType) {
                var ret = 4;
                switch (smType) {
                    case "ND":
                        ret = 1;
                        break;
                    case "LD":
                        ret = 2;
                        break;
                    case "ZJ":
                        ret = 3;
                        break;
                    case "QT":
                        ret = 4;
                        break;
                    default:
                        ret = 4
                }
                return ret;
            }
            //数字转换为任务类型代码
            var NumberToSmType = function (smTypeNumber) {
                var ret = "QT";
                switch (smTypeNumber) {
                    case 1:
                        ret = "ND";
                        break;
                    case 2:
                        ret = "LD";
                        break;
                    case 3:
                        ret = "ZJ";
                        break;
                    case 4:
                        ret = "QT";
                        break;
                    case "1":
                        ret = "ND";
                        break;
                    case "2":
                        ret = "LD";
                        break;
                    case "3":
                        ret = "ZJ";
                        break;
                    case "4":
                        ret = "QT";
                        break;
                    default:
                        ret = "QT"
                }
                return ret;
            }
            });
            //href在ie会弹窗
            $('.tab-content li a').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                var $this = $(this);
                var href = $this.attr('href');
                window.open(href);
            })
        })
    </script>


</body>
</html>
