<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="New.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.New" %>

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
        .setting.setting2 {
            text-align:center;
        }
        .main{
            height:800px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="title clearfix">
                <h3 class="caption" style="width: 60px;">新建</h3>
            </div>


            <div class="setting setting2">

                <div class="grid">
                    <a href="NewYear.aspx?smtype=ND&PageType=NewPage" target="_blank">
                        <p>
                            <span class="iconfont icon-sv_check"></span>
                        </p>
                        <strong>年度重点工作任务</strong>
                    </a>
                </div>

                <div class="grid">
                    <a href="LeaderMeetingMission.aspx?smtype=LD&PageType=NewPage" target="_blank">
                        <p>
                            <span class="iconfont icon-sv-text"></span>
                        </p>
                        <strong>领导行政例会督查任务</strong>
                    </a>
                </div>

            </div>

            <div class="setting setting2">

                <div class="grid">
                    <a href="LeaderMeetingMission.aspx?smtype=LD&PageType=NewPage" target="_blank">
                        <p>
                            <span class="iconfont icon-sv-handle-s"></span>
                        </p>
                        <strong>总经理办公会督查任务</strong>
                    </a>
                </div>

                <div class="grid">
                    <%--<a href="newOther.html">--%>
                     <a href="NewYear.aspx?smtype=QT&PageType=NewPage" target="_blank">
                        <p>
                            <span class="iconfont icon-sv-timeout"></span>
                        </p>
                        <strong>其他重要工作任务</strong>
                    </a>
                </div>

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
        //重置高度
        var iFrameResizer = {
			heightCalculationMethod:'lowestElement'
        }
        requirejs(['jquery', 'iframeResizer.contentWindow.min'], function ($) {
            //重置高度
            if ('parentIFrame' in window) {
                setTimeout(parentIFrame.size.bind(parentIFrame,500));
		    }
        });
    </script>
</body>
</html>
