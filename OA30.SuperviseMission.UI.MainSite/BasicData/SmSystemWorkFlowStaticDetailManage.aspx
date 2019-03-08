<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmSystemWorkFlowStaticDetailManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmSystemWorkFlowStaticDetailManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>固定流程配置</title>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#parameter">管理</a></li>
                <li class="active">固定流程配置</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#parameter'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">流程</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_workflow" aria-labelledby="dLabel">
                                    <option selected="selected" value="">全部</option>
                                </select>
                            </div>
                        </div>
                    </div>
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
                </div>
                <div class="form-group" style="margin-left:50px;">
                    <button class="btn btn-primary-s btn-group" id="btn_search">查询</button>
                    <button class="btn btn-default-s btn-group" id="btn_search_clear">清空</button>
                    <button class="btn btn-default-s btn-group"id="btn_export">导出</button>
                </div>
            </div>
        </div>
        <div id="tips-alert" class="alert alert-top" style="display: none;">&nbsp;</div>
        <div class="tar">
            <a href="javascript:;" data-row="table"><span class="iconfont icon-sv-add"></span>&nbsp;新增</a>
        </div>
        <div class="table-page">
            <table id="SmSystemWorkFlowStatic_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>
    <script id="add_workflow" type="text/x-template">
	    <select class="form-control" name="add_workflow_name">
		    
	    </select>
    </script>

    <script id="add_step" type="text/x-template">
	    <select class="form-control" name="add_step_name">
		    
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
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSuperviseMissionSystemWorkFlowStaticDetailEntityList";

            //初始化
            InitTable("#SmSystemWorkFlowStatic_Origin", initUrl);

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
                        var stepId = $("#search_step option:selected").val();
                        var workflowId = $("#search_workflow option:selected").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            stepId: stepId,
                            workflowId: workflowId
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
                        width: 100,
                        title: '操作',
                        formatter: function (value, row, index) {
                            return [
                                '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>'
                            ].join('');
                        }
                    }, {
                        field: 'FlowId',
                        title: '流程配置ID',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" data-type="edit" class="disabled flowid-edit form-control" value="' + row.FlowId + '"/>';
                        }
                    }, {
                        field: 'WorkFlowId',
                        title: '流程',
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="form-control workflowid-edit disabled" disabled>'
                                + '<option  value="' + row.WorkFlowId + '" selected = "selected">' + row.WorkFlowId + '</option>'
                                + '</select>';
                        }
                    }, {
                        field: 'FatherFlowId',
                        title: '父流程ID',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" data-type="edit" class="disabled fatherflowid-edit form-control" value="' + row.FatherFlowId + '"/>';
                        }
                    }, {
                        field: 'StepId',
                        title: '步骤ID',
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
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };

            //获取角色列表。
            var workflow;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetWorkFlowStaticList",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    workflow = JSON.parse($(data).find("data").text());
                    bindWorkFlowSelectSearch();
                },
                error: function (message) {
                    alert("获取流程列表失败！");
                }
            });

            //绑定角色select列表。
            function bindWorkFlowSelectSearch() {
                $selectWorkFlow = $("#search_workflow");
                var html = "";
                for (var i = 0; i < workflow.length; i++) {
                    html += "<option value='" + workflow[i].WorkFlowId + "'>" + workflow[i].WorkFlowName + "</option>";
                }
                $selectWorkFlow.append(html);
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
                $("#search_step").find("option").eq(0).prop("selected", true);
                $("#search_workflow").find("option").eq(0).prop("selected", true);
            });


            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {

                var type = "SmSystemWorkFlowStaticDetailManage";

                var stepId = $("#search_step option:selected").val();
                var workflowId = $("#search_workflow option:selected").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&stepId=" + stepId + "&workflowId" + workflowId;
                window.open(url);
            });


            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#SmSystemWorkFlowStatic_Origin", initUrl);
            });

            $('#SmSystemWorkFlowStatic_Origin').csTable({
                fields: [{
                    type: 'text',
                    name: 'add_flow_id',
                    value: ''
                }, {
                    type: 'select',
                    template: '#add_workflow'
                }, {
                    type: 'text',
                    name: 'add_fatherflow_id',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_step_id',
                    value: ''
                }, {
                    type: 'select',
                    template: '#add_step'
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $('[data-row^="table"]').on('click',function (e) {
                if ($("input[name='add_step_id']").length === 0) {
                    $('.table').csTable('add');
                    setCreateControlValue();
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            function setCreateControlValue() {
                $("input[name='add_flow_id']").attr("readonly", "readonly");
                $("input[name='add_fatherflow_id']").attr("readonly", "readonly");
                setCreateStepValue();
                setCreateWorkFlowValue();
            }

            function setCreateWorkFlowValue() {
                var workflowGroup = $("[name='add_workflow_name']");
                workflowGroup.empty();
                var html = "";
                for (var i = 0; i < workflow.length; i++) {
                    html += "<option value='" + workflow[i].WorkFlowId + "'>" + workflow[i].WorkFlowName + "</option>";
                }
                workflowGroup.append(html);
                var id = workflow[0].WorkFlowId;
            }

            function setCreateStepValue() {
                var stepGroup = $("[name='add_step_name']");
                var $stepId = $("[name='add_step_id']");
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < step.length; i++) {
                    html += "<option value='" + step[i].StepId + "'>" + step[i].StepName + "</option>";
                }
                stepGroup.append(html);
                var id = step[0].StepId;
                $stepId.val(id);
                $stepId.attr("readonly", "true");
                stepGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $stepId.val(selectVal);
                });
            }

            //编辑行
            $('.table').delegate('[data-row^="edit"]', 'row.edit', function (e) {
                $(e.target).closest('tr').children().find(".flowid-edit,.fatherflowid-edit").attr("readonly", "readonly");
                bindEditStep(e);
            });

            function bindEditStep(e) {
                $tds = $(e.target).closest('tr').children();
                var stepGroup = $tds.find(".stepname-edit");
                var currentIndex = $(e.target).closest('tr').data().index;
                var model = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];
                var stepId = step[0].StepId;
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < step.length; i++) {
                    if (step[i].StepName === model.StepName) {
                        html += "<option selected='selected' value='" +
                            step[i].StepId +
                            "'>" +
                            step[i].StepName +
                            "</option>";

                        stepId = step[i].StepId;
                    } else {
                        html += "<option value='" + step[i].StepId + "'>" + step[i].StepName + "</option>";
                    }
                }
                stepGroup.append(html);
                $tds.find(".stepid-edit").val(stepId);
                stepGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $tds.find(".stepid-edit").val(selectVal);
                });
            }

            //取消。
            $('.table').delegate('[data-row^="cancel"]', 'row.cancel', function (e) {
                var $tr = $(e.target).closest('tr');
                var currentIndex = $tr.data().index;
                var event = $(e.target).closest('td');
                if (!$(e.target).closest('tr').attr("id")) {
                    setTimeout(function () {
                        event.html(
                            '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="inversion" class="btn btn-default btn-sm">置否</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>');
                    });
                    //编辑
                    reloadCurrentRow(e);
                }

                function reloadCurrentRow() {
                    var smBasicDataEntityObj = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];
                    $('#SmSystemWorkFlowStatic_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataEntityObj });
                }
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
                var $tr = $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    if (!edit(e)) {
                        //保存失败（显示保存和取消按钮,当前行保持编辑状态）
                        setTimeout(editSaveBtn);
                    }
                } else {
                    //新增
                    if (!add()) {
                        setTimeout(createSaveBtn);
                    }
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
            });

            //增加
            function add() {
                var stepId = $('input[name="add_step_id"]').val();
                var workFlowId = $("[name='add_workflow_name'] option:selected").val();
                var smSystemStepRoleDefinitionObj = new Object();
                smSystemStepRoleDefinitionObj.WorkFlowId = workFlowId;
                smSystemStepRoleDefinitionObj.StepId = stepId;
                var smWorkFlowStaticDetailEntity = '{"smWorkFlowStaticDetailEntity":' + JSON.stringify(smSystemStepRoleDefinitionObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSmWorkFlowStaticDetail",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smWorkFlowStaticDetailEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                            return true;
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                        return false;
                    }
                });
            };

            function edit(e) {
                var stepId = $tds.find(".stepid-edit").val();
                var currentIndex = $(e.target).closest('tr').data().index
                var smSystemWorkFlowStaticTableObj = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];
                var smWorkFlowStaticObj = new Object();
                smWorkFlowStaticObj.StepId = stepId;
                smWorkFlowStaticObj.FlowId = smSystemWorkFlowStaticTableObj.FlowId;
                var smWorkFlowStaticDetailEntity = '{"smWorkFlowStaticDetailEntity":' + JSON.stringify(smWorkFlowStaticObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/EditSmWorkFlowStaticDetail",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smWorkFlowStaticDetailEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                            return true;
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                        return false;
                    }
                });
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
