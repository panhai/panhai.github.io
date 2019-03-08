<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionDelayModifyEndChangeAudit.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionDelayModifyEndDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>年度变更审核</title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <style type="text/css">
        .detail-box .detail-part {
            padding-bottom: 5px;
        }

            .detail-box .detail-part:last-child {
                padding-bottom: 20px;
            }

        .af + .card.card-box {
            padding-bottom: 0;
        }

            .af + .card.card-box h3 {
                margin-top: 10px;
                padding: 0;
            }

        .detail-box .detail-part-sub2 {
            padding-left: 25px;
        }

        .form-group {
            font-size: 12px;
        }

        .card.card-box .form-group {
            margin-bottom: 0;
        }

        .card {
            margin-bottom: 10px;
        }

        .card-box + .card .card-header .form-group {
            padding-top: 10px;
        }

        textarea {
            resize: none;
        }

        .bf .bft, .af .bft {
            margin-top: -10px;
        }

        .st > span:nth-child(2) {
            color: #959fab;
        }

        .modal-form .b .l ul {
            overflow: visible;
        }

        .modal-form .b .l > p {
            margin: 0 0 4px 10px;
            line-height: 22px;
        }
    </style>
</head>
<body>
    <div class="main main2">
        <div class="card">
            <div class="card-header card-header-line">
                <% if (page == 2)
                    { %>
                <h3 class="title">延期申请<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <% if (page == 3)
                    { %>
                <h3 class="title">中止申请<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <% if (page == 4)
                    { %>
                <h3 class="title">办结申请<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <% if (page == 5)
                    { %>
                <h3 class="title">调整申请<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <span class="iconfont-title">变更文档ID：<%=changeId %></span>
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


        <% 
            if (page == 2 && isParentTargetItem)
            {
        %>
        <%-- 延期，措施 --%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span data-name="deadlinetime"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <asp:Repeater ID="Repeater1_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span data-name="deadlinetime<%#Container.ItemIndex + 1%>"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="af">
            <asp:Repeater ID="Repeater2" runat="server" OnItemDataBound="Repeater2_ItemDataBound">
                <ItemTemplate>
                    <div class="bft">调整后</div>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>

                        <asp:Repeater ID="Repeater2_1" runat="server" OnItemDataBound="Repeater2_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                    <p><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span data-name="deadlinetime"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>

                                <asp:Repeater ID="Repeater2_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span data-name="deadlinetime<%#Container.ItemIndex + 1%>"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="card card-box">
            <div class="card-header">
                <h3 class="c-primary">延期原因
                </h3>
                <div class="form-group">
                    <%=EncodeSpecialCode(reason)%>
                </div>
            </div>
        </div>

        <% } %>


        <% 
            if (page == 2 && !isParentTargetItem)
            {
        %>
        <%-- 延期，子措施 --%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater3_1" runat="server" OnItemDataBound="Repeater3_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <asp:Repeater ID="Repeater3_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span data-name="deadlinetime"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="af">
            <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="bft">调整后</div>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>

                        <asp:Repeater ID="Repeater3_1" runat="server" OnItemDataBound="Repeater4_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>

                                <asp:Repeater ID="Repeater4_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span data-name="deadlinetime"><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="card card-box">
            <div class="card-header">
                <h3 class="c-primary">延期原因
                </h3>
                <div class="form-group">
                    <%=reason%>
                </div>
            </div>
        </div>

        <% } %>


        <% 
            if (page == 3 && isParentTargetItem)
            {
        %>

        <%-- 中止，措施 --%>
        <asp:Repeater ID="Repeater5" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
            <ItemTemplate>
                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName") %></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                        <span>责任处室</span>
                                        <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process"><%#Eval("FinshPercent") %>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>
                            <asp:Repeater ID="Repeater1_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
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
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="card card-box">
                    <div class="card-header">
                        <h3 class="c-primary">中止原因
                        </h3>
                        <div class="form-group">
                            <%=reason %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>


        <% 
            if (page == 3 && !isParentTargetItem)
            {
        %>

        <%-- 中止，子措施 --%>
        <asp:Repeater ID="Repeater6" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
            <ItemTemplate>
                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName") %></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                            </div>
                        </div>
                    </div>

                    <asp:Repeater ID="Repeater3_1" runat="server" OnItemDataBound="Repeater3_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                        <span>责任处室</span>
                                        <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process"><%#Eval("FinshPercent") %>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>

                            <asp:Repeater ID="Repeater3_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
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
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="card card-box">
                    <div class="card-header">
                        <h3 class="c-primary">中止原因
                        </h3>
                        <div class="form-group">
                            <%=reason %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>


        <% 
            if (page == 4 && isParentTargetItem)
            {
        %>

        <%-- 办结，措施 --%>
        <asp:Repeater ID="Repeater7" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
            <ItemTemplate>
                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName") %></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                        <span>责任处室</span>
                                        <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process"><%#Eval("FinshPercent") %>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>
                            <asp:Repeater ID="Repeater1_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
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
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="card card-box">
                    <div class="card-header">
                        <h3 class="c-primary">办结原因
                        </h3>
                        <div class="form-group">
                            <%=reason %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>


        <% 
            if (page == 4 && !isParentTargetItem)
            {
        %>

        <%-- 办结，子措施 --%>
        <asp:Repeater ID="Repeater8" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
            <ItemTemplate>
                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName") %></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                            </div>
                        </div>
                    </div>

                    <asp:Repeater ID="Repeater3_1" runat="server" OnItemDataBound="Repeater3_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                        <span>责任处室</span>
                                        <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process"><%#Eval("FinshPercent") %>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>

                            <asp:Repeater ID="Repeater3_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
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
                                                <span class="process"><%#Eval("FinshPercent") %>%</span>
                                            </div>
                                        </div>
                                        <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="card card-box">
                    <div class="card-header">
                        <h3 class="c-primary">办结原因
                        </h3>
                        <div class="form-group">
                            <%=reason %>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>

        <% 
            if (page == 5 && isParentTargetItem)
            {
        %>

        <%-- 调整，措施 --%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater9" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p data-name="targetname"><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span data-name="maindeptname" title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                    <p data-name="itemname"><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span data-name="assistdeptname" title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span data-name="dutydeptname" title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <asp:Repeater ID="Repeater1_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p data-name="itemname<%#Container.ItemIndex + 1%>"><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span data-name="assistdeptname<%#Container.ItemIndex + 1%>" title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span data-name="excutorname<%#Container.ItemIndex + 1%>" title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="af">
            <asp:Repeater ID="Repeater10" runat="server" OnItemDataBound="Repeater10_ItemDataBound">
                <ItemTemplate>
                    <div class="bft">调整后</div>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p data-name="targetname"><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span data-name="maindeptname" title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>

                        <asp:Repeater ID="Repeater10_1" runat="server" OnItemDataBound="Repeater10_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                    <p data-name="itemname"><%#Eval("ItemName") %></p>
                                    <div class="detail-col detail-col-2">
                                        <div class="col">
                                            <span>协办单位</span>
                                            <span data-name="assistdeptname" title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                        </div>
                                        <div class="col">
                                            <span>完成时间</span>
                                            <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                        </div>
                                        <div class="col">
                                            <span>责任处室</span>
                                            <span data-name="dutydeptname" title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>

                                <asp:Repeater ID="Repeater10_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p data-name="itemname<%#Container.ItemIndex + 1%>"><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span data-name="assistdeptname<%#Container.ItemIndex + 1%>" title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span data-name="excutorname<%#Container.ItemIndex + 1%>" title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="card card-box">
            <div class="card-header">
                <h3 class="c-primary">调整原因
                </h3>
                <div class="form-group">
                    <%=reason %>
                </div>
            </div>
        </div>

        <% } %>


        <% 
            if (page == 5 && !isParentTargetItem)
            {
        %>

        <%-- 调整，子措施 --%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater11" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater3_1" runat="server" OnItemDataBound="Repeater3_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>
                                <asp:Repeater ID="Repeater3_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p data-name="itemname"><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span data-name="assistdeptname" title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span data-name="excutorname" title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="af">
            <asp:Repeater ID="Repeater12" runat="server" OnItemDataBound="Repeater3_ItemDataBound">
                <ItemTemplate>
                    <div class="bft">调整后</div>
                    <div class="detail-box">
                        <div class="detail-part detail-line">
                            <h3 class="c">年度目标</h3>
                            <p><%#Eval("TargetName") %></p>
                            <div class="detail-col">
                                <div class="col">
                                    <span>主办单位</span>
                                    <span title="<%#Eval("MainDeptName") %>"><%#Eval("MainDeptName") %></span>
                                </div>
                            </div>
                        </div>

                        <asp:Repeater ID="Repeater3_1" runat="server" OnItemDataBound="Repeater12_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr">
                                    <h3 class="st"><span class="line line-primary"></span>措施</h3>
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
                                            <span>责任处室</span>
                                            <span title="<%#Eval("DutyDeptName") %>"><%#Eval("DutyDeptName") %></span>
                                        </div>
                                    </div>
                                    <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                                </div>

                                <asp:Repeater ID="Repeater12_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr">
                                            <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                            <p data-name="itemname"><%#Eval("ItemName") %></p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col">
                                                    <span>协办单位</span>
                                                    <span data-name="assistdeptname" title="<%#Eval("AssistDeptName") %>"><%#Eval("AssistDeptName") %></span>
                                                </div>
                                                <div class="col">
                                                    <span>完成时间</span>
                                                    <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                                </div>
                                                <div class="col">
                                                    <span>责任人</span>
                                                    <span data-name="excutorname" title="<%#Eval("ExcutorName") %>"><%#Eval("ExcutorName") %></span>
                                                </div>
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
        </div>
        <div class="card card-box">
            <div class="card-header">
                <h3 class="c-primary">调整原因
                </h3>
                <div class="form-group">
                    <%=reason%>
                </div>
            </div>
        </div>

        <% } %>
        <div class="card">
            <div class="card-header">
                <div class="opinion-type"></div>
                <div class="form-group">
                    <label class="font-lg">审批意见</label>
                    <textarea class="form-control thx" id="opinion15"></textarea>
                </div>
            </div>
        </div>
        <div class="tar">
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#feedback" data-targetid="<%=targetid %>" data-targetitemid="<%=itemid %>">反馈记录</button>
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%=targetid %>" data-targetitemid="<%=itemid %>">操作记录</button>
        </div>
        <div class="form-group tac">
            <button type="button" class="btn btn-primary-s" data-toggle="modal" data-target="#agreeModal" id="btnSubmit">同意</button>
            <% if (stepid != "ZCSZYLNG" && stepid != "CSZYLNG")
                { %>
            <button type="button" class="btn btn-default-s" data-dismiss="modal" id="disagree">不同意</button>
            <% } %>
        </div>

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
                        <input type="hidden" id="flowDeptIdAndSmId15" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end同意弹窗-->

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
        require(['jquery', 'bootstrap', 'toast', 'cs-opinion'], function ($) {
            //修改过的记录加红色
            $('.bf [data-name]').each(function () {
                var name = $(this).data('name');
                var text = $(this).text().trim();
                var $name = $('.af [data-name="' + name + '"]');
                var $text = $name.text().trim();
                if (text !== $text) {
                    $(this).css('color', '#a6b1bd');
                }
            })
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
                            layer.msg(data.d.message, { icon: 2 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                    },
                    cache: false
                });
            });

            //检查是否选择审批意见类型
            function CheckOpinionTypeIsSelected() {
                var selectValue = $('select[name="opinion"]').val();
                if (selectValue === '0' || selectValue === '' || selectValue === undefined) {
                    layer.msg('请先选择意见类型', { icon: 7, time: 2000 });
                    return false;
                }
                return true;
            }

            $('#agreeModal').on('show.bs.modal', function () {
                //验证是否选择了意见类型
                if (!CheckOpinionTypeIsSelected()) {
                    return false;
                }
            });

            // 部门审核/审批。
            // 【同意】。
            $(document).on('click', '[data-target="#agreeModal"]', function (e) {
                // 每次打开同意模态框要把原先的旧值清空。
                $("#stepItem15").children('li').remove();
                $("#userItem15").children('div').remove();

                var smid = getQueryString("smid");
                var flowid = getQueryString("flowid");
                var data15 = { smId: smid, flowId: flowid };
                var flowDeptId = '';

                // 获取流程部门Id。
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(data15),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetFlowDeptId",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status != "1") {
                            layer.msg(data.d.message, { icon: 2 });
                        } else {
                            flowDeptId = data.d.data;
                            $('#flowDeptIdAndSmId15').val(smid + '-' + flowDeptId);
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                    }
                });

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(data15),
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
                var stepid = $('#stepItem15 .active [data-stepid]').data('stepid');
                var stepName = $('#stepItem15 .active [data-stepid]').data('stepname');
                var userId = '';
                var userName = '';
                var deptId = '';
                var deptName = '';
                var opinionType = $('select[name="opinion"]').val();

                if ($('.tab-pane.active input:checked').data("roletype") == "1") {
                    userId = $('.tab-pane.active input:checked').val();
                    userName = $('.tab-pane.active input:checked').data("membername");
                }

                if ($('.tab-pane.active input:checked').data("roletype") == "2") {
                    deptId = $('.tab-pane.active input:checked').val();
                    deptName = $('.tab-pane.active input:checked').data("membername");
                }

                if (stepid == undefined) {
                    layer.msg("请选择下一步骤。", { icon: 2 });
                    return;
                }

                if ((userId == '' && deptId == '') && (stepid != 'JS')) {
                    layer.msg('请选择下一步骤的用户或部门。', { icon: 2 });
                    return;
                }

                var op = $('#opinion15').val();
                var flowid = getQueryString("flowid");
                var smid = getQueryString("smid");
                // 校验数据的合法性。
                // 。。。。。。

                /*console.log({ smId: smid, itemId: '', flowId: flowid, stepId: stepid, stepName: stepName, flowDeptId: deptId, userId: userId, opinion: op });
                return;*/
                $(this).attr("disabled", true);
                $.ajax({
                    type: "POST",
                    data: JSON.stringify({ smId: smid, flowId: flowid, stepId: stepid, stepName: stepName, flowDeptId: deptId, deptName: deptName, userName: userName, userId: userId, opinion: op, opinionType: opinionType }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/SendChangeAudit",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status != "1") {
                            layer.msg(data.d.message, { icon: 2 });
                            $(this).attr("disabled", false);
                        } else {
                            layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                                window.close();
                            });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                        $(this).attr("disabled", false);
                    }
                });
            });

            var OPINION_MAX_LENGTH = 400;         // 反馈字符数最大限长量。
            // 【不同意】。
            $(document).on('click', '#disagree', function (e) {
                if (!CheckOpinionTypeIsSelected()) {
                    return false;
                }
                var opinionType = $('select[name="opinion"]').val();
                var opinion = jQuery.trim($('#opinion15').val());
                var flowId = getQueryString("flowid");
                var smId = getQueryString("smid");
                // 校验数据的合法性。
                // 。。。。。。
                if (opinion == '' || opinion == undefined) opinion = '不同意';
                if (opinion.length > OPINION_MAX_LENGTH) {
                    layer.msg("审核意见的字符数不能大于" + OPINION_MAX_LENGTH + "个字符。", { icon: 2, time: 1500 });
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

                $(this).attr("disabled", true);

                $.ajax({
                    type: "POST",
                    data: JSON.stringify(data),
                    url: "WebServices/SuperviseMissionWebServices.asmx/DisagreeSendPage15",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status != "1") {
                            layer.msg("发送失败。", { icon: 2 });
                            $(this).attr("disabled", false);
                        } else {
                            layer.msg("发送成功。", { icon: 1, time: 1500 }, function () {
                                window.close();
                            });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                        $(this).attr("disabled", false);
                    }
                });
            });

            // 单击步骤列表项时触发。
            $(document).delegate('[data-toggle="tab"]', 'click', function (e) {
                // 追加用户节点时要先清空旧数据。
                $("#userItem15").children('div').remove();
                //console.log(e.target);
                var tabno = $(e.target).data('tabno');// 获取当前选中步骤项对应的tab编号(如:tab1)。
                var smid = $('#flowDeptIdAndSmId15').val().split('-')[0];
                var flowdeptid = $('#flowDeptIdAndSmId15').val().split('-')[1];
                var flowid = getQueryString("flowid");
                var stepid = $(e.target).data('stepid');

                if (stepid == "JS") {
                    // FKJS或JS不存在用户或部门。
                    return;
                }

                // 获取当前选中的步骤对应的用户并绑定到右侧的用户列表框。
                $.ajax({
                    type: "POST",
                    data: JSON.stringify({ deptId: flowdeptid, stepId: stepid, smId: smid, targetId: '', itemId: '', flowId: flowid }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetBGUserListByStep  ",
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
                                    var $selectUserItem = '<div class="radio"><label><input type="radio"  data-membername="' + userObj[i]["MemberName"] + '" name="name" value="' + userObj[i]["MemberId"] + '" data-roletype="' + userObj[i].RoleType + '"/>' + userObj[i]["MemberName"] + '(' + userObj[i]["MemberId"] + ')</label></div>';
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

            function getQueryString(name) {
                var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                }
                return null;
            };
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
                        alert("请求发生异常");
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

            window.onunload = function () {
                location.href.toLowerCase().indexOf('flowid') > -1 ? window.opener.document.getElementById('pending').click() : window.opener.document.getElementById('task').click()

            };
        });
    </script>
</body>
</html>
