<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaderMeetingMissionDetail.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.LeaderMeetingMissionDetail" %>

<% int page = this.page; %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查系统</title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <style type="text/css">
        .card .card-body textarea {
            margin-left: 0;
            margin-top: -5px;
            width: 100%;
        }

        .detial-info li ul {
            margin-left: -5px;
        }

        .card .card-body .form-block {
            padding: 0 5px;
        }

        .btn-default-c {
            margin-left: 10px;
        }

        .card .card-body .form-child textarea.disabled {
            margin-bottom: -15px;
        }

        .card .card-body .form-child.disabled .form-group {
            margin-bottom: 0;
        }

        .rc.rr {
            right: 20px;
        }

            .rc.rr + .rc.rr {
                right: 110px;
            }

        .detail-block .form-group input {
            margin-left: 0;
        }

        .lmd h3.c {
            margin-bottom: 10px;
        }

        /*label, span.hi {
            height: 34px;
            line-height: 34px;
            margin-bottom: 0;
        }*/

        /*.detial-info li {
            margin-top: 0;
            margin-bottom: 0;
        }*/

        .lmd .detail-col-2 .col {
            width: 22.5%;
        }

        .radio label, .checkbox label {
            height: auto;
            line-height: normal;
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

        .detail-part > .title {
            border: none;
        }

        .card .card-body {
            font-size: 14px;
        }

            .card .card-body label, .card .card-body span {
                line-height: 18px;
            }

        .card-body {
            font-size: 12px;
        }

        .detail-block-2 {
            padding-left: 0;
        }

        .detail-col .col > span:first-child {
            color: #959fab;
        }

        ul.flc.list-unstyled.checkInputForRWFK li {
            margin-top: 5px;
        }

        ul.flc.list-unstyled.checkInputForRWFK {
            font-size: 12px;
        }

        .flc li .list-unstyled li > .form-group textarea.form-control {
            height: 30px;
            width: 80%;
            overflow: auto;
            overflow-y: hidden;
            resize: none;
            margin-top: 5px;
            margin-left: -4px;
        }

        .dib input, .dib textarea {
            font-size: 12px;
        }

        .tac {
            margin-top: 10px;
        }
        span.iconfont.icon-sv-trash.delete-flag {
        font-size:18.4px;
        padding: 5px 9px;
        }
    </style>
</head>
<body class="lmd">
    <div class="main main2" url="<%=page %>">
        <!--撤回-->
        <% if (page == 1)
            { %>
        <div class="tal buttons" style="display: block; height: 28px">
            <button class="btn btn-primary-s  <%=!IsYiBan()?" hide":""%>" type="button" id="rollBackPage1">撤回</button>
            <%--<button class="btn btn-default-s" type="button">导出</button>
            <button class="btn btn-default-s" type="button">打印</button>--%>
            <%--<button class="btn btn-default-s tal-head-right" type="button">切换图表</button>--%>
        </div>
        <% } %>
        <!--end撤回-->

        <span id="currentPage" class="hidden"><%=page %></span>
        <span id="isLeader" class="hidden"><%=IsLeader %></span>
        <% if (page != 16)
            { %>
        <div class="card">
            <div class="card-header card-header-line">
                <h3 class="title">详情</h3>
                <span class="iconfont icon-sv-del"></span>
            </div>
            <div class="card-body">
                <div class="clearfix detial-info">
                    <ul class="list-unstyled">
                        <li>
                            <div class="row dib-special">
                                <label class="dib">任务内容：</label>
                                <span class="dib hi">
                                    <asp:Label ID="lblTaskContent" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <div class="col-lg-4 col-xs-4 col-sm-4 col-md-4">
                                    <label>督查编号：</label>
                                    <span>
                                        <asp:Label ID="lblSpNum" runat="server" Text=""></asp:Label></span>
                                </div>
                                <div class="col-lg-8 col-xs-8 col-sm-8 col-md-8">
                                    <label>文档ID：</label>
                                    <span class="hi">
                                        <asp:Label ID="lblSmId" runat="server" Text=""></asp:Label></span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">主办单位：</label>
                                <span class="dib hi">
                                    <asp:Label ID="lblMainDept" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">协办单位：</label>
                                <span class="dib hi">
                                    <asp:Label ID="lblAssDept" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">启动时间：</label>
                                <span class="dib hi">
                                    <asp:Label ID="lblStartTime" runat="server" Text=""></asp:Label></span>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
        <% } %>
        <% if (page == 1)
            { %>
        <div style="display: block">
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater17_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <%--   <div class="tar rc rt">
                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">历史记录</button>
                                <div class="rb">
                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("LmmId") %>" data-targetitemid="">反馈记录</button>
                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("LmmId") %>" data-targetitemid="">操作记录</button>
                                </div>
                            </div>--%>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度
                                    </span>
                                    <span class="process1"><%# FinishPercentFormat(Eval("FinishPercent")) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="detail-box">
                        <asp:Repeater ID="Repeater17_1" runat="server" OnItemDataBound="Repeater17_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
                                    <h3 class="st"><span class="line line-primary"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <!--新增加详情记录-->
                                    <div class="tar rc rr">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                            历史记录
                                        </button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                    <!--end新增加详情记录-->
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <%--  <p class="f"><span class="iconfont icon-sv-sound"><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></span></p>--%>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <asp:Repeater ID="Repeater17_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                            <!--新增加详情记录-->
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                    历史记录
                                                </button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                            <!--end新增加详情记录-->
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成进度</span>
                                                    <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                </div>
                                            </div>

                                            <%--<div class="detail-block">
                                                <p class="f"><span class="iconfont icon-sv-sound"><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></span></p>
                                            </div>--%>
                                            <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <% } %>
        <% if (page == 2)
            { %>
        <div class="card" id="mainDeptList">
        </div>
        <div class="card">
            <div class="detail-box detail-box2">
                <div class="detail-part pr">
                    <div class="opinion-type"></div>
                    <div class="form-group">
                        <label class="font-lg">审批意见</label>
                        <textarea class="form-control thx" id="opinion"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        <% if (page == 3)
            { %>
        <div class="card">
            <div class="card-body">
                <div class="clearfix detial-info">
                    <ul class="list-unstyled">
                        <li>
                            <div class="row">
                                <label class="dib">主办单位：</label>
                                <span class="dib hi">
                                    <label id="DeptName"></label>
                                    <input id="LmmId" data-type="text" type="text" class="hidden" />
                                </span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib" style="line-height: 34px">完成时间：</label>
                                <span class="dib">
                                    <input style="width: 200px;" type="text" data-type="time" id="DeadLineTime" class="form-control input-time" value="" readonly data-date-format="yyyy-mm-dd" />
                                </span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <% } %>
        <% if (page == 4)
            { %>
        <div class="detail-box detail-box2">
            <div class="detail-part pr detail-line">
                <h3 class="c">主办单位</h3>
                <div class="detail-col detail-col-1">
                    <div class="col">
                        <span>主办单位</span>
                        <span title="南航信息中心">
                            <label id="DeptName"></label>
                        </span>
                    </div>
                    <div class="col">
                        <span>完成时间
                        </span>
                        <span>
                            <label id="DeadLineTime" data-type="timeFormatForLabel"></label>
                        </span>
                    </div>

                </div>
                <div class="opinion-type"></div>
                <div class="form-group">
                    <label class="font-lg">审批意见</label>
                    <textarea class="form-control th2" id="opinion"></textarea>
                </div>
            </div>
        </div>
        <% } %>
        <% if (page == 5)
            { %>
        <div class="card" id="mainDeptList">
        </div>
        <div class="detail-box detail-box2">
            <div class="detail-part pr">
                <div class="notice">
                    <h3 class="font-lg">督查定时反馈提醒</h3>
                    <div class="info">
                        <div class="radio">
                            <label>
                                <input type="radio" name="notice2" value="-1" checked="checked" style="height: auto" />
                                不做提醒
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input checked="checked" type="radio" name="notice2" value="2" style="height: auto" />
                                每两个月提醒一次（60天）
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="notice2" value="4" style="height: auto" />
                                <span>每月</span>
                                <input type="text" name="everymonth" value="" />
                                <span>号</span>
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="notice2" value="3" style="height: auto" />
                                <span>自定义&nbsp;每</span>
                                <input type="text" name="day2" value="12" />
                                <span>天提醒一次</span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="opinion-type"></div>
                <div class="form-group" style="padding-bottom: 45px">
                    <label class="font-lg">审批意见</label>
                    <textarea class="form-control thx" id="opinion"></textarea>
                </div>
            </div>
        </div>
        <% } %>
        <% if (page == 6)
            { %>
        <div id="mainDeptList">
        </div>

        <% } %>
        <% if (page == 7)
            { %>
        <div class="card">
            <div class="detail-box detail-box2">
                <div class="detail-part pr detail-line">
                    <h3 class="c">主办单位</h3>
                    <ul class="flc list-unstyled checkInputForRWFK">
                        <li>
                            <label class="dib">
                                主办单位：
                                <span id="lmmId" class="hidden"></span>
                            </label>
                            <span class="dib">
                                <label id="DeptName"></label>

                            </span></li>
                        <li>
                            <label class="dib">完成时间：</label><span class="dib">
                                <label id="DeadLineTime" data-type="time"></label>
                            </span></li>
                        <li>
                            <label class="dib">完成进度：</label><span class="dib">
                                <input type="text" data-type="num" data-operate="true" data-operateid="rwfk" class="form-control" value="" id="finishPercent" datacol="yes" err="完成进度" checkexpession="Num" />

                            </span></li>
                        <li id="rwfk" style="display: none;">
                            <ul class="list-unstyled">
                                <li>
                                    <div class="form-group form-inline form-new">
                                        <label class="dib">最新反馈：</label>
                                        <textarea class="form-control th1" id="opinion" datacol="yes" err="最新反馈" checkexpession="NotNull"></textarea>
                                    </div>
                                </li>
                                <li>
                                    <div class="ec">
                                        <label class="dib">
                                            附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：</label>
                                        <span class="dib">
                                            <input type="file" class="ocf" data-id="" />
                                            <button type="button" class="btn btn-default-sm">上传附件</button>
                                        </span>
                                    </div>
                                </li>
                                <li class="attchmentList" data-id=""></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!--非当前主办单位的集合-->
        <asp:Repeater ID="Repeater7" runat="server" OnItemDataBound="Repeater7_ItemDataBound">
            <ItemTemplate>
                <div class="card">
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%# FinishPercentFormat(Eval("FinishPercent")) %></span>
                                </div>
                            </div>
                        </div>
                        <div style="display: <%# (Eval("FinishPercent")==null ||Eval("FinishPercent").ToString()=="")?"none":"block" %>">
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByTargetId(Eval("LmmId").ToString()) %></p>
                            </div>
                            <a data-toggle="collapse" href="#<%#Eval("LmmId") %>" aria-expanded="False" aria-controls="<%#Eval("LmmId") %>" data-status="hide" class="zk">展开></a>
                        </div>
                    </div>
                    <div class="card card-box card-line">
                        <div class="collapse" id="<%#Eval("LmmId") %>">
                            <asp:Repeater ID="Repeater7_1" runat="server" OnItemDataBound="Repeater7_1_ItemDataBound">
                                <ItemTemplate>
                                    <div class="card-detail">
                                        <div class="card-header">
                                            <h3 class="title">
                                                <span class="line"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %>
                                            </h3>
                                            <div class="tar rc r">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">历史记录</button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-part detail-part-sub pr detail-line">
                                                <div class="detail-col detail-col-2">

                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任处室</span>
                                                        <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                </div>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                            <asp:Repeater ID="Repeater7_1_1" runat="server">
                                                <ItemTemplate>
                                                    <div class="detail-part detail-part-sub2 pr detail-line">
                                                        <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                                        <!--新增加详情记录-->
                                                        <div class="tar rc rr">
                                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                                历史记录
                                                            </button>
                                                            <div class="rb">
                                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                            </div>
                                                        </div>
                                                        <!--end新增加详情记录-->
                                                        <p><%#Eval("ItemName") %></p>
                                                        <div class="detail-col detail-col-2">
                                                            <div class="col">
                                                                <span>协办单位</span>
                                                                <span><%#Eval("AssistDeptName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成时间</span>
                                                                <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>责任人</span>
                                                                <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成进度</span>
                                                                <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                            </div>
                                                        </div>
                                                        <div class="detail-block">
                                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                        </div>
                                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <% } %>
        <% if (page == 8)
            { %>
        <!--主办单位秘书分解任务-->
        <div style="display: block">
            <!--当前主办单位-->
            <div class="detail-box detail-box2">
                <div class="detail-part pr detail-line">
                    <h3 class="c">主办单位</h3>
                    <div class="detail-col detail-col-1">
                        <div class="col">
                            <span>主办单位</span>
                            <span id="lmmId" class="hidden"></span>
                            <span>
                                <label id="DeptName"></label>
                            </span>
                        </div>
                        <div class="col">
                            <span>完成时间
                            </span>
                            <label id="DeadLineTime" data-type="time"></label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-outter" data-lmmid="">
                <div class="card card-box first">
                    <div class="step">
                        <div class="card-header">
                            <h3 class="title">添加措施</h3>
                            <span class="iconfont icon-sv-add" data-add="year-target"></span>
                        </div>
                    </div>
                </div>
            </div>

            <!--非当前主办单位的集合-->
            <asp:Repeater ID="Repeater8" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <div class="detail-box detail-box2">
                            <div class="detail-part pr detail-line">
                                <h3 class="c">主办单位</h3>
                                <div class="detail-col detail-col-1">
                                    <div class="col">
                                        <span>主办单位</span>
                                        <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成时间
                                        </span>
                                        <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <!--目标模板-->
            <script id="targetTempl" type="x-tmpl-mustache">
            <div class="card card-box" data-index="{{index}}">
                <div class="card-header">
		            <h3 class="title c">措施{{index}}</h3>
                </div>
                <div class="card-body year-target">
                    <div class="form-block">
                        <div class="form-child">
                        <div class="form-group">
                            <textarea class="form-control th3"></textarea>
                            <span data-type="cs" class="iconfont icon-sv-trash delete-flag" style="display:none;"></span>
                        </div>
                        <div class="form-group tac">
                            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">
                                <label>协办单位</label>
                                <input type="text" readonly class="form-control" name="company" data-dept="company" data-toggle="modal" data-target="#company"/>
                                <span class="iconfont icon-sv-add" name="company" data-dept="company" data-toggle="modal" data-target="#company"></span>
                            </div>
                            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tac">
                                <label>完成时间</label>
                                <input type="text" readonly data-date-format="yyyy-mm-dd" class="form-control input-time" data-name="dataPicker" />
                            </div>
                            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 tar">
                                <label>责任处室</label>
                                <input type="text" readonly class="form-control" readonly="readonly" name="office" data-single="true" data-dept="office" data-toggle="modal" data-target="#company"/>
                                <span class="iconfont icon-sv-add" name="office" data-dept="office" data-single="true" data-toggle="modal" data-target="#company"></span>
                            </div>
                        </div>
                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                        <div class="form-group tac">
                                <button type="button" class="btn btn-primary-s" data-add="finish">添加</button>
                            <button type="button" class="btn btn-default-s" data-cancel="">取消</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            </script>
            <!--end目标模板-->

        </div>
        <% } %>
        <% if (page == 9)
            { %>
        <asp:Repeater ID="Repeater9" runat="server" OnItemDataBound="Repeater9_ItemDataBound">
            <ItemTemplate>
                <div style="display: block">
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater9_1" runat="server">
                        <ItemTemplate>
                            <div class="detail-box">
                                <div class="detail-part">
                                    <h3 class="title">措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-1">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <div class="clearfix">&nbsp;</div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <% } %>
        <% if (page == 10)
            { %>
        <asp:Repeater ID="Repeater10" runat="server" OnItemDataBound="Repeater10_ItemDataBound" Visible="true">
            <ItemTemplate>
                <div style="display: block">
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card card-box card-line">
                        <!--可操作的措施-->
                        <asp:Repeater ID="Repeater10_1" runat="server">
                            <ItemTemplate>
                                <div>
                                    <div class="card-header">
                                        <h3 class="title">
                                            <span class="line"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %>
                                        </h3>
                                        <div class="tar rc">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                变更申请
                                            </button>
                                            <div class="rb">

                                                <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>

                                            </div>
                                        </div>
                                        <div class="tar rc">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                历史记录
                                            </button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                    </div>
                                    <!--以ItemId构造一个自定义类名，防止同一个人反馈多个措施时，数据验证方法无法正确定位对应的措施输入框组-->
                                    <div class="card-body checkInput <%#Eval("ItemId") %>_Div">
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="detail-block">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                            </div>
                                            <div class="form-group form-inline col">
                                                <span>完成进度</span>
                                                <input data-type="num" id="<%#Eval("ItemId") %>_FinshPrecent" type="text" class="form-control" value="<%#Eval("FinshPercent") %>" data-operate="true" data-operateid="<%#Eval("MeasureOperateIdIndex") %>" datacol="yes" err="完成进度" checkexpession="Num" />
                                            </div>
                                            <div id="<%#Eval("MeasureOperateIdIndex") %>" style="display: none;">
                                                <div class="form-group form-inline form-new">
                                                    最新反馈<span class="c-danger">*</span>
                                                    <textarea id="<%#Eval("ItemId") %>_Opinion" class="form-control th3" datacol="yes" err="最新反馈" checkexpession="NotNull"><%#Eval("Opinion") %></textarea>
                                                </div>
                                                <div class="form-group form-inline form-new">
                                                    附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件
                                                <input type="file" data-id="<%#Eval("ItemId") %>" />
                                                    <button type="button" class="btn btn-default-sm">上传附件</button>
                                                </div>
                                                <div class="file-list form-new">
                                                    <ul class="list-unstyled attchmentList" data-id="<%#Eval("ItemId") %>"></ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        <div class="button-group">
                                            <button type="button" class="btn btn-primary-s btn10Submit" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-flowid="<%#Eval("FlowId") %>">进度反馈</button>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!--不可操作的措施-->
                        <asp:Repeater ID="Repeater10_2" runat="server">
                            <ItemTemplate>
                                <div>
                                    <div class="card-header">
                                        <h3 class="title">
                                            <span class="line"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %>
                                        </h3>
                                        <div class="tar rc">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                历史记录
                                            </button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <p><%#Eval("ItemName") %></p>
                                        <div id="<%#Eval("MeasureOperateIdIndex") %>" class="collapse">
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任处室</span>
                                                    <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成进度</span>
                                                    <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                </div>
                                            </div>
                                            <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        </div>
                                        <a data-toggle="collapse" href="#<%#Eval("MeasureOperateIdIndex") %>" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <%--   <div class="detail-box detail-box2">
            <div class="detail-part pr detail-line">
                <h3 class="c">主办单位</h3>
                <div class="detail-col detail-col-1">
                    <div class="col">
                        <span>主办单位</span>
                        <span title="南航信息中心">南航信息中心</span>
                    </div>
                    <div class="col">
                        <span>完成时间
                        </span>
                        <span>2018-12-11</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="card card-box card-line">
            <div> <div class="card-header">
                <h3 class="title">
                    <span class="line"></span>措施1
                </h3>
                <div class="tar rc">
                    <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                        变更申请
                    </button>
                    <div class="rb">

                        <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="4">办结申请</button>
                        <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="2">延期申请</button>
                        <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="3">中止申请</button>
                        <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="5">调整申请</button>

                    </div>
                </div>
                <div class="tar rc">
                    <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                        历史记录
                    </button>
                    <div class="rb">
                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="18101800003" data-targetitemid="18101800004">反馈记录</button>
                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="18101800003" data-targetitemid="18101800004">操作记录</button>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <p>2日进入沙特驻土耳其伊斯坦布尔领事馆后下落不明</p>
                <div class="detail-block">
                    <div class="col">
                        <span>协办单位</span>
                        <span>南航办公厅</span>
                    </div>
                    <div class="col">
                        <span>完成时间</span>
                        <span>2018/10/21</span>
                    </div>
                    <div class="col">
                        <span>责任处室</span>
                        <span>南航办公厅</span>
                    </div>
                    <div class="form-group form-inline col">
                        <span>完成进度</span>
                        <input id="18101800004_FinshPrecent" data-toggle="collapse" href="#fk" aria-expanded="false" type="text" class="form-control" value="60" data-operate="false" data-operateid="Detail18101800004_0">
                    </div>
                    <div id="fk" style="" class="collapse">
                        <div class="form-group form-inline form-new">
                            最新反馈<span class="c-danger">*</span>
                            <textarea class="form-control" id="18101800004_Opinion"></textarea>
                        </div>
                        <div class="form-group form-inline form-new">
                            附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件
                                                <input type="file" data-targetitemid="18101800004" />
                            <button type="button" class="btn btn-default-sm" data-targetitemid="18101800004">上传附件</button>
                        </div>
                        <div class="file-list form-new">
                            <ul class="list-unstyled attchmentList" data-targetitemid="18101800004"></ul>
                        </div>
                    </div>
                </div>
                <div class="button-group">
                    <button type="button" class="btn btn-default-s" data-save="save" data-itemid="18101800004" data-flowid="">保存</button>
                    <button type="button" class="btn btn-default-s hide" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="4">办结申请</button>
                    <button type="button" class="btn btn-default-s hide" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="2">延期申请</button>
                    <button type="button" class="btn btn-default-s hide" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="3">中止申请</button>
                    <button type="button" class="btn btn-default-s hide" data-gotohref="" data-parenttargetitemid="" data-targetid="18101800003" data-itemid="18101800004" data-type="5">调整申请</button>
                </div>
            </div></div>
            <div>
                <div class="card-header">
                    <h3 class="title">
                        <span class="line"></span>措施1
                    </h3>
                    <div class="tar rc">
                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                            历史记录
                        </button>
                        <div class="rb">
                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="" data-targetitemid="">反馈记录</button>
                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="" data-targetitemid="">操作记录</button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <p>2日进入沙特驻土耳其伊斯坦布尔领事馆后下落不明</p>
                    <div id="121" class="collapse">
                        <div class="detail-col detail-col-2">
                            <div class="col">
                                <span>协办单位</span>
                                <span>协办单位</span>
                            </div>
                            <div class="col">
                                <span>完成时间</span>
                                <span>完成时间</span>
                            </div>
                            <div class="col">
                                <span>责任人</span>
                                <span>责任人</span>
                            </div>
                            <div class="col">
                                <span>完成进度</span>
                                10%
                            </div>
                        </div>
                    </div>
                    <a data-toggle="collapse" href="#121" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
                </div>
            </div>

        </div>--%>

        <% } %>
        <% if (page == 11)
            { %>
        <div style="display: block">
            <asp:Repeater ID="Repeater11" runat="server" OnItemDataBound="Repeater11_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="detail-box dp13">
                        <!--可进行分解子措施的措施-->
                        <asp:Repeater ID="Repeater11_1" runat="server">
                            <ItemTemplate>
                                <div class="detail-box detail-box2">
                                    <div class="detail-part pr detail-line">
                                        <h3 class="title">措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="detail-col detail-col-1">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                            </div>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                变更申请
                                            </button>
                                            <div class="rb">
                                                <div class="button-group">
                                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="4">办结申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="2">延期申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="3">中止申请</button>
                                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="<%#Eval("ParentTargetItemId") %>" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-type="5">调整申请</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                历史记录
                                            </button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="detail-part detail-part-sub pr" data-measureid="<%#Eval("ItemId") %>" data-targetid="<%#Eval("TargetId") %>">
                                    <div class="clearfix"></div>
                                    <div class="add-step detail-opera">
                                        <h3 class="st"><span class="line"></span>添加子措施</h3>
                                        <span class="iconfont icon-sv-add" data-add="add-step-child"></span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <!--只可看的措施-->
                        <asp:Repeater ID="Repeater11_2" runat="server">
                            <ItemTemplate>
                                <div class="detail-box detail-box2">
                                    <div class="detail-part pr detail-line">
                                        <h3 class="title">措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                        <p><%#Eval("ItemName") %></p>
                                        <div class="collapse" id="<%#Eval("ItemId") %>">
                                            <div class="detail-col detail-col-1 ">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任处室</span>
                                                    <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                                </div>
                                            </div>
                                            <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        </div>
                                        <div class="tar rc rr">
                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                历史记录
                                            </button>
                                            <div class="rb">
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                            </div>
                                        </div>
                                        <a data-toggle="collapse" href="#<%#Eval("ItemId") %>" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>


            <%--            <div class="detail-box detail-box2">
                <div class="detail-part pr detail-line">
                    <h3 class="c">主办单位</h3>
                    <div class="detail-col detail-col-1">
                        <div class="col">
                            <span>主办单位</span>
                            <span title="南航信息中心">南航信息中心</span>
                        </div>
                        <div class="col">
                            <span>完成时间
                            </span>
                            <span>2018-12-11</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="detail-box dp13">

                <div class="detail-box detail-box2">
                    <div class="detail-part pr detail-line">
                        <h3 class="title">措施1</h3>
                        <p>措施1措施1措施1措施1措施1措施1</p>
                        <div class="detail-col detail-col-1">
                            <div class="col">
                                <span>协办单位</span>
                                <span title="南航信息中心">南航信息中心</span>
                            </div>
                            <div class="col">
                                <span>完成时间</span>
                                <span>2018/10/27 0:00:00</span>
                            </div>
                            <div class="col">
                                <span>责任处室</span>
                                <span title="南航信息中心">南航信息中心</span>
                            </div>
                        </div>
                        <div class="tar rc rr">
                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                变更申请
                            </button>
                            <div class="rb">
                                <div class="button-group">
                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101900029" data-itemid="18101900030" data-type="4">办结申请</button>
                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101900029" data-itemid="18101900030" data-type="2">延期申请</button>
                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101900029" data-itemid="18101900030" data-type="3">中止申请</button>
                                    <button type="button" class="btn btn-default-s" data-gotohref="" data-parenttargetitemid="" data-targetid="18101900029" data-itemid="18101900030" data-type="5">调整申请</button>
                                </div>
                            </div>
                        </div>
                        <div class="tar rc rr">
                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                历史记录
                            </button>
                            <div class="rb">
                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="18101900029" data-targetitemid="18101900030">反馈记录</button>
                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="18101900029" data-targetitemid="18101900030">操作记录</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="detail-part detail-part-sub pr" data-measureid="18101900030" data-targetid="18101900029">
                    <div class="clearfix"></div>
                    <div class="add-step detail-opera">
                        <h3 class="st"><span class="line"></span>添加子措施</h3>
                        <span class="iconfont icon-sv-add" data-add="add-step-child"></span>
                    </div>
                </div>

                 <div class="detail-box detail-box2">
                    <div class="detail-part pr detail-line">
                        <h3 class="title">措施1</h3>
                        <p>措施1措施1措施1措施1措施1措施1</p>
                        <div class="detail-col detail-col-1">
                            <div class="col">
                                <span>协办单位</span>
                                <span title="南航信息中心">南航信息中心</span>
                            </div>
                            <div class="col">
                                <span>完成时间</span>
                                <span>2018/10/27 0:00:00</span>
                            </div>
                            <div class="col">
                                <span>责任处室</span>
                                <span title="南航信息中心">南航信息中心</span>
                            </div>
                        </div>
                        <div class="tar rc rr">
                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                历史记录
                            </button>
                            <div class="rb">
                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="18101900029" data-targetitemid="18101900030">反馈记录</button>
                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="18101900029" data-targetitemid="18101900030">操作记录</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="detail-box detail-box2">
                    <div class="detail-part pr detail-line">
                        <h3 class="title">措施1</h3>
                        <p>措施1措施1措施1措施1措施1措施1</p>
                        <div class="detail-col detail-col-1 collapse" id="12">
                            <div class="col">
                                <span>协办单位</span>
                                <span title="南航信息中心">南航信息中心</span>
                            </div>
                            <div class="col">
                                <span>完成时间</span>
                                <span>2018/10/27 0:00:00</span>
                            </div>
                            <div class="col">
                                <span>责任处室</span>
                                <span title="南航信息中心">南航信息中心</span>
                            </div>
                        </div>
                        <div class="tar rc rr">
                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                历史记录
                            </button>
                            <div class="rb">
                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="18101900029" data-targetitemid="18101900030">反馈记录</button>
                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="18101900029" data-targetitemid="18101900030">操作记录</button>
                            </div>
                        </div>
                        <a data-toggle="collapse" href="#12" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
                    </div>
                </div>

            </div>--%>



            <!--子措施模板-->
            <script id="steoChildTempl" type="x-tmpl-mustache">
                <div class="detail-part detail-part-sub dps" data-index="{{index}}">
                    <div class="add-step">
                        <h3 class="st">
                            <span class="line"></span>子措施{{index}}
                        </h3>
                        <span data-type="zcs" class="iconfont icon-sv-trash" style="display:none;"></span>
                   </div>
                    <div class="card-body target-step">
                        <div class="form-child">
                            <div class="form-group">
                                <textarea class="form-control th4"></textarea>
                            </div>
                            <div class="form-group tac">
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 tal">
                                    <label>协办单位</label>
                                    <input type="text" readonly class="form-control" name="company" data-dept="company" data-toggle="modal" data-target="#company"/>
                                    <span class="iconfont icon-sv-add" data-dept="company" data-toggle="modal" data-target="#company"></span>
                                </div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 tac">
                                    <label>完成时间</label>
                                    <input type="text" readonly data-date-format="yyyy-mm-dd" class="form-control input-time" data-name="dataPicker" />
                                </div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 tar">
                                    <label>责任人</label>
                                    <input type="text" readonly class="form-control" name="person" data-toggle="modal" data-target="#leaderModal"/>
                                    <span class="iconfont icon-sv-add" data-dept="office" data-toggle="modal" data-target="#leaderModal"></span>
                                </div>
                            </div>
                            <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
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
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
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


        </div>

        <% } %>
        <% if (page == 12)
            { %>
        <div style="display: block">
            <asp:Repeater ID="Repeater12" runat="server" OnItemDataBound="Repeater12_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card card-box card-line">
                        <asp:Repeater ID="Repeater12_1" runat="server" OnItemDataBound="Repeater12_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施<%# GetIndexForItem(Eval("TargetId").ToString()) %>
                                    </h3>
                                    <div class="tar rc r">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">历史记录</button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%# Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId")%>">反馈记录</button>
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
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <!--责任人为当前用户-->
                                    <asp:Repeater ID="Repeater12_1_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <!--以ItemId构造一个自定义类名，防止同一个人反馈多个子措施时，数据验证方法无法正确定位对应的子措施输入框组-->
                                                <div class="detail-block detail-block-2 checkInput <%#Eval("ItemId") %>_Div">
                                                    <h3 class="st">
                                                        <span class="line"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">
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
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责&nbsp;&nbsp;任&nbsp;&nbsp;人</span>
                                                        <span><%#Eval("ExcutorName") %></span>
                                                    </div>
                                                    <div class="form-group form-inline col">
                                                        <span>完成进度</span>
                                                        <input data-type="num" id="<%#Eval("ItemId") %>_FinshPrecent" type="text" class="form-control" value="<%#Eval("FinshPercent") %>" data-operate="true" data-operateid="<%#Eval("SubMeasureOperateIdIndex") %>" datacol="yes" err="完成进度" checkexpession="Num" />
                                                    </div>
                                                    <div id="<%#Eval("SubMeasureOperateIdIndex") %>" style="display: none;">
                                                        <div class="form-group form-inline form-new">
                                                            <span class="cd">最新反馈</span><span class="c-danger">*</span>
                                                            <textarea id="<%#Eval("ItemId") %>_Opinion" class="form-control th4" datacol="yes" err="最新反馈" checkexpession="NotNull"></textarea>
                                                        </div>
                                                        <div class="form-group form-inline form-new">
                                                            <span class="cd">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件</span>
                                                            <input type="file" data-id="<%#Eval("ItemId") %>" />
                                                            <button type="button" class="btn btn-default-sm">上传附件</button>
                                                        </div>
                                                        <div class="file-list form-new">
                                                            <ul class="list-unstyled dci attchmentList" data-id="<%#Eval("ItemId") %>">
                                                            </ul>
                                                        </div>

                                                    </div>
                                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                </div>
                                                <div class="button-group">
                                                    <button type="button" class="btn btn-primary-s btn12Submit" data-targetid="<%#Eval("TargetId") %>" data-itemid="<%#Eval("ItemId") %>" data-flowid="<%#Eval("FlowId") %>">进度反馈</button>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <!--责任人非当前用户-->
                                    <asp:Repeater ID="Repeater12_1_2" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="st">
                                                        <span class="line"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <p><%#Eval("ItemName") %></p>
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom">
                                                            历史记录
                                                        </button>
                                                        <div class="rb">
                                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
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
                                                                <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>责任人</span>
                                                                <span><%#Eval("ExcutorName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成进度</span>
                                                                <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                            </div>
                                                        </div>
                                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                    </div>
                                                    <a data-toggle="collapse" href="#<%#Eval("SubMeasureDetailIdIndex") %>" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
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
        <% } %>
        <% if (page == 13)
            { %>
        <div style="display: block">
            <asp:Repeater ID="Repeater13" runat="server" OnItemDataBound="Repeater13_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--可发送的措施-->
                    <asp:Repeater ID="Repeater13_1" runat="server" OnItemDataBound="Repeater13_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-box ItemDiv">

                                <div class="detail-part detail-part-sub pr detail-line">
                                    <h3 class="st"><span class="line line-primary"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <!--新增加详情记录-->
                                    <div class="tar rc rr">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                            历史记录
                                        </button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                    <!--end新增加详情记录-->
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <!--可操作的子措施-->
                                <asp:Repeater ID="Repeater13_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                            <!--新增加详情记录-->
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-second-s <%# (Eval("FlowId")==null ||Eval("FlowId").ToString()=="") ? "disabled" : "" %>" data-toggle="modal" data-target="#backModal" data-flowid="<%#Eval("FlowId") %>">退回</button>
                                            </div>
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                    历史记录
                                                </button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                            <!--end新增加详情记录-->
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成进度</span>
                                                    <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                </div>
                                            </div>
                                            <div class="detail-block">
                                                <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                            </div>
                                            <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <div class="tac" style="display: <%# IsAllFeedback(1,Eval("ItemId").ToString())?"block":"none" %>;">
                                    <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">同意</button>
                                </div>
                                <div class="clearfix">&nbsp;</div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <!--不可发送的措施-->
                    <asp:Repeater ID="Repeater13_2" runat="server" OnItemDataBound="Repeater13_2_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-box">

                                <div class="detail-part detail-part-sub pr detail-line">
                                    <h3 class="st"><span class="line line-primary"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <!--新增加详情记录-->
                                    <div class="tar rc rr">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                            历史记录
                                        </button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                    <!--end新增加详情记录-->
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <!--展示的子措施-->
                                <asp:Repeater ID="Repeater13_2_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                            <!--新增加详情记录-->
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                    历史记录
                                                </button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                            <!--end新增加详情记录-->
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="collapse" id="<%#Eval("SubMeasureDetailIdIndex") %>">
                                                <div class="detail-col detail-col-2">
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任人</span>
                                                        <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                </div>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                            <a data-toggle="collapse" href="#<%#Eval("SubMeasureDetailIdIndex") %>" aria-expanded="False" aria-controls="detail1" data-status="hide">展开></a>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <% } %>
        <% if (page == 14)
            { %>
        <div style="display: block">
            <asp:Repeater ID="Repeater14" runat="server" OnItemDataBound="Repeater14_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="detail-box ItemDiv">
                        <!--可退回的措施-->
                        <asp:Repeater ID="Repeater14_1" runat="server" OnItemDataBound="Repeater14_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
                                    <h3 class="st"><span class="line line-primary"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <!--新增加详情记录-->
                                    <div class="tar rc rr">
                                        <button type="button" class="btn btn-second-s <%# (Eval("FlowId")==null ||Eval("FlowId").ToString()=="") ? "disabled" : "" %>" data-toggle="modal" data-target="#backModal" data-flowid="<%#Eval("FlowId") %>">退回</button>
                                    </div>
                                    <div class="tar rc rr">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                            历史记录
                                        </button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>

                                    <!--end新增加详情记录-->
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <a data-toggle="collapse" href="#<%#Eval("ItemId") %>" aria-expanded="False" aria-controls="<%#Eval("ItemId") %>" data-status="hide" class="zk">展开></a>
                                </div>
                                <div class="collapse" id="<%#Eval("ItemId") %>">
                                    <asp:Repeater ID="Repeater14_1_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-part detail-part-sub2 pr detail-line">
                                                <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                                <!--新增加详情记录-->
                                                <div class="tar rc rr">
                                                    <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                        历史记录
                                                    </button>
                                                    <div class="rb">
                                                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                        <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                    </div>
                                                </div>
                                                <!--end新增加详情记录-->
                                                <p><%#Eval("ItemName") %></p>
                                                <div class="detail-col detail-col-2">
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任人</span>
                                                        <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                </div>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!--不可退回的措施-->
                        <asp:Repeater ID="Repeater14_2" runat="server" OnItemDataBound="Repeater14_2_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
                                    <h3 class="st"><span class="line line-primary"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <!--新增加详情记录-->
                                    <div class="tar rc rr">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                            历史记录
                                        </button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                            <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                        </div>
                                    </div>
                                    <!--end新增加详情记录-->
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    <a data-toggle="collapse" href="#<%#Eval("ItemId") %>" aria-expanded="False" aria-controls="<%#Eval("ItemId") %>" data-status="hide" class="zk">展开></a>
                                </div>
                                <div class="collapse" id="<%#Eval("ItemId") %>">
                                    <asp:Repeater ID="Repeater14_2_1" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-part detail-part-sub2 pr detail-line">
                                                <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                                <!--新增加详情记录-->
                                                <div class="tar rc rr">
                                                    <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                        历史记录
                                                    </button>
                                                    <div class="rb">
                                                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                        <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                        <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                    </div>
                                                </div>
                                                <!--end新增加详情记录-->
                                                <p><%#Eval("ItemName") %></p>
                                                <div class="detail-col detail-col-2">
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任人</span>
                                                        <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                </div>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>

                        </asp:Repeater>
                        <div class="tac" style="display: <%# IsCurrentMainDept(Eval("DeptId").ToString())&&IsAllFeedback(2,Eval("LmmId").ToString())?"block":"none" %>;">
                            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">同意</button>
                        </div>
                        <div class="clearfix">&nbsp;</div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <% } %>
        <% if (page == 15)
            { %>

        <div style="display: block">
            <asp:Repeater ID="Repeater15" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="tar rc rt">
                                <button type="button" class="btn btn-second-s <%# (Eval("FlowId")==null ||Eval("FlowId").ToString()=="") ? "disabled" : "" %>" data-toggle="modal" data-target="#backModal" data-flowid="<%#Eval("FlowId") %>">退回</button>
                            </div>
                            <div class="tar rc rt">
                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">历史记录</button>
                                <div class="rb">
                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("LmmId") %>" data-targetitemid="">反馈记录</button>
                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("LmmId") %>" data-targetitemid="">操作记录</button>
                                </div>
                            </div>
                            <!--新增主办单位信息-->
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度</span>
                                    <span class="process1"><%# FinishPercentFormat(Eval("FinishPercent")) %></span>
                                </div>
                            </div>
                            <div class="detail-block">
                                <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByTargetId(Eval("LmmId").ToString()) %></p>
                            </div>
                            <a data-toggle="collapse" href="#<%#Eval("LmmId") %>" aria-expanded="False" aria-controls="<%#Eval("LmmId") %>" data-status="hide" class="zk">展开></a>
                            <!--新增主办单位信息-->
                        </div>
                    </div>
                    <div class="card card-box card-line">
                        <div class="collapse" id="<%#Eval("LmmId") %>">
                            <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                                <ItemTemplate>
                                    <div class="card-detail">
                                        <div class="card-header">
                                            <h3 class="title">
                                                <span class="line"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %>
                                            </h3>
                                            <div class="tar rc r">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">历史记录</button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-part detail-part-sub pr detail-line">
                                                <div class="detail-col detail-col-2">
                                                    <div class="col">
                                                        <span>协办单位</span>
                                                        <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成时间</span>
                                                        <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>责任处室</span>
                                                        <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                                    </div>
                                                    <div class="col">
                                                        <span>完成进度</span>
                                                        <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                    </div>
                                                </div>
                                                <div class="detail-block">
                                                    <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                </div>
                                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                            </div>
                                            <asp:Repeater ID="Repeater15_1_1" runat="server">
                                                <ItemTemplate>
                                                    <div class="detail-part detail-part-sub2 pr detail-line">
                                                        <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                                        <!--新增加详情记录-->
                                                        <div class="tar rc rr">
                                                            <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                                历史记录
                                                            </button>
                                                            <div class="rb">
                                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                                <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                                <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                            </div>
                                                        </div>
                                                        <!--end新增加详情记录-->
                                                        <p><%#Eval("ItemName") %></p>
                                                        <div class="detail-col detail-col-2">
                                                            <div class="col">
                                                                <span>协办单位</span>
                                                                <span><%#Eval("AssistDeptName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成时间</span>
                                                                <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>责任人</span>
                                                                <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成进度</span>
                                                                <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                            </div>
                                                        </div>
                                                        <div class="detail-block">
                                                            <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                                        </div>
                                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>

        <% } %>

        <% if (page == 16)
            { %>
        <!--拟稿编辑-->
        <div class="mission-part" data-index="1">
            <h3 class="mission-title"><%=LbHeader %></h3>
            <div class="form-box form-horizontal checkInput">
                <div class="form-group form-customer sn">
                    <div class="sedit">
                        <label class="col-lg-1 col-sm-1 col-xs-1 col-md-1 control-label">督查编号</label>
                        <div class="col-lg-6 col-sm-6 col-md-6 col-xs-6 disabled">
                            <span class="s" data-name="snName" style="display: none">南航督查</span>
                            <select name="snName" class="dbi fcc" datacol="yes" err="督查字号" checkexpession="NotNull">
                            </select>
                            <span class="s" data-name="snYear" style="display: none"></span>
                            <select name="snYear" class="dbi fcc" datacol="yes" err="年号" checkexpession="NotNull">
                            </select>
                            <span class="s" data-name="snCode" style="display: none"></span>
                            <input name="snCode" data-code="" type="text" class="dbi fcc" placeholder="" value="" readonly="readonly" disabled="disabled" datacol="yes" err="编号" checkexpession="NotNull">
                            号
                        </div>
                        <div class="col-lg-5 col-md-5 col-xs-5 col-sm-5">
                            <label class="dbi">文件ID</label>
                            <input type="text" class="form-control dbi" data-id="" placeholder="" name="snId" disabled="disabled" readonly="readonly">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">任务内容</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <textarea class="form-control th1" name="snText" placeholder="请输入任务内容" datacol="yes" err="任务内容" checkexpession="NotNull"></textarea>
                    </div>
                </div>
                <div class="form-group sn">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">主办单位</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" name="snCompany" data-obj="1" class="form-control" readonly="readonly" placeholder="请输入主办单位" data-toggle="modal" data-target="#company" data-dept="snCompany" data-backdrop="static" data-keyboard="false" datacol="yes" err="主办单位" checkexpession="NotNull">
                        <input type="hidden" name="snCompanyIds" class="form-control">
                        <%--<span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#company" data-dept="snCompany" data-backdrop="static" data-keyboard="false"></span>--%>
                    </div>
                </div>
                <div class="form-group sn">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">协办单位</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" name="snOtherCompany" data-obj="1" class="form-control" readonly="readonly" placeholder="请输入协办单位" data-toggle="modal" data-target="#company" data-dept="snOtherCompany" data-backdrop="static" data-keyboard="false" datacol="yes" err="协办单位" checkexpession="NotNull">
                        <input type="hidden" name="snOtherCompanyIds" class="form-control">
                        <%--<span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#company" data-dept="snOtherCompany" data-backdrop="static" data-keyboard="false"></span>--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">完成时限</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" data-name="endTime" readonly="readonly" placeholder="请输入完成时间" class="form-control input-time" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" name="snEndTime" datacol="yes" err="完成时间" checkexpession="NotNull">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">启动时间</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" readonly="readonly" data-name="startTime" placeholder="请输入启动时间" class="form-control input-time" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" name="snStartTime" datacol="yes" err="启动时间" checkexpession="NotNull">
                    </div>
                </div>
                <div class="form-group tac sn">
                    <button type="button" class="btn btn-primary-c" data-btn="sure">提交</button>
                    <button type="button" class="btn btn-default-c" data-btn="reset">取消</button>
                </div>
            </div>
        </div>
        <% } %>

        <% if (page == 17 || page == 18)
            { %>
        <div style="display: block">
            <asp:Repeater ID="Repeater17" runat="server" OnItemDataBound="Repeater17_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">主办单位</h3>
                            <div class="detail-col detail-col-1">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("DeptName") %>"><%#Eval("DeptName") %></span>
                                </div>
                                <div class="col">
                                    <span>完成时间
                                    </span>
                                    <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                </div>
                                <div class="col">
                                    <span>完成进度
                                    </span>
                                    <span class="process1"><%# FinishPercentFormat(Eval("FinishPercent")) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="detail-box">
                        <asp:Repeater ID="Repeater17_1" runat="server" OnItemDataBound="Repeater17_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
                                    <h3 class="st"><span class="line line-primary"></span>措施<%# GetIndexForItem(Convert.ToString(Eval("TargetId"))) %></h3>
                                    <!--新增加详情记录-->
                                    <%--<div class="tar rc rr">
                                        <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                            历史记录
                                        </button>
                                        <div class="rb">
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory">反馈记录</button>
                                            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
                                        </div>
                                    </div>--%>
                                    <!--end新增加详情记录-->
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%# DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成进度</span>
                                            <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block">
                                        <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <asp:Repeater ID="Repeater17_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%# GetIndexForSubItem(Eval("ParentTargetItemId").ToString()) %><span class="s"><%#Eval("ItemId") %></h3>
                                            <!--新增加详情记录-->
                                            <div class="tar rc rr">
                                                <button type="button" class="btn btn-default-s pop" data-container="body" data-toggle="popover" data-placement="bottom" data-original-title="" title="">
                                                    历史记录
                                                </button>
                                                <div class="rb">
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" name="btnFeedbackHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">反馈记录</button>
                                                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%#Eval("TargetId") %>" data-targetitemid="<%#Eval("ItemId") %>">操作记录</button>
                                                    <%#ShowChangeRecordBtn(Eval("ItemId").ToString())?"<button type='button' class='btn btn-default-s' data-toggle='modal' data-target='#changeRecord' name='btnChangeHistory' data-itemid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"'>变更记录</button>":"" %>
                                                </div>
                                            </div>
                                            <!--end新增加详情记录-->
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#DateFormat(Convert.ToDateTime(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成进度</span>
                                                    <span class="process"><%# FinishPercentFormat(Eval("FinshPercent")) %></span>
                                                </div>
                                            </div>
                                            <div class="detail-block">
                                                <p class="f"><span class="iconfont icon-sv-sound"></span><%# GetRecentOpinionByItemId(Eval("ItemId").ToString()) %></p>
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
            <div class="opinion-type"></div>
            <div class="form-group">
                <label class="font-lg">审批意见</label>
                <textarea class="form-control thx" id="opinion"></textarea>
            </div>
        </div>
        <%} %>

        <div class="tar">
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" data-targetid="" data-targetitemid="">反馈记录</button>
            <button type="button" name="btnOpreaHistory" data-targetid="" data-targetitemid="" class="btn btn-default-s" data-toggle="modal" data-target="#opera">操作记录</button>
        </div>

        <% if (page == 3)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c" id="submit">确定</button>
        </div>
        <% } %>
        <% if (page == 2 || page == 4)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c" name="btnSubmit" data-type="1">同意</button>
            <button type="button" class="btn btn-default-c" name="btnSubmit" data-type="0">不同意</button>
        </div>
        <% } %>
        <% if (page == 5)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c" name="btnSubmit" data-type="1">同意</button>
            <button type="button" class="btn btn-default-c" data-toggle="modal" data-target="#disagreeModal">不同意</button>
        </div>
        <% } %>
        <% if (page == 15)
            { %>
       <div class="tac" style="display: <%= IsAllFeedback(3,"")?"block":"none" %>;">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">同意</button>
        </div>
        <% } %>
        <% if (page == 6 || page == 9)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c">反馈进度</button>
            <button type="button" class="btn btn-default-c">继续分解</button>
        </div>
        <% } %>
        <% if (page == 7 || page == 8 || page == 11)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c" id="btnSubmit">提交</button>
        </div>
        <% } %>
        <% if (page == 17)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">同意</button>
            <button type="button" class="btn btn-default-c">不同意</button>
        </div>
        <% } %>
        <% if (page == 18)
            { %>
        <div class="tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">发送</button>
        </div>
        <% } %>
    </div>
    <div class="main main3" style="display: none">
        <div class="tal buttons" style="display: block; height: 28px">
            <button class="btn btn-default-s tal-head-right" type="button">切换表单</button>
        </div>
        <div class="table-page">
            <table class="table table-bordered table-static-width" id="pageList">
                <thead>
                    <tr>
                        <th style="width: 44px;">序号</th>
                        <th style="width: 140px">督查编号</th>
                        <th style="width: 180px">重点工作任务</th>
                        <th style="width: 72.8px">任务进度</th>
                        <th style="width: 78.4px">最新反馈</th>
                        <th style="width: 72.8px">主管领导</th>
                        <th style="width: 72.8px">协管领导</th>
                        <%--  <th style="width: 110px">主办单位</th>--%>
                        <%--<th>状态</th>--%>
                        <th style="width: 110px">主办单位</th>
                        <th style="width: 180px">年度目标</th>
                        <th style="width: 72.8px;">目标进度</th>
                        <th style="width: 72.8px;">最新反馈</th>
                        <th style="width: 87.2px;">措施流水号</th>
                        <th style="width: 180px">措施</th>
                        <th style="width: 72.8px;">完成时间</th>
                        <th style="width: 72.8px;">措施进度</th>
                        <th style="width: 237.6px">最新反馈</th>
                        <th style="width: 72.8px">责任处室</th>
                        <th style="width: 180px">子措施</th>
                        <th style="width: 96px;">子措施进度</th>
                        <th style="width: 509.6px;">最新反馈</th>
                        <th style="width: 72.8px">责任人</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

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

    <!--退回弹窗-->
    <div class="modal fade feedback" tabindex="-1" role="dialog" id="backModal">
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
                        <textarea class="form-control thx" id="backReason"></textarea>
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
                <div class="modal-body modal-form checkInput">
                    <div class="form-group feedback-details">
                        <p>
                            完成进度<span class="c-danger">（*）</span>
                        </p>
                        <input class="form-control" type="text" id="finishPercent_Modal" data-type="num" datacol="yes" err="完成进度" checkexpession="Num" />
                    </div>
                    <div class="form-group feedback-details">
                        <p>
                            反馈意见<span class="c-danger">（*）</span>
                        </p>
                        <textarea class="form-control thx" id="opinion_Modal" datacol="yes" err="反馈意见" checkexpession="NotNull"></textarea>
                    </div>
                    <p>请选择下一步骤</p>
                    <div class="b">
                        <div class="l si">
                            <p>选择发送</p>
                            <ul class="list-unstyled" role="tablist" id="stepList">
                                <%-- <li role="presentation" class="active"><a href="#tab1" aria-controls="home" role="tab" data-toggle="tab">反馈结束</a></li>
                                        <li role="presentation"><a href="#tab2" aria-controls="profile" role="tab" data-toggle="tab">审核</a></li>
                                        <li role="presentation"><a href="#tab3" aria-controls="profile" role="tab" data-toggle="tab">审批</a></li>
                                        <li role="presentation"><a href="#tab4" aria-controls="messages" role="tab" data-toggle="tab">会签单位</a></li>
                                        <li role="presentation"><a href="#tab5" aria-controls="settings" role="tab" data-toggle="tab">任务结束</a></li>--%>
                            </ul>
                        </div>
                        <div class="r">
                            <p>已选择</p>
                            <div class="tab-content" id="stepUserList">
                            </div>
                        </div>
                    </div>
                    <div class="form-group tac">
                        <button type="button" class="btn btn-primary-s" id="surePage3">确定</button>
                        <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end同意弹窗-->

    <!--不同意弹窗-->
    <div class="modal fade feedback" tabindex="-1" role="dialog" id="disagreeModal">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">选择退回主办单位</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group check-ele" id="returnDeptList">
                    </div>
                    <div class="form-group tac">
                        <button type="button" class="btn btn-primary-s" name="btn-disagree-confirm">确定</button>
                        <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end不同意弹窗-->

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
                        <h3><span class="line"></span>公司领导批示</h3>
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
                        <h3><span class="line"></span>主办单位意见</h3>
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
        <div class="modal-dialog" role="document" style="width: 610px; margin: 30px auto;">
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
</body>
</html>


