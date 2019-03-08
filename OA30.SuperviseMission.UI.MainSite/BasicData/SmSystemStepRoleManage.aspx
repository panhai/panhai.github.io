<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmSystemStepRoleManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmSystemStepRoleManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>步骤角色定义</title>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#parameter">管理</a></li>
                <li class="active">步骤角色定义</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#parameter'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">步骤</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_step" aria-labelledby="dLabel">
                                    <option selected="selected" value="">全部</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">角色</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_role" aria-labelledby="dLabel">
                                    <option selected="selected" value="">全部</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group" style="margin-left:50px;">
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
            <table id="SystemStepRole_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>
    <script id="add_step" type="text/x-template">
	    <select class="form-control" name="add_step_name">
		    
	    </select>
    </script>
    <script id="add_role" type="text/x-template">
	    <select class="form-control" name="add_role_name">
		    
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
    require(['jquery', 'bootstrap', 'cs-table', 'bootstrap-table', 'tableExport'],
        function ($, row) {
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSuperviseMissionSystemStepRoleEntityList";

            //初始化
            InitTable("#SystemStepRole_Origin", initUrl);

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
                        var roleId = $("#search_role option:selected").val();
                        var stepId = $("#search_step option:selected").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            stepId: stepId,
                            roleId: roleId
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
                        width: 150,
                        formatter: function (value, row, index) {
                            return [
                                '<button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button>'
                            ].join('');
                        }
                    }, {
                        field: 'StepId',
                        title: '步骤ID',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled stepid-edit form-control" value="' + row.StepId + '"/>';
                        }
                    }, {
                        field: 'StepName',
                        title: '步骤名称',
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="form-control stepname-edit disabled" disabled>'
                                + '<option  value="' + row.StepId + '" selected = "selected">' + row.StepName + '</option>'
                                + '</select>';
                        }
                    },
                        {
                            field: 'RoleId',
                            title: '角色ID',
                            width: 150,
                            formatter: function (value, row, index) {
                                return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled roleid-edit form-control" value="' + row.RoleId + '"/>';
                            }
                        }, {
                            field: 'RoleName',
                            title: '角色名称',
                            formatter: function (value, row, index) {
                                return '<select data-type="edit" class="form-control rolename-edit disabled" disabled>'
                                    + '<option  value="' + row.RoleId + '" selected = "selected">' + row.RoleName + '</option>'
                                    + '</select>';
                            }
                        }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };

            //获取角色列表。
            var role;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetRoleListByStepRoleManage",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    role = JSON.parse($(data).find("data").text());
                    bindRoleSelectSearch();
                },
                error: function (message) {
                    alert("获取角色列表失败！");
                }
            });

            //绑定角色select列表。
            function bindRoleSelectSearch() {
                $selectRole = $("#search_role");
                var html = "";
                for (var i = 0; i < role.length; i++) {
                    html += "<option value='" + role[i].RoleId + "'>" + role[i].RoleName + "</option>";
                }
                $selectRole.append(html);
            }

            //获取步骤列表。
            var step;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetStepListByStepRoleManage",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    step = JSON.parse($(data).find("data").text());
                    bindStepSelectSearch();
                },
                error: function (message) {
                    alert("获取步骤列表失败！");
                }
            });

            //绑定角色select列表。
            function bindStepSelectSearch() {
                $selectStep = $("#search_step");
                var html = "";
                for (var i = 0; i < step.length; i++) {
                    html += "<option value='" + step[i].StepId + "'>" + step[i].StepName + "</option>";
                }
                $selectStep.append(html);
            }

            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {
                $("#search_role").find("option").eq(0).prop("selected", true);
                $("#search_step").find("option").eq(0).prop("selected", true);
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#SystemStepRole_Origin", initUrl);
            });



            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {


                var type = "SmSystemStepRoleManage";

                var roleId = $("#search_role option:selected").val();
                var stepId = $("#search_step option:selected").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&roleId=" + roleId + "&stepId=" + stepId
                ;
                window.open(url);
            });


            $('#SystemStepRole_Origin').csTable({
                fields: [{
                    type: 'text',
                    name: 'add_step_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_step'
                }, {
                    type: 'text',
                    name: 'add_role_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_role'
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $('[data-row^="table"]').on('click',  function (e) {
                if ($("input[name='add_step_id']").length === 0) {
                    $('.table').csTable('add');
                    setCreateControlValue();
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            //删除行。
            $('[data-row^="delete"]').on('click',  function (e) {
                //此判断用来区分删除和取消按钮，新增的时候取消按钮也有data-row^="delete"
                if ($(e.target).data().type != "cancel") {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataDeptRoleEntityObj = $("#SystemStepRole_Origin").bootstrapTable('getData')[currentIndex];

                    $.ajax({
                        url: "WebServices/SuperviseMissionWebServices.asmx/DelSMSystemStepRole",
                        type: "post",
                        dataType: "xml",
                        data: { "stepId": smBasicDataDeptRoleEntityObj.StepId, "roleId": smBasicDataDeptRoleEntityObj.RoleId },
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        success: function (message) {
                            if ($(message).find("status").text() === "1") {
                                showTips($(message).find("message").text(), "alert-success", "alert-danger");
                                $(e.target).closest('tr').remove();
                                $("#SystemStepRole_Origin").bootstrapTable('refresh');
                            } else {
                                showTips($(message).find("message").text(), "alert-danger", "alert-success");
                            }
                        },
                        error: function (message) {
                            $("#SystemStepRole_Origin").bootstrapTable('refresh')
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    });
                }
            });

            function setCreateControlValue() {
                setCreateRoleValue();
                setCreateStepValue();
            }

            function setCreateRoleValue() {
                var roleGroup = $("[name='add_role_name']");
                var $roleId = $("[name='add_role_id']");
                roleGroup.empty();
                for (var i = 0; i < role.length; i++) {
                    roleGroup.append("<option value='" + role[i].RoleId + "'>" + role[i].RoleName + "</option>");
                }
                var id = role[0].RoleId;
                $roleId.val(id);
                $roleId.attr("readonly", "true");
                roleGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $roleId.val(selectVal);
                });
            }

            function setCreateStepValue() {
                var stepGroup = $("[name='add_step_name']");
                var $stepId = $("[name='add_step_id']");
                stepGroup.empty();
                for (var i = 0; i < step.length; i++) {
                    stepGroup.append("<option value='" + step[i].StepId + "'>" + step[i].StepName + "</option>");
                }
                var id = step[0].StepId;
                $stepId.val(id);
                $stepId.attr("readonly", "true");
                stepGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $stepId.val(selectVal);
                });
            }

            //取消。
            $('.table').delegate('[data-row^="cancel"]', 'row.cancel', function (e) {
                $(e.target).closest('tr').remove();
            });

            function changeClassByNull($this) {
                if (isRequestNotNull($this.val())) {
                    $this.addClass("error");
                } else {
                    $this.removeClass("error");
                }
            }


            //保存
            $('.table').delegate('[data-row^="save"]', 'row.save', function (e) {
                var event = $(e.target).closest('td');
                if (add()) {
                    setTimeout(function () {
                        event.html(
                            '<button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button>')
                    });
                } else {
                    setTimeout(function () {
                        event.html(
                            '<div class="btn-group btn-group-sm" role="group"><button data-row="save" data-type="cancel" type="button" class="btn btn-sm btn-default">保存</button><button data-row="delete" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>')
                    });
                }
            });

            //增加
            function add() {
                var roleId = $('input[name="add_role_id"]').val();
                var stepId = $('input[name="add_step_id"]').val();
                var smSystemStepRoleDefinitionObj = new Object();
                smSystemStepRoleDefinitionObj.RoleId = roleId;
                smSystemStepRoleDefinitionObj.StepId = stepId;
                var smBasicDataDeptRoleDefinitionEntity = '{"smSystemStepRoleDefinitionEntity":' + JSON.stringify(smSystemStepRoleDefinitionObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSMSystemStepRole",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataDeptRoleDefinitionEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#SystemStepRole_Origin").bootstrapTable('refresh')
                            return true;
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        $("#SystemStepRole_Origin").bootstrapTable('refresh')
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
