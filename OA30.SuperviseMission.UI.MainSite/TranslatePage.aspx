<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TranslatePage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.TranslatePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>督办系统</title>
    <script src="Script/jquery.js"></script>
    <script type="text/javascript">
        //旧的督办系统
        var GoToOldJdSystem = function () {
            var iframe = parent.frames["launchFrame"];
            var url = "JD/WebPages/Index.aspx";
            if (document.all) {
                //ie
                var href = iframe.location.href
                href = href.replace("SM/TranslatePage.aspx",url);
                iframe.location.href = href;
            }
            else {
                iframe.src = url;
            }
            return;
        };
        //新的督查系统
        var GoToNewSmSystem = function () {
            var tmpUrl = window.location.href;
            var url = tmpUrl.replace("TranslatePage.aspx", "MainPage.aspx");
            window.open(url);
            return;
        };

    </script>
    <style>
        .MainDiv {
            width: 100%;
            height: 400px;
            display: flex;
            flex-basis: auto;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            align-content: center;
            flex-wrap: nowrap;
            margin-top: 200px\0;
            text-align: center\0;
        }

        .Item {
            width: 20%;
            line-height: 50px;
            border: 1px solid #dddbdb;
            border-radius: 5px 5px;
            text-align: center;
            margin: auto 20px;
            cursor: pointer;
            background-color: #ffffff;
            color: #000000;
            display: inline-block\0;
        }


            .Item:hover {
                background-color: #4c80fb;
                color: #ffffff;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="MainDiv">
            <div class="Item" onclick="GoToOldJdSystem()">原督办系统入口</div>
            <div class="Item" onclick="GoToNewSmSystem()">新督查系统入口（部分单位试用）</div>
        </div>
    </form>
</body>
</html>
