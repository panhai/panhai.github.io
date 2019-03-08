<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuperviseMissionExport.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.SuperviseMissionExport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script>

        function toErrorCorrectViewPopUp(h) {
            try {
                var d; var a = $("input[id='eprotalCurrentPageId']").val();
                var f = $("input[id='eprotalCurrentArticleKey']").val();
                var e = $("input[id='eprotalCurrentColumnId']").val();
                var b = window.location.href; b = b.replace(/&/g, "^");
                var g = document.title;
                jQuery.ajax(
                    {
                        type: "POST",
                        dataType: "text",
                        url: "/eportal/ui?moduleId=3&struts.portlet.action=/portlet/errorCorrectFront!getModuleId.action",
                        async: false
                        , error: function (i) { },
                        success: function (i) {
                            d = i;
                            var j = "/eportal/ui?mode=popup&columnId=" + e + "&moduleId=" + d + "&channelId=" + a + "&articleKey=" + f + "&url=" + b + "&title=" + g + "&errorDescribe=" + h + "&struts.portlet.action=/portlet/errorCorrectFront!toView.action";
                            openDialog("toErrorCorrectView", "æ–‡ç« çº é”™ç®¡ç†", j, 800, 300)
                        }
                    })
            }
            catch (c) { }
        }
        function toErrorCorrectView() {
            try {
                var j = "";
                jQuery.ajax(
                    {
                        type: "POST",
                        dataType: "text",
                        url: "/eportal/ui?moduleId=3&struts.portlet.action=/portlet/errorCorrectFront!getPageId.action&pageId=" + $("#eprotalCurrentPageId").val(),
                        async: false,
                        error: function (a) { },
                        success: function (a) {
                            j = a
                        }
                    });
                if (j == "") {
                    alert("æœªæ‰¾åˆ°è¯¥ç«™ç‚¹çº é”™é¡µé¢ï¼");
                    return
                }
                var k = $("input[id='eprotalCurrentPageId']").val();
                var v = $("input[id='eprotalCurrentArticleKey']").val();
                var h = $("input[id='eprotalCurrentColumnId']").val();
                var r = document.createElement("form");
                var i = window.location.href;
                var t = document.title;
                r.method = "post";
                r.target = "_blank";
                r.action = "/eportal/ui?pageId=" + j;
                var u = document.createElement("input");
                u.type = "hidden";
                u.name = "channelId";
                u.value = k;
                r.appendChild(u);
                var s = document.createElement("input");
                s.type = "hidden";
                s.name = "articleKey";
                s.value = v;
                r.appendChild(s);
                var q = document.createElement("input");
                q.type = "hidden";
                q.name = "pageId";
                q.value = j;
                r.appendChild(q);
                var p = document.createElement("input");
                p.type = "hidden";
                p.name = "url";
                p.value = i;
                r.appendChild(p);
                var o = document.createElement("input");
                o.type = "hidden";
                o.name = "title";
                o.value = t;
                r.appendChild(o);
                var n = document.createElement("input");
                n.type = "hidden";
                n.name = "mode";
                n.value = "common";
                r.appendChild(n);
                var m = document.createElement("input");
                m.type = "hidden";
                m.name = "columnId";
                m.value = h;
                r.appendChild(m);
                document.body.appendChild(r);
                r.submit()
            }
            catch (l) {
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
