<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmBasicDataSuperviseNumberManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDataSuperviseNumberManage" %>

<!DOCType html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查日志</title>

</head>


<body>
    <!--导航-->
    <div class="main">

        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#super">管理</a></li>
                <li class="active">督查日志</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#super'></a>
        </div>

        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-md-4 col-xs-4 col-lg-4 col-sm-4">

                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">模块类型</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8 dropdown">


                                <select class="form-control" id="log_moduleType">

                                    <option value="-1" selected="selected">请选择模块类型</option>
                                    <option value="0">基础数据</option>
                                    <option value="1">流转引擎</option>
                                    <option value="2">年度重点工作任务</option>
                                    <option value="3">领导行政例会督查任务</option>
                                    <option value="4">总经理办公会督查任务</option>
                                    <option value="5">其它重要工作任务</option>
                                    <option value="6">提醒模块</option>
                                    <option value="7">业务数据</option>
                                </select>


                            </div>
                        </div>

                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">层级类型</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8 dropdown">
                                <select class="form-control" id="log_layerType">


                                    <option value="-1" selected="selected">请选择层级类型</option>
                                    <option value="0">页面</option>
                                    <option value="1">服务</option>
                                    <option value="2">数据库</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">错误类型</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8 dropdown">

                                <select class="form-control" id="log_errorType">

                                    <option value="-1" selected="selected">请选择错误类型</option>
                                    <option value="0">页面错误</option>
                                    <option value="1">服务错误</option>
                                    <option value="2">数据库错误</option>
                                    <option value="3">网络错误</option>
                                    <option value="4">权限错误</option>
                                    <option value="5">其它错误</option>
                                    <option value="9">操作错误</option>

                                </select>
                            </div>
                        </div>


                    </div>

                    <div class="col col-md-4 col-xs-4 col-lg-4 col-sm-4">



                        <div class="form-group clearfix">


                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">操作日期</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8 dropdown">

                                <input type="text" name="begin_time" id="begin_time" class=" form-control begintime-edit" placeholder="开始时间" />
                                <div style="margin-top:15px">
                                <input type="text" name="end_time" id="end_time" class=" form-control endtime-edit" placeholder="结束时间" />
                                    </div>

                            </div>
                        </div>

                    </div>

                    <div class="col col-md-4 col-xs-4 col-lg-4 col-sm-4">

                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">操作者姓名</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8">
                                <input type="text" id="log_opreator" name="log_content" class="form-control" placeholder="请输入操作者姓名...." />
                            </div>
                        </div>


                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">错误提示内容</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8">
                                <input type="text" id="log_contentid" name="log_content" class="form-control" placeholder="请输入错误提示内容关键字信息" />
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

        <div id="content_display" class="alert alert-danger">点击表格单元以获取单元格的内容</div>

        <div class="table-page">
            <table id="SuperviseNumber_Origin" data-show-columns="false" class="table table-bordered"></table>

        </div>

    </div>
    <script id="option" type="text/x-template">
	    <select class="form-control" name="add_dept_name">
		    
	    </select>
    </script>

    


</body>
</html>

