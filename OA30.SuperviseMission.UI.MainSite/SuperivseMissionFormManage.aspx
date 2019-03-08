<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperivseMissionFormManage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperivseMissionFormManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>运维工具</title>
    <link href="Css/bootstrap.css" rel="stylesheet" />
    <link href="Css/style.css" rel="stylesheet" />
    <link href="Css/picker.css" rel="stylesheet" />
    <style type="text/css">
        .fm .form-group.fdg.disabled {
            margin-bottom: 10px;
            margin-top: 0px;
        }

        .fm .form-group.fdg textarea.disabled[disabled] {
            margin-bottom: -10px;
            margin-top: 0;
            padding-left: 12px;
        }

        .fm .form-group textarea {
            margin-top: 5px;
            margin-bottom: 10px;
            margin-left: -5px;
        }

        .fm .form-group.fdg {
            margin-bottom: 0px;
        }

        .editabled {
            text-align: center;
        }

        .tab-content .tab-pane {
            background: #fff;
        }

            .tab-content .tab-pane:first-child {
                background: none;
            }

        .table {
        }

            .table > tbody > tr > td {
                vertical-align: middle;
            }

        .fm .detail-box .detail-part .col.form-group {
            height: 36px;
            line-height: 36px;
        }

        .fd.form-group {
            margin-bottom: 0;
        }

        .tab-content > div.tab-pane {
        }

        .fm .form-group .disabled[disabled] {
            width: 100%;
        }

        .mgbm {
            margin-bottom: 10px;
        }

        .pdbm {
            padding-bottom: 10px;
        }

        .tab-content .tab-pane {
            padding-bottom: 10px;
        }

        .h .fg input[type="submit"] {
            padding: 0;
            height: 35px;
            width: 80px;
            line-height: 35px;
            vertical-align: 1px;
            border-radius: 5px;
        }

        .fm .form-group textarea.disabled[disabled] {
            margin-bottom: 0;
            margin-left: 0;
        }
        .h .fg .dib .form-control {
            display:inline;
        }
        .detail-box .detail-part input,.detail-box .detail-part textarea {
            font-size:12px!important;
            height:34px!important;
        }
        .dib input {
            margin-top:-4px;
        }
        .detial-info span {
            font-size:14px;
        }
    </style>
