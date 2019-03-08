<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionDetail.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionDetail" %>

<!DOCTYPE html>
<% int page = this.page; %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查系统</title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <!--[if  IE 8]>
	<link rel="stylesheet" type="text/css" href="Css/ie.css" />
	<![endif]-->
    <style type="text/css">
        .form-group textarea {
            resize: none !important;
        }

        .buttons {
            margin-bottom: 20px;
        }

            .buttons button {
                background: #15497d;
                color: #fff;
                border-radius: 5px;
                margin-right: 10px;
            }

        .pmgb {
            padding-bottom: 10px;
            margin-top: -30px;
        }

        label {
            font-weight: 500;
        }

        p {
            font-size: 12px;
            margin: 0;
        }

        .detail-col {
            font-size: 12px;
            /*margin-top: 8px;#10431*/
        }

        .detail-box h3 {
            font-size: 14px;
        }

            .detail-box h3.c {
                font-size: 16px;
            }

        .detail-part {
        }

        .detail-line {
            border-bottom: 1px dashed #e5e5e5;
        }

        .card .card-body .form-child .col-sm-4 label {
            width: auto;
        }

        .form-group {
            margin-bottom: 5px;
        }
        /*#10431*/
        .supervise-md-box {
            margin-left: -5px !important;
        }

        .detail-col span:first-child {
            color: #959fab !important;
        }

        .detail-part + .detail-box {
            margin-top: 15px;
        }
        /*奇怪的page 12页面设置字体大小*/
        .card-body .form-block .form-group > span {
            font-size: 12px;
        }

        .step-child .card-body .form-child .form-group > span {
            font-size: 12px;
        }

        .card-body .form-child .form-group .col > span, .card-body .form-child .form-group .col > label {
            font-size: 12px;
        }

        .col > input {
            font-size: 12px;
        }

        .detail-block + .detail-block > .f {
            display: none;
        }

        span.iconfont.icon-sv-trash.delete-flag {
            font-size: 18.4px;
            padding: 5px 9px;
        }
    </style>
