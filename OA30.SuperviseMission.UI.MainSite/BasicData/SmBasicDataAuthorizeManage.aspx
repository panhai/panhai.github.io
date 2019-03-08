<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmBasicDataAuthorizeManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDataAuthorizeManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查委托管理</title>
    <style type="text/css">
        .dc {
            width: auto;
        }

        .mb .btn-group {
            min-width: 80px;
        }
    </style>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx">管理</a></li>
                <li class="active">督查委托</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-sm-4 control-label dc">授权人姓名</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="search_authorize_name" placeholder="请输入授权人姓名" />
                            </div>
                        </div>
                    </div>
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-sm-4 control-label dc">委托人姓名</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="search_consignee_name" placeholder="请输入委托人姓名" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary-s btn-group" id="btn_search">查询</button>
                    <button class="btn btn-default-s btn-group" id="btn_search_clear">清空</button>
                    <button class="btn btn-default-s btn-group" id="btn_export">导出</button>
                </div>
            </div>
        </div>
        <div id="tips-alert" class="alert alert-top" style="display: none;">&nbsp;</div>
        <div class="tar">
            <a href="javascript:;" data-row="table"><span class="iconfont icon-sv-add"></span>&nbsp;新增</a>
        </div>
        <div class="table-page">
            <table id="Authorize_Origin" data-show-columns="false" class="table table-bordered mb"></table>
        </div>
    </div>
    <script id="add_status_template" type="text/x-template">
	    <input class="form-control"  disabled="" style="font-weight: normal;" name="add_status" value="未过期"/>
    </script>
    <script id="add_operator_id_template" type="text/x-template">
	    <input disabled="" class="form-control" style="font-weight: normal;" name="add_operator_id"/>
    </script>
    <script id="add_create_time_template" type="text/x-template">
        <input disabled="" class="form-control" style="font-weight: normal;" name="add_create_time"/>
    </script>
