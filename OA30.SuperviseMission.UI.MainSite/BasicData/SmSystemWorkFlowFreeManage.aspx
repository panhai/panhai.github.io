<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmSystemWorkFlowFreeManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmSystemWorkFlowFreeManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>自由流程定义</title>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#parameter">管理</a></li>
                <li class="active">自由流程定义</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#parameter'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
              
                
                  <div class="row">
                    
              
                    
                     <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">所属类型</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_smType" aria-labelledby="dLabel">
                                    <option selected="selected" value="">全部</option>
                                </select>
                            </div>
                        </div>
                    </div>
        
                      
                      
                      
                      <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">当前步骤</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_currentstep" aria-labelledby="dLabel">
                                    <option selected="selected" value="">全部</option>
                                </select>
                            </div>
                        </div>
                    </div>


                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">下一步骤</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_nextstep" aria-labelledby="dLabel">
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
            <table id="SmSystemWorkFlowFree_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>
    <script id="add_activity_flag" type="text/x-template">
	    <select class="form-control" name="add_activity_flag_select">
		    <option  value="1" selected = "selected">是</option>
            <option  value="0">否</option>
	    </select>
    </script>
    <script id="add_current_step" type="text/x-template">
	    <select class="form-control" name="add_current_step_name">
		    
	    </select>
    </script>
    <script id="add_next_step" type="text/x-template">
	    <select class="form-control" name="add_next_step_name">
		    
	    </select>
    </script>
    <script id="add_sm_type" type="text/x-template">
	    <select class="form-control" name="add_sm_type_name">
		    
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
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSuperviseMissionSystemWorkFlowFreeEntityList";

            //初始化
            InitTable("#SmSystemWorkFlowFree_Origin", initUrl);

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
                        var nextStepId = $("#search_nextstep option:selected").val();
                        var currentStepId = $("#search_currentstep option:selected").val();
                        var smType = $("#search_smType option:selected").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            currentStepId: currentStepId,
                            nextStepId: nextStepId,
                            smType:smType
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
                                '<button type="button" data-row="inversion" class="btn btn-default btn-sm">置否</button>'
                            ].join('');
                        }
                    }, {
                        field: 'StepId',
                        title: '当前步骤ID',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled stepid-edit form-control" value="' + row.CurrentStepId + '"/>';
                        }
                    }, {
                        field: 'StepName',
                        title: '当前步骤名称',
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="form-control stepname-edit disabled" disabled>'
                                + '<option  value="' + row.StepId + '" selected = "selected">' + row.CurrentStepName + '</option>'
                                + '</select>';
                        }
                    },
                        {
                            field: 'RoleId',
                            title: '下一步骤ID',
                            width: 150,
                            formatter: function (value, row, index) {
                                return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled roleid-edit form-control" value="' + row.NextStepId + '"/>';
                            }
                        }, {
                            field: 'RoleName',
                            title: '下一步骤名称',
                            formatter: function (value, row, index) {
                                return '<select data-type="edit" class="form-control rolename-edit disabled" disabled>'
                                    + '<option  value="' + row.RoleId + '" selected = "selected">' + row.NextStepName + '</option>'
                                    + '</select>';
                            }
                        },{
                            field: 'SmType',
                            title: '所属类型',
                            formatter: function (value, row, index) {
                                return '<input disabled="" data-type="edit" class="disabled form-control typename-edit" value="' + row.SmType + '"/>';
                            }
                        },
                        {
                            field: 'ActivityFlag',
                            title: '是否可用',
                            formatter: function (value, row, index) {
                                if (value === 1) {
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
                        }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };

            //获取smtype。
            var smtype;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSmType",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    smtype = JSON.parse($(data).find("data").text());
                    bindSmtypeValue();
                },
                error: function (message) {
                    alert("获取所属类型列表失败！");
                }
            });

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
                    bindNextStepSelectSearch();
                },
                error: function (message) {
                    alert("获取步骤列表失败！");
                }
            });



            function bindSmtypeValue() {
                $smTypeGroup = $("#search_smType");
    
               var html = "";
                for (var i = 0; i < smtype.length; i++) {
                    html += "<option value='" + smtype[i].TypeId + "'>" + smtype[i].TypeName + "</option>";
                }
                $smTypeGroup.append(html);
            }


            //绑定角色select1列表。
            function bindStepSelectSearch() {
                $selectStep = $("#search_currentstep");
                var html = "";
                for (var i = 0; i < step.length; i++) {
                    html += "<option value='" + step[i].StepId + "'>" + step[i].StepName + "("+step[i].StepId+")"+"</option>";
                }
                $selectStep.append(html);
            }

            //绑定角色select2列表。
            function bindNextStepSelectSearch() {
                $selectStep = $("#search_nextstep");
                var html = "";
                for (var i = 0; i < step.length; i++) {
                    html += "<option value='" + step[i].StepId + "'>" + step[i].StepName + "(" + step[i].StepId + ")" + "</option>";
                }
                $selectStep.append(html);
            }





            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {
                $("#search_nextstep").find("option").eq(0).prop("selected", true);
                $("#search_currentstep").find("option").eq(0).prop("selected", true);
                $("#search_smType").find("option").eq(0).prop("selected", true);
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#SmSystemWorkFlowFree_Origin", initUrl);
            });


            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {

                var type = "SmSystemWorkFlowFreeManage";

                var nextStepId = $("#search_nextstep option:selected").val();
                var currentStepId = $("#search_currentstep option:selected").val();
                var smType = $("#search_smType option:selected").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&nextStepId=" + nextStepId + "&currentStepId=" + currentStepId + "&smType=" + smType;
                window.open(url);
            });


            $('#SmSystemWorkFlowFree_Origin').csTable({
                fields: [{
                    type: 'text',
                    name: 'add_current_step_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_current_step'
                }, {
                    type: 'text',
                    name: 'add_next_step_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_next_step'
                }, {
                    type: 'select',
                    template: '#add_sm_type'
                }, {
                    type: 'select',
                    template: '#add_activity_flag'
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $('[data-row^="table"]').on('click',  function (e) {
                if ($("input[name='add_current_step_id']").length === 0) {
                    $('.table').csTable('add');
                    //绑定非空验证事件。
                    setCreateControlValue();
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            function setCreateControlValue() {
                setCreateCurrentStepValue();
                setCreateNextStepValue();
                setCreateSmtypeValue();
            }

            function setCreateSmtypeValue() {
                var stepGroup = $("[name='add_sm_type_name']");
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < smtype.length; i++) {
                    html += "<option value='" + smtype[i].TypeId + "'>" + smtype[i].TypeName + "</option>";
                }
                stepGroup.append(html);
            }

            function setCreateCurrentStepValue() {
                var stepGroup = $("[name='add_current_step_name']");
                var $stepId = $("[name='add_current_step_id']");
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

            function setCreateNextStepValue() {
                var stepGroup = $("[name='add_next_step_name']");
                var $stepId = $("[name='add_next_step_id']");
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

            //置否。
            $('[data-row^="inversion"]').on('click',  function (e) {
                var currentIndex = $(e.target).closest('tr').data().index
                var smSystemWorkFlowFreeDefinitionEntityObj = $("#SmSystemWorkFlowFree_Origin").bootstrapTable('getData')[currentIndex];
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/InversionSMSystemWorkFlowFree",
                    type: "post",
                    dataType: "xml",
                    data: { "currentStepId": smSystemWorkFlowFreeDefinitionEntityObj.CurrentStepId, "nextStepId": smSystemWorkFlowFreeDefinitionEntityObj.NextStepId, "smType": smSystemWorkFlowFreeDefinitionEntityObj.SmType },
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    success: function (message) {
                        if ($(message).find("status").text() === "1") {
                            showTips($(message).find("message").text(), "alert-success", "alert-danger");
                            $("#SmSystemWorkFlowFree_Origin").bootstrapTable('refresh');
                        } else {
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#SmSystemWorkFlowFree_Origin").bootstrapTable('refresh')
                        showTips($(message).find("message").text(), "alert-danger", "alert-success");
                    }
                });
            });

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
                var currentStepId = $('input[name="add_current_step_id"]').val();
                var nextStepId = $('input[name="add_next_step_id"]').val();
                var type = $('select[name="add_sm_type_name"] option:selected').val();
                var activityflag = $("select[name='add_activity_flag_select'] option:selected").val();
                var smSystemWorkFlowFreeObj = new Object();
                smSystemWorkFlowFreeObj.CurrentStepId = currentStepId;
                smSystemWorkFlowFreeObj.NextStepId = nextStepId;
                smSystemWorkFlowFreeObj.ActivityFlag = activityflag;
                smSystemWorkFlowFreeObj.SmType = type;
                var smSystemWorkFlowFreeEntity = '{"smSystemWorkFlowFreeEntity":' + JSON.stringify(smSystemWorkFlowFreeObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSMSystemWorkFlowFree",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smSystemWorkFlowFreeEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#SmSystemWorkFlowFree_Origin").bootstrapTable('refresh')
                            return true;
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        $("#SmSystemWorkFlowFree_Origin").bootstrapTable('refresh')
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

