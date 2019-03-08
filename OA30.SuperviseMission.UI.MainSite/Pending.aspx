<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pending.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.Pending" %>

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
        .list-part .list-box li .t {
            position: absolute;
            right: 30px;
        }

        .list-part .list-box li, .list-part {
            padding-bottom: 0;
        }

        .list-part {
            margin-top: 0;
            padding-top: 0;
            padding-bottom: 10px;
            margin-left: -10px;
        }

            .list-part .title {
                padding: 0;
                margin-bottom: 5px;
                margin-top: 8px;
                padding-bottom: 10px;
            }

            .list-part .list-box li .t {
                font-size: 12px;
                position:absolute;
                right:0;
                top:5px;
            }

            .list-part .list-box li ins {
                margin: 0 -15px 0 -8px;
            }

            .list-part .list-box li input {
                vertical-align: middle;
                margin-top: 0;
            }

            .list-part .list-box li {
                padding-bottom: 0;
                padding-top: 0;
                line-height: 30px;
                height: 35px;
                border-bottom: 1px dashed #ededed;
                position:relative;
            }
            .list-part .list-box li a{
                   display: inline-block;
                    width: 85%;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                    overflow: hidden;
                    vertical-align: middle;
        }
                .list-part .list-box li span {
                    width:100%;
                    display:inline;
                }
        .list-part {
            min-height: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="list-part">
                <div class="title">
                    <h3>年度重点工作任务</h3>
                    <div class="poa" style="<%=DisplayType%>">
                        <label>
                            <input type="checkbox" name="" data-checked="#box1" />
                            全选
                        </label>
                        <button class="btn btn-primary-s" name="btnAgree" id="btnNDSend">同意发送</button>
                    </div>
                </div>
                <ul class="list-box list-unstyled" id="box1">
                    <asp:Repeater ID="RpNDJob" runat="server">
                        <ItemTemplate>
                            <li style="display: block">
                                <input type="checkbox" name="" data-smid="<%#Eval("SM_ID") %>" data-flowid="<%#Eval("FLOW_ID") %>">
                                <a href="<%#(Eval("SUB_TYPE").ToString()=="YQ"
                                             ||Eval("SUB_TYPE").ToString()=="BJ"
                                             ||Eval("SUB_TYPE").ToString()=="ZZ"
                                             ||Eval("SUB_TYPE").ToString()=="TZ")?"SuperviseMissionDelayModifyEndChangeAudit.aspx":"SuperviseMissionDetail.aspx" %>?smid=<%#Eval("SM_ID") %>&flowid=<%#Eval("FLOW_ID") %>&smtype=<%#Eval("SM_TYPE") %>&stepid=<%#Eval("STEP_ID") %>&subtype=<%#Eval("SUB_TYPE") %>&pagetype=FormPage"
                                    target="blank">
                                    <%-- <ins>【<%#MissionStatusStr(Eval("MISSION_STATUS").ToString()) %>】</ins>--%>
                                    <ins>【<b data-subtype="<%#Eval("SUB_TYPE") %>" class="dataSubType fw5"></b><%#Eval("STEP_NAME") %>】</ins>
                                    <span>
                                        <span class="c">【<%#Eval("CREATOR_VISIBLE_DEPT_NAME") %>】</span>
                                        <%#Eval("TASK_CONTENT") %>
                                    </span>
                                    <span class="t"><%#Eval("RECEIVE_TIME") %></span>
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div class="list-part">
                <div class="title">
                    <h3>领导行政例会督查</h3>
                    <div class="poa" style="<%=DisplayType%>">
                        <label>
                            <input type="checkbox" name="" data-checked="#box2" />
                            全选
                        </label>
                        <button class="btn btn-primary-s" name="btnAgree" id="btnLDSend">同意发送</button>
                    </div>
                </div>
                <ul class="list-box list-unstyled" id="box2">
                    <asp:Repeater ID="RpLDJob" runat="server">
                        <ItemTemplate>
                            <li style="display: block">
                                <input type="checkbox" name="" data-smid="<%#Eval("SM_ID") %>" data-flowid="<%#Eval("FLOW_ID") %>">
                                <a href="<%#(Eval("SUB_TYPE").ToString()=="YQ"
                                             ||Eval("SUB_TYPE").ToString()=="BJ"
                                             ||Eval("SUB_TYPE").ToString()=="ZZ"
                                             ||Eval("SUB_TYPE").ToString()=="TZ")?"LeaderMeetingMissionChangeModifyAudit.aspx":"LeaderMeetingMissionDetail.aspx" %>?smid=<%#Eval("SM_ID") %>&flowid=<%#Eval("FLOW_ID") %>&smtype=<%#Eval("SM_TYPE") %>&stepid=<%#Eval("STEP_ID") %>&subtype=<%#Eval("SUB_TYPE") %>&pagetype=FormPage" target="blank">
                                    <%-- <ins>【<%#MissionStatusStr(Eval("MISSION_STATUS").ToString()) %>】</ins>--%>
                                    <ins>【<b data-subtype="<%#Eval("SUB_TYPE") %>" class="dataSubType fw5"></b><%#Eval("STEP_NAME") %>】</ins>
                                    <span>
                                        <span class="c">【<%#Eval("CREATOR_DEPT_NAME") %>】</span>
                                        <%#Eval("TASK_CONTENT") %>
                                    </span>
                                    <span class="t"><%#Eval("RECEIVE_TIME") %></span>
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div class="list-part">
                <div class="title">
                    <h3>总经理办公会督查</h3>
                    <div class="poa" style="<%=DisplayType%>">
                        <label>
                            <input type="checkbox" name="" data-checked="#box3" />
                            全选
                        </label>
                        <button class="btn btn-primary-s" name="btnAgree" id="btnZJSend">同意发送</button>
                    </div>
                </div>
                <ul class="list-box list-unstyled" id="box3">
                    <asp:Repeater ID="RpZJJob" runat="server">
                        <ItemTemplate>
                            <li style="display: block">
                                <input type="checkbox" name="" data-smid="<%#Eval("SM_ID") %>" data-flowid="<%#Eval("FLOW_ID") %>">
                                <a href="SuperviseMissionDetail.aspx?smid=<%#Eval("SM_ID") %>&flowid=<%#Eval("FLOW_ID") %>&smtype=<%#Eval("SM_TYPE") %>&stepid=<%#Eval("STEP_ID") %>&pagetype=FormPage" target="blank">
                                    <%-- <ins>【<%#MissionStatusStr(Eval("MISSION_STATUS").ToString()) %>】</ins>--%>
                                    <ins>【<%#Eval("STEP_NAME") %>】</ins>
                                    <span>
                                        <span class="c">【<%#Eval("CREATOR_DEPT_NAME") %>】</span>
                                        <%#Eval("TASK_CONTENT") %>
                                    </span>
                                    <span class="t"><%#Eval("RECEIVE_TIME") %></span>
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div class="list-part">
                <div class="title">
                    <h3>其他重要工作督查</h3>
                    <div class="poa" style="<%=DisplayType%>">
                        <label>
                            <input type="checkbox" name="" data-checked="#box4" />
                            全选
                        </label>
                        <button class="btn btn-primary-s" name="btnAgree" id="btnQTSend">同意发送</button>
                    </div>
                </div>
                <ul class="list-box list-unstyled" id="box4">
                    <asp:Repeater ID="RpQTJob" runat="server">
                        <ItemTemplate>
                            <li style="display: block">
                                <input type="checkbox" name="" data-smid="<%#Eval("SM_ID") %>" data-flowid="<%#Eval("FLOW_ID") %>">
                                <a href="SuperviseMissionDetail.aspx?smid=<%#Eval("SM_ID") %>&flowid=<%#Eval("FLOW_ID") %>&smtype=<%#Eval("SM_TYPE") %>&stepid=<%#Eval("STEP_ID") %>&pagetype=FormPage" target="blank">
                                    <%--   <ins>【<%#MissionStatusStr(Eval("MISSION_STATUS").ToString()) %>】</ins>--%>
                                    <ins>【<%#Eval("STEP_NAME") %>】</ins>
                                    <span>
                                        <span class="c">【<%#Eval("CREATOR_DEPT_NAME") %>】</span>
                                        <%#Eval("TASK_CONTENT") %>
                                    </span>
                                    <span class="t"><%#Eval("RECEIVE_TIME") %></span>
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </form>
    <script src="Script/require.js"></script>
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
        
        requirejs(['jquery', 'bootstrap', 'mustache', 'picker'], function ($) {
            

            $(document).on('click', "[type='checkbox']", function (e) {
                var target = $(e.target);
                var checked = target.data('checked');
                if (checked) {
                    if (target.is(':checked')) {
                        $(checked).find('input[type="checkbox"]').prop('checked', true);
                    } else {
                        $(checked).find('input[type="checkbox"]').removeAttr('checked');
                    }
                }
            });

            var allSubType = $(".dataSubType");
            for (var i = 0; i < allSubType.length; i++) {
                if ($(allSubType[i]).data().subtype === "ZZ") {
                    $(allSubType[i]).html("变更(中止)");
                } else if ($(allSubType[i]).data().subtype === "YQ") {
                    $(allSubType[i]).html("变更(延期)");
                } else if ($(allSubType[i]).data().subtype === "TZ") {
                    $(allSubType[i]).html("变更(调整)");
                } else if ($(allSubType[i]).data().subtype === "BJ") {
                    $(allSubType[i]).html("变更(办结)");
                }
            }

            $(document).on('click', "[name='btnAgree']", function (e) {
                var target = e.target.id;
                var actionType = { "btnNDSend": "box1", "btnLDSend": "box2", "btnZJSend": "box3", "btnQTSend": "box4" };
                var jobId = actionType[target];
                var postListItem = $("#" + jobId + " :checked");
                if (postListItem.length < 1) {
                    alert("请选择要审批的任务");
                    return;
                }
                var itemList = [];
                for (var i = 0; i < postListItem.length; i++) {
                    var $item = $(postListItem[i]);
                    var smid = $item.data("smid");
                    var flowid = $item.data("flowid");
                    itemList.push({ smid: smid, flowid: flowid });
                }
                $.ajax({
                    type: "POST",
                    data: JSON.stringify({ items: itemList }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/AgreeAllTask",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            alert(data.d.message);
                            window.location.reload();
                        } else {
                            alert(data.d.message);
                        }
                    },
                    error: function (xhr, textStatus) {
                        alert("请求发生异常");
                    }
                });
            });
            //href在ie会弹窗
            $('.list-part li a').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                var $this = $(this);
                var href = $this.attr('href');
                window.open(href);
            })
        })
    </script>
</body>
</html>