</head>
<body class="fm">
    <form runat="server" id="form1">
        <div class="h">
            <div class="fg form-group">
                <span class="dib">文档ID：</span>
                <div class="dib">
                    <input class="form-control" type="text" name="search" value="" runat="server" id="txtSMID" />
                </div>
                <div class="dib">
                    <%--<button class="btn btn-primary-s">查询</button>--%>
                    <asp:Button ID="btnQuery" CssClass="btn btn-primary-s" runat="server" Text="查询" OnClientClick="return checkSearch();" OnClick="btnQuery_Click" />
                </div>
            </div>
        </div>
    </form>

    <div class="main main2" style="display: <%= HaveResult ? "block" : "none" %>;">
        <!--tab-->
        <div class="t">
            <ul class="nav nav-tabs" role="tablist">
                <!--这里传参数判断是领导还是年度-->
                <!--年度显示tab1-->
                <li role="presentation" class="active" style="display: <%= IsNdType ? "block" : "none" %>;"><a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">年度表单信息</a></li>
                <!--年度显示tab1-->
                <!--年度显示tab5-->
                <li role="presentation" class="active" style="display: <%= IsLdType ? "block" : "none" %>;"><a href="#tab5" aria-controls="tab5" role="tab" data-toggle="tab">领导表单信息</a></li>
                <!--年度显示tab5-->
                <!--这里传参数判断是领导还是年度-->
                <li role="presentation"><a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">修改意见</a></li>
                <li role="presentation"><a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">流转信息</a></li>
                <li role="presentation"><a href="#tab4" aria-controls="tab4" role="tab" data-toggle="tab">附件管理</a></li>
            </ul>
        </div>
        <!--tab-->

        <!--tab-content-->
        <div class="tab-content">
            <!--tab1 表单信息。-->
            <% if (IsNdType)
                { %>
            <!--年度表单信息-->
            <div role="tabpanel" class="tab-pane <%=IsNdType?"active":""%>" id="tab1">
                <!--任务-->
                <div class="card" data-index="1">
                    <div class="card-header card-header-line">
                        <h3 class="title">详情</h3>
                        <span class="iconfont icon-sv-del"></span>
                    </div>
                    <div class="card-body form-in-edit">
                        <div class="clearfix detial-info">
                            <ul class="list-unstyled">
                                <li>
                                    <div class="row">
                                        <label class="dib">任务内容：</label>
                                        <span class="dib form-group fdg disabled">
                                            <textarea class="disabled form-control th1" disabled="disabled" name="TaskContent"><%=TaskContent%></textarea>
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <div class="dib">
                                            <label class="dib">督查编号：</label>
                                            <div class="dib il">
                                                <div class="sedit">
                                                    <span class="s"><%=SpNumberName%></span>
                                                    <select class="fcc" name="snName" style="display: none">
                                                    </select>
                                                    <span class="s"><%=SpNumberYear%></span>
                                                    <select class="fcc" name="snYear" style="display: none">
                                                    </select>
                                                    <span class="s"><%=SpNumberCode%>号</span>
                                                    <input type="text" name="snCode" class="fcc" value="<%=SpNumberCode%>" style="display: none" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="dib">
                                            <label>文档ID：</label>
                                            <span>
                                                <span><%=SmId%></span>
                                                <input type="hidden" name="SmId" value="<%=SmId%>" />
                                            </span>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">主管领导：</label>
                                        <span class="dib form-group">
                                            <input type="text" data-obj="1" class="form-control disabled" disabled="disabled" value="<%=MainLeader %>" name="employ" data-toggle="modal" data-target="#leaderModal" data-key="<%=MainLeaderIds%>" data-val="<%=MainLeaderNames%>" />
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">协管领导：</label>
                                        <span class="dib form-group">
                                            <input type="text" data-obj="1" name="leader" class="form-control disabled" disabled="disabled" value="<%=AssLeader %>" data-toggle="modal" data-target="#leaderModal" data-key="<%=AssLeaderIds%>" data-val="<%=AssLeaderNames%>" />
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">主办单位：</label>
                                        <span class="dib form-group">
                                            <input type="text" data-obj="1" name="company" class="form-control disabled" disabled="disabled" data-toggle="modal" data-target="#company" value="<%=MainDeptNames %>" data-key="<%=MainDeptIds%>" data-val="<%=MainDeptNames %>" />
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">协办单位：</label>
                                        <span class="dib form-group">
                                            <input type="text" data-obj="1" name="office" class="form-control disabled" disabled="disabled" value="<%=AssistDeptNames %>" data-toggle="modal" data-target="#company" data-key="<%=AssistDeptIds %>" data-val="<%=AssistDeptNames%>" />
                                        </span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end任务-->
                <!--年度-->
                <div style="display: block">
                    <asp:Repeater ID="rptTarget" runat="server" OnItemDataBound="rptTarget_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-box">
                                <div class="detail-part" data-index="<%=DataIndex%>">
                                    <h3 class="c">年度目标<%#GetPostfix(0)%></h3>
                                    <p class="form-group disabled">
                                        <textarea class="form-control disabled th2" disabled="disabled" name="TargetName"><%#Eval("TargetName")%></textarea>
                                        <input type="hidden" name="SmId" value="<%#Eval("SmId")%>" />
                                        <input type="hidden" name="TargetId" value="<%#Eval("TargetId")%>" />
                                    </p>
                                    <div class="detail-col">
                                        <div class="col form-group">
                                            <span class="dib">主办单位</span>
                                            <span class="dib">
                                                <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("CreatorDeptName") %>" name="company" data-toggle="modal" data-target="#company" data-key="<%#Eval("CreatorDeptId") %>" data-val="<%#Eval("CreatorDeptName") %>" /></span>
                                        </div>
                                        <div class="col form-group">
                                            <span class="dib">目标进度</span>
                                            <span class="dib c-danger">
                                                <input type="text" class="disabled form-control" disabled="disabled" value="<%#Eval("TargetPercent") %>%" name="TargetPercent" />
                                            </span>
                                        </div>
                                    </div>
                                    <div class="detail-block"></div>
                                </div>

                                <asp:Repeater ID="rptItem" runat="server" OnItemDataBound="rptItem_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub pr" data-index="<%=DataIndex%>">
                                            <h3><span class="line line-primary"></span>措施<%#GetPostfix(1)%></h3>
                                            <p class="form-group disabled">
                                                <textarea class="form-control disabled th3" disabled="disabled" name="ItemName"><%#Eval("ItemName") %></textarea>
                                                <input type="hidden" name="SmId" value="<%#Eval("SmId")%>" />
                                                <input type="hidden" name="TargetId" value="<%#Eval("TargetId")%>" />
                                                <input type="hidden" name="ItemId" value="<%#Eval("ItemId")%>" />
                                            </p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col form-group">
                                                    <span class="dib">协办单位</span>
                                                    <span class="dib">
                                                        <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("AssistDeptName") %>" name="company" data-toggle="modal" data-target="#company" data-key="<%#Eval("AssistDeptId") %>" data-val="<%#Eval("AssistDeptName") %>" /></span>
                                                </div>
                                                <div class="col form-group">
                                                    <span class="dib">完成时间</span>
                                                    <span class="dib">
                                                        <input type="text" data-date-format="yyyy-mm-dd" readonly="readonly" class="disabled form-control input-time" disabled="disabled" value="<%#Convert.ToDateTime(Eval("DeadLineTime")).ToString("yyyy-MM-dd") %>" name="DeadLineTime" /></span>
                                                </div>


                                                <div class="col form-group">
                                                    <span class="dib">责任处室</span>
                                                    <span class="dib">
                                                        <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("DutyDeptName") %>" name="snCompany" data-single="true" data-toggle="modal" data-target="#company" data-key="<%#Eval("DutyDeptId") %>" data-val="<%#Eval("DutyDeptName") %>" /></span>
                                                </div>

                                                <div class="col form-group">
                                                    <span class="dib">完成进度</span>
                                                    <span class="dib process">
                                                        <input type="text" class="disabled form-control" disabled="disabled" value="<%#Eval("FinshPercent") %>%" name="FinshPercent" /></span>
                                                </div>
                                            </div>
                                            <div class="detail-block">
                                            </div>
                                        </div>

                                        <asp:Repeater ID="rptItem_1" runat="server">
                                            <ItemTemplate>
                                                <div class="detail-part detail-part-sub2 pr" data-index="<%=DataIndex%>">
                                                    <h3><span class="line line-success"></span>子措施<%#GetPostfix(2)%></h3>
                                                    <p class="form-group disabled">
                                                        <textarea class="form-control disabled th4" disabled="disabled" name="ItemName"><%#Eval("ItemName")%></textarea>
                                                        <input type="hidden" name="SmId" value="<%#Eval("SmId")%>" />
                                                        <input type="hidden" name="TargetId" value="<%#Eval("TargetId")%>" />
                                                        <input type="hidden" name="ItemId" value="<%#Eval("ItemId")%>" />
                                                        <input type="hidden" name="ParentTargetItemId" value="<%#Eval("ParentTargetItemId")%>" />
                                                    </p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col form-group">
                                                            <span class="dib">协办单位</span>
                                                            <span class="dib">
                                                                <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("AssistDeptName") %>" name="company" data-toggle="modal" data-target="#company" data-key="<%#Eval("AssistDeptId") %>" data-val="<%#Eval("AssistDeptName") %>" /></span>
                                                        </div>
                                                        <div class="col form-group">
                                                            <span class="dib">完成时间</span>
                                                            <span class="dib">
                                                                <input type="text" data-date-format="yyyy-mm-dd" readonly="readonly" class="form-control input-time disabled" name="DeadLineTime" data-name="dataPicker" value="<%#Convert.ToDateTime(Eval("DeadLineTime")).ToString("yyyy-MM-dd") %>" disabled="disabled" />
                                                            </span>
                                                        </div>
                                                        <div class="col form-group">
                                                            <span class="dib">责任人</span>
                                                            <span class="dib">
                                                                <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("ExcutorName") %>" name="employ" data-toggle="modal" data-target="#leaderModal" data-key="<%#Eval("ExcutorId") %>" data-val="<%#Eval("ExcutorName") %>" />
                                                            </span>
                                                        </div>
                                                        <div class="col form-group">
                                                            <span class="dib">完成进度</span>
                                                            <span class="dib process">
                                                                <input type="text" class="disabled form-control" disabled="disabled" value="<%#Eval("FinshPercent") %>%" name="FinshPercent" /></span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <!--end年度-->
                <div class="tac">
                    <button type="button" class="btn btn-primary-c" id="update">提交</button>
                </div>
            </div>
            <!--end年度表单信息-->
            <%
                }
                else
                {
            %>

            <!--领导表单信息-->
            <div role="tabpanel" class="tab-pane <%=IsLdType?"active":""%>" id="tab5">
                <!--任务-->
                <div class="card" data-index="1">
                    <div class="card-header card-header-line">
                        <h3 class="title c">详情</h3>
                        <span class="iconfont icon-sv-del"></span>
                    </div>
                    <div class="card-body">
                        <div class="clearfix detial-info">
                            <ul class="list-unstyled">
                                <li>
                                    <div class="row">
                                        <label class="dib">任务内容：</label>
                                        <span class="dib form-group fdg disabled">
                                            <textarea class="disabled form-control th1" disabled="disabled" name="TaskContent"><%=TaskContent%></textarea>
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <div class="dib">
                                            <label class="dib">督查编号：</label>
                                            <div class="dib il">
                                                <div class="sedit">
                                                    <span class="s"><%=SpNumberName%></span>
                                                    <select class="fcc" name="snName" style="display: none">
                                                    </select>
                                                    <span class="s"><%=SpNumberYear%></span>
                                                    <select class="fcc" name="snYear" style="display: none">
                                                    </select>
                                                    <span class="s"><%=SpNumberCode%>号</span>
                                                    <input type="text" name="snCode" class="fcc" value="<%=SpNumberCode%>" style="display: none" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="dib">
                                            <label>文档ID：</label>
                                            <span>
                                                <span><%=SmId%></span>
                                                <input type="hidden" name="SmId" value="<%=SmId%>" />
                                            </span>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">主办单位：</label>
                                        <span class="dib form-group">
                                            <input data-obj="1" type="text" name="company" data-toggle="modal" data-target="#company" data-single="false" readonly="readonly" class="form-control disabled" disabled="disabled" value="<%=MainDeptNames %>" data-key="<%=MainDeptIds%>" data-val="<%=MainDeptNames %>" />
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">协办单位：</label>
                                        <span class="dib form-group">
                                            <input data-obj="1" type="text" name="office" data-toggle="modal" data-target="#company" data-single="false" readonly="readonly" class="form-control disabled" disabled="disabled" value="<%=AssistDeptNames %>" data-key="<%=AssistDeptIds %>" data-val="<%=AssistDeptNames%>" />
                                        </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="row">
                                        <label class="dib">启动时间：</label>
                                        <span class="dib form-group">
                                            <input type="text" readonly="readonly" class="disabled form-control input-time" disabled="disabled" value="<%=Convert.ToDateTime(StartTime).ToString("yyyy-MM-dd") %>" name="StartTime" />
                                        </span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end任务-->
                <!--主办单位-->
                <div style="display: block">
                    <asp:Repeater ID="rptLdTarget" runat="server" OnItemDataBound="rptLdTarget_ItemDataBound">
                        <ItemTemplate>
                            <div class="detail-box">
                                <div class="detail-part" data-index="<%=DataIndex%>">
                                    <h3 class="c">主办单位<%#GetPostfix(0)%></h3>
                                    <p class="form-group disabled">
                                        <%--<textarea class="form-control disabled th2" disabled="disabled" name="TargetName"><%#Eval("TargetName")%></textarea>--%>
                                        <input type="hidden" name="SmId" value="<%#Eval("SmId")%>" />
                                        <input type="hidden" name="TargetId" value="<%#Eval("LmmId")%>" />
                                    </p>
                                    <div class="detail-col">
                                        <div class="col form-group">
                                            <span class="dib">主办单位</span>
                                            <span class="dib">
                                                <input data-single="true" type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("DeptName") %>" name="office" data-toggle="modal" data-target="#company" data-key="<%#Eval("DeptId") %>" data-val="<%#Eval("DeptName") %>" /></span>
                                        </div>
                                        <div class="col form-group">
                                            <span class="dib">完成进度</span>
                                            <span class="dib c-danger">
                                                <input type="text" class="disabled form-control" disabled="disabled" value="<%#Eval("FinishPercent") %>%" name="TargetPercent" />
                                            </span>
                                        </div>
                                    </div>
                                    <div class="detail-block"></div>
                                </div>

                                <asp:Repeater ID="rptLdItem" runat="server" OnItemDataBound="rptLdItem_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="detail-part detail-part-sub pr" data-index="<%=DataIndex%>">
                                            <h3><span class="line line-primary"></span>措施<%#GetPostfix(1)%></h3>
                                            <p class="form-group disabled">
                                                <textarea class="form-control disabled th3" disabled="disabled" name="ItemName"><%#Eval("ItemName") %></textarea>
                                                <input type="hidden" name="SmId" value="<%#Eval("SmId")%>" />
                                                <input type="hidden" name="TargetId" value="<%#Eval("TargetId")%>" />
                                                <input type="hidden" name="ItemId" value="<%#Eval("ItemId")%>" />
                                            </p>
                                            <div class="detail-col detail-col-2">
                                                <div class="col form-group">
                                                    <span class="dib">协办单位</span>
                                                    <span class="dib">
                                                        <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("AssistDeptName") %>" name="company" data-toggle="modal" data-target="#company" data-key="<%#Eval("AssistDeptId") %>" data-val="<%#Eval("AssistDeptName") %>" /></span>
                                                </div>

                                                <div class="col form-group">
                                                    <span class="dib">完成时间</span>
                                                    <span class="dib">
                                                        <input type="text" data-date-format="yyyy-mm-dd" readonly="readonly" class="disabled form-control input-time" disabled="disabled" value="<%#Convert.ToDateTime(Eval("DeadLineTime")).ToString("yyyy-MM-dd") %>" name="DeadLineTime" /></span>
                                                </div>

                                                <div class="col form-group">
                                                    <span class="dib">责任处室</span>
                                                    <span class="dib">
                                                        <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("DutyDeptName") %>" name="snCompany" data-single="true" data-toggle="modal" data-target="#company" data-key="<%#Eval("DutyDeptId") %>" data-val="<%#Eval("DutyDeptName") %>" /></span>
                                                </div>

                                                <div class="col form-group">
                                                    <span class="dib">完成进度</span>
                                                    <span class="dib process">
                                                        <input type="text" class="disabled form-control" disabled="disabled" value="<%#Eval("FinshPercent") %>%" name="FinshPercent" /></span>
                                                </div>
                                            </div>
                                            <div class="detail-block">
                                            </div>
                                        </div>

                                        <asp:Repeater ID="rptLdItem_1" runat="server">
                                            <ItemTemplate>
                                                <div class="detail-part detail-part-sub2 pr" data-index="<%=DataIndex%>">
                                                    <h3><span class="line line-success"></span>子措施<%#GetPostfix(2)%></h3>
                                                    <p class="form-group disabled">
                                                        <textarea class="form-control disabled th4" disabled="disabled" name="ItemName"><%#Eval("ItemName")%></textarea>
                                                        <input type="hidden" name="SmId" value="<%#Eval("SmId")%>" />
                                                        <input type="hidden" name="TargetId" value="<%#Eval("TargetId")%>" />
                                                        <input type="hidden" name="ItemId" value="<%#Eval("ItemId")%>" />
                                                        <input type="hidden" name="ParentTargetItemId" value="<%#Eval("ParentTargetItemId")%>" />
                                                    </p>
                                                    <div class="detail-col detail-col-2">
                                                        <div class="col form-group">
                                                            <span class="dib">协办单位</span>
                                                            <span class="dib">
                                                                <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("AssistDeptName") %>" name="company" data-toggle="modal" data-target="#company" data-key="<%#Eval("AssistDeptId") %>" data-val="<%#Eval("AssistDeptName") %>" /></span>
                                                        </div>
                                                        <div class="col form-group">
                                                            <span class="dib">完成时间</span>
                                                            <span class="dib">
                                                                <input type="text" data-date-format="yyyy-mm-dd" readonly="readonly" class="form-control input-time disabled" name="DeadLineTime" data-name="dataPicker" value="<%#Convert.ToDateTime(Eval("DeadLineTime")).ToString("yyyy-MM-dd") %>" disabled="disabled" />
                                                            </span>
                                                        </div>
                                                        <div class="col form-group">
                                                            <span class="dib">责任人</span>
                                                            <span class="dib">
                                                                <input type="text" data-obj="1" class="disabled form-control" disabled="disabled" value="<%#Eval("ExcutorName") %>" name="employ" data-toggle="modal" data-target="#leaderModal" data-key="<%#Eval("ExcutorId") %>" data-val="<%#Eval("ExcutorName") %>" />
                                                            </span>
                                                        </div>
                                                        <div class="col form-group">
                                                            <span class="dib">完成进度</span>
                                                            <span class="dib process">
                                                                <input type="text" class="disabled form-control" disabled="disabled" value="<%#Eval("FinshPercent") %>%" name="FinshPercent" /></span>
                                                        </div>
                                                    </div>
                                                    <div class="detail-block">
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="tac">
                    <button type="button" class="btn btn-primary-c" id="updateLD">提交</button>
                </div>
                <!--end年度-->
            </div>
            <!--end领导表单信息-->
            <% } %>


            <!--end tab1 表单信息。-->

            <!--tab2-->
            <div role="tabpanel" class="tab-pane" id="tab2">


                <table class="table">
                    <thead>
                        <tr>
                            <th>处理人工号</th>
                            <th>处理人姓名</th>
                            <th>接收时间</th>
                            <th>阅读时间</th>
                            <th>完成时间</th>
                            <th>处理意见</th>
                            <th>处理步骤</th>
                            <th>意见类型</th>

                        </tr>
                    </thead>
                    <tbody class="trOpreaHistory">
                        <%foreach (var smFlowItemBaseEntity in smFlowItemBaseEntitys)
                            { %>


                        <tr>
                            <td style="display: none">
                                <input type="hidden" name="SmIdTab2" value="<%=smFlowItemBaseEntity.SmId%>" />
                            </td>
                            <td style="display: none">
                                <input type="hidden" name="FlowIdTab2" value="<%=smFlowItemBaseEntity.FlowId %>" />
                            </td>
                            <td><%=smFlowItemBaseEntity.UserId %></td>
                            <td><%=smFlowItemBaseEntity.UserName%></td>
                            <td><%=smFlowItemBaseEntity.ReceiveTime%></td>
                            <td><%=smFlowItemBaseEntity.ReadTime%></td>
                            <td><%=smFlowItemBaseEntity.FinishTime%></td>

                            <%if (!String.IsNullOrEmpty(smFlowItemBaseEntity.FinishTime.ToString()))
                                { %>
                            <td>
                                <div class="form-group fd disabled">
                                    <input type="text" id="HandleOptionId" name="HandleOption" class="disabled form-control" value="<%=smFlowItemBaseEntity.Opinion%>" />
                                </div>
                            </td>

                            <%}
                                else
                                { %>
                            <td><%=smFlowItemBaseEntity.Opinion%></td>
                            <% }%>

                            <td><%=smFlowItemBaseEntity.StepName%></td>


                            <td>

                                <%if (!String.IsNullOrEmpty(smFlowItemBaseEntity.FinishTime.ToString()))
                                    { %>
                                <div class="editabled">

                                    <%--获取意见类型数据选择下拉框--%>
                                    <select data-type="edit" class="form-control TypeName-edit disabled" id="OpinionTypeId" name="OpinionType">

                                        <%foreach (var smBasicDataOpinionTypeEntity in smBasicDataOpinionTypeEntitys)
                                            { %>

                                        <% if (smBasicDataOpinionTypeEntity.TypeId == smFlowItemBaseEntity.OpinionType)
                                            { %>
                                        <option value="<%=smBasicDataOpinionTypeEntity.TypeId%>" selected="selected"><%=smBasicDataOpinionTypeEntity.TypeName%></option>
                                        <%}
                                            else
                                            { %>
                                        <option value="<%=smBasicDataOpinionTypeEntity.TypeId%>"><%=smBasicDataOpinionTypeEntity.TypeName%></option>
                                        <%} %>
                                        <%}%>
                                    </select>

                                </div>

                                <%}
                                    else
                                    { %>

                                <%=smFlowItemBaseEntity.OpinionType%>
                          
                            </td>
                            <% }%>
                        </tr>

                        <%} %>
                    </tbody>
                </table>

                <div class="tac">
                    <button type="button" class="btn btn-primary-c" id="updateOption">提交</button>
                </div>
            </div>
            <!--end tab2-->

            <!--tab3 流转信息。-->
            <div role="tabpanel" class="tab-pane" id="tab3">
                <table class="table">
                    <thead>
                        <tr>
                            <th>是否可用</th>
                            <th>表单号smid</th>
                            <th>流程号flowid</th>
                            <th>目标id</th>
                            <th>措施id</th>
                            <th>部门id</th>
                            <th>部门名称</th>
                            <th>处理人id</th>
                            <th>处理人姓名</th>
                            <th>意见</th>
                            <th>接受时间</th>
                            <th>完成时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% foreach (var smFlowFinishAndWaitingEntity in smFlowFinishAndWaitingEntityList)
                            { %>

                        <% if (smFlowFinishAndWaitingEntity.SmFlowWaitingEntity != null)
                            { %>
                        <tr>
                            <td>
                                <input type="hidden" name="SmId" value="<%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.SmId %>" />
                                <input type="hidden" name="FlowId" value="<%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.FlowId %>" />
                                <input type="hidden" name="FlowType" value="Waiting" />
                                <select name="ActivityFlag" class="form-control">
                                    <% if (smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.ActivityFlag == 1)
                                        { %>
                                    <option value="1" selected="selected">是</option>
                                    <option value="0">否</option>
                                    <% }
                                        else
                                        { %>
                                    <option value="1">是</option>
                                    <option value="0" selected="selected">否</option>
                                    <% } %>
                                </select>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.SmId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.FlowId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.TargetId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.TargetItemId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.UserDeptId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.UserDeptName %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.UserId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.UserName %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.Opinion %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.ReceiveTime %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowWaitingEntity.FinishTime %>
                            </td>
                        </tr>
                        <% }
                            else
                            { %>
                        <tr>
                            <td>
                                <input type="hidden" name="SmId" value="<%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.SmId %>" />
                                <input type="hidden" name="FlowId" value="<%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.FlowId %>" />
                                <input type="hidden" name="FlowType" value="Finish" />
                                <select name="ActivityFlag" class="form-control">
                                    <% if (smFlowFinishAndWaitingEntity.SmFlowFinishEntity.ActivityFlag == 1)
                                        { %>
                                    <option value="1" selected="selected">是</option>
                                    <option value="0">否</option>
                                    <% }
                                        else
                                        { %>
                                    <option value="1">是</option>
                                    <option value="0" selected="selected">否</option>
                                    <% } %>
                                </select>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.SmId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.FlowId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.TargetId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.TargetItemId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.UserDeptId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.UserDeptName %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.UserId %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.UserName %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.Opinion %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.ReceiveTime %>
                            </td>
                            <td>
                                <%=smFlowFinishAndWaitingEntity.SmFlowFinishEntity.FinishTime %>
                            </td>
                        </tr>
                        <% } %>
                        <% } %>
                    </tbody>
                </table>
                <div class="tac">
                    <button type="button" class="btn btn-primary-c" id="changeInfo">提交</button>
                </div>
            </div>
            <!--end tab3 流转信息。-->

            <!--tab4 附件管理。-->
            <div role="tabpanel" class="tab-pane" id="tab4">
                <asp:Literal ID="litResult" runat="server"></asp:Literal>
            </div>
            <!--end tab4 附件管理。-->
        </div>
    </div>
    <!--end tab-content-->
    <!--搜索无结果-->
    <div class="no-result" style="display: <%=NotHaveResult?"block":"none"%>;">
        <div class="no-page">
            <div class="no-search-icon"></div>
            <p>暂无查询结果</p>
        </div>
    </div>
    <!--end搜索无结果-->

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

    require(['jquery', 'mustache', 'common', 'state', 'lodash', 'bootstrap', 'picker', 'toast', 'jquery.iframe-transport', 'jquery.fileupload'], function ($, Mustache, cm, state, _) {
        //字符串转对象
        function stringToObject(key, value) {
            var obj = {}
            if (key) {
                if (value.indexOf(';') > -1) {
                    var ids = key.split(';');
                    var vds = value.split(';');
                    _.each(ids, function (item, index) {
                        obj[item] = vds[index]
                    });
                } else {
                    obj[key] = value
                }
            }
            console.log(obj)
            return obj;
        }
        // 遍历任务、目标，措施，子措施。
        $('[data-index]').each(function (index) {
            var obj = {}
            $(this).find('[name]').each(function () {
                var name = $(this).attr('name');
                var val = $(this).val();
                var ids = $(this).data('key');
                var names = $(this).data('val');
                if ($(this).data('obj')) {
                    obj[name] = stringToObject(ids, names);
                } else {
                    obj[name] = val;
                    if (name === 'snName') {
                        obj['snName'] = '<%=SpNumberName%>';
                    } else if (name === 'snYear') {
                        obj['snYear'] = '<%=SpNumberYear%>';
                    } else {
                        obj[name] = val;
                    }
            }

            })
            //console.log(obj)
            state.setIndex(obj);

            /*
                        $(this).find('[name]').each(function () {
                            var name = $(this).attr('name');
                            var val = $(this).val();
                            var ids = $(this).data('key');
                            var names = $(this).data('val');
                            if ($(this).data('obj') && ids && names) {
                                state.stringToObject(name,ids,names);
                            }
                        })
                        */
            /*
            state.setIndex({
                company: stringToObject($('[data-index="' + (index + 1) + '"] [name="company"]').data('assdeptid'), $('[data-index="' + (index + 1) + '"] [name="company"]').data('assdeptname')),
                dutydeptname: stringToObject($('[data-index="' + (index + 1) + '"] [name="dutydeptname"]').data('dutydeptid'), $('[data-index="' + (index + 1) + '"] [name="dutydeptname"]').data('dutydeptname')),
                employ: stringToObject($('[data-index="' + (index + 1) + '"] [name="employ"]').data('mainleaderid'), $('[name="employ"]').data('mainleadername')),
                leader: stringToObject($('[data-index="' + (index + 1) + '"] [name="leader"]').data('assleaderid'), $('[data-index="' + (index + 1) + '"] [name="leader"]').data('assleadername')),
                SmId: $('[data-index="' + (index + 1) + '"] [name="SmId"]').val(),
                TargetId: $('[data-index="' + (index + 1) + '"] [name="TargetId"]').val(),
                ItemId: $('[data-index="' + (index + 1) + '"] [name="ItemId"]').val(),
                ParentTargetItemId: $('[data-index="' + (index + 1) + '"] [name="ParentTargetItemId"]').val(),
                TargetName: $('[data-index="' + (index + 1) + '"] [name="TargetName"]').val(),
                TargetPercent: $('[data-index="' + (index + 1) + '"] [name="TargetPercent"]').val(),
                TaskContent: $('[data-index="' + (index + 1) + '"] [name="TaskContent"]').val(),
                TargetName: $('[data-index="' + (index + 1) + '"] [name="TargetName"]').val(),
                ItemName: $('[data-index="' + (index + 1) + '"] [name="ItemName"]').val(),
                DeadLineTime: $('[data-index="' + (index + 1) + '"] [name="DeadLineTime"]').val(),
                FinshPercent: $('[data-index="' + (index + 1) + '"] [name="FinshPercent"]').val()
            });
            */
        });
        console.log(state.page)
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

        //流转信息提交
        $(document).on('click', '#changeInfo', function (e) {
            var $this = $(e.target);
            var postData = [];
            $('#tab3 .table tbody tr').each(function () {
                var obj = {};
                $(this).find('[name]').each(function () {
                    var name = $(this).attr('name');
                    var val = $(this).val();
                    if (name === 'ActivityFlag') {
                        obj[name] = $(this).find('option:selected').val();
                    } else {
                        obj[name] = val;
                    }
                })
                postData.push(obj);
            })
            $.ajax({
                data: JSON.stringify({ smFlowFinishAndWaitingRequestEntityList: postData }),
                url: "WebServices/ManagerToolWebService.asmx/UpdateSmFlowFinishAndWaitingList",
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('更新成功。', { icon: 1 });
                        //window.close();
                    }
                },
                error: function (message) {
                    layer.msg('更新失败。', { icon: 2 });
                },
                cache: false
            });
        })

        //搜索责任人
        $(document).on('click', '#btSearchAssLeader', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.input-group').find('input')
            var $word = $box.val();
            if ($.trim($word) === '') return
            var data = searchMan($word)
            $.when(searchMan($word)).done(function (data) {
                if (data.d.status == "1") {
                    var jd = JSON.parse(data.d.data);
                    cm.getPerson(jd)
                } else {
                    layer.msg(data.d.message, { icon: 2 });
                }
            }).fail(function (err) {
                layer.msg('请求发生异常。', { icon: 2 });
            })
        })

        //点击修改
        $(document).on('click', '.main .form-group', function (e) {
            var $this = $(e.target);
            var $index = $this.closest('[data-index]').data('index');
            //console.log(state.getState(),state.getPage(),$index)
            $this.removeClass('disabled').prop('disabled', false).parent().removeClass('disabled');

        });

        //修改表格
        $(document).on('click', '.editabled', function (e) {
            var $this = $(e.target);
            var $select = $this.find('select');
            var $span = $this.find('.s')
            $span.hide();
            $select.show();
        })
        //修改督查编号
        $(document).on('click', '.sedit', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.sedit');
            var $text = $this.find('option:selected').text();

            //console.log($this.val(), $this.find('option:selected').text())
            $box.find('.fcc').show();
            $box.find('.s').hide();
            //$this.prev().text($text);
        })
        //移开督查编号保存
        $(document).on('blur', '.main .fcc', function (e) {
            var $this = $(e.target)
            var $box = $this.parent('.sedit');
            if ($this.attr('name') === 'snCode') {
                $this.prev('.s').text($this.val());
            }
            $box.find('.fcc').hide();
            $box.find('.s').show();
            state.setValue('snCode', $box.find('[name="snCode"]').val());
        });

        //点击空白处隐藏编辑
        $(document).on('click', '.main', function (e) {
            var $this = $(e.target)
            if ($this.hasClass('form-control') || $this.hasClass('sedit') || $this.hasClass('s') || $this.hasClass('fcc'))
                return false
            $('.sedit .fcc').hide();
            $('.sedit .s').show();
        })

        //确定部门
        $(document).on('click', '[data-btn="deptSure"]', function (e) {
            //console.log($('[data-index="' + state.getIndex() + '"]'), state.dType)
            $('[data-index="' + (state.getPage() + 1) + '"]').find('[name="' + state.dType + '"]').val(state.getDeptByName());
            $('#company').modal('hide');
        })

        //日历控件
        showPicker();
        function showPicker() {
            $('.input-time').datetimepicker({
                language: 'zh-CN',
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                startDate: new Date(),
                minView: 2,
                forceParse: 0
            }).on('changeDate', function (ev) {
                var $this = $(ev.target);
                var $name = $this.attr('name');
                var $index = $this.closest('[data-index]').data('index');
                state.setPage($index);
                console.log($index)
                var $val = $(ev.target).val()
                if ($name) {
                    state.setValue($name, $val)
                }
                state.setValue('endTime', $val)
                console.log(state.page)
            })
        }
        //textarea高度自适应
        /*
        $(document).on("keyup", 'textarea', function () {
            var $this = $(this);
            if (!$this.attr('initAttrH')) {
                $this.attr('initAttrH', $this.outerHeight());
            }
            $this.css({ height: $this.attr('initAttrH'), 'overflow-y': 'hidden' }).height(this.scrollHeight - 16);
            $this.parent().height(this.scrollHeight - 16);
        });
        */

        //添加年度目标的textarea高度问题
        //回车键状态码
        var textareaState = 0;
        $(document).on('keyup', "textarea[name='TargetName'],textarea[name='ItemName']", function (e) {
            var $this = $(e.target);
            //捕获回车键
            $(document).keyup(function (event) {
                if (event.keyCode == 13) {
                    $this.css({ 'height': '52px', 'overflow': 'auto' });
                    $this.parent('.form-group').css('margin-top', '10px');
                    textareaState++;
                }
            });
            //判断字数及回车换行
            if ($this.val().length >= 80 || textareaState > 0) {
                $this.css({ 'height': '52px', 'overflow': 'auto', 'line-height': '25px' });
                $this.parent('.form-group').css('margin-top', '10px');
            } else {
                $this.css({ 'height': '30px', 'overflow-y': 'hidden' });
                $this.parent('.form-group').css('margin-top', '5px')
            };
            //当字数为空的时候，回车键状态码清零
            if ($this.val() == '') {
                textareaState = 0;
                $this.css({ 'height': '30px', 'overflow-y': 'hidden' });
                $this.parent('.form-group').css('margin-top', '5px')
            }
        });
        $(document).on('focus', 'textarea', function (e) {
            var $this = $(e.target);
            $this.css({'overflow-y': 'auto'});
        });
        $(document).on('blur', 'textarea', function (e) {
            var $this = $(e.target);
            $this.css({'overflow-y': 'hidden'});
        });
        $(document).on('click', '.dib', function (e) {
            var $this = $(this);
            $this.children().css({ 'margin-top': '0px' });
        });

        //进度只能显示数字
        $(document).on('keyup', '[name="TargetPercent"],[name="FinshPercent"]', function (e) {
            var $this = $(e.target);
            var val = $this.val();
            var name = $this.attr('name');
            var $index = $this.closest('[data-index]').data('index');
            state.setPage($index);
            var newVal = (parseInt(val.replace(/\D+|^0+/ig, ''), 10) > 100 ? 100 : val.replace(/\D+|^0+/ig, '')) + '%';
            if (e.key === 'Backspace' || e.key === 'Delete') {
                newVal = newVal.replace('%', '');
            }
            $this.val(newVal);
            state.setValue(name, newVal);
        })
        //编辑保存
        $(document).on('change', '.main .tab-pane:eq(0) .form-control', function (e) {
            var $this = $(e.target);
            var $index = $this.closest('[data-index]').data('index');
            var $name = $this.attr('name');
            var $val = $this.val();
            state.setPage($index);
            if ($name && $name !== 'company' && $name !== 'office' && $name !== 'person' && $name !== 'employ' && $name !== 'leader' && $name !== 'snCompany' && $name !== 'dutydeptname') {
                state.setValue($name, $val);
            }
        });
        //移开保存
        $(document).on('blur', '.main #tabl .form-control,.main #tab5 .form-control', function (e) {
            var $this = $(e.target);
            var $index = $this.closest('[data-index]').data('index');
            var $name = $this.attr('name');
            var $val = $this.val();
            state.setPage($index);
            if ($name && $name !== 'company' && $name !== 'office' && $name !== 'person' && $name !== 'employ' && $name !== 'leader' && $name !== 'snCompany' && $name !== 'dutydeptname') {
                state.setValue($name, $val);
            }
            $this.addClass('disabled').prop('disabled', true).parent().addClass('disabled');
        });

        //移开select保存
        $(document).on('blur', '.main .fc', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.editabled');
            var $text = $this.find('option:selected').text();
            $box.find('.s').text($text).show();
            $this.hide().parent().addClass('disabled');
        });

        //主管领导
        $(document).on('click', '[name="employ"]', function (e) {
            state.setSingle(false);
            state.setDeptType('employ');
        });
        //不能输入html标签
        $(document).on('blur', 'textarea,input', function (e) {
            var $this = $(this);
            var val = $this.val();
            var newValue = val.replace(/\s/ig, '');
            newValue = newValue.replace(/<[a-z][A-Z]*?\/*?>|<\/[a-z][A-Z]*?>/ig, '');
            $this.val(newValue);
        })
        //协管领导
        $(document).on('click', '[name="leader"]', function (e) {
            state.setSingle(false);
            state.setDeptType('leader');
        });
        //责任处事
        $(document).on('click', '[name="dutydeptname"]', function (e) {
            state.setSingle(false);
            state.setDeptType('dutydeptname');
        });

        //协办单位
        $(document).on('click', '[name="company"]', function (e) {
            state.setDeptType('company');
            //state.setSingle(false);
        });
        $(document).on('click', '[name="office"]', function (e) {
            state.setDeptType('office');
            //state.setSingle(true);
        });
        $(document).on('click', '[name="snCompany"]', function (e) {
            state.setDeptType('snCompany');
            //state.setSingle(true);
        });

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
                layer.msg('获取部门组列表失败。', { icon: 2 });
            }
        });

        //获取部门列表。
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
                layer.msg('获取部门列表失败。', { icon: 2 });
            }
        });


        // 【表单信息-提交】。
        $(document).on('click', '#update', function (e) {
            var tData = state.page;
            var postData = _.map(tData, function (item, key) {
                var company = [];
                var companyIds = [];
                var office = [];
                var officeIds = [];
                var employ = [];
                var employIds = [];
                var leader = [];
                var leaderIds = [];
                var dutydeptname = [];
                var dutydeptnameIds = [];
                var snCompany = [];
                var snCompanyIds = [];
                _.map(item, function (v, k) {
                    if (v === undefined) {
                        item[k] = ''
                    }
                })
                var sc = _.map(item['company'], function (sc, k) {
                    if (parseInt(k, 10) === 0) return false
                    company.push(sc)
                    companyIds.push(k)
                    return {
                        company: company,
                        companyIds: companyIds
                    }
                })
                var sc = _.map(item['office'], function (sc, k) {
                    if (parseInt(k, 10) === 0) return false
                    office.push(sc)
                    officeIds.push(k)
                    return {
                        office: office,
                        officeIds: officeIds
                    }
                })
                var so = _.map(item['employ'], function (sc, k) {
                    employ.push(sc)
                    employIds.push(k)
                    return {
                        employ: employ,
                        employIds: employIds
                    }
                })
                var so = _.map(item['leader'], function (sc, k) {
                    leader.push(sc)
                    leaderIds.push(k)
                    return {
                        leader: leader,
                        leaderIds: leaderIds
                    }
                })
                var so = _.map(item['snCompany'], function (sc, k) {
                    snCompany.push(sc)
                    snCompanyIds.push(k)
                    return {
                        snCompany: snCompany,
                        snCompanyIds: snCompanyIds
                    }
                })
                if (item.hasOwnProperty('TargetPercent')) {
                    //item.TargetPercent = item.TargetPercent.replace('%', '');
                }
                if (item.hasOwnProperty('FinshPercent')) {
                    //item.FinshPercent = item.FinshPercent.replace('%', '');
                }
                return _.assign({}, item, {
                    MainDeptId: companyIds.join(';'),
                    MainDeptName: company.join(';'),
                    AssistDeptName: office.join(';'),
                    AssistDeptId: officeIds.join(';'),
                    MainLeaderName: employ.join(';'),
                    MainLeaderId: employIds.join(';'),
                    ExcutorName: employ.join(';'),
                    ExcutorId: employIds.join(';'),
                    AssLeaderId: leaderIds.join(';'),
                    AssLeaderName: leader.join(';'),
                    DutyDeptId: snCompanyIds.join(';'),
                    DutyDeptName: snCompany.join(';'),
                    NumberCode: item.snCode,
                    NumberName: item.snName,
                    NumberYear: item.snYear,
                })
            });

            // 移除未使用到的属性。
            _.map(postData, function (item) {
                console.log(item)
                delete item.company;
                delete item.employ;
                delete item.endTime;
                delete item.leader;
                delete item.dutydeptname;
                delete item.office;
                delete item.text;
                delete item.snCompany;
                delete item.single;
            });
            $.ajax({
                data: JSON.stringify({ mainTargetItems: postData }),
                url: "WebServices/ManagerToolWebService.asmx/UpdateMainTargetItem",
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('更新成功。', { icon: 1 });
                        //window.close();
                    }
                },
                error: function (message) {
                    layer.msg('更新失败。', { icon: 2 });
                },
                cache: false
            });
        });

        // 【表单信息-提交】。
        $(document).on('click', '#updateLD', function (e) {
            var tData = state.page;
            var postData = _.map(tData, function (item, key) {
                var company = [];
                var companyIds = [];
                var office = [];
                var officeIds = [];
                var employ = [];
                var employIds = [];
                var leader = [];
                var leaderIds = [];
                var dutydeptname = [];
                var dutydeptnameIds = [];
                var snCompany = [];
                var snCompanyIds = [];
                _.map(item, function (v, k) {
                    if (v === undefined) {
                        item[k] = ''
                    }
                })
                var sc = _.map(item['company'], function (sc, k) {
                    if (parseInt(k, 10) === 0) return false
                    company.push(sc)
                    companyIds.push(k)
                    return {
                        company: company,
                        companyIds: companyIds
                    }
                })
                var sc = _.map(item['office'], function (sc, k) {
                    if (parseInt(k, 10) === 0) return false
                    office.push(sc)
                    officeIds.push(k)
                    return {
                        office: office,
                        officeIds: officeIds
                    }
                })
                var so = _.map(item['employ'], function (sc, k) {
                    employ.push(sc)
                    employIds.push(k)
                    return {
                        employ: employ,
                        employIds: employIds
                    }
                })
                var so = _.map(item['leader'], function (sc, k) {
                    leader.push(sc)
                    leaderIds.push(k)
                    return {
                        leader: leader,
                        leaderIds: leaderIds
                    }
                })
                var so = _.map(item['snCompany'], function (sc, k) {
                    snCompany.push(sc)
                    snCompanyIds.push(k)
                    return {
                        snCompany: snCompany,
                        snCompanyIds: snCompanyIds
                    }
                })
                if (item.hasOwnProperty('TargetPercent')) {
                    //item.TargetPercent = item.TargetPercent.replace('%', '');
                }
                if (item.hasOwnProperty('FinshPercent')) {
                    //item.FinshPercent = item.FinshPercent.replace('%', '');
                }
                return _.assign({}, item, {
                    MainDeptId: companyIds.join(';'),
                    MainDeptName: company.join(';'),
                    AssistDeptName: office.join(';'),
                    AssistDeptId: officeIds.join(';'),
                    MainLeaderName: employ.join(';'),
                    MainLeaderId: employIds.join(';'),
                    ExcutorName: employ.join(';'),
                    ExcutorId: employIds.join(';'),
                    AssLeaderId: leaderIds.join(';'),
                    AssLeaderName: leader.join(';'),
                    DutyDeptId: snCompanyIds.join(';'),
                    DutyDeptName: snCompany.join(';'),
                    NumberCode: item.snCode,
                    NumberName: item.snName,
                    NumberYear: item.snYear,
                })
            });

            // 移除未使用到的属性。
            _.map(postData, function (item) {
                console.log(item)
                delete item.company;
                delete item.employ;
                delete item.endTime;
                delete item.leader;
                delete item.dutydeptname;
                delete item.office;
                delete item.text;
                delete item.snCompany;
                delete item.single;
            });
            console.log(postData);
            $.ajax({
                data: JSON.stringify({ mainTargetItems: postData }),
                url: "WebServices/ManagerToolWebService.asmx/UpdateLDMainTargetItem",
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('更新成功。', { icon: 1 });
                        //window.close();
                    }
                },
                error: function (message) {
                    layer.msg('更新失败。', { icon: 2 });
                },
                cache: false
            });
        });

        //获取督查字号缓存到本地。
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetDistinctSuperviseNumberNameList",
            type: "post",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d.status == "1") {
                    superviseNumber = data.d.data;
                    bindSuperviseNumber(superviseNumber);//先绑定第一个任务的督查字号
                }
                else {
                    layer.msg(data.d.message, { icon: 2 });
                }
            },
            error: function (message) {
                layer.msg("获取督查字号列表失败！", { icon: 2 });
            }
        });

        //绑定督查字号列表。
        function bindSuperviseNumber(superviseNumber) {
            var $selectSuperviseNumber = $("[name='snName']");
            if ($selectSuperviseNumber.length > 0 && superviseNumber !== '') {
                var superviseNumberList = JSON.parse(superviseNumber);
                var optionHtml = '<option value="">请选择</option>';
                //遍历生成督查字号选项
                $.each(superviseNumberList, function (index, obj) {
                    if ('<%=SpNumberDeptId%>' === obj.DeptId && '<%=SpNumberName%>' === obj.Name) {
                        optionHtml += '<option selected="selected" value="' + obj.DeptId + '">' + obj.Name + '</option>';
                    } else {
                        optionHtml += '<option value="' + obj.DeptId + '">' + obj.Name + '</option>';
                    }
                });
                $.each($selectSuperviseNumber, function (index, obj) {
                    //已绑定字号的元素不再执行绑定
                    if ($(obj).children().length === 0) {
                        $(obj).append(optionHtml);
                    }
                });
                $("select[name='snName']").trigger('change');
                }
            }

        //获取年号
        $(document).on("change", "select[name='snName']", function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.sedit');
            var $index = $this.closest('[data-index]');
            var deptId = $this.find('option:selected').val();
            var text = $this.find('option:selected').text();
            $this.prev('.s').text(text);
            //state.setPage($index);
            state.setValue('snName', text);
            if (deptId == "") {
                return;
            }
            var name = $this.find("option:selected").text();
            var jsonData = { deptId: deptId, name: name };
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/SuperviseMissionWebServices.asmx/GetSuSuperviseNumberYear",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        var years = data.d.data.split('|');
                        var str = "";
                        for (var i = 0; i < years.length; i++) {
                            console.log(<%=SpNumberYear%>)
                            str += "<option " + ('<%=SpNumberYear%>' === years[i].toString() ? 'selected="selected"' : '') + " value='" + years[i] + "'>" + years[i] + "</option>";
                        }
                        $box.find("select[name='snYear']").html('').append(str);
                        $box.find("select[name='snYear']").trigger("change");
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                }
            });
        });

        //获取序号

        $(document).on("change", "select[name='snYear']", function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.sedit');
            var deptId = $box.find("select[name='snName']").val();
            var name = $box.find("select[name='snName'] option:selected").text();
            var year = $box.find("select[name='snYear'] option:selected").text();
            var text = $this.find('option:selected').text();
            $this.prev('.s').text(text);
            state.setValue('snYear', year);
        });

        // 删除附件。
        $(document).on('click', '.icon-sv-reduce', function (e) {
            var $this = $(e.target)
            var itemId = $this.data('itemid');
            var attachmentId = $this.data('attachmentid');
            //alert('itemId=' + itemId + ' attachmentId=' + attachmentId); return;
            layer.confirm('是否确认该附件删除', { icon: 3, title: '提示' }, function (index) {

                //if (confirm("是否确认该附件删除")) {
                //先调接口进行删除附件信息
                var jsonData = { SmId: itemId, AttachmentId: attachmentId };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/DeleteSuperviseMissionAttachmentByAttachmentId",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message);
                            $this.parent('li').remove();
                        } else {
                            layer.msg(data.d.message);
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常");
                    }
                });
                //}
                layer.close(index);
            });
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
                            layer.msg(data.d.message);
                            $this.parent('li').remove();
                        } else {
                            layer.msg(data.d.message);
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。");
                    }
                });
            }
        });
        //上传文件。
        uploadFile();
        function uploadFile() {
            var SmId = '';
            var obj = '';
            $('input[type="file"]').fileupload({
                url: 'WebServices/SuperviseMissionWebServices.asmx/SaveSuperviseMissionAttachment',
                dataType: 'json',
                frame: true,
                maxFileSize: 1,
                add: function (e, data) {
                    obj = $(e.target);
                    SmId = $(e.target).data('itemid');
                    $.each(data.files, function (index, file) {
                        if (file.size && (file.size / 1024 / 1024) > 5) {
                            layer.msg("文件不能大于5M！", { icon: 2 });
                            return;
                        }
                    });
                    data.formData = {
                        SmId: $(e.target).data('itemid')
                    }
                    data.submit();
                },
                error: function (ex, textStatus, errorThrown) {
                    //由于返回的是xml 不能走success的回调函数，在这里做判断。;
                    if (ex.responseText && ex.responseText.toString().indexOf('<status>1</status>') > -1) {
                        layer.msg("上传附件成功。");
                        //如果需要处理 在这里添加函数
                        //获取当前子措施对应的附件列表对象
                        var $ul = obj.closest('.fli');
                        //执行重新绑定附件列表
                        LoadAttchmentList($ul, SmId);
                    }
                    else {
                        layer.msg($(ex.responseText).find("message").text(), { icon: 2 });
                        //如果需要处理 在这里添加函数
                    }
                }
            })
        }

        //加载附件列表信息公用部门（page=10、11）
        //UlObj：需要加载内容的元素对象
        //itemId:措施或子措施ID
        function LoadAttchmentList(UlObj, itemId) {
            //先置空对象的子孙元素
            UlObj.find('li:not(.last)').remove();
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
                                html += '<span title="删除" class="iconfont icon-sv-fail" data-itemid="' + itemId + '" data-attachmentid="' + obj.AttachmentId + '" ></span>';
                                html += '<a title="点击下载" target="_blank" style="color: Blue;text-decoration:none;" href="DownLoadAttachment.aspx?SmId=' + obj.SmId + '&AttachmentId=' + obj.AttachmentId + '" >' + obj.AttachmentName + '</a>';
                                html += '</li>';
                            });
                            //html += '<li class="last"><span class="iconfont icon-sv-add"></span>添加附件<input type="file" name="upload" multiple="multiple" data-itemid="' + itemId + '"></li>';
                            UlObj.find('.last').before(html);
                        }
                    } else {
                        //alert(data.d.message);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                }
            });
        }

        $(document).on('keyup',
            '[name="snCode"]',
            function () {
                var val = $(this).val();
                var newVal = val.replace(/\D+|^0+/ig, '');
                $(this).val(newVal);
            });

        //修改意见提交
        $(document).on('click', '#updateOption', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.tab-pane');
            var postData = [];
            $box.find('tbody tr').each(function () {
                var obj = {}
                $(this).find('input[name],select[name]').each(function () {
                    var name = $(this).attr('name');
                    var val = $(this).val();
                    if (name === 'OpinionType') {
                        obj[name] = $(this).find('option:selected').val();
                    } else {
                        obj[name] = val;
                    }
                })
                postData.push(obj);
            })

            //更新修改意见表单信息
            $.ajax({
                data: JSON.stringify({ modifyOpinion: postData }),
                url: "WebServices/ManagerToolWebService.asmx/UpdateSmFlowItemBaseEntitys",
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.d.status != "1") {
                        layer.msg(data.d.message, { icon: 2 });
                    } else {
                        layer.msg('更新成功。', { icon: 1 });
                        //window.close();
                    }
                },
                error: function (message) {
                    layer.msg('更新失败。', { icon: 2 });
                },
                cache: false
            });

            //后端只需要使用postData即可
            console.log(postData)
        })


    });

    function checkSearch() {
        var inVal = $('#txtSMID').val();

        if (inVal == '') {
            layer.msg('请输入督查编号。', { icon: 2 });
            return false;
        }

        var reg = new RegExp('[@#\$%\^&\*]+', "gi");
        if (reg.test(inVal)) {
            layer.msg('督查编号不能包含特殊字符，例如：！@#￥%&*。', { icon: 2 });
            return false;
        }

        return true;
    }
</script>
