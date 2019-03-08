<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmSystemWorkFlowStaticManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.SmSystemWorkFlowStaticManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>固定流程定义</title>
</head>
<body>
    <div class="main">
        <div class="top-nav">
            <ul class="breadcrumb">
                <li><a href="Index.aspx#parameter">管理</a></li>
                <li class="active">固定流程定义</li>
            </ul>
            <a class="iconfont icon-sv-back" href='Index.aspx#parameter'></a>
        </div>
        <div class="search-part search-part-2">
            <div class="search-control-2">
                <div class="row">
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">工作流程ID</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8">
                                <input type="text" class="form-control" id="search_workflow_id" placeholder="工作流程ID" />
                            </div>
                        </div>
                    </div>
                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">部门</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 select_control">
                                <input type="hidden" id="search_department_ids" value="" />
                                <input type="hidden" id="search_department" value="" />
                                <select id="select_dept" data-live-search="true" class="selectpicker"></select>
                            </div>
                        </div>
                    </div>
   

                    <div class="col col-lg-4 col-sm-4 col-md-4 col-xs-4">
                        <div class="form-group clearfix">
                            <label for="" class="col-lg-4 col-sm-4 col-md-4 col-xs-4 control-label">步骤类型</label>
                            <div class="col-lg-8 col-sm-8 col-md-8 col-xs-8 dropdown">
                                <select class="form-control" id="search_smType" aria-labelledby="dLabel">
                                    <option selected="selected" value="">全部</option>
                                </select>
                            </div>
                        </div>
                     </div>

                 


                </div>
                <div class="form-group" style="margin-left:20px;">
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
            <table id="SmSystemWorkFlowStatic_Origin" data-show-columns="false" class="table table-bordered"></table>
        </div>
    </div>
    
    <script id="add_workflow" type="text/x-template">
    <div class="dropdown">
        <input type="text" class="form-control" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"  id="add_workflow_id" />
    </div>
    </script>

    <script id="add_activity_flag" type="text/x-template">
	    <select class="form-control" name="add_activity_flag_select">
		    <option  value="1" selected = "selected">是</option>
            <option  value="0">否</option>
	    </select>
    </script>

    <script id="add_sm_type" type="text/x-template">
	    <select class="form-control" name="add_sm_type_name">
		    
	    </select>
    </script>


    <script id="add_sub_type" type="text/x-template">
	    <select class="form-control" name="add_sub_type_name">
		    
	    </select>
    </script>



    <script id="add_dept" type="text/x-template">
	    <select class="form-control" name="add_dept_name" data-live-search="true">
		    
	    </select>
    </script>
      
    
    <script id="add_workflow_name" type="text/x-template">
       <div class="dropdown">
	        <input type="text" class="form-control"  id="add_workflow_name" name="add_workflow_name" placeholder="请输入工作流程名称" />
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
            //初始化url
            var initUrl = "WebServices/SuperviseMissionWebServices.asmx/GetSuperviseMissionSystemWorkFlowStaticEntityList";

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
                        var searchDeptName = $('#search_department').val() ? $('#search_department').val() : '';
                        var searchDeptIds = $('#search_department_ids').val();
                        var smType = $("#search_smType option:selected").val();
                        var workflowId = $('#search_workflow_id').val();
                        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的  
                            limit: params.limit,
                            offset: params.offset,
                            searchDeptIds: searchDeptIds,
                            searchDeptName: searchDeptName,
                            smType: smType,
                            workflowId: workflowId,
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
                        width:100,
                        title: '操作',
                        formatter: function (value, row, index) {
                            return [
                                '<div class="btn-group btn-group-sm" role="group"><button type="button" data-row="inversion" class="btn btn-default btn-sm">置否</button><button type="button" data-row="edit" class="btn-show-edit btn btn-default  btn-sm">编辑</button></div>'
                            ].join('');
                        }
                    }, {
                        field: 'WorkFlowId',
                        title: '工作流程ID',
                        formatter: function (value, row, index) {
                            return '<input disabled="" readonly="true" style="width:-webkit-fill-available" data-type="edit" class="disabled stepid-edit form-control" value="' + row.WorkFlowId + '"/>';
                        }
                    }, {
                        field: 'WorkFlowName',
                        title: '工作流程名称',
                        formatter: function (value, row, index) {
                            return '<input disabled="" style="width:-webkit-fill-available" data-type="edit" class="disabled workflowname-edit form-control" value="' + row.WorkFlowName + '"/>';
                        }
                    }, {
                        field: 'DeptId',
                        title: '部门号',
                        width: 150,
                        formatter: function (value, row, index) {
                            return '<input disabled="" readonly="true" data-type="edit" class="disabled DeptId-edit form-control" value="' + row.DeptId + '"/>';
                        }
                    }, {
                        field: 'DeptName',
                        title: '部门名称',
                        formatter: function (value, row, index) {
                            return '<select data-type="edit" class="form-control DeptName-edit disabled" disabled>'
                                + '<option  value="' + row.DeptId + '" selected = "selected">' + row.DeptName + '</option>'
                                + '</select>';
                        }
                    }, {
                        field: 'SmType',
                        title: '步骤类型',
                        formatter: function (value, row, index) {

                            var smTypeTextForSmType = "";
                            if (row.SmType === 'BJ') {
                                smTypeTextForSmType = "办结"
                            } else if (row.SmType === 'LD') {
                                smTypeTextForSmType = "领导行政例会督查任务"
                            } else if (row.SmType === 'ND') {
                                smTypeTextForSmType = "年度重点任务"
                            } else if (row.SmType === 'QT') {
                                smTypeTextForSmType = "其他重要公务任务"
                            } else if (row.SmType === 'TZ') {
                                smTypeTextForSmType = "调整"
                            } else if (row.SmType === 'YQ') {
                                smTypeTextForSmType = "延期"
                            } else if (row.SmType === 'ZZ') {
                                smTypeTextForSmType = "中止"
                            } else if (row.SmType === 'ZJ') {
                                smTypeTextForSmType = "总经理办公会督查任务"
                            }

                            return '<select data-type="edit" class="form-control sm-type-edit disabled" disabled>'
                                + '<option  value="' + row.SmType + '" selected = "selected">' + smTypeTextForSmType + '</option>'
                                + '</select>';
                        }
                    }, {
                        field: 'SubType',
                        title: '步骤子类型',
                        formatter: function (value, row, index) {
                            var smTypeText = "";
                            if (row.SubType === 'BJ') {
                                smTypeText = "办结"
                            } else if (row.SubType === 'LD') {
                                smTypeText = "领导行政例会督查任务"
                            } else if (row.SubType === 'ND') {
                                smTypeText = "年度重点任务"
                            } else if (row.SubType === 'QT') {
                                smTypeText = "其他重要公务任务"
                            } else if (row.SubType === 'TZ') {
                                smTypeText = "调整"
                            } else if (row.SubType === 'YQ') {
                                smTypeText = "延期"
                            } else if (row.SubType === 'ZZ') {
                                smTypeText = "中止"
                            }
                            else if (row.SubType === 'ZJ') {
                                smTypeText= "总经理办公会督查任务"
                            }
                            return '<select data-type="edit" class="form-control sub-type-edit disabled" disabled>'
                              + '<option  value="' + row.SubType + '" selected = "selected">' + smTypeText + '</option>'
                              + '</select>';
                        }

                    }, {
                        field: 'ActivityFlag',
                        title: '是否可用',
                        formatter: function (value, row, index) {
                            if (value === 1) {
                                return '<select data-type="edit" class="form-control activityflag-edit disabled" disabled>'
                                    + '<option value="1" selected = "selected">是</option>'
                                    + '</select>';
                            } else {
                                return '<select data-type="edit" class="form-control activityflag-edit disabled" disabled>'
                                    + '<option value="0" selected = "selected">否</option>'
                                    + '</select>';
                            }
                        }
                    }]
                }
                $(tableId).bootstrapTable(option);
                return InitTable;
            };

            //获取部门列表。
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
                $('#search_workflow_id').val('');
                $("#search_smType").find("option").eq(0).prop("selected", true);
                $("#search_type").find("option").eq(0).prop("selected", true);
                var selectDeptText = $("#select_dept option:first").text();
                $("#search_department").next().find(".filter-option").html(selectDeptText);
            });

            //查询按钮绑定
            $("#btn_search").click(function () {
                InitTable("#SmSystemWorkFlowStatic_Origin", initUrl);
            });



            //在查询条件中获取smtype。
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

            //在查询条件中获取smtype。
            var subtype;
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSmType",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    subtype = JSON.parse($(data).find("data").text());
                  
                },
                error: function (message) {
                    alert("获取所属类型列表失败！");
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


            //绑定导出     跳转到导出数据页面
            $("#btn_export").click(
            function goToExportPage() {

                var type = "SmSystemWorkFlowStaticManage";

                var searchDeptName = $('#search_department').val() ? $('#search_department').val() : '';
                var searchDeptIds = $('#search_department_ids').val();
              //  var typeWorkFlow = $("#search_type option:selected").val();
                var workflowId = $('#search_workflow_id').val();
                var smType = $("#search_smType option:selected").val();


                var url = "SuperviseMissionExport.aspx?type=" + type + "&searchDeptName=" + searchDeptName
                    + "&searchDeptIds=" + searchDeptIds +"&workflowId=" + workflowId + "&smType=" + smType;
                window.open(url);
            });


            $('#SmSystemWorkFlowStatic_Origin').csTable({
                fields: [{
                    type: 'select',
                    template: '#add_workflow'
                }, {
                    type: 'select',
                    template: '#add_workflow_name',
         
                }, {
                    type: 'text',
                    name: 'add_dept_id',
                    value: '1'
                }, {
                    type: 'select',
                    template: '#add_dept'
                }, {
                    type: 'select',
                    template: '#add_sm_type'
                }, {
                    type: 'select',
                    template: '#add_sub_type'
                }, {
                    type: 'select',
                    template: '#add_activity_flag'
                }],
                addBtn: ['save', 'cancel'],
                editBtn: 'delete',
                saveBtn: ['edit', 'delete']
            });

            //新建行
            $('[data-row^="table"]').on('click',function (e) {
                if ($("input[name='add_workflow_name']").length === 0) {
                    $('.table').csTable('add');
                    //绑定非空验证事件。
                    bindCreateIsNullValidate();
                    bindCreateDept();
                    bindPingYin();
                    setCreateSmtypeValue();
                    setCreateSubtypeValue();
                    $('[name="add_dept_name"]').selectpicker('show');
                    $('[name="add_dept_name"]').selectpicker({
                        dropupAuto: false
                    });
                } else {
                    showTips("已存在新增行", "alert-danger", "alert-success");
                }
            });


            function setCreateSmtypeValue() {
                var stepGroup = $("[name='add_sm_type_name']");
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < smtype.length; i++) {
                    html += "<option value='" + smtype[i].TypeId + "'>" + smtype[i].TypeName + "</option>";
                }
                stepGroup.append(html);
            }


            function setCreateSubtypeValue() {
                var stepGroup = $("[name='add_sub_type_name']");
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < subtype.length; i++) {
                    html += "<option value='" + subtype[i].TypeId + "'>" + subtype[i].TypeName + "</option>";
                }
                html += "<option value='0'>无</option>";
                stepGroup.append(html);
            }


            //置否。
            $('.table').delegate('[data-row^="inversion"]','click', function (e) {
                var currentIndex = $(e.target).closest('tr').data().index
                var smWorkFlowStaticEntityObj = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/InversionSmWorkFlowStatic",
                    type: "post",
                    dataType: "xml",
                    data: { "deptId": smWorkFlowStaticEntityObj.DeptId, "smType": smWorkFlowStaticEntityObj.SmType, "workFlowId": smWorkFlowStaticEntityObj.WorkFlowId },
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    success: function (message) {
                        if ($(message).find("status").text() === "1") {
                            showTips($(message).find("message").text(), "alert-success", "alert-danger");
                            $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh');
                        } else {
                            showTips($(message).find("message").text(), "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                        showTips($(message).find("message").text(), "alert-danger", "alert-success");
                    }
                });
            });

            function bindCreateIsNullValidate() {
                $("#add_workflow_id").on('blur', function () {
                    changeClassByNull($(this));
                });
                $("[name='add_workflow_name']").on('blur', function () {
                    changeClassByNull($(this));
                });
            }

            function bindCreateDept() {
                var deptGroup = $("[name='add_dept_name']");
                var $deptId = $("[name='add_dept_id']");
                deptGroup.empty();
                var html = "";
                for (var i = 1; i < dept.length; i++) {
                    html += "<option value='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                }
                deptGroup.append(html);
                var id = dept[1].DeptId;
                $deptId.val(id);
                $deptId.on('blur',
                    function () {
                        var value = $(this).val();
                        if (isInDeptArray(value)) {
                            deptGroup.selectpicker('val', ($(this).val()));
                        } else {
                            alert("输入的部门编号有误，请重新输入！");
                            var id = dept[1].DeptId;
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
                for (var i = 1; i < dept.length; i++) {
                    if (dept[i].DeptId === value) {
                        return true;
                    }
                }

                return false;
            }

            function bindPingYin() {
                // 汉字拼音首字母列表 本列表包含了20902个汉字,用于配合 ToChineseSpell  
                //函数使用,本表收录的字符的Unicode编码范围为19968至40869, XDesigner 整理  
                var strChineseFirstPY = "YDYQSXMWZSSXJBYMGCCZQPSSQBYCDSCDQLDYLYBSSJGYZZJJFKCCLZDHWDWZJLJPFYYNWJJTMYHZWZHFLZPPQHGSCYYYNJQYXXGJHHSDSJNKKTMOMLCRXYPSNQSECCQZGGLLYJLMYZZSECYKYYHQWJSSGGYXYZYJWWKDJHYCHMYXJTLXJYQBYXZLDWRDJRWYSRLDZJPCBZJJBRCFTLECZSTZFXXZHTRQHYBDLYCZSSYMMRFMYQZPWWJJYFCRWFDFZQPYDDWYXKYJAWJFFXYPSFTZYHHYZYSWCJYXSCLCXXWZZXNBGNNXBXLZSZSBSGPYSYZDHMDZBQBZCWDZZYYTZHBTSYYBZGNTNXQYWQSKBPHHLXGYBFMJEBJHHGQTJCYSXSTKZHLYCKGLYSMZXYALMELDCCXGZYRJXSDLTYZCQKCNNJWHJTZZCQLJSTSTBNXBTYXCEQXGKWJYFLZQLYHYXSPSFXLMPBYSXXXYDJCZYLLLSJXFHJXPJBTFFYABYXBHZZBJYZLWLCZGGBTSSMDTJZXPTHYQTGLJSCQFZKJZJQNLZWLSLHDZBWJNCJZYZSQQYCQYRZCJJWYBRTWPYFTWEXCSKDZCTBZHYZZYYJXZCFFZZMJYXXSDZZOTTBZLQWFCKSZSXFYRLNYJMBDTHJXSQQCCSBXYYTSYFBXDZTGBCNSLCYZZPSAZYZZSCJCSHZQYDXLBPJLLMQXTYDZXSQJTZPXLCGLQTZWJBHCTSYJSFXYEJJTLBGXSXJMYJQQPFZASYJNTYDJXKJCDJSZCBARTDCLYJQMWNQNCLLLKBYBZZSYHQQLTWLCCXTXLLZNTYLNEWYZYXCZXXGRKRMTCNDNJTSYYSSDQDGHSDBJGHRWRQLYBGLXHLGTGXBQJDZPYJSJYJCTMRNYMGRZJCZGJMZMGXMPRYXKJNYMSGMZJYMKMFXMLDTGFBHCJHKYLPFMDXLQJJSMTQGZSJLQDLDGJYCALCMZCSDJLLNXDJFFFFJCZFMZFFPFKHKGDPSXKTACJDHHZDDCRRCFQYJKQCCWJDXHWJLYLLZGCFCQDSMLZPBJJPLSBCJGGDCKKDEZSQCCKJGCGKDJTJDLZYCXKLQSCGJCLTFPCQCZGWPJDQYZJJBYJHSJDZWGFSJGZKQCCZLLPSPKJGQJHZZLJPLGJGJJTHJJYJZCZMLZLYQBGJWMLJKXZDZNJQSYZMLJLLJKYWXMKJLHSKJGBMCLYYMKXJQLBMLLKMDXXKWYXYSLMLPSJQQJQXYXFJTJDXMXXLLCXQBSYJBGWYMBGGBCYXPJYGPEPFGDJGBHBNSQJYZJKJKHXQFGQZKFHYGKHDKLLSDJQXPQYKYBNQSXQNSZSWHBSXWHXWBZZXDMNSJBSBKBBZKLYLXGWXDRWYQZMYWSJQLCJXXJXKJEQXSCYETLZHLYYYSDZPAQYZCMTLSHTZCFYZYXYLJSDCJQAGYSLCQLYYYSHMRQQKLDXZSCSSSYDYCJYSFSJBFRSSZQSBXXPXJYSDRCKGJLGDKZJZBDKTCSYQPYHSTCLDJDHMXMCGXYZHJDDTMHLTXZXYLYMOHYJCLTYFBQQXPFBDFHHTKSQHZYYWCNXXCRWHOWGYJLEGWDQCWGFJYCSNTMYTOLBYGWQWESJPWNMLRYDZSZTXYQPZGCWXHNGPYXSHMYQJXZTDPPBFYHZHTJYFDZWKGKZBLDNTSXHQEEGZZYLZMMZYJZGXZXKHKSTXNXXWYLYAPSTHXDWHZYMPXAGKYDXBHNHXKDPJNMYHYLPMGOCSLNZHKXXLPZZLBMLSFBHHGYGYYGGBHSCYAQTYWLXTZQCEZYDQDQMMHTKLLSZHLSJZWFYHQSWSCWLQAZYNYTLSXTHAZNKZZSZZLAXXZWWCTGQQTDDYZTCCHYQZFLXPSLZYGPZSZNGLNDQTBDLXGTCTAJDKYWNSYZLJHHZZCWNYYZYWMHYCHHYXHJKZWSXHZYXLYSKQYSPSLYZWMYPPKBYGLKZHTYXAXQSYSHXASMCHKDSCRSWJPWXSGZJLWWSCHSJHSQNHCSEGNDAQTBAALZZMSSTDQJCJKTSCJAXPLGGXHHGXXZCXPDMMHLDGTYBYSJMXHMRCPXXJZCKZXSHMLQXXTTHXWZFKHCCZDYTCJYXQHLXDHYPJQXYLSYYDZOZJNYXQEZYSQYAYXWYPDGXDDXSPPYZNDLTWRHXYDXZZJHTCXMCZLHPYYYYMHZLLHNXMYLLLMDCPPXHMXDKYCYRDLTXJCHHZZXZLCCLYLNZSHZJZZLNNRLWHYQSNJHXYNTTTKYJPYCHHYEGKCTTWLGQRLGGTGTYGYHPYHYLQYQGCWYQKPYYYTTTTLHYHLLTYTTSPLKYZXGZWGPYDSSZZDQXSKCQNMJJZZBXYQMJRTFFBTKHZKBXLJJKDXJTLBWFZPPTKQTZTGPDGNTPJYFALQMKGXBDCLZFHZCLLLLADPMXDJHLCCLGYHDZFGYDDGCYYFGYDXKSSEBDHYKDKDKHNAXXYBPBYYHXZQGAFFQYJXDMLJCSQZLLPCHBSXGJYNDYBYQSPZWJLZKSDDTACTBXZDYZYPJZQSJNKKTKNJDJGYYPGTLFYQKASDNTCYHBLWDZHBBYDWJRYGKZYHEYYFJMSDTYFZJJHGCXPLXHLDWXXJKYTCYKSSSMTWCTTQZLPBSZDZWZXGZAGYKTYWXLHLSPBCLLOQMMZSSLCMBJCSZZKYDCZJGQQDSMCYTZQQLWZQZXSSFPTTFQMDDZDSHDTDWFHTDYZJYQJQKYPBDJYYXTLJHDRQXXXHAYDHRJLKLYTWHLLRLLRCXYLBWSRSZZSYMKZZHHKYHXKSMDSYDYCJPBZBSQLFCXXXNXKXWYWSDZYQOGGQMMYHCDZTTFJYYBGSTTTYBYKJDHKYXBELHTYPJQNFXFDYKZHQKZBYJTZBXHFDXKDASWTAWAJLDYJSFHBLDNNTNQJTJNCHXFJSRFWHZFMDRYJYJWZPDJKZYJYMPCYZNYNXFBYTFYFWYGDBNZZZDNYTXZEMMQBSQEHXFZMBMFLZZSRXYMJGSXWZJSPRYDJSJGXHJJGLJJYNZZJXHGXKYMLPYYYCXYTWQZSWHWLYRJLPXSLSXMFSWWKLCTNXNYNPSJSZHDZEPTXMYYWXYYSYWLXJQZQXZDCLEEELMCPJPCLWBXSQHFWWTFFJTNQJHJQDXHWLBYZNFJLALKYYJLDXHHYCSTYYWNRJYXYWTRMDRQHWQCMFJDYZMHMYYXJWMYZQZXTLMRSPWWCHAQBXYGZYPXYYRRCLMPYMGKSJSZYSRMYJSNXTPLNBAPPYPYLXYYZKYNLDZYJZCZNNLMZHHARQMPGWQTZMXXMLLHGDZXYHXKYXYCJMFFYYHJFSBSSQLXXNDYCANNMTCJCYPRRNYTYQNYYMBMSXNDLYLYSLJRLXYSXQMLLYZLZJJJKYZZCSFBZXXMSTBJGNXYZHLXNMCWSCYZYFZLXBRNNNYLBNRTGZQYSATSWRYHYJZMZDHZGZDWYBSSCSKXSYHYTXXGCQGXZZSHYXJSCRHMKKBXCZJYJYMKQHZJFNBHMQHYSNJNZYBKNQMCLGQHWLZNZSWXKHLJHYYBQLBFCDSXDLDSPFZPSKJYZWZXZDDXJSMMEGJSCSSMGCLXXKYYYLNYPWWWGYDKZJGGGZGGSYCKNJWNJPCXBJJTQTJWDSSPJXZXNZXUMELPXFSXTLLXCLJXJJLJZXCTPSWXLYDHLYQRWHSYCSQYYBYAYWJJJQFWQCQQCJQGXALDBZZYJGKGXPLTZYFXJLTPADKYQHPMATLCPDCKBMTXYBHKLENXDLEEGQDYMSAWHZMLJTWYGXLYQZLJEEYYBQQFFNLYXRDSCTGJGXYYNKLLYQKCCTLHJLQMKKZGCYYGLLLJDZGYDHZWXPYSJBZKDZGYZZHYWYFQYTYZSZYEZZLYMHJJHTSMQWYZLKYYWZCSRKQYTLTDXWCTYJKLWSQZWBDCQYNCJSRSZJLKCDCDTLZZZACQQZZDDXYPLXZBQJYLZLLLQDDZQJYJYJZYXNYYYNYJXKXDAZWYRDLJYYYRJLXLLDYXJCYWYWNQCCLDDNYYYNYCKCZHXXCCLGZQJGKWPPCQQJYSBZZXYJSQPXJPZBSBDSFNSFPZXHDWZTDWPPTFLZZBZDMYYPQJRSDZSQZSQXBDGCPZSWDWCSQZGMDHZXMWWFYBPDGPHTMJTHZSMMBGZMBZJCFZWFZBBZMQCFMBDMCJXLGPNJBBXGYHYYJGPTZGZMQBQTCGYXJXLWZKYDPDYMGCFTPFXYZTZXDZXTGKMTYBBCLBJASKYTSSQYYMSZXFJEWLXLLSZBQJJJAKLYLXLYCCTSXMCWFKKKBSXLLLLJYXTYLTJYYTDPJHNHNNKBYQNFQYYZBYYESSESSGDYHFHWTCJBSDZZTFDMXHCNJZYMQWSRYJDZJQPDQBBSTJGGFBKJBXTGQHNGWJXJGDLLTHZHHYYYYYYSXWTYYYCCBDBPYPZYCCZYJPZYWCBDLFWZCWJDXXHYHLHWZZXJTCZLCDPXUJCZZZLYXJJTXPHFXWPYWXZPTDZZBDZCYHJHMLXBQXSBYLRDTGJRRCTTTHYTCZWMXFYTWWZCWJWXJYWCSKYBZSCCTZQNHXNWXXKHKFHTSWOCCJYBCMPZZYKBNNZPBZHHZDLSYDDYTYFJPXYNGFXBYQXCBHXCPSXTYZDMKYSNXSXLHKMZXLYHDHKWHXXSSKQYHHCJYXGLHZXCSNHEKDTGZXQYPKDHEXTYKCNYMYYYPKQYYYKXZLTHJQTBYQHXBMYHSQCKWWYLLHCYYLNNEQXQWMCFBDCCMLJGGXDQKTLXKGNQCDGZJWYJJLYHHQTTTNWCHMXCXWHWSZJYDJCCDBQCDGDNYXZTHCQRXCBHZTQCBXWGQWYYBXHMBYMYQTYEXMQKYAQYRGYZSLFYKKQHYSSQYSHJGJCNXKZYCXSBXYXHYYLSTYCXQTHYSMGSCPMMGCCCCCMTZTASMGQZJHKLOSQYLSWTMXSYQKDZLJQQYPLSYCZTCQQPBBQJZCLPKHQZYYXXDTDDTSJCXFFLLCHQXMJLWCJCXTSPYCXNDTJSHJWXDQQJSKXYAMYLSJHMLALYKXCYYDMNMDQMXMCZNNCYBZKKYFLMCHCMLHXRCJJHSYLNMTJZGZGYWJXSRXCWJGJQHQZDQJDCJJZKJKGDZQGJJYJYLXZXXCDQHHHEYTMHLFSBDJSYYSHFYSTCZQLPBDRFRZTZYKYWHSZYQKWDQZRKMSYNBCRXQBJYFAZPZZEDZCJYWBCJWHYJBQSZYWRYSZPTDKZPFPBNZTKLQYHBBZPNPPTYZZYBQNYDCPJMMCYCQMCYFZZDCMNLFPBPLNGQJTBTTNJZPZBBZNJKLJQYLNBZQHKSJZNGGQSZZKYXSHPZSNBCGZKDDZQANZHJKDRTLZLSWJLJZLYWTJNDJZJHXYAYNCBGTZCSSQMNJPJYTYSWXZFKWJQTKHTZPLBHSNJZSYZBWZZZZLSYLSBJHDWWQPSLMMFBJDWAQYZTCJTBNNWZXQXCDSLQGDSDPDZHJTQQPSWLYYJZLGYXYZLCTCBJTKTYCZJTQKBSJLGMGZDMCSGPYNJZYQYYKNXRPWSZXMTNCSZZYXYBYHYZAXYWQCJTLLCKJJTJHGDXDXYQYZZBYWDLWQCGLZGJGQRQZCZSSBCRPCSKYDZNXJSQGXSSJMYDNSTZTPBDLTKZWXQWQTZEXNQCZGWEZKSSBYBRTSSSLCCGBPSZQSZLCCGLLLZXHZQTHCZMQGYZQZNMCOCSZJMMZSQPJYGQLJYJPPLDXRGZYXCCSXHSHGTZNLZWZKJCXTCFCJXLBMQBCZZWPQDNHXLJCTHYZLGYLNLSZZPCXDSCQQHJQKSXZPBAJYEMSMJTZDXLCJYRYYNWJBNGZZTMJXLTBSLYRZPYLSSCNXPHLLHYLLQQZQLXYMRSYCXZLMMCZLTZSDWTJJLLNZGGQXPFSKYGYGHBFZPDKMWGHCXMSGDXJMCJZDYCABXJDLNBCDQYGSKYDQTXDJJYXMSZQAZDZFSLQXYJSJZYLBTXXWXQQZBJZUFBBLYLWDSLJHXJYZJWTDJCZFQZQZZDZSXZZQLZCDZFJHYSPYMPQZMLPPLFFXJJNZZYLSJEYQZFPFZKSYWJJJHRDJZZXTXXGLGHYDXCSKYSWMMZCWYBAZBJKSHFHJCXMHFQHYXXYZFTSJYZFXYXPZLCHMZMBXHZZSXYFYMNCWDABAZLXKTCSHHXKXJJZJSTHYGXSXYYHHHJWXKZXSSBZZWHHHCWTZZZPJXSNXQQJGZYZYWLLCWXZFXXYXYHXMKYYSWSQMNLNAYCYSPMJKHWCQHYLAJJMZXHMMCNZHBHXCLXTJPLTXYJHDYYLTTXFSZHYXXSJBJYAYRSMXYPLCKDUYHLXRLNLLSTYZYYQYGYHHSCCSMZCTZQXKYQFPYYRPFFLKQUNTSZLLZMWWTCQQYZWTLLMLMPWMBZSSTZRBPDDTLQJJBXZCSRZQQYGWCSXFWZLXCCRSZDZMCYGGDZQSGTJSWLJMYMMZYHFBJDGYXCCPSHXNZCSBSJYJGJMPPWAFFYFNXHYZXZYLREMZGZCYZSSZDLLJCSQFNXZKPTXZGXJJGFMYYYSNBTYLBNLHPFZDCYFBMGQRRSSSZXYSGTZRNYDZZCDGPJAFJFZKNZBLCZSZPSGCYCJSZLMLRSZBZZLDLSLLYSXSQZQLYXZLSKKBRXBRBZCYCXZZZEEYFGKLZLYYHGZSGZLFJHGTGWKRAAJYZKZQTSSHJJXDCYZUYJLZYRZDQQHGJZXSSZBYKJPBFRTJXLLFQWJHYLQTYMBLPZDXTZYGBDHZZRBGXHWNJTJXLKSCFSMWLSDQYSJTXKZSCFWJLBXFTZLLJZLLQBLSQMQQCGCZFPBPHZCZJLPYYGGDTGWDCFCZQYYYQYSSCLXZSKLZZZGFFCQNWGLHQYZJJCZLQZZYJPJZZBPDCCMHJGXDQDGDLZQMFGPSYTSDYFWWDJZJYSXYYCZCYHZWPBYKXRYLYBHKJKSFXTZJMMCKHLLTNYYMSYXYZPYJQYCSYCWMTJJKQYRHLLQXPSGTLYYCLJSCPXJYZFNMLRGJJTYZBXYZMSJYJHHFZQMSYXRSZCWTLRTQZSSTKXGQKGSPTGCZNJSJCQCXHMXGGZTQYDJKZDLBZSXJLHYQGGGTHQSZPYHJHHGYYGKGGCWJZZYLCZLXQSFTGZSLLLMLJSKCTBLLZZSZMMNYTPZSXQHJCJYQXYZXZQZCPSHKZZYSXCDFGMWQRLLQXRFZTLYSTCTMJCXJJXHJNXTNRZTZFQYHQGLLGCXSZSJDJLJCYDSJTLNYXHSZXCGJZYQPYLFHDJSBPCCZHJJJQZJQDYBSSLLCMYTTMQTBHJQNNYGKYRQYQMZGCJKPDCGMYZHQLLSLLCLMHOLZGDYYFZSLJCQZLYLZQJESHNYLLJXGJXLYSYYYXNBZLJSSZCQQCJYLLZLTJYLLZLLBNYLGQCHXYYXOXCXQKYJXXXYKLXSXXYQXCYKQXQCSGYXXYQXYGYTQOHXHXPYXXXULCYEYCHZZCBWQBBWJQZSCSZSSLZYLKDESJZWMYMCYTSDSXXSCJPQQSQYLYYZYCMDJDZYWCBTJSYDJKCYDDJLBDJJSODZYSYXQQYXDHHGQQYQHDYXWGMMMAJDYBBBPPBCMUUPLJZSMTXERXJMHQNUTPJDCBSSMSSSTKJTSSMMTRCPLZSZMLQDSDMJMQPNQDXCFYNBFSDQXYXHYAYKQYDDLQYYYSSZBYDSLNTFQTZQPZMCHDHCZCWFDXTMYQSPHQYYXSRGJCWTJTZZQMGWJJTJHTQJBBHWZPXXHYQFXXQYWYYHYSCDYDHHQMNMTMWCPBSZPPZZGLMZFOLLCFWHMMSJZTTDHZZYFFYTZZGZYSKYJXQYJZQBHMBZZLYGHGFMSHPZFZSNCLPBQSNJXZSLXXFPMTYJYGBXLLDLXPZJYZJYHHZCYWHJYLSJEXFSZZYWXKZJLUYDTMLYMQJPWXYHXSKTQJEZRPXXZHHMHWQPWQLYJJQJJZSZCPHJLCHHNXJLQWZJHBMZYXBDHHYPZLHLHLGFWLCHYYTLHJXCJMSCPXSTKPNHQXSRTYXXTESYJCTLSSLSTDLLLWWYHDHRJZSFGXTSYCZYNYHTDHWJSLHTZDQDJZXXQHGYLTZPHCSQFCLNJTCLZPFSTPDYNYLGMJLLYCQHYSSHCHYLHQYQTMZYPBYWRFQYKQSYSLZDQJMPXYYSSRHZJNYWTQDFZBWWTWWRXCWHGYHXMKMYYYQMSMZHNGCEPMLQQMTCWCTMMPXJPJJHFXYYZSXZHTYBMSTSYJTTQQQYYLHYNPYQZLCYZHZWSMYLKFJXLWGXYPJYTYSYXYMZCKTTWLKSMZSYLMPWLZWXWQZSSAQSYXYRHSSNTSRAPXCPWCMGDXHXZDZYFJHGZTTSBJHGYZSZYSMYCLLLXBTYXHBBZJKSSDMALXHYCFYGMQYPJYCQXJLLLJGSLZGQLYCJCCZOTYXMTMTTLLWTGPXYMZMKLPSZZZXHKQYSXCTYJZYHXSHYXZKXLZWPSQPYHJWPJPWXQQYLXSDHMRSLZZYZWTTCYXYSZZSHBSCCSTPLWSSCJCHNLCGCHSSPHYLHFHHXJSXYLLNYLSZDHZXYLSXLWZYKCLDYAXZCMDDYSPJTQJZLNWQPSSSWCTSTSZLBLNXSMNYYMJQBQHRZWTYYDCHQLXKPZWBGQYBKFCMZWPZLLYYLSZYDWHXPSBCMLJBSCGBHXLQHYRLJXYSWXWXZSLDFHLSLYNJLZYFLYJYCDRJLFSYZFSLLCQYQFGJYHYXZLYLMSTDJCYHBZLLNWLXXYGYYHSMGDHXXHHLZZJZXCZZZCYQZFNGWPYLCPKPYYPMCLQKDGXZGGWQBDXZZKZFBXXLZXJTPJPTTBYTSZZDWSLCHZHSLTYXHQLHYXXXYYZYSWTXZKHLXZXZPYHGCHKCFSYHUTJRLXFJXPTZTWHPLYXFCRHXSHXKYXXYHZQDXQWULHYHMJTBFLKHTXCWHJFWJCFPQRYQXCYYYQYGRPYWSGSUNGWCHKZDXYFLXXHJJBYZWTSXXNCYJJYMSWZJQRMHXZWFQSYLZJZGBHYNSLBGTTCSYBYXXWXYHXYYXNSQYXMQYWRGYQLXBBZLJSYLPSYTJZYHYZAWLRORJMKSCZJXXXYXCHDYXRYXXJDTSQFXLYLTSFFYXLMTYJMJUYYYXLTZCSXQZQHZXLYYXZHDNBRXXXJCTYHLBRLMBRLLAXKYLLLJLYXXLYCRYLCJTGJCMTLZLLCYZZPZPCYAWHJJFYBDYYZSMPCKZDQYQPBPCJPDCYZMDPBCYYDYCNNPLMTMLRMFMMGWYZBSJGYGSMZQQQZTXMKQWGXLLPJGZBQCDJJJFPKJKCXBLJMSWMDTQJXLDLPPBXCWRCQFBFQJCZAHZGMYKPHYYHZYKNDKZMBPJYXPXYHLFPNYYGXJDBKXNXHJMZJXSTRSTLDXSKZYSYBZXJLXYSLBZYSLHXJPFXPQNBYLLJQKYGZMCYZZYMCCSLCLHZFWFWYXZMWSXTYNXJHPYYMCYSPMHYSMYDYSHQYZCHMJJMZCAAGCFJBBHPLYZYLXXSDJGXDHKXXTXXNBHRMLYJSLTXMRHNLXQJXYZLLYSWQGDLBJHDCGJYQYCMHWFMJYBMBYJYJWYMDPWHXQLDYGPDFXXBCGJSPCKRSSYZJMSLBZZJFLJJJLGXZGYXYXLSZQYXBEXYXHGCXBPLDYHWETTWWCJMBTXCHXYQXLLXFLYXLLJLSSFWDPZSMYJCLMWYTCZPCHQEKCQBWLCQYDPLQPPQZQFJQDJHYMMCXTXDRMJWRHXCJZYLQXDYYNHYYHRSLSRSYWWZJYMTLTLLGTQCJZYABTCKZCJYCCQLJZQXALMZYHYWLWDXZXQDLLQSHGPJFJLJHJABCQZDJGTKHSSTCYJLPSWZLXZXRWGLDLZRLZXTGSLLLLZLYXXWGDZYGBDPHZPBRLWSXQBPFDWOFMWHLYPCBJCCLDMBZPBZZLCYQXLDOMZBLZWPDWYYGDSTTHCSQSCCRSSSYSLFYBFNTYJSZDFNDPDHDZZMBBLSLCMYFFGTJJQWFTMTPJWFNLBZCMMJTGBDZLQLPYFHYYMJYLSDCHDZJWJCCTLJCLDTLJJCPDDSQDSSZYBNDBJLGGJZXSXNLYCYBJXQYCBYLZCFZPPGKCXZDZFZTJJFJSJXZBNZYJQTTYJYHTYCZHYMDJXTTMPXSPLZCDWSLSHXYPZGTFMLCJTYCBPMGDKWYCYZCDSZZYHFLYCTYGWHKJYYLSJCXGYWJCBLLCSNDDBTZBSCLYZCZZSSQDLLMQYYHFSLQLLXFTYHABXGWNYWYYPLLSDLDLLBJCYXJZMLHLJDXYYQYTDLLLBUGBFDFBBQJZZMDPJHGCLGMJJPGAEHHBWCQXAXHHHZCHXYPHJAXHLPHJPGPZJQCQZGJJZZUZDMQYYBZZPHYHYBWHAZYJHYKFGDPFQSDLZMLJXKXGALXZDAGLMDGXMWZQYXXDXXPFDMMSSYMPFMDMMKXKSYZYSHDZKXSYSMMZZZMSYDNZZCZXFPLSTMZDNMXCKJMZTYYMZMZZMSXHHDCZJEMXXKLJSTLWLSQLYJZLLZJSSDPPMHNLZJCZYHMXXHGZCJMDHXTKGRMXFWMCGMWKDTKSXQMMMFZZYDKMSCLCMPCGMHSPXQPZDSSLCXKYXTWLWJYAHZJGZQMCSNXYYMMPMLKJXMHLMLQMXCTKZMJQYSZJSYSZHSYJZJCDAJZYBSDQJZGWZQQXFKDMSDJLFWEHKZQKJPEYPZYSZCDWYJFFMZZYLTTDZZEFMZLBNPPLPLPEPSZALLTYLKCKQZKGENQLWAGYXYDPXLHSXQQWQCQXQCLHYXXMLYCCWLYMQYSKGCHLCJNSZKPYZKCQZQLJPDMDZHLASXLBYDWQLWDNBQCRYDDZTJYBKBWSZDXDTNPJDTCTQDFXQQMGNXECLTTBKPWSLCTYQLPWYZZKLPYGZCQQPLLKCCYLPQMZCZQCLJSLQZDJXLDDHPZQDLJJXZQDXYZQKZLJCYQDYJPPYPQYKJYRMPCBYMCXKLLZLLFQPYLLLMBSGLCYSSLRSYSQTMXYXZQZFDZUYSYZTFFMZZSMZQHZSSCCMLYXWTPZGXZJGZGSJSGKDDHTQGGZLLBJDZLCBCHYXYZHZFYWXYZYMSDBZZYJGTSMTFXQYXQSTDGSLNXDLRYZZLRYYLXQHTXSRTZNGZXBNQQZFMYKMZJBZYMKBPNLYZPBLMCNQYZZZSJZHJCTZKHYZZJRDYZHNPXGLFZTLKGJTCTSSYLLGZRZBBQZZKLPKLCZYSSUYXBJFPNJZZXCDWXZYJXZZDJJKGGRSRJKMSMZJLSJYWQSKYHQJSXPJZZZLSNSHRNYPZTWCHKLPSRZLZXYJQXQKYSJYCZTLQZYBBYBWZPQDWWYZCYTJCJXCKCWDKKZXSGKDZXWWYYJQYYTCYTDLLXWKCZKKLCCLZCQQDZLQLCSFQCHQHSFSMQZZLNBJJZBSJHTSZDYSJQJPDLZCDCWJKJZZLPYCGMZWDJJBSJQZSYZYHHXJPBJYDSSXDZNCGLQMBTSFSBPDZDLZNFGFJGFSMPXJQLMBLGQCYYXBQKDJJQYRFKZTJDHCZKLBSDZCFJTPLLJGXHYXZCSSZZXSTJYGKGCKGYOQXJPLZPBPGTGYJZGHZQZZLBJLSQFZGKQQJZGYCZBZQTLDXRJXBSXXPZXHYZYCLWDXJJHXMFDZPFZHQHQMQGKSLYHTYCGFRZGNQXCLPDLBZCSCZQLLJBLHBZCYPZZPPDYMZZSGYHCKCPZJGSLJLNSCDSLDLXBMSTLDDFJMKDJDHZLZXLSZQPQPGJLLYBDSZGQLBZLSLKYYHZTTNTJYQTZZPSZQZTLLJTYYLLQLLQYZQLBDZLSLYYZYMDFSZSNHLXZNCZQZPBWSKRFBSYZMTHBLGJPMCZZLSTLXSHTCSYZLZBLFEQHLXFLCJLYLJQCBZLZJHHSSTBRMHXZHJZCLXFNBGXGTQJCZTMSFZKJMSSNXLJKBHSJXNTNLZDNTLMSJXGZJYJCZXYJYJWRWWQNZTNFJSZPZSHZJFYRDJSFSZJZBJFZQZZHZLXFYSBZQLZSGYFTZDCSZXZJBQMSZKJRHYJZCKMJKHCHGTXKXQGLXPXFXTRTYLXJXHDTSJXHJZJXZWZLCQSBTXWXGXTXXHXFTSDKFJHZYJFJXRZSDLLLTQSQQZQWZXSYQTWGWBZCGZLLYZBCLMQQTZHZXZXLJFRMYZFLXYSQXXJKXRMQDZDMMYYBSQBHGZMWFWXGMXLZPYYTGZYCCDXYZXYWGSYJYZNBHPZJSQSYXSXRTFYZGRHZTXSZZTHCBFCLSYXZLZQMZLMPLMXZJXSFLBYZMYQHXJSXRXSQZZZSSLYFRCZJRCRXHHZXQYDYHXSJJHZCXZBTYNSYSXJBQLPXZQPYMLXZKYXLXCJLCYSXXZZLXDLLLJJYHZXGYJWKJRWYHCPSGNRZLFZWFZZNSXGXFLZSXZZZBFCSYJDBRJKRDHHGXJLJJTGXJXXSTJTJXLYXQFCSGSWMSBCTLQZZWLZZKXJMLTMJYHSDDBXGZHDLBMYJFRZFSGCLYJBPMLYSMSXLSZJQQHJZFXGFQFQBPXZGYYQXGZTCQWYLTLGWSGWHRLFSFGZJMGMGBGTJFSYZZGZYZAFLSSPMLPFLCWBJZCLJJMZLPJJLYMQDMYYYFBGYGYZMLYZDXQYXRQQQHSYYYQXYLJTYXFSFSLLGNQCYHYCWFHCCCFXPYLYPLLZYXXXXXKQHHXSHJZCFZSCZJXCPZWHHHHHAPYLQALPQAFYHXDYLUKMZQGGGDDESRNNZLTZGCHYPPYSQJJHCLLJTOLNJPZLJLHYMHEYDYDSQYCDDHGZUNDZCLZYZLLZNTNYZGSLHSLPJJBDGWXPCDUTJCKLKCLWKLLCASSTKZZDNQNTTLYYZSSYSSZZRYLJQKCQDHHCRXRZYDGRGCWCGZQFFFPPJFZYNAKRGYWYQPQXXFKJTSZZXSWZDDFBBXTBGTZKZNPZZPZXZPJSZBMQHKCYXYLDKLJNYPKYGHGDZJXXEAHPNZKZTZCMXCXMMJXNKSZQNMNLWBWWXJKYHCPSTMCSQTZJYXTPCTPDTNNPGLLLZSJLSPBLPLQHDTNJNLYYRSZFFJFQWDPHZDWMRZCCLODAXNSSNYZRESTYJWJYJDBCFXNMWTTBYLWSTSZGYBLJPXGLBOCLHPCBJLTMXZLJYLZXCLTPNCLCKXTPZJSWCYXSFYSZDKNTLBYJCYJLLSTGQCBXRYZXBXKLYLHZLQZLNZCXWJZLJZJNCJHXMNZZGJZZXTZJXYCYYCXXJYYXJJXSSSJSTSSTTPPGQTCSXWZDCSYFPTFBFHFBBLZJCLZZDBXGCXLQPXKFZFLSYLTUWBMQJHSZBMDDBCYSCCLDXYCDDQLYJJWMQLLCSGLJJSYFPYYCCYLTJANTJJPWYCMMGQYYSXDXQMZHSZXPFTWWZQSWQRFKJLZJQQYFBRXJHHFWJJZYQAZMYFRHCYYBYQWLPEXCCZSTYRLTTDMQLYKMBBGMYYJPRKZNPBSXYXBHYZDJDNGHPMFSGMWFZMFQMMBCMZZCJJLCNUXYQLMLRYGQZCYXZLWJGCJCGGMCJNFYZZJHYCPRRCMTZQZXHFQGTJXCCJEAQCRJYHPLQLSZDJRBCQHQDYRHYLYXJSYMHZYDWLDFRYHBPYDTSSCNWBXGLPZMLZZTQSSCPJMXXYCSJYTYCGHYCJWYRXXLFEMWJNMKLLSWTXHYYYNCMMCWJDQDJZGLLJWJRKHPZGGFLCCSCZMCBLTBHBQJXQDSPDJZZGKGLFQYWBZYZJLTSTDHQHCTCBCHFLQMPWDSHYYTQWCNZZJTLBYMBPDYYYXSQKXWYYFLXXNCWCXYPMAELYKKJMZZZBRXYYQJFLJPFHHHYTZZXSGQQMHSPGDZQWBWPJHZJDYSCQWZKTXXSQLZYYMYSDZGRXCKKUJLWPYSYSCSYZLRMLQSYLJXBCXTLWDQZPCYCYKPPPNSXFYZJJRCEMHSZMSXLXGLRWGCSTLRSXBZGBZGZTCPLUJLSLYLYMTXMTZPALZXPXJTJWTCYYZLBLXBZLQMYLXPGHDSLSSDMXMBDZZSXWHAMLCZCPJMCNHJYSNSYGCHSKQMZZQDLLKABLWJXSFMOCDXJRRLYQZKJMYBYQLYHETFJZFRFKSRYXFJTWDSXXSYSQJYSLYXWJHSNLXYYXHBHAWHHJZXWMYLJCSSLKYDZTXBZSYFDXGXZJKHSXXYBSSXDPYNZWRPTQZCZENYGCXQFJYKJBZMLJCMQQXUOXSLYXXLYLLJDZBTYMHPFSTTQQWLHOKYBLZZALZXQLHZWRRQHLSTMYPYXJJXMQSJFNBXYXYJXXYQYLTHYLQYFMLKLJTMLLHSZWKZHLJMLHLJKLJSTLQXYLMBHHLNLZXQJHXCFXXLHYHJJGBYZZKBXSCQDJQDSUJZYYHZHHMGSXCSYMXFEBCQWWRBPYYJQTYZCYQYQQZYHMWFFHGZFRJFCDPXNTQYZPDYKHJLFRZXPPXZDBBGZQSTLGDGYLCQMLCHHMFYWLZYXKJLYPQHSYWMQQGQZMLZJNSQXJQSYJYCBEHSXFSZPXZWFLLBCYYJDYTDTHWZSFJMQQYJLMQXXLLDTTKHHYBFPWTYYSQQWNQWLGWDEBZWCMYGCULKJXTMXMYJSXHYBRWFYMWFRXYQMXYSZTZZTFYKMLDHQDXWYYNLCRYJBLPSXCXYWLSPRRJWXHQYPHTYDNXHHMMYWYTZCSQMTSSCCDALWZTCPQPYJLLQZYJSWXMZZMMYLMXCLMXCZMXMZSQTZPPQQBLPGXQZHFLJJHYTJSRXWZXSCCDLXTYJDCQJXSLQYCLZXLZZXMXQRJMHRHZJBHMFLJLMLCLQNLDXZLLLPYPSYJYSXCQQDCMQJZZXHNPNXZMEKMXHYKYQLXSXTXJYYHWDCWDZHQYYBGYBCYSCFGPSJNZDYZZJZXRZRQJJYMCANYRJTLDPPYZBSTJKXXZYPFDWFGZZRPYMTNGXZQBYXNBUFNQKRJQZMJEGRZGYCLKXZDSKKNSXKCLJSPJYYZLQQJYBZSSQLLLKJXTBKTYLCCDDBLSPPFYLGYDTZJYQGGKQTTFZXBDKTYYHYBBFYTYYBCLPDYTGDHRYRNJSPTCSNYJQHKLLLZSLYDXXWBCJQSPXBPJZJCJDZFFXXBRMLAZHCSNDLBJDSZBLPRZTSWSBXBCLLXXLZDJZSJPYLYXXYFTFFFBHJJXGBYXJPMMMPSSJZJMTLYZJXSWXTYLEDQPJMYGQZJGDJLQJWJQLLSJGJGYGMSCLJJXDTYGJQJQJCJZCJGDZZSXQGSJGGCXHQXSNQLZZBXHSGZXCXYLJXYXYYDFQQJHJFXDHCTXJYRXYSQTJXYEFYYSSYYJXNCYZXFXMSYSZXYYSCHSHXZZZGZZZGFJDLTYLNPZGYJYZYYQZPBXQBDZTZCZYXXYHHSQXSHDHGQHJHGYWSZTMZMLHYXGEBTYLZKQWYTJZRCLEKYSTDBCYKQQSAYXCJXWWGSBHJYZYDHCSJKQCXSWXFLTYNYZPZCCZJQTZWJQDZZZQZLJJXLSBHPYXXPSXSHHEZTXFPTLQYZZXHYTXNCFZYYHXGNXMYWXTZSJPTHHGYMXMXQZXTSBCZYJYXXTYYZYPCQLMMSZMJZZLLZXGXZAAJZYXJMZXWDXZSXZDZXLEYJJZQBHZWZZZQTZPSXZTDSXJJJZNYAZPHXYYSRNQDTHZHYYKYJHDZXZLSWCLYBZYECWCYCRYLCXNHZYDZYDYJDFRJJHTRSQTXYXJRJHOJYNXELXSFSFJZGHPZSXZSZDZCQZBYYKLSGSJHCZSHDGQGXYZGXCHXZJWYQWGYHKSSEQZZNDZFKWYSSTCLZSTSYMCDHJXXYWEYXCZAYDMPXMDSXYBSQMJMZJMTZQLPJYQZCGQHXJHHLXXHLHDLDJQCLDWBSXFZZYYSCHTYTYYBHECXHYKGJPXHHYZJFXHWHBDZFYZBCAPNPGNYDMSXHMMMMAMYNBYJTMPXYYMCTHJBZYFCGTYHWPHFTWZZEZSBZEGPFMTSKFTYCMHFLLHGPZJXZJGZJYXZSBBQSCZZLZCCSTPGXMJSFTCCZJZDJXCYBZLFCJSYZFGSZLYBCWZZBYZDZYPSWYJZXZBDSYUXLZZBZFYGCZXBZHZFTPBGZGEJBSTGKDMFHYZZJHZLLZZGJQZLSFDJSSCBZGPDLFZFZSZYZYZSYGCXSNXXCHCZXTZZLJFZGQSQYXZJQDCCZTQCDXZJYQJQCHXZTDLGSCXZSYQJQTZWLQDQZTQCHQQJZYEZZZPBWKDJFCJPZTYPQYQTTYNLMBDKTJZPQZQZZFPZSBNJLGYJDXJDZZKZGQKXDLPZJTCJDQBXDJQJSTCKNXBXZMSLYJCQMTJQWWCJQNJNLLLHJCWQTBZQYDZCZPZZDZYDDCYZZZCCJTTJFZDPRRTZTJDCQTQZDTJNPLZBCLLCTZSXKJZQZPZLBZRBTJDCXFCZDBCCJJLTQQPLDCGZDBBZJCQDCJWYNLLZYZCCDWLLXWZLXRXNTQQCZXKQLSGDFQTDDGLRLAJJTKUYMKQLLTZYTDYYCZGJWYXDXFRSKSTQTENQMRKQZHHQKDLDAZFKYPBGGPZREBZZYKZZSPEGJXGYKQZZZSLYSYYYZWFQZYLZZLZHWCHKYPQGNPGBLPLRRJYXCCSYYHSFZFYBZYYTGZXYLXCZWXXZJZBLFFLGSKHYJZEYJHLPLLLLCZGXDRZELRHGKLZZYHZLYQSZZJZQLJZFLNBHGWLCZCFJYSPYXZLZLXGCCPZBLLCYBBBBUBBCBPCRNNZCZYRBFSRLDCGQYYQXYGMQZWTZYTYJXYFWTEHZZJYWLCCNTZYJJZDEDPZDZTSYQJHDYMBJNYJZLXTSSTPHNDJXXBYXQTZQDDTJTDYYTGWSCSZQFLSHLGLBCZPHDLYZJYCKWTYTYLBNYTSDSYCCTYSZYYEBHEXHQDTWNYGYCLXTSZYSTQMYGZAZCCSZZDSLZCLZRQXYYELJSBYMXSXZTEMBBLLYYLLYTDQYSHYMRQWKFKBFXNXSBYCHXBWJYHTQBPBSBWDZYLKGZSKYHXQZJXHXJXGNLJKZLYYCDXLFYFGHLJGJYBXQLYBXQPQGZTZPLNCYPXDJYQYDYMRBESJYYHKXXSTMXRCZZYWXYQYBMCLLYZHQYZWQXDBXBZWZMSLPDMYSKFMZKLZCYQYCZLQXFZZYDQZPZYGYJYZMZXDZFYFYTTQTZHGSPCZMLCCYTZXJCYTJMKSLPZHYSNZLLYTPZCTZZCKTXDHXXTQCYFKSMQCCYYAZHTJPCYLZLYJBJXTPNYLJYYNRXSYLMMNXJSMYBCSYSYLZYLXJJQYLDZLPQBFZZBLFNDXQKCZFYWHGQMRDSXYCYTXNQQJZYYPFZXDYZFPRXEJDGYQBXRCNFYYQPGHYJDYZXGRHTKYLNWDZNTSMPKLBTHBPYSZBZTJZSZZJTYYXZPHSSZZBZCZPTQFZMYFLYPYBBJQXZMXXDJMTSYSKKBJZXHJCKLPSMKYJZCXTMLJYXRZZQSLXXQPYZXMKYXXXJCLJPRMYYGADYSKQLSNDHYZKQXZYZTCGHZTLMLWZYBWSYCTBHJHJFCWZTXWYTKZLXQSHLYJZJXTMPLPYCGLTBZZTLZJCYJGDTCLKLPLLQPJMZPAPXYZLKKTKDZCZZBNZDYDYQZJYJGMCTXLTGXSZLMLHBGLKFWNWZHDXUHLFMKYSLGXDTWWFRJEJZTZHYDXYKSHWFZCQSHKTMQQHTZHYMJDJSKHXZJZBZZXYMPAGQMSTPXLSKLZYNWRTSQLSZBPSPSGZWYHTLKSSSWHZZLYYTNXJGMJSZSUFWNLSOZTXGXLSAMMLBWLDSZYLAKQCQCTMYCFJBSLXCLZZCLXXKSBZQCLHJPSQPLSXXCKSLNHPSFQQYTXYJZLQLDXZQJZDYYDJNZPTUZDSKJFSLJHYLZSQZLBTXYDGTQFDBYAZXDZHZJNHHQBYKNXJJQCZMLLJZKSPLDYCLBBLXKLELXJLBQYCXJXGCNLCQPLZLZYJTZLJGYZDZPLTQCSXFDMNYCXGBTJDCZNBGBQYQJWGKFHTNPYQZQGBKPBBYZMTJDYTBLSQMPSXTBNPDXKLEMYYCJYNZCTLDYKZZXDDXHQSHDGMZSJYCCTAYRZLPYLTLKXSLZCGGEXCLFXLKJRTLQJAQZNCMBYDKKCXGLCZJZXJHPTDJJMZQYKQSECQZDSHHADMLZFMMZBGNTJNNLGBYJBRBTMLBYJDZXLCJLPLDLPCQDHLXZLYCBLCXZZJADJLNZMMSSSMYBHBSQKBHRSXXJMXSDZNZPXLGBRHWGGFCXGMSKLLTSJYYCQLTSKYWYYHYWXBXQYWPYWYKQLSQPTNTKHQCWDQKTWPXXHCPTHTWUMSSYHBWCRWXHJMKMZNGWTMLKFGHKJYLSYYCXWHYECLQHKQHTTQKHFZLDXQWYZYYDESBPKYRZPJFYYZJCEQDZZDLATZBBFJLLCXDLMJSSXEGYGSJQXCWBXSSZPDYZCXDNYXPPZYDLYJCZPLTXLSXYZYRXCYYYDYLWWNZSAHJSYQYHGYWWAXTJZDAXYSRLTDPSSYYFNEJDXYZHLXLLLZQZSJNYQYQQXYJGHZGZCYJCHZLYCDSHWSHJZYJXCLLNXZJJYYXNFXMWFPYLCYLLABWDDHWDXJMCXZTZPMLQZHSFHZYNZTLLDYWLSLXHYMMYLMBWWKYXYADTXYLLDJPYBPWUXJMWMLLSAFDLLYFLBHHHBQQLTZJCQJLDJTFFKMMMBYTHYGDCQRDDWRQJXNBYSNWZDBYYTBJHPYBYTTJXAAHGQDQTMYSTQXKBTZPKJLZRBEQQSSMJJBDJOTGTBXPGBKTLHQXJJJCTHXQDWJLWRFWQGWSHCKRYSWGFTGYGBXSDWDWRFHWYTJJXXXJYZYSLPYYYPAYXHYDQKXSHXYXGSKQHYWFDDDPPLCJLQQEEWXKSYYKDYPLTJTHKJLTCYYHHJTTPLTZZCDLTHQKZXQYSTEEYWYYZYXXYYSTTJKLLPZMCYHQGXYHSRMBXPLLNQYDQHXSXXWGDQBSHYLLPJJJTHYJKYPPTHYYKTYEZYENMDSHLCRPQFDGFXZPSFTLJXXJBSWYYSKSFLXLPPLBBBLBSFXFYZBSJSSYLPBBFFFFSSCJDSTZSXZRYYSYFFSYZYZBJTBCTSBSDHRTJJBYTCXYJEYLXCBNEBJDSYXYKGSJZBXBYTFZWGENYHHTHZHHXFWGCSTBGXKLSXYWMTMBYXJSTZSCDYQRCYTWXZFHMYMCXLZNSDJTTTXRYCFYJSBSDYERXJLJXBBDEYNJGHXGCKGSCYMBLXJMSZNSKGXFBNBPTHFJAAFXYXFPXMYPQDTZCXZZPXRSYWZDLYBBKTYQPQJPZYPZJZNJPZJLZZFYSBTTSLMPTZRTDXQSJEHBZYLZDHLJSQMLHTXTJECXSLZZSPKTLZKQQYFSYGYWPCPQFHQHYTQXZKRSGTTSQCZLPTXCDYYZXSQZSLXLZMYCPCQBZYXHBSXLZDLTCDXTYLZJYYZPZYZLTXJSJXHLPMYTXCQRBLZSSFJZZTNJYTXMYJHLHPPLCYXQJQQKZZSCPZKSWALQSBLCCZJSXGWWWYGYKTJBBZTDKHXHKGTGPBKQYSLPXPJCKBMLLXDZSTBKLGGQKQLSBKKTFXRMDKBFTPZFRTBBRFERQGXYJPZSSTLBZTPSZQZSJDHLJQLZBPMSMMSXLQQNHKNBLRDDNXXDHDDJCYYGYLXGZLXSYGMQQGKHBPMXYXLYTQWLWGCPBMQXCYZYDRJBHTDJYHQSHTMJSBYPLWHLZFFNYPMHXXHPLTBQPFBJWQDBYGPNZTPFZJGSDDTQSHZEAWZZYLLTYYBWJKXXGHLFKXDJTMSZSQYNZGGSWQSPHTLSSKMCLZXYSZQZXNCJDQGZDLFNYKLJCJLLZLMZZNHYDSSHTHZZLZZBBHQZWWYCRZHLYQQJBEYFXXXWHSRXWQHWPSLMSSKZTTYGYQQWRSLALHMJTQJSMXQBJJZJXZYZKXBYQXBJXSHZTSFJLXMXZXFGHKZSZGGYLCLSARJYHSLLLMZXELGLXYDJYTLFBHBPNLYZFBBHPTGJKWETZHKJJXZXXGLLJLSTGSHJJYQLQZFKCGNNDJSSZFDBCTWWSEQFHQJBSAQTGYPQLBXBMMYWXGSLZHGLZGQYFLZBYFZJFRYSFMBYZHQGFWZSYFYJJPHZBYYZFFWODGRLMFTWLBZGYCQXCDJYGZYYYYTYTYDWEGAZYHXJLZYYHLRMGRXXZCLHNELJJTJTPWJYBJJBXJJTJTEEKHWSLJPLPSFYZPQQBDLQJJTYYQLYZKDKSQJYYQZLDQTGJQYZJSUCMRYQTHTEJMFCTYHYPKMHYZWJDQFHYYXWSHCTXRLJHQXHCCYYYJLTKTTYTMXGTCJTZAYYOCZLYLBSZYWJYTSJYHBYSHFJLYGJXXTMZYYLTXXYPZLXYJZYZYYPNHMYMDYYLBLHLSYYQQLLNJJYMSOYQBZGDLYXYLCQYXTSZEGXHZGLHWBLJHEYXTWQMAKBPQCGYSHHEGQCMWYYWLJYJHYYZLLJJYLHZYHMGSLJLJXCJJYCLYCJPCPZJZJMMYLCQLNQLJQJSXYJMLSZLJQLYCMMHCFMMFPQQMFYLQMCFFQMMMMHMZNFHHJGTTHHKHSLNCHHYQDXTMMQDCYZYXYQMYQYLTDCYYYZAZZCYMZYDLZFFFMMYCQZWZZMABTBYZTDMNZZGGDFTYPCGQYTTSSFFWFDTZQSSYSTWXJHXYTSXXYLBYQHWWKXHZXWZNNZZJZJJQJCCCHYYXBZXZCYZTLLCQXYNJYCYYCYNZZQYYYEWYCZDCJYCCHYJLBTZYYCQWMPWPYMLGKDLDLGKQQBGYCHJXY";
                //此处收录了375个多音字,数据来自于http://www.51window.net/page/pinyin  
                var oMultiDiff = { "19969": "DZ", "19975": "WM", "19988": "QJ", "20048": "YL", "20056": "SC", "20060": "NM", "20094": "QG", "20127": "QJ", "20167": "QC", "20193": "YG", "20250": "KH", "20256": "ZC", "20282": "SC", "20285": "QJG", "20291": "TD", "20314": "YD", "20340": "NE", "20375": "TD", "20389": "YJ", "20391": "CZ", "20415": "PB", "20446": "YS", "20447": "SQ", "20504": "TC", "20608": "KG", "20854": "QJ", "20857": "ZC", "20911": "PF", "20504": "TC", "20608": "KG", "20854": "QJ", "20857": "ZC", "20911": "PF", "20985": "AW", "21032": "PB", "21048": "XQ", "21049": "SC", "21089": "YS", "21119": "JC", "21242": "SB", "21273": "SC", "21305": "YP", "21306": "QO", "21330": "ZC", "21333": "SDC", "21345": "QK", "21378": "CA", "21397": "SC", "21414": "XS", "21442": "SC", "21477": "JG", "21480": "TD", "21484": "ZS", "21494": "YX", "21505": "YX", "21512": "HG", "21523": "XH", "21537": "PB", "21542": "PF", "21549": "KH", "21571": "E", "21574": "DA", "21588": "TD", "21589": "O", "21618": "ZC", "21621": "KHA", "21632": "ZJ", "21654": "KG", "21679": "LKG", "21683": "KH", "21710": "A", "21719": "YH", "21734": "WOE", "21769": "A", "21780": "WN", "21804": "XH", "21834": "A", "21899": "ZD", "21903": "RN", "21908": "WO", "21939": "ZC", "21956": "SA", "21964": "YA", "21970": "TD", "22003": "A", "22031": "JG", "22040": "XS", "22060": "ZC", "22066": "ZC", "22079": "MH", "22129": "XJ", "22179": "XA", "22237": "NJ", "22244": "TD", "22280": "JQ", "22300": "YH", "22313": "XW", "22331": "YQ", "22343": "YJ", "22351": "PH", "22395": "DC", "22412": "TD", "22484": "PB", "22500": "PB", "22534": "ZD", "22549": "DH", "22561": "PB", "22612": "TD", "22771": "KQ", "22831": "HB", "22841": "JG", "22855": "QJ", "22865": "XQ", "23013": "ML", "23081": "WM", "23487": "SX", "23558": "QJ", "23561": "YW", "23586": "YW", "23614": "YW", "23615": "SN", "23631": "PB", "23646": "ZS", "23663": "ZT", "23673": "YG", "23762": "TD", "23769": "ZS", "23780": "QJ", "23884": "QK", "24055": "XH", "24113": "DC", "24162": "ZC", "24191": "GA", "24273": "QJ", "24324": "NL", "24377": "TD", "24378": "QJ", "24439": "PF", "24554": "ZS", "24683": "TD", "24694": "WE", "24733": "LK", "24925": "TN", "25094": "ZG", "25100": "XQ", "25103": "XH", "25153": "PB", "25170": "PB", "25179": "KG", "25203": "PB", "25240": "ZS", "25282": "FB", "25303": "NA", "25324": "KG", "25341": "ZY", "25373": "WZ", "25375": "XJ", "25384": "A", "25457": "A", "25528": "SD", "25530": "SC", "25552": "TD", "25774": "ZC", "25874": "ZC", "26044": "YW", "26080": "WM", "26292": "PB", "26333": "PB", "26355": "ZY", "26366": "CZ", "26397": "ZC", "26399": "QJ", "26415": "ZS", "26451": "SB", "26526": "ZC", "26552": "JG", "26561": "TD", "26588": "JG", "26597": "CZ", "26629": "ZS", "26638": "YL", "26646": "XQ", "26653": "KG", "26657": "XJ", "26727": "HG", "26894": "ZC", "26937": "ZS", "26946": "ZC", "26999": "KJ", "27099": "KJ", "27449": "YQ", "27481": "XS", "27542": "ZS", "27663": "ZS", "27748": "TS", "27784": "SC", "27788": "ZD", "27795": "TD", "27812": "O", "27850": "PB", "27852": "MB", "27895": "SL", "27898": "PL", "27973": "QJ", "27981": "KH", "27986": "HX", "27994": "XJ", "28044": "YC", "28065": "WG", "28177": "SM", "28267": "QJ", "28291": "KH", "28337": "ZQ", "28463": "TL", "28548": "DC", "28601": "TD", "28689": "PB", "28805": "JG", "28820": "QG", "28846": "PB", "28952": "TD", "28975": "ZC", "29100": "A", "29325": "QJ", "29575": "SL", "29602": "FB", "30010": "TD", "30044": "CX", "30058": "PF", "30091": "YSP", "30111": "YN", "30229": "XJ", "30427": "SC", "30465": "SX", "30631": "YQ", "30655": "QJ", "30684": "QJG", "30707": "SD", "30729": "XH", "30796": "LG", "30917": "PB", "31074": "NM", "31085": "JZ", "31109": "SC", "31181": "ZC", "31192": "MLB", "31293": "JQ", "31400": "YX", "31584": "YJ", "31896": "ZN", "31909": "ZY", "31995": "XJ", "32321": "PF", "32327": "ZY", "32418": "HG", "32420": "XQ", "32421": "HG", "32438": "LG", "32473": "GJ", "32488": "TD", "32521": "QJ", "32527": "PB", "32562": "ZSQ", "32564": "JZ", "32735": "ZD", "32793": "PB", "33071": "PF", "33098": "XL", "33100": "YA", "33152": "PB", "33261": "CX", "33324": "BP", "33333": "TD", "33406": "YA", "33426": "WM", "33432": "PB", "33445": "JG", "33486": "ZN", "33493": "TS", "33507": "QJ", "33540": "QJ", "33544": "ZC", "33564": "XQ", "33617": "YT", "33632": "QJ", "33636": "XH", "33637": "YX", "33694": "WG", "33705": "PF", "33728": "YW", "33882": "SR", "34067": "WM", "34074": "YW", "34121": "QJ", "34255": "ZC", "34259": "XL", "34425": "JH", "34430": "XH", "34485": "KH", "34503": "YS", "34532": "HG", "34552": "XS", "34558": "YE", "34593": "ZL", "34660": "YQ", "34892": "XH", "34928": "SC", "34999": "QJ", "35048": "PB", "35059": "SC", "35098": "ZC", "35203": "TQ", "35265": "JX", "35299": "JX", "35782": "SZ", "35828": "YS", "35830": "E", "35843": "TD", "35895": "YG", "35977": "MH", "36158": "JG", "36228": "QJ", "36426": "XQ", "36466": "DC", "36710": "JC", "36711": "ZYG", "36767": "PB", "36866": "SK", "36951": "YW", "37034": "YX", "37063": "XH", "37218": "ZC", "37325": "ZC", "38063": "PB", "38079": "TD", "38085": "QY", "38107": "DC", "38116": "TD", "38123": "YD", "38224": "HG", "38241": "XTC", "38271": "ZC", "38415": "YE", "38426": "KH", "38461": "YD", "38463": "AE", "38466": "PB", "38477": "XJ", "38518": "YT", "38551": "WK", "38585": "ZC", "38704": "XS", "38739": "LJ", "38761": "GJ", "38808": "SQ", "39048": "JG", "39049": "XJ", "39052": "HG", "39076": "CZ", "39271": "XT", "39534": "TD", "39552": "TD", "39584": "PB", "39647": "SB", "39730": "LG", "39748": "TPB", "40109": "ZQ", "40479": "ND", "40516": "HG", "40536": "HG", "40583": "QJ", "40765": "YQ", "40784": "QJ", "40840": "YK", "40863": "QJG" };
                //参数,中文字符串  
                //返回值:拼音首字母串数组  
                function makePy(str) {
                    if (typeof (str) != "string")
                        throw new Error(-1, "函数makePy需要字符串类型参数!");
                    var arrResult = new Array(); //保存中间结果的数组  
                    for (var i = 0, len = str.length; i < len; i++) {
                        //获得unicode码  
                        var ch = str.charAt(i);
                        //检查该unicode码是否在处理范围之内,在则返回该码对映汉字的拼音首字母,不在则调用其它函数处理  
                        arrResult.push(checkCh(ch));
                    }
                    //处理arrResult,返回所有可能的拼音首字母串数组  
                    return mkRslt(arrResult);
                }
                function checkCh(ch) {
                    var uni = ch.charCodeAt(0);
                    //如果不在汉字处理范围之内,返回原字符,也可以调用自己的处理函数  
                    if (uni > 40869 || uni < 19968)
                        return ch; //dealWithOthers(ch);  
                    //检查是否是多音字,是按多音字处理,不是就直接在strChineseFirstPY字符串中找对应的首字母  
                    return (oMultiDiff[uni] ? oMultiDiff[uni] : (strChineseFirstPY.charAt(uni - 19968)));
                }
                function mkRslt(arr) {
                    var arrRslt = [""];
                    for (var i = 0, len = arr.length; i < len; i++) {
                        var str = arr[i];
                        var strlen = str.length;
                        if (strlen == 1) {
                            for (var k = 0; k < arrRslt.length; k++) {
                                arrRslt[k] += str;
                            }
                        } else {
                            var tmpArr = arrRslt.slice(0);
                            arrRslt = [];
                            for (k = 0; k < strlen; k++) {
                                //复制一个相同的arrRslt  
                                var tmp = tmpArr.slice(0);
                                //把当前字符str[k]添加到每个元素末尾  
                                for (var j = 0; j < tmp.length; j++) {
                                    tmp[j] += str.charAt(k);
                                }
                                //把复制并修改后的数组连接到arrRslt上  
                                arrRslt = arrRslt.concat(tmp);
                            }
                        }
                    }
                    return arrRslt;
                }
                //两端去空格函数  
                String.prototype.trim = function () { return this.replace(/(^\s*)|(\s*$)/g, ""); }

                $("[name='add_workflow_name']").on('keyup', function () {
                    var str = $("[name='add_workflow_name']").val();
                    if (str == "") {
                        $("#add_workflow_id").val("");
                        return;
                    }
                    var arrRslt = makePy(str);
                    //循环将值到下拉框
                    var option = null;
                    $("#add_workflow_ids_val").empty();//清空下拉框
                    var $select = $("#add_workflow_ids_val");
                    var html = "";
                    for (var j = 0; j < arrRslt.length; j++) {
                        html += "<li style='margin-left: 10px;'><input type='radio' name='workflow_ids' id='" + arrRslt[j] + "' data-deptname='" + arrRslt[j] + "' value='" + arrRslt[j] + "'/>&nbsp;&nbsp;<label style='cursor:pointer' for='" + arrRslt[j] + "'>" + arrRslt[j] + "</label></li>";
                    }
                    $select.append(html);
                    $("#add_workflow_id").val(arrRslt[0]);

                    $("input:radio[name='workflow_ids']").on('click', function (event) {
                        $("#add_workflow_id").val($(this).data().deptname);
                    });
                });
            }

            //编辑行
            $('.table').delegate( '[data-row^="edit"]','row.edit', function (e) {

               // $(e.target).closest('tr').children().find(".DeptId-edit,.LeaderUserName-edit,.LeaderDeptId-edit,.LeaderDeptName-edit").attr("readonly", "readonly");

                bindEditIsNullValidate(e);
                //绑定步骤类型和子步骤类型的数据源
                bindEditSmtype(e);
                setEditDeptValue(e);
                bindEditSubtype(e);
            });


            function setEditDeptValue(e) {
                $tds = $(e.target).closest('tr').children();
                var stepGroup = $tds.find(".DeptName-edit");
                var currentIndex = $(e.target).closest('tr').data().index
                var model = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];

                var deptId = dept[0].DeptId;
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < dept.length; i++) {
                    if (dept[i].DeptName === model.DeptName) {
                        html += "<option selected='selected' value='" +
                            dept[i].DeptId +
                            "'>" +
                            dept[i].DeptName +
                            "</option>";

                        deptId = dept[i].DeptId;
                    } else {
                        html += "<option value='" + dept[i].DeptId + "'>" + dept[i].DeptName + "</option>";
                    }
                }
                stepGroup.append(html);
                $tds.find(".DeptId-edit").val(deptId);
                stepGroup.on('change', function () {
                    var selectVal = $(this).find('option:selected').val();
                    $tds.find(".DeptId-edit").val(selectVal);
                });
            }

            function bindEditSmtype(e) {
                //拿到对应的select
                //往select上面绑数据


                $tds = $(e.target).closest('tr').children();
                var stepGroup = $tds.find(".sm-type-edit");
                var currentIndex = $(e.target).closest('tr').data().index
                var model = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];


                var typeId = smtype[0].TypeId;
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < smtype.length; i++) {
                    if (smtype[i].TypeId=== model.SmType) {
                        html += "<option selected='selected' value='" +
                            smtype[i].TypeId +
                            "'>" +
                            smtype[i].TypeName +
                            "</option>";

                        typeId = smtype[i].TypeId;
                    } else {
                        html += "<option value='" + smtype[i].TypeId + "'>" + smtype[i].TypeName + "</option>";
                    }
                }
                stepGroup.append(html);

             

            }


            function bindEditSubtype(e) {
                //拿到对应的select
                //往select上面绑数据

                $tds = $(e.target).closest('tr').children();
                var stepGroup = $tds.find(".sub-type-edit");
                var currentIndex = $(e.target).closest('tr').data().index
                var model = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];


                var typeId = subtype[0].TypeId;
                stepGroup.empty();
                var html = "";
                for (var i = 0; i < subtype.length; i++) {
                    if (subtype[i].TypeId === model.SubType) {
                        html += "<option selected='selected' value='" +
                            subtype[i].TypeId +
                            "'>" +
                            subtype[i].TypeName +
                            "</option>";

                        typeId = subtype[i].TypeId;
                    } else {
                        html += "<option value='" + subtype[i].TypeId + "'>" + subtype[i].TypeName + "</option>";
                    }
                }

                html += "<option value=‘0'>无</option>";
                stepGroup.append(html);

           

            }


            function bindEditIsNullValidate(e) {
                $tds = $(e.target).closest('tr').children();
                //非空验证。
                $tds.find(".workflowname-edit").on('blur', function () {
                    changeClassByNull($(this));
                });
            }

            //取消。
            $('.table').delegate('[data-row^="cancel"]','row.cancel', function (e) {
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
                    var smBasicDataEntityObj = $("#DeptGroup_Origin").bootstrapTable('getData')[currentIndex];
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
                    var workflowname = $tds.find(".workflowname-edit").val();
                    $tds.find(".workflowname-edit").blur();
                    if (workflowname === "") {
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
                var workflowName = $('input[name="add_workflow_name"]').val();
                var workflowId = $('#add_workflow_id').val();
                $('input[name="add_workflow_name"]').blur();
                $('#add_workflow_id').blur();
                if (workflowName === "" || workflowId === "") {
                    return false;
                } else {
                    return true;
                }
            }

            //增加
            function add() {
                var workFlowId = $('#add_workflow_id').val();
                var deptId = $('input[name="add_dept_id"]').val();
                var workFlowName = $('input[name="add_workflow_name"]').val();
                var smType = $("select[name='add_sm_type_name'] option:selected").val();
                var subType = $("select[name='add_sub_type_name'] option:selected").val();
                var activityflag = $("select[name='add_activity_flag_select'] option:selected").val();
                var smWorkFlowStaticObj = new Object();
                smWorkFlowStaticObj.WorkFlowId = $.trim(workFlowId);
                smWorkFlowStaticObj.DeptId = $.trim(deptId);
                smWorkFlowStaticObj.WorkFlowName = $.trim(workFlowName);
                smWorkFlowStaticObj.SmType = $.trim(smType);
                smWorkFlowStaticObj.SubType = $.trim(subType);
                smWorkFlowStaticObj.ActivityFlag = $.trim(activityflag);
                var smWorkFlowStaticEntity = '{"smWorkFlowStaticEntity":' + JSON.stringify(smWorkFlowStaticObj) + '}';
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/AddSmWorkFlowStatic",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smWorkFlowStaticEntity,
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


            //编辑
            function edit(e) {

                $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData');
                $tds = $(e.target).closest('tr').children();
                var currentIndex = $(e.target).closest('tr').data().index


                //旧模型
                var oldSmSystemWorkFlowStaticTableObj = $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('getData')[currentIndex];
                oldSmSystemWorkFlowStaticTableObj.CreateTime = "";

                //新模型

                var DeptId = $tds.find(".DeptId-edit").val();
                var DeptName = $tds.find(".DeptName-edit option:selected").text();
                var WorkFlowId = $tds.find(".stepid-edit").val();
                var WorkFlowName = $tds.find(".workflowname-edit").val();
                var SmType = $tds.find(".sm-type-edit option:selected").val();
                var SubType = $tds.find(".sub-type-edit option:selected").val();
                var ActivityFlag = $tds.find(".activityflag-edit").val();

                var smWorkFlowStaticObj = new SmWorkFlowStaticObj();
                smWorkFlowStaticObj.DeptId = DeptId;
                smWorkFlowStaticObj.DeptName = DeptName;
                smWorkFlowStaticObj.WorkFlowId = WorkFlowId;
                smWorkFlowStaticObj.WorkFlowName = WorkFlowName;
                smWorkFlowStaticObj.SmType = SmType;
                smWorkFlowStaticObj.SubType = SubType;
                smWorkFlowStaticObj.ActivityFlag = oldSmSystemWorkFlowStaticTableObj.ActivityFlag;
                var smWorkFlowStaticEntity = '{"smWorkFlowStaticEntity":'
                    + JSON.stringify(smWorkFlowStaticObj)
                    + ',"oldSmSystemWorkFlowStaticTableObj":' + JSON.stringify(oldSmSystemWorkFlowStaticTableObj) + '}';

                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/EditSmWorkFlowStatic",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: smWorkFlowStaticEntity,

                    success: function (message) {
                        if (message.d.status === "1") {
                            showTips(message.d.message, "alert-success", "alert-danger");

                            //var json = JSON.parse(message.d.data);
                            //smBasicDataDeptDefaultLeaderEntityObj.DeptName = json.DeptName;
                            //smBasicDataDeptDefaultLeaderEntityObj.LeaderUserName = json.LeaderUserName;
                            //smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptId = json.LeaderDeptId;
                            //smBasicDataDeptDefaultLeaderEntityObj.LeaderDeptName = json.LeaderDeptName;
                            $('#SmSystemWorkFlowStatic_Origin').bootstrapTable('updateRow', { index: currentIndex, row: smWorkFlowStaticObj });
                            $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')

                        } else {
                            $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                            showTips(message.d.message, "alert-danger", "alert-success");
                        }
                    },
                    error: function (message) {
                        $("#SmSystemWorkFlowStatic_Origin").bootstrapTable('refresh')
                        showTips(message.responseText, "alert-danger", "alert-success");
                    }
                });
            }


            function SmWorkFlowStaticObj() {

                var smWorkFlowStaticObj = new Object();
                smWorkFlowStaticObj.DeptId = "";
                smWorkFlowStaticObj.DeptName = "";
                smWorkFlowStaticObj.WorkFlowId = "";
                smWorkFlowStaticObj.WorkFlowName = "";
                smWorkFlowStaticObj.SmType = "";
                smWorkFlowStaticObj.SubType = "";
                smWorkFlowStaticObj.ActivityFlag =0;
                return smWorkFlowStaticObj;
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
