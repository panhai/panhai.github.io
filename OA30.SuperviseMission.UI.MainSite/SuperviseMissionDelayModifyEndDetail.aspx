<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionDelayModifyEndDetail.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionDelayModifyEndDetail1" %>

<!DOCTYPE html>
<% int page = this.page; %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>年度变更详情</title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <style>
        .buttons {
            margin-bottom: 20px;
        }

        .bft {
            background: #f5f5f5;
            padding: 5px 0px;
            margin-top: -15px;
        }

        .detail-box .detail-part title {
            font-size: 14px;
        }

        .bf .detail-box .detail-part-sub, .af .detail-box .detail-part-sub {
            padding-bottom: 5px;
        }

        .buttons button {
            background: #15497d;
            color: #fff;
            border-radius: 5px;
            margin-right: 10px;
        }

        .main .card-box {
            padding-bottom: 0;
        }

        .detail-line {
            border-bottom: 1px dashed #e5e5e5;
        }

        .st span:nth-child(2) {
            color: #959fab;
        }
    </style>
</head>
<body>
    <div class="main main2">
        <div class="tal buttons" style="display: block; height: 28px">
            <button class="btn btn-primary-s" type="button" id="rollBackPage1">撤回</button>
        </div>
        <div class="card">
            <div class="card-header card-header-line">
                <% if (page == 2)
                    { %>
                <h3 class="title">延期详情<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <% if (page == 3)
                    { %>
                <h3 class="title">中止详情<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <% if (page == 4)
                    { %>
                <h3 class="title">办结详情<span class="iconfont icon-sv-del"></span> </h3>
                <% } %>
                <% if (page == 5)
                    { %>
                <h3 class="title">调整详情<span class="iconfont icon-sv-del"></span> </h3>
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
                                    <asp:Label ID="LbMainLeader" runat="server" Text=""></asp:Label>
                                </span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">协管领导：</label>
                                <span class="dib">
                                    <asp:Label ID="LbAssLeader" runat="server" Text=""></asp:Label>
                                </span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">主办单位：</label>
                                <span class="dib">
                                    <asp:Label ID="LbMainDept" runat="server" Text=""></asp:Label>
                                </span>
                            </div>
                        </li>
                        <li>
                            <div class="row">
                                <label class="dib">协办单位：</label>
                                <span class="dib">
                                    <asp:Label ID="LbAssDept" runat="server" Text=""></asp:Label>
                                </span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <% if (page == 2 && isParentTargetItem && IsJS)
            { %>

        <%--延期变更结束措施页面--%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater11" runat="server" OnItemDataBound="Repeater11_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px">
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
                        <div class="detail-part detail-part-sub pr detail-line">
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
                        <asp:Repeater ID="Repeater11_1" runat="server">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub2 pr detail-line">
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
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <% if (IsHistory)
            { %>
        <div class="af">
            <div class="bft">调整后</div>
            <asp:Repeater ID="Repeater12" runat="server" OnItemDataBound="Repeater11_ItemDataBound">
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
                        <div class="detail-part detail-part-sub pr detail-line">
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

                        <asp:Repeater ID="Repeater11_1" runat="server">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub2 pr detail-line">
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
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <% }
            else
            { %>
        <div class="af">
            <asp:Repeater ID="Repeater13" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
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

                        <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% } %>

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


        <% if (page == 2 && isParentTargetItem && !IsJS)
            { %>


        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px">
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
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
                    <%=reason%>
                </div>
            </div>
        </div>

        <% } %>


        <% if (page == 2 && !isParentTargetItem && !IsJS)
            { %>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater15" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px;">
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
                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                <asp:Repeater ID="Repeater15_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
            <asp:Repeater ID="Repeater16" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
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

                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater16_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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

                                <asp:Repeater ID="Repeater16_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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


        <% if (page == 2 && !isParentTargetItem && IsJS)
            { %>
        <%--延期变更结束子措施页面--%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater17" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px;">
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
                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater17_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                <asp:Repeater ID="Repeater17_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% if (IsHistory)
            { %>
        <div class="af">
            <asp:Repeater ID="Repeater18" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
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
                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater18_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                <asp:Repeater ID="Repeater18_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% }
            else
            { %>
        <div class="af">
            <asp:Repeater ID="Repeater14" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
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
                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                <asp:Repeater ID="Repeater15_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% } %>

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


        <% if (page == 3 && isParentTargetItem)
            { %>

        <asp:Repeater ID="Repeater3" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
            <ItemTemplate>
                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName")%></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr detail-line">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                <p><%#Eval("ItemName")%></p>
                                <div class="detail-col detail-col-2">
                                    <div class="col">
                                        <span>协办单位</span>
                                        <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
                                    </div>
                                    <div class="col">
                                        <span>完成时间</span>
                                        <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                    </div>
                                    <div class="col">
                                        <span>责任处室</span>
                                        <span title="<%#Eval("DutyDeptName")%>"><%#Eval("DutyDeptName")%></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process"><%#Eval("FinshPercent")%>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>


                            <asp:Repeater ID="Repeater1_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr detail-line">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                        <p><%#Eval("ItemName")%></p>
                                        <div class="detail-col detail-col-2">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
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
                            <%#reason%>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>


        <% if (page == 3 && !isParentTargetItem)
            { %>


        <asp:Repeater ID="Repeater4" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
            <ItemTemplate>


                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName")%></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="主办单位"><%#Eval("MainDeptName")%></span>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr detail-line">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                <p>措施<%#Eval("ItemName")%></p>
                                <div class="detail-col detail-col-2">
                                    <div class="col">
                                        <span>协办单位</span>
                                        <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
                                    </div>
                                    <div class="col">
                                        <span>完成时间</span>
                                        <span><%#FormatDateTime(Convert.ToString(Eval("DeadLineTime"))) %></span>
                                    </div>
                                    <div class="col">
                                        <span>责任处室</span>
                                        <span title="<%#Eval("DutyDeptName")%>"><%#Eval("DutyDeptName")%></span>
                                    </div>
                                    <div class="col">
                                        <span>完成进度</span>
                                        <span class="process"><%#Eval("FinshPercent")%>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>



                            <asp:Repeater ID="Repeater15_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr detail-line">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                        <p><%#Eval("ItemName")%></p>
                                        <div class="detail-col detail-col-2">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
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
                            <%#reason%>
                        </div>
                    </div>
                </div>

                <div class="tar">
                    <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%=targetid %>" data-targetitemid="<%=itemid %>">
                    </button>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>

        <% if (page == 4 && isParentTargetItem)
            { %>


        <asp:Repeater ID="Repeater5" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
            <ItemTemplate>
                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName")%></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="<%#Eval("MainDeptName")%>"><%#Eval("MainDeptName")%></span>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater3_1_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr detail-line">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                <p>措施<%#Eval("ItemName")%></p>
                                <div class="detail-col detail-col-2">
                                    <div class="col">
                                        <span>协办单位</span>
                                        <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
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
                                        <span class="process"><%#Eval("FinshPercent")%>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>


                            <asp:Repeater ID="Repeater3_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr detail-line">
                                        <h3 class="st"><span class="line line-success"></span><%#Eval("ItemName")%></h3>
                                        <p><%#Eval("ItemName")%></p>
                                        <div class="detail-col detail-col-2">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
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
                            <%#reason%>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>


        <% } %>

        <% if (page == 4 && !isParentTargetItem)
            { %>

        <asp:Repeater ID="Repeater6" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
            <ItemTemplate>


                <div class="detail-box">
                    <div class="detail-part detail-line">
                        <h3 class="c">年度目标</h3>
                        <p><%#Eval("TargetName")%></p>
                        <div class="detail-col">
                            <div class="col">
                                <span>主办单位</span>
                                <span title="主办单位"><%#Eval("MainDeptName")%></span>
                            </div>
                        </div>
                    </div>
                    <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-part detail-part-sub pr detail-line">
                                <h3 class="st"><span class="line line-primary"></span>措施</h3>
                                <p>措施<%#Eval("ItemName")%></p>
                                <div class="detail-col detail-col-2">
                                    <div class="col">
                                        <span>协办单位</span>
                                        <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
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
                                        <span class="process"><%#Eval("FinshPercent")%>%</span>
                                    </div>
                                </div>
                                <div class="detail-block enclosure-list" data-sm="<%#Eval("ItemId")%>"></div>
                            </div>



                            <asp:Repeater ID="Repeater15_1_1" runat="server">
                                <ItemTemplate>
                                    <div class="detail-part detail-part-sub2 pr detail-line">
                                        <h3 class="st"><span class="line line-success"></span>子措施<%#Container.ItemIndex + 1%>  <span><%#Eval("ItemId") %></span></h3>
                                        <p><%#Eval("ItemName")%></p>
                                        <div class="detail-col detail-col-2">
                                            <div class="col">
                                                <span>协办单位</span>
                                                <span title="<%#Eval("AssistDeptName")%>"><%#Eval("AssistDeptName")%></span>
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
                            <%#reason%>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <% } %>

        <% if (page == 5 && isParentTargetItem && !IsJS)
            { %>

        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater7" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px;">
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
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
            <asp:Repeater ID="Repeater8" runat="server" OnItemDataBound="Repeater8_ItemDataBound">
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

                        <asp:Repeater ID="Repeater8_1" runat="server" OnItemDataBound="Repeater8_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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

                                <asp:Repeater ID="Repeater8_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% } %>

        <% if (page == 5 && isParentTargetItem && IsJS)
            { %>
        <%--措施调整变更详情页（结束）--%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater19" runat="server" OnItemDataBound="Repeater19_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px;">
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
                        <div class="detail-part detail-part-sub pr detail-line">
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
                        <asp:Repeater ID="Repeater19_1" runat="server">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub2 pr detail-line">
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
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <% if (IsHistory)
            { %>

        <div class="af">
            <asp:Repeater ID="Repeater20" runat="server" OnItemDataBound="Repeater11_ItemDataBound">
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
                        <div class="detail-part detail-part-sub pr detail-line">
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

                        <asp:Repeater ID="Repeater11_1" runat="server">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub2 pr detail-line">
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
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <% }
            else
            { %>
        <div class="af">
            <asp:Repeater ID="Repeater21" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
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

                        <asp:Repeater ID="Repeater1_1" runat="server" OnItemDataBound="Repeater1_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% } %>

        <% } %>

        <% if (page == 5 && !isParentTargetItem && !IsJS)
            { %>

        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater9" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px;">
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
                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                <asp:Repeater ID="Repeater15_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
            <asp:Repeater ID="Repeater10" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
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

                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater12_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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

                                <asp:Repeater ID="Repeater12_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% } %>


        <% if (page == 5 && !isParentTargetItem && IsJS)
            { %>
        <%--子措施调整变更详情页（结束）--%>
        <div class="bf">
            <div class="bft">调整前</div>
            <asp:Repeater ID="Repeater22" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
                <ItemTemplate>
                    <div class="detail-box" style="margin-bottom: 15px;">
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
                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater17_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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
                                <asp:Repeater ID="Repeater17_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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

        <% if (IsHistory)
            { %>
        <div class="af">
            <asp:Repeater ID="Repeater24" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
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

                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater18_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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

                                <asp:Repeater ID="Repeater18_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% }
            else
            { %>
        <div class="af">
            <asp:Repeater ID="Repeater23" runat="server" OnItemDataBound="Repeater15_ItemDataBound">
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

                        <asp:Repeater ID="Repeater15_1" runat="server" OnItemDataBound="Repeater15_1_ItemDataBound">
                            <ItemTemplate>
                                <div class="detail-part detail-part-sub pr detail-line">
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

                                <asp:Repeater ID="Repeater15_1_1" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub2 pr detail-line">
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
        <% } %>
        <% } %>

        <% if (page == 5)
           { %>
        <div class="card card-box">
            <div class="card-header">
                <h3 class="c-primary">调整原因
                </h3>
                <div class="form-group">
                    <%= reason %>
                </div>
            </div>
        </div>
        <% } %>
        <div class="tar">
            <button type="button" class="btn btn-default-s" data-toggle="modal" data-target="#opera" name="btnOpreaHistory" data-targetid="<%=targetid %>" data-targetitemid="<%=itemid %>">操作记录</button>
        </div>
    </div>

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
        require(['jquery', 'bootstrap', 'toast'], function ($) {
            function getQueryString(name) {
                var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                }
                return null;
            }
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

            $(document).on('click', '#rollBackPage1', function (e) {

                $.ajax({
                    type: "POST",
                    data: JSON.stringify({ smId: getQueryString("smid"), flowId: getQueryString("flowid") }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/RollBack",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status != "1") {
                            layer.msg(data.d.message, { icon: 2 });
                        } else {
                            layer.msg("撤回成功。", { icon: 1, time: 1500 }, function () {
                                window.close();
                            });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon: 2 });
                    }
                });
            });

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