</head>
<body>
    <div class="main main2">
        <!--撤回-->
        <% if (page == 1)
            { %>
        <div class="tal buttons" style="display: block; height: 28px">
            <button class="btn btn-primary-s <%=!IsYiBan()?" hide":""%>" type="button" id="rollBackPage1">撤回</button>
            <%--<button class="btn btn-default-s" type="button">导出</button>
            <button class="btn btn-default-s" type="button">打印</button>--%>
            <button class="btn btn-default-s tal-head-right" type="button">切换图表</button>
        </div>
        <% } %>
        <!--end撤回-->

        <!--公共详情-->
        <div class="card">
            <div class="card-header card-header-line">
                <h3 class="title">详情</h3>
                <span class="iconfont-title"></span>
            </div>
            <div class="card-body">
                <div class="clearfix detial-info">
                    <ul class="list-unstyled">
                        <li>
                            <div class="row dib-special">
                                <label class="dib">任务内容：</label>
                                <span class="dib">
                                    <asp:Label ID="LbTaskContent" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <div class="col-lg-4 col-xs-4 col-sm-4 col-md-4">
                                    <label>督查编号：</label>
                                    <span>
                                        <asp:Label ID="LbSpNum" runat="server" Text=""></asp:Label></span>
                                </div>
                                <div class="col-lg-8 col-xs-8 col-sm-8 col-md-8">
                                    <label>文档ID：</label>
                                    <span>
                                        <asp:Label ID="LbSmId" runat="server" Text=""></asp:Label></span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">主管领导：</label>
                                <span class="dib">
                                    <asp:Label ID="LbMainLeader" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">协管领导：</label>
                                <span class="dib">
                                    <asp:Label ID="LbAssLeader" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">主办单位：</label>
                                <span class="dib">
                                    <asp:Label ID="LbMainDept" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">协办单位：</label>
                                <span class="dib">
                                    <asp:Label ID="LbAssDept" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!--end公共详情-->

        <% if (page == 1)
            { %>
        <!--督查任务进入-->
        <div style="display: block">
            <div style="display: block">
                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                    <ItemTemplate>
                        <div class="detail-box">
                            <div class="detail-part detail-line">
                                <h3 class="c">年度目标<%=GetPostfix(0)%></h3>
                                <p><%#Eval("TargetName") %></p>
                                <div class="detail-col">
                                    <div class="col">
                                        <span>主办单位</span>
                                        <span><%#Eval("MainDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                    </div>
                                </div>
                                <div class="detail-block">
                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                                </div>
                            </div>
                            <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub pr detail-line">
                                        <h3><span class="line line-primary"></span>措施<%=GetPostfix(1)%></h3>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsMainDept(Convert.ToString(Eval("TargetId")))&&!IsDutyDept(Convert.ToString(Eval("ItemId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom">
                                                变更申请
                                            </button>
                                            <div class="rb">
                                                <div class="button-group">
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">
                                                历史记录
                                            </button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="detail-col detail-col-2">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span><%#Eval("DutyDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成进度</span>
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block">
                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),1)%></p>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    </div>
                                    <asp:Repeater ID="Repeater1_1_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-part detail-part-sub2 pr detail-line">
                                                <h3><span class="line line-success"></span>子措施<%=GetPostfix(2)%></h3>
                                                <div class="tar rc rr">
                                                    <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsDutyDept(Convert.ToString(Eval("ParentTargetItemId")))&&!IsExcutor(Convert.ToString(Eval("ExcutorId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom">变更申请</button>
                                                    <div class="rb">
                                                        <div class="button-group">
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tar rc rr">
                                                    <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">
                                                        历史记录
                                                    </button>
                                                    <div class="rb">
                                                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>">操作记录</button>
                                                        <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                    </div>
                                                </div>
                                                <p><%#Eval("ItemName") %></p>
                                                <div class="detail-col detail-col-2">
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任人</span>
                                                        <span><%#Eval("ExcutorName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),1) %></p>
                                                </div>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="tar">
                    <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#feedback">反馈记录</button>
                    <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-page="1" data-target="#opera">操作记录</button>
                </div>
            </div>
        </div>
        <!--end督查任务进入-->
        <% } %>

        <% if (page == 2)
            { %>
        <!--办公厅目标确认-->
        <div style="display: block">
            <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%# GetIndexForTarget() %></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater2_2" runat="server" OnItemDataBound="Repeater2_2_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub detail-line">
                                    <h3><span class="line line-primary"></span>措施<%# GetIndexForTargetItem(Eval("TargetId").ToString()) %></h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-1">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),2)%></p>
                                    </div>
                                </div>
                                <asp:Repeater ID="Repeater2_2_2" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 detail-line">
                                            <h3><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %></h3>
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-1">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span><%#Eval("ExcutorName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成进度</span>
                                                    <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                </div>
                                            </div>
                                            <div class="detail-block">
                                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),2)%></p>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="card">
                <div class="card-header">
                    <div class="notice">
                        <h3 class="font-lg">督查定时反馈提醒</h3>
                        <div class="info">
                            <div class="radio">
                                <label>
                                    <input type="radio" name="notice2" value="-1" checked="checked" />
                                    不做提醒
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input checked="checked" type="radio" name="notice2" value="2" />
                                    每两个月提醒一次（60天）
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="notice2" value="4" />
                                    <span>每月</span>
                                    <input type="text" name="everymonth" value="" />
                                    <span>号</span>
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="notice2" value="3" />
                                    <span>自定义&nbsp;每</span>
                                    <input type="text" name="day2" value="12" />
                                    <span>天提醒一次</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="opinion-type"></div>
                        <label class="font-lg">审批意见</label>
                        <textarea class="form-control thx" id="textarea2"></textarea>
                    </div>
                </div>
            </div>
            <div class="tar rc">
                <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
            </div>
            <div class="form-group tac">
                <button type="button" class="btn btn-primary-c" name="btn2" id="btn2Agree">同意</button>
                <button type="button" class="btn btn-default-c" data-toggle="modal" data-target="#disagreeModal">不同意</button>
            </div>
        </div>
        <!--不同意弹窗-->
        <div class="modal fade feedback" tabindex="-1" role="dialog" id="disagreeModal">
            <div class="modal-dialog" role="document" style="width: 400px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">选择退回主办单位</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group check-ele" id="page2ReturnDept">
                        </div>
                        <div class="form-group tac">
                            <button type="button" class="btn btn-primary-s" name="btn2" id="btn2DisAgree">确定</button>
                            <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end不同意弹窗-->
        <!--end办公厅目标确认->
        <% } %>

        <% if (page == 3)
            { %>
        <!--办公厅任务反馈-->
        <div style="display: block">
            <div class="detail-box">
                <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                    <ItemTemplate>
                        <div class="card-box card card-box-1" style="margin-top: 0px; padding-bottom: 0px">
                            <div class="supervise-md-box card-header">
                                <div class="detail-part">
                                    <h3 class="c">年度目标<%=GetPostfix(0)%> &nbsp&nbsp <%#Eval("TargetId")%></h3>
                                    <p><%#Eval("TargetName")%></p>
                                    <div class="tar r">
                                        <button type="button" class="btn btn-second-s<%#GetWaitingFlowIdByTargetId(Convert.ToString(Eval("TargetId")),"BGTRWFK")==""?" hide":""%>" data-toggle="modal" data-targetid="<%#Eval("TargetId")%>" data-flowid='<%#GetWaitingFlowIdByTargetId(Convert.ToString(Eval("TargetId")),"BGTRWFK") %>' data-target="#backModal3">退回</button>
                                    </div>
                                </div>
                            </div>

                            <div class="card-body  detail-line">
                                <div class="detail-col detail-col">
                                    <div class="col">
                                        <span>主办单位</span>
                                        <span><%#Eval("MainDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="c-danger"><%#Eval("TargetPercent") %>%</span>
                                    </div>
                                </div>
                                <div class="detail-block">
                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId"))) %></p>
                                </div>
                            </div>
                            <a class="cs" role="button" data-toggle="collapse" href="#collapse1-<%#Eval("TargetId")%>" aria-expanded="false" data-status="hide">展开></a>
                            <div class="collapse" id="collapse1-<%#Eval("TargetId")%>">
                                <asp:Repeater ID="Repeater3_3" runat="server" OnItemDataBound="Repeater3_3_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub pr detail-line">
                                            <h3><span class="line line-primary"></span>措施<%=GetPostfix(1)%>&nbsp&nbsp <%#Eval("ItemId")%></h3>
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsMainDept(Convert.ToString(Eval("TargetId")))&&!IsDutyDept(Convert.ToString(Eval("ItemId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                    变更申请
                                                </button>
                                                <div class="rb">
                                                    <div class="button-group">
                                                        <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                        <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                        <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                        <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                    历史记录
                                                </button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>" data-target="#opera">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任处室</span>
                                                    <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成进度</span>
                                                    <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                </div>
                                            </div>
                                            <div class="detail-block">
                                                <p class="f">
                                                    <span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),3)%>
                                                    <span class="db">
                                                        <span class="iconfont icon-sv-trial"></span><%#GetLastAuditingOpinionByItemId(Convert.ToString(Eval("ItemId")))%>
                                                    </span>
                                                </p>
                                            </div>
                                            <%--qq这是测试附件--%>
                                            <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        </div>
                                        <asp:Repeater ID="Repeater3_3_3" runat="server">
                                            <ItemTemplate>
                                                <div class="detail-part detail-part-sub2 pr detail-line">
                                                    <h3><span class="line line-success"></span>子措施<%=GetPostfix(2)%></h3>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsDutyDept(Convert.ToString(Eval("ParentTargetItemId")))&&!IsExcutor(Convert.ToString(Eval("ExcutorId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                            变更申请
                                                        </button>
                                                        <div class="rb">
                                                            <div class="button-group">
                                                                <button type="button" class="btn btn-default-s">办结申请</button>
                                                                <button type="button" class="btn btn-default-s">延期申请</button>
                                                                <button type="button" class="btn btn-default-s">中止申请</button>
                                                                <button type="button" class="btn btn-default-s">调整申请</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                            历史记录
                                                        </button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId")%>" data-targetitemid="<%#Eval("ItemId")%>">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                    </div>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成进度</span>
                                                            <span class="process"><%#Eval("FinshPercent")%>%</span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),3) %></p>
                                                    </div>
                                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
            <div class="tar rc">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-itemid="">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
            </div>
            <div class="form-group tac">
                <button type="button" class='btn btn-primary-c<%=IsSubmitAllTarget()?"":" hide" %>' data-toggle="modal" data-target="#agreeModal">同意</button>
            </div>
            <!--退回弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="backModal3">
                <div class="modal-dialog" role="document" style="width: 400px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <p>
                                    请填写退回理由
                                </p>
                                <textarea class="form-control thx" id="backReason3"></textarea>
                                <!--当前要退回的目标Id。-->
                                <input type="hidden" id="backTargetId3" />
                                <!--当前要退回的目标的待办流程Id。-->
                                <input type="hidden" id="backFlowId3" />
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-sure="agree">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end退回弹窗-->
            <!--同意弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModal">
                <div class="modal-dialog" role="document" style="width: 650px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body modal-form">
                            <div class="form-group">
                                <p>
                                    任务进度<span class="c-danger">（*）</span>
                                </p>
                                <input class="form-control" type="text" id="finishPercent3" data-type="num" />
                            </div>
                            <div class="form-group">
                                <p>
                                    反馈意见<span class="c-danger">（*）</span>
                                </p>
                                <textarea class="form-control thx" id="opinion3"></textarea>
                            </div>
                            <p>请选择下一步骤</p>
                            <div class="b">
                                <div class="l si">
                                    <p>选择发送</p>
                                    <ul class="list-unstyled" role="tablist" id="stepItem3"></ul>
                                </div>
                                <div class="r">
                                    <p>已选择</p>
                                    <div class="tab-content" id="userItem3">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" id="surePage3">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            </div>

                            <!--当前任务对应的流程部门Id。-->
                            <input type="hidden" id="flowDeptId3" />
                        </div>
                    </div>
                </div>
            </div>
            <!--end同意弹窗-->
        </div>
        <!--end办公厅任务反馈-->
        <% } %>

        <% if (page == 4)
            { %>
        <!--领导审批-->
        <div style="display: block">
            <div class="detail-box">
                <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater4_ItemDataBound">
                    <ItemTemplate>
                        <div class="detail-box">
                            <div class="detail-part detail-line">
                                <h3 class="c">年度目标<%# GetIndexForTarget() %></h3>
                                <p><%#Eval("TargetName") %></p>
                                <div class="detail-col">
                                    <div class="col">
                                        <span>主办单位</span>
                                        <span><%#Eval("MainDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                    </div>
                                </div>
                                <div class="detail-block">
                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                                </div>
                            </div>
                            <asp:Repeater ID="Repeater4_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub detail-line">
                                        <h3><span class="line line-primary"></span>措施<%# GetIndexForTargetItem(Eval("TargetId").ToString()) %></h3>
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="detail-col detail-col-1">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span><%#Eval("DutyDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成进度</span>
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block">
                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),4)%></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="opinion-type"></div>
                    <div class="form-group">
                        <label class="font-lg">审批意见</label>
                        <textarea class="form-control thx" id="textarea4"></textarea>
                    </div>
                </div>
            </div>
            <div class="tar rc">
                <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
            </div>
            <div class="form-group tac">
                <button type="button" class="btn btn-primary-c" name="btn4" id="btn4Agree">同意</button>
                <button type="button" class="btn btn-default-c" name="btn4" id="btn4DisAgree">不同意</button>
            </div>
        </div>
        <!--end领导审批-->
        <% } %>

        <% if (page == 8)
            { %>
        <!--主办单位收到进度反馈-->
        <div style="display: block">
            <asp:Repeater ID="Repeater8" runat="server" OnItemDataBound="Repeater8_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%>&nbsp&nbsp<%#Eval("TargetId")%></h3>
                            <p><%#Eval("TargetName")%></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater8_8" runat="server" OnItemDataBound="Repeater8_8_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1) %> &nbsp&nbsp <%#Eval("ItemId")%>
                                    </h3>
                                    <div class="tar rc r">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>" data-target="#opera">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                        <%--需求说退回的是措施而不是子措施--%>
                                        <button type="button" class="btn btn-second-s<%#!IsMainDept(Convert.ToString(Eval("TargetId")))||GetWaitingFlowIdByItemId(Convert.ToString(Eval("ItemId")),"ZBDWMBFK")==""?" hide":"" %>" data-toggle="modal" data-itemid="<%#Eval("ItemId")%>" data-flowid='<%#GetWaitingFlowIdByItemId(Convert.ToString(Eval("ItemId")),"ZBDWMBFK") %>' data-target="#backModal8">退回</button>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f" style='<%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),8)!=""?"display:auto": "display:none"%>'>
                                            <span class="iconfont icon-sv-sound" style="color: #4aa2f7; margin-right: 10px; margin-left: 5px;"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),8)%>
                                            <span class="db">
                                                <span class="iconfont icon-sv-trial"></span><%#GetLastAuditingOpinionByItemId(Convert.ToString(Eval("ItemId")))%>
                                            </span>
                                        </p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <asp:Repeater ID="Repeater8_8_8" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<%=GetPostfix(2)%>&nbsp&nbsp<%#Eval("ItemId")%><span class="s"></span>
                                                    </h3>
                                                    <div class="tar rc r">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>" data-target="#opera">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                    </div>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成进度</span>
                                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                        <p class="f" style="<%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),8)!=""?"display:auto": "display:none"%>"><span class="iconfont icon-sv-sound" style="color: #4aa2f7; margin-right: 10px; margin-left: 5px;"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),8)%></p>
                                                    </div>
                                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="form-group tac">
                        <button type="button" class="btn btn-primary-c<%#GetWaitingFlowIdByTargetId(Convert.ToString(Eval("TargetId")),"ZBDWMBFK")!=""&&IsSubmitAllItem(Convert.ToString(Eval("TargetId")))?"":" hide"%>" data-toggle="modal" data-target=".agreeModal8" data-targetid="<%#Eval("TargetId")%>" data-flowid="<%#GetWaitingFlowIdByTargetId(Convert.ToString(Eval("TargetId")),"ZBDWMBFK")%>">同意</button>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="tar ">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-target="#opera" data-targetid="" data-targetitemid="">操作记录</button>
            </div>

            <!--退回弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="backModal8">
                <div class="modal-dialog" role="document" style="width: 400px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <p>
                                    请填写退回理由
                                </p>
                                <textarea class="form-control thx" id="backReason8"></textarea>
                                <!--当前退回的措施Id。-->
                                <input type="hidden" id="backItemId8" />
                                <!--当前退回措施对应的流程Id。-->
                                <input type="hidden" id="backFlowId8" />
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-sure="agree">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end退回弹窗-->
            <!--同意弹窗-->
            <div class="modal fade feedback agreeModal8" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document" style="width: 650px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body modal-form">
                            <div class="form-group">
                                <p>
                                    目标进度<span class="c-danger">（*）</span>
                                </p>
                                <input class="form-control" type="text" id="finishPercent8" data-type="num" />
                            </div>
                            <div class="form-group">
                                <p>
                                    反馈意见<span class="c-danger">（*）</span>
                                </p>
                                <textarea class="form-control thx" id="opinion8"></textarea>
                            </div>
                            <p>请选择下一步骤</p>
                            <div class="b">
                                <div class="l si">
                                    <p>选择发送</p>
                                    <ul class="list-unstyled" role="tablist" id="stepItem8"></ul>
                                </div>
                                <div class="r">
                                    <p>已选择</p>
                                    <div class="tab-content" id="userItem8"></div>
                                </div>
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" id="surePage8">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                                <!--当前任务对应的流程部门Id。-->
                                <input type="hidden" id="flowDeptId8" />
                                <!--当前点击同意的目标Id。-->
                                <input type="hidden" id="targetId8" />
                                <!--当前点击同意的目标的待办Id。-->
                                <input type="hidden" id="flowId8" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!--end同意弹窗-->
        </div>
        <!--end主办单位收到进度反馈-->
        <% } %>


        <% if (page == 9)
            { %>
        <!--责任处室措施反馈。-->
        <div style="display: block">
            <asp:Repeater ID="Repeater9" runat="server" OnItemDataBound="Repeater9_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%> &nbsp&nbsp<%#Eval("TargetId")%></h3>
                            <p><%#Eval("TargetName")%></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater9_9" runat="server" OnItemDataBound="Repeater9_9_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1)%> &nbsp&nbsp<%#Eval("ItemId")%>
                                    </h3>
                                    <div class="tar rc r">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId")%>" data-targetitemid="<%#Eval("ItemId")%>" data-target="#opera">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>

                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f">
                                            <span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),9)%>
                                            <span class="db">
                                               <span class="iconfont icon-sv-trial"></span><%#GetLastAuditingOpinionByItemId(Convert.ToString(Eval("ItemId")))%>
                                            </span>
                                        </p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <!--子措施。-->
                                    <asp:Repeater ID="Repeater9_9_9" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<%=GetPostfix(2)%>&nbsp&nbsp<%#Eval("ItemId")%><span class="s"></span>
                                                    </h3>
                                                    <div class="tar rc r">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>" data-target="#opera">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                        <button type="button" class="btn btn-second-s<%#!IsSameDeptByItemId(Convert.ToString(Eval("ParentTargetItemId")))||GetWaitingFlowIdByItemId(Convert.ToString(Eval("ItemId")),"ZRCSCSFK")==""?" hide":"" %> parent-item-id-<%#Eval("ParentTargetItemId")%>" data-toggle="modal" data-itemid="<%#Eval("ItemId")%>" data-flowid='<%#GetWaitingFlowIdByItemId(Convert.ToString(Eval("ItemId")),"ZRCSCSFK")%>' data-target="#backModal9">退回</button>
                                                    </div>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成进度</span>
                                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),9)%></p>
                                                    </div>
                                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <!--end子措施。-->
                                </div>
                            </div>
                            <!--同意按钮。-->
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-c<%#IsSameDeptByItemId(Convert.ToString(Eval("ItemId")))&&GetWaitingFlowIdByParentItemId(Convert.ToString(Eval("ItemId")),9)!=""&&IsSubmitAllChildItem(Convert.ToString(Eval("ItemId")))?"":" hide"%>" data-toggle="modal" data-target=".agreeModal9" data-targetid="<%#Eval("TargetId")%>" data-parentitemid='<%#Eval("ItemId")%>'>同意</button>
                            </div>
                            <!--end同意按钮。-->
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>

            <div class="tar">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
            </div>

            <!--退回弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="backModal9">
                <div class="modal-dialog" role="document" style="width: 400px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <p>
                                    请填写退回理由
                                </p>
                                <textarea class="form-control thx" id="backReason9"></textarea>
                                <!--当前退回子措施Id。-->
                                <input type="hidden" id="backItemId9" />
                                <!--当前退回子措施Id所在的待办流程Id。-->
                                <input type="hidden" id="backFlowId9" />
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-sure="agree">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end退回弹窗-->

            <!--同意弹窗-->
            <div class="modal fade feedback agreeModal9" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document" style="width: 650px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body modal-form">
                            <div class="form-group">
                                <p>
                                    措施进度<span class="c-danger">（*）</span>
                                </p>
                                <input class="form-control" type="text" id="finishPercent9" data-type="num" />
                            </div>
                            <div class="form-group">
                                <p>
                                    反馈意见<span class="c-danger">（*）</span>
                                </p>
                                <textarea class="form-control thx" id="opinion9"></textarea>
                            </div>
                            <p>请选择下一步骤</p>
                            <div class="b">
                                <div class="l si">
                                    <p>选择发送</p>
                                    <ul class="list-unstyled" role="tablist" id="stepItem9">
                                        <%--  <li role="presentation" class="active"><a href="#tab1" aria-controls="home" role="tab" data-toggle="tab">上报</a></li>
                                        <li role="presentation"><a href="#tab2" aria-controls="profile" role="tab" data-toggle="tab">审核</a></li>
                                        <li role="presentation"><a href="#tab3" aria-controls="messages" role="tab" data-toggle="tab">会签单位</a></li>
                                        <li role="presentation"><a href="#tab4" aria-controls="settings" role="tab" data-toggle="tab">审批</a></li>--%>
                                    </ul>
                                </div>
                                <div class="r">
                                    <p>已选择</p>
                                    <div class="tab-content" id="userItem9"></div>
                                </div>
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" id="surePage9">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                                <!--当前任务对应的流程部门Id。-->
                                <input type="hidden" id="flowDeptId9" />
                                <!--当前点击同意的目标Id和父措施Id。-->
                                <input type="hidden" id="targetId9" />
                                <input type="hidden" id="parentItemId9" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end同意弹窗-->
        </div>
        <!--end责任处室措施反馈。-->
        <% } %>

        <% if (page == 10)
            { %>
        <!--责任人-->
        <div style="display: block">
            <asp:Repeater ID="Repeater10" runat="server" OnItemDataBound="Repeater10_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%# GetIndexForTarget() %></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater10_1" runat="server" OnItemDataBound="Repeater10_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%# GetIndexForTargetItem(Eval("TargetId").ToString()) %>
                                    </h3>
                                    <div class="tar rc r">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%#Eval("FinshPercent")%>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),10)%></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <!--责任人为当前用户-->
                                    <asp:Repeater ID="Repeater10_1_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsDutyDept(Convert.ToString(Eval("ParentTargetItemId")))&&!IsExcutor(Convert.ToString(Eval("ExcutorId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom">
                                                            变更申请
                                                        </button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                                        </div>
                                                    </div>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%# Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责&nbsp;&nbsp;任&nbsp;&nbsp;人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                        <div class="<%#!IsMainDept(Convert.ToString(Eval("TargetId")))?"form-inline col":"form-group form-inline col" %>">
                                                            <span>完成进度</span>
                                                            <input data-type="num" id="<%#Eval("ItemId") %>_FinshPrecent" type="text" class="form-control" value="<%#Convert.ToInt32(Eval("FinshPercent"))==0?"":Eval("FinshPercent")%>" data-operate="true" data-operateid="<%#Eval("SubMeasureOperateIdIndex") %>" />
                                                        </div>
                                                        <div id="<%#Eval("SubMeasureOperateIdIndex") %>" style="display: none;">
                                                            <div class="form-group form-inline form-new">
                                                                <span class="cd">最新反馈</span><span class="c-danger">*</span>
                                                                <textarea id="<%#Eval("ItemId") %>_Opinion" class="form-control th4"><%#Eval("Opinion") %></textarea>
                                                            </div>
                                                            <div class="form-group form-inline form-new">
                                                                <span class="cd">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件</span>
                                                                <input type="file" data-targetitemid="<%#Eval("ItemId") %>" data-form-data="{'SmId': '<%#Eval("ItemId") %>'}" />
                                                                <button type="button" class="btn btn-default-sm" data-targetitemid="<%#Eval("ItemId") %>">上传附件</button>
                                                            </div>
                                                            <div class="file-list form-new">
                                                                <ul class="list-unstyled dci attchmentList" data-targetitemid="<%#Eval("ItemId") %>">
                                                                    <%--<li><a href="#">iniiidasdakda</a><span class="iconfont icon-sv-fail "></span>adfasfda.doc</li>
                                                                <li><span class="iconfont icon-sv-fail"></span>adfaasdfffffffffsfda.doc</li>
                                                                <li><span class="iconfont icon-sv-fail"></span>bbbbbbbbbbbbbbbbbbbb.doc</li>--%>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="button-group">
                                                    <button type="button" class="btn btn-primary-s btn10Submit" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-flowid="<%#Eval("FlowId") %>">进度反馈</button>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <!--责任人非当前用户-->
                                    <asp:Repeater ID="Repeater10_1_2" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">
                                                            历史记录
                                                        </button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%# Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                    </div>
                                                    <div id="<%#Eval("SubMeasureDetailIdIndex") %>" class="collapse">
                                                        <div class="detail-col detail-col-2">
                                                            <div class="col">
                                                                <span>协办单位</span>
                                                                <span><%#Eval("AssistDeptName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成时间</span>
                                                                <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>责任人</span>
                                                                <span><%#Eval("ExcutorName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成进度</span>
                                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                            </div>
                                                        </div>
                                                        <div class="detail-block">
                                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%#Eval("FinishTime") %>   <%#Eval("Opinion") %></p>
                                                        </div>
                                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                    </div>
                                                    <a data-toggle="collapse" href="#<%#Eval("SubMeasureDetailIdIndex") %>" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>

            <div class="tar">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-targetitemid="">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="" data-targetitemid="">操作记录</button>
            </div>
        </div>
        <!--办结弹窗-->
        <div class="modal fade feedback" tabindex="-1" role="dialog" id="finishModal">
            <div class="modal-dialog" role="document" style="width: 400px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">提示</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p>
                                确定要办结改措施吗？请填写理由
                            </p>
                            <textarea class="form-control th4"></textarea>
                        </div>
                        <div class="form-group tac">
                            <button type="button" class="btn btn-primary-s">确定</button>
                            <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end办结弹窗-->
        <!--end责任人-->
        <% } %>

        <% if (page == 11)
            { %>
        <!--措施反馈-->
        <div style="display: block">
            <asp:Repeater ID="Repeater11" runat="server" OnItemDataBound="Repeater11_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%>&nbsp&nbsp<%#Eval("TargetId")%></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater11_1" runat="server">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1)%>&nbsp&nbsp<%#Eval("ItemId")%>
                                    </h3>
                                    <div class='tar rc <%#!IsMainDept(Convert.ToString(Eval("ItemId")))?" hide":"" %>'>
                                        <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsMainDept(Convert.ToString(Eval("TargetId")))&&!IsDutyDept(Convert.ToString(Eval("ItemId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom">变更申请</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                        </div>
                                    </div>
                                    <div class="tar rc">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="<%#!IsMainDept(Convert.ToString(Eval("TargetId")))?"detail-col detail-col-2":"detail-block"%>">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="form-group form-inline col">
                                            <span>完成进度</span>
                                            <input data-type="num" id="<%#Eval("ItemId") %>_FinshPrecent" type="text" class="form-control <%#!IsMainDept(Convert.ToString(Eval("TargetId")))?"input-ch-text":"" %>" value="<%#Eval("FinshPercent") %>" data-operate="true" data-operateid="<%#Eval("MeasureDetailIdIndex") %>" <%#!IsMainDept(Convert.ToString(Eval("TargetId")))?"disabled":"" %> />
                                        </div>
                                        <div id="<%#Eval("MeasureDetailIdIndex") %>" style="display: none;">
                                            <div class="form-group form-inline form-new">
                                                <span class="cd">最新反馈</span><span class="c-danger">*</span>
                                                <textarea class="form-control th3" id="<%#Eval("ItemId") %>_Opinion"><%#Eval("Opinion") %></textarea>
                                            </div>
                                            <div class="form-group form-inline form-new">
                                                <span class="cd">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件</span>
                                                <input type="file" data-targetitemid="<%#Eval("ItemId") %>" data-form-data="{'SmId': '<%#Eval("ItemId") %>'}" />
                                                <button type="button" class="btn btn-default-sm" data-targetitemid="<%#Eval("ItemId") %>">上传附件</button>
                                            </div>
                                            <div class="file-list form-new">
                                                <ul class="list-unstyled attchmentList" data-targetitemid="<%#Eval("ItemId") %>"></ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),11)%></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <div class="button-group">
                                        <button type="button" data-save-targetid="<%#Eval("TargetId") %>" class="btn btn-default-s<%#!IsMainDept(Convert.ToString(Eval("TargetId")))?" hide":"" %>" data-save="save" data-itemid="<%#Eval("ItemId") %>" data-flowid="<%#Eval("FlowId") %>">保存</button>
                                        <button type="button" class="btn btn-default-s hide" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                        <button type="button" class="btn btn-default-s hide" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                        <button type="button" class="btn btn-default-s hide" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                        <button type="button" class="btn btn-default-s hide" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="tac mgbm">
                        <button type="button" class="btn btn-primary-c btn11Submit<%#!IsMainDept(Convert.ToString(Eval("TargetId")))?" hide":"" %>" data-toggle="modal" data-target="#agreeModal" data-targetid="<%#Eval("TargetId") %>">进度发送</button>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <%--qq这个弹窗修改--%>
            <div class="tar">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%# Eval("TargetId") %>" data-itemid="">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="">操作记录</button>
            </div>
            <!--同意弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModal">
                <div class="modal-dialog" role="document" style="width: 650px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body modal-form">
                            <div class="form-group">
                                <p>
                                    目标进度<span class="c-danger">（*）</span>
                                </p>
                                <input class="form-control" type="text" id="TargetPercent" data-type="num" />
                            </div>
                            <div class="form-group">
                                <p>
                                    反馈意见<span class="c-danger">（*）</span>
                                </p>
                                <textarea class="form-control thx" id="TargetOpinion"></textarea>
                            </div>
                            <p>请选择下一步骤</p>
                            <div class="b">
                                <div class="l si">
                                    <p>选择发送</p>
                                    <ul class="list-unstyled" role="tablist" id="stepList">
                                    </ul>
                                </div>
                                <div class="r">
                                    <p>已选择</p>
                                    <div class="tab-content" id="stepUserList">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-targetid="" id="btn11Submit">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!--end同意弹窗-->
        </div>
        <!--end措施反馈-->
        <% } %>

        <% if (page == 12)
            { %>
        <!--主办单位秘书分解任务-->
        <div style="display: block">
            <div class="card-outter">
                <div class="card card-box first">
                    <div class="step">
                        <div class="card-header">
                            <h3 class="title">添加年度目标</h3>
                            <span class="iconfont icon-sv-add" data-add="year-target"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tar">
                <button type="button" name="btnOpreaHistory" data-targetid="" data-targetitemid="" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
            </div>
            <div class="tac" style="display: none;" data-btn="sure">
                <button type="button" class="btn btn-primary-c" id="bt12Submit">提交</button>
            </div>
            <!--目标模板-->
            <script id="targetTempl" type="x-tmpl-mustache">
            <div class="card card-box" data-index="{{index}}">
                <div class="card-header">
		            <h3 class="c">年度目标{{index}}</h3>
                </div>
                <div class="card-body year-target detail-line">
                    <div class="form-block">
                        <div class="form-group">
                            <textarea data-name="ndText" name="ndText" class="form-control th2"></textarea>
                            <span class="iconfont icon-sv-trash delete-flag" style="display:none;font-size:16px;background:#fff;"></span>
                        </div>
                        <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-toggle="modal" data-add="target-step">添加</button>
                            <button type="button" class="btn btn-default-s" data-cancel="cancel">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            </script>
            <!--end目标模板-->
            <!--措施模板-->
            <script id="stepTempl" type="x-tmpl-mustache">
            <div class="step-child card-box detail-line" data-key="{{key}}">
                <div class="card-header">
                    <h3 class="title">
                        <span class="line"></span>措施{{key}}
                    </h3>
                    <span class="iconfont icon-sv-trash" style="display:none;font-size:16px;"></span>
               </div>
                <div class="card-body target-step">
                    <div class="form-child">
                        <div class="form-group">
                            <textarea data-name="csText" name="csText" class="form-control th3"></textarea>
                            <span class="iconfont icon-sv-trash delete-flag" style="display:none;font-size:16px;background:#fff;"></span>
                        </div>
                        <div class="form-group tac">
                            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">
                                <label>协办单位</label>
                                <input type="text" readonly class="form-control" name="company" data-dept="company" data-toggle="modal" data-target="#company"/>
                                <span class="iconfont icon-sv-add" data-dept="company" data-toggle="modal" data-target="#company"></span>
                            </div>
                            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tac">
                                <label>完成时间</label>
                                <input type="text" readonly data-date-format="yyyy-mm-dd" class="form-control input-time" data-name="dataPicker" />
                            </div>
                            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tar">
                                <label>责任处室</label>
                                <input type="text" readonly class="form-control" readonly="readonly" name="office" data-dept="office" data-toggle="modal" data-target="#company"/>
                                <span class="iconfont icon-sv-add" data-dept="office" data-toggle="modal" data-target="#company"></span>
                            </div>
                        </div>
                        <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-add="finish">添加</button>
                            <button type="button" class="btn btn-default-s" data-cancel="">取消</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            </script>
            <!--end措施模板-->
            <!--删除提示-->
            <div class="modal fade" tabindex="-1" role="dialog" id="deleteModal">
                <div class="modal-dialog" role="document" style="width: 300px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">提示</h4>
                        </div>
                        <div class="modal-body">
                            <p id="tips"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-delete="sure">确认</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--end删除提示-->
        </div>
        <!--end主办单位秘书分解任务-->
        <% } %>

        <% if (page == 12 || page == 13)
            { %>
        <!--选择单位-->
        <div class="modal company-modal" tabindex="-1" role="dialog" id="company" style="display: none;" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document" style="width: 610px; margin: 30px auto;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                        <h4 class="modal-title">选择单位</h4>
                    </div>
                    <div class="modal-body">
                        <div class="clearfix">
                            <div class="col-sm-6 col" style="padding-left: 0;">
                                <div class="form-group">
                                    <div class="input-group">
                                        <input type="text" class="form-control search-dept" placeholder="选择部门" />
                                        <div class="input-group-addon sdept">
                                            <span class="iconfont icon-sv-search"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col" style="padding-right: 0;">
                                <div class="form-group dropdown">
                                    <select class="form-control" name="groupSelect">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="choose-area" id="chooseArea">
                        </div>
                        <div class="result-area" id="resultArea" data-area="">
                        </div>
                        <div class="form-group sn tac">
                            <button type="button" class="btn btn-primary-c" data-btn="deptSure">确定</button>
                            <button type="button" class="btn btn-default-c" data-modal-btn="reset">重置</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end选择单位-->
        <% } %>

        <% if (page == 13)
            { %>
        <!--责任处室分解子措施-->
        <div style="display: block">
            <div class="detail-box dp13 detail-box">
                <div class="detail-box">
                    <asp:Repeater ID="Repeater13" runat="server" OnItemDataBound="Repeater13_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-box detail-box2">
                                <div class="detail-part detail-line">
                                    <h3 class="c">年度目标<%# GetIndexForTarget() %></h3>
                                    <p><%#Eval("TargetName") %></p>
                                    <div class="detail-col">
                                        <div class="col">
                                            <span>主办单位</span>
                                            <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                                    </div>
                                </div>
                            </div>
                            <!--可进行分解子措施的措施-->
                            <asp:Repeater ID="Repeater13_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub pr detail-line" data-measureid="<%#Eval("ItemId") %>" data-targetid="<%#Eval("TargetId") %>">
                                        <h3><span class="line line-primary"></span>措施<%# GetIndexForTargetItem(Eval("TargetId").ToString()) %></h3>
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsMainDept(Convert.ToString(Eval("TargetId")))&&!IsDutyDept(Convert.ToString(Eval("ItemId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom">
                                                变更申请
                                            </button>
                                            <div class="rb">
                                                <div class="button-group">
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">
                                                历史记录
                                            </button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                        <div class="detail-col detail-col-1">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span><%#Eval("DutyDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成进度</span>
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block">
                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),13)%></p>
                                        </div>
                                        <div class="clearfix"></div>
                                        <div class="add-step detail-opera">
                                            <h3><span class="line"></span>添加子措施</h3>
                                            <span class="iconfont icon-sv-add" data-add="add-step-child"></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <!--只可看的措施-->
                            <asp:Repeater ID="Repeater13_2" runat="server" OnItemDataBound="Repeater13_2_ItemDataBound">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub pr detail-line" data-measureid="<%#Eval("ItemId") %>" data-targetid="<%#Eval("TargetId") %>">
                                        <h3><span class="line line-primary"></span>措施<%# GetIndexForTargetItem(Eval("TargetId").ToString()) %></h3>
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                        <div class="detail-col detail-col-1">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span><%#Eval("DutyDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成进度</span>
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block">
                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),13)%></p>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <asp:Repeater ID="Repeater13_2_2" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-part detail-part-sub2 pr detail-line">
                                                <h3><span class="line line-success"></span>子措施<%#GetIndexForSubItem(Eval("ParentTargetItemId").ToString())%></h3>
                                                <p><%#Eval("ItemName") %></p>
                                                <div class="detail-col detail-col-2">
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任人</span>
                                                        <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%#Eval("FinshPercent")%>%</span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),13) %></p>
                                                </div>
                                                <%--qq这是测试附件--%>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="tar">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-itemid="">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="" data-targetitemid="">操作记录</button>
            </div>
            <div class="tac form-group">
                <button id="btn13Submit" type="button" class="btn btn-primary-c" data-btn="send">发送</button>
            </div>
            <!--子措施模板-->
            <script id="steoChildTempl" type="x-tmpl-mustache">
                <div class="detail-part detail-part-sub dps detail-line" data-index="{{index}}">
                    <div class="add-step">
                        <h3 class="">
                            <span class="line"></span>子措施{{index}}
                        </h3>
                        <span class="iconfont icon-sv-trash" style="display:none;"></span>
                   </div>
                    <div class="card-body target-step">
                        <div class="form-child">
                            <div class="form-group">
                                <textarea class="form-control th4" field-name="itemname"></textarea>
                            </div>
                            <div class="form-group tac">
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">
                                    <label>协办单位</label>
                                    <input type="text" readonly class="form-control" name="company" data-dept="company" data-toggle="modal" data-target="#company" field-name="assistdept" />
                                    <span class="iconfont icon-sv-add" data-dept="company" data-toggle="modal" data-target="#company"></span>
                                </div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 tac">
                                    <label>完成时间</label>
                                    <input type="text" readonly data-date-format="yyyy-mm-dd" class="form-control input-time" data-name="dataPicker" field-name="dutylinetime"/>
                                </div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 tar">
                                    <label>责任人</label>
                                    <input type="text" readonly class="form-control" name="office" data-dept="office" data-toggle="modal" data-target="#leaderModal" field-name="excutorname"/>
                                    <span class="iconfont icon-sv-add" data-dept="office" data-toggle="modal" data-target="#leaderModal"></span>
                                </div>
                            </div>
                            <div class="form-group tac">
                                    <button type="button" class="btn btn-primary-s" data-add="finishStep">添加</button>
                                <button type="button" class="btn btn-default-s" data-cancel="cancel">取消</button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </script>
            <!--end子措施模板-->

            <!--办结弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="finishModal" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog" role="document" style="width: 400px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">提示</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <p>
                                    确定要办结改措施吗？请填写理由
                                </p>
                                <textarea class="form-control thx"></textarea>
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end办结弹窗-->
            <!--责任人-->
            <div class="modal" tabindex="-1" role="dialog" id="leaderModal" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog" role="document" style="width: 600px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">选择责任人</h4>
                        </div>
                        <div class="modal-body">
                            <div class="input-group">
                                <input type="text" class="form-control" id="textAssLeader" placeholder="请输入员工号或姓名" />
                                <div class="input-group-addon" id="btSearchAssLeader">
                                    <span class="iconfont icon-sv-search"></span>
                                </div>
                            </div>
                            <div class="choose-area">
                                <ul class="list-unstyled" id="ulAssLeader">
                                </ul>
                            </div>
                            <div id="assLeaderSelectedList" class="result-area" data-value="" data-text=""></div>
                        </div>
                        <div class="form-group tac">
                            <button id="btConfirmSelectAssLeader" type="button" class="btn btn-primary-c">确定</button>
                            <button id="btResetSelectAssLeader" type="button" class="btn btn-default-c" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
                <!--end责任人-->

            </div>
        </div>

        <!--删除提示-->
        <div class="modal" tabindex="-1" role="dialog" id="deleteModal" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document" style="width: 300px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">提示</h4>
                    </div>
                    <div class="modal-body">
                        <p id="tips">确认删除该子措施吗？</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-delete="sure">确认</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
        <!--end删除提示-->
        <!--end责任处室分解子措施-->
        <% } %>

        <% if (page == 14)
            { %>
        <!--撤回-->
        <div style="display: block">
            <asp:Repeater ID="Repeater14" runat="server" OnItemDataBound="Repeater14_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%#GetIndexForTarget() %></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater14_1" runat="server">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%#GetIndexForTargetItem(Eval("TargetId").ToString()) %>
                                    </h3>
                                    <div class="tar rc">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" name="btnFeedbackHistory" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" name="btnOpreaHistory" data-targetid="<%# Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-1">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>
            <div class="tar">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target=".feedback" data-targetid="" data-itemid="">反馈记录</button>
                <button type="button" name="btnOpreaHistory" data-targetid="" data-targetitemid="" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
            </div>
            <div class="tac">
                <button class="btn btn-primary-c" type="button" id="btnRedirect">反馈进度</button>
                <button class="btn btn-default-c" type="button" id="btn14Send">发送</button>
            </div>
        </div>
        <!--撤回-->
        <% } %>

        <% if (page == 15)
            { %>
        <!--部门审核/部门审批-->
        <div style="display: block">
            <asp:Repeater ID="Repeater15" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col detail-col-2">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1)%>
                                    </h3>
                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),15)%></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <asp:Repeater ID="Repeater15_1_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<%=GetPostfix(2)%><span class="s"></span>
                                                    </h3>
                                                    <div class="tar rc r">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                        <button type="button" class="btn btn-second-s<%#!IsSameDeptByItemId(Convert.ToString(Eval("ParentTargetItemId")))?" hide":"" %>" data-toggle="modal" data-smid="<%#Eval("SmId")%>" data-itemid="<%#Eval("ItemId")%>" data-target="#backModal">退回</button>
                                                    </div>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成进度</span>
                                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),15)%></p>
                                                    </div>
                                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="card">
            <div class="card-header">
                <%--<div class="opinion-type"></div>--%>
                <div class="form-group">
                    <label class="font-lg">审批意见</label>
                    <textarea class="form-control thx" id="opinion15"></textarea>
                </div>
            </div>
        </div>

        <div class="tar">
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-itemid="">反馈记录</button>
            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
        </div>

        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal15">同意</button>
            <button type="button" class="btn btn-default-c" id="disagree15">不同意</button>
        </div>
        <!--同意弹窗-->
        <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModal15">
            <div class="modal-dialog" role="document" style="width: 650px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">反馈</h4>
                    </div>
                    <div class="modal-body modal-form">
                        <p>请选择下一步骤</p>
                        <div class="b">
                            <div class="l si">
                                <p>选择发送</p>
                                <ul class="list-unstyled" role="tablist" id="stepItem15"></ul>
                            </div>
                            <div class="r">
                                <p>已选择</p>
                                <div class="tab-content" id="userItem15"></div>
                            </div>
                        </div>
                        <div class="form-group tac">
                            <button type="button" class="btn btn-primary-s" id="surePage15">确定</button>
                            <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            <!--当前任务对应的流程部门Id。-->
                            <input type="hidden" id="flowDeptId15" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end同意弹窗-->
        <!--end部门审核/部门审批-->
        <% } %>

        <%if (page == 16)
            {%>
        <!--责任处室措施推进-->
        <div style="display: block">
            <asp:Repeater ID="Repeater16" runat="server" OnItemDataBound="Repeater16_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater16_1" runat="server">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1)%>
                                    </h3>
                                    <div class="tar rc">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" name="btnFeedbackHistory" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" name="btnOpreaHistory" data-targetid="" data-targetitemid="" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-1">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>

            <div class="tar">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target=".feedback" data-targetid="" data-itemid="">反馈记录</button>
                <button type="button" name="btnOpreaHistory" data-targetid="" data-targetitemid="" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
            </div>
            <div class="tac">
                <button class="btn btn-primary-c" type="button" id="btnRedirect16">反馈进度</button>
                <button class="btn btn-default-c" type="button" id="btnSend16">继续分解</button>
            </div>
        </div>
        <!--end责任处室措施推进-->
        <%}%>

        <%if (page == 17)
            {%>
        <!--责任处室措施反馈。-->
        <div style="display: block">
            <asp:Repeater ID="Repeater17" runat="server" OnItemDataBound="Repeater17_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%>&nbsp&nbsp<%#Eval("TargetId")%></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater17_1" runat="server">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1)%>&nbsp&nbsp<%#Eval("ItemId")%>
                                    </h3>
                                    <div class="tar rc">
                                        <button type="button" class="btn btn-default-s pop <%#IsSmMainJS(Convert.ToString(Eval("SmId")))||(!IsMainDept(Convert.ToString(Eval("TargetId")))&&!IsDutyDept(Convert.ToString(Eval("ItemId"))))?" hide":"" %>" data-container="body" data-toggle="popover" data-placement="bottom">变更申请</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                            <button type="button" class="btn btn-default-s" data-gotohref data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                        </div>
                                    </div>
                                    <div class="tar rc">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="<%#!IsDutyDept(Convert.ToString(Eval("ItemId")))?"detail-col detail-col-2":"detail-block" %>">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="form-group form-inline col">
                                            <span>完成进度</span>
                                            <input data-type="num" id="finishPercent_<%#Eval("ItemId") %>" type="text" class="form-control <%#!IsDutyDept(Convert.ToString(Eval("ItemId")))?"input-ch-text":"" %>" value="<%#GetWaitingFinishPercentByItemId(Convert.ToString(Eval("ItemId")))%><%#!IsDutyDept(Convert.ToString(Eval("ItemId")))?"%":"" %>" data-operate="true" data-operateid="opinionAndAttchmentPanel_<%#Eval("ItemId") %>" <%#!IsDutyDept(Convert.ToString(Eval("ItemId")))?"disabled":"" %> />
                                        </div>
                                        <%--说明：id=opinionAndAttchmentPanel_xxx是最新反馈和附件的面板用于控制鼠标点击"完成进度"文本框时就显示该面板，初始时该面板是隐藏的。--%>
                                        <div id="opinionAndAttchmentPanel_<%#Eval("ItemId") %>" style="display: none;">
                                            <div class="form-group form-inline form-new">
                                                <span class="cd">最新反馈</span><span class="c-danger">*</span>
                                                <textarea class="form-control th3" id="opinion_<%#Eval("ItemId")%>"><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),17)%></textarea>
                                            </div>
                                            <div class="form-group form-inline form-new">
                                                <span class="cd">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件</span>
                                                <input type="file" data-targetitemid="<%#Eval("ItemId")%>" data-form-data="{'SmId': '<%#Eval("ItemId") %>'}" />
                                                <button type="button" class="btn btn-default-sm" data-targetitemid="<%#Eval("ItemId")%>">上传附件</button>
                                            </div>
                                            <div class="file-list form-new">
                                                <ul class="list-unstyled attchmentList" data-targetitemid="<%#Eval("ItemId")%>">
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f" style="<%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),17)!=""?"display:auto": "display:none"%>"><span class="iconfont icon-sv-sound" style="color: #4aa2f7; margin-right: 10px; margin-left: 5px;"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),17)%></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <div class="button-group">
                                        <button type="button" class="btn btn-default-s<%#!IsDutyDept(Convert.ToString(Eval("ItemId")))?" hide":"" %>" data-save="save" data-itemid="<%#Eval("ItemId") %>" data-flowid="<%#GetWaitingFlowIdByItemId(Convert.ToString(Eval("ItemId")))%>">保存</button>
                                    </div>
                                </div>
                            </div>
                            <div class="tac mgbm">
                                <button type="button" class="btn btn-primary-c btnSubmit17<%#!IsDutyDept(Convert.ToString(Eval("ItemId")))?" hide":"" %>" data-toggle="modal" data-target="#agreeModalPage17" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>" data-flowid="<%#GetWaitingFlowIdByItemId(Convert.ToString(Eval("ItemId")))%>">进度发送</button>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>
            <%--qq这里的弹窗做了修改--%>
            <div class="tar mgbm">
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-itemid="">反馈记录</button>
                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="" data-targetitemid="">操作记录</button>
            </div>

            <!--同意弹窗-->
            <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModalPage17">
                <div class="modal-dialog" role="document" style="width: 650px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">反馈</h4>
                        </div>
                        <div class="modal-body modal-form">
                            <%--<div class="form-group">
                                <p>
                                    目标进度<span class="c-danger">（*）</span>
                                </p>
                                <input class="form-control" type="text" id="targetPercent17" data-type="num" />
                            </div>
                            <div class="form-group">
                                <p>
                                    反馈意见<span class="c-danger">（*）</span>
                                </p>
                                <textarea class="form-control thx" id="opinion17"></textarea>
                            </div>--%>
                            <p>请选择下一步骤</p>
                            <div class="b">
                                <div class="l si">
                                    <p>选择发送</p>
                                    <ul class="list-unstyled" role="tablist" id="stepItem17"></ul>
                                </div>
                                <div class="r">
                                    <p>已选择</p>
                                    <div class="tab-content" id="userItem17"></div>
                                </div>
                            </div>
                            <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-targetid="" id="btnSubmit17">确定</button>
                                <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                                <!--当前任务对应的流程部门Id。-->
                                <input type="hidden" id="flowDeptId17" />
                                <!--当前选中的目标Id。-->
                                <input type="hidden" id="targetId17" />
                                <!--当前选中的措施Id。-->
                                <input type="hidden" id="itemId17" />
                                <!--当前选中的措施Id对应待办的流程Id。-->
                                <input type="hidden" id="itemFlowId" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--end同意弹窗-->
        </div>
        <!--end责任处室措施反馈。-->
        <%}%>

        <% if (page == 18)
            { %>
        <!--秘书处理-->

        <div class="detail-box">
            <asp:Repeater ID="Repeater18" runat="server" OnItemDataBound="Repeater18_ItemDataBound">
                <ItemTemplate>
                    <div style="display: block">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标<%=GetPostfix(0)%></h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col detail-col-2">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                    <div class="card card-box card-line">
                        <asp:Repeater ID="Repeater18_1" runat="server" OnItemDataBound="Repeater18_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%=GetPostfix(1)%>
                                    </h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound" style="position: static; font-size: 15.8px"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),18)%></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <div class="card-body detail-line">
                                    <asp:Repeater ID="Repeater18_1_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<%=GetPostfix(2)%><span class="s"></span>
                                                    </h3>
                                                    <div class="tar rc r">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId")%>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                        <button type="button" class="btn btn-second-s<%#!IsSameDeptByItemId(Convert.ToString(Eval("ParentTargetItemId")))?" hide":"" %>" data-toggle="modal" data-smid="<%#Eval("SmId")%>" data-itemid="<%#Eval("ItemId")%>" data-target="#backModal">退回</button>
                                                    </div>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成进度</span>
                                                            <span class="process"><%#Eval("FinshPercent") %>%</span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByItemId(Convert.ToString(Eval("ItemId")),18)%></p>
                                                    </div>
                                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>


        <div class="card">
            <div class="card-header">
                <div class="opinion-type"></div>
                <div class="form-group">
                    <label class="font-lg">审批意见</label>
                    <textarea class="form-control thx" id="opinion18"></textarea>
                </div>
            </div>
        </div>
        <div class="tar">
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-itemid="">反馈记录</button>
            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
        </div>
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal18">发送</button>
        </div>
        <!--同意弹窗-->
        <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModal18">
            <div class="modal-dialog" role="document" style="width: 650px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">反馈</h4>
                    </div>
                    <div class="modal-body modal-form">
                        <p>请选择下一步骤</p>
                        <div class="b">
                            <div class="l si">
                                <p>选择发送</p>
                                <ul class="list-unstyled" role="tablist" id="stepItem18"></ul>
                            </div>
                            <div class="r">
                                <p>已选择</p>
                                <div class="tab-content" id="userItem18"></div>
                            </div>
                        </div>
                        <div class="form-group tac">
                            <button type="button" class="btn btn-primary-s" id="sure18">确定</button>
                            <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            <!--当前任务对应的流程部门Id。-->
                            <input type="hidden" id="flowDeptId18" />
                            <input type="hidden" id="targetId18" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end同意弹窗-->
        <!--end秘书处理-->
        <% } %>

        <%if (page == 19)
            { %>
        <div class="card2">
            <div class="pd5 mgbm2">
                <ul class="list-unstyled">
                    <li><span>任务进度：</span><span><%=TaskFinishPercent%>%</span></li>
                    <li><span>反馈意见：</span><span><%=LastTaskOpinion%></span></li>
                </ul>
            </div>
        </div>

        <div class="card2">
            <div class="pd5 mgbm2">
                <h3 class="c">年度目标</h3>
                <a class="cp-p2" data-pos="top" href="#page19">展开<span class="iconfont icon-arrow-left"></span></a>
            </div>
        </div>
        <div class="detail-box pr" id="page19" style="display: none;">
            <asp:Repeater ID="Repeater19" runat="server">
                <ItemTemplate>
                    <div class="card-box card card-box-1" style="margin-top: 0px; padding-bottom: 0px">
                        <div class="supervise-md-box card-header">
                            <div class="detail-part">
                                <h3 class="c">年度目标<%=GetPostfix(0)%></h3>
                                <p><%#Eval("TargetName") %></p>
                            </div>
                        </div>
                        <div class="card-body  detail-line">
                            <div class="detail-col detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="c-primary"><%#Eval("TargetPercent")%>%</span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%#GetLastOpinionByTargetId(Convert.ToString(Eval("TargetId")))%></p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <a class="cp-p2" data-pos="bottom" href="#page19">收起<span class="iconfont icon-sv-arrow-up"></span></a>
        </div>
        <div class="card">
            <div class="card-header">
                <div class="form-group">
                    <label class="font-lg">审批意见</label>
                    <textarea class="form-control" id="opinion19"></textarea>
                </div>
            </div>
        </div>
        <div class="tar rc">
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-itemid="">反馈记录</button>
            <button type="button" class="btn btn-default-s" data-toggle="modal" name="btnOpreaHistory" data-targetid="" data-targetitemid="" data-target="#opera">操作记录</button>
        </div>
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal19">同意</button>
            <button type="button" class="btn btn-default-c" id="disagree19">不同意</button>
        </div>

        <!--同意弹窗-->
        <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModal19">
            <div class="modal-dialog" role="document" style="width: 650px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">反馈</h4>
                    </div>
                    <div class="modal-body modal-form">
                        <p>请选择下一步骤</p>
                        <div class="b">
                            <div class="l si">
                                <p>选择发送</p>
                                <ul class="list-unstyled" role="tablist" id="stepItem19"></ul>
                            </div>
                            <div class="r">
                                <p>已选择</p>
                                <div class="tab-content" id="userItem19"></div>
                            </div>
                        </div>
                        <div class="form-group tac">
                            <button type="button" class="btn btn-primary-s" id="surePage19">确定</button>
                            <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                            <!--当前任务对应的流程部门Id。-->
                            <input type="hidden" id="flowDeptId19" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end同意弹窗-->
        <%}%>

        <!--公共的部分：反馈记录+操作记录。-->
        <!--反馈记录-->
        <div class="modal fade feedback" tabindex="-1" role="dialog" id="feedback">
            <div class="modal-dialog" role="document" style="width: 610px; margin: 30px auto;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">反馈记录</h4>
                    </div>
                    <div class="modal-body">
                        <div class="feed-modal">
                            <%--<h3><span class="line"></span>公司领导批示</h3>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>反馈内容</th>
                                        <th>反馈人</th>
                                        <th>反馈人信息</th>
                                        <th>反馈时间</th>
                                    </tr>
                                </thead>
                                <tbody class="trLeaderFeedbackHistrpy">
                                </tbody>
                            </table>
                            <h3><span class="line"></span>主办单位意见</h3>--%>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>反馈内容</th>
                                        <th>反馈人</th>
                                        <th>反馈人信息</th>
                                        <th>反馈时间</th>
                                    </tr>
                                </thead>
                                <tbody class="trMainDeptFeedbackHistory">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end反馈记录-->

        <!--操作记录-->
        <div class="modal fade opera" tabindex="-1" role="dialog" id="opera">
            <div class="modal-dialog" role="document" style="margin: 30px auto;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">操作记录</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>处理人</th>
                                    <th>处理人信息</th>
                                    <th>时间</th>
                                    <th>处理意见</th>
                                    <th>处理步骤</th>
                                    <th>意见类型</th>
                                </tr>
                            </thead>
                            <tbody class="trOpreaHistory">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--end操作记录-->
        <!--变更记录-->
        <div class="modal fade opera" tabindex="-1" role="dialog" id="changeRecord">
            <div class="modal-dialog" role="document" style="margin: 30px auto;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">变更记录</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>文档ID</th>
                                    <th>变更类型</th>
                                    <th>变更单状态</th>
                                    <th>变更原因</th>
                                    <th>申请人</th>
                                    <th>申请人信息</th>
                                    <th>申请时间</th>
                                </tr>
                            </thead>
                            <tbody class="trChangeHistory">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--end变更记录-->
        <!--end公共的部分：反馈记录+操作记录。-->


    </div>
    <div class="main main3" style="display: none;">
        <div class="tal buttons" style="display: block; height: 28px">
            <button class="btn btn-default-s tal-head-right" type="button">切换表单</button>
        </div>
        <div class="table-page">
            <table class="table table-bordered table-static-width" id="pageList">
                <thead>
                    <tr>
                        <th style="width: 40px">序号</th>
                        <th style="width: 80px">督查编号</th>
                        <th style="width: 80px">重点工作任务</th>
                        <th style="width: 80px">任务进度</th>
                        <th style="width: 80px">最新反馈</th>
                        <th style="width: 80px">主管领导</th>
                        <th style="width: 80px">协管领导</th>
                        <%--  <th style="width: 110px">主办单位</th>--%>
                        <%--<th>状态</th>--%>
                        <th style="width: 80px">主办单位</th>
                        <th style="">年度目标</th>
                        <th style="width: 80px">目标进度</th>
                        <th style="width: 80px">最新反馈</th>
                        <th style="width: 80px">措施流水号</th>
                        <th style="">措施</th>
                        <th style="width: 80px">完成时间</th>
                        <th style="width: 80px">措施进度</th>
                        <th style="width: 80px">最新反馈</th>
                        <th style="width: 80px">责任处室</th>
                        <th style="">子措施</th>
                        <th style="width: 80px">子措施进度</th>
                        <th style="width: 80px">最新反馈</th>
                        <th style="width: 80px">责任人</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <script id="deptTemplate" type="x-tmpl-mustache">
   <ul class="list-unstyled">{{{deptHtml}}}</ul>
    </script>
    <script id="deptGroupTemplate" type="x-tmpl-mustache">
                                  {{{deptGroupHtml}}}
    </script>
    <script src="Script/require.js"></script>