<script src="Script/require.js"></script>
<script>
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
    require(['jquery', 'mustache', 'common', 'state', 'lodash', 'LeaderMeetingMissionDetail', 'AJAX', 'bootstrap', 'picker', 'toast', "Form-validator", 'jquery.iframe-transport', 'jquery.fileupload', 'cs-opinion'], function ($, Mustache, cm, state, _, LMM, Ajax) {
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
        //新增措施
        $(document).on('click', '[data-add="year-target"]', function (e) {
            var $this = $(e.target)
            var template = $('#targetTempl').html();
            state.setIndex({
                isDel: true
            });
            Mustache.parse(template);
            var rendered = Mustache.render(template, { index: state.getIndex() });
            //$('.card-outter').append(rendered);
            $('.first').before(rendered)
            cm.showPicker();
        })
        //确认措施
        $(document).on('click', '[data-add="target-step"]', function (e) {
            var $this = $(e.target)
            var $body = $this.closest('.card-body')
            var $box = $this.closest('.card-box')
            var $form = $this.closest('.form-group')
            var html = ['<div class="card-header step-first"><h3 class="title"><span class="line"></span>',
                '添加措施',
                '</h3 >',
                '<span class="iconfont icon-sv-add" data-add="target-child"></span>',
                '</div>'
            ]
            if ($box.find('.form-control').val().trim() === '') {
                alert('目标不能为空')
                return
            }
            state.setValue('isDel', false);
            $form.hide()
            $body.find('button').hide()
            $body.find('.form-control').attr('disabled', true).addClass('disabled')
            $body.find('.icon-sv-trash').show()
            $box.append(html.join(''))
            state[thatState].text = $box.find('.form-control').val()
        })
        //添加子措施
        $(document).on('click', '[data-add="add-step-child"]', function (e) {
            var $this = $(e.target)
            var template = $('#steoChildTempl').html();
            state.setIndex({
                isDel: true,
                measureId: '',
                targetId: '',
                employ: {}
            })
            Mustache.parse(template);
            var rendered = Mustache.render(template, { index: state.getIndex() });
            $this.closest('.detail-opera').before(rendered)
            cm.showPicker();
            //获取设置子措施对应的主办单位ID和措施ID
            var measureid = $this.closest('[data-measureid]').data('measureid')
            var targetid = $this.closest('[data-targetid]').data('targetid')
            var $index = $this.parent().prev().data('index')
            state.setPage($index)  //先设置索引
            state.setValue('measureId', measureid)
            state.setValue('targetId', targetid)
        });

        //确认子措施
        $(document).on('click', '[data-add="finishStep"]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.detail-part')
            var flag = false;
            //$.each($box.find('.form-control'), function (index, obj) {
            //    // 协办单位index=1为选填项。
            //    if ($(obj).val() === '' && index != 1) {
            //        flag = true;
            //        layer.msg('子措施,完成时间,责任人必须填写', { icon: 7 });
            //        return false;
            //    }
            //});
            if ($box.find('.form-control').val().trim() === '') {
                layer.msg('子措施不能为空', { icon: 7 });
                return false;
            }
            else {
                //检查措施的长度
                if (!LMM.CheckStringLength($box.find('.form-control').val().trim(), LMM.SUB_MEASURE_MAX_LENHTH, '子措施')) {
                    return false;
                }
            }
            if ($box.find('.input-time').val().trim() === '') {
                layer.msg('完成时间不能为空', { icon: 7 });
                return
            }
            if ($box.find('[name="person"]').val().trim() === '') {
                layer.msg('责任人不能为空', { icon: 7 });
                return false;
            }
            $this.closest('.form-child').addClass('disabled')
            $this.closest('.form-child').find('.form-control').attr('disabled', true).addClass('disabled')
            $('[data-btn="send"]').show()
            $box.find('.icon-sv-trash').show();
            state.setValue('text', $box.find('.form-control').val());
            state.setValue('endTime', $box.find('.input-time').val());
            state.setValue('isDel', false);
        });
        //取消
        $(document).on('click', '[data-cancel]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('[data-index]')
            var $cIndex = $this.closest('[data-index]').data('index')
            var $index = $box.data('index')
            var $key = $box.data('key')
            $box.remove()
            state.setPage($index);
            if ($index)
                state.setValue('isDel', true);
            if ($key)
                state[$cIndex - 1].child[$key - 1].isDel = true
        })
        //点击显示日历
        $(document).on('click', '.input-time', function () {
            $(this).datetimepicker('show');
        })
        //移开保存
        $(document).on('blur', '.form-control', function (e) {
            var $this = $(e.target)
            var isAdd = $this.closest('.card-body').find('[data-cancel]')
            var $box = $this.closest('[data-index]')
            var $index = $box.data('index')
            var $key = $box.data('key')
            var $name = $this.get(0).tagName.toLowerCase();
            var $attr = $this.attr('data-name')
            if ($index)
                state.setPage($index)
            if ($name === 'textarea' && $index) {
                state.setValue('text', $this.val())
            }
            if ($name === 'input' && $key && $attr === 'dataPicker') {  //新增data-name=dataPicker 条件，防止更改协办单位或责任处室时，日期被更改
                state.setValue('endTime', $this.val());
            }
            if (isAdd.is(':hidden')) {
                $this.addClass('disabled').prop('disabled', true)
                $this.next('.icon-sv-add').hide()
            }
        })
        //责任搜索
        function searchMan(word) {
            return $.ajax({
                type: "POST",
                data: JSON.stringify({ UserId: word }),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
            })
            /*.done(function (data) {
            
        }).fail(function (err) {
            alert("请求发生异常");
        })
        */
        }
        //搜索责任人
        $(document).on('click', '#btSearchAssLeader', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.input-group').find('input')
            var $word = $box.val();
            if ($word.trim() === '') return
            var data = searchMan($word)
            $.when(searchMan($word)).done(function (data) {
                if (data.d.status == "1") {
                    var jd = JSON.parse(data.d.data);
                    cm.getPerson(jd)
                } else {
                    layer.alert(data.d.message);
                }
            }).fail(function (err) {
                layer.msg("请求发生异常", { icon: 7 });
            })
        })
        //确认责任人
        $(document).on('click', '#btConfirmSelectAssLeader', function (e) {
            var person = state.getPerson('person');
            $('[data-index="' + state.getIndex() + '"] [name="person"]').val(person).attr('title', person)
            $('#leaderModal').modal('hide')
        })
        //点击修改
        $(document).on('click', '.form-group', function (e) {
            var $this = $(e.target)
            $this.removeClass('disabled').prop('disabled', false)
            $this.next('.icon-sv-add').show()
        })
        //确认措施
        $(document).on('click', '[data-add="finish"]', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.card-box')
            var $key = $box.data('key')
            if ($box.find('.form-control').val().trim() === '') {
                layer.msg('措施不能为空', { icon: 7 });
                return
            }
            else {
                //检查措施的长度
                if (!LMM.CheckStringLength($box.find('.form-control').val().trim(), LMM.MEASURE_MAX_LENHTH, '措施')) {
                    return
                }
            }
            if ($box.find('.input-time').val().trim() === '') {
                layer.msg('完成时间不能为空', { icon: 7 });
                return
            }
            if ($box.find('[name="office"]').val().trim() === '') {
                layer.msg('责任处室不能为空', { icon: 7 });
                return
            }
            $this.closest('.form-child').addClass('disabled')
            $this.closest('.form-child').find('.form-control').attr('disabled', true).addClass('disabled')
            $('[data-btn="sure"]').show()
            $box.find('.icon-sv-trash').show()
            state.setValue('isDel', false)
            //state.setValue(,$box.find('.form-control').val())
        })
        //责任处室
        $(document).on('click', '[name="office"]', function (e) {
            state.setDeptType('office');
            state.setSingle(true);
        })
        $(document).on('click', 'span[name="office"]', function (e) {
            state.setDeptType('office');
            state.setSingle(true);
        })
        //责任处室
        $(document).on('click', '[name="company"]', function (e) {
            state.setDeptType('company');
            state.setSingle(false);
            state.setPage($(e.target).closest('[data-index]').data('index'))
        })
        $(document).on('click', 'span[name="company"]', function (e) {
            state.setDeptType('company');
            state.setSingle(false);
            state.setPage($(e.target).closest('[data-index]').data('index'))
        })
        //责任人
        $(document).on('click', '[name="person"]', function (e) {
            state.setDeptType('person');
            state.setSingle(true);
        })

        //textarea高度自适应
        //cm.resetTextarea();

        //措施下的textarea
        $(".card-body .detail-block .form-group textarea").on('keyup',
            function (e) {
                var $this = $(e.target);
                if ($('.detail-block textarea').attr('class', 'form-control').val().length >= 80) {
                    $this.css({ 'height': '52px', 'overflow': 'auto' });
                    $this.parent('.form-group').css('margin-top', '10px');
                } else {
                    $this.css({ 'height': '30px', 'overflow-y': 'hidden' });
                    $this.parent('.form-group').css('margin-top', '5px')
                };
            });

        //确定部门
        $(document).on('click', '[data-btn="deptSure"]', function (e) {
            $('[data-index="' + (state.getPage() + 1) + '"]').find('[name="' + state.dType + '"]').val(state.getDeptByName());
            $('#company').modal('hide');
        })
        //确定责任人
        $(document).on('click', '[data-btn="btConfirmSelectAssLeader"]', function (e) {
            $('[data-index="' + state.getIndex() + '"]').find('[name="' + state.dType + '"]').val(state.getPerson());
            $('#company').modal('hide');
        })
        //删除目标或措施
        $(document).on('click', '.icon-sv-trash', function (e) {
            var $this = $(e.target)
            $('#deleteModal').modal('show')
            var type = $(this).data('type');
            var $box = $this.closest('[data-index]')
            var $index = $box.data('index')
            $('#tips').text('确定删除该' + (type === 'cs' ? '措施' : '子措施') + '吗？').attr('data-index', $index);
        })
        //确认删除
        $(document).on('click', '[data-delete="sure"]', function (e) {
            var $this = $(e.target).closest('.modal-content').find('p')
            var $index = $this.attr('data-index');
            $('[data-index="' + $index + '"]').remove()
            state.setPage($index);
            state.setValue('isDel', true);
            $this.removeAttr('data-index')
            $('#deleteModal').modal('hide')
        });

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
                var html = $(this).closest('.rc').find('.rb').html().trim()
                html = html.replace(/class=".*?"/ig, '')
                return '<div class="hl">' + html + '</div>'
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

        //措施分解、责任处室分解子措施步骤需加载部门相关信息
        if (LMM.CurrentPage == "8" || LMM.CurrentPage == "11" || LMM.CurrentPage == "16") {
            //获取部门组列表。
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetGroupListByUser",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    var deptGroup = JSON.parse($(data).find("data").text());
                    cm.getDeptGroup(deptGroup);
                },
                error: function (message) {
                    layer.msg('获取部门组列表失败', { icon: 7 });
                }
            });
            //获取部门信息
            $.ajax({
                url: "WebServices/SuperviseMissionWebServices.asmx/GetAllActiveDeptList",
                type: "post",
                dataType: "xml",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                    var dept = JSON.parse($(data).find("data").text());
                    cm.getDept(dept);
                },
                error: function (message) {
                    layer.msg('获取部门列表失败', { icon: 7 });
                }
            });
        }

        $('textarea.form-control').on('keyup', function (e) {
            var $this = $(e.target);
            if ($('textarea.form-control').val().length >= 80) {
                $this.css({ 'height': '52px', 'overflow': 'auto' });
                $this.parent('.form-group').css('margin-top', '10px');
            } else {
                $this.css({ 'height': '30px', 'overflow-y': 'hidden' });
                $this.parent('.form-group').css('margin-top', '5px')
            };
        });

        //控制进度，小喇叭的显示隐藏
        //获取进度span
        $(document).find('span.process,span.process1,span.c-danger').each(function () {
            var $this = $(this);
            var spanParent = $this.parent('.col');
            var spanGrandpa = $this.parents('.detail-col');
            var SmallHorn = spanGrandpa.next('.detail-block');
            if ($this.html() == '%' || $this.html() == '') {
                if ($this.parents('.card-body.detail-line').nextUntil('.cs.collapsed')) {
                    $this.parents('.card-box.card.card-box-1').css('padding-bottom', '30px');
                    $this.parents('.card-body.detail-line').nextUntil('.collapse.in').css({ 'margin-top': '30px', 'border-top': '1px dashed #e5e5e5' });
                    $this.parents('.card-body.detail-line').next('a.cs').css({ 'margin-top': '5px', 'border-top': 'none' });
                    $this.parents('.card-body.detail-line').css('border', 'none');
                    if (SmallHorn.css('display', 'none')) {
                        spanGrandpa.css('margin-bottom', '50px')
                    }
                };
                SmallHorn.hide();
                spanParent.remove();

            };

        });

        //详情页加载图表相关
        if (LMM.CurrentPage == "1") {
            //切换图表
            $('.main2 .tal-head-right').click(function () {
                $('.main2').hide();
                $('.main3').show();
            });
            $('.main3 .tal-head-right').click(function () {
                $('.main2').show();
                $('.main3').hide();
            });

            //切换图表
            var statisticsPageListRequestEntity = {
                PageIndex: 1,
                PageSize: 10,
                SmId: getQueryString("smid")
            };
            var postdata = {
                statisticsPageListRequestEntity: statisticsPageListRequestEntity
            };
            var ret = Ajax({ FunName: 'GetStatisticSMListByPage', async: true, callback: ViewListData, data: postdata, isFristSearch: true });
        }


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
                    layer.alert("请求发生异常");
                }
            });
        };
        //附件列表
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


        //变更历史记录公用部分
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
                        layer.alert(data.d.message);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.alert("请求发生异常");
                },
                cache: false
            });
        });

        //刷新父级页面处理
        window.onunload = function () {
            location.href.toLowerCase().indexOf('stepid') > -1 ? window.opener.document.getElementById('pending').click() : window.opener.document.getElementById('task').click()
        };
    })
</script>
