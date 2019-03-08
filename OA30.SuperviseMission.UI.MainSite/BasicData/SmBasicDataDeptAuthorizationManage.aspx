<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmBasicDataDeptAuthorizationManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDataDeptAuthorizationManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>部门管理员授权</title>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#department">管理</a></li>
                <li class="active">部门管理员授权</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#department'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-md-4 col-xs-4 col-lg-4 col-sm-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">部门</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8 select_control">
                                <input type="hidden" id="search_department_ids" value="" />
                                <input type="hidden" id="search_department" value="" />
                                <select id="select_dept" data-live-search="true" class="selectpicker"></select>
                            </div>
                        </div>
                    </div>
                    <div class="col col-md-4 col-xs-4 col-lg-4 col-sm-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-md-4 col-xs-4 col-lg-4 col-sm-4 control-label">成员工号</label>
                            <div class="col-md-8 col-xs-8 col-lg-8 col-sm-8">
                                <input type="text" class="form-control" id="search_member_id" placeholder="请输入成员工号" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group" style="margin-left: 70px">
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
            <table id="DeptRole_Origin" data-show-columns="false" class="table table-bordered"></table>
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
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSMBasicDataDeptRolesByDept";

            //初始化
            InitTable("#DeptRole_Origin", initUrl);

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
                        var memberId = $("#search_member_id").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            searchDeptIds: searchDeptIds,
                            memberId: memberId
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
                        formatter: function (value, row, index) {
                            return [
                                '<button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button>'
                            ].join('');
                        }
                    }, {
                        field: 'DeptId',
                        title: '部门号',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled deptid-edit form-control" value="' + row.DeptId + '"/>';
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
                        field: 'MemberId',
                        title: '成员工号',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" data-type="edit" class="disabled memberid-edit form-control" value="' + row.MemberId + '"/>';
                        }
                    }, {
                        field: 'MemberName',
                        title: '姓名',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" data-type="edit" class="disabled membername-edit form-control" value="' + row.MemberName + '"/>';
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
                    //$selectDept.append("<li><input type='radio' name='dept' id='" + dept[i].DeptId + "' data-deptname='" + dept[i].DeptName + "' value='" + dept[i].DeptId + "'/><label style='cursor:pointer' for='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</label></li>");
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
                $("#search_department_ids").val('');
                $("#search_member_id").val('');
                var selectDeptText = $("#select_dept option:first").text();
                $("#search_department").next().find(".filter-option").html(selectDeptText);
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#DeptRole_Origin", initUrl);
            });

            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {


                var type = "SmBasicDataDeptAuthorizationManage";
                var dept_ids = $('#search_department_ids').val();
                var searchMemberId = $("#search_member_id").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&dept_ids=" + dept_ids + "&searchMemberId=" + searchMemberId;
                window.open(url);
            });


            $('#DeptRole_Origin').csTable({
                fields: [{
                    type: 'text',
                    name: 'add_dept_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_dept'
                }, {
                    type: 'text',
                    name: 'add_member_id',
                    value: ''
                }, {
                    type: 'text',
                    name: 'add_member_name',
                    value: ''
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $('[data-row^="table"]').on('click', function (e) {
                if ($("input[name='add_dept_id']").length === 0) {
                    $('.table').csTable('add');
                    //绑定非空验证事件。
                    bindCreateIsNullValidate();
                    setCreateControlValue();
                    $('[name="add_dept_name"]').selectpicker('show');
                    $('[name="add_dept_name"]').selectpicker({
                        dropupAuto: false
                    });
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            //删除行。
            $('.table').delegate('[data-row^="delete"]','click', function (e) {
                //此判断用来区分删除和取消按钮，新增的时候取消按钮也有data-row^="delete"
                if ($(e.target).data().type != "cancel") {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataDeptRoleEntityObj = $("#DeptRole_Origin").bootstrapTable('getData')[currentIndex];

                    $.ajax({
                        url: "WebServices/SuperviseMissionWebServices.asmx/DelSMBasicDataDeptRoleByDept",
                        type: "post",
                        dataType: "xml",
                        data: { "deptId": smBasicDataDeptRoleEntityObj.DeptId, "memberId": smBasicDataDeptRoleEntityObj.MemberId },
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        success: function (message) {
                            if ($(message).find("status").text() === "1") {
                                showTips($(message).find("message").text(), "alert-success", "alert-danger");
                                $(e.target).closest('tr').remove();
                                $("#DeptRole_Origin").bootstrapTable('refresh');
                            } else {
                                showTips($(message).find("message").text(), "alert-danger", "alert-success");
                            }
                        },
                        error: function (message) {
                            $("#DeptRole_Origin").bootstrapTable('refresh')
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    });
                }
            });

            function setCreateControlValue() {
                setCreateDeptValue(); 
                setCreateMemberValue();
            }

            function setCreateMemberValue() {
                $("input[name='add_member_name']").attr("readonly", "true");
                $("input[name='add_member_id']").on('blur', function () {
                    if ($("input[name='add_member_id']").val() !== "") {
                        $.ajax({
                            url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                            type: "post",
                            dataType: "xml",
                            data: { "UserId": $("input[name='add_member_id']").val() },
                            contentType: "application/x-www-form-urlencoded; charset=utf-8",
                            success: function (data) {
                                if ($(data).find("status").text() === "1") {
                                    var user = JSON.parse($(data).find("data").text());
                                    $("input[name='add_member_name']").val(user[0].Name);
                                } else {
                                    $("input[name='add_member_name']").val("");
                                    showTips($(data).find("message"), "alert-danger", "alert-success");
                                }
                            },
                            error: function (message) {
                                alert("获取管理员名称失败！请检查相关配置！");
                            }
                        });
                    } else {
                        $("input[name='add_member_name']").val("");
                    }
                });
            }

            function setCreateDeptValue() {
                var deptGroup = $("[name='add_dept_name']");
                var $deptId = $("[name='add_dept_id']");
                deptGroup.empty();
                for (var i = 1; i < allDept.length; i++) {
                    deptGroup.append("<option value='" + allDept[i].DeptId + "'>" + allDept[i].DeptName + "</option>");
                }
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
                $("[name='add_member_id']").on('blur', function () {
                    changeClassByNull($(this));
                });
            }

            //取消。
            $('.table').on('[data-row^="cancel"]','row.cancel', function (e) {
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
                if (isNotNullByCreate()) {
                    if (add()) {
                        setTimeout(function () {
                            event.html(
                                '<button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button>')
                        });
                    } else {
                        setTimeout(function () {
                            event.html(
                                '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="delete" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>')
                        });
                    }
                } else {
                    setTimeout(function () {
                        event.html(
                            '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="delete" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>')
                    });
                }
            });

            function isNotNullByCreate() {
                var departmentId = $('input[name="add_dept_id"]').val();
                var memberId = $('input[name="add_member_id"]').val();
                var memberName = $('input[name="add_member_name"]').val();
                $('input[name="add_dept_id"]').blur();
                $('input[name="add_member_id"]').blur();
                $('input[name="add_member_name"]').blur();
                if (departmentId === "" || memberId === "" || memberName === "") {
                    return false;
                } else {
                    return true;
                }
            }

            //增加
            function add() {
                var departmentId = $('input[name="add_dept_id"]').val();
                var memberId = $('input[name="add_member_id"]').val();
                var smBasicDataDeptRoleDefinitionObj = new Object();
                smBasicDataDeptRoleDefinitionObj.DeptId = departmentId;
                smBasicDataDeptRoleDefinitionObj.MemberId = memberId;
                var smBasicDataDeptRoleDefinitionEntity = '{"smBasicDataDeptRoleDefinitionEntity":' + JSON.stringify(smBasicDataDeptRoleDefinitionObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSmBasicDataDeptRoleByDept",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smBasicDataDeptRoleDefinitionEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#DeptRole_Origin").bootstrapTable('refresh')
                            return true;
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        $("#DeptRole_Origin").bootstrapTable('refresh')
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