</body>
</html>
<script>

    var TARGET_NAME_MAX_LENGTH = 400;     // 目标字符数最大限长量。
    var TARGET_ITEM_NAME_MAX_LENGTH = 400;// 措施字符数最大限长量。
    var BACK_OPINION_MAX_LENGTH = 400;    // 退回字符数最大限长量。
    var CHECK_OPINION_MAX_LENGTH = 400;   // 审核字符数最大限长量。
    var TASK_OPINION_MAX_LENGTH = 1000;   // 任务反馈意见最大限长量。
    var TARGET_OPINION_MAX_LENGTH = 1000; // 目标反馈意见最大限长量。
    var PTI_OPINION_MAX_LENGTH = 500;     // 父措施反馈意见最大限长量。
    var CTI_OPINION_MAX_LENGTH = 400;     // 子措施反馈意见最大限长量。

    require.config({
        baseUrl: "Script/",
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

    require(['jquery', 'mustache', 'toast', 'AJAX', 'bootstrap', 'picker', 'ie', 'jquery.iframe-transport', 'jquery.fileupload', 'cs-opinion'], function ($, Mustache, layer, Ajax) {
        function getQueryString(name) {
            var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
            var r = window.location.search.substr(1).match(reg);
            if (r != null) {
                return unescape(r[2]);
            }
            return null;
        }

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
            }
            else {
                appendNone(ele);
                if (cfg.isFristSearch) {
                    page.hide();
                }
            }
        }
        //无数据展示
        var appendNone = function (el) {
            $("#pageList").hide()
            $(el).css('overflow-x', 'hidden')
            var html = '<div class="no-page"><div class="no-search-icon"></div><p>暂无查询结果</p></div>';
            $(el).append(html);
        }

        //限制输入数字，可小数
        $(document).on('keyup', '[data-type="num"]', function (e) {
            var $this = $(e.target);
            var $val = $this.val();
            var $newValue = $val.replace(/[^1-9]/g, '');
            if ($val.length == 1) {
                $newValue = $val.replace(/[^1-9]/g, '');
            } else {
                $newValue = $val.replace(/\D/g, '');
                if ($newValue > 100) {
                    $newValue = 100;
                } else if (/^0+/ig.test($newValue)) {
                    $newValue = $newValue.replace(/^0+/ig, '')
                }
            }
            $this.val($newValue);
        });

        $(document).on('afterpaste', '[data-type="num"]', function (e) {
            var $this = $(e.target);
            var $val = $this.val();
            var $newValue = $val.replace(/[^1-9]/g, '');
            if ($val.length == 1) {
                $newValue = $val.replace(/[^1-9]/g, '');
            } else {
                $newValue = $val.replace(/\D/g, '');
                if ($newValue > 100) {
                    $newValue = 100;
                } else if (/^0+/ig.test($newValue)) {
                    $newValue = $newValue.replace(/^0+/ig, '')
                }
            }
            $this.val($newValue);
        });
        //操作记录公用部分（page=4、2、14）
        $(document).on("click", "[name='btnOpreaHistory']", function (e) {
            $(".trOpreaHistory").html("");//清空
            var smid = getQueryString("smid");
            var targetid = $(e.target).data("targetid");
            var targetitemid = $(e.target).data("targetitemid");
            var page = "0";
            try {
                page = $(e.target).data("page");
                if (page == undefined) {
                    page = "0";
                }
            } catch (e) {
                page = "0";
            }

            var jsonData = { smid: smid, targetid: targetid, targetItemId: targetitemid, page: page };

            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSmFlowFinishList",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var flowlist = data.d.historyFlow;
                        var str = "";
                        for (var i = 0; i < flowlist.length; i++) {
                            str += "<tr><td>" + flowlist[i].OperatorId + "</td><td>" + flowlist[i].OperatorName + "</td><td>" + flowlist[i].OperaTime + "</td><td>" + flowlist[i].Opintion + "</td><td>" + flowlist[i].StepName + "</td><td>" + flowlist[i].OpintionType + "</td></tr>";
                        }
                        $(".trOpreaHistory").html(str);
                    } else {
                        layer.msg(data.d.message, { icon:2,time:1000});
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon:2,time:1000});
                },
                cache: false
            });
        });

        //变更历史记录公用部分（page=4、2、14）
        $(document).on("click", "[name='btnChangeHistory']", function (e) {
            $(".trChangeHistory").html("");//清空
            var smid = getQueryString("smid");
            var targetitemid = $(e.target).data("itemid");
            var jsonData = { smid: smid, targetItemId: targetitemid };

            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSmChangeRecordList",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var flowlist = data.d.changeItemList;
                        var str = "";
                        for (var i = 0; i < flowlist.length; i++) {
                            var href = "SuperviseMissionDelayModifyEndDetail.aspx?smid=" + flowlist[i].ChangeId + "&smtype=" + flowlist[i].SmType + "&subtype=" + flowlist[i].SubType + "&pagetype=FormPage";
                            if (flowlist[i].SmType === "LD") {
                                href = "LeaderMeetingMissionChangeModifyDetail.aspx?smid=" + flowlist[i].ChangeId + "&smtype=" + flowlist[i].SmType + "&subtype=" + flowlist[i].SubType + "&pagetype=FormPage";
                            }
                            str += "<tr><td><a style='color:blue' href='" + href + "'>" + flowlist[i].ChangeId + "</a></td><td>" + flowlist[i].ChangeTypeName + "</td><td>" + flowlist[i].Status + "</td><td>" + flowlist[i].Reason + "</td><td>" + flowlist[i].CreatorId + "<br/>" + flowlist[i].CreatorName + "</td><td>" + flowlist[i].CreatorDeptName + "</td><td>" + flowlist[i].CreateTime + "</td></tr>";
                        }
                        $(".trChangeHistory").html(str);
                    } else {
                        layer.msg(data.d.message, { icon:2,time:1000});
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon:2,time:1000});
                },
                cache: false
            });
        });

        // 办结、中止、延期、调整跳转页面公用部分（page=1、3、10、11、13）
        $(document).on('click', '[data-gotohref]', function (e) {
            var $this = $(e.target);
            var smid = getQueryString("smid");
            var targetid = $this.data('targetid');
            var itemid = $this.data('itemid');
            var parentTargetItemId = $this.data('parenttargetitemid');
            var page = $this.data('type');
            var smtype = getQueryString("smtype");
            var url = 'SuperviseMissionDelayModifyEnd.aspx?smid=' + smid + '&itemid=' + itemid + '&targetid=' + targetid + '&parentTargetItemId=' + parentTargetItemId + '&page=' + page + '&smtype=' + smtype;
            window.location.href = url;
        });

        //反馈记录公用部分（page=1,3,10,11,13,14,15,16,17,18）
        $(document).on("click", "[name='btnFeedbackHistory']", function (e) {
            $(".trLeaderFeedbackHistrpy").html("");//清空
            $(".trMainDeptFeedbackHistory").html("");//清空
            //var smid = getQueryString("smid");
            //var targetid = $(e.target).data("targetid");
            //if (targetid == undefined) { targetid = ""; }
            //var targetitemid = $(e.target).data("targetitemid");
            //if (targetitemid == undefined) { targetitemid = ""; }

            //var jsonData = { smid: smid, targetid: targetid, targetItemId: targetitemid };
            //$.ajax({
            //    type: "POST",
            //    data: JSON.stringify(jsonData),
            //    url: "WebServices/SuperviseMissionWebServices.asmx/GetSmFeedbackFlowFinishList",
            //    contentType: 'application/json;charset=utf-8',
            //    dataType: "json",
            //    success: function (data) {
            //        if (data.d.status == "1") {
            //            var flowlist1 = data.d.LeaderFeedbackFlow;
            //            var flowlist2 = data.d.MainDeptFeedbackFlow;
            //            var str1 = "";
            //            var str2 = "";
            //            for (var i = 0; i < flowlist1.length; i++) {
            //                str1 += "<tr><td>" + flowlist1[i].Opintion + "</td><td>" + flowlist1[i].OperatorId + "</td><td>" + flowlist1[i].OperatorName + "</td><td>" + flowlist1[i].OperaTime + "</td></tr>";
            //            }
            //            for (var k = 0; k < flowlist2.length; k++) {
            //                str2 += "<tr><td>" + flowlist2[k].Opintion + "</td><td>" + flowlist2[k].OperatorId + "</td><td>" + flowlist2[k].OperatorName + "</td><td>" + flowlist2[k].OperaTime + "</td></tr>";
            //            }
            //            $(".trLeaderFeedbackHistrpy").html(str1);
            //            $(".trMainDeptFeedbackHistory").html(str2);
            //        } else {
            //            alert(data.d.message);
            //        }
            //    },
            //    error: function (xhr, textStatus) {
            //        alert("请求发生异常");
            //    }
            //});

            var smId = getQueryString("smid");
            var targetId = $(e.target).data("targetid");
            var itemId = $(e.target).data("itemid");

            if (targetId == undefined || targetId == '') {
                targetId = "";
            }
            if (itemId == undefined || itemId == '') {
                itemId = "";
            }

            var requestParameter = {
                smId: smId,
                targetId: targetId,
                itemId: itemId,
                opinionType: ''
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetFeedback",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var items = data.d.Items;
                        var str = "";
                        for (var k = 0; k < items.length; k++) {
                            str += "<tr><td>" + items[k].Opinion + "</td><td>" + items[k].UserId + "</td><td>" + items[k].UserName + "</td><td>" + items[k].HandlerTime + "</td></tr>";
                        }
                        $(".trLeaderFeedbackHistrpy").html(str);
                        $(".trMainDeptFeedbackHistory").html(str);
                    } else {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });

        //加载附件列表信息公用部门（page=10、11）
        //UlObj：需要加载内容的元素对象
        //itemId:措施或子措施ID
        function LoadAttchmentList(UlObj, itemId) {
            //先置空对象的子孙元素
            UlObj.html('');
            //请求接口获取数据源
            var jsonData = { SmId: itemId };
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSuperviseMissionAttachments",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        if (data.d.data !== '' && data.d.data !== null) {
                            var attchmentList = JSON.parse(data.d.data);
                            //遍历输出附件信息
                            var html = '';
                            $.each(attchmentList, function (index, obj) {
                                html += "<li>";
                                html += '<a title="点击下载" target="_blank" style="color: Blue;text-decoration:none;" href="DownLoadAttachment.aspx?SmId=' + obj.SmId + '&AttachmentId=' + obj.AttachmentId + '" >' + obj.AttachmentName + '</a>';
                                html += '<span title="删除" class="iconfont icon-sv-fail" data-itemid="' + itemId + '" data-attachmentid="' + obj.AttachmentId + '" >';
                                html += '</li>';
                            });
                            UlObj.append(html);
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("加载附件列表:请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        };

        //qq这是测试
        //加载附件列表信息公用部门（测试中的详情页附件列表）
        //UlObj：需要加载内容的元素对象
        //itemId:措施或子措施ID
        function LoadEnclosureList(UlObj, itemId) {
            //先置空对象的子孙元素
            UlObj.html('');
            //请求接口获取数据源
            var jsonData = { SmId: itemId };
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSuperviseMissionAttachments",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        if (data.d.data !== '' && data.d.data !== null && data.d.data !== '[]') {
                            var attchmentList = JSON.parse(data.d.data);

                            //遍历输出附件信息
                            var html = '';
                            $.each(attchmentList, function (index, obj) {
                                html += "<p class='enclosure-item'>";
                                html += '<span class="iconfont icon-sv-form"></span><a title="点击下载" target="_blank" href="DownLoadAttachment.aspx?SmId=' + obj.SmId + '&AttachmentId=' + obj.AttachmentId + '" >' + obj.AttachmentName + '</a>';
                                html += '</p>';
                            });
                            UlObj.append(html);
                            //console.log("OK：您检索的SMID:(" + JSON.stringify(jsonData) + ")附件信息已遍历到DOM上~")
                        } else {
                            //console.log("emmm，您检索的SMID:(" + JSON.stringify(jsonData) + ")没有任何附件信息~")
                        };
                    } else {
                        //alert(data.d.message);
                    }
                },
                error: function (xhr, textStatus) {
                    //alert("请求发生异常");
                }
            });
        }

            <% if (page == 2)
    { %>
        $(document).on('click', '.check-ele', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.check-ele');
            if ($this.hasClass('check-all')) {
                if ($this.prop('checked'))
                    $box.find('input').prop('checked', true)
                else
                    $box.find('input').prop('checked', false)
            }
        });

        // 打开【不同意】。
        $('#disagreeModal').on('show.bs.modal', function (e) {
            var opinionType = $('.f-so .form-control').find('option:selected').val();

            if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
                layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
                return false;
            }
        });

        // 【同意】或【不同意-确定】。
        $(document).on("click", "[name='btn2']", function (e) {
            var requestParameter = {};
            var action = e.target.id;
            var actionFlag = { "btn2Agree": 1, "btn2DisAgree": 0 };
            var smId = getQueryString("smid");
            var opinionType = $('.f-so .form-control').find('option:selected').val();

            if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
                layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
                return;
            }

            if (actionFlag[action] == 1) {
                var checkType = $("[name='notice2']:checked").val();
                var remindType = checkType;
                var checkValue = checkType;
                var remindInterval = -1;
                var flowid = getQueryString("flowid");
                var option = $("#textarea2").val();

                if (option == '') option = '同意';

                if (remindType == "2") {
                    remindInterval = 60;
                }
                else if (remindType == "3") {
                    remindInterval = $("[name='day2']").val();
                    if (!remindInterval) {
                        layer.msg("请输入自定义的提醒天数。", { icon: 2 });
                        return;
                    }
                } else if (remindType == '4') {
                    remindInterval = $("[name='everymonth']").val();
                    if (remindInterval == '') {
                        layer.msg('请输入每月多少号提醒。', { icon: 2 });
                        return;
                    }

                    var day = parseInt(remindInterval, 10);
                    if ((day < 1 || day > 31) || !/^\d+$/.test(remindInterval)) {
                        layer.msg('请输入1到31之间的数字。', { icon: 2 });
                        return;
                    }

                    if (!/^[1-9]\d*$/.test(remindInterval)) {
                        layer.msg('请去掉数字前面额外的零。', { icon: 2 });
                        return;
                    }
                }

                if (option.length > CHECK_OPINION_MAX_LENGTH) {
                    layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                    return;
                }
                requestParameter = { smId: smId, flowid: flowid, remindType: remindType, remindInterval: remindInterval, action: actionFlag[action], option: option, opinionType: opinionType, flowids: [], deptids: [] };
            } else {
                var option = $("#textarea2").val();
                if (option == '') option = '不同意';
                if (option.length > CHECK_OPINION_MAX_LENGTH) {
                    layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                    return;
                }
                var checkDepts = $("#page2ReturnDept :checked");
                var flowids = [];
                var deptids = [];
                for (var k = 0; k < checkDepts.length; k++) {
                    var fid = $(checkDepts[k]).data("flowid");
                    if (fid) flowids.push(fid);
                    var did = $(checkDepts[k]).data("deptid");
                    if (did) deptids.push(did);
                }

                if (flowids.length < 1) {
                    layer.msg("请选择退回的主办单位。", { icon: 2 });
                    return;
                } else {
                    requestParameter = { smId: smId, flowid: 0, remindType: -1, remindInterval: -1, action: actionFlag[action], option: option, opinionType: opinionType, flowids: flowids, deptids: deptids };
                }
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage2",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        $(document).ready(function () {
            var smid = getQueryString("smid");
            $.ajax({
                type: "POST",
                data: JSON.stringify({ smId: smid }),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetPrevStepInformationForBgtmbqr",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var list = data.d.myData;
                        var strHtml = "<div class='checkbox'><label><input class='check-all' type='checkbox' data-deptname='' data-deptid='' data-flowid='' data-smid='' />全选</label></div>";
                        for (var i = 0; i < list.length; i++) {
                            var items = list[i].split('|');
                            strHtml += "<div class='checkbox'><label><input type='checkbox' data-deptname='" + items[0] + "' data-deptid='" + items[1] + "' data-flowid='" + items[2] + "' data-smid='" + items[3] + "' />" + items[0] + "</label></div>";
                        }
                        $("#page2ReturnDept").html(strHtml);
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });

            // 判断是否还有主办部门未到达BGTMBQR步骤，如果存在未到达则隐藏“同意”按钮。
            $.ajax({
                type: "POST",
                data: JSON.stringify({ smId: smid }),
                url: "WebServices/SuperviseMissionWebServices.asmx/IsAllPass",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var isPassed = data.d.data;
                        if (isPassed == "0") {
                            $('#btn2Agree').attr('disabled', true);
                        }
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });
        <% } %>

        <%if (page == 3)
    { %>
        // 【退回】。
        $('#backModal3').on('show.bs.modal', function (e) {
            var $releated = $(e.relatedTarget);
            var targetId = $releated.attr('data-targetid');
            var flowId = $releated.attr('data-flowid');
            if (flowId == '' || flowId == undefined) {
                layer.msg("目标尚未反馈，无需退回。", { icon: 2, time: 1500 });
                return false;
            }

            $('#backTargetId3').val(targetId);
            $('#backFlowId3').val(flowId);
        });

        // 【退回-确定】。
        $(document).on('click', '[data-sure="agree"]', function (e) {
            var smId = getQueryString('smid');
            var flowId = $('#backFlowId3').val();
            var targetId = $('#backTargetId3').val();
            var opinion = jQuery.trim($('#backReason3').val());
            if (opinion == '' || opinion == undefined) {
                layer.msg("退回原因不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion.length > BACK_OPINION_MAX_LENGTH) {
                layer.msg("退回原因的字符数不能大于" + BACK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    TargetId: targetId,
                    Opinion: opinion,
                    OpinionType: '8',
                    FlowId: flowId
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/BackPreviousStep3",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg("退回成功。", { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });

            // 隐藏退回模态对话框。
            $('#backModal3').modal('hide');
        });

        //非当前用户的子措施的展开/收起事件
        $(document).on('click', '[data-status]', function (e) {
            var $this = $(e.target);
            var status = $this.attr('data-status');

            if (status === 'hide') {
                $this.attr('data-status', 'show');
                $this[0].innerText = '<收起';
            }
            else if (status === 'show') {
                $this.attr('data-status', 'hide');
                $this[0].innerText = '展开>';
            }
        });

        // 【同意】。
        $(document).on('click', '[data-target="#agreeModal"]', function (e) {
            // 每次打开同意模态框要把原先的旧值清空。
            $('#finishPercent3').val('');
            $('#opinion3').val('');

            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");

            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    StepId: getQueryString('stepid')
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStep2",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        // 追加节点时要先清空原有的。
                        $("#stepItem3").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);
                        $('#flowDeptId3').val(stepObj.FlowDeptId);// 设置流程部门Id。
                        $('#opinion3').val(stepObj.Opinion);      // 设置所有子措施反馈的意见。
                        if (stepObj.NextStep.StepFreeList != null) {
                            for (var i = 0; i < stepObj.NextStep.StepFreeList.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj.NextStep.StepFreeList[i]["NextStepId"] + '" data-stepname="' + stepObj.NextStep.StepFreeList[i]["NextStepName"] + '">' + stepObj.NextStep.StepFreeList[i]["NextStepName"] + '</a></li>';
                                $("#stepItem3").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        })

        // 【同意-确定】。
        $(document).delegate('#surePage3', 'click', function (e) {
            var stepId = $('#stepItem3 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem3 .active [data-stepid]').data('stepname');
            var finishPercent = $('#finishPercent3').val();
            var opinion = $('#opinion3').val();
            var userId = '';
            var deptId = '';
            var userName = '';
            var deptName = '';

            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (finishPercent === '' || finishPercent === undefined) {
                layer.msg("任务进度不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion === '' || opinion === undefined) {
                layer.msg("反馈意见不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion.length > TASK_OPINION_MAX_LENGTH) {
                layer.msg("反馈意见的字符数不能大于" + TASK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            if (stepId == undefined || stepId == '') {
                layer.msg("请选择下一步骤。", { icon: 2, time: 1500 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2, time: 1500 });
                return;
            }

            if (stepId.toLowerCase() == 'js') {
                if (!confirm('你确定要结束流程吗?')) return;
            }

            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    StepId: stepId,
                    StepName: stepName,
                    FlowDeptId: deptId,
                    DeptName: deptName,
                    UserId: userId,
                    UserName: userName,
                    Opinion: opinion,
                    OpinionType: '7',
                    FinishPercent: finishPercent
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage3",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        })

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            // 追加用户节点时要先清空旧数据。
            $("#userItem3").children('div').remove();
            var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString("smid");
            var flowDeptId = $('#flowDeptId3').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门。
                return;
            }

            var requestParameter = { deptId: flowDeptId, stepId: stepId, smId: smId, targetId: '', itemId: '', flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem3").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        })



        <%}%>

        <% if (page == 4)
    {%>
        $(document).on("click", "[name='btn4']", function (e) {
            var smId = getQueryString("smid");
            var flowid = getQueryString("flowid");
            var action = e.target.id;
            var actionFlag = { "btn4Agree": 1, "btn4DisAgree": 0 };
            var option = $("#textarea4").val();
            var opinionType = $('.f-so .form-control').find('option:selected').val();

            if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
                layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
                return;
            }

            if (option == '' || option == undefined) {
                if (actionFlag[action] == 1) option = '同意';
                else option = '不同意';
            }

            if (option.length > CHECK_OPINION_MAX_LENGTH) {
                layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            var requestParameter = { smId: smId, flowid: flowid, action: actionFlag[action], option: option, opinionType: opinionType };

            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage4",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                }
            });
        });
        <%}%>

     <% if (page == 12)
    { %>
        /*主办单位新建目标和措施*/
        //默认状态
        var thatState = 0, thatDept = 'company', thatChild = 0
        //状态管理
        var state = [];
        //获取状态
        var getter = {
            getIndex: function () {
                return state.length
            },
            getChildIndex: function () {
                return state[thatState].child.length
            },
            //获取当前部门
            getDept: function () {
                return state[thatState].child[thatChild][thatDept]
            },
        }

        //设置状态
        var setter = {
            setThatState: function (st) {
                thatState = st - 1
            },
            setThatChild: function (st) {
                thatChild = st - 1
            },
            setThatDept: function (t) {
                thatDept = t
            },
            setIndex: function () {
                var sn = {
                    targetId: '',
                    title: '',
                    text: '',
                    child: [],
                    isDel: false
                }
                state.push(sn)
            },
            setStep: function () {
                var sn = {
                    itemId: '',
                    text: '',
                    company: {},
                    endTime: '',
                    office: {},
                    isDel: false
                };
                state[thatState].child.push(sn);
            },
            //选中单位
            selectDept: function (key, value) {
                state[thatState].child[thatChild][thatDept][key.toString()] = value
            },
            //设置键值
            setValue: function (key, value) {
                state[thatState].child[thatChild][key] = value
            },
            //不选择单位
            unselectDept: function (key) {
                delete state[thatState].child[thatChild][thatDept][key]
            },
            //清除单位
            clearDept: function () {
                state[thatState].child[thatChild][thatDept] = {}
            },
            //设置单位
            setDeptInArea: function () {
                var html = []
                var depts = getter.getDept()
                for (var dept in depts) {
                    if (dept) {
                        $('input[value="' + dept + '"]').prop('checked', true);
                        html.push('<span ', 'data-deptid="', dept, '">', depts[dept], ';</span>');
                    }
                }
                return html.join('')
            }
        }

        //textarea高度自适应
        function resetArea(selector) {
            var cName = selector ? ('textarea' + selector) : 'textarea';
            $(document).on("keyup", cName, function () {
                var $this = $(this);
                if (!$this.attr('initAttrH')) {
                    $this.attr('initAttrH', $this.outerHeight());
                }
                $this.css({ height: $this.attr('initAttrH'), 'overflow-y': 'hidden' }).height(this.scrollHeight - 16);
            });
        }
        resetArea();

        var deptGroup;
        //获取部门组列表。
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetGroupListByUser",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                deptGroup = JSON.parse($(data).find("data").text());
                bindDeptGroup();
            },
            error: function (message) {
                layer.msg("获取部门组列表失败。", { icon: 2, time: 1000 });
            }
        });

        function bindDeptGroup() {
            var deptGroupHtml = '<option disabled="disabled" style="display:none;" selected="selected">请选择部门组</option><option value="">全部</option>';
            var template = $("#deptGroupTemplate").html();
            for (var i = 0; i < deptGroup.length; i++) {
                deptGroupHtml = deptGroupHtml + '<option value="' + deptGroup[i].DeptIds + '">' + deptGroup[i].GroupName + '</option>'
            }
            Mustache.parse(template);
            var rendered = Mustache.render(template, { deptGroupHtml: deptGroupHtml });
            $("[name='groupSelect']").append(rendered);

            $("[name='groupSelect']").on('change', function (e) {
                var $this = $(e.target);
                $this.closest('.clearfix').find('.search-dept').val("");
                var deptIds = $this.val();
                bindDept("", deptIds);
                if (thatDept === 'company') {
                    $('#company').find('.choose-area .radio').hide()
                    $('#company').find('.choose-area .checkbox').show()
                }
                if (thatDept === 'office') {
                    $('#company').find('.choose-area .checkbox').hide()
                    $('#company').find('.choose-area .radio').show()
                }
            });

            $(".sdept").on('click', function (e) {
                var $this = $(e.target);
                var deptName = $this.closest('.clearfix').find('.search-dept').val();
                $this.closest('.clearfix').find('.dept-group-input').val("");
                bindDept(deptName, "");
            });
        }

        var dept;
        //获取部门列表。
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetAllActiveDeptList",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                dept = JSON.parse($(data).find("data").text());
                bindDept("", "");
            },
            error: function (message) {
                layer.msg("获取部门组列表失败。", { icon: 2, time: 1000 });
            }
        });

        function bindDept(deptName, deptIds) {
            var deptHtml = '';
            var template = $("#deptTemplate").html();
            for (var i = 1; i < dept.length; i++) {
                if (dept[i].DeptName !== '') {
                    if (deptIds === "" && deptName === "") {
                        deptHtml = deptHtml +
                            '<li><div class="radio"><label><span class="iconfont icon-sv-tree"></span>' +
                            dept[i].DeptName +
                            '<input type="radio" name="deptRadio" value="' +
                            dept[i].DeptId +
                            '" /></label></div><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' +
                            dept[i].DeptName +
                            '<input type="checkbox" name="deptCheckbox" value="' +
                            dept[i].DeptId +
                            '" /></label></div></li>'
                    } else if (deptIds !== "") {
                        var deptIdList = deptIds.split(',');
                        if (IsInArray(deptIdList, dept[i].DeptId)) {
                            deptHtml = deptHtml +
                                '<li><div class="radio"><label><span class="iconfont icon-sv-tree"></span>' +
                                dept[i].DeptName +
                                '<input type="radio" name="deptRadio" value="' +
                                dept[i].DeptId +
                                '" /></label></div><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' +
                                dept[i].DeptName +
                                '<input type="checkbox" name="deptCheckbox" value="' +
                                dept[i].DeptId +
                                '" /></label></div></li>'
                        }
                    } else {
                        if (dept[i].DeptName.indexOf(deptName) !== -1) {
                            deptHtml = deptHtml +
                                '<li><div class="radio"><label><span class="iconfont icon-sv-tree"></span>' +
                                dept[i].DeptName +
                                '<input type="radio" name="deptRadio" value="' +
                                dept[i].DeptId +
                                '" /></label></div><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' +
                                dept[i].DeptName +
                                '<input type="checkbox" name="deptCheckbox" value="' +
                                dept[i].DeptId +
                                '" /></label></div></li>'
                        }
                    }
                }
                function IsInArray(arr, val) {
                    var testStr = ',' + arr.join(",") + ",";
                    return testStr.indexOf("," + val + ",") != -1;
                }
            }

            Mustache.parse(template);
            var rendered = Mustache.render(template, { deptHtml: deptHtml });
            $(".choose-area").empty();
            $(".choose-area").append(rendered);
        }

        //双击删除
        $(document).on('dblclick', '.result-area span', function (e) {
            var $this = $(this)
            var dept = $this.data('deptid')
            setter.unselectDept(dept)
            $('#company li').find('input[value="' + dept + '"]').prop('checked', false)
            $this.remove();
        });
        //协办单位
        $(document).on('click', '[data-target="#company"]', function (e) {
            var $this = $(e.target);
            var dept = $this.data('dept');
            var key = $this.closest('[data-key]').data('key');
            var index = $this.closest('[data-index]').data('index');
            //设置当前状态
            setter.setThatState(index);
            //设置当前单位
            setter.setThatDept(dept);
            $('#resultArea').html(setter.setDeptInArea());
        });

        //重置
        $(document).on('click', '[data-modal-btn="reset"]', function (e) {
            var $this = $(this);
            $this.closest('.modal-body').find('.result-area').html('');
            $this.closest('.modal-body').find('.search-dept').val("");
            $this.closest('.modal-body').find("[name='groupSelect']")[0].options[0].selected = true;
            bindDept("", "");
            for (var key in getter.getDept()) {
                setter.unselectDept(key)
                $('.choose-area input[value="' + key + '"]').prop('checked', false);
            }

            if (thatDept === 'company') {
                $('#company').find('.choose-area .radio').hide();
                $('#company').find('.choose-area .checkbox').show();
            }

            if (thatDept === 'office') {
                $('#company').find('.choose-area .checkbox').hide();
                $('#company').find('.choose-area .radio').show();
            }
        });

        //判断是否存在已分解的年度目标，存在则遍历输出年度目标和对应的措施
        var postData = { smId: getQueryString("smid") };
        var existedTargetAndItems = false; // 用于提交按钮控制，表示当前用户所在的主办单位是否存在目标和措施(一般地，如果存在编辑权限说明该主办单位已存在目标和措施)。

        $.ajax({
            type: "POST",
            data: JSON.stringify(postData),
            url: "WebServices/SuperviseMissionWebServices.asmx/GetTargetAndTargetItemData",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var isPower = true; // 可否添加措施。
                    if (data.d.data !== '' && data.d.data !== null) {
                        var target = JSON.parse(data.d.data);
                        $.each(target, function (index, obj) {
                            // [{targetId: "18111000016", title: "", text: "年度目标1==》南航信息中心管理研发处;", child: Array(1), isDel: false},...n]
                            // child:[{itemId: "18111000017", text: "措施1==》南航信息中心管理研发处;", company: {…}, endTime: "2018-11-30", office: {…}}
                            var targetHtml = '';
                            var targetIndex = index + 1;
                            setter.setThatState(targetIndex)
                            //添加年度目标数组
                            setter.setIndex()
                            state[thatState].text = obj.TargetName;
                            state[thatState].targetId = obj.TargetId;
                            //1.输出年度目标HTML
                            targetHtml += '<div class="card card-box" data-index="' + targetIndex + '">';
                            targetHtml += '<div class="card-header" style="padding-top:15px;padding-left:0px;">';
                            targetHtml += '<h3 class="c">年度目标' + targetIndex + '</h3>';
                            targetHtml += '</div>';
                            targetHtml += '<div class="card-body year-target detail-line">';
                            targetHtml += '<div class="form-block" style="padding-left:0px;">';
                            targetHtml += '<div class="form-group">';
                            if (obj.IsSameDept) { // 是当前用户所在单位创建的可以编辑，否则不可以编辑。下同。
                                targetHtml += '<textarea name="ndText" data-name="ndText" class="form-control disabled" disabled="disabled" style="margin-left:0px;font-size:12px;margin-top:0px;">' + obj.TargetName + '</textarea>';
                                targetHtml += '<span class="iconfont icon-sv-trash delete-flag" style=""></span>';
                                existedTargetAndItems = true;
                            } else {
                                targetHtml += '<span>' + obj.TargetName + '</span>';
                            }

                            targetHtml += '<div class="form-group tac" style="display: none;">';
                            targetHtml += '<button type="button" class="btn btn-primary-s" data-toggle="modal" data-add="target-step" style="display: none;">添加</button>';
                            targetHtml += '<button type="button" class="btn btn-default-s" data-cancel="cancel" style="display: none;">取消</button>';
                            targetHtml += '</div>';
                            targetHtml += '</div>';
                            targetHtml += '</div>';
                            targetHtml += '</div>';

                            //2.输出措施HTML
                            $.each(obj.Item, function (itemIndex, itemObj) {
                                isPower = itemObj.IsSameDept;
                                //添加措施数组
                                setter.setStep();
                                state[thatState].child[itemIndex].itemId = itemObj.ItemId;
                                state[thatState].child[itemIndex].text = itemObj.ItemName;
                                state[thatState].child[itemIndex].endTime = itemObj.DeadLineFormat;
                                state[thatState].child[itemIndex]['company'][itemObj.AssDeptId] = itemObj.AssDeptName;    //协办单位
                                state[thatState].child[itemIndex]['office'][itemObj.DutyDeptId] = itemObj.DutyDeptName;    //责任处室
                                var targetItemIndex = itemIndex + 1;

                                targetHtml += '<div class="step-child card-box detail-line" data-key="' + targetItemIndex + '">';
                                targetHtml += '<div class="card-header">';
                                targetHtml += '<h3 class="title">';
                                targetHtml += '<span class="line"></span>措施' + targetItemIndex;
                                targetHtml += '</h3>';
                                if (itemObj.IsSameDept) {
                                    targetHtml += '<span class="iconfont icon-sv-trash" style=""></span>';
                                }
                                targetHtml += '</div>';
                                targetHtml += '<div class="card-body target-step">';
                                targetHtml += '<div class="form-child disabled">';
                                targetHtml += '<div class="form-group">';
                                if (itemObj.IsSameDept) {
                                    targetHtml += '<textarea name="csText" data-name="csText" class="form-control disabled aa" disabled="disabled" style="font-size:12px;margin-top:0px;">' + itemObj.ItemName + '</textarea>';
                                } else {
                                    targetHtml += '<span>' + itemObj.ItemName + '</span>';
                                }

                                targetHtml += '</div>';
                                targetHtml += '<div class="form-group tac">';
                                targetHtml += '<div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">';
                                targetHtml += '<label>协办单位</label>';
                                if (itemObj.IsSameDept) {
                                    targetHtml += '<input type="text" readonly="" class="form-control disabled" name="company" data-dept="company" data-toggle="modal" data-target="#company" disabled="disabled" value="' + itemObj.AssDeptName + '">';
                                    targetHtml += '<span class="iconfont icon-sv-add" data-dept="company" data-toggle="modal" data-target="#company"></span>';
                                } else {
                                    targetHtml += '<span>' + itemObj.AssDeptName + '</span>';
                                }
                                targetHtml += '</div>';
                                targetHtml += '<div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">';
                                targetHtml += '<label>完成时间</label>';
                                if (itemObj.IsSameDept) {
                                    targetHtml += '<input type="text" readonly="" data-date-format="yyyy-mm-dd" class="form-control input-time disabled" disabled="disabled" data-name="dataPicker" value="' + itemObj.DeadLineFormat + '">';
                                } else {
                                    targetHtml += '<span>' + itemObj.DeadLineFormat + '</span>';
                                }
                                targetHtml += '</div>';
                                targetHtml += '<div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">';
                                targetHtml += '<label>责任处室</label>';
                                if (itemObj.IsSameDept) {
                                    targetHtml += '<input type="text" readonly="" class="form-control disabled" name="office" data-dept="office" data-toggle="modal" data-target="#company" disabled="disabled" value="' + itemObj.DutyDeptName + '">';
                                    targetHtml += '<span class="iconfont icon-sv-add" data-dept="office" data-toggle="modal" data-target="#company"></span>';
                                } else {
                                    targetHtml += '<span>' + itemObj.DutyDeptName + '</span>';
                                }
                                targetHtml += '</div>';
                                targetHtml += '</div>';
                                targetHtml += '<div class="form-group tac">';
                                targetHtml += '<button type="button" class="btn btn-primary-s" data-add="finish">添加</button>';
                                targetHtml += '<button type="button" class="btn btn-default-s" data-cancel="">取消</button>';
                                targetHtml += '</div>';
                                targetHtml += '</div>';
                                targetHtml += '<div class="clearfix"></div>';
                                targetHtml += '</div>';
                                targetHtml += '</div>';

                                //输出措施后，可显示提交按钮
                                $('[data-btn="sure"]').show();
                            });

                            //3.输出"添加措施"HTML
                            if (isPower) targetHtml += '<div class="card-header step-first" style="margin-top:45px;"><h3 class="title"><span class="line"></span>添加措施</h3><span class="iconfont icon-sv-add" data-add="target-child"></span></div></div>';
                            //4.绑定到DOM树上
                            $('.first').before(targetHtml);

                            //5.执行日期控件初始化
                            showPicker();

                            //如果是ie，把input的diabled去掉(IE兼容)
                            if (navigator.userAgent.toUpperCase().indexOf('MSIE 8') >= 0) {
                                $("input[disabled='disabled']").each(function () {
                                    $(this).css({ 'margin-top': ' -2px', 'border-color': '#f2f8fd' });
                                    $(this).removeAttr('disabled');
                                    $(this).attr('unselectable', 'on');
                                });

                                $("textarea[disabled='disabled']").each(function () {
                                    $(this).css('border-color', '#fff');
                                    $(this).removeAttr('disabled');
                                    $(this).attr('unselectable', 'on');
                                });
                            };
                        });
                    }

                } else {
                    layer.msg(data.d.message, { icon: 2, time: 1000 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常。", { icon: 2, time: 1000 });
            }
        });

        //新增年度目标表单面板。
        $(document).on('click', '[data-add="year-target"]', function (e) {
            var $this = $(e.target)
            var template = $('#targetTempl').html();
            setter.setIndex()
            Mustache.parse(template);
            var rendered = Mustache.render(template, { index: getter.getIndex() });
            $('.first').before(rendered)
        });

        // 添加目标
        $(document).on('click', '[data-add="target-step"]', function (e) {
            var $this = $(e.target);
            var $body = $this.closest('.card-body');
            var $box = $this.closest('.card-box');
            var $form = $this.closest('.form-group');
            var html = ['<div class="card-header step-first"><h3 class="title"><span class="line"></span>',
                '添加措施',
                '</h3 >',
                '<span class="iconfont icon-sv-add" data-add="target-child"></span>',
                '</div>'
            ];

            if ($.trim($box.find('.form-control').val()) === '') {
                layer.msg('目标名为必填项。', { icon: 2 });
                return;
            };

            if ($.trim($box.find('.form-control').val()).length > TARGET_NAME_MAX_LENGTH) {
                layer.msg('目标字符数不能大于' + TARGET_NAME_MAX_LENGTH + '个字符。', { icon: 2, time: 1500 });
                return;
            };

            $form.hide();
            $body.find('button').hide();
            $body.find('.form-control').attr('disabled', true).addClass('disabled');
            $body.find('.icon-sv-trash').show();
            $box.append(html.join(''));
            state[thatState].text = $box.find('.form-control').val();
        });

        // 新增措施表单面板。
        $(document).on('click', '[data-add="target-child"]', function (e) {
            var $this = $(e.target)
            var template = $('#stepTempl').html();
            var $index = $this.closest('[data-index]').data('index');
            var $box = $this.closest('.card-box')
            setter.setThatState($index)
            setter.setStep()
            Mustache.parse(template);
            var rendered = Mustache.render(template, { key: getter.getChildIndex() });
            $box.find('.step-first').before(rendered)
            showPicker()
        });

        // 添加父措施。
        $(document).on('click', '[data-add="finish"]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.card-box')
            var $key = $box.data('key')
            if ($.trim($box.find('.form-control').val()) === '') {
                layer.msg('措施不能为空。', { icon: 2 });
                return;
            }

            if ($.trim($box.find('.form-control').val()).length > TARGET_ITEM_NAME_MAX_LENGTH) {
                layer.msg('措施名字符数不能大于' + TARGET_ITEM_NAME_MAX_LENGTH + '个字符。', { icon: 2, time: 1500 });
                return;
            }

            if ($.trim($box.find('.input-time').val()) === '') {
                layer.msg('完成时间不能为空。', { icon: 2 });
                return
            }
            if ($.trim($box.find('[name="office"]').val()) === '') {
                layer.msg('责任处室不能为空。', { icon: 2 });
                return
            }
            $this.closest('.form-child').addClass('disabled')
            $this.closest('.form-child').find('.form-control').attr('disabled', true).addClass('disabled')
            existedTargetAndItems = true; // 标识用户添加了目标和措施。
            $('[data-btn="sure"]').show(); // 显示【提交】按钮。
            $box.find('.icon-sv-trash').show()
            state[thatState].child[$key - 1].text = $box.find('.form-control').val()
            state[thatState].child[$key - 1].endTime = $box.find('.input-time').val()
        });

        //取消
        $(document).on('click', '[data-cancel]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.card-box')
            var $cIndex = $this.closest('[data-index]').data('index')
            var $index = $box.data('index')
            var $key = $box.data('key')
            $box.remove()
            if ($index)
                state[$index - 1].isDel = true
            if ($key)
                state[$cIndex - 1].child[$key - 1].isDel = true
        });

        //搜搜部门
        var depts = [];

        $(document).on('click', '.sdept', function (e) {
            var $this = $(e.target)
            var $input = $this.closest('.input-group').find('input')
            var $area = $('.choose-area .checkbox label')
            if (thatDept === 'company') {
                $('#company').find('.choose-area .radio').hide()
                $('#company').find('.choose-area .checkbox').show()
            }
            if (thatDept === 'office') {
                $('#company').find('.choose-area .checkbox').hide()
                $('#company').find('.choose-area .radio').show()
            }
            $area.each(function () {
                depts.push($.trim($(this).text()))
            })
        });
        //回车查询
        $(document).keydown(function (event) {
            var $this = $(event.target)
            if (event.keyCode == 13) {
                $('form').each(function () {
                    event.preventDefault();
                });

                if ($this.next().hasClass('input-group-addon')) {
                    $this.next().trigger('click')
                }
            }
        });

        //部门弹窗多选
        $('#company').on('shown.bs.modal', function (e) {
            $(this).find('input').prop('checked', false)
            $(this).find('.result-area').empty()
            $(this).find('.result-area').html(setter.setDeptInArea())
        });

        //部门弹窗多选
        $('#company').on('hidden.bs.modal', function (e) {
            var html = setter.setDeptInArea().replace(/<span.*?>(.*?)<\/span>/ig, '$1')
            $('.card-box[data-index="' + (thatState + 1) + '"] [data-key="' + (thatChild + 1) + '"] [name="' + thatDept + '"]').val(html)
        });

        //确认部门
        $(document).on('click', '[data-btn="deptSure"]', function (e) {
            var html = setter.setDeptInArea().replace(/<span.*?>(.*?)<\/span>/ig, '$1')
            $('.card-box[data-index="' + (thatState + 1) + '"] [data-key="' + (thatChild + 1) + '"] [name="' + thatDept + '"]').val(html)
            $('#company').modal('hide')
        });

        //重置部门
        $(document).on('click', '[data-btn="deptCancel"]', function (e) {
            var $this = $(this)
            $this.closest('.modal-body').find('.result-area').html('')
            for (var key in getter.getDept()) {
                setter.unselectDept(key)
                $('.choose-area input[value="' + key + '"]').prop('checked', false)
            }
            if (thatDept === 'company') {
                $('#company').find('.choose-area .radio').hide()
                $('#company').find('.choose-area .checkbox').show()
            }
            if (thatDept === 'office') {
                $('#company').find('.choose-area .checkbox').hide()
                $('#company').find('.choose-area .radio').show()
            }
        });

        //选择部门
        $(document).on('change', '.choose-area', function (e) {
            var $this = $(e.target);
            var name = $this.val();
            var text = $.trim($this.parent().text());
            if (thatDept === 'office') {
                setter.clearDept();
            };
            if ($this.is(':checked')) {
                setter.selectDept(name, text)
            } else {
                setter.unselectDept(name)
            };
            $('.result-area').html(setter.setDeptInArea());
        });

        //协办单位还是责任处室
        $(document).on('click', '[data-target="#company"]', function (e) {
            var $this = $(e.target)
            var dept = $this.data('dept')
            var key = $this.closest('[data-key]').data('key')
            var index = $this.closest('[data-index]').data('index')
            //设置当前状态
            setter.setThatState(index)
            //设置当前措施
            setter.setThatChild(key)
            //设置当前单位
            setter.setThatDept(dept)
            if (thatDept === 'company') {
                $('#company').find('.choose-area .radio').hide()
                $('#company').find('.choose-area .checkbox').show()
            }
            if (thatDept === 'office') {
                $('#company').find('.choose-area .checkbox').hide()
                $('#company').find('.choose-area .radio').show()
            }
            $('#company').find('input').prop('checked', false)
            $('#company').find('.result-area').empty()
            $('#company').find('.result-area').html(setter.setDeptInArea)
        });

        //点击修改
        $(document).on('click', '.form-group', function (e) {
            var $this = $(e.target)
            $this.removeClass('disabled').prop('disabled', false)
            $this.next('.icon-sv-add').show()
        });

        //时间控件
        function showPicker() {
            $('.input-time').datetimepicker({
                language: 'zh-CN',
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startDate: new Date(),
                startView: 2,
                minView: 2,
                forceParse: 0
            }).on('changeDate', function (ev) {
                setter.setValue('endTime', ev.target.value)
            });
        }

        //点击显示日历
        $(document).on('click', '.input-time', function () {
            $(this).datetimepicker('show');
        });

        //移开保存
        $(document).on('blur', '.form-control', function (e) {
            var $this = $(e.target)
            var isAdd = $this.closest('.card-body').find('[data-cancel]')
            var $box = $this.closest('[data-index]')
            var $kBox = $this.closest('[data-key]')
            var $index = $box.data('index')
            var $key = $kBox.data('key')
            var $name = $this.get(0).tagName.toLowerCase();
            var $attr = $this.attr('data-name')
            if ($index)
                setter.setThatState($index)
            if ($key)
                setter.setThatChild($key)
            if ($attr === 'ndText') {
                state[thatState].text = $this.val()
            }
            if ($attr === 'csText') {
                state[thatState].child[thatChild].text = $this.val()
            }
            if (isAdd.is(':hidden')) {
                $this.addClass('disabled').prop('disabled', true)
                $this.next('.icon-sv-add').hide()
            }
        });

        // 删除目标或措施。
        $(document).on('click', '.icon-sv-trash', function (e) {
            var $this = $(e.target);
            $('#deleteModal').modal('show');
            var $box = $this.closest('[data-index]');
            var $index = $box.data('index');
            var $key = $this.closest('.card-box').data('key');
            if ($index && $this.hasClass('delete-flag')) {
                if ($key) {
                    $('#tips').text('当前年度目标存在措施，是否将年度目标和措施一并删除？').attr('data-index', $index).removeAttr('data-key', '');
                } else {
                    $('#tips').text('确定删除该年度目标吗？').attr('data-index', $index).removeAttr('data-key', '');
                }
            } else {
                $('#tips').text('确定删除该措施吗？').attr('data-key', $key).attr('data-index', $index);
            }
        });

        // 确认删除。
        $(document).on('click', '[data-delete="sure"]', function (e) {
            var $this = $(e.target).closest('.modal-content').find('p')
            var $index = $this.attr('data-index');
            var $key = $this.attr('data-key');
            if ($key && $index) {
                // 删除的是措施。
                $('.card-box[data-key="' + $key + '"]').remove();
                state[$index - 1].child[$key - 1].isDel = true
            } else {
                // 删除的是目标。
                state[$index - 1].isDel = true
                $('.card-box[data-index="' + $index + '"]').remove();
                // 判断是否存在年度目标，如果没有则隐藏“提交”按钮。20181205
                var isExistedTarget = false;
                $.each(state, function (i, e) {
                    if (!e.isDel) {
                        isExistedTarget = true;
                        return false;
                    }
                });

                if (!isExistedTarget) {
                    $('[data-btn="sure"]').hide();
                }
            }

            $this.removeAttr('data-index').removeAttr('data-key')
            $('#deleteModal').modal('hide')
        });

        function getCodeAndName(item) {
            var keyValues = { keys: "", values: "" };
            var keys = "";
            var values = "";
            for (var key in item) {
                keys += key + ";";
                values += item[key] + ";";
            }
            if (keys !== "") {
                keys = keys.substring(0, keys.length - 1);
            }
            if (values !== "") {
                values = values.substring(0, values.length - 1);
            }
            keyValues.keys = keys;
            keyValues.values = values;

            return keyValues;
        };

        // 【提交】。
        $(document).on('click', '#bt12Submit', function () {
            if ($('#LbSmId').text() == '') {
                layer.msg('无效的任务。', { icon: 2 });
                return;
            }

            if (!existedTargetAndItems) {
                layer.msg('请分解本主办单位的年度目标和措施。', { icon: 2 });
                return;
            }

            $(this).attr('disabled', true).text('提交中...');
            var smId = getQueryString("smid");
            var flowid = getQueryString("flowid");
            var data = { smId: smId, flowid: flowid, targets: [], removeModel: null };
            var removeData = { TargetIds: [], TargetItemIds: [] };
            for (var i = 0; i < state.length; i++) {
                if (!state[i].isDel) {
                    var targetId = state[i].targetId;
                    var targetName = state[i].text;
                    var Target = { TargetId: targetId, TargetName: targetName, Item: [] };
                    for (var k = 0; k < state[i].child.length; k++) {
                        if (!state[i].child[k].isDel) {
                            var ItemId = state[i].child[k].itemId;
                            var ItemName = state[i].child[k].text;
                            var AssDeptName = getCodeAndName(state[i].child[k].company).values;
                            var AssDeptId = getCodeAndName(state[i].child[k].company).keys;
                            var DeadLine = state[i].child[k].endTime;
                            var DutyDeptName = getCodeAndName(state[i].child[k].office).values;
                            var DutyDeptId = getCodeAndName(state[i].child[k].office).keys;
                            var TargetItem = { ItemId: ItemId, ItemName: ItemName, AssDeptName: AssDeptName, AssDeptId: AssDeptId, DeadLine: DeadLine, DutyDeptName: DutyDeptName, DutyDeptId: DutyDeptId };
                            Target.Item.push(TargetItem);
                        }
                        else {
                            //获取已有的且被移除的措施ID
                            var ItemId = state[i].child[k].itemId;
                            if (ItemId !== '' && ItemId !== null && ItemId !== undefined) {
                                removeData.TargetItemIds.push(ItemId);
                            }

                        }
                    }
                    data.targets.push(Target);
                }
                else {
                    //获取已有的且被移除的年度目标ID
                    var targetId = state[i].targetId;
                    if (targetId !== '' && targetId !== null && targetId !== undefined) {
                        removeData.TargetIds.push(targetId);
                    }
                }
            }
            data.removeModel = removeData;

            // 判断年度目标、措施是否存在有必填项未填或长度超长等情况。
            var isSuccess = true;
            var msg = '';

            for (var i = 0; i < data.targets.length; i++) {
                if (data.targets[i].TargetName == '') {
                    msg = '目标名为必填项。';
                    isSuccess = false;
                    break;
                }

                if (data.targets[i].Item.length == 0) {
                    msg = '年度目标' + (i + 1) + '不能没有措施。';
                    isSuccess = false;
                    break;
                }

                if (data.targets[i].TargetName.length > TARGET_NAME_MAX_LENGTH) {
                    msg = '年度目标' + (i + 1) + '的字符数不能大于' + TARGET_NAME_MAX_LENGTH + '个字符。';
                    isSuccess = false;
                    break;
                }

                for (var j = 0; j < data.targets[i].Item.length; j++) {
                    if (data.targets[i].Item[j].ItemName == '') {
                        msg = '措施名为必填项。';
                        isSuccess = false;
                        break;
                    }

                    if (data.targets[i].Item[j].ItemName.length > TARGET_ITEM_NAME_MAX_LENGTH) {
                        msg = '措施名长度不能大于' + TARGET_ITEM_NAME_MAX_LENGTH + '个字符。';
                        isSuccess = false;
                        break;
                    }

                    if (data.targets[i].Item[j].DeadLine == '') {
                        msg = "完成时间为必填项。";
                        isSuccess = false;
                        break;
                    }

                    if (data.targets[i].Item[j].DutyDeptId == '') {
                        msg = "责任处室为必填项。";
                        isSuccess = false;
                        break;
                    }
                }
                if (!isSuccess) break;
            }

            if (!isSuccess) {
                layer.msg(msg, { icon: 2, time: 1500 });
                $('#bt12Submit').removeAttr('disabled').text('提交');
                return;
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage12",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                        $('#bt12Submit').removeAttr('disabled').text('提交');
                    } else {
                        layer.msg("目标分解完成。", { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 1 });
                    $('#bt12Submit').removeAttr('disabled').text('提交');
                }
            });
        });
        <% } %>

        <% if (page == 13)
    { %>
        //默认状态
        var thatState = 0, thatDept = 'company'
        //状态管理
        var state = []
        //获取状态
        var getter = {
            getIndex: function () {
                return state.length
            },
            getChildIndex: function () {
                return state[thatState].length
            },
            //获取当前部门
            getDept: function () {
                return state[thatState][thatDept]
            },
            getThatState: function () {
                return thatState
            }
        }
        //设置状态
        var setter = {
            setThatState: function (st) {
                thatState = st - 1
            },
            setThatDept: function (t) {
                thatDept = t
            },
            setValue: function (name, value) {
                state[thatState][name] = value
            },
            setIndex: function () {
                var sn = {
                    text: '',
                    company: {},
                    endTime: '',
                    office: {},
                    uName: '',
                    uNo: '',
                    uDept: '',
                    targetId: '',
                    measureId: '',
                    isDel: true      //默认为true,确认添加后，更改为false By hexingjian
                }
                state.push(sn)
            },
            //选中单位
            selectDept: function (key, value) {
                state[thatState][thatDept][key.toString()] = value
            },
            //不选择单位
            unselectDept: function (key) {
                delete state[thatState][thatDept][key]
            },
            //清除单位
            clearDept: function () {
                state[thatState][thatDept] = {}
            },
            //设置单位
            setDeptInArea: function () {
                var html = []
                var depts = getter.getDept()
                for (var dept in depts) {
                    if (dept) {
                        $('input[value="' + dept + '"]').prop('checked', true);
                        html.push('<span data-deptid="' + dept + '">', depts[dept], ';</span>');
                    }
                }
                return html.join('')
            },
            //设置责任人
            setEmpInArea: function () {
                var name = state[thatState].uName
                var no = state[thatState].uNo
                var dept = state[thatState].uDept
                var html = []
                if (name)
                    html.push('<span data-name="' + name + '" data-empid="' + no + '" data-dept="' + dept + '">' + name + '(' + no + ')</span>');
                return html.join('')
            }
        }
        var deptGroup;
        //获取部门组列表。
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetGroupListByUser",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                deptGroup = JSON.parse($(data).find("data").text());
                bindDeptGroup();
            },
            error: function (message) {
                layer.msg("获取部门组列表失败！", { icon: 2, time: 1000 });
            }
        });
        //双击删除
        $(document).on('dblclick', '.result-area span', function (e) {
            var $this = $(this)
            var dept = $this.data('deptid')
            var empid = $this.data('empid')

            if (dept) {
                setter.unselectDept(dept)
                $('#company li').find('input[value="' + dept + '"]').prop('checked', false)
            }
            if (empid) {
                setter.setValue('uName', '')
                setter.setValue('uNo', '')
                setter.setValue('uDept', '')
                $('#leaderModal li').find('input').prop('checked', false)
            }
            $this.remove();
        });
        //textarea高度自适应
        $(document).on("keyup", 'textarea', function () {
            var $this = $(this);
            if (!$this.attr('initAttrH')) {
                $this.attr('initAttrH', $this.outerHeight());
            }
            $this.css({ height: $this.attr('initAttrH'), 'overflow-y': 'hidden' }).height(this.scrollHeight - 16);
        })
        function bindDeptGroup() {
            var deptGroupHtml = '<option disabled="disabled" style="display:none;" selected="selected">请选择部门组</option><option value="">全部</option>';
            var template = $("#deptGroupTemplate").html();
            for (var i = 0; i < deptGroup.length; i++) {
                deptGroupHtml = deptGroupHtml + '<option value="' + deptGroup[i].DeptIds + '">' + deptGroup[i].GroupName + '</option>'
            }
            Mustache.parse(template);
            var rendered = Mustache.render(template, { deptGroupHtml: deptGroupHtml });
            $("[name='groupSelect']").append(rendered);

            $("[name='groupSelect']").on('change', function (e) {
                var $this = $(e.target);
                $this.closest('.clearfix').find('.search-dept').val("");
                var deptIds = $this.val();
                bindDept("", deptIds);
            });

            $(".sdept").on('click', function (e) {
                var $this = $(e.target);
                var deptName = $this.closest('.clearfix').find('.search-dept').val();
                $this.closest('.clearfix').find('.dept-group-input').val("");
                bindDept(deptName, "");
            });
        }

        var dept;
        //获取部门列表。
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetAllDeptList",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                dept = JSON.parse($(data).find("data").text());
                bindDept("", "");
            },
            error: function (message) {
                layer.msg("获取部门列表失败！", { icon: 2, time: 1000 });
            }
        });

        function bindDept(deptName, deptIds) {
            var deptHtml = '';
            var template = $("#deptTemplate").html();
            for (var i = 1; i < dept.length; i++) {
                if (dept[i].DeptName !== '') {
                    var deptCheck = '<input type="checkbox" name="deptRadio" value="' + dept[i].DeptId + '" />'
                    if (state[thatState] && getter.getDept().hasOwnProperty(dept[i].DeptId)) {
                        deptCheck = '<input checked type="checkbox" name="deptRadio" value="' + dept[i].DeptId + '" />'
                    }
                    if (deptIds === "" && deptName === "") {
                        deptHtml = deptHtml +
                            '<li><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' +
                            dept[i].DeptName +
                            deptCheck +
                            '</label></div></li>'
                    } else if (deptIds !== "") {
                        var deptIdList = deptIds.split(',');
                        if (IsInArray(deptIdList, dept[i].DeptId)) {
                            deptHtml = deptHtml +
                                '<li><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' +
                                dept[i].DeptName +
                                deptCheck +
                                '"</label></div></li>'
                        }
                    } else {
                        if (dept[i].DeptName.indexOf(deptName) !== -1) {
                            deptHtml = deptHtml +
                                '<li><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' +
                                dept[i].DeptName +
                                deptCheck +
                                '</label></div></li>'
                        }
                    }
                }
                function IsInArray(arr, val) {
                    var testStr = ',' + arr.join(",") + ",";
                    return testStr.indexOf("," + val + ",") != -1;
                }
            }
            Mustache.parse(template);
            var rendered = Mustache.render(template, { deptHtml: deptHtml });
            $("#company .choose-area").empty();
            $("#company .choose-area").append(rendered);
        }
        //重置
        $(document).on('click', '[data-modal-btn="reset"]', function (e) {
            var $this = $(this)
            $this.closest('.modal-body').find('.result-area').html('');
            $this.closest('.modal-body').find('.search-dept').val("");
            $this.closest('.modal-body').find("[name='groupSelect']")[0].options[0].selected = true;
            bindDept("", "");
            for (var key in getter.getDept()) {
                setter.unselectDept(key)
                $('.choose-area input[value="' + key + '"]').prop('checked', false)
            }

        });

        //取消
        $(document).on('click', '[data-cancel]', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.card-box');
            $box.remove();
        });

        //时间控件
        function showPicker() {
            $('.input-time').datetimepicker({
                language: 'zh-CN',
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                startDate: new Date(),
                todayHighlight: 1,
                startView: 2,
                minView: 2,
                forceParse: 0
            }).on('changeDate', function (ev) {
                setter.setValue('endTime', ev.target.value);
            });
        }
        //点击显示日历
        $(document).on('click', '.input-time', function () {
            $(this).datetimepicker('show');
        })

        //确认责任人
        $(document).on('click', '#btConfirmSelectAssLeader', function (e) {
            var html = setter.setEmpInArea().replace(/<span.*?>(.*?)<\/span>/ig, '$1');
            $('.detail-part[data-index="' + (thatState + 1) + '"] [name="office"]').val(html).attr('title', html);
            $('#leaderModal').modal('hide');
        });
        //选择责任人
        $(document).on('change', '#ulAssLeader', function (e) {
            var $this = $(e.target)
            var name = $this.val()
            var $box = $this.closest('li')
            var text = $.trim($this.parent().text())
            var uName = $box.data('name')
            var uNo = $box.data('empid')
            var uDept = $box.data('dept')
            if ($this.is(':checked')) {
                setter.setValue('uName', uName)
                setter.setValue('uNo', uNo)
                setter.setValue('uDept', uDept)
            } else {
                setter.setValue('uName', '')
                setter.setValue('uNo', '')
                setter.setValue('uDept', '')
            }
            $('#assLeaderSelectedList').html(setter.setEmpInArea())
        });

        // 添加子措施面板。
        $(document).on('click', '[data-add="add-step-child"]', function (e) {
            var $this = $(e.target)
            var template = $('#steoChildTempl').html();
            setter.setIndex()
            Mustache.parse(template);
            var rendered = Mustache.render(template, { index: getter.getIndex() });
            $this.closest('.detail-opera').before(rendered)
            showPicker()
            //获取设置子措施对应的年度目标ID和措施ID
            var measureid = $this.closest('[data-measureid]').data('measureid')
            var targetid = $this.closest('[data-targetid]').data('targetid')
            var $index = $this.parent().prev().data('index')
            setter.setThatState($index)  //先设置索引
            setter.setValue('measureId', measureid)
            setter.setValue('targetId', targetid)
        });

        // 添加子措施。
        $(document).on('click', '[data-add="finishStep"]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.detail-part')
            var flag = false;
            $.each($box.find('.form-control'), function (index, obj) {
                var field = $(obj).attr('field-name');// 获取到当前表单域的字段名。
                var value = jQuery.trim($(obj).val());// 获取当前表单域的输入的值。
                var msg = '';
                // 字段的合法性检查,除协办单位是可选项，其余为必填项。
                if (field != 'assistdept') {
                    if (value == '') {
                        if (field == 'itemname') msg = "子措施名不能为空。";
                        if (field == 'dutylinetime') msg = "完成时间不能为空。";
                        if (field == 'excutorname') msg = "责任人不能为空。";
                        flag = true;
                    }

                    if (field == 'itemname' && value.length > TARGET_ITEM_NAME_MAX_LENGTH) {
                        flag = true;
                        msg = "子措施名字符数不能大于" + TARGET_ITEM_NAME_MAX_LENGTH + "个字符。";
                    }

                    if (flag) {
                        layer.msg(msg, { icon: 2, time: 1500 });
                        return false;
                    }
                }
            });

            if (flag) {
                return false;
            }

            $this.closest('.form-child').addClass('disabled')
            $this.closest('.form-child').find('.form-control').attr('disabled', true).addClass('disabled')
            $('[data-btn="send"]').show()
            $box.find('.icon-sv-trash').show()

            state[thatState].text = $box.find('.form-control').val()
            state[thatState].endTime = $box.find('.input-time').val()
            //设置该组数据isDel=false
            state[thatState].isDel = false
        });

        $(document).on('click', '[data-cancel]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.card-box')
            $box.remove()
        })

        //搜搜部门
        var depts = []
        $(document).on('click', '.sdept', function (e) {
            var $this = $(e.target)
            var $input = $this.closest('.input-group').find('input')
            var $area = $('.choose-area .checkbox label')
            $area.each(function () {
                depts.push($.trim($(this).text()))
            })
        });

        //协办单位
        $(document).on('click', '[data-target="#company"]', function (e) {
            var $this = $(e.target);
            var dept = $this.data('dept');
            var key = $this.closest('[data-key]').data('key');
            var index = $this.closest('[data-index]').data('index');
            //设置当前状态
            setter.setThatState(index);
            //设置当前单位
            setter.setThatDept(dept);
            $('#resultArea').html(setter.setDeptInArea());
        });

        //责任人
        $(document).on('click', '[data-target="#leaderModal"]', function (e) {
            var $this = $(e.target);
            var dept = $this.data('dept');
            var index = $this.closest('[data-index]').data('index');
            //设置当前状态
            setter.setThatState(index);

            $('#assLeaderSelectedList').html(setter.setEmpInArea());
        });

        //部门弹窗多选
        $('#company').on('show.bs.modal', function (e) {
            $(this).find('input').prop('checked', false);
        });

        //责任人隐藏
        $('#leaderModal').on('hidden.bs.modal', function (e) {
            $('#ulAssLeader').empty();
            $('#textAssLeader').val('');
            $('#assLeaderSelectedList').empty();
        });

        //部门弹窗多选

        //确认部门
        $(document).on('click', '[data-btn="deptSure"]', function (e) {
            var html = setter.setDeptInArea().replace(/<span.*?>(.*?)<\/span>/ig, '$1')
            $('.detail-part[data-index="' + (thatState + 1) + '"] [name="' + thatDept + '"]').val(html).attr('title', html)
            $('#company').modal('hide')
        });

        //重置部门
        $(document).on('click', '[data-btn="deptCancel"]', function (e) {
            var $this = $(this)
            $this.closest('.modal-body').find('.result-area').html('')
            for (var key in getter.getDept()) {
                setter.unselectDept(key)
                $('.choose-area input[value="' + key + '"]').prop('checked', false)
            }
        });

        //选择部门
        $(document).on('change', '#company .choose-area', function (e) {
            var $this = $(e.target);
            var name = $this.val();
            var text = $.trim($this.parent().text());
            if ($this.is(':checked')) {
                setter.selectDept(name, text);
            } else {
                setter.unselectDept(name);
            }
            $('#resultArea').html(setter.setDeptInArea());
        });

        //搜索责任人
        $("#btSearchAssLeader").on("click", function () {
            var assLeader = $("#textAssLeader").val();
            if (assLeader == "")
                return;
            $.ajax({
                type: "POST",
                data: JSON.stringify({ UserId: assLeader }),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var jd = JSON.parse(data.d.data);
                        bindLeader(jd, ["ulAssLeader"]);
                    } else {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });

        //绑定责任人
        function bindLeader(data, ids) {
            var html = "";
            for (var i = 0; i < data.length; i++) {
                //console.log($('#' + ids).closest('.choose-area').next().find('[data-empid="' + data[i].Employee_ID + '"]').length)
                var input = '<input type="radio" name="emp"/>';
                if ($('#' + ids).closest('.choose-area').next().find('[data-empid="' + data[i].Employee_ID + '"]').length > 0) {
                    input = '<input type="radio" checked="true" name="emp"/>';
                }
                html += ' <li data-dept="' + data[i].Dept_Name + '" data-name=' + data[i].Name + ' data-empid=' + data[i].Employee_ID + '><div class="radio"><label><span class="iconfont icon-sv-user"></span>' + data[i].Name + "（" + data[i].Employee_ID + "）-" + data[i].Dept_Name + input + '</label></div>';
            }
            for (var item in ids) {
                $("#" + ids[item]).empty().append(html);
            }
        }

        //点击修改
        $(document).on('click', '.form-group', function (e) {
            var $this = $(e.target)
            $this.removeClass('disabled').prop('disabled', false)
            $this.next('.icon-sv-add').show()
        });

        //移开保存
        $(document).on('blur', '.form-control', function (e) {
            var $this = $(e.target)
            var isAdd = $this.closest('.card-body').find('[data-cancel]')

            var $box = $this.closest('[data-index]')
            var $index = $box.data('index')
            var $name = $this.get(0).tagName.toLowerCase();
            var $attr = $this.attr('data-name')
            if ($index)
                setter.setThatState($index)
            if ($name === 'textarea' && $index) {
                state[thatState].text = $this.val()
            }
            if ($name === 'input' && $index && $attr === 'dataPicker') {  //新增data-name=dataPicker 条件，防止更改协办单位或责任处室时，日期被更改
                state[thatState].endTime = $this.val()
            }

            if (isAdd.is(':hidden')) {
                $this.addClass('disabled').prop('disabled', true)
                $this.next('.icon-sv-add').hide()
            }
        });

        //删除子措施提示
        $(document).on('click', '.icon-sv-trash', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.detail-part')
            var $index = $box.data('index')
            setter.setThatState($index)
            $('#tips').attr('data-index', $index)
            $('#deleteModal').modal('show')
        });

        //确认删除子措施
        $(document).on('click', '[data-delete="sure"]', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.modal-content');
            var $index = $box.find('#tips').attr('data-index');
            setter.setValue('isDel', true);
            $('.detail-part [data-index="' + $index + '"]').remove();
            $('#deleteModal').modal('hide');
        });

        //取消添加措施
        $(document).on('click', '[data-cancel="cancel"]', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.detail-part');
            var $index = $box.data('index');
            setter.setThatState($index);
            setter.setValue('isDel', true);
            $box.remove();
        });

        //回车查询
        $(document).keydown(function (event) {
            var $this = $(event.target)
            if (event.keyCode == 13) {
                $('form').each(function () {
                    event.preventDefault();
                });
                if ($this.next().hasClass('input-group-addon')) {
                    $this.next().trigger('click')
                }
            }
        });

        function getCodeAndName(item) {
            var keyValues = { keys: "", values: "" };
            var keys = "";
            var values = "";
            for (var key in item) {
                keys += key + ";";
                values += item[key] + ";";
            }
            keyValues.keys = keys;
            keyValues.values = values;
            return keyValues;
        };

        $(document).on('click', '#btn13Submit', function () {
            var smId = getQueryString("smid");
            var flowid = getQueryString("flowid");
            var data = { smId: smId, flowid: flowid, opinion: '分解子措施', opinionType: '4', subMeasures: [] };
            for (var i = 0; i < state.length; i++) {
                if (!state[i].isDel) {
                    var TargetId = state[i].targetId;
                    var MeasureId = state[i].measureId;
                    var ItemName = state[i].text;
                    var AssDeptName = getCodeAndName(state[i].company).values;
                    var AssDeptId = getCodeAndName(state[i].company).keys;
                    var DeadLine = state[i].endTime;
                    var DutyUserName = state[i].uName;
                    var DutyUserId = state[i].uNo;
                    var SubMeasureItem = { TargetId: TargetId, MeasureId: MeasureId, ItemName: ItemName, AssDeptName: AssDeptName, AssDeptId: AssDeptId, DeadLine: DeadLine, DutyUserName: DutyUserName, DutyUserId: DutyUserId };

                    data.subMeasures.push(SubMeasureItem);
                }
            }

            if (data.subMeasures == null || data.subMeasures.length == 0) {
                layer.msg("请添加子措施。", { icon: 2, time: 1500 });
                return;
            }

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage13",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });
        <% } %>



        <% if (page == 14)
    {%>
        $(document).on("click", "#btn14Send", function (e) {
            var smId = getQueryString("smid");
            var flowid = getQueryString("flowid");
            $.ajax({
                type: "POST",
                data: JSON.stringify({ smId: smId, flowid: flowid }),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage14",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        $(document).on('click', '#btnRedirect', function (e) {
            //跳转到措施反馈页面
            var smId = getQueryString("smid");
            var flowid = getQueryString("flowid");
            var stepid = 'CSFK';
            var smtype = 'ND';
            var url = 'SuperviseMissionDetail.aspx?smid=' + smId + '&flowid=' + flowid + '&smtype=' + smtype + '&stepid=' + stepid + '&subtype=&pagetype=FormPage';
            window.location.href = url;
        });
        <%}%>

        <% if (page == 10)
    {%>
        $(function () {
            //遍历并绑定附件列表信息
            var $attchmentUl = $('.attchmentList');
            if ($attchmentUl.length !== 0) {
                $.each($attchmentUl, function (index, obj) {
                    LoadAttchmentList($(obj), $(obj).data('targetitemid'));
                });
            }
        });

        //非当前用户的子措施的展开/收起事件
        $(document).on('click', '[data-status]', function (e) {
            var $this = $(e.target);
            var status = $this.attr('data-status');

            if (status === 'hide') {
                $this.attr('data-status', 'show');
                $this[0].innerText = '<收起';
            }
            else if (status === 'show') {
                $this.attr('data-status', 'hide');
                $this[0].innerText = '展开>';
            }
        });

        $(document).on('click', '[data-operateid]', function (e) {
            var $this = $(e.target);
            var flag = $this.attr('data-operate');
            if (flag === 'true') {
                $this.attr('data-operate', 'false');    //更新标识，只会触发一次展开操作
                $('#' + $this.data('operateid')).show();
                $('.enclosure-list').empty();
            }
        });

        $(document).on('click', '.btn10Submit', function (e) {
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var $this = $(e.target);
            var targetId = $this.attr('data-targetId');
            var itemId = $this.attr('data-itemId');
            var itemFlowId = $this.attr('data-flowid');
            //通过遍历输出子措施时的Id规则，获取对应的值
            var finishPercent = $.trim($('#' + itemId + '_FinshPrecent').val());
            var opinion = $.trim($('#' + itemId + '_Opinion').val());

            //参数检查
            if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                layer.msg("完成进度不能为空。", { icon: 2, time: 1500 });
                return false;
            }
            if (opinion === '' || opinion === undefined || opinion === null) {
                layer.msg("最新反馈不能为空。", { icon: 2, time: 1500 });
                return false;
            }
            if (opinion.length > CTI_OPINION_MAX_LENGTH) {
                layer.msg("最新反馈最大长度不能超过" + CTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return false;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    TargetId: targetId,
                    ItemId: itemId,
                    FinishPercent: finishPercent,
                    Opinion: opinion,
                    OpinionType: '7',
                    FlowId: itemFlowId
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage10",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg("操作成功。", { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });
        // 上传文件。
        uploadFile();
        function uploadFile(ele) {
            var SmId = '';
            $('input[type="file"]').fileupload({
                url: 'WebServices/SuperviseMissionWebServices.asmx/SaveSuperviseMissionAttachment',
                dataType: 'json',
                frame: true,
                maxFileSize: 1,
                add: function (e, data) {
                    SmId = $(e.target).data('targetitemid');
                    $.each(data.files, function (index, file) {
                        if (file.size && (file.size / 1024 / 1024) > 5) {
                            layer.msg("文件不能大于5M！", { icon: 2 });
                            return;
                        }
                    });
                    data.formData = {
                        SmId: $(e.target).data('targetitemid')
                    }
                    data.submit();
                },
                error: function (ex, textStatus, errorThrown) {
                    //由于返回的是xml 不能走success的回调函数，在这里做判断。;
                    if (ex.responseText && ex.responseText.toString().indexOf('<status>1</status>') > -1) {
                        layer.msg("上传附件成功。");
                        //如果需要处理 在这里添加函数
                        //获取当前子措施对应的附件列表对象
                        var $ul = $('.attchmentList[data-targetitemid="' + SmId + '"]');
                        //执行重新绑定附件列表
                        LoadAttchmentList($ul, SmId);
                    }
                    else {
                        layer.msg("上传附件失败。", { icon:2,time:1000});
                        //如果需要处理 在这里添加函数
                    }
                }
            })
        }

        //删除文件
        $(document).on('click', '.icon-sv-fail', function (e) {
            var $this = $(e.target)
            var itemId = $this.data('itemid');
            var attachmentid = $this.data('attachmentid');
            if (confirm("是否确认该附件删除")) {
                //先调接口进行删除附件信息
                var jsonData = { SmId: itemId, AttachmentId: attachmentid };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/DeleteSuperviseMissionAttachmentByAttachmentId",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon:2,time:1000});
                            $this.parent('li').remove();
                        } else {
                            layer.msg(data.d.message, { icon:2,time:1000});
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon:2,time:1000});
                    }
                });
            }
        });
        <%}%>

        //措施处理
        <% if (page == 11)
    {%>
        $(document).on('click', '[data-operateid]', function (e) {
            var $this = $(e.target);
            var flag = $this.attr('data-operate');
            if (flag === 'true') {
                $this.attr('data-operate', 'false');    //更新标识，只会触发一次展开操作
                $('#' + $this.data('operateid')).show();
                $('.enclosure-list').empty();
            }
        });

        $(function () {
            //遍历并绑定附件列表信息
            var $attchmentUl = $('.attchmentList');
            if ($attchmentUl.length !== 0) {
                $.each($attchmentUl, function (index, obj) {
                    LoadAttchmentList($(obj), $(obj).data('targetitemid'));
                });
            }
        });

        //删除文件
        $(document).on('click', '.icon-sv-fail', function (e) {
            var $this = $(e.target)
            var itemId = $this.data('itemid');
            var attachmentid = $this.data('attachmentid');
            if (confirm("是否确认该附件删除")) {
                //先调接口进行删除附件信息
                var jsonData = { SmId: itemId, AttachmentId: attachmentid };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/DeleteSuperviseMissionAttachmentByAttachmentId",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon: 1, time: 1500 });
                            $this.parent('li').remove();
                        } else {
                            layer.msg(data.d.message, { icon: 2, time: 1500 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                    }
                });
            }
        });

        // 上传文件。
        uploadFile();
        function uploadFile(ele) {
            var SmId = '';
            $('input[type="file"]').fileupload({
                url: 'WebServices/SuperviseMissionWebServices.asmx/SaveSuperviseMissionAttachment',
                dataType: 'json',
                frame: true,
                maxFileSize: 1,
                add: function (e, data) {
                    SmId = $(e.target).data('targetitemid');
                    $.each(data.files, function (index, file) {
                        if (file.size && (file.size / 1024 / 1024) > 5) {
                            layer.msg("文件不能大于5M！", { icon: 2 });
                            return;
                        }
                    });
                    data.formData = {
                        SmId: $(e.target).data('targetitemid')
                    }
                    data.submit();
                },
                error: function (ex, textStatus, errorThrown) {
                    //由于返回的是xml 不能走success的回调函数，在这里做判断。;
                    if (ex.responseText && ex.responseText.toString().indexOf('<status>1</status>') > -1) {
                        layer.msg("上传附件成功。");
                        //如果需要处理 在这里添加函数
                        //获取当前子措施对应的附件列表对象
                        var $ul = $('.attchmentList[data-targetitemid="' + SmId + '"]');
                        //执行重新绑定附件列表
                        LoadAttchmentList($ul, SmId);
                    }
                    else {
                        layer.msg("上传附件失败。", { icon: 2 });
                        //如果需要处理 在这里添加函数
                    }
                }
            });
        }

        //措施进度保存事件
        $(document).on('click', '[data-save]', function (e) {
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var $this = $(e.target);
            var itemId = $this.attr('data-itemId');
            var itemFlowId = $this.attr('data-flowid');
            //通过遍历输出子措施时的Id规则，获取对应的值
            var finishPercent = $.trim($('#' + itemId + '_FinshPrecent').val());
            var opinion = $.trim($('#' + itemId + '_Opinion').val());

            //参数检查
            if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                layer.msg("完成进度不能为空。", { icon: 2 });
                return false;
            }
            if (opinion === '' || opinion === undefined || opinion === null) {
                layer.msg("最新反馈不能为空。", { icon: 2 });
                return false;
            }
            if (opinion.length > PTI_OPINION_MAX_LENGTH) {
                layer.msg("最新反馈最大长度不能超过" + PTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return false;
            }

            save11(smId, flowId, itemId, finishPercent, opinion, itemFlowId, true, false);
        });

        // 保存进度和最新反馈。
        function save11(smId, flowId, itemId, finishPercent, opinion, itemFlowId, isNeedTips, isSendSave) {
            var data = {
                requestParameter: {
                    SmId: smId,
                    IsSendSave: isSendSave,
                    ItemId: itemId,
                    FinishPercent: finishPercent,
                    Opinion: opinion,
                    OpinionType: '7',
                    FlowId: itemFlowId
                }
            };
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SavePage11",
                cache: false,
                async: false,
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        if (isNeedTips) layer.msg("保存成功。", { icon: 1, time: 1000 });
                    } else {
                        if (isNeedTips) layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    if (isNeedTips) layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        }

        // 保存时先检查参数。
        function checkAndSave11(targetId) {
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var saveBtns = $('[data-save-targetid="' + targetId + '"]');
            var saveItems = [];
            for (var i = 0; i < saveBtns.length; i++) {
                var $this = $(saveBtns[i]);
                var itemId = $this.attr('data-itemId');
                var itemFlowId = $this.attr('data-flowid');
                //通过遍历输出子措施时的Id规则，获取对应的值
                var finishPercent = $.trim($('#' + itemId + '_FinshPrecent').val());
                var opinion = $.trim($('#' + itemId + '_Opinion').val());

                //参数检查
                if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                    $('#' + itemId + '_FinshPrecent').focus();
                    layer.msg("完成进度不能为空。", { icon: 2 });
                    return false;
                }
                if (opinion === '' || opinion === undefined || opinion === null) {
                    $('#' + itemId + '_Opinion').focus();
                    layer.msg("最新反馈不能为空。", { icon: 2 });
                    return false;
                }
                if (opinion.length > PTI_OPINION_MAX_LENGTH) {
                    layer.msg("最新反馈最大长度不能超过" + PTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                    return false;
                }

                var item = { smId: smId, flowId: flowId, entity: { itemId: itemId, finishPercent: finishPercent, opinion: opinion, itemFlowId: itemFlowId } };
                saveItems.push(item);
            }

            for (var i = 0; i < saveItems.length; i++) {
                save11(saveItems[i].smId, saveItems[i].flowId, saveItems[i].entity.itemId, saveItems[i].entity.finishPercent, saveItems[i].entity.opinion, saveItems[i].entity.itemFlowId, false, true);
            }

            return true;
        }

        // 【进度发送】
        $('#agreeModal').on('show.bs.modal', function (e) {
            var $this = $(e.target);
            var $releated = $(e.relatedTarget); //获取触发器的元素（即哪个年度目标对应的"进度发送"按钮对象）

            //将年度目标ID赋值给模态框的确定按钮相应的属性
            var targetId = $releated.attr('data-targetid');
            $('#btn11Submit').attr('data-targetId', targetId);

            // 判断措施的完成进度和意见有没有填写。
            var saveBtns = $('[data-save-targetid="' + targetId + '"]');
            for (var i = 0; i < saveBtns.length; i++) {
                var $this = $(saveBtns[i]);
                var itemId = $this.attr('data-itemId');
                //通过遍历输出子措施时的Id规则，获取对应的值
                var finishPercent = $.trim($('#' + itemId + '_FinshPrecent').val());
                var opinion = $.trim($('#' + itemId + '_Opinion').val());

                if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                    $('#' + itemId + '_FinshPrecent').focus();
                    layer.msg("完成进度不能为空。", { icon: 2 });
                    return false;
                }
                if (opinion === '' || opinion === undefined || opinion === null) {
                    $('#' + itemId + '_Opinion').focus();
                    layer.msg("最新反馈不能为空。", { icon: 2 });
                    return false;
                }
                if (opinion.length > PTI_OPINION_MAX_LENGTH) {
                    layer.msg("最新反馈最大长度不能超过" + PTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                    return false;
                }
            }

            // 清空目标进度和反馈意见。
            $('#TargetPercent').val('');
            $('#TargetOpinion').val('');

            //绑定下一步骤列表信息(目前只会请求一次)
            var stepListObj = $('#stepList').children();
            if (stepListObj.length === 0) {
                var requestParameter = { stepid: 'CSFK', smType: "ND", subType: getQueryString("subtype") };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(requestParameter),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStepFreeList",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            if (data.d.data !== '' && data.d.data !== null) {
                                var stepList = JSON.parse(data.d.data);
                                $('#stepList').html('');// 先清空原有旧的步骤。
                                var html = '';          // 步骤项(li)。
                                var htmlForUser = '';   // 处理人html(右侧的用户或部门)。
                                var tabid = '';         // 选中的步骤tabid
                                var stepid = '';        // 选中的步骤ID
                                // 遍历拼接步骤项。
                                $.each(stepList, function (index, obj) {
                                    if (index === 0) {
                                        // 设置第1个步骤为默认选中状态。
                                        html += '<li role="presentation" class="active"><a href="#tab' +
                                            index +
                                            '" aria-controls="home" role="tab" data-toggle="tab" data-tabid="tab' + index + '" data-stepid="' +
                                            obj.NextStepId +
                                            '">' +
                                            obj.NextStepName +
                                            '</a></li>';
                                        stepid = obj.NextStepId;
                                        tabid = 'tab' + index;

                                        htmlForUser += '<div role="tabpanel" class="tab-pane active" id="tab' + index + '"></div>';
                                    } else {
                                        html += '<li role="presentation"><a href="#tab' +
                                            index +
                                            '" aria-controls="profile" role="tab" data-toggle="tab" data-tabid="tab' + index + '" data-stepid="' +
                                            obj.NextStepId +
                                            '">' +
                                            obj.NextStepName +
                                            '</a></li>';

                                        htmlForUser += '<div role="tabpanel" class="tab-pane" id="tab' + index + '"></div>';
                                    }
                                });

                                $('#stepList').append(html);//绑定步骤
                                $('#stepUserList').append(htmlForUser);//添加处理人信息呈现所在的div

                                if (stepid !== '') {
                                    //加载默认选中步骤的处理人信息
                                    BindStepUserList(tabid, stepid);
                                }
                            }
                        } else {
                            layer.msg(data.d.message, { icon: 2, time: 1500 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                    }
                });
            }
        });

        //监听步骤点击事件
        $(document).on('show.bs.tab', function (e) {
            var $this = $(e.target);
            var stepid = $this.data('stepid');
            var tabid = $this.data('tabid');
            BindStepUserList(tabid, stepid);
        });

        //加载步骤对应的处理人信息(只请求一次)
        function BindStepUserList(tabId, stepId) {
            var smId = getQueryString("smid");
            var flowid = getQueryString("flowid");
            var targetId = $('#btn11Submit').data('targetid');
            var $userDiv = $('#' + tabId).children();
            if ($userDiv.length == 0) {
                var jsonData = { smId: smId, flowid: flowid, stepId: stepId, targetId: targetId }
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStepFree",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            if (data.d.data !== '' && data.d.data !== null) {
                                var stepUserList = JSON.parse(data.d.data);
                                var html = '';
                                // 遍历拼接右侧的用户或部门。
                                $.each(stepUserList, function (index, obj) {
                                    if (index == 0) {
                                        html += '<div class="radio"><label><input type="radio" name="nextStepUser" value="' + obj.MemberId + '" data-roletype="' + obj.RoleType + '" checked="checked"/>' + obj.MemberName + '</label></div>';
                                    } else {
                                        html += '<div class="radio"><label><input type="radio" name="nextStepUser" value="' + obj.MemberId + '" data-roletype="' + obj.RoleType + '" />' + obj.MemberName + '</label></div>';
                                    }
                                });
                                $('#' + tabId).append(html);
                            }
                        } else {
                            layer.msg(data.d.message, { icon: 2, time: 1500 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                    }
                });
            }
        }

        //发送事件
        $(document).on('click', '#btn11Submit', function (e) {
            var $this = $(e.target);
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var $nextStep = $('#stepList').children('.active').children('a');
            var $nextStepUser = $('#stepUserList').children('.active').find('input[name="nextStepUser"]:checked');
            var targetId = $this.data('targetid');
            var finishPercent = $.trim($('#TargetPercent').val());
            var opinion = $.trim($('#TargetOpinion').val());
            var nextStepId = $nextStep.data('stepid');
            var nextStepName = $nextStep[0].innerText;
            var nextUserId = $nextStepUser.val();
            var nextUserName = $nextStepUser.parent()[0].innerText;
            var roleType = $nextStepUser.attr('data-roletype');

            if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                layer.msg("目标进度不能为空。", { icon: 2 });
                return false;
            }
            if (opinion === '' || opinion === undefined || opinion === null) {
                layer.msg("反馈意见不能为空。", { icon: 2 });
                return false;
            }
            if (opinion.length > TARGET_OPINION_MAX_LENGTH) {
                layer.msg("反馈意见最大长度不能超过" + TARGET_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return false;
            }
            if (nextStepId === '' || nextStepId === undefined || nextStepId === null) {
                layer.msg("请先选择下一步骤信息。", { icon: 2 });
                return false;
            }
            if (nextStepName === '' || nextStepName === undefined || nextStepName === null) {
                layer.msg("请先选择下一步骤信息。", { icon: 2 });
                return false;
            }
            if (nextUserId === '' || nextUserId === undefined || nextUserId === null) {
                layer.msg("请先选择当前骤对应的处理部门/处理人信息。", { icon: 2 });
                return false;
            }

            // 1)先保存措施的进度和意见。
            checkAndSave11(targetId);

            // 2)发送下一步。
            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    TargetId: targetId,
                    FinishPercent: finishPercent,
                    Opinion: opinion,
                    OpinionType: '7',
                    StepId: nextStepId,
                    StepName: nextStepName,
                    UserId: nextUserId,
                    UserName: nextUserName,
                    RoleType: roleType
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage11",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });
        <%}%>

        <%if (page == 9)
    {%>
        // 【退回】。
        $('#backModal9').on('show.bs.modal', function (e) {
            var $releated = $(e.relatedTarget);
            var itemId = $releated.attr('data-itemid');
            var flowId = $releated.attr('data-flowid');

            if (flowId == '' || flowId == undefined) {
                layer.msg("子措施尚未反馈。", { icon: 2, time: 1500 });
                return false;
            }

            $('#backItemId9').val(itemId);
            $('#backFlowId9').val(flowId);
        });

        // 【退回-确定】。
        $(document).on('click', '[data-sure="agree"]', function (e) {
            var smId = getQueryString("smid");
            var flowId = $('#backFlowId9').val();
            var itemId = $('#backItemId9').val();
            var opinion = jQuery.trim($('#backReason9').val());

            if (opinion == '' || opinion == undefined) {
                layer.msg("退回原因不能为空。", { icon: 2, time: 1000 });
                return;
            }

            if (opinion.length > BACK_OPINION_MAX_LENGTH) {
                layer.msg("退回原因的字符数不能大于" + BACK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            var data = { requestParameter: { SmId: smId, ItemId: itemId, Opinion: opinion, FlowId: flowId, OpinionType: '8' } };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/BackPreviousStep9",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        layer.msg('退回成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });

            // 隐藏退回模态对话框。
            $('#backModal9').modal('hide');
        });

        // 【同意】。
        $('.agreeModal9').on('show.bs.modal', function (e) {
            // 每次打开同意模态框要把原先的旧值清空。
            $('#finishPercent9').val('');
            $('#opinion9').val('');
            $("#stepItem9").children('li').remove();
            $("#userItem9").children('div').remove();

            var $releated = $(e.relatedTarget);
            // 设置当前"同意"按钮所属哪个年度目标和哪个父措施。
            $('#targetId9').val($releated.attr('data-targetid'));
            $('#parentItemId9').val($releated.attr('data-parentitemid'));
            var smId = getQueryString("smid");
            var flowId = '';

            // 获取当前措施的任意子措施的flowid(且不为空)。
            var parentItemId = $releated.attr('data-parentitemid');  // 先获取父措施Id用于拼接指定规则class名的DOM元素。
            var $domCollection = $('.parent-item-id-' + parentItemId);// 获取所有子措施元素的"退回"按钮DOM元素。
            $.each($domCollection, function (index, element) {        // 遍历并获取任意子措施对应的flowid。
                flowId = $(element).attr('data-flowid');
                if (flowId != '' && flowId != undefined) {
                    return false;
                }
            });

            if (flowId == '' || flowId == undefined) {
                layer.msg("子措施尚未反馈，无需操作。", { icon: 2, time: 1500 });
                return false;// return false用于阻止模态框打开。
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    ItemId: $('#parentItemId9').val(),
                    StepId: getQueryString('stepid')
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStep2",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        // 追加节点时要先清空原有的。
                        $("#stepItem9").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);
                        $('#flowDeptId9').val(stepObj.FlowDeptId);// 设置流程部门Id。
                        $('#opinion9').val(stepObj.Opinion);      // 设置所有子措施反馈的意见。
                        if (stepObj.NextStep.StepFreeList != null) {
                            for (var i = 0; i < stepObj.NextStep.StepFreeList.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj.NextStep.StepFreeList[i]["NextStepId"] + '" data-stepname="' + stepObj.NextStep.StepFreeList[i]["NextStepName"] + '">' + stepObj.NextStep.StepFreeList[i]["NextStepName"] + '</a></li>';
                                $("#stepItem9").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });

        // 【同意-确定】。
        $(document).delegate('#surePage9', 'click', function (e) {
            var stepId = $('#stepItem9 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem9 .active [data-stepid]').data('stepname');
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var userId = '';
            var deptId = '';
            var userName = '';
            var deptName = '';
            var finishPercent = jQuery.trim($('#finishPercent9').val());
            var opinion = jQuery.trim($('#opinion9').val());
            var targetId = $('#targetId9').val();
            var parentItemId = $('#parentItemId9').val();
            // 当前选中的是用户类型。
            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }
            // 当前选中的是部门类型。
            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (finishPercent === '' || finishPercent === undefined) {
                layer.msg("措施进度不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion === '' || opinion === undefined) {
                layer.msg("反馈意见不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion.length > PTI_OPINION_MAX_LENGTH) {
                layer.msg("反馈意见最大长度不能超过" + PTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return false;
            }

            if (stepId == undefined) {
                layer.msg("请选择下一步骤。", { icon: 2, time: 1500 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    StepId: stepId,
                    StepName: stepName,
                    FlowDeptId: deptId,
                    DeptName: deptName,
                    UserId: userId,
                    UserName: userName,
                    Opinion: opinion,
                    OpinionType: '7',
                    FinishPercent: finishPercent,
                    TargetId: targetId,
                    ItemId: parentItemId
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage9",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            $("#userItem9").children('div').remove();
            var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString("smid");
            var flowdeptid = $('#flowDeptId9').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门。
                return;
            }

            // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
            var requestParameter = { deptId: flowdeptid, stepId: stepId, smId: smId, targetId: $('#targetId9').val(), itemId: '', flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        // 追加用户节点时要先清空旧数据。
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem9").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });
        <%} %>

        <%if (page == 8)
    {%>
        // 【退回】。
        $('#backModal8').on('show.bs.modal', function (e) {
            var $releated = $(e.relatedTarget);
            var itemId = $releated.attr('data-itemid');
            var flowId = $releated.attr('data-flowid');

            if (flowId == '' || flowId == undefined) {
                layer.msg("措施尚未反馈。", { icon: 2, time: 1500 });
                return false;
            }

            $('#backItemId8').val(itemId);
            $('#backFlowId8').val(flowId);
        });

        // 【退回-确定】。
        $(document).on('click', '[data-sure="agree"]', function (e) {
            var smId = getQueryString("smid");
            var flowId = $('#backFlowId8').val();
            var itemId = $('#backItemId8').val();
            var opinion = jQuery.trim($('#backReason8').val());

            if (opinion == '' || opinion == undefined) {
                layer.msg("退回原因不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion.length > BACK_OPINION_MAX_LENGTH) {
                layer.msg("退回原因的字符数不能大于" + BACK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            var data = { requestParameter: { SmId: smId, ItemId: itemId, Opinion: opinion, FlowId: flowId, OpinionType: '8' } };
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/BackPreviousStep8",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        layer.msg('退回成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });

            $('#backModal8').modal('hide');
        });

        // 【同意】。
        $('.agreeModal8').on('show.bs.modal', function (e) {
            // 每次打开同意模态框要把原先的旧值清空。
            $('#finishPercent8').val('');
            $('#opinion8').val('');
            $("#stepItem8").children('li').remove();
            $("#userItem8").children('div').remove();

            var $releated = $(e.relatedTarget);
            // 设置当前"同意"按钮所属哪个年度目标。
            $('#targetId8').val($releated.attr('data-targetid'));
            // 设置当前"同意"按钮所属的年度目标的flowid。
            $('#flowId8').val($releated.attr('data-flowid'));
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var requestParameter = { smId: smId, flowId: flowId };
            
            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    TargetId: $('#targetId8').val(),
                    StepId: getQueryString('stepid')
                }
            };

            // 获取下一步骤。
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStep2",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        // 追加节点时要先清空原有的。
                        $("#stepItem8").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);
                        $('#flowDeptId8').val(stepObj.FlowDeptId);// 设置流程部门Id。
                        $('#opinion8').val(stepObj.Opinion);      // 设置所有子措施反馈的意见。
                        if (stepObj.NextStep.StepFreeList != null) {
                            for (var i = 0; i < stepObj.NextStep.StepFreeList.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj.NextStep.StepFreeList[i]["NextStepId"] + '" data-stepname="' + stepObj.NextStep.StepFreeList[i]["NextStepName"] + '">' + stepObj.NextStep.StepFreeList[i]["NextStepName"] + '</a></li>';
                                $("#stepItem8").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });

        // 【同意-确定】。
        $(document).delegate('#surePage8', 'click', function (e) {
            var stepId = $('#stepItem8 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem8 .active [data-stepid]').data('stepname');
            var userId = '';
            var deptId = '';
            var userName = '';
            var deptName = '';
            var finishPercent = jQuery.trim($('#finishPercent8').val());
            var opinion = jQuery.trim($('#opinion8').val());
            var flowId = $('#flowId8').val();
            var smId = getQueryString("smid");
            var targetId = jQuery.trim($('#targetId8').val());
            // 当前选中的是用户。
            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }
            // 当前选中的是部门。
            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (finishPercent === '' || finishPercent === undefined) {
                layer.msg("目标进度不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion === '' || opinion === undefined) {
                layer.msg("反馈意见不能为空。", { icon: 2, time: 1500 });
                return;
            }

            if (opinion.length > TARGET_OPINION_MAX_LENGTH) {
                layer.msg("反馈意见字符数不能大于" + TARGET_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            if (stepId == undefined || stepId == '') {
                layer.msg("请选择下一步骤。", { icon: 2, time: 1500 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    TargetId: targetId,
                    FlowId: flowId,
                    StepId: stepId,
                    StepName: stepName,
                    FlowDeptId: deptId,
                    DeptName: deptName,
                    UserId: userId,
                    UserName: userName,
                    Opinion: opinion,
                    OpinionType: '7',
                    FinishPercent: finishPercent
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage8",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            // 追加用户节点时要先清空旧数据。
            $("#userItem8").children('div').remove();
            var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString("smid");
            var flowDeptId = $('#flowDeptId8').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门。
                return;
            }

            // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
            var requestParameter = { deptId: flowDeptId, stepId: stepId, smId: smId, targetId: '', itemId: '', flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem8").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });
        <%}%>

        //为单位添加标题
        $('.detail-col').find('.col:eq(0) span:eq(1),.col:eq(2) span:eq(1)').each(function () {
            $(this).attr('title', $(this).text())
        })

        //popover弹出框
        $(".pop").popover({
            placement: 'bottom',
            trigger: 'manual',
            html: true,
            content: function (e) {
                var html = $.trim($(this).closest('.rc').find('.rb').html());
                html = html.replace(/class=".*?"/ig, '');
                return '<div class="hl">' + html + '</div>';
            }
        });

        $(document).on('click', function (event) {
            var target = $(event.target);
            if (!target.hasClass('popover')
                && !target.hasClass('pop')
                && !target.hasClass('popover-content')
                && !target.hasClass('popover-title')
                && !target.hasClass('arrow')) {
                $('.pop').popover('hide');
            }
        });
        $(document).on('click', '.pop', function (event) {
            $('.pop').popover('hide');
            $(this).popover('toggle');
        });

      <%if (page == 15)
    {%>
        // 【同意】。
        $('#agreeModal15').on('show.bs.modal', function (e) {
            // 每次打开同意模态框要把原先的步骤项和用户(部门)项的旧值清空。
            $("#stepItem15").children('li').remove();
            $("#userItem15").children('div').remove();

            var smid = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var requestParameter = { smId: smid, flowId: flowId };
            var flowDeptId = '';

            // 1)获取流程部门Id。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetFlowDeptId",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        flowDeptId = data.d.data;
                        $('#flowDeptId15').val(flowDeptId);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });

            // 2)获取下一步骤。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStep389",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        // 追加节点时要先清空原有的。
                        $("#stepItem15").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);

                        if (stepObj.StepFreeList != null) {
                            for (var i = 0; i < stepObj.StepFreeList.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj.StepFreeList[i]["NextStepId"] + '" data-stepname="' + stepObj.StepFreeList[i]["NextStepName"] + '">' + stepObj.StepFreeList[i]["NextStepName"] + '</a></li>';
                                $("#stepItem15").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 【同意-确定】。
        $(document).delegate('#surePage15', 'click', function (e) {
            var stepId = $('#stepItem15 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem15 .active [data-stepid]').data('stepname');
            var userId = '';
            var deptId = '';
            var userName = '';
            var deptName = '';
            var opinion = jQuery.trim($('#opinion15').val());
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            /*var opinionType = $('.f-so .form-control').find('option:selected').val();

            if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
                layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
                return;
            }*/

            var opinionType = '';
            if (getQueryString('stepid').toLowerCase() == 'bmsh') opinionType = '10';
            else opinionType = '9';

            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (opinion == '' || opinion == undefined) opinion = '同意';
            if (opinion.length > CHECK_OPINION_MAX_LENGTH) {
                layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            if (stepId == '' || stepId == undefined) {
                layer.msg("请选择下一步骤。", { icon: 2, time: 1500 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                SmId: smId,
                FlowId: flowId,
                StepId: stepId,
                StepName: stepName,
                FlowDeptId: deptId,
                DeptName: deptName,
                UserId: userId,
                UserName: userName,
                Opinion: opinion,
                OpinionType: opinionType,
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify({ requestParameter: data }),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage15",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1000 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });

        // 【不同意】。
        $(document).on('click', '#disagree15', function (e) {
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var opinion = jQuery.trim($('#opinion15').val());
            //var opinionType = $('.f-so .form-control').find('option:selected').val();

            //if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
            //    layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
            //    return;
            //}
            var opinionType = '';
            if (getQueryString('stepid').toLowerCase() == 'bmsh') opinionType = '10';
            else opinionType = '9';

            if (opinion == '' || opinion == undefined) opinion = '不同意';

            if (opinion.length > CHECK_OPINION_MAX_LENGTH) {
                layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    Opinion: opinion,
                    OpinionType: opinionType
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/DisagreeSendPage15",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1000 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            // 追加用户节点时要先清空旧数据。
            $("#userItem15").children('div').remove();
            var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString('smid');
            var flowDeptId = $('#flowDeptId15').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门。
                return;
            }

            // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
            var requestParameter = { deptId: flowDeptId, stepId: stepId, smId: smId, targetId: '', itemId: '', flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem15").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });
        <%}%>


        // 撤回。
        $(document).on('click', '#rollBackPage1', function (e) {
            var data = { requestParameter: { smId: getQueryString("smid"), flowId: getQueryString("flowid") } };
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/RollBack",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        layer.msg('撤回成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        <%if (page == 16)
    {%>
        // 【反馈进度】
        $(document).on('click', '#btnRedirect16', function (e) {
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var stepId = 'ZRDWCSFK';
            var smType = 'ND';
            //跳转到page17并没有实际发送。
            var url = 'SuperviseMissionDetail.aspx?smid=' + smId + '&flowid=' + flowId + '&smtype=' + smType + '&stepid=' + stepId + '&subtype=&pagetype=FormPage';
            window.location.href = url;
        });

        // 【继续分解】
        $(document).on("click", "#btnSend16", function (e) {
            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var stepId = 'ZRCSFJZCS';
            var smType = 'ND';
            // 跳转到page13并没有实际发送。
            var url = 'SuperviseMissionDetail.aspx?smid=' + smId + '&flowid=' + flowId + '&smtype=' + smType + '&stepid=' + stepId + '&subtype=&pagetype=FormPage';
            window.location.href = url;
        });
        <%}%>

        <%if (page == 17)
    {%>
        $(function () {
            //遍历并绑定附件列表信息
            var $attchmentUl = $('.attchmentList');
            if ($attchmentUl.length !== 0) {
                $.each($attchmentUl, function (index, obj) {
                    LoadAttchmentList($(obj), $(obj).data('targetitemid'));
                });
            }
        });

        //删除文件
        $(document).on('click', '.icon-sv-fail', function (e) {
            var $this = $(e.target)
            var itemId = $this.data('itemid');
            var attachmentid = $this.data('attachmentid');
            if (confirm("确定要删除该附件吗？")) {
                //先调接口进行删除附件信息
                var jsonData = { SmId: itemId, AttachmentId: attachmentid };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/DeleteSuperviseMissionAttachmentByAttachmentId",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg("删除成功。", { icon: 1 });
                            $this.parent('li').remove();
                        } else {
                            layer.msg(data.d.message, { icon: 2 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                    }
                });
            }
        });

        // 上传文件。
        uploadFile();
        function uploadFile(ele) {
            var SmId = '';
            $('input[type="file"]').fileupload({
                url: 'WebServices/SuperviseMissionWebServices.asmx/SaveSuperviseMissionAttachment',
                dataType: 'json',
                frame: true,
                maxFileSize: 1,
                add: function (e, data) {
                    SmId = $(e.target).data('targetitemid');
                    $.each(data.files, function (index, file) {
                        if (file.size && (file.size / 1024 / 1024) > 5) {
                            layer.msg("文件不能大于5M！", { icon: 2 });
                            return;
                        }
                    });
                    data.formData = {
                        SmId: $(e.target).data('targetitemid')
                    }
                    data.submit();
                },
                error: function (ex, textStatus, errorThrown) {
                    //由于返回的是xml 不能走success的回调函数，在这里做判断。;
                    if (ex.responseText && ex.responseText.toString().indexOf('<status>1</status>') > -1) {
                        layer.msg("上传附件成功。");
                        //如果需要处理 在这里添加函数
                        //获取当前子措施对应的附件列表对象
                        var $ul = $('.attchmentList[data-targetitemid="' + SmId + '"]');
                        //执行重新绑定附件列表
                        LoadAttchmentList($ul, SmId);
                    }
                    else {
                        layer.msg("上传附件失败。", { icon: 2 });
                        //如果需要处理 在这里添加函数
                    }
                }
            })
        }

        // 【完成进度】文本框单击时触发。
        $(document).on('click', '[data-operateid]', function (e) {
            var $this = $(e.target);
            var flag = $this.attr('data-operate');
            if (flag === 'true') {
                $this.attr('data-operate', 'false');    //更新标识，只会触发一次展开操作
                $('#' + $this.data('operateid')).show();
                $('.enclosure-list').empty();
            }
        });

        // 【保存】。
        $(document).on('click', '[data-save]', function (e) {
            var smId = getQueryString("smid");
            var $this = $(e.target);
            var itemId = $this.attr('data-itemId');
            var itemFlowId = $this.attr('data-flowid');
            // 获取完成进度。
            var finishPercent = $.trim($('#finishPercent_' + itemId).val());
            // 获取最新反馈。
            var opinion = $.trim($('#opinion_' + itemId).val());

            if (itemFlowId == '') {
                layer.msg("该措施已被处理。", { icon: 2 });
                return;
            }

            //参数检查
            if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                layer.msg("完成进度不能为空。", { icon: 2 });
                return false;
            }

            if (opinion === '' || opinion === undefined || opinion === null) {
                layer.msg("最新反馈不能为空。", { icon: 2 });
                return false;
            }

            if (opinion.length > PTI_OPINION_MAX_LENGTH) {
                layer.msg("最新反馈字符数不能大于" + PTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return false;
            }

            if (itemFlowId == '') {
                layer.msg("措施不存在或已被处理。", { icon: 2 });
                return false;
            }

            save17(smId, itemId, opinion, itemFlowId, finishPercent, true, false);
        });

        // 保存进度和最新反馈。
        function save17(smId, itemId, opinion, itemFlowId, finishPercent, isNeedTips, isSendSave) {
            var data = {
                requestParameter: {
                    SmId: smId,
                    ItemId: itemId,
                    Opinion: opinion,
                    OpinionType: '7',
                    FlowId: itemFlowId,
                    FinishPercent: finishPercent,
                    IsSendSave: isSendSave
                }
            };
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SavePage17",
                cache: false,
                async: false,
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        if (isNeedTips) layer.msg("保存成功。", { icon: 1, time: 1500 });
                    } else {
                        if (isNeedTips) layer.msg(data.d.message, { icon: 2, time: 1500 });
                    }
                },
                error: function (xhr, textStatus) {
                    if (isNeedTips) layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        }

        // 【进度发送】。
        $('#agreeModalPage17').on('show.bs.modal', function (e) {
            // 每次打开同意模态框要把原先的旧值清空。
            $("#stepItem17").children('li').remove();
            $("#userItem17").children('div').remove();
            // 将当前触发的那个目标id和措施id取出来赋值给反馈对话框。
            var $releated = $(e.relatedTarget);
            var targetId = $releated.attr('data-targetid');  // 目标Id。
            var itemId = $releated.attr('data-itemid');      // 措施Id。
            var itemFlowId = $releated.attr('data-flowid');  // 措施对应待办的流程Id。
            $('#targetId17').val(targetId);
            $('#itemId17').val(itemId);
            $('#itemFlowId').val(itemFlowId);

            if (itemFlowId == '') {
                layer.msg("该措施已被处理。", { icon: 2, time: 1000 });
                return false;
            }

            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var requestParameter = { smId: smId, flowId: flowId };
            var requestParameter2 = { stepid: 'ZRDWCSFK', smType: 'ND', subType: '' };

            // 1)打开进度发送前先判断措施的进度和最新反馈有没有填。
            var finishPercent = jQuery.trim($('#finishPercent_' + itemId).val());
            var opinion = jQuery.trim($('#opinion_' + itemId).val());
            if (finishPercent === '' || finishPercent === undefined || finishPercent === null) {
                layer.msg("完成进度不能为空。", { icon: 2, time: 1000 });
                return false;
            }

            if (opinion === '' || opinion === undefined || opinion === null) {
                layer.msg("最新反馈不能为空。", { icon: 2, time: 1000 });
                return false;
            }

            if (opinion.length > PTI_OPINION_MAX_LENGTH) {
                layer.msg("最新反馈字符数不能大于" + PTI_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return false;
            }

            // 2)获取流程部门Id。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetFlowDeptId",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        $('#flowDeptId17').val(data.d.data);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });

            // 3)获取下一步骤。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter2),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStepFreeList",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1000 });
                    } else {
                        // 追加节点前要先清空原有的。
                        $("#stepItem17").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);
                        if (stepObj != null && stepObj.length > 0) {
                            for (var i = 0; i < stepObj.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj[i]["NextStepId"] + '" data-stepname="' + stepObj[i]["NextStepName"] + '">' + stepObj[i]["NextStepName"] + '</a></li>';
                                $("#stepItem17").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            $("#userItem17").children('div').remove(); // 先清空右侧的用户或部门列表。
            var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString("smid");
            var flowDeptId = $('#flowDeptId17').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门直接返回不处理。
                return;
            }

            // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
            var requestParameter = { deptId: flowDeptId, stepId: stepId, smId: smId, targetId: $('#targetId17').val(), itemId: $('#itemId17').val(), flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        // 追加用户节点时要先清空旧数据。
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem17").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '" />' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 【进度发送-确定】。
        $(document).delegate('#btnSubmit17', 'click', function (e) {
            var stepId = $('#stepItem17 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem17 .active [data-stepid]').data('stepname');
            var userId = '';// 存储当前选中的用户Id。
            var deptId = '';// 存储当前选中的部门Id。
            var userName = '';
            var deptName = '';
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var targetId = $('#targetId17').val();
            var itemId = $('#itemId17').val();
            var itemFlowId = $('#itemFlowId').val();

            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (stepId == undefined || stepId == '') {
                layer.msg("请选择下一步骤。", { icon: 2 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2 });
                return;
            }

            // 1)先保存措施的进度和最新反馈。
            var finishPercent = jQuery.trim($('#finishPercent_' + itemId).val());
            var opinion = jQuery.trim($('#opinion_' + itemId).val());
            save17(smId, itemId, opinion, itemFlowId, finishPercent, false, true);

            var data = {
                requestParameter: {
                    SmId: smId,
                    TargetId: targetId,
                    ItemId: itemId,
                    StepId: stepId,
                    StepName: stepName,
                    UserId: userId,
                    UserName: userName,
                    FlowDeptId: deptId,
                    DeptName: deptName,
                    FlowId: flowId,
                    OpinionType: '7'
                }
            };

            // 2)发送下一步。
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage17",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('发送成功。', { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });
        <%}%>

        <%if (page == 18)
    {%>
        // 【发送】。
        $('#agreeModal18').on('show.bs.modal', function (e) {
            var opinionType = $('.f-so .form-control').find('option:selected').val();

            if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
                layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
                return false;
            }

            // 每次打开同意模态框要把原先的步骤项和用户(部门)项的旧值清空。
            $("#stepItem18").children('li').remove();
            $("#userItem18").children('div').remove();

            var smId = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var requestParameter = { smId: smId, flowId: flowId, rn: Math.random() };

            // 1)获取流程部门Id。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetFlowDeptId",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        $('#flowDeptId18').val(data.d.data);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });

            // 2)获取下一步骤。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStep389",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        // 追加节点前要先清空原有的。
                        $("#stepItem18").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);
                        if (stepObj.StepFreeList != null) {
                            for (var i = 0; i < stepObj.StepFreeList.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj.StepFreeList[i]["NextStepId"] + '" data-stepname="' + stepObj.StepFreeList[i]["NextStepName"] + '">' + stepObj.StepFreeList[i]["NextStepName"] + '</a></li>';
                                $("#stepItem18").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 【发送-确定】。
        $(document).delegate('#sure18', 'click', function (e) {
            var stepId = $('#stepItem18 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem18 .active [data-stepid]').data('stepname');
            var userId = '';
            var deptId = '';
            var userName = '';
            var deptName = '';

            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (stepId == undefined || stepId == '') {
                layer.msg("请选择下一步骤。", { icon: 2, time: 1000 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2, time: 1000 });
                return;
            }

            var opinion = jQuery.trim($('#opinion18').val());
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var opinionType = $('.f-so .form-control').find('option:selected').val();

            if (opinionType == '0' || opinionType == '' || opinionType == undefined) {
                layer.msg("请选择意见类型。", { icon: 2, time: 1500 });
                return false;
            }

            if (opinion == '' || opinion == undefined) {
                opinion = "同意";
            }

            if (opinion.length > CHECK_OPINION_MAX_LENGTH) {
                layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1000 });
                return;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    StepId: stepId,
                    StepName: stepName,
                    FlowDeptId: deptId,
                    DeptName: deptName,
                    UserId: userId,
                    UserName: userName,
                    Opinion: opinion,
                    OpinionType: opinionType
                }
            };
            // 发送。
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage18",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2, time: 1500 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1000 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            $("#userItem18").children('div').remove(); // 先清空右侧的用户或部门列表。
            var tabno = $(e.target).data('tabno');     // 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString("smid");
            var flowDeptId = $('#flowDeptId18').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门直接返回不处理。
                return;
            }

            // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
            var requestParameter = { deptId: flowDeptId, stepId: stepId, smId: smId, targetId: '', itemId: '', flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        // 追加用户节点时要先清空旧数据。
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem18").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1000 });
                }
            });
        });
        <%}%>

        <%if (page == 19)
    {%>
        // 【同意】。
        $('#agreeModal19').on('show.bs.modal', function (e) {
            // 每次打开同意模态框要把原先的步骤项和用户(部门)项的旧值清空。
            $("#stepItem19").children('li').remove();
            $("#userItem19").children('div').remove();

            var smid = getQueryString("smid");
            var flowId = getQueryString("flowid");
            var requestParameter = { smId: smid, flowId: flowId };
            var flowDeptId = '';

            // 1)获取流程部门Id。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetFlowDeptId",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        flowDeptId = data.d.data;
                        $('#flowDeptId19').val(flowDeptId);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });

            // 2)获取下一步骤。
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStep389",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        // 追加节点时要先清空原有的。
                        $("#stepItem19").children('li').remove();
                        var stepObj = JSON.parse(data.d.data);

                        if (stepObj.StepFreeList != null) {
                            for (var i = 0; i < stepObj.StepFreeList.length; i++) {
                                var $li = '<li role="presentation"><a href="#tab' + (i + 1) + '" aria-controls="profile" role="tab" data-toggle="tab" data-tabno="tab' + (i + 1) + '" data-stepid="' + stepObj.StepFreeList[i]["NextStepId"] + '" data-stepname="' + stepObj.StepFreeList[i]["NextStepName"] + '">' + stepObj.StepFreeList[i]["NextStepName"] + '</a></li>';
                                $("#stepItem19").append($li);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 【同意-确定】。
        $(document).delegate('#surePage19', 'click', function (e) {
            var stepId = $('#stepItem19 .active [data-stepid]').data('stepid');
            var stepName = $('#stepItem19 .active [data-stepid]').data('stepname');
            var userId = '';
            var deptId = '';
            var userName = '';
            var deptName = '';
            var opinion = jQuery.trim($('#opinion19').val());
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var opinionType = '';
            if (getQueryString('stepid').toLowerCase() == 'gsldsh') opinionType = '10';
            else opinionType = '9';

            if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                userId = $('.tab-pane.active input:checked').val().split('|')[0];
                userName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                deptId = $('.tab-pane.active input:checked').val().split('|')[0];
                deptName = $('.tab-pane.active input:checked').val().split('|')[1];
            }

            if (opinion == '' || opinion == undefined) opinion = '同意';
            if (opinion.length > CHECK_OPINION_MAX_LENGTH) {
                layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            if (stepId == '' || stepId == undefined) {
                layer.msg("请选择下一步骤。", { icon: 2, time: 1500 });
                return;
            }

            if ((userId == '' && deptId == '') && (stepId != 'FKJS' && stepId != 'JS')) {
                layer.msg("请选择下一步骤的用户或部门。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                SmId: smId,
                FlowId: flowId,
                StepId: stepId,
                StepName: stepName,
                FlowDeptId: deptId,
                DeptName: deptName,
                UserId: userId,
                UserName: userName,
                Opinion: opinion,
                OpinionType: opinionType,
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify({ requestParameter: data }),
                url: "WebServices/SuperviseMissionWebServices.asmx/SendPage19",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1000 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2, time: 1500 });
                }
            });
        });

        // 【不同意】。
        $(document).on('click', '#disagree19', function (e) {
            var flowId = getQueryString("flowid");
            var smId = getQueryString("smid");
            var opinion = jQuery.trim($('#opinion19').val());
            var opinionType = '';
            if (getQueryString('stepid').toLowerCase() == 'gsldsh') opinionType = '10';
            else opinionType = '9';

            if (opinion == '' || opinion == undefined) opinion = '不同意';

            if (opinion.length > CHECK_OPINION_MAX_LENGTH) {
                layer.msg("审核意见的字符数不能大于" + CHECK_OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
                return;
            }

            var data = {
                requestParameter: {
                    SmId: smId,
                    FlowId: flowId,
                    Opinion: opinion,
                    OpinionType: opinionType
                }
            };

            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/SuperviseMissionWebServices.asmx/DisagreeSendPage19",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('操作成功。', { icon: 1, time: 1000 }, function () {
                            window.close();
                        });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });

        // 单击步骤列表项时触发。
        $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
            // 追加用户节点时要先清空旧数据。
            $("#userItem19").children('div').remove();
            var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
            var smId = getQueryString('smid');
            var flowDeptId = $('#flowDeptId19').val();
            var stepId = $(e.target).data('stepid');

            if (stepId == "FKJS" || stepId == "JS") {
                // FKJS或JS不存在用户或部门。
                return;
            }

            // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
            var requestParameter = { deptId: flowDeptId, stepId: stepId, smId: smId, targetId: '', itemId: '', flowId: getQueryString("flowid") };
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserListByStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        var userObj = JSON.parse(data.d.data);
                        if (userObj != null || userObj != undefined) {
                            var $div = '<div role="tabpanel" class="tab-pane active" id="' + tabno + '"></div>';
                            $("#userItem19").append($div)
                            for (var i = 0; i < userObj.length; i++) {
                                var $selectUserItem = '<div class="radio"><label><input type="radio" name="name" value="' + userObj[i]["MemberId"] + '|' + userObj[i]["MemberName"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
                                $("#" + tabno).append($selectUserItem);
                            }
                        }
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                }
            });
        });
        <%}%>

        //清除card的间距
        $('.detail-box').nextAll('.card').addClass('no-interval detail-line');
        //三种情况下剔除样式
        $('.detail-box').prev('.card').removeClass('no-interval detail-line');
        $('.detail-box').nextAll('.card:last').removeClass('no-interval detail-line');
        $('.detail-box').nextAll('.tac,.tar').prev('.card').removeClass('no-interval detail-line');

        //控制进度，小喇叭的显示隐藏
        $(document).find('span.process,span.process1,span.c-danger').each(function () {
            var $this = $(this);
            if ($this.html() == '%') {
                if ($this.parents('.card-body.detail-line').nextUntil('.cs.collapsed')) {
                    $this.parents('.card-box.card.card-box-1').css('padding-bottom', '30px');
                    $this.parents('.card-body.detail-line').nextUntil('.collapse.in').css({ 'margin-top': '30px', 'border-top': '1px dashed #e5e5e5' });
                    $this.parents('.card-body.detail-line').next('a.cs').css({ 'margin-top': '5px', 'border-top': 'none' });
                    $this.parents('.card-body.detail-line').css('border', 'none');
                };
                $this.parents('.detail-col').next('.detail-block').hide();
                $this.parent('.col').remove();

            };

        });
        //input编辑情况下进度，小喇叭的显示隐藏
        $(document).find('input.input-ch-text').each(function () {
            var $this = $(this);
            if ($this.val() == '%' && $this.attr('disabled')) {
                $this.parents('.detail-col').next().remove();
                $this.parent('.form-group').next().remove();
                $this.parent('.form-group').remove();
            } else if (!$this.val() == '' && $this.attr('disabled')) {
                //$this.val(function () {
                //    return this.value + '%'
                //});
                $this.css('cursor', 'auto');
            };

        });


        $(document).on('keyup', 'textarea,input', function (e) {
            var $this = $(this);
            var val = $this.val();
            //var newValue = val.replace(/\s/ig, '');
            var newValue = val;
            newValue = newValue.replace(/<[a-z][A-Z]*?\/*?>|<\/[a-z][A-Z]*?>/ig, '');
            $this.val(newValue);
        })

        $(document).on('blur', 'textarea,input[type="text"]', function (e) {
            var $this = $(this);
            var val = $this.val();
            //var newValue = val.replace(/\s/ig, '');
            var newValue = val;
            newValue = newValue.replace(/<[a-z][A-Z]*?\/*?>|<\/[a-z][A-Z]*?>/ig, '');
            $this.val(newValue);
        })

        //措施下的textarea
        $(".card-body .detail-block .form-group textarea").on('keyup', function (e) {
            var $this = $(e.target);
            if ($('.detail-block textarea').attr('class', 'form-control').val().length >= 80) {
                $this.css({ 'height': '52px', 'overflow': 'auto' });
                $this.parent('.form-group').css('margin-top', '10px');
            } else {
                $this.css({ 'height': '30px', 'overflow-y': 'hidden' });
                $this.parent('.form-group').css('margin-top', '5px')
            };

        });

        //添加年度目标的textarea高度问题
        $(document).on('keyup', "textarea[name='ndText'],textarea[name='csText'],textarea[field-name='itemname']", function (e) {
            var $this = $(e.target);
            $this.css('line-height', '24px');
            if (parseInt($this.css('height')) >= 234) {
                $this.css({ 'height': '234px', 'overflow-y': 'scroll' })
            };
        });
        $(document).on('focus', 'textarea', function (e) {
            var $this = $(e.target);
            $this.css('overflow-y', 'auto');
        });
        $(document).on('blur', 'textarea', function (e) {
            var $this = $(e.target);
            $this.css('overflow-y', 'hidden');
        });





        //qq附件列表
        $(function () {
            //遍历并绑定附件列表信息
            var $enclosure = $('.enclosure-list');
            var enclosureID = $('.enclosure-list').attr('data-sm');
            if ($enclosure.length !== 0) {
                $.each($enclosure, function (index, obj) {
                    LoadEnclosureList($(obj), $(obj).attr('data-sm'));
                    //console.log('$enclosureID--' + $(obj).attr('data-sm'));
                });
            }
        });

        //切换图表
        $('.main2 .tal-head-right').click(function () {
            clickTable();
            $('.main2').hide();
            $('.main3').show();
        });
        $('.main3 .tal-head-right').click(function () {
            $('.main2').show();
            $('.main3').hide();
        });
        function clickTable() {
            //切换图表
            var statisticsPageListRequestEntity = {
                PageIndex: 1,
                PageSize: 10,
                SmId: getQueryString("smid")
            };
            var postdata = {
                statisticsPageListRequestEntity: statisticsPageListRequestEntity
            };

            var ret = Ajax({ FunName: 'GetStatisticSMListByPageDetail', async: true, callback: ViewListData, data: postdata, isFristSearch: true });
        };

        window.onunload = function () {
            location.href.toLowerCase().indexOf('flowid') > -1 ? window.opener.document.getElementById('pending').click() : window.opener.document.getElementById('task').click()

        };
        //展开收起
        $(document).on('click', '.cp-p2', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $this = $(e.target);
            var status = $this.attr('data-pos');
            var id = $(this).attr('href');
            if (status === 'top') {
                $(id).show();
                $(this).closest('.card2').hide();
            }
            if (status === 'bottom') {
                $(this).closest(id).hide();
                $(this).closest(id).prev().show();
                $(id).hide();
            }
        });
    });
</script>
