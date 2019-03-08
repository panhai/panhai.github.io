<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmBasicDataPersonalDeptGroupManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDataPersonalDeptGroupManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>个人部门组设置</title>
    <style type="text/css">
        .fixed-table-body {
            overflow-x: inherit;
            overflow-y: inherit;
        }

        .selectpicker {
            width: 50%;
        }

        .form-group.mgl-xs > .btn:first-child {
            margin-left: -10px;
        }
    </style>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx">管理</a></li>
                <li class="active">个人部门组设置</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-5 col-sm-5 col-md-5 col-xs-5">
                        <div class="form-group clearfix">
                            <label for="" class="col-customer col-sm-5 col-xs-5 col-md-5 col-lg-5 control-label">部门组名称</label>
                            <div class="col-lg-7 col-xs-7 col-md-7 col-sm-7">
                                <input type="text" class="form-control" id="search_group_name" placeholder="请输入部门组名称" />
                            </div>
                        </div>
                    </div>
                    <div class="col col-lg-7 col-sm-7 col-md-7 col-xs-7">
                        <div class="form-group clearfix">
                            <label for="" class="col-sm-2 col-xs-2 col-md-2 col-lg-2 control-label">部门</label>
                            <div class="col-sm-8 col-lg-8 col-md-8 col-xs-8 select_control">

                                <input type="hidden" id="search_department_ids" value="" />
                                <input type="hidden" id="search_department" value="" />
                                <select id="select_dept" data-live-search="true" class="selectpicker form-control"></select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col col-lg-12 col-sm-12 col-md-12 col-xs-12">
                    <div class="form-group mgl-xs">
                        <button class="btn btn-primary-s btn-group" id="btn_search">查询</button>
                        <button class="btn btn-default-s btn-group" id="btn_search_clear">清空</button>
                        <button class="btn btn-default-s btn-group" id="btn_export">导出</button>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div id="tips-alert" class="alert alert-top" style="display: none;">&nbsp;</div>
        <div class="tar">
            <a href="javascript:;" data-row="table"><span class="iconfont icon-sv-add"></span>&nbsp;新增</a>
        </div>
        <div class="table-page" style="overflow: inherit;">
            <table id="DeptGroup_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>
    <script id="add_group_id" type="text/x-template">
        <input disabled="" name="add_group_id_name" class="form-control" style="font-weight: normal;"/>
    </script>
    <script id="add_dept_id" type="text/x-template">
        <div class="form-group">
            <input disabled="" name="add_depts_id" class="form-control" style="font-weight: normal;"/>
        </div>
    </script>
    <script id="add_dept" type="text/x-template">
	    <div class="form-group" data-toggle="depart">
		<select class="form-control" data-type="edit" name="add_dept_name" data-live-search="true" class="selectpicker">
			<option value="1">南航信息中心</option>
			<option value="2">南航飞行保障部</option>
			<option value="3">南航地勤</option>
		</select>
		<span class="iconfont icon-sv-reduce" data-row="unselect"></span>
	</div>
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
            var deptList = []
            //初次加载
            var firstLoad = true
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSMBasicDataDeptGroups";

            //初始化
            InitTable("#DeptGroup_Origin", initUrl);

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
                        var searchDeptName = $('#search_department').val() ? $('#search_department').val() : ''
                        var searchDeptIds = $('#search_department_ids').val();
                        var deptGroupName = $("#search_group_name").val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            searchDeptIds: searchDeptIds,
                            searchDeptName: searchDeptName,
                            deptGroupName: deptGroupName
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
                                '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="erase" class="btn btn-default btn-sm">删除</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>'
                            ].join('');
                        }
                    }, {
                        field: 'GroupName',
                        title: '部门组名称',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" data-type="edit" class="disabled groupname-edit form-control" value="' + row.Group.GroupName + '"/>';
                        }
                    }, {
                        field: 'GroupId',
                        title: '部门组ID',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" readonly="true" data-type="edit" class="disabled groupid-edit form-control" value="' + row.Group.GroupId + '"/>';
                        }
                    }, {
                        field: 'DeptName',
                        title: '部门名称',
                        formatter: function (value, row, index) {
                            var deptNameHtml = "";
                            for (var i = 0; i < row.Depts.length; i++) {
                                var spanHtml = " <span class='iconfont icon-sv-add' data-row='select' data-target='#add_dept'></span>";
                                if (row.Depts[i].Order !== 1) {
                                    spanHtml = " <span class='iconfont icon-sv-reduce' data-row='unselect'></span>";
                                }
                                deptNameHtml = deptNameHtml + '<div class="form-group" data-toggle="depart"><select data-type="edit" class="deptname-edit form-control disabled" disabled data-live-search="true" >'
                                    + '<option  value="' + row.Depts[i].DeptId + '" selected = "selected">' + row.Depts[i].DeptName + '</option>'
                                    + '</select>' + spanHtml + '</div>';
                            }
                            return deptNameHtml;
                        }
                    }, {
                        field: 'DeptId',
                        title: '部门Id',
                        formatter: function (value, row, index) {
                            var deptIdHtml = "";
                            for (var i = 0; i < row.Depts.length; i++) {
                                deptIdHtml = deptIdHtml + '<div class="form-group" data-index="' + i + '"><input style="width:-webkit-fill-available" disabled="" data-type="edit" readonly="true" class="disabled deptid-edit form-control" value="' + row.Depts[i].DeptId + '"/></div>';
                            }
                            return deptIdHtml;
                        }
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };

            //获取部门列表。
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetAllDeptList",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    dept = JSON.parse($(data).find("data").text());
                    bindDeptSearch();
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
                $("#search_group_name").val('');
                $("#search_department_ids").val('');
                var selectDeptText = $("#select_dept option:first").text();
                $("#search_department").next().find(".filter-option").html(selectDeptText);
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#DeptGroup_Origin", initUrl);
            });

            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {


                var type = "SmBasicDataPersonalDeptGroupManage";
                var searchDepartment = $('#search_department').val();
                var dept_ids = $('#search_department_ids').val();
                var deptGroupName = $("#search_group_name").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&searchDepartment=" + searchDepartment + "&dept_ids=" + dept_ids + "&deptGroupName=" + deptGroupName;
                window.open(url);
            });
            var dept;
            $('#DeptGroup_Origin').csTable({
                fields: [{
                    type: 'text',
                    name: 'add_group_name',
                    value: ''
                }, {
                    type: 'select',
                    template: '#add_group_id'
                }, {
                    type: 'select',
                    template: '#add_dept'
                }, {
                    type: 'select',
                    template: '#add_dept_id'
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $( '[data-row^="table"]').on('click', function (e) {
                if ($("input[name='add_group_name']").length === 0) {
                    var html = '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="cancel" class="btn btn-default btn-sm">删除</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>'
                    $('.isEdit').find('td:eq(0)').html(html);
                    $('.isEdit').find('[data-toggle="depart"]').addClass('select-disabled');
                    $('tbody tr td .btn').attr('disabled', true)
                    $('.isEdit').find('[data-type]').each(function () {
                        $(this).attr('disabled', true).addClass('disabled');
                        $(this).closest('[data-toggle="depart"]').addClass('select-disabled');
                        $(this).closest('[data-toggle="depart"]').find('.iconfont').css("display", "none");
                    });
                    $(this).attr('disabled', true).addClass('disabled');
                    $(this).closest('[data-toggle="depart"]').addClass('select-disabled')
                    $('.table').csTable('add');
                    //绑定非空验证事件。
                    bindCreateIsNullValidate();
                    bindCreateDept();
                    setTimeout(function () {
                        $('[name="add_dept_name"]').selectpicker('refresh');
                        //}
                        $('.bootstrap-select').removeClass('disabled').find('.dropdown-toggle').removeClass('disabled')
                    }, 500);
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

            function bindCreateDept() {
                var deptGroup = $("[name='add_dept_name']");
                var $deptId = $("[name='add_depts_id']");
                var html = "";
                deptGroup.empty();
                for (var i = 1; i < dept.length; i++) {
                    html += "<option value='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                }
                deptGroup.append(html);
                var id = dept[1].DeptId;
                $deptId.val(id);
                $deptId.attr("readonly", "true");
                deptGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $deptId.val(selectVal);
                });
            }

            //编辑行
            $('.table').delegate('[data-row^="edit"]', 'row.edit', function (e) {
                $(this).trigger('row.cancel')
                $(e.target).closest('tbody').find('.iconfont').hide()
                $(e.target).closest('tr').find('.iconfont').show()
                var html = '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="erase" class="btn btn-default btn-sm">删除</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>'
                $(e.target).closest('tr').siblings('tr').find('td:eq(0)').html(html)
                $(e.target).closest('tr').addClass('isEdit').siblings().removeClass('isEdit')
                $(e.target).closest('tr').find('[data-toggle="depart"]').removeClass('select-disabled');
                $(e.target).closest('tr').siblings('tr').find('[data-type]').each(function () {
                    $(this).attr('disabled', true).addClass('disabled');
                    $(this).closest('[data-toggle="depart"]').addClass('select-disabled')
                });
                bindEditIsNullValidate(e);
                bindEditDept(e);
                firstLoad = false
                setTimeout(function () {
                    $('.deptname-edit').selectpicker('refresh');
                    //}
                    $('.bootstrap-select').removeClass('disabled').find('.dropdown-toggle').removeClass('disabled')
                }, 500);
            });

            //删除行。
            $('.table').delegate('[data-row^="erase"]', 'click', function (e) {
                $('tbody tr td .btn').removeAttr('disabled')
                //此判断用来区分删除和取消按钮，新增的时候取消按钮也有data-row^="delete"
                if ($(e.target).data().type != "cancel") {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataDeptGroupEntityObj = $("#DeptGroup_Origin").bootstrapTable('getData')[currentIndex];
                    $.ajax({
                        url: "WebServices/SuperviseMissionWebServices.asmx/DelSMBasicDataDeptGroup",
                        type: "post",
                        dataType: "xml",
                        data: { "deptGroupId": smBasicDataDeptGroupEntityObj.Group.GroupId },
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        success: function (message) {
                            if ($(message).find("status").text() === "1") {
                                showTips($(message).find("message").text(), "alert-success", "alert-danger");
                                $(e.target).closest('tr').remove();
                                $("#DeptGroup_Origin").bootstrapTable('refresh');
                            } else {
                                showTips($(message).find("message").text(), "alert-danger", "alert-success");
                            }
                        },
                        error: function (message) {
                            $("#DeptGroup_Origin").bootstrapTable('refresh')
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    });
                } else {
                    $('tbody tr td .btn').removeAttr('disabled')
                    var $tr = $(e.target).closest('tr');
                    var currentIndex = $tr.data().index;
                    var event = $(e.target).closest('td');
                    if (!$(e.target).closest('tr').attr("id")) {
                        setTimeout(function () {
                            event.html(
                                '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>');
                        });
                        //编辑
                        reloadCurrentRow(e);
                    }

                    function reloadCurrentRow() {
                        var smBasicDataEntityObj = $("#DeptGroup_Origin").bootstrapTable('getData')[currentIndex];
                        $('#DeptGroup_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataEntityObj });
                    }
                }
            });

            $(document).on('click', '.icon-sv-add', function (e) {
                var event = $(e.target);
                var arr = '';
                bindDeptVal(event.closest('td').find("[name='add_dept_name']:last"));
                event.closest('td').find('[data-live-search="true"]').each(function (index) {
                    //arr.push('<div class="form-group">'+$(this).val()+'</div>')
                    arr += '<div class="form-group" data-index="' + index + '"><input disabled="" name="add_depts_id"  class="form-control deptid-edit" style="font-weight: normal;" value=' + $(this).val() + ' /></div>'
                })
                event.closest('td').next().html(arr);

            })

            function bindDeptVal($dept) {
                var html = "";
                $dept.empty();
                for (var i = 1; i < dept.length; i++) {
                    html += "<option value='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                }
                $dept.append(html);
                setTimeout(function () {
                    $('[name="add_dept_name"]').selectpicker('refresh');
                    $('.bootstrap-select').removeClass('disabled').find('.dropdown-toggle').removeClass('disabled')
                }, 500);
            }

            $('.table').delegate('[data-toggle="depart"]', 'change', function (e) {
                var event = $(e.target);
                var arr = '';
                event.closest('td').find('[data-live-search="true"]').each(function (index) {
                    arr += '<div class="form-group" data-index="' + index + '"><input name="add_depts_id" disabled=""  class="form-control deptid-edit" style="font-weight: normal;" value=' + $(this).val() + ' /></div>'
                })
                event.closest('td').next().html(arr)
            })
            $('.table').delegate('[data-row="unselect"]', 'row.unselect', function (e) {
                var event = $(e.target);
                var select = event.prev('.form-control').val();
                var key = event.closest('.form-group').index();
                event.closest('td').next().find('[data-index="' + key + '"]').remove();
                event.closest('td').next().find('.form-group').each(function (index) {
                    $(this).attr('data-index', index);
                });
            });

            function bindCreateIsNullValidate() {
                $("[name='add_group_name']").on('blur', function () {
                    changeClassByNull($(this));
                });
            }

            function bindEditDept(e) {
                $tds = $(e.target).closest('tr').children();
                var deptGroup = $tds.find("select.deptname-edit");
                var html = ""
                //if (firstLoad) {
                for (var i = 1; i < dept.length; i++) {
                    html += "<option value='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                }
                deptGroup.append(html);

            }

            function bindEditIsNullValidate(e) {
                $tds = $(e.target).closest('tr').children();
                //非空验证。
                $tds.find(".groupname-edit").on('blur', function () {
                    changeClassByNull($(this));
                });
            }

            function changeClassByNull($this) {
                if (isRequestNotNull($this.val())) {
                    $this.addClass("error");
                } else {
                    $this.removeClass("error");
                }
            }

            $('.table').delegate('[data-row="table"],[data-row="select"]', 'click', function (e) {
                //下拉搜索部门
                $('[name="add_dept_name"]').selectpicker('show');
            })


            //取消
            $('.table').delegate('[data-row^="cancel"]', 'row.cancel', function (e) {
                $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    //row.cancel(e);
                    reloadCurrentRow(e);

                    setTimeout(function () {
                        event.html(
                            '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="delete" class="btn btn-default btn-sm">删除</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>');
                    });
                    row.success(e, 'edit');
                } else {
                    //新增
                    $(e.target).closest('tr').remove();
                }

                function reloadCurrentRow(e) {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smDeptGroupEntityObj = $("#DeptGroup_Origin").bootstrapTable('getData')[currentIndex];
                    $('#DeptGroup_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smDeptGroupEntityObj });
                }
            });


            //保存
            $('.table').delegate('[data-row^="save"]', 'row.save', function (e) {
                var event = $(e.target).closest('td');
                var $tr = $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    if (isNotNullByEdit(e)) {
                        //是否编辑成功
                        if (!edit(e)) {
                            //保存失败（显示保存和取消按钮,当前行保持编辑状态）
                            setTimeout(editSaveBtn);
                        }
                    } else {
                        setTimeout(editSaveBtn);
                    }
                } else {
                    //新增
                    if (isNotNullByCreate()) {
                        if (!add()) {
                            setTimeout(createSaveBtn);
                        }
                    } else {
                        setTimeout(createSaveBtn);
                    }
                }

                function isNotNullByEdit(e) {
                    $tds = $(e.target).closest('tr').children();
                    var groupName = $tds.find(".groupname-edit").val();
                    $tds.find(".groupname-edit").blur();
                    if (groupName === "") {
                        return false;
                    } else {
                        return true;
                    }
                }

                function editSaveBtn() {
                    event.html(
                        '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="erase" data-row="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>');
                    $tr.find('.form-control').each(function () {
                        $(this).attr('disabled', false).removeClass('disabled');
                    });
                }

                function createSaveBtn() {
                    event.html(
                        '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-sm btn-default">保存</button><button data-row="erase" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button><div></div></div>');
                    $tr.find('.form-control').each(function () {
                        var name = $(this).attr('name');
                        if (name !== "add_group_id_name" && name !== "add_depts_id") {
                            $(this).attr('disabled', false).removeClass('disabled');
                        }
                    });
                }
            });

            function isNotNullByCreate() {
                var groupName = $('input[name="add_group_name"]').val();
                $('input[name="add_group_name"]').blur();
                if (groupName === "") {
                    return false;
                } else {
                    return true;
                }
            }

            function edit(e) {
                var groupName = $tds.find(".groupname-edit").val();
                var deptGroupId = $tds.find(".groupid-edit").val();
                var deptIds = "";
                var $deptIds = $tds.find(".deptid-edit");
                for (var i = 0; i < $deptIds.length; i++) {
                    if (i === 0) {
                        deptIds = $($deptIds[i]).val();
                    } else {
                        deptIds = deptIds + "," + $($deptIds[i]).val();
                    }
                }
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/EditSMBasicDataDeptGroup",
                    type: "post",
                    dataType: "xml",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: { "deptGroupId": deptGroupId, "groupName": groupName, "deptIds": deptIds },
                    success: function (message) {
                        if ($(message).find("status").text() === "1") {
                            showTips($(message).find("message").text(), "alert-success", "alert-danger");
                            $("#DeptGroup_Origin").bootstrapTable('refresh');
                            return true;
                        } else {
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        return false;
                    }
                });
            }

            //增加
            function add() {
                var name = $('input[name="add_group_name"]').val();
                var deptIds = "";
                var $deptIds = $('input[name="add_depts_id"]');
                for (var i = 0; i < $deptIds.length; i++) {
                    if (i === 0) {
                        deptIds = $($deptIds[i]).val();
                    } else {
                        deptIds = deptIds + "," + $($deptIds[i]).val();
                    }
                }
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSMBasicDataDeptGroup",
                    type: "post",
                    dataType: "xml",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data: { "groupName": name, "deptIds": deptIds },
                    success: function (message) {
                        if ($(message).find("status").text() === "1") {
                            showTips($(message).find("message").text(), "alert-success", "alert-danger");
                            $("#DeptGroup_Origin").bootstrapTable('refresh');
                            return true;
                        } else {
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                            return false;
                        }
                    },
                    error: function (message) {
                        showTips($(message).find("message").text(), "alert-danger", "alert-success");
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
