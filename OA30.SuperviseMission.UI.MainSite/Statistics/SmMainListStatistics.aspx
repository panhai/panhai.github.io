<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmMainListStatistics.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.Statistics.SmMainListStatistics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督办系统-报表</title>
    <style type="text/css">
         .search-part {
            margin-top:0px;
        }
        .search-part .search-control-2 {
            margin-top:0;
        }
        .search-part .search-control-2 .dropdown-menu {
            padding-left: 10px;
            width: 87%;
            margin-left: 15px;
        }
        .search-part .search-control-2 .btn-group{
            margin:0;
        }
        .search-part .search-control-2 .dc .dropdown-menu {
            padding-left: 0;
            width: 100%;
            margin-left: 0;
        }
        .search-part .search-control-2 .row+.row+.form-group {
            padding-bottom: 15px;
        }
        .md {
        padding-right:0;
        }
        .search-part .search-control-2 .md .dropdown-menu{
            padding-left:0;
            margin-left:0;
        }
        .da label.control-label{
            width:21%;
        }
        .dd .control-label {
            margin-left:-15px;
        }
        .search-part .search-control-2 .time-create.dd .form-group .control-label + div,.search-part .search-control-2 .time-create.dd .form-group .control-label + div + label + div{
            width:38%;
        }
        .table-bordered > thead > tr > th, .table-bordered > tbody > tr > th, .table-bordered > tfoot > tr > th, .table-bordered > thead > tr > td, .table-bordered > tbody > tr > td, .table-bordered > tfoot > tr > td {
        border:1px solid #e5e5e5;
        }
        .search-control-2 .row .col:first-child {
            margin-left:-10px;
         }
        .table-page .table.table-static-width {
            width:auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="hidden">
            <asp:HiddenField ID="isRoleLimit" runat="server" />
        </div>


        <div class="main">
            
            <div class="search-part search-part-2">
                <div class="search-control-2">
                    <div class="row">
                        <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-4 col-xs-4 col-md-4 col-lg-4 control-label">文档ID</label>
                                <div class="col-sm-8 col-xs-8 col-md-8 col-lg-8 dropdown dc">
                                    <input type="text" id="smId" name="smId" class="form-control" placeholder="请输入文档ID" />
                                    
                                </div>
                            </div>
                            <div class="form-group clearfix dropdown">
                                <label for="" class="col-sm-4 col-xs-4 col-md-4 col-lg-4 control-label">督查任务类型</label>
                                <div class="col-sm-8 col-xs-8 col-md-8 col-lg-8">
                                    <input type="text" class="form-control" placeholder="督查任务类型" data-toggle="dropdown" role="button" name="radioText" />
                                    <span class="iconfont icon-sv-add form-control-feedback" aria-hidden="true" data-toggle="dropdown" role="button"></span>
                                    <ul class="list-unstyled dropdown-menu" id="smtype" aria-labelledby="dLabel">
                                        <li>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="radio" value="" />
                                                    全部类型</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="radio" value="ND" />
                                                    年度重点工作任务</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="radio" value="LD" />
                                                    领导行政例会督查</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="radio" value="ZJ" />
                                                    总经理办公会督查</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="radio" value="QT" />
                                                    其他重要工作督查</label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-4 col-xs-4 col-md-4 col-lg-4 control-label">主管领导</label>
                                <div class="col-sm-8 col-xs-8 col-md-8 col-lg-8">
                                    <input type="text" class="form-control" id="" name="leader" placeholder="主管领导" />
                                </div>
                            </div>
                            <div class="form-group clearfix status-col dropdown">
                                <label for="" class="col-sm-4 col-xs-4 col-md-4 col-lg-4 control-label">关键词搜索</label>
                                <div class="col-sm-8 col-xs-8 col-md-8 col-lg-8">
                                    <input type="text" class="form-control" id="" name="keyword" placeholder="关键词搜索" />
                                </div>
                            </div>
                        </div>
                        <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-3 col-xs-3 col-md-3 col-lg-3 control-label">协管领导</label>
                                <div class="col-sm-9 col-xs-9 col-md-9 col-lg-9">
                                    <input type="text" class="form-control" name="leader2" id="" placeholder="协管领导" />
                                </div>
                            </div>
                            <div class="form-group clearfix status-col dropdown">
                                <label for="" class="col-sm-3 col-xs-3 col-md-3 col-lg-3 control-label">状态</label>
                                <div class="col-sm-9 col-xs-9 col-md-9 col-lg-9 stb">
                                    <input type="text" name="statusText" class="form-control" id="inputStatus" placeholder="请选择状态" data-toggle="dropdown" role="button" />
                                    <span class="iconfont icon-sv-add form-control-feedback" aria-hidden="true" data-toggle="dropdown" role="button"></span>
                                    <ul class="list-unstyled dropdown-menu">
                                        <li style="display:none;">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="NG" />
                                                    拟稿</label>
                                            </div>
                                        </li>
                                        <li style="display:none;">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="FJ" />
                                                    任务分解中</label>
                                            </div>
                                        </li>
                                        <li style="display:none;">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="SP" />
                                                    分解审批中</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="QR" />
                                                    任务确认中</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="TJ" />
                                                    任务推进中</label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="status" class="cbMissionStatus" value="BJ" />
                                                    任务办结</label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 da">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-4 col-md-4 col-xs-4 col-lg-4 control-label">主办单位</label>
                                <div class="col-sm-8 col-md-8 col-xs-8 col-lg-8 dropdown md">
                                    <select name="unit" data-live-search="true" class="selectpicker form-control">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 time-create da dd">
                            <div class="form-group clearfix">
                                <label for="" class="col-sm-4 col-md-4 col-xs-4 col-lg-4 control-label">创建时间</label>
                                <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4">
                                    <input type="text" class="form-control input-time" id="beginDate" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" placeholder="请选择创建时间" name="startTime" />
                                </div>
                                <label>至</label>
                                <div class="col-sm-4 col-md-4 col-xs-4 col-lg-4">
                                    <input type="text" class="form-control input-time" id="endDate" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" placeholder="请选择创建时间" name="endTime" />
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" style="text-align: right; margin-right: 20px;">
                        <button class="btn btn-primary-s btn-group search-btn">查询</button>
                        <button class="btn btn-default-s btn-group clear-btn">清空</button>
                        <button class="btn btn-default-s btn-group import-btn">导出</button>
                    </div>
                </div>
            </div>

            <div class="table-page">
                <table class="table table-bordered table-static-width" id="pageList" style="display: none;">
                    <thead>
                        <tr>
                            <th style="width: 3%">序号</th>
                            <%--<th style="width: 140px">督查编号</th>--%>
                            <th style="width: 14%">年度重点工作任务</th>
                            <th style="width: 9.3%">一级目标</th>
                            <th style="width: 9.3%;">任务进度</th>
                            <th style="width: 9.3%;">反馈情况</th>
                            <th style="width: 9.3%">主办单位</th>
                            <th style="width: 9.3%">二级目标</th>
                            <th style="width: 5%;">任务进度</th>
                            <th style="width: 9.3%">反馈情况</th>
                            <th style="width: 9.3%">责任处室</th>
                            <th style="width: 9.3%;">完成时限</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%--  <%= ReturnStr() %>--%>
                    </tbody>
                </table>
            </div>
            <div class="tar">
                <nav aria-label="Page navigation" class="pagination">
                </nav>

            </div>
        </div>
        
        <script>
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
         require(['jquery','toast','AJAX', 'state', 'cs-page','bootstrap','picker','bootstrap-select'], function ($,layer,Ajax,state) {
             $(function () {
                 //全局搜索条件 
                 var searchFilters = {
                     company: '',
                     companyText: '',
                     leader: '',
                     leader2: '',
                     task: '',
                     keyword: '',
                     status: [],
                     statusText: [],
                     smId: '',
                     startTime: '',
                     endTime: '',
                     radio: '',
                     radioText: ''
                 }

                 //每页分页数量
                 var pageSize = 10;

                 //加loading
                 //var index = layer.load(0, { shade: false });
                 var pageLoadIndex;
                 //页面第一次加载事件
                 $(document).ready(function () {
                     var isRoleLimit = $("#isRoleLimit").val();
                     if (isRoleLimit != "1") {
                         alert("权限不够");
                         return false;
                     }
                     //绑定部门
                     ViewDept(fDepts);
                     //getDeptListData();

                     //defaultLoadData();
                     appendNone($(".table-page"));
                 });
                 //获取接口
                 var getDeptListData = function () {
                     Ajax({ FunName: 'DeptList', async: true, callback: ViewDept, data: null });
                 }

                 //绑定部门下拉列表
                 var ViewDept = function (data, cfg) {
                     var el = $(".selectpicker").empty();
                     //var list = JSON.parse(data.data);
                     var list = data;
                     if (list && list.length > 0) {
                         var lihtml = ''
                         for (var i = 0; i < list.length; i++) {
                             var item = list[i];
                             lihtml += '<option name="company" value="' + (item.DeptName == "全部" ? "" : (item.DeptId || "")) + '">' + (item.DeptName || "") + '</option>';
                         }
                         el.append(lihtml);
                     }
                     //筛选控件
                     $('.selectpicker').selectpicker('refresh');
                 }
                 //选择部门
                 $('.selectpicker').on('changed.bs.select', function (e) {
                     searchFilters.company = $(this).val();
                 });

                 //基础搜索函数
                 var SearchPageData = function (pageIndex, isFristSearch) {
                     pageIndex = pageIndex || 1;
                     if (searchFilters.startTime && searchFilters.endTime) {
                         if (new Date(searchFilters.startTime.replace(/-/g, "/")).getTime() > new Date(searchFilters.endTime.replace(/-/g, "/")).getTime()) {
                             alert('请假时间的开始时间不能大于结束时间');
                             return false;
                         }
                     }
                     var statisticsPageListRequestEntity = {
                         PageIndex: pageIndex,
                         PageSize: pageSize,
                         MainDeptId: searchFilters.company == 0 ? '':searchFilters.company,
                         KeyWord: searchFilters.keyword,
                         BeginDate: searchFilters.startTime,
                         EndDate: searchFilters.endTime,
                         SmId: searchFilters.smId,
                         SmType: searchFilters.task,
                         MissionStatus: searchFilters.status.join("|"),
                         MainLeaderName: searchFilters.leader,
                         AssistLeaderName: searchFilters.leader2,
                     };
                     var postdata = {
                         statisticsPageListRequestEntity: statisticsPageListRequestEntity
                     };
                     var ret = Ajax({ FunName: 'GetStatisticSMListByPage', async: true, callback: ViewListData, data: postdata, isFristSearch: (isFristSearch || false) });
                 }

                 //初次加载数据函数
                 var defaultLoadData = function () {

                     var statisticsPageListRequestEntity = {
                         PageIndex: 1,
                         PageSize: pageSize,
                     };
                     var postdata = {
                         statisticsPageListRequestEntity: statisticsPageListRequestEntity
                     };
                     var ret = Ajax({ FunName: 'GetStatisticSMListByPage', async: true, callback: ViewListData, data: postdata, isFristSearch: true });
                 };
                 

                 //填充数据，分页
                 var ViewListData = function (data, cfg) {
                     var el = $("#pageList tbody").empty();
                     var ele = $(".table-page");
                     var page = $(".pagination");
                     var nodata = $(".no-page");
                     if (nodata) {
                         nodata.remove();
                     }
                     
                     if (data.data && data.data.length > 0) {
                         $("#pageList").show()
                         el.html(data.data);
                         //console.log(data.TotalCount)
                         //console.log(cfg.data.pageSize)
                         //console.log(cfg.isFristSearch)
                         //console.log(cfg.isFristSearch && data.TotalCount > cfg.data.statisticsPageListRequestEntity.PageSize)
                         //初始化分页
                         if (cfg.isFristSearch) {
                             //需要重置分页
                             if (data.TotalCount > cfg.data.statisticsPageListRequestEntity.PageSize) {
                                 page.show();
                                 $('.pagination').csPage({
                                     totalCounts: data.TotalCount,
                                     pageSize: pageSize,
                                     currentPage: 1,
                                     onPageChange: function (num, type) {
                                         pageLoadIndex = layer.load(0, { shade: false });
                                         if (type !== 'init') {
                                             SearchPageData(num, false);
                                         }
                                     }
                                 });
                             }
                             else {
                                 page.hide();
                             }
                         }
                     }
                     else {
                         appendNone(ele);
                         if (cfg.isFristSearch) {
                             page.hide();
                         }
                     }
                     layer.close(index);
                     layer.close(pageLoadIndex);
                 }
                 //无数据展示
                 var appendNone = function (el) {
                     $("#pageList").hide()
                     $(el).css('overflow-x', 'hidden')
                     var html = '<div class="no-page"><div class="no-search-icon"></div><p>暂无查询结果</p></div>';
                     $(el).append(html);
                 }
                 //下拉框不消失
                 $(document).on('click', function (e) {
                     var target = $(e.target)
                     if (target.closest('.stb').length === 1) {
                         $('#inputStatus').dropdown('toggle')
                         target.closest('.stb').addClass('open')
                     }
                 })
                 //下拉框状态值改变事件
                 $(document).on('change', '.dropdown-menu input', function (e) {
                     var event = $(e.target)
                     if (event.closest('.checkbox').hasClass('checkbox')) {
                         var status = []
                         event.closest('.dropdown-menu').find('input').each(function (item) {
                             var text = event.closest('label').text().trim()
                             if ($(this).is(':checked')) {
                                 status.push($(this).closest('label').text().trim())
                             }
                         })
                         event.closest('.dropdown').find('.form-control').val(status.toString())
                     } else {
                         event.closest('.dropdown').find('.form-control').val(event.closest('label').text().trim())
                     }
                 })

                 $(document).on('click', '.import-btn', function (e) {
                     var isRoleLimit = $("#isRoleLimit").val();
                     if (isRoleLimit != "1") {
                         alert("权限不够");
                         return false;
                     }

                     var event = $(e.target)
                     var html = ''
                     event.closest('.search-control-2').find('input').each(function () {
                         var type = $(this).attr('type')
                         var name = $(this).attr('name')
                         var value = $(this).val()
                         if (name) {
                             switch (type) {
                                 case 'text':
                                     searchFilters[name] = value
                                     break;
                                 case 'checkbox':
                                     if ($(this).is(':checked') && $.inArray(value, searchFilters.status) < 0) {
                                         searchFilters.status.push(value)
                                         searchFilters[name + 'Text'] = $('input[name="' + name + 'Text"]').val()
                                     }
                                     break;
                                 case 'radio':
                                     if ($(this).is(':checked')) {
                                         searchFilters[name] = value
                                         searchFilters[name + 'Text'] = $('input[name="' + name + 'Text"]').val()
                                     }
                                     break;
                                 default:
                                     searchFilters[name] = value
                                     break;
                             }
                         }
                     })

                     var statisticsPageListRequestEntity = {
                         MainDeptId: searchFilters.company,
                         KeyWord: searchFilters.keyword,
                         BeginDate: searchFilters.startTime,
                         EndDate: searchFilters.endTime,
                         SmId: searchFilters.smId,
                         SmType: searchFilters.task,
                         MissionStatus: searchFilters.status.join("|"),
                         MainLeaderName: searchFilters.leader,
                         AssistLeaderName: searchFilters.leader2,
                     };
                     var parms = "MainDeptId=" + statisticsPageListRequestEntity.MainDeptId
                     parms += "&KeyWord=" + statisticsPageListRequestEntity.KeyWord
                     parms += "&BeginDate=" + statisticsPageListRequestEntity.BeginDate
                     parms += "&EndDate=" + statisticsPageListRequestEntity.EndDate
                     parms += "&SmId=" + statisticsPageListRequestEntity.SmId
                     parms += "&SmType=" + statisticsPageListRequestEntity.SmType
                     parms += "&MissionStatus=" + statisticsPageListRequestEntity.MissionStatus
                     parms += "&MainLeaderName=" + statisticsPageListRequestEntity.MainLeaderName
                     parms += "&AssistLeaderName=" + statisticsPageListRequestEntity.AssistLeaderName
                     window.open("Statistics/Export.ToExcel.aspx?" + parms);
                     return false;
                 });
                 //回车查询
                 $(document).keydown(function (event) {
                     var $this = $(event.target)
                     if (event.keyCode == 13) {
                         $('.search-btn').trigger('click')
                     }
                 });
                 //查询按钮事件
                 $(document).on('click', '.search-btn', function (e) {
                     index = layer.load(0, { shade: false });
                     var isRoleLimit = $("#isRoleLimit").val();
                     if (isRoleLimit != "1") {
                         alert("权限不够");
                         return false;
                     }

                     var event = $(e.target)
                     var html = ''
                     event.closest('.search-control-2').find('input').each(function () {
                         var type = $(this).attr('type')
                         var name = $(this).attr('name')
                         var value = $(this).val()
                         if (name) {
                             switch (type) {
                                 case 'text':
                                     searchFilters[name] = value
                                     break;
                                 case 'checkbox':
                                     if ($(this).is(':checked') && $.inArray(value, searchFilters.status) < 0) {
                                         searchFilters.status.push(value)
                                         searchFilters[name + 'Text'] = $('input[name="' + name + 'Text"]').val()
                                     }
                                     break;
                                 case 'radio':
                                     if ($(this).is(':checked')) {
                                         searchFilters[name] = value
                                         searchFilters[name + 'Text'] = $('input[name="' + name + 'Text"]').val()
                                     }
                                     break;
                                 default:
                                     searchFilters[name] = value
                                     break;
                             }
                         }
                     })
                     SearchPageData(1, true);

                     return false
                 })
                 //下拉框，清除选中
                 $(document).on('click', '.checkbox input[type="checkbox"]', function (e) {
                     var status = searchFilters.status
                     status.splice(status.indexOf($(this).val()), 1)
                 })
                 //清空按钮事件
                 $(document).on('click', '.clear-btn', function (e) {
                     var event = e || window.event;
                     var target= event.target || event.srcElement; //获取document 对象的引用 
                     $this = $(target)
                     $this.closest('.search-control-2').find('input[type="text"]').each(function () {
                         $(this).val('')
                     })
                     $this.closest('.search-control-2').find('input[type="checkbox"],input[type="radio"]').each(function () {
                         $(this).prop('checked', false)
                     });
                     $('.selectpicker').selectpicker('refresh');
                     $('.selectpicker').selectpicker('val', ['noneSelectedText']);
                     searchFilters = {
                         company: '',
                         companyText: '',
                         leader: '',
                         leader2: '',
                         task: '',
                         keyword: '',
                         status: [],
                         statusText: [],
                         smId: '',
                         startTime: '',
                         endTime: '',
                         radio: '',
                         radioText: ''
                     }
                     return false;
                 })

                 //日历控件
                 $('.input-time').datetimepicker({
                     language: 'zh-CN',
                     weekStart: 1,
                     clearBtn: 1,
                     autoclose: 1,
                     todayHighlight: 1,
                     startView: 2,
                     minView: 2,
                     forceParse: 0
                 });
             });
             


         })
        </script>
    </form>
</body>
</html>