</body>
</html>
<script src="Script/require.js"></script>
<script type="text/javascript">
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
    require(['jquery','row', 'bootstrap', 'picker', 'bootstrap-table', 'tableExport'],
        function ($,Row) {
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSmBasicDataAuthorize";

            //初始化
            InitTable("#Authorize_Origin", initUrl);

            function InitTable(tableId, url) {
                //先销毁表格
                $(tableId).bootstrapTable("destroy");
                //加载表格
                var option = {
                    rowStyle: function (row, index) {//row 表示行数据，object,index为行索引，从0开始
                        var style = "";
                        if (row.SignInTime == '' || row.SignOutTime == '') {
                            style = { css: { 'color': 'red' } };
                        }
                        return style;
                    },
                    //searchAlign: 'left',
                    //search: true,   //显示隐藏搜索框
                    showHeader: true,     //是否显示列头
                    //classes: 'table-no-bordered',
                    showLoading: true,
                    undefinedText: '',
                    dataType: 'xml',
                    showFullscreen: false,
                    method: 'post',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    paginationHAlign: 'right',
                    silent: true,
                    striped: false,
                    url: url,
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: true,                   //是否显示分页（*）
                    sortable: false,                     //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    //queryParams: InitTable.queryParams,  //传递参数（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber: 1,                       //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    pageList: [6, 12, 24, 26],        //可供选择的每页的行数（*）
                    search: false,                      //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    //height: 680,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    showExport: false,
                    exportDataType: "all",        //导出所有数据
                    showToggle: false,
                    showRefresh: false,
                    showColumns: false,
                    queryParams: function (params) {
                        var searchAuthorizeName = $("#search_authorize_name").val();
                        var searchConsigneeName = $("#search_consignee_name").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            searchAuthorizeName: searchAuthorizeName,
                            searchConsigneeName: searchConsigneeName
                        };
                        return temp;
                    },
                    responseHandler: function (data) {
                        var dataObj = JSON.parse($(data).find("data").text());
                        return {
                            "rows": dataObj.rows,
                            "total": dataObj.total
                        };
                    },
                    columns: [{
                        title: '操作',
                        width: 120,
                        formatter: function (value, row, index) {
                            return [
                                '<button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button>'
                            ].join('');
                        }
                    }, {
                        field: 'Status',
                        title: '是否过期',
                        width: 90,
                        formatter: function (value, row, index) {
                            if (value === 1 || value === "1") {
                                return '<font class="status-edit" style="color:green; width:80px;font-weight: normal;">未过期</font>';
                            } else {
                                return '<font class="status-edit" style="color:green; width:80px;font-weight: normal;">过期</font>';
                            }
                        }
                    }, {
                        field: 'AuthorizerId',
                        title: '授权人ID',
                        width: 100,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:60px;" data-type="edit" class="disabled authorizerid-edit form-control" value="' + row.AuthorizerId + '"/>';
                        }
                    }, {
                        field: 'AuthorizerName',
                        title: '授权人姓名',
                        width: 100,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:90px;" data-type="edit" class="disabled authorizername-edit form-control" value="' + row.AuthorizerName + '"/>';
                        }
                    }, {
                        field: 'ConsigneeId',
                        title: '委托人ID',
                        width: 100,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:60px;" data-type="edit" class="disabled consigneerid-edit form-control" value="' + row.ConsigneeId + '"/>';
                        }
                    }, {
                        field: 'ConsigneeName',
                        title: '委托人姓名',
                        width: 100,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:90px;" data-type="edit" class="disabled consigneername-edit form-control" value="' + row.ConsigneeName + '"/>';
                        }
                    }, {
                        field: 'BeginTime',
                        title: '开始时间',
                        width: 150,
                        formatter: function (value, row, index) {
                            var newDate = /\d{4}-\d{1,2}-\d{1,2}/g.exec(row.BeginTime)
                            return '<input disabled="" data-type="edit" class="disabled form-control begintime-edit" value="' + newDate + '" readonly/>';
                        }
                    }, {
                        field: 'EndTime',
                        title: '结束时间',
                        width: 150,
                        formatter: function (value, row, index) {
                            var newDate = /\d{4}-\d{1,2}-\d{1,2}/g.exec(row.EndTime)
                            return '<input disabled="" data-type="edit" class="disabled form-control endtime-edit" value="' + newDate + '" readonly/>';
                        }
                    }, {
                        field: 'OperatorId',
                        title: '操作人ID',
                        width: 95,
                        formatter: function (value, row, index) {
                            return row.OperatorId;
                        }
                    }, {
                        field: 'CreateTime',
                        title: '创建时间',
                        width: 180,
                        formatter: function (value, row, index) {
                            return '<font class="createtime-edit" style="width:140px;">' + row.CreateTime + '</font>';
                        }
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };
            //跳转到导出数据页面
            function goToExportPage() {
                var type = "SmBasicDataAuthorizeManage";
                var authorizerUserName = $("#search_authorize_name").val();
                var consigneeUserName = $("#search_consignee_name").val();
                var url = "SuperviseMissionExport.aspx?type=" + type + "&authorizerUserName=" + authorizerUserName + "&consigneeUserName=" + consigneeUserName;
                window.open(url);
            };
            var currentUser;

            //获取当前管理员。
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetCurrentUser",
                type: "get",
                dataType: "xml",
                contentType: "text/xml; charset=utf-8",
                success: function (data) {
                    currentUser = JSON.parse($(data).find("data").text());
                },
                error: function (message) {
                    alert("获取当前管理员失败！请检查相关配置！");
                }
            });

            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {
                $('#search_authorize_name').val('');
                $("#search_consignee_name").val('');
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#Authorize_Origin", initUrl);
            });
            //绑定导出
            $("#btn_export").click(goToExportPage);


            var dept;
            var row = new Row({
                target: '.table',
                fields: [{
                    type: 'select',
                    template: '#add_status_template'
                }, {
                    type: 'text',
                    name: 'add_authorizer_id',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_authorizer_name',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_consignee_id',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_consignee_name',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_begin_time',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_end_time',
                    value: ''
                }, {
                    type: 'select',
                    template: '#add_operator_id_template'
                }, {
                    type: 'select',
                    template: '#add_create_time_template'
                }]
            });

            //取消。
            $('.table').delegate( '[data-row^="cancel"]','row.cancel', function (e) {
                $(e.target).closest('tr').remove();
            });


            //新建行。
            $('[data-row^="table"]').on('click',function (e) {
                if ($("input[name='add_authorizer_id']").length === 0) {
                    row.create();
                    //绑定非空验证事件。
                    bindCreateIsNullValidate();
                    bindCreateDefaultValue();
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            function bindCreateIsNullValidate() {
                $("[name='add_consignee_id']").on('blur', function () {
                    changeClassByNull($(this));
                    changeClassByNull($('input[name="add_consignee_name"]'));
                });

                $("[name='add_begin_time']").on('blur', function () {
                    changeClassByNull($(this));
                });

                $("[name='add_end_time']").on('blur', function () {
                    changeClassByNull($(this));
                });
            }

            function bindCreateDefaultValue() {
                //绑定当前时间。
                showCurrentTime();
                //绑定当前管理员Id和姓名。
                $("input[name='add_operator_id'],input[name='add_authorizer_id']").val(currentUser.Employee_ID);
                $("input[name='add_authorizer_name']").val(currentUser.Name);
                $("input[name='add_authorizer_id'],input[name='add_authorizer_name']").attr("disabled", "disabled");
                $("input[name='add_begin_time']").datetimepicker(
                    {
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        minView: "month",
                        maxView: "decade",
                        startDate: new Date(),
                        todayBtn: true
                    }).on("click", function () {
                        $("input[name='add_begin_time']").datetimepicker("setEndDate", $("input[name='add_end_time']").val());
                    });

                $("input[name='add_end_time']").datetimepicker(
                    {
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        minView: "month",
                        maxView: "decade",
                        startDate: new Date(),
                        todayBtn: true
                    }).on('changeDate', function () {
                        var endtime = $("input[name='add_end_time']").val();
                        if (endtime !== "") {
                            if (CompareCurrentDate(endtime)) {
                                $("input[name='add_status']").val("未过期");
                            } else {
                                $("input[name='add_status']").val("过期");
                            }
                        }
                    }).on("click", function () {
                        $("input[name='add_end_time']").datetimepicker("setStartDate", $("input[name='add_begin_time']").val());
                    });

                $("input[name='add_end_time'],input[name='add_begin_time'],input[name='add_consignee_name']").attr("readonly", "true").css("background-color", "white");
                $("input[name='add_consignee_id']").on('blur', function () {
                    if ($("input[name='add_consignee_id']").val() !== "") {
                        $.ajax({
                            url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                            type: "post",
                            dataType: "xml",
                            data: { "UserId": $("input[name='add_consignee_id']").val() },
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                            success: function (data) {
                                if ($(data).find("status").text() === "1") {
                                    var user = JSON.parse($(data).find("data").text());
                                    $("input[name='add_consignee_name']").val(user[0].Name);
                                } else {
                                    $("input[name='add_consignee_name']").val("");
                                    showTips($(data).find("message"), "alert-danger", "alert-success");
                                }
                            },
                            error: function (message) {
                                alert("获取管理员名称失败！请检查相关配置！");
                            }
                        });
                    } else {
                        $("input[name='add_consignee_name']").val("");
                    }
                });
                function showCurrentTime() {
                    var currentDT = new Date();
                    var y, m, date, day, hs, ms, ss, theDateStr;
                    y = currentDT.getFullYear(); //四位整数表示的年份
                    m = currentDT.getMonth() + 1; //月
                    date = currentDT.getDate(); //日
                    day = currentDT.getDay(); //星期
                    hs = currentDT.getHours(); //时
                    ms = currentDT.getMinutes(); //分
                    ss = currentDT.getSeconds(); //秒
                    theDateStr = y + "-" + m + "-" + date + " " + hs + ":" + ms + ":" + ss;
                    $("input[name='add_create_time']").val(theDateStr);
                    // setTimeout 在执行时,是在载入后延迟指定时间后,去执行一次表达式,仅执行一次
                    window.setTimeout(showCurrentTime, 1000);
                }

                function CompareCurrentDate(date) {
                    return ((new Date(date.replace(/-/g, "\/"))) > (new Date()));
                }
            }

            function changeClassByNull($this) {
                if (isRequestNotNull($this.val())) {
                    $this.addClass("error");
                } else {
                    $this.removeClass("error");
                }
            }

            //删除行。
            $(document).on('row.delete', '[data-row^="delete"]', function (e) {
                var currentIndex = $(e.target).closest('tr').data().index
                var oldSmBasicDataSuperviseNumberEntityObj = $("#Authorize_Origin").bootstrapTable('getData')[currentIndex];

                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/DelSmBasicDataAuthorize",
                    type: "post",
                    dataType: "xml",
                    data: { "authorizerId": oldSmBasicDataSuperviseNumberEntityObj.AuthorizerId, "consigneeId": oldSmBasicDataSuperviseNumberEntityObj.ConsigneeId },
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    success: function (message) {
                        if ($(message).find("status").text() === "1") {
                            showTips($(message).find("message").text(), "alert-success", "alert-danger");
                            $(e.target).closest('tr').remove();
                            $("#Authorize_Origin").bootstrapTable('refresh');
                        } else {
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#Authorize_Origin").bootstrapTable('refresh')
                        showTips($(message).find("message").text(), "alert-danger", "alert-success");
                    }
                });
            });

            //保存
            $('.table').delegate('[data-row^="save"]', 'row.save', function (e) {
                //新增
                if (isNotNullByCreate()) {
                    add();
                }
            });

            function isNotNullByCreate() {
                var consigneeId = $('input[name="add_consignee_id"]').val();
                var consigneeName = $('input[name="add_consignee_name"]').val();
                var begintime = $('input[name="add_begin_time"]').val();
                var endtime = $('input[name="add_end_time"]').val();
                if (consigneeId === "" || begintime === "" || endtime === "" || consigneeName === "") {
                    $('input[name="add_consignee_id"],input[name="add_begin_time"],input[name="add_end_time"],input[name="add_consignee_name"]').blur();
                    return false;
                } else {
                    return true;
                }
            }

            //增加
            function add() {
                var consigneeId = $('input[name="add_consignee_id"]').val();
                var beginTime = $('input[name="add_begin_time"]').val();
                var endTime = $('input[name="add_end_time"]').val();
                var smBasicDataAuthorizeEntityObj = new Object();
                smBasicDataAuthorizeEntityObj.ConsigneeId = consigneeId;
                smBasicDataAuthorizeEntityObj.BeginTime = beginTime;
                smBasicDataAuthorizeEntityObj.EndTime = endTime;
                var smBasicDataAuthorizeEntity = '{"smBasicDataAuthorizeEntity":' + JSON.stringify(smBasicDataAuthorizeEntityObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSmBasicDataAuthorize",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataAuthorizeEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#Authorize_Origin").bootstrapTable('refresh')
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#Authorize_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            };

            //显示提示
            function showTips(tips, addClassName, removeClassName) {
                var $tips = $("#tips-alert");
                $tips.css('display', 'block');
                $tips.addClass(addClassName);
                $tips.removeClass(removeClassName);
                $tips.html(tips);
                setTimeout(function () {
                    $tips.css('display', 'none');
                }, 3000);
            }

            function isRequestNotNull(obj) {
                obj = $.trim(obj);
                if (obj.length == 0 || obj == null || obj == undefined) {
                    return true;
                }
                else
                    return false;
            }

            //回车查询
            $(document).keydown(function (event) {
                var $this = $(event.target)
                if (event.keyCode == 13) {
                    $('#btn_search').trigger('click');
                }
            });
        });
</script>
