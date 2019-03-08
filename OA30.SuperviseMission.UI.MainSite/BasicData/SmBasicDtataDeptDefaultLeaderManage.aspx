<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmBasicDtataDeptDefaultLeaderManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDtataDeptRoleManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>部门默认领导</title>
    <style type="text/css">
        .dc label {
            width: 25%;
        }

        .search-control-2 .row + .form-group {
            margin-left: 50px;
        }
        .table {
            table-layout:fixed;
        }
    </style>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#department">管理</a></li>
                <li class="active">部门默认领导</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#department'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-6 clo-md-6 col-sm-6 col-xs-6 dc">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-md-4 col-md-4 col-xs-4 control-label">所在部门</label>
                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8 select_control">
                                <input type="hidden" id="search_department_ids" value="" />
                                <input type="hidden" id="search_department" value="" />
                                <select id="select_dept" data-live-search="true" class="selectpicker form-control"></select>
                            </div>
                        </div>
                    </div>

                    <div class="col col-lg-6 clo-md-6 col-sm-6 col-xs-6 dc">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-md-4 col-md-4 col-xs-4 control-label">领导姓名</label>
                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <input type="text" class="form-control" id="search_leader_name" placeholder="请输入领导姓名" />
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
            <table id="DeptLeader_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>

    <script id="add_dept" type="text/x-template">
	    <select class="form-control" data-type="edit" name="add_dept_name" data-live-search="true" class="selectpicker">
		    
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
    require(['jquery', 'bootstrap', 'cs-table', 'bootstrap-table', 'tableExport', 'bootstrap-select'],
        function ($, row) {
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSMBasicDeptDefaultLeader";

            //初始化
            InitTable("#DeptLeader_Origin", initUrl);

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

                        var searchDeptIds = $('#search_department_ids').val();

                        var leaderName = $("#search_leader_name").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            searchDeptIds: searchDeptIds,
                            leaderName: leaderName,
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
                                '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>'
                            ].join('');
                        }
                    }, {
                        field: 'DeptId',
                        title: '部门号',
                        width: 80,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled DeptId-edit form-control" value="' + row.DeptId + '"/>';
                        }
                    }, {
                        field: 'DeptName',
                        title: '部门名称',
                        width: 120,
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="disabled DeptName-edit form-control " disabled >'
                                + '<option  value="' + row.DeptId + '" selected = "selected">' + row.DeptName + '</option>'
                                + '</select>';
                        }
                    }, {
                        field: 'LeaderUserId',
                        title: '领导工号',
                        width: 80,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available"  data-type="edit" class="disabled LeaderUserId-edit form-control" value="' + row.LeaderUserId + '"/>';
                        }
                    }, {
                        field: 'LeaderUserName',
                        title: '领导姓名',
                        width: 80,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled LeaderUserName-edit form-control" value="' + row.LeaderUserName + '"/>';
                        }
                    }
                    , {
                        field: 'LeaderDeptId',
                        title: '领导所在部门号',
                        width: 80,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled LeaderDeptId-edit form-control" value="' + row.LeaderDeptId + '"/>';
                        }
                    }, {
                        field: 'LeaderDeptName',
                        title: '领导所在部门名',
                        width: 120,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled LeaderDeptName-edit form-control" value="' + row.LeaderDeptName + '"/>';
                        }
                    }, {
                        field: 'OrderNumber',
                        title: '排序号',
                        width: 80,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available"  data-type="edit" class="disabled OrderNumber-edit form-control" value="' + row.OrderNumber + '"/>';
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

                $selectDept = $(".selectpicker");
                $selectDept.empty();
                var html = "";
                for (var i = 0; i < dept.length; i++) {
                    html += "<option value='" + dept[i].DeptId + "' data-deptname='" + dept[i].DeptName + " id='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                }
                $selectDept.append(html);
                $('.selectpicker').on('changed.bs.select', function (e) {
                    if ($(e.target).closest(".form-group").find("#search_department_ids").length > 0) {
                        $("#search_department_ids").val($(this).val());
                        $("#search_department").val($(this).data('deptname'));

                    } else {
                        $("#search_leader_department_ids").val($(this).val());
                        $("#search_leader_department").val($(this).data('deptname'));
                    }

                });


                $("#search_department").on('keyup', function () {
                    $("#search_department_ids").val("");
                });

                $("#search_leader_department").on('keyup', function () {
                    $("#search_leader_department_ids").val("");
                });

                //下拉搜索部门
                $('.selectpicker').selectpicker('refresh');
            }
            $('.selectpicker').selectpicker();




            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {
                var selectDeptText = $("#select_dept option:first").text();
                $("#search_department").next().find(".filter-option").html(selectDeptText);
                $("#search_department_ids").val('');
                $("#search_leader_name").val('');


            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#DeptLeader_Origin", initUrl);
            });


            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {


                var type = "SmBasicDtataDeptDefaultLeaderManage";
                var searchDeptIds = $('#search_department_ids').val();
                var leaderName = $("#search_leader_name").val();
                var url = "SuperviseMissionExport.aspx?type=" + type + "&searchDeptIds=" + searchDeptIds + "&leaderName=" + leaderName;
                window.open(url);
            });



            $('#DeptLeader_Origin').csTable({
                fields: [{
                    type: 'text',
                    name: 'add_dept_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_dept'
                }, {
                    type: 'text',
                    name: 'add_leader_user_id',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_leader_user_name',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_leader_dept_id',
                    value: ''
                }, {

                    type: 'text',
                    name: 'add_leader_dept_name',
                    value: ''

                }, {
                    type: 'text',
                    name: 'add_order_number',
                    value: ''
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $('[data-row^="table"]').on('click', function (e) {
                if ($("input[name='add_dept_id']").length === 0) {
                    console.log('输出新建行信息------------------------：' + JSON.stringify($("input[name='add_dept_id']")));
                    $('.table').csTable('add');
                    //绑定非空验证事件。
                    bindCreateIsNullValidate();
                    setCreateControlValue();
                    $('[name="add_dept_name"]').selectpicker('show');
                    $('[name="add_dept_name"]').selectpicker({
                        dropupAuto: false
                    });
                } else {
                    console.log('输出已存在新增行信息------------------------：' + JSON.stringify($("input[name='add_dept_id']")));
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            //删除行。
            $('.table').delegate('[data-row^="delete"]', 'click', function (e) {
                //此判断用来区分删除和取消按钮，新增的时候取消按钮也有data-row^="delete"
                if ($(e.target).data().type != "cancel") {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataDeptDefaultLeaderEntityObj = $("#DeptLeader_Origin").bootstrapTable('getData')[currentIndex];

                    $.ajax({
                        url: "WebServices/SuperviseMissionWebServices.asmx/DelSMBasicDataDeptDefaultLeader",
                        type: "post",
                        dataType: "xml",
                        data: { "deptId": smBasicDataDeptDefaultLeaderEntityObj.DeptId, "leaderUserId": smBasicDataDeptDefaultLeaderEntityObj.LeaderUserId, "leaderDeptId": smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptId },
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        success: function (message) {
                            if ($(message).find("status").text() === "1") {
                                showTips($(message).find("message").text(), "alert-success", "alert-danger");
                                $(e.target).closest('tr').remove();
                                $("#DeptLeader_Origin").bootstrapTable('refresh');
                            } else {
                                showTips($(message).find("message").text(), "alert-danger", "alert-success");
                            }
                        },
                        error: function (message) {
                            $("#DeptLeader_Origin").bootstrapTable('refresh')
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    });
                }
            });



            function setCreateControlValue() {
                setCreateDeptValue();
                setCreateLeaderUserValue();

            }



            function setCreateDeptValue() {
                var deptGroup = $("[name='add_dept_name']");
                var $deptId = $("[name='add_dept_id']");
                var html = "";
                deptGroup.empty();
                for (var i = 1; i < allDept.length; i++) {
                    html += "<option value='" + allDept[i].DeptId + "'>" + allDept[i].DeptName + "</option>";
                }
                deptGroup.append(html);
                var id = allDept[1].DeptId;
                $deptId.val(id);
                $deptId.attr("readonly", "true");
                deptGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $deptId.val(selectVal);
                });
            }



            function setCreateLeaderUserValue() {
                $("input[name='add_leader_user_name']").attr("readonly", "true");
                $("input[name='add_leader_dept_id']").attr("readonly", "true");
                $("input[name='add_leader_dept_name']").attr("readonly", "true");
                $("input[name='add_leader_user_id']").on('blur', function () {
                    if ($("input[name='add_leader_user_id']").val() !== "") {
                        $.ajax({
                            url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                            type: "post",
                            dataType: "xml",
                            data: { "UserId": $("input[name='add_leader_user_id']").val() },
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                            success: function (data) {
                                if ($(data).find("status").text() === "1") {
                                    var user = JSON.parse($(data).find("data").text());
                                    $("input[name='add_leader_user_name']").val(user[0].Name);
                                    //通过领导工号自动填充领导所属部门号和部门
                                    $("input[name='add_leader_dept_id']").val(user[0].Dept_ID);
                                    $("input[name='add_leader_dept_name']").val(user[0].Dept_Name);

                                } else {
                                    $("input[name='add_leader_user_name']").val("");
                                    showTips($(data).find("message"), "alert-danger", "alert-success");
                                }
                            },
                            error: function (message) {
                                alert("获取管理员名称失败！请检查相关配置！");
                            }
                        });
                    } else {
                        $("input[name='add_leader_user_name']").val("");
                        $("input[name='add_leader_dept_id']").val("");
                        $("input[name='add_leader_dept_name']").val("");
                    }
                });
            }


            function bindCreateIsNullValidate() {
                $("[name='add_dept_id']").on('blur', function () {
                    changeClassByNull($(this));
                });
                $("[name='add_leader_user_name']").on('blur', function () {
                    changeClassByNull($(this));
                });

            }

            //取消
            $('.table').delegate('[data-row^="cancel"]', 'row.cancel', function (e) {
                $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    //row.cancel(e);
                    reloadCurrentRow(e);
                    row.success(e, 'edit');
                } else {
                    //新增
                    $(e.target).closest('tr').remove();
                }

                function reloadCurrentRow(e) {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataDeptDefaultLeaderEntityObj = $("#DeptLeader_Origin").bootstrapTable('getData')[currentIndex];
                    $('#DeptLeader_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataDeptDefaultLeaderEntityObj });
                }
            });



            function changeClassByNull($this) {
                if (isRequestNotNull($this.val())) {
                    $this.addClass("error");
                } else {
                    $this.removeClass("error");
                }
            }



            //编辑行
            $('.table').delegate('[data-row^="edit"]', 'row.edit', function (e) {

                $(e.target).closest('tr').children().find(".DeptId-edit,.LeaderUserName-edit,.LeaderDeptId-edit,.LeaderDeptName-edit").attr("readonly", "readonly");

                setEditDeptValue(e);
                setEditLeaderUserValue(e);
            });

            function setEditDeptValue(e) {
                $tds = $(e.target).closest('tr').children();
                var stepGroup = $tds.find(".DeptName-edit");
                var currentIndex = $(e.target).closest('tr').data().index
                var model = $("#DeptLeader_Origin").bootstrapTable('getData')[currentIndex];

                var deptId = allDept[0].DeptId;
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < allDept.length; i++) {
                    if (allDept[i].DeptName === model.DeptName) {
                        html += "<option selected='selected' value='" +
                            allDept[i].DeptId +
                            "'>" +
                            allDept[i].DeptName +
                            "</option>";

                        deptId = allDept[i].DeptId;
                    } else {
                        html += "<option value='" + allDept[i].DeptId + "'>" + allDept[i].DeptName + "</option>";
                    }
                }
                stepGroup.append(html);
                $tds.find(".DeptId-edit").val(deptId);
                stepGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $tds.find(".DeptId-edit").val(selectVal);
                });
            }



            function setEditLeaderUserValue(e) {

                $tds = $(e.target).closest('tr').children();


                $tds.find(".LeaderUserId-edit").on('blur', function () {
                    if ($tds.find(".LeaderUserId-edit").val() !== "") {
                        $.ajax({
                            url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                            type: "post",
                            dataType: "xml",
                            data: { "UserId": $tds.find(".LeaderUserId-edit").val() },
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                            success: function (data) {
                                if ($(data).find("status").text() === "1") {
                                    var user = JSON.parse($(data).find("data").text());
                                    $tds.find(".LeaderUserName-edit").val(user[0].Name);
                                    //通过领导工号自动填充领导所属部门号和部门
                                    $tds.find(".LeaderDeptId-edit").val(user[0].Dept_ID);
                                    $tds.find(".LeaderDeptName-edit").val(user[0].Dept_Name);

                                } else {
                                    $tds.find(".LeaderUserName-edit").val("");
                                    $tds.find(".LeaderDeptId-edit").val("");
                                    $tds.find(".LeaderDeptName-edit").val("");
                                    showTips($(data).find("message"), "alert-danger", "alert-success");
                                }
                            },
                            error: function (message) {
                                alert("获取管理员名称失败！请检查相关配置！");
                            }
                        });
                    } else {
                        $tds.find(".LeaderUserName-edit").val("");
                        $tds.find(".LeaderDeptId-edit").val("");
                        $tds.find(".LeaderDeptName-edit").val("");
                    }
                });
            }




            //非空验证
            function bindEditIsNullValidate(e) {
                $tds = $(e.target).closest('tr').children();


                $tds.find(".DeptName-edit").on('blur', function () {
                    changeClassByNull($(this));
                });
                $tds.find(".LeaderUserId-edit").on('blur', function () {
                    changeClassByNull($(this));
                });
            }



            function editSaveBtn() {
                event.html(
                    '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>');
                $tr.find('.form-control').each(function () {
                    $(this).attr('disabled', false).removeClass('disabled');
                });
            }

            function createSaveBtn() {
                event.html(
                    '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="delete" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>');
                $tr.find('.form-control').each(function () {
                    var name = $(this).attr('name');
                    if (name !== "add_group_id_name" && name !== "add_depts_id") {
                        $(this).attr('disabled', false).removeClass('disabled');
                    }
                });
            }


            //保存
            $('.table').delegate('[data-row^="save"]', 'row.save', function (e) {
                var event=$(e.target).closest('td');             
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    if (isNotNullByEdit(e)) {
                        edit(e);
                    }
                } else {
                    //新增
                                if (add()) {
                                    setTimeout(function () {
                                        event.html(
                                            '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="erase" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>')
                                    });
                                } else {
                                    setTimeout(function () {
                                        event.html(
                                            '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="erase" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>')
                                    });
                                }
                            
                }
            });




            function isNotNullByEdit(e) {

                $tds = $(e.target).closest('tr').children();

                var DeptId = $tds.find(".DeptId-edit").val();
                var DeptName = $tds.find(".DeptName-edit").val();
                var LeaderUserId = $tds.find(".LeaderUserId-edit").val();
                var LeaderUserName = $tds.find(".LeaderUserName-edit").val();
                var LeaderDeptId = $tds.find(".LeaderDeptId-edit").val();
                var LeaderDeptName = $tds.find(".LeaderDeptName-edit").val();

                $tds.find(".DeptId-edit").blur();
                $tds.find(".DeptName-edit").blur();
                $tds.find(".LeaderUserId-edit").blur();
                $tds.find(".LeaderUserName-edit").blur();
                $tds.find(".LeaderDeptId-edit").blur();
                $tds.find(".LeaderDeptName-edit").blur();


                if (DeptId === "" || DeptName === "" || LeaderUserId === "" || LeaderUserName === "" || LeaderDeptId === ""
                    || LeaderDeptName === "") {
                    return false;
                }
                else {
                    return true;
                }
            }


            //编辑
            function edit(e) {

                $("#DeptLeader_Origin").bootstrapTable('getData');
                $tds = $(e.target).closest('tr').children();
                var currentIndex = $(e.target).closest('tr').data().index


                //旧模型
                var oldSmBasicDataDeptDefaultLeaderEntity = $("#DeptLeader_Origin").bootstrapTable('getData')[currentIndex];
                oldSmBasicDataDeptDefaultLeaderEntity.CreateTime = "";

                //新模型
                var DeptId = $tds.find(".DeptId-edit").val();
                var LeaderUserId = $tds.find(".LeaderUserId-edit").val();
                var OrderNumber = $tds.find(".OrderNumber-edit").val();

                var smBasicDataDeptDefaultLeaderEntityObj = new SmBasicDataDeptDefaultLeaderEntityObj();
                smBasicDataDeptDefaultLeaderEntityObj.DeptId = DeptId;
                smBasicDataDeptDefaultLeaderEntityObj.LeaderUserId = LeaderUserId;
                smBasicDataDeptDefaultLeaderEntityObj.OrderNumber = OrderNumber;

                var smBasicDataDeptDefaultLeaderEntity = '{"smBasicDataDeptDefaultLeaderEntity":' + JSON.stringify(smBasicDataDeptDefaultLeaderEntityObj) + ',"oldSmBasicDataDeptDefaultLeaderEntity":' + JSON.stringify(oldSmBasicDataDeptDefaultLeaderEntity) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/EditSMBasicDataDeptDefaultLeader",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataDeptDefaultLeaderEntity,

                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");

                            var json = JSON.parse(message.d.data);
                            smBasicDataDeptDefaultLeaderEntityObj.DeptName = json.DeptName;
                            smBasicDataDeptDefaultLeaderEntityObj.LeaderUserName = json.LeaderUserName;
                            smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptId = json.LeaderDeptId;
                            smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptName = json.LeaderDeptName;
                            $('#DeptLeader_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataDeptDefaultLeaderEntityObj });
                            $("#DeptLeader_Origin").bootstrapTable('refresh')

                        } else {
                            $("#DeptLeader_Origin").bootstrapTable('refresh')
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#DeptLeader_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            }



            function SmBasicDataDeptDefaultLeaderEntityObj() {

                var smBasicDataDeptDefaultLeaderEntityObj = new Object();
                smBasicDataDeptDefaultLeaderEntityObj.DeptId = "";
                smBasicDataDeptDefaultLeaderEntityObj.DeptName = "";
                smBasicDataDeptDefaultLeaderEntityObj.LeaderUserId = "";
                smBasicDataDeptDefaultLeaderEntityObj.LeaderUserName = "";
                smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptID = "";
                smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptName = "";
                smBasicDataDeptDefaultLeaderEntityObj.OrderNumber = "";

                return smBasicDataDeptDefaultLeaderEntityObj;
            }

            function isNotNullByCreate() {
                var departmentId = $('input[name="add_dept_id"]').val();
                var leaderUserId = $('input[name="add_leader_user_id"]').val();
                $('input[name="add_dept_id"]').blur();
                $('input[name="add_leader_user_id"]').blur();
                if (departmentId===""||leaderUserId==="") {
                    return false;
                } else {
                    return true;
                }
            }

            //增加
            function add() {

                var departmentId = $('input[name="add_dept_id"]').val();
                var leaderUserId = $('input[name="add_leader_user_id"]').val();
                var orderNumber = $('input[name="add_order_number"]').val();
                var smBasicDataDeptDefaultLeaderEntityObj = new Object();
                smBasicDataDeptDefaultLeaderEntityObj.DeptId = departmentId;
                smBasicDataDeptDefaultLeaderEntityObj.LeaderUserId = leaderUserId;
                smBasicDataDeptDefaultLeaderEntityObj.OrderNumber = orderNumber;

                var smBasicDataDeptDefaultLeaderEntity = '{"smBasicDataDeptDefaultLeaderEntity":' + JSON.stringify(smBasicDataDeptDefaultLeaderEntityObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSmBasicDeptDefaultLeader",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataDeptDefaultLeaderEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#DeptLeader_Origin").bootstrapTable('refresh')
                            return true;
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        $("#DeptLeader_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                        return false;
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
