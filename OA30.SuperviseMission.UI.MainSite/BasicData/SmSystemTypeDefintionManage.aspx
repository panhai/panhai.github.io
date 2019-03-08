<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmSystemTypeDefintionManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmBasicDataSuperviseNumberManage" %>

<!DOCType html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>文件类型</title>
</head>
<body>
    <!--导航-->
    <div class="main">

        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#parameter">管理</a></li>
                <li class="active">文件类型</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#parameter'></a>
        </div>

        <div class="search-part search-part-2">
            <div class="search-control-2">

                <div class="row">



                    <div class="col col-lg-4  col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">类型号</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8">
                                <input type="text" id="type_id" name="type_id" class="form-control" placeholder="类型号" />
                            </div>
                        </div>
                    </div>


                    <div class="col col-lg-4  col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">类型名</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8">
                                <input type="text" id="type_name" name="type_name" class="form-control" placeholder="类型名" />
                            </div>
                        </div>
                    </div>

                </div>


                <div class="form-group" style="margin-left: 50px;">
                    <button class="btn btn-primary-s btn-group" id="btn_search">查询</button>
                    <button class="btn btn-default-s btn-group" id="btn_search_clear">清空</button>
                    <button class="btn btn-default-s btn-group export-excel" id="btn_export">导出</button>

                </div>
            </div>
        </div>

        <div id="tips-alert" class="alert alert-top" style="display: none;">&nbsp;</div>
        <div class="tar">
            <a href="javascript:;" data-row="table"><span class="iconfont icon-sv-add"></span>&nbsp;新增</a>
        </div>

        <div class="table-page">
            <table id="TypeDefinition_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>

    <script id="option" type="text/x-template">
	    <select class="form-control" name="add_dept_name">
		    
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
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSMSystemTypeDefintion";

            //初始化
            InitTable("#TypeDefinition_Origin", initUrl);

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
                    sortable: false,                    //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    //queryParams: InitTable.queryParams,  //传递参数（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber: 1,                      //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    pageList: [6, 12, 24, 26],          //可供选择的每页的行数（*）
                    search: false,                      //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                  //是否显示父子表
                    showExport: false,
                    exportDataType: "all",              //导出所有数据
                    showToggle: false,
                    showRefresh: false,
                    showColumns: false,
                    queryParams: function (params) {

                        var typename = $("#type_name").val();
                        var typeid = $("#type_id").val();

                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  

                            limit: params.limit,
                            offset: params.offset,
                            typeid: typeid,
                            typename: typename,

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
                        title: '编辑',
                        width: "200px",
                        formatter: function (value, row, index) {
                            return [
                                '<button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button>'
                            ].join('');
                        }
                    }, {
                        field: 'TypeId',
                        title: '类型号',
                        width: "700px",
                        formatter: function (value, row, index) {
                            return '<input disabled="" readonly="true" data-type="edit" class="disabled typeid-edit form-control" value="' + row.TypeId + '"/>';
                        }
                    },
                    {
                        field: 'TypeName',
                        title: '类型名',
                        width: "700px",
                        formatter: function (value, row, index) {
                            return '<input disabled="" data-type="edit" class="disabled form-control typename-edit" value="' + row.TypeName + '"/>';
                        }
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };


            //清空按钮绑定
            $("#btn_search_clear").on("click", function () {

                $("#type_name").val('');
                $("#type_id").val('');

            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#TypeDefinition_Origin", initUrl);
            });


            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {

                var type = "SmSystemTypeDefintionManage";

                var typename = $("#type_name").val();
                var typeid = $("#type_id").val();

                var url = "SuperviseMissionExport.aspx?type=" + type + "&typename=" + typename + "&typeid=" + typeid;
                window.open(url);
            });

            //取消(包括新增和编辑中的取消）
            $('.table').delegate('[data-row^="cancel"]', 'row.cancel', function (e) {
                $(e.target).closest('tr');
                var target = e.target;
                if (!$(e.target).closest('tr').attr("id")) {
                    //编辑
                    reloadCurrentRow(e);

                } else {
                    //新增
                    $(e.target).closest('tr').remove();
                }

                function reloadCurrentRow(e) {
                    var currentIndex = $(e.target).closest('tr').data().index
                    var smBasicDataSuperviseNumberEntityObj = $("#TypeDefinition_Origin").bootstrapTable('getData')[currentIndex];
                    $('#TypeDefinition_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smBasicDataSuperviseNumberEntityObj });
                }
            });


            $('#TypeDefinition_Origin').csTable({
                fields: [
                    {
                        type: 'text',
                        name: 'add_type_id',
                        value: ''
                    }, {
                        type: 'text',
                        name: 'add_type_name',
                        value: ''
                    }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

             //新建行
             $('[data-row^="table"]').on('click', function (e) {
                if ($("input[name='add_type_id']").length === 0) {
                    $('.table').csTable('add');
                    //绑定非空验证事件。
                    bindCreateIsNullValidate();
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });

             function bindCreateIsNullValidate() {
                 $("[name='add_type_id']").on('blur', function () {
                     changeClassByNull($(this));
                 });
                 $("[name='add_type_name']").on('blur', function () {
                     changeClassByNull($(this));
                 });
             }

            //编辑行
            $('.table').delegate('[data-row^="edit"]', 'row.edit', function (e) {


                bindEditIsNullValidate(e);
              

            })

            //非空验证。
            function bindEditIsNullValidate(e) {
                $tds = $(e.target).closest('tr').children();

                $tds.find(".typeid-edit").on('blur', function () {
                    changeClassByNull($(this));
                });

                $tds.find(".typename-edit").on('blur', function () {
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

            //保存
            $('.table').delegate('[data-row^="save"]', 'row.save', function (e) {
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
                var typename = $tds.find(".typename-edit").val();
                var typeid = $tds.find(".typed-edit").val();
                $tds.find(".typename-edit").blur();
                $tds.find(".typeid-edit").blur();
                if (typeid === "" || typename === "") {
                    return false;
                } else {
                    return true;
                }
            }

            function isNotNullByCreate() {
                var TypeId = $('input[name="add_type_id"]').val();
                var TypeName = $('input[name="add_type_name"]').val();
                $('input[name="add_type_id"]').blur();
                $('input[name="add_type_name"]').blur();
                if (TypeId === "" || TypeName === "") {
                    return false;
                } else {
                    return true;
                }
            }

            function edit(e) {
                $("#TypeDefinition_Origin").bootstrapTable('getData');
                $tds = $(e.target).closest('tr').children();
                var currentIndex = $(e.target).closest('tr').data().index
                //旧模型
                var oldSmSystemTypeDefinitionEntityObj = $("#TypeDefinition_Origin").bootstrapTable('getData')[currentIndex];
                oldSmSystemTypeDefinitionEntityObj.CreateTime = "";
                //新模型
                var typeId = $tds.find(".typeid-edit").val();
                var typename = $tds.find(".typename-edit").val();
                var smSystemTypeDefinitionEntityObj = new SmSystemTypeDefinitionEntityObj();
                smSystemTypeDefinitionEntityObj.TypeId = typeId;
                smSystemTypeDefinitionEntityObj.TypeName = typename;
                var smSystemTypeDefinitionEntity = '{"smSystemTypeDefinitionEntity":' + JSON.stringify(smSystemTypeDefinitionEntityObj) + ',"oldSmSystemTypeDefinitionEntity":' + JSON.stringify(oldSmSystemTypeDefinitionEntityObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/EditSMSystemTypeDefinitionNumber",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smSystemTypeDefinitionEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $('#TypeDefinition_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smSystemTypeDefinitionEntityObj });
                        } else {
                            $("#TypeDefinition_Origin").bootstrapTable('refresh')
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#TypeDefinition_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            }

            //增加
            function add() {

                var type_id = $('input[name="add_type_id"]').val();
                var type_name = $('input[name="add_type_name"]').val();

                var smSystemTypeDefinitionEntityObj = new Object();
                smSystemTypeDefinitionEntityObj.TypeId = type_id;
                smSystemTypeDefinitionEntityObj.TypeName = type_name;
                var smSystemTypeDefinitionEntity = '{"smSystemTypeDefinitionEntity":' + JSON.stringify(smSystemTypeDefinitionEntityObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSMSystemTypeDefintion",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smSystemTypeDefinitionEntity,
                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");
                            $("#TypeDefinition_Origin").bootstrapTable('refresh')
                        } else {
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#TypeDefinition_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            };

            function SmSystemTypeDefinitionEntityObj() {

                var smSystemTypeDefinitionEntityObj = new Object();
                smSystemTypeDefinitionEntityObj.TypeId = "";
                smSystemTypeDefinitionEntityObj.TypeName = "";
                return smSystemTypeDefinitionEntityObj;
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
