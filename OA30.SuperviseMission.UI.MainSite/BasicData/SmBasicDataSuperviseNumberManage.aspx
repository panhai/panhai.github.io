<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmBasicDataSuperviseNumberManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDataSuperviseNumberManage" %>

<!DOCType html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查字号</title>
</head>
<body>
    <!--导航-->
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#department">管理</a></li>
                <li class="active">督查字号</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#department'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-5 col-md-5 col-sm-5 col-xs-5">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">部门</label>
                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8 select_control">
                                <input type="hidden" id="search_department_ids" value="" />
                                <input type="hidden" id="search_department" value="" />
                                <select id="select_dept" data-live-search="true" class="selectpicker form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col col-lg-5 col-md-5 col-sm-5 col-xs-5">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-lg-4 col-xs-4 control-label">当前流水号</label>
                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <input type="text" id="search_code" onkeyup="value=value.replace(/[^\d]/g,'')" name="search_code" class="form-control" placeholder="当前流水号" />
                            </div>
                        </div>
                    </div>
                    <div class="col col-lg-5 col-md-5 col-sm-5 col-xs-5">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-lg-4 col-xs-4 control-label">文件字</label>
                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <input type="text" id="search_name" name="search_name" class="form-control" placeholder="文件字" />
                            </div>
                        </div>

                    </div>
                    <div class="col col-sm-5 col-lg-5 col-md-5 col-xs-5">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-lg-4 col-xs-4 control-label">年号</label>
                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <input type="text" class="form-control" id="search_year" onkeyup="value=value.replace(/[^\d]/g,'')" name="search_year" placeholder="年号" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group" style="margin-left: 110px;">
                    <button class="btn btn-primary-s btn-group" id="btn_search">查询</button>
                    <button class="btn btn-default-s btn-group" id="btn_search_clear">清空</button>
                    <button class="btn btn-default-s btn-group export-excel" id="btn_export">导出</button>
                    <%--<button class="btn btn-default-s btn-group export-excel">导出</button>--%>
                </div>
            </div>
        </div>
        <div id="tips-alert" class="alert alert-top" style="display: none;">&nbsp;</div>
        <div class="tar">
            <a href="javascript:;" data-row="table"><span class="iconfont icon-sv-add"></span>&nbsp;新增</a>
        </div>

        <div class="table-page">
            <table id="SuperviseNumber_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>
    <script id="option" type="text/x-template">
	    <select class="form-control" data-type="edit" name="add_dept_name" data-live-search="true" class="selectpicker">
		    
	    </select>
    </script>
    <script id="year_select" type="text/x-template">
	    <select class="form-control" name="year_select_val">
		    
	    </select>
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
    require(['jquery', 'bootstrap', 'row', 'bootstrap-table', 'tableExport', 'bootstrap-select'],
        function ($, row) {
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSMBasicDataSuperviseNumbers";

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
                    //searchAlign: 'left',
                    //search: true,   //显示隐藏搜索框
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

                        var searchDepartmentIds = $('#search_department_ids').val();
                        var searchCode = $("#search_code").val();
                        var searchName = $("#search_name").val();
                        var searchYear = $("#search_year").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            searchDepartmentIds: searchDepartmentIds,

                            searchCode: searchCode,
                            searchName: searchName,
                            searchYear: searchYear
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
                        width: 100,
                        formatter: function (value, row, index) {
                            return [
                                '<button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button>'
                            ].join('');
                        }
                    }, {
                        field: 'ActivityFlag',
                        title: '是否可用',
                        formatter: function (value, row, index) {
                            if (value === 1 || value === "1") {
                                return '<select data-type="edit" class="form-control activityflag-edit disabled" disabled>'
                                    + '<option value="1" selected = "selected">是</option>'
                                    + '<option value="0">否</option>'
                                    + '</select>';
                            } else {
                                return '<select data-type="edit" class="form-control activityflag-edit disabled" disabled>'
                                    + '<option value="1">是</option>'
                                    + '<option value="0" selected = "selected">否</option>'
                                    + '</select>';
                            }
                        }
                    }, {
                        field: 'DeptId',
                        title: '部门号',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<input disabled="" data-type="edit" class="disabled deptid-edit form-control" value="' + row.DeptId + '"/>';
                        }
                    }, {
                        field: 'DeptName',
                        title: '部门名称',
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="form-control deptname-edit disabled" disabled>'
                                + '<option  value="' + row.DeptId + '" selected = "selected">' + row.DeptName + '</option>'
                                + '</select>';
                        }
                    }, {
                        field: 'Name',
                        title: '文件字',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<input disabled="" data-type="edit" class="disabled form-control name-edit" value="' + row.Name + '"/>';
                        }
                    }, {
                        field: 'Year',
                        title: '年号',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="form-control year-edit disabled" disabled>' +
                                '<option  value="' +
                                row.Year +
                                '" selected = "selected">' +
                                row.Year +
                                '</option>' +
                                '</select>';
                        }
                    }, {
                        field: 'Code',
                        title: '当前流水号',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<input disabled="" data-type="edit" class="disabled form-control code-edit" value="' + row.Code + '"/>';
                        }
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };


            //根据用户权限获取二级部门列表。
            var dept;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/DeptList",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    dept = JSON.parse($(data).find("data").text());
                    bindDeptSearch();
                },
                error: function (message) {
                    alert("获取二级部门列表失败！");
                }
            });

            //根据用户权限获取多级部门列表。
            var allDept;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/DeptActivityList",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    allDept = JSON.parse($(data).find("data").text());
                },
                error: function (message) {
                    alert("获取部门列表失败！");
                }
            });


            //绑定部门列表。
            function bindDeptSearch() {
                $selectDept = $("#select_dept");
                $selectDept.empty();
                var html = "";
                for (var i = 0; i < dept.length; i++) {
                    html += "<option value='" + dept[i].DeptId + "' data-deptname='" + dept[i].DeptName + " id='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                }
                $selectDept.append(html);
                $('.selectpicker').on('changed.bs.select', function (e) {
                    $("#search_department_ids").val($(this).val());
                    $("#search_department").val($(this).data('deptname'));
                });

                $("#search_department").on('keyup', function () {
                    $("#search_department_ids").val("");
                });
                //下拉搜索部门
                $('.selectpicker').selectpicker('refresh');
            }
            $('.selectpicker').selectpicker();
            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {
                $('#search_department_ids').val('');
                $("#search_code").val('');
                $("#search_name").val('');
                $("#search_year").val('');
                var selectDeptText = $("#select_dept option:first").text();
                $("#search_department").next().find(".filter-option").html(selectDeptText);
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#SuperviseNumber_Origin", initUrl);
            });

            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {


                var type = "SmBasicDataSuperviseNumberManage";

                var dept_ids = $('#search_department_ids').val();

                var code = $("#search_code").val();
                var name = $("#search_name").val();
                var year = $("#search_year").val();
                var url = "SuperviseMissionExport.aspx?type=" + type + "&dept_ids=" + dept_ids + "&code=" + code + "&name=" + name + "&year=" + year;
                window.open(url);
            });

            var dept;
            var Row = require('row');
            var row = new Row({
                target: '.table',
                fields: [{
                    type: 'yes',
                    name: 'add_activity_flag',
                    value: '1'
                }, {
                    type: 'text',
                    name: 'add_dept_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#option'
                }, {
                    type: 'text',
                    name: 'add_name',
                    value: ''
                }, {
                    type: 'select',
                    template: '#year_select'
                }, {
                    type: 'text',
                    name: 'add_code',
                    value: '0'
                }]
            });

            //取消。
            $('.table').delegate('[data-row^="cancel"]', 'row.cancel', function (e) {
                $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    row.cancel(e);
                    reloadCurrentRow(e);
                    row.success(e, 'edit');
                } else {
                    //新增
                    $(e.target).closest('tr').remove();
                }

                function reloadCurrentRow(e) {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataSuperviseNumberEntityObj = $("#SuperviseNumber_Origin").bootstrapTable('getData')[currentIndex];
                    $('#SuperviseNumber_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataSuperviseNumberEntityObj });
                }
            });

            //新建行。
            $('[data-row^="table"]').on('click.row', function (e) {
                if (dept.length > 1) {
                    if ($("select[name='add_activity_flag']").length === 0) {
                        row.create();
                        //绑定非空验证事件。
                        bindCreateIsNullValidate();
                        bindCreateDept();
                        setCreateInputStatus();
                        bindCreateYear();
                        $('[name="add_dept_name"]').selectpicker('show');
                        $('[name="add_dept_name"]').selectpicker({
                            dropupAuto: false
                        });
                    } else {
                        showTips("已存在新增行", "alert-danger", "alert-success");
                    }
                } else {
                    showTips("该用户没有可选择部门，请先授权！", "alert-danger", "alert-success");
                }
            });

            function bindCreateYear() {
                var initYearObj = new Date(2017, 1, 1);
                nowYearObj = new Date(),
                yearList = new Array(),
                initYear = initYearObj.getFullYear(),
                nowYear = nowYearObj.getFullYear(),
                yearCount = (nowYear - initYear) + 5;
                for (var i = 0; i <= yearCount; i++) {
                    yearList.push(initYear + i);
                }

                var yearGroup = $("[name='year_select_val']");
                yearGroup.empty();
                var html = "";
                for (var i = 0; i < yearList.length; i++) {
                    if (yearList[i] === nowYear) {
                        html += "<option selected='selected' value='" + yearList[i] + "'>" + yearList[i] + "</option>";
                    } else {
                        html += "<option value='" + yearList[i] + "'>" + yearList[i] + "</option>";
                    }
                }
                yearGroup.append(html);
            }

            function setCreateInputStatus() {
                $("input[name='add_code']").attr("readonly", "true");
            }

            function bindCreateDept() {
                var deptGroup = $("[name='add_dept_name']");
                var $deptId = $("[name='add_dept_id']");
                deptGroup.empty();
                var html = "";
                for (var i = 1; i < allDept.length; i++) {
                    html += "<option value='" + allDept[i].DeptId + "'>" + allDept[i].DeptName + "</option>";
                }
                deptGroup.append(html);
                var id = allDept[1].DeptId;
                $deptId.val(id);
                $deptId.on('blur',
                    function () {
                        var value = $(this).val();
                        if (isInDeptArray(value)) {
                            deptGroup.selectpicker('val', ($(this).val()));
                        } else {
                            alert("输入的部门编号有误，请重新输入！");
                            var id = allDept[1].DeptId;
                            $deptId.val(id);
                            deptGroup.val(id);
                            $('[name="add_dept_name"]').selectpicker('refresh');
                        }
                    });
                deptGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $deptId.val(selectVal);
                });
            }

            function isInDeptArray(value) {
                for (var i = 1; i < allDept.length; i++) {
                    if (allDept[i].DeptId === value) {
                        return true;
                    }
                }

                return false;
            }

            function bindCreateIsNullValidate() {
                $("[name='add_dept_id']").on('blur', function () {
                    changeClassByNull($(this));
                });

                $("[name='add_name']").on('blur', function () {
                    changeClassByNull($(this));
                });

                $("[name='add_year']").on('blur', function () {
                    changeClassByNull($(this));
                });

                $("[name='add_code']").on('blur', function () {
                    changeClassByNull($(this));
                });

                $("[name='add_year']").on('keyup', function () {
                    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
                });

                $("[name='add_code']").on('keyup', function () {
                    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
                });
            }

            //编辑行
            $('.table').delegate('[data-row^="edit"]', 'row.edit', function (e) {
                if (dept.length > 1) {
                    row.edit(e);
                    bindEditIsNullValidate(e);
                    bindEditDept(e);
                    setEditInputStatus(e);
                    row.success(e, ['save', 'cancel']);
                } else {
                    showTips("该用户没有可选择部门，请先授权！", "alert-danger", "alert-success");
                }
            })

            function setEditInputStatus(e) {
                var $tds = $(e.target).closest('tr').children();
                $tds.find(".code-edit,.year-edit").attr("readonly", "true");
            }

            function bindEditDept(e) {
                var $tds = $(e.target).closest('tr').children();
                var deptGroup = $tds.find(".deptname-edit");
                var currentIndex = $(e.target).closest('tr').data().index
                var model = $("#SuperviseNumber_Origin").bootstrapTable('getData')[currentIndex];
                var deptId = allDept[1].DeptId;
                deptGroup.empty();
                for (var i = 1; i < allDept.length; i++) {
                    if (allDept[i].DeptId === model.DeptId) {
                        deptGroup.append("<option selected='selected' value='" + allDept[i].DeptId + "'>" + allDept[i].DeptName + "</option>");
                        deptId = allDept[i].DeptId;
                    } else {
                        deptGroup.append("<option value='" + allDept[i].DeptId + "'>" + allDept[i].DeptName + "</option>");
                    }
                }

                $tds.find(".deptid-edit").val(deptId);

                $tds.find(".deptid-edit").on('blur',
                    function () {
                        var value = $(this).val();
                        if (isInDeptArray(value)) {
                            deptGroup.selectpicker('val', ($(this).val()));
                        } else {
                            alert("输入的部门编号有误，请重新输入！");
                            var id = allDept[1].DeptId;
                            $tds.find(".deptid-edit").val(id);
                            deptGroup.val(id);
                            $('[name="add_dept_name"]').selectpicker('refresh');
                        }
                    });

                deptGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $tds.find(".deptid-edit").val(selectVal);
                });
            }

            function bindEditIsNullValidate(e) {
                $tds = $(e.target).closest('tr').children();
                //非空验证。
                $tds.find(".deptid-edit").on('blur', function () {
                    changeClassByNull($(this));
                });

                $tds.find(".name-edit").on('blur', function () {
                    changeClassByNull($(this));
                });

                $tds.find(".year-edit").on('blur', function () {
                    changeClassByNull($(this));
                });

                $tds.find(".code-edit").on('blur', function () {
                    changeClassByNull($(this));
                });

                $tds.find(".year-edit").on('keyup', function () {
                    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
                });

                $tds.find(".code-edit").on('keyup', function () {
                    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
                });
            }

            function changeClassByNull($this) {
                if (isRequestNotNull($this.val())) {
                    $this.addClass("error");
                } else {
                    $this.removeClass("error");
                }
            }

            //保存
            $(document).on('row.save', '[data-row^="save"]', function (e) {
                $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    if (isNotNullByEdit(e)) {
                        edit(e);
                    }
                } else {
                    //新增
                    if (isNotNullByCreate()) {
                        add();
                    }
                }
            });

            function isNotNullByEdit(e) {
                $tds = $(e.target).closest('tr').children();
                var activityflag = $tds.find(".activityflag-edit").val();
                var departmentId = $tds.find(".deptid-edit").val();
                var name = $tds.find(".name-edit").val();
                var year = $tds.find(".year-edit").val();
                var code = $tds.find(".code-edit").val();
                $tds.find(".name-edit").blur();
                $tds.find(".year-edit").blur();
                $tds.find(".code-edit").blur();
                $tds.find(".deptid-edit").blur();
                if (departmentId === "" || name === "" || year === "" || code === "" || activityflag === "") {
                    return false;
                } else {
                    return true;
                }
            }

            function isNotNullByCreate() {
                var departmentId = $('input[name="add_dept_id"]').val();
                var name = $('input[name="add_name"]').val();
                var year = $('input[name="add_year"]').val();
                var code = $('input[name="add_code"]').val();
                var activityflag = $("select[name='add_activity_flag'] option:selected").val();
                $('input[name="add_name"]').blur();
                $('input[name="add_year"]').blur();
                $('input[name="add_code"]').blur();
                $('input[name="add_dept_id"]').blur();
                if (departmentId === "" || name === "" || year === "" || code === "" || activityflag === "") {
                    return false;
                } else {
                    return true;
                }
            }

            function edit(e) {
                $("#SuperviseNumber_Origin").bootstrapTable('getData');
                $tds = $(e.target).closest('tr').children();
                var currentIndex = $(e.target).closest('tr').data().index
                //旧模型
                var oldSmBasicDataSuperviseNumberEntityObj = $("#SuperviseNumber_Origin").bootstrapTable('getData')[currentIndex];
                oldSmBasicDataSuperviseNumberEntityObj.CreateTime = "";
                //新模型
                var activityFlag = $tds.find('.activityflag-edit option:selected').val();
                var departmentId = $tds.find(".deptid-edit").val();
                var departmentName = $tds.find('.deptname-edit option:selected').text();
                var name = $tds.find(".name-edit").val();
                var year = $tds.find(".year-edit").val();
                var code = $tds.find(".code-edit").val();
                var smBasicDataSuperviseNumberEntityObj = new SmBasicDataSuperviseNumberEntityObj();
                smBasicDataSuperviseNumberEntityObj.Name = name;
                smBasicDataSuperviseNumberEntityObj.Year = year;
                smBasicDataSuperviseNumberEntityObj.DeptId = departmentId;
                smBasicDataSuperviseNumberEntityObj.Code = code;
                smBasicDataSuperviseNumberEntityObj.ActivityFlag = activityFlag;
                smBasicDataSuperviseNumberEntityObj.DeptName = departmentName;
                var smBasicDataSuperviseNumberEntity = '{"smBasicDataSuperviseNumberEntity":' + JSON.stringify(smBasicDataSuperviseNumberEntityObj) + ',"oldSmBasicDataSuperviseNumberEntity":' + JSON.stringify(oldSmBasicDataSuperviseNumberEntityObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/EditSMBasicDataSuperviseNumber",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataSuperviseNumberEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $('#SuperviseNumber_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataSuperviseNumberEntityObj });
                        } else {
                            $("#SuperviseNumber_Origin").bootstrapTable('refresh')
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#SuperviseNumber_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            }

            //增加
            function add() {
                var name = $('input[name="add_name"]').val();
                var year = $("select[name='year_select_val'] option:selected").val();
                var code = $('input[name="add_code"]').val();
                var departmentId = $('input[name="add_dept_id"]').val();
                var activityflag = $("select[name='add_activity_flag'] option:selected").val();
                var smBasicDataSuperviseNumberEntityObj = new Object();
                smBasicDataSuperviseNumberEntityObj.DeptId = departmentId;
                smBasicDataSuperviseNumberEntityObj.DeptName = "";
                smBasicDataSuperviseNumberEntityObj.Name = name;
                smBasicDataSuperviseNumberEntityObj.Year = year;
                smBasicDataSuperviseNumberEntityObj.Code = code;
                smBasicDataSuperviseNumberEntityObj.Type = "2";
                smBasicDataSuperviseNumberEntityObj.ActivityFlag = activityflag;
                smBasicDataSuperviseNumberEntityObj.CreatorId = "";
                smBasicDataSuperviseNumberEntityObj.CreateTime = "";
                var smBasicDataSuperviseNumberEntity = '{"smBasicDataSuperviseNumberEntity":' + JSON.stringify(smBasicDataSuperviseNumberEntityObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSMBasicDataSuperviseNumber",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataSuperviseNumberEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#SuperviseNumber_Origin").bootstrapTable('refresh')
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#SuperviseNumber_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            };

            function SmBasicDataSuperviseNumberEntityObj() {
                var smBasicDataSuperviseNumberEntityObj = new Object();
                smBasicDataSuperviseNumberEntityObj.DeptId = "";
                smBasicDataSuperviseNumberEntityObj.DeptName = "";;
                smBasicDataSuperviseNumberEntityObj.Name = "";;
                smBasicDataSuperviseNumberEntityObj.Year = "";;
                smBasicDataSuperviseNumberEntityObj.Code = "";;
                smBasicDataSuperviseNumberEntityObj.Type = "";;
                smBasicDataSuperviseNumberEntityObj.CreatorId = "";
                smBasicDataSuperviseNumberEntityObj.CreateTime = "";
                smBasicDataSuperviseNumberEntityObj.ActivityFlag = "";
                return smBasicDataSuperviseNumberEntityObj;
            }

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

            //非空验证
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
