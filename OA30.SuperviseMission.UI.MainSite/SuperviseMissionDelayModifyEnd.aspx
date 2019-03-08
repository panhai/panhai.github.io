<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionDelayModifyEnd.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionDelayModifyEnd" %>


<!DOCTYPE html>
<% int page = this.page; %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>年度变更拟稿</title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <style type="text/css">
        .buttons {
            margin-bottom: 20px;
        }

            .buttons button {
                background: #15497d;
                color: #fff;
                border-radius: 5px;
                margin-right: 10px;
            }

        h3 {
            font-size: 16px;
            font-weight: 500;
        }

        label {
            font-weight: 500;
        }

        p {
            margin: 0;
            padding: 0;
        }

        .detail-box .detail-part .col, .card-box .detail-col .col {
            height: 32px;
            line-height: 32px;
        }

        .sedit {
            margin-top: -5px;
        }

        .detail-box .detail-part .col span.wlg {
            width: 90%;
            margin-bottom: 0;
        }

        .detail-col-3 .col .wlg input {
            width: 100%;
        }

        .detail-col-3 .col .wlg input {
            text-align: left;
        }

        .twl.disabled[disabled] {
            resize: none;
            width: 100%;
            text-align: left;
            height: 16px;
            overflow: hidden;
            margin-top: 5px;
            font-size: 12px;
        }

        textarea.form-control.twl {
            margin-top: 10px;
            resize: none;
        }

        .bft {
            background: #f5f5f5;
            padding: 5px 0px;
            margin-top: -15px;
        }

        .bf .sedit {
            display: none;
        }

        .card .card-header h3 {
            margin-bottom: 0;
            margin-top: 0;
        }

        .card .card-header p {
            font-size: 12px;
        }

        .detail-step .detail-block textarea {
            margin-left: 0px !important;
            font-size: 12px;
        }

        .detail-box .detail-part > p {
            background: inherit;
        }

        .detail-col .col {
            font-size: 12px;
        }

        .card .card-header p span > span {
            display: block;
        }

        .detail-step .detail-block .t span + span {
            font-size: 12px;
        }

        .t span:nth-child(3) {
            display: block;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        .detail-part > p > span > span {
            display: block;
        }

            .detail-part > p > span > span > span {
                font-size: 12px;
            }

        .bf .detail-box .detail-part p {
            display: block;
            /*height:50px;*/
        }

        .card textarea.disabled[disabled] {
            margin-left: 0px !important;
        }

        .card .card-header p {
        }

        .card .card-body .detail-step .detail-block h3 {
            /*height:90px;*/
            margin: 0;
        }

        .detail-box .detail-part p {
            /*height:50px;*/
        }

        .card-body .detail-step .detail-block .detail-col .col span > input, .card .card-header .detail-col .col .dib input, .detail-box .detail-col .col .tal input {
            font-size: 12px;
        }

        .edit-body textarea {
            height: 54px;
        }

        .edit-body .detail-box .detail-part .col, .edit-body .card-box .detail-col .col {
            /*display:block;*/
            /*width:100%;*/
        }

        .edit-body .detail-col .col, .edit-body .card .card-header .detail-col .col, .edit-body .card .card-body .detail-step .detail-col .col {
            width: 100%;
        }

        .edit-body .detail-box .detail-part .detail-col {
            /*background:#fff;*/
        }

        .edit-body .detail-col {
            /*background:#fff;*/
        }

        .edit-body .bf .modify, .edit-body .af .modify {
            background: #fff !important;
            margin-top: 10px;
        }

        .edit-body .modify .col {
            display: block;
            width: 100% !important;
            margin-bottom: 10px;
        }

        .edit-body .dct {
            margin-top: 0;
        }

        .edit-body .detail-part input, .edit-body .dib input {
            background: inherit;
            font-size: 12px;
            width: 100%;
            height: 28px;
        }
        /*年度*/
        .edit-body .detail-box .detail-part p textarea {
            font-size: 12px;
            height: 60px;
        }
        /*措施*/
        .edit-body .card .card-header textarea {
            background: inherit;
            margin-top: 10px !important;
            margin-bottom: 15px;
            margin-left: 0px !important;
            font-size: 12px;
            height: 60px;
        }
        /*子措施*/
        .edit-body .card-body .detail-step .detail-block h3 > textarea {
            margin-top: 10px;
            font-size: 12px;
            height: 60px;
            width: 99.5%;
        }

        .edit-body .detail-col .col {
            width: 100%;
        }

        .card-content {
            font-size: 12px;
        }

        .detail-col-3 .col span {
            font-size: 12px;
        }

        .detail-step .detail-block .col .dib input, .card-body .detail-col-3 .col .dib input {
            font-size: 12px;
        }

        .af {
            margin-bottom: -5px;
        }

        .dib input {
            font-size: 12px;
        }

        .card .detail-col .col > span:first-child {
            color: #959fab;
        }

        .card-body > p {
            font-size: 12px;
        }

        .detail-step .detail-block .t .line {
            background: #52cc2c;
            display: inline-block;
            height: 17px;
            width: 3px;
            position: relative;
            top: 5px;
            left: -10px;
        }

        .detail-col {
            /*margin-top: 10px;*/
        }

        .detail-block {
            padding-top: 8px;
        }

        .edit-body textarea {
            width: 100%;
            margin: 0;
        }

        .edit-body .detail-box .detail-part .col {
            margin: 0;
            padding: 0;
        }

            .edit-body .detail-box .detail-part .col span:first-child {
                padding-left: 0;
                margin-left: 0;
            }

            .edit-body .detail-box .detail-part .col span:nth-child(2) {
                width: calc(100% - 55px);
            }

        .edit-body .card .card-body .detail-col .col .dib input {
            width: 99.5%;
        }

        .edit-body .card .detail-col .col > span:first-child {
            color: #235280;
        }

        .t {
            margin-bottom: 5px;
        }

        .modal-form .b .l ul {
            overflow: visible;
        }

        .modal-form .b .l > p {
            margin: 0 0 4px 10px;
            line-height: 22px;
        }
        input.form-control {
            display:inherit;
        }
    </style>
</head>
<body>
    <div class="main main2" url="<%=page %>">
        <div class="card">
            <div class="card-header card-header-line">
                <h3 class="title"><% if (page == 2)
                                      { %>
                                        延期申请单
                                  <% }
                                      else if (page == 3)
                                      { %></h3>
                中止申请单
                                  <% }
                                      else if (page == 4)
                                      { %>
                                        办结申请单
                                  <% }
                                      else if (page == 5)
                                      { %>
                                        调整申请单
                                  <% } %>
                <span class="iconfont-title">变更文档ID：后台自动生成</span>
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

        <% if (page == 5)
            { %>
        <!--调整申请单-->
        <% if (!isParentTargetItem)
            { %>
        <!--子措施-->
        <div class="bf">
        </div>
        <div class="af">
            <div style="display: block" data-index="1">
                <div class="bft">调整后</div>
                <asp:Repeater ID="Repeater7" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                    <ItemTemplate>
                        <div class="detail-box detail-box2">
                            <div class="detail-part detail-line">
                                <h3 class="c">年度目标</h3>
                                <input type="hidden" name="TargetId" value="<%#Eval("TargetId") %>" />
                                <p><%#Eval("TargetName") %></p>
                                <div class="detail-col dct ">
                                    <div class="col">
                                        <span>主办单位</span>
                                        <span><%#Eval("MainDeptName") %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater2_2" runat="server" OnItemDataBound="Repeater2_2_ItemDataBound">
                            <ItemTemplate>
                                <div class="card card-box card-line">
                                    <div class="card-header">
                                        <h3 class="st">
                                            <span class="line"></span>措施
                                        </h3>
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
                                        <asp:Repeater ID="Repeater2_2_2" runat="server">
                                            <ItemTemplate>
                                                <input type="hidden" name="ItemId" value="<%#Eval("ItemId") %>" />
                                                <input type="hidden" name="ParentTargetItemId" value="<%#Eval("ParentTargetItemId") %>" />
                                                <div class="detail-step">
                                                    <div class="detail-block detail-block-2">
                                                        <h3 class="t">
                                                            <span class="line"></span>子措施<span class="s"><%#Eval("ItemId") %></span>
                                                        </h3>
                                                        <div class="tac r">
                                                            <button type="button" class="btn btn-second-s sedit">修改</button>
                                                        </div>
                                                        <div class="col">
                                                            <span class="dib wlg" style="margin-bottom: 0; width: 100%">
                                                                <input type="text" data-type="itemname" name="ItemName" class="form-control disabled" disabled="disabled" value="<%#Eval("ItemName")%>" />
                                                            </span>
                                                        </div>
                                                        <div class="detail-col">
                                                            <div class="col">
                                                                <span>协办单位</span>
                                                                <span class="dib wlg">
                                                                    <input data-type="assistdeptid" class="form-control disabled" data-obj="1" data-key="<%#Eval("AssistDeptId") %>" data-val="<%#Eval("AssistDeptName")%>" name="company" value="<%#Eval("AssistDeptName") %>" disabled="disabled" data-toggle="modal" data-target="#company" />
                                                                </span>
                                                            </div>
                                                            <div class="col">
                                                                <span>完成时间</span>
                                                                <span class="dib wlg">
                                                                    <%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %>
                                                                </span>
                                                            </div>
                                                            <div class="col">
                                                                <span>责&nbsp;&nbsp;任&nbsp;人</span>
                                                                <span class="dib wlg">
                                                                    <input type="text" data-type="excutorname" readonly="readonly" name="employ" data-toggle="modal" disabled="disabled" data-target="#leaderModal" class="form-control disabled" value="<%#Eval("ExcutorName") %>" />
                                                                </span>
                                                            </div>
                                                        </div>
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
        </div>
        <div class="card card-box reson" style="display: none;">
            <div class="card-header">
                <h3 class="c-primary">调整原因
                </h3>
                <div class="form-group">
                    <textarea name="Reason" class="form-control th4"></textarea>
                </div>
            </div>
        </div>
        <!--end子措施-->
        <% }
            else
            { %>
        <!--措施-->
        <div class="bf">
        </div>
        <div style="display: block" class="af">
            <div class="bft">调整后</div>
            <asp:Repeater ID="Repeater8" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line" data-index="1">
                            <h3 class="c">年度目标</h3>
                            <p>
                                <input type="hidden" name="TargetId" value="<%#Eval("TargetId") %>" />
                                <p><%#Eval("TargetName") %></p>
                            </p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span><span class="tal">
                                        <span><%#Eval("MainDeptName") %></span>
                                    </span>
                                </div>
                            </div>
                            <div class="tar rc rr">
                                <button type="button" class="btn btn-second-s sedit">修改</button>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater3_3" runat="server" OnItemDataBound="Repeater3_3_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header" data-index="2">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                    <p>
                                        <input type="hidden" name="ItemId" value="<%#Eval("ItemId") %>" />
                                        <input type="hidden" name="ParentTargetItemId" value="<%#Eval("ParentTargetItemId") %>" />
                                        <textarea data-type="itemname" name="ItemName" class="disabled form-control twl st th3" disabled="disabled"><%#Eval("ItemName") %></textarea>
                                    </p>
                                    <div class="detail-col">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span class="dib wlg">
                                                <input type="text" data-type="assistdeptid" data-obj="1" class="form-control disabled" disabled="disabled" data-key="<%#Eval("AssistDeptId") %>" data-val="<%#Eval("AssistDeptName") %>" name="company" data-toggle="modal" data-target="#company" value="<%#Eval("AssistDeptName") %>" />
                                            </span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span>
                                                <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                            </span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span class="dib wlg">
                                                <input type="text" data-type="dutydeptid" data-obj="1" class="form-control disabled" disabled="disabled" data-key="<%#Eval("DutyDeptId") %>" data-val="<%#Eval("DutyDeptName") %>" data-dept="office" name="office" data-single="true" data-toggle="modal" data-target="#company" value="<%#Eval("DutyDeptName") %>" />
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">

                                    <div class="clearfix"></div>
                                    <asp:Repeater ID="Repeater3_3_3" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step" data-index="<%#Container.ItemIndex + 3%>">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t st" style="padding-bottom: 0px;">
                                                        <span class="line"></span>子措施<span class="s"><%#Container.ItemIndex + 1%>号  <%#Eval("ItemId") %></span>
                                                        <textarea data-type="itemname<%#Container.ItemIndex + 1%>" name="ItemName" class="disabled form-control twl th4" disabled="disabled"><%#Eval("ItemName") %></textarea>
                                                        <input type="hidden" name="ItemId" value="<%#Eval("ItemId") %>" />
                                                    </h3>
                                                    <div class="detail-col">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span class="dib wlg">
                                                                <%# (DataBinder.Eval(Container.DataItem, "Status").ToString()=="0")
                                                                    ? "<input type='text' data-type='assistdeptname"+DataBinder.Eval(Container.DataItem, "ItemId")+"' class='form-control disabled' data-obj='1' data-key='"+DataBinder.Eval(Container.DataItem, "AssistDeptId")+"' data-val='"+DataBinder.Eval(Container.DataItem, "AssistDeptName")+"' readonly='readonly' name='company' disabled='disabled' data-toggle='modal' data-target='#company' value='"+DataBinder.Eval(Container.DataItem, "AssistDeptName")+"' />"
                                                                    : "<span>"+DataBinder.Eval(Container.DataItem, "AssistDeptName")+"</span>" %>
                                                                <input type="hidden" name="ParentTargetItemId" value="<%#Eval("ParentTargetItemId") %>" />
                                                            </span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责&nbsp;&nbsp;任&nbsp;人</span>
                                                            <span class="dib wlg">
                                                                <%# (DataBinder.Eval(Container.DataItem, "Status").ToString()=="0")
                                                                    ? "<input type='text' data-type='excutorname"+DataBinder.Eval(Container.DataItem, "ItemId")+"' readonly='readonly' data-obj='1' data-key='"+DataBinder.Eval(Container.DataItem, "ExcutorId")+"' data-val='"+DataBinder.Eval(Container.DataItem, "ExcutorName")+"' name='employ' data-toggle='modal' disabled='disabled' data-target='#leaderModal' class='form-control disabled' value='"+DataBinder.Eval(Container.DataItem, "ExcutorName")+"' />"
                                                                    : "<span>"+DataBinder.Eval(Container.DataItem, "ExcutorName")+"</span>" %>
                                                            </span>
                                                        </div>
                                                    </div>

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
        <div class="card card-box reson" style="display: none;">
            <div class="card-header">
                <h3 class="c-primary">调整原因
                </h3>
                <div class="form-group">
                    <textarea name="Reason" class="form-control thx"></textarea>
                </div>
            </div>
        </div>
        <!--end措施-->
        <% } %>


        <!--end调整申请单-->
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c action">确认调整</button>
            <button type="button" class="btn btn-primary-c action1" style="display: none;" data-toggle="modal" data-target="#agreeModal">提交</button>
            <button type="button" class="btn btn-default-c action2" style="display: none;">返回修改</button>
        </div>

        <% } %>


        <% if (page == 2)
            { %>
        <div class="bf"></div>
        <!--延迟申请单-->
        <% if (!isParentTargetItem)
            { %>
        <!--子措施-->
        <div style="display: block" class="af">
            <div class="bft">调整后</div>
            <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2 pr">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col dct">
                                <div class="col">
                                    <span>主办单位</span><span class="tal">
                                        <%#Eval("MainDeptName") %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater2_2" runat="server" OnItemDataBound="Repeater2_2_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施
                                    </h3>
                                </div>
                                <div class="card-body">
                                    <p class="card-content"><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-1">
                                        <div class="detail-col">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span><%#Eval("AssistDeptName") %></span>
                                            </div>
                                            <div class="col">
                                                <span>完成时间</span>
                                                <span class="dib wlg"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                            </div>
                                            <div class="col">
                                                <span>责任处室</span>
                                                <span><%#Eval("DutyDeptName") %></span>
                                            </div>
                                        </div>

                                    </div>
                                    <asp:Repeater ID="Repeater2_2_2" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <div class="tar rc rr">
                                                        <button type="button" class="btn btn-second-s sedit" style="margin-right: 0px">修改</button>
                                                    </div>
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <div class="detail-col"></div>
                                                    <div class="detail-col detail-col-1">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <span class="dib wlg">
                                                                <input type="text" data-type="deadlinetime" disabled="disabled" class="form-control tal input-time disabled" style="text-align: left;" name="lateTime" value="<%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %>" /></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col">
                                                        <span class="c-primary">申请延期时限</span>
                                                        <span>
                                                            <input type="text" readonly="readonly" class="form-control tal input-time" style="text-align: left;" name="lateTime" value="" />
                                                        </span>
                                                    </div>--%>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="card card-box reson" style="display: none;">
                <div class="card-header">
                    <div class="form-group">
                        <label class="c-primary">延期原因</label>
                        <textarea class="form-control thx" name="lateReason"></textarea>
                    </div>
                </div>
            </div>
        </div>

        <!--end子措施-->
        <% }
            else
            { %>
        <!--措施-->

        <div style="display: block" class="af">
            <div class="bft">调整后</div>
            <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part pr detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col dct">
                                <div class="col">
                                    <span>主办单位</span><span class="tal">
                                        <%#Eval("MainDeptName") %>
                                    </span>
                                </div>
                            </div>
                            <div class="tar rc rr">
                                <button type="button" class="btn btn-second-s sedit">修改</button>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater3_3" runat="server" OnItemDataBound="Repeater3_3_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title"><span class="line line-primary"></span>措施</h3>
                                    <p><%#Eval("ItemName") %></p>
                                </div>
                                <div class="card-body">
                                    <div class="detail-col">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span class="dib wlg">
                                                <input type="text" data-type="deadlinetime" readonly="readonly" disabled="disabled" class="form-control input-time disabled" name="lateTime" value="<%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %>" />
                                            </span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <asp:Repeater ID="Repeater3_3_3" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<span class="s"><%#Container.ItemIndex + 1%>号  <%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <div class="detail-col">
                                                        <div class="col">
                                                            <span>协办单位</span>
                                                            <span><%#Eval("AssistDeptName") %></span>
                                                        </div>
                                                        <div class="col">
                                                            <span>完成时间</span>
                                                            <%--如果子措施是其他变更状态的，那么证明这条子措施正在走变更流程，故用户不能对这条子措施进行变更申请--%>
                                                            <span class="dib wlg" style="margin-bottom: 0px">
                                                                <%# (DataBinder.Eval(Container.DataItem, "Status").ToString()=="0")
                                                                    ? "<input type='text' data-type='deadlinetime"+DataBinder.Eval(Container.DataItem, "ItemId")+"' readonly='readonly' data-targetid='"+DataBinder.Eval(Container.DataItem, "ItemId")+"' disabled='disabled' class='form-control input-time disabled' name='targetItemLateTime' value='"+FormatDateTime(Convert.ToString(DataBinder.Eval(Container.DataItem, "DeadLineTime")))+"' />"
                                                            : "<span>"+FormatDateTime(Convert.ToString(DataBinder.Eval(Container.DataItem, "DeadLineTime")))+"</span>" %>
                                                            </span>
                                                        </div>
                                                        <div class="col">
                                                            <span>责任人</span>
                                                            <span><%#Eval("ExcutorName") %></span>
                                                        </div>
                                                    </div>
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
        <div class="card card-box reson" style="display: none;">
            <div class="card-header">
                <h3 class="c-primary">延期原因
                </h3>
                <div class="form-group">
                    <textarea class="form-control thx" name="lateReason"></textarea>
                </div>
            </div>
        </div>
        <!--end措施-->
        <% } %>
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c action">确认调整</button>
            <button type="button" class="btn btn-primary-c action1" style="display: none" data-toggle="modal" data-target="#agreeModal">提交</button>
            <button type="button" class="btn btn-default-c action2" style="display: none">返回修改</button>
        </div>
        <!--end调整申请单-->
        <% } %>

        <% if (page == 3)
            { %>
        <!--中止申请单-->

        <% if (!isParentTargetItem)
            { %>
        <!--子措施-->
        <div style="display: block">
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater2_2" runat="server" OnItemDataBound="Repeater2_2_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="st">
                                        <span class="line"></span>措施
                                    </h3>
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
                                    <asp:Repeater ID="Repeater2_2_2" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
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
                                                    </div>
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
        <!--end子措施-->
        <% }
            else
            { %>
        <!--措施-->
        <div style="display: block">
            <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater3_3" runat="server" OnItemDataBound="Repeater3_3_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub">
                                    <h3><span class="line line-primary"></span>措施</h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col">
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
                                    <div class="clearfix"></div>
                                    <asp:Repeater ID="Repeater3_3_3" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<span class="s"><%#Container.ItemIndex + 1%>号  <%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <div class="detail-col">
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
                                                    </div>
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
        <!--end措施-->
        <% } %>
        <div class="card card-box">
            <div class="card-header">
                <div class="form-group">
                    <label class="c-primary">中止原因</label>
                    <textarea class="form-control thx" id="stopReason"></textarea>
                </div>
            </div>
        </div>
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">提交</button>
            <button type="button" class="btn btn-default-c">取消</button>
        </div>
        <!--end中止申请单-->
        <% } %>


        <% if (page == 4)
            { %>
        <!--办结申请单-->
        <% if (!isParentTargetItem)
            { %>
        <!--子措施-->
        <div style="display: block">
            <asp:Repeater ID="Repeater6" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box detail-box2">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>

                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater2_2" runat="server" OnItemDataBound="Repeater2_2_ItemDataBound">
                        <ItemTemplate>
                            <div class="card card-box card-line">
                                <div class="card-header">
                                    <h3 class="title">
                                        <span class="line"></span>措施
                                    </h3>
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
                                    <asp:Repeater ID="Repeater2_2_2" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<span class="s"><%#Eval("ItemId") %></span>
                                                    </h3>
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
                                                    </div>
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
        <!--end子措施-->
        <% }
            else
            { %>
        <!--措施-->
        <div style="display: block">
            <asp:Repeater ID="Repeater5" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span><%#Eval("MainDeptName") %></span>
                                </div>

                            </div>
                        </div>
                        <asp:Repeater ID="Repeater3_3" runat="server" OnItemDataBound="Repeater3_3_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub">
                                    <h3><span class="line line-primary"></span>措施</h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col">
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
                                    <div class="clearfix"></div>
                                    <asp:Repeater ID="Repeater3_3_3" runat="server">
                                        <ItemTemplate>
                                            <div class="detail-step">
                                                <div class="detail-block detail-block-2">
                                                    <h3 class="t">
                                                        <span class="line"></span>子措施<span class="s"><%#Container.ItemIndex + 1%>号  <%#Eval("ItemId") %></span>
                                                    </h3>
                                                    <div class="detail-col">
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
                                                    </div>
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
        <!--end措施-->
        <% } %>

        <div class="card card-box">
            <div class="card-header">
                <div class="form-group">
                    <label class="c-primary">办结原因</label>
                    <textarea class="form-control thx" id="bjReason"></textarea>
                </div>
            </div>
        </div>
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-c" data-toggle="modal" data-target="#agreeModal">提交</button>
            <button type="button" class="btn btn-default-c">取消</button>
        </div>
        <!--end办结申请单-->
        <% } %>
    </div>

    <!--同意弹窗-->
    <div class="modal fade feedback" tabindex="-1" role="dialog" id="agreeModal">
        <div class="modal-dialog" role="document" style="width: 650px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">提交变更</h4>
                </div>
                <div class="modal-body modal-form">
                    <p>请选择下一步骤</p>
                    <div class="b">
                        <div class="l">
                            <p>选择发送</p>
                            <ul class="list-unstyled" role="tablist" id="stepList">
                                <%-- <li role="presentation" class="active"><a href="#tab1" aria-controls="home" role="tab" data-toggle="tab">上报</a></li>
                                        <li role="presentation"><a href="#tab2" aria-controls="profile" role="tab" data-toggle="tab">审核</a></li>
                                        <li role="presentation"><a href="#tab3" aria-controls="messages" role="tab" data-toggle="tab">会签单位</a></li>
                                        <li role="presentation"><a href="#tab4" aria-controls="settings" role="tab" data-toggle="tab">审批</a></li>--%>
                            </ul>
                        </div>
                        <div class="r">
                            <p>已选择</p>
                            <div class="tab-content" id="stepUserList">
                            </div>
                        </div>
                    </div>
                    <div class="form-group tac">
                        <button type="button" class="btn btn-primary-s" data-targetid="<%=targetid %>"" id="btnSubmit">确定</button>
                        <button type="button" class="btn btn-default-s" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!--end同意弹窗-->

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
        require(['jquery', 'mustache', 'common', 'state', 'lodash', 'bootstrap', 'picker', 'toast'], function ($, Mustache, cm, state, _) {

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

            /*延期原因*/
         <% if (page == 2)
        { %>
            //确认调整
            var copyHtml = $('.af').html();
            var regHtml = copyHtml.replace(/<input.*?type="text".*?data-type="(.*?)".*?value="(.*?)".*?>/ig, '<span data-type="$1">$2<span>');
            $('.af .bft').hide();
            $(document).on('click', '.action', function (e) {
                var $this = $(e.target);
                var $box = $('.af');
                //复制内容
                $('.sedit').hide();
                $('.af .bft').show();
                $('.bf').html(regHtml.replace('调整后', '调整前'));
                $box.find('.form-control').each(function () {
                    var $val = $(this).val().replace(/\s/ig, '');
                    var $name = $(this).data('type');
                    $(this).attr('disabled', true).addClass('disabled');
                    var $sName = $('.bf [data-type="' + $name + '"]').text().replace(/\s/ig, '');
                    if ($sName !== $val) {
                        $('.bf [data-type="' + $name + '"]').css('color', '#a6b1bd');
                    } else {
                        $(this).removeAttr('style');
                    }
                    $('body').removeClass('edit-body');

                })
                $('.action1').show();
                $('.action2').show();
                $('.action').hide();
                $('.reson').show();
                document.body.scrollTop = document.documentElement.scrollTop = 0;
            })
            //返回修改
            $(document).on('click', '.action2', function (e) {
                var $this = $(e.target);
                $('.sedit').show();
                $('.af .bft').hide();
                $('.bf').empty();
                $('.action').show();
                $('.action1').hide();
                $('.action2').hide();
                $('.reson').hide();
                $('.af').find('.form-control').removeAttr('style');
                document.body.scrollTop = document.documentElement.scrollTop = 0;
            })
            showPicker();
            //时间控件
            function showPicker() {
                $('.input-time').datetimepicker({
                    language: 'zh-CN',
                    weekStart: 1,
                    format: "yyyy-mm-dd",
                    todayBtn: 1,
                    autoclose: 1,
                    todayHighlight: 1,
                    startView: 2,
                    startDate: new Date(),
                    minView: 2,
                    forceParse: 0
                });
            }
            <% } %>
            /*延期原因*/

            /*调整原因*/
            <% if (page == 5)
        { %>
            var postData;
            //确认调整
            var copyHtml = $('.af').html();
            var regHtml = copyHtml.replace(/<input.*?type="text".*?data-type="(.*?)".*?value="(.*?)".*?>|<textarea.*?data-type="(.*?)".*?>(.*?)<\/textarea>/ig, '<span data-type="$1$3">$2$4<span>');
            $('.af .bft').hide();
            $(document).on('click', '.action', function (e) {
                var $this = $(e.target);
                var $box = $('.af');
                //复制内容
                $('.sedit').hide();
                $('.af .bft').show();
                $('.bf').html(regHtml.replace('调整后', '调整前'));
                console.log($box.find('input'))
                $box.find('.form-control').each(function () {
                    var $val = $(this).val().replace(/\s/ig, '');
                    var $name = $(this).data('type');
                    $(this).attr('disabled', true).addClass('disabled');
                    var $sName = $('.bf [data-type="' + $name + '"]').text().replace(/\s/ig, '');
                    //console.log($name,$sName)
                    console.log($sName)
                    if ($sName !== $val) {
                        $('.bf [data-type="' + $name + '"]').css('color', '#a6b1bd');
                    } else {
                        $(this).removeAttr('style');
                    }
                    $(this).css('height', '');
                    $('body').removeClass('edit-body');
                })

                $('.action1').show();
                $('.action2').show();
                $('.action').hide();
                $('.reson').show();
                document.body.scrollTop = document.documentElement.scrollTop = 0;
            })
            //返回修改
            $(document).on('click', '.action2', function (e) {
                var $this = $(e.target);
                $('.sedit').show();
                $('.af .bft').hide();
                $('.bf').empty();
                $('.action').show();
                $('.action1').hide();
                $('.action2').hide();
                $('.reson').hide();
                $('.af').find('.form-control').removeAttr('style');
                document.body.scrollTop = document.documentElement.scrollTop = 0;
            })
            //提交
            $(document).on('click', '.action1', function (e) {
                //console.log(state.page)
                var tData = state.page;
                var newData = _.map(tData, function (item, key) {
                    var company = [];
                    var companyIds = [];
                    var office = [];
                    var officeIds = [];
                    var employ = [];
                    var employIds = [];
                    _.map(item, function (v, k) {
                        if (v === undefined) {
                            item[k] = ''
                        }
                    })

                    var sc = _.map(item['company'], function (sc, k) {
                        if (parseInt(k, 10) === 0) return false
                        company.push(sc);
                        companyIds.push(k);

                        return {
                            company,
                            companyIds
                            }
                            })
                    var so = _.map(item['employ'], function (sc, k) {
                        employ.push(sc)
                        employIds.push(k)
                        return {
                            employ,
                            employIds
                            }
                            })
                    var so = _.map(item['office'], function (sc, k) {
                        office.push(sc)
                        officeIds.push(k)
                        return {
                            office,
                            officeIds
                            }
                            })
                    var jObj = { }
                    //年度目标
                    if (item.hasOwnProperty('TargetName')) {
                        jObj = _.assign({}, item, {
                            MainDeptId: companyIds.join(';'),
                            MainDeptName: company.join(';'),
                        })

                    }
                    //子措施|措施
                    if (item.hasOwnProperty('ParentTargetItemId')) {
                        jObj = _.assign({}, item, {
                            AssistDeptName: company.join(';'),
                            AssistDeptId: companyIds.join(';'),
                            DutyDeptId: officeIds.join(';'),
                            DutyDeptName: office.join(';'),
                            ExcutorId: employIds.join(';'),
                            ExcutorName: employ.join(';'),
                        })
                    }

                    <% if (!isParentTargetItem)
        { %>
                    jObj = _.assign({}, item, {
                        AssistDeptName: company.join(';'),
                        AssistDeptId: companyIds.join(';'),
                        DutyDeptId: officeIds.join(';'),
                        DutyDeptName: office.join(';'),
                        ExcutorId: employIds.join(';'),
                        ExcutorName: employ.join(';'),
                    })
                    <% } %>

                    delete jObj.company;
                    delete jObj.endTime;
                    delete jObj.office;
                    delete jObj.single;
                    delete jObj.text;
                    delete jObj.employ;
                    delete jObj.btnOpreaHistory;
                    return jObj
                });
                console.log(newData)
                postData = {

                    SmTargetEntity: newData[0],
                    SmTargetItemChangeEntitys: _.slice(newData, 1),
                    Reson: $('[name="Reason"]').val()
                }
            })
            //设置默认的值
            $('.af [data-index]').each(function (index) {
                var obj = {}
                $(this).find('[name]').each(function () {
                    var val = $(this).val();
                    var name = $(this).attr('name');
                    if (name !== 'company' && name !== 'office' && name !== 'employ') {
                        obj[name] = val;
                    }
                });
                var newObj = _.assign({}, {
                    single: false,
                }, obj)
                console.log(newObj)
                state.setIndex(newObj);
                state.setPage(index + 1);
                $(this).find('[data-obj]').each(function () {
                    var name = $(this).attr('name');
                    var k = $(this).data('key');
                    var v = $(this).data('val');
                    console.log(k, v)
                    state.stringToObject(name, k, v);
                });
            })
            console.log(state.page);
            //时间控件
            console.log(state.index, state.getPage())
            cm.showPicker();
            cm.initDept();
            cm.initDeptGroup();
            //协办单位
            $(document).on('click', '[name="company"]', function (e) {
                state.setSingle(false);
                state.setDeptType('company');
            });
            //责任处室
            $(document).on('click', '[name="office"]', function (e) {
                state.setSingle(true);
                state.setDeptType('office');
            });
            //修改文本内容
            /*
            $(document).on('change', '.form-control', function (e) {
                var $this = $(e.target);
                var name = $this.attr('name');
                state.setPage(1);
                var val = $this.val();
                if (name !== 'company' && name !== 'employ' && name !== 'office') {
                    state.setValue(name, val)
                }
            })
            */
            //确认部门
            $(document).on('click', '[data-btn="deptSure"]', function (e) {
                //$('[data-index="' + (state.getPage() + 1) + '"]').find('[name="' + state.dType + '"]').val(state.getDeptByName());
                var name = $('.bf [data-index="' + (state.getPage() + 1) + '"] [data-name="' + state.dType + '"]').text().trim()
                if (name !== state.getDeptByName()) {
                    $('[data-index="' + (state.getPage() + 1) + '"]').find('[name="' + state.dType + '"]').val(state.getDeptByName()).css({ color: '#f00' });
                } else {
                    $('[data-index="' + (state.getPage() + 1) + '"]').find('[name="' + state.dType + '"]').val(state.getDeptByName());
                }
                $('#company').modal('hide')
            });

            //责任搜索
            function searchMan(word) {
                return $.ajax({
                    type: "POST",
                    data: JSON.stringify({ UserId: word }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                });
            }

            //确认责任人
            $(document).on('click', '#btConfirmSelectAssLeader', function (e) {
                var person = state.getPerson(state.dType);
                $('[data-index="' + (state.getPage() + 1) + '"] [name="' + state.dType + '"]').val(person).attr('title', person)
                $('#leaderModal').modal('hide')
            })

            //责任人
            $(document).on('click', '[name="employ"]', function (e) {
                state.setSingle(true);
                state.setDeptType('employ');
            });

            //移开保存
            $(document).on('change', '.af .form-control', function (e) {
                var $this = $(e.target);
                var $index = $this.closest('[data-index]').data('index');
                var $name = $this.attr('name');
                var $val = $this.val();
                var $sName = $('.bf [data-name="' + $name + '"]').text().trim();
                state.setPage($index);
                if ($name && $name !== 'company' && $name !== 'office' && $name !== 'person' && $name !== 'employ' && $name !== 'leader') {
                    state.setValue($name, $val);
                }
            });

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
                        layer.msg(data.d.message, { icon: 2 });
                    }
                }).fail(function (err) {
                    layer.msg("请求发生异常。", { icon: 2 });
                })
            })

            <% } %>
            /*调整原因*/

            function noReason() {
                <% if (page == 2)
        { %>
                //延迟变更申请。
                var lateReason = $('[name="lateReason"]').val();
                if ($.trim(lateReason)==="") {
                    layer.msg("请输入延期原因。", { icon: 2 });
                    return true;
                }
                <% }
        else if (page == 3)
        { %>
                //中止变更申请。
                var stopReason = $('#stopReason').val();
                if ($.trim(stopReason) === "") {
                    layer.msg("请输入中止原因。", { icon: 2 });
                    return true;
                }
                <% }
        else if (page == 4)
        { %>
                //办结变更申请。
                var bjReason = $('#bjReason').val();
                if ($.trim(bjReason) === "") {
                    layer.msg("请输入办结原因。", { icon: 2 });
                    return true;
                }
                <% }
        else
        { %>
                var reason = $('[name="Reason"]').val();
                if ($.trim(reason) === "") {
                    layer.msg("请输入调整原因。", { icon: 2 });
                    return true;
                }
                <% } %>
            }


            //进度反馈模态框打开事件
            $('#agreeModal').on('show.bs.modal', function (e) {
                if (noReason()) {
                    return false;
                }

                var smId = getQueryString("smid");
                var parentTargetItemId = getQueryString("parentTargetItemId");
                var smType = getQueryString("smtype");
                var stepId = "CSZYLNG";
                    <% if (!isParentTargetItem)
        { %>
                stepId = "ZCSZYLNG";
                    <% } %>
                //将年度目标ID赋值给模态框的确定按钮相应的属性
                var TargetId = getQueryString("targetid");
                $('#btnSubmit').attr('data-targetId', TargetId);

                //绑定下一步骤列表信息(目前只会请求一次)
                var stepListObj = $('#stepList').children();
                if (stepListObj.length === 0) {
                    var jsonData = { stepid: stepId, smType: smType, subType: '<%=subtype%>' }//这里需要输入文件类型 去获取步骤
                    $.ajax({
                        type: "POST",
                        data: JSON.stringify(jsonData),
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetNextStepFreeList",
                        contentType: 'application/json;charset=utf-8',
                        dataType: "json",
                        success: function (data) {
                            if (data.d.status == "1") {
                                if (data.d.data !== '' && data.d.data !== null) {
                                    var stepList = JSON.parse(data.d.data);
                                    //循环遍历输出步骤信息
                                    $('#stepList').html('');
                                    var html = '';      //步骤html
                                    var htmlForUser = '';//处理人html
                                    var tabid = '';     //选中的步骤tabid
                                    var stepid = '';    //选中的步骤ID
                                    $.each(stepList,
                                        function (index, obj) {

                                            if (index === 0) {
                                                //设置第一个步骤为默认选中状态
                                                html += '<li role="presentation" class="active"><a href="#tab' +
                                                    index +
                                                    '" aria-controls="home" role="tab" data-toggle="tab" data-tabid="tab' + index + '" data-stepid="' +
                                                    obj.NextStepId +
                                                    '" data-stepname="' +
                                                    obj.NextStepName +
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
                                                    '" data-stepname="' +
                                                    obj.NextStepName +
                                                    '">' +
                                                    obj.NextStepName +
                                                    '</a></li>';

                                                htmlForUser += '<div role="tabpanel" class="tab-pane" id="tab' + index + '"></div>';
                                            }
                                        });
                                    $('#stepList').append(html);//绑定步骤
                                    $('#stepUserList').append(htmlForUser);//添加处理人信息呈现所在的div
                                    if (stepid !== '' && stepid !== 'SBBGT' && stepid !== 'ZBDWMS') {
                                        //加载默认选中步骤的处理人信息
                                        BindStepUserList(tabid, stepid);

                                    }
                                }
                            } else {
                                layer.msg(data.d.message, { icon: 2 });
                            }
                        },
                        error: function (xhr, textStatus) {
                            layer.msg("请求发生异常。", { icon: 2 });
                        }
                    });
                }
            })

            //修改
            $(document).on('click', '.sedit', function (e) {
                var $this = $(e.target);
                $('.af .disabled[disabled="disabled"]').removeClass('disabled').removeAttr('disabled');
                $('body').addClass('edit-body');
                $('.edit-body .af .form-control').parents('.detail-col').addClass('modify');

            })

            //监听步骤点击事件
            $(document).on('show.bs.tab', function (e) {
                var $this = $(e.target);
                var stepid = $this.data('stepid');
                var tabid = $this.data('tabid');
                if (stepid && tabid) {
                    BindStepUserList(tabid, stepid);
                }
            })
            //加载步骤对应的处理人信息(只请求一次)
            function BindStepUserList(tabId, stepId) {
                var smId = getQueryString("smid");
                var flowid = getQueryString("flowid");
                var targetId = $('#btnSubmit').data('targetid');
                var $userDiv = $('#' + tabId).children();
                if ($userDiv.length === 0) {
                    var jsonData = { smId: smId, flowid: "1", stepId: stepId, targetId: targetId }
                    $.ajax({
                        type: "POST",
                        data: JSON.stringify(jsonData),
                        url: "WebServices/SuperviseMissionWebServices.asmx/BGGetUserListByStepFree",
                        contentType: 'application/json;charset=utf-8',
                        dataType: "json",
                        success: function (data) {
                            if (data.d.status == "1") {
                                if (data.d.data !== '' && data.d.data !== null) {
                                    var stepUserList = JSON.parse(data.d.data);
                                    console.log(stepUserList);
                                    var html = '';
                                    $.each(stepUserList,
                                        function (index, obj) {
                                            html += '<div class="radio"><label><input type="radio" name="nextStepUser" data-membername="' + obj.MemberName + '" value="' + obj.MemberId + '" data-roletype="' + obj.RoleType + '" />' + obj.MemberName + '</label></div>';
                                        });
                                    $('#' + tabId).append(html);
                                }
                            } else {
                                layer.msg(data.d.message, { icon: 2 });
                            }
                        },
                        error: function (xhr, textStatus) {
                            layer.msg("请求发生异常。", { icon: 2 });
                        }
                    });
                }
            }

            $("#btnSubmit").on('click', function () {

                    <% if (page == 2)
        { %>
                //提交延迟变更申请。
                sendLateMessage();
                    <% }
        else if (page == 3)
        { %>
                //提交中止变更申请。
                sendStopMessage();
                    <% }
        else if (page == 4)
        { %>
                //提交办结变更申请。
                sendBJMessage();
                <% }
        else
        { %>
                sendAdjustmentMessage();
                <% } %>
            });

            //发送调整申请
            function sendAdjustmentMessage() {
                var reason = postData.Reson;
                var stepid = $('#stepList .active [data-stepid]').data('stepid');
                var stepName = $('#stepList .active [data-stepid]').data('stepname');
                var userId = '';
                var userName = '';
                var deptId = '';
                var deptName = '';

                if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                    userId = $('.tab-pane.active input:checked').val();
                    userName = $('.tab-pane.active input:checked').data("membername");
                }

                if ($('.tab-pane.active input:checked').data("roletype") == "2") {

                    deptId = $('.tab-pane.active input:checked').val();
                    deptName = $('.tab-pane.active input:checked').data("membername");
                }
                var jsonData = {
                    deptId: deptId, deptName: deptName, userId: userId, userName: userName, stepId: stepid, stepName: stepName, reason: reason, smTargetItemChangeEntitys: postData.SmTargetItemChangeEntitys
                };


                <% if (!isParentTargetItem)
        { %>
                var smTargetEntity = {};
                jsonData = {
                    deptId: deptId, deptName: deptName, userId: userId, userName: userName, stepId: stepid, stepName: stepName, reason: reason, smTargetItemChangeEntitys: [postData.SmTargetEntity]
                };
                <% } %>

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/SendAdjustmentMessage",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                                window.close();
                            });
                            //关闭窗口
                        } else {
                            layer.msg(data.d.message, { icon: 2 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                    }
                });
            }
            //关闭当前页
            function closeWindow() {
                window.close();
            }
            //发送延迟申请
            function sendLateMessage() {
                var itemId = getQueryString("itemid");
                var targetId = getQueryString("targetid");
                var parentTargetItemId = getQueryString("parentTargetItemId");
                var lateTime = $('[name="lateTime"]').val();
                var lateReason = $('[name="lateReason"]').val();
                if (lateTime === "") {
                    layer.msg("请输入申请延期时限。", { icon: 2 });
                    return false;
                } else if (lateReason === "") {
                    layer.msg("请输入延期原因。", { icon: 2 });
                    return false;
                }

                var stepid = $('#stepList .active [data-stepid]').data('stepid');
                var stepName = $('#stepList .active [data-stepid]').data('stepname');
                var userId = '';
                var userName = '';
                var deptId = '';
                var deptName = '';

                if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                    userId = $('.tab-pane.active input:checked').val();
                    userName = $('.tab-pane.active input:checked').data("membername");
                }

                if ($('.tab-pane.active input:checked').data("roletype") == "2") {

                    deptId = $('.tab-pane.active input:checked').val();
                    deptName = $('.tab-pane.active input:checked').data("membername");
                }

                var jsonData = { itemId: itemId, parentTargetItemId: parentTargetItemId, lateTime: lateTime, lateReason: lateReason, deptId: deptId, deptName: deptName, userId: userId, userName: userName, stepId: stepid, stepName: stepName, targetItemLateRequestEntitys: [] }

                var $targetItemLateTime = $("[name='targetItemLateTime']");
                if ($targetItemLateTime && $targetItemLateTime.length > 0) {
                    for (var i = 0; i < $targetItemLateTime.length; i++) {
                        var ItemId = $($targetItemLateTime[i]).data().targetid;
                        var LateTime = $($targetItemLateTime[i]).val();
                        var TargetItemLateRequestEntitys = { ItemId: ItemId, LateTime: LateTime };
                        jsonData.targetItemLateRequestEntitys.push(TargetItemLateRequestEntitys);
                    }
                }
                 
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/SendLateMessage",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
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
            }

            //发送中止申请
            function sendStopMessage() {
                var itemId = getQueryString("itemid");
                var targetId = getQueryString("targetid");
                var parentTargetItemId = getQueryString("parentTargetItemId");
                var stopReason = $('#stopReason').val();
                if (stopReason === "") {
                    layer.msg("请输入中止原因。", { icon: 2 });
                    return false;
                }

                var stepid = $('#stepList .active [data-stepid]').data('stepid');
                var stepName = $('#stepList .active [data-stepid]').data('stepname');
                var userId = '';
                var userName = '';
                var deptId = '';
                var deptName = '';

                if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                    userId = $('.tab-pane.active input:checked').val();
                    userName = $('.tab-pane.active input:checked').data("membername");
                }

                if ($('.tab-pane.active input:checked').data("roletype") == "2") {

                    deptId = $('.tab-pane.active input:checked').val();
                    deptName = $('.tab-pane.active input:checked').data("membername");
                }

                var jsonData = { itemId: itemId, parentTargetItemId: parentTargetItemId, stopReason: stopReason, deptId: deptId, deptName: deptName, userId: userId, userName: userName, stepId: stepid, stepName: stepName }
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/SendStopMessage",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
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
            }

            //发送办结申请
            function sendBJMessage() {
                var itemId = getQueryString("itemid");
                var targetId = getQueryString("targetid");
                var parentTargetItemId = getQueryString("parentTargetItemId");
                var stopReason = $('#bjReason').val();
                if (stopReason === "") {
                    layer.msg("请输入办结原因。", { icon: 2 });
                    return false;
                }

                var stepid = $('#stepList .active [data-stepid]').data('stepid');
                var stepName = $('#stepList .active [data-stepid]').data('stepname');
                var userId = '';
                var userName = '';
                var deptId = '';
                var deptName = '';

                if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                    userId = $('.tab-pane.active input:checked').val();
                    userName = $('.tab-pane.active input:checked').data("membername");
                }

                if ($('.tab-pane.active input:checked').data("roletype") == "2") {

                    deptId = $('.tab-pane.active input:checked').val();
                    deptName = $('.tab-pane.active input:checked').data("membername");
                }

                var jsonData = { itemId: itemId, parentTargetItemId: parentTargetItemId, bjReason: stopReason, deptId: deptId, deptName: deptName, userId: userId, userName: userName, stepId: stepid, stepName: stepName }
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/SendBJMessage",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
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
            }

            function getQueryString(name) {
                var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                }
                return null;
            };

        });
        window.onunload = function () {
            location.href.toLowerCase().indexOf('itemid') > -1 ? window.opener.document.getElementById('pending').click() : window.opener.document.getElementById('task').click()

        };
    </script>
</body>
</html>