<%--以上是html页面--%>

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
    require(['jquery', 'bootstrap', 'cs-table', 'picker', 'bootstrap-table', 'tableExport'],
        function ($, row) {
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSMOpreationLog";

            //初始化
            InitTable("#SuperviseNumber_Origin", initUrl);

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

                    showHeader: true,     //是否显示列头
                    //classes: 'table-no-bordered',
                    showLoading: true,
                    method: 'post',
                    striped: false,
                    undefinedText: '',
                    dataType: 'xml',
                    showFullscreen: false,
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    paginationHAlign: 'right',
                    silent: true,
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

                        var logModuleType = $('#log_moduleType').val();
                        var logLayerType = $('#log_layerType').val();
                        var logErrorType = $("#log_errorType").val();
                        var startSearchTime = $('#begin_time').val();
                        var endSearchTime = $('#end_time').val();
                        var logOpreator = $("#log_opreator").val();
                        var logContent = $("#log_contentid").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  

                            limit: params.limit,
                            offset: params.offset,
                            logModuleType: logModuleType,
                            logLayerType: logLayerType,
                            logErrorType: logErrorType,
                            startSearchTime: startSearchTime,
                            endSearchTime: endSearchTime,
                            logOpreator: logOpreator,
                            logContent: logContent
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
                        field: 'ModuleName',
                        title: '模块名',
                        width: 150,
                        formatter: function (value, row, index) {
                            return  '<div class="m-td">' + row.ModuleName + '</div>';
                        }
                    }, {
                        field: 'LayerName',
                        title: '层次名',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.LayerName + '</div>';
                        }
                    }, {
                        field: 'ErrorTypeName',
                        title: '错误名',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.ErrorTypeName + '</div>';
                        }
                    }, {
                        field: 'Content',
                        title: '错误提示',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.Content + '</div>';
                        }
                    }, {
                        field: 'OpreatorId',
                        title: '操作者员工号',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.OpreatorId + '</div>';
                        }
                    }, {
                        field: 'OpreatorName',
                        title: '操作者姓名',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.OpreatorName + '</div>';
                        }
                    }, {
                        field: 'OpreateTime',
                        title: '操作时间',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.OpreateTime + '</div>';
                        }
                    }, {
                        field: 'OpreatorIp',
                        title: '操作者员IP',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.OpreatorIp + '</div>';
                        }
                    }, {
                        field: 'OpreatorDeptId',
                        title: '操作者所属部门ID',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.OpreatorDeptId + '</div>';
                        }
                    }, {
                        field: 'OpreatorDeptName',
                        title: '操作者部门名称',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<div class="m-td">' + row.OpreatorDeptName + '</div>';
                        }
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };



            $("table#SuperviseNumber_Origin").on("click", function (e) {


                $("#content_display").text($(e.target).closest('td').text());

            });

            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {
                $('#log_moduleType').val('');
                $('#log_layerType').val('');
                $("#log_errorType").val('');
                $('#begin_time').val('');
                $('#end_time').val('');
                $("#log_opreator").val('');
                $("#log_contentid").val('');
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#SuperviseNumber_Origin", initUrl);

            });

            //绑定导出
            $("#btn_export").click(goToExportPage);

            //跳转到导出数据页面
            function goToExportPage() {
                var type = "SmOpreationLogManage";


                var logModuleType = $('#log_moduleType').val();
                var logLayerType = $('#log_layerType').val();
                var logErrorType = $("#log_errorType").val();
                var startSearchTime = $('#begin_time').val();
                var endSearchTime = $('#end_time').val();
                var logOpreator = $("#log_opreator").val();
                var logContent = $("#log_contentid").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&logModuleType="
                    + logModuleType + "&logLayerType=" + logLayerType + "&logErrorType="
                    + logErrorType + "&startSearchTime=" + startSearchTime + "&endSearchTime=" + endSearchTime + "&logOpreator="
                    + logOpreator + "&logContent=" + logContent;
                window.open(url);
            };


            $("input[name='begin_time']").datetimepicker(
                      {
                          language: 'zh-CN',
                          format: "yyyy-mm-dd",
                          autoclose: true,
                          minView: "month",
                          maxView: "decade",

                      }).on("click", function () {
                          $("input[name='begin_time']").datetimepicker("setEndDate", $("input[name='end_time']").val());
                      });

            $("input[name='end_time']").datetimepicker(
                {
                    language: 'zh-CN',
                    format: "yyyy-mm-dd",
                    autoclose: true,
                    minView: "month",
                    maxView: "decade",
                    startDate: new Date(),
                    todayBtn: true
                }).on('changeDate', function () {
                    var endtime = $("input[name='end_time']").val();
                    if (endtime !== "") {
                        if (CompareCurrentDate(endtime)) {
                            $("input[name='add_status']").val("未过期");
                        } else {
                            $("input[name='add_status']").val("过期");
                        }
                    }
                }).on("click", function () {
                    $("input[name='end_time']").datetimepicker("setStartDate", $("input[name='begin_time']").val());
                });

            //回车查询
            $(document).keydown(function (event) {
                var $this = $(event.target)
                if (event.keyCode == 13) {
                    $('#btn_search').trigger('click');
                }
            });
        });


</script>
