<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.MainPage" %>
<!DOCTYPE html>
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
    <link rel="stylesheet" type="text/css" href="Css/bootstrap-select.css" />
    <script type="text/javascript">
        //退出系统
        //function quit() { window.location = '/logoff.aspx'; }
        //获取当前用户
        function GetCurrentUser() {
            $.ajax({
                type: 'POST',
                data: '',
                url: 'WebServices/SuperviseMissionWebServices.asmx/GetCurrentUser',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                success: function (data) {
                    var d = data.d;
                    if (d.status == "0") {
                        alert(d.message);
                    } else if (d.status == "1") {
                        var user = JSON.parse(d.data);
                        $("#UserName").html(user.Name);
                    } else {
                        alert(d.message);
                    }
                },
                error: function (xhr, textStatus) {
                    if (textStatus == 'timeout') {
                        alert("获取登录信息超时");
                    } else {
                        alert("获取登录信息失败:" + xhr.responseText);
                    }
                }


            });
        }
    </script>
</head>
<body style="height: 500px">
    <div class="page g-bd1 f-cb">
        <div class="menu-part g-sd1">
            <div class="face-part clearfix f-brc g-face">
                <img src="Image/face.jpg" width="48" height="48"  class="f-fl"/>
                <p class="f-fl">
                    <span id="hello" class="s-fc">早上好</span>，<br />
                    <strong id="UserName" class="f-fs2 s-fc1"></strong>
                </p>
            </div>


            <ul class="list-group g-lst">
                <li class="list-group-item">
                    <%--<a href="ouyangrunfeng/dist/html/pending.html" target="view-frame"><span class="iconfont icon-sv-tag"></span>待处理</a>--%>
                    <a href="Pending.aspx?PageType=WaitingPage&date=<%=(DateTime.Now).ToFileTime().ToString() %>" target="view-frame" id="pending"><span class="iconfont icon-sv-tag"></span>待处理</a>
                </li>

                <li class="list-group-item">
                    <a href="New.aspx?PageType=NewPage" target="view-frame"><span class="iconfont icon-sv-add"></span>新建</a>
                    <%--                    <a href="ouyangrunfeng/dist/html/new.html" target="view-frame"><span class="iconfont icon-sv-add"></span>新建</a>--%>
                </li>

                <li class="list-group-item">
                    <a href="SuperviseMissionIndex.aspx?PageType=MissionIndexPage&date=<%=(DateTime.Now).ToFileTime().ToString() %>" target="view-frame" id="task"><span class="iconfont icon-sv-home"></span>督查任务</a>
                </li>

                <li class="list-group-item">
                    <a href="Statistics/SmMainListStatistics.aspx?PageType=ReportPage" target="view-frame"><span class="iconfont icon-sv-pager-s"></span>报表</a>
                </li>

                <li class="list-group-item">
                    <a href="BasicData/Index.aspx?PageType=BasicDataNormalPage" target="view-frame"><span class="iconfont icon-sv-setting"></span>管理</a>
                </li>

                <li class="list-group-item">
                    <a id="quit" style="cursor: pointer;"><span class="iconfont icon-sv-off"></span>退出</a>
                </li>

            </ul>

        </div>
        <div class="iframe-part g-mn1">
            <div id="frame" class="g-mn1c">

            </div>
        </div>
    </div>

    <script src="Script/require.js"></script>
<script type="text/javascript">
     var fDepts = []
    require.config({
        urlArgs: 'ver=' + (new Date).getTime(),
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
    require(['jquery', 'toast', 'state'], function ($, layer, state) {
       
        $(function () {
            //获取用户信息
            GetCurrentUser();

            //显示问候语
            var hello = document.getElementById('hello');
            var date = new Date();
            var hour = date.getHours();
            var minute = date.getMinutes();
            var arr = [6, 12, 18, 24]
            hello.innerHTML = hour >= 0 && hour < 6 ? '凌晨好' : (hour >= 6 && hour < 13 ? '上午好' : (hour >= 13 && hour < 19 ? '下午好' : (hour >= 19 && hour < 24 ? '晚上好' : '凌晨好')));

            //ajax加载，弃用iframe
            var index = layer.load(0, { shade: false });
            $.get('Pending.aspx?PageType=WaitingPage&version='+(new Date()).getTime(), function (html) {
                layer.close(index);     
                $('#frame').html(html);
            })
            //点击左侧菜单
            $(document).on('click', '.list-group .list-group-item a', function (e) {
                //退出登陆
                if ($(e.target).attr('id') === 'quit') {
                    window.location = '/logoff.aspx';
                    return;
                }
                e.stopPropagation();
                e.preventDefault();
                var href = $(this).attr('href');
                var index = layer.load(0, { shade: false });
                $('#frame').empty();
                $.get(href, function (html) {
                    layer.close(index);     
                    $('#frame').html(html);
                });
            });

            //管理新建页面加载
            $(document).on('click', '.setting .grid a', function (e) {
                e.stopPropagation();
                e.preventDefault();
                var index = layer.load(0, { shade: false });
                var href = 'BasicData/' + $(this).attr('href') + '?version=' + (new Date).getTime();
                var box = $(e.target).closest('.setting');
                $('#frame').empty();
                if (box.hasClass('setting2')) {
                    href = $(this).attr('href');
                    window.open(href);
                    href = 'New.aspx'
                } else {
                    if ($(this).attr('target') === '_blank') {
                        href = $(this).attr('href');
                        window.open(href);
                        href = 'BasicData/Index.aspx?version='+(new Date).getTime()+'#super'
                    }
                }
                $.get(href, function (html) {
                        layer.close(index);
                        $('#frame').html(html);
                    });
            })
            
            //管理返回
            $(document).on('click', '.top-nav a', function (e) {
                e.stopPropagation();
                e.preventDefault();
                var href = 'BasicData/' + $(this).attr('href');
                var uri = href.split('#');
                var index = layer.load(0, { shade: false });
                $('#frame').empty();
                $.get(href, function (html) {
                    layer.close(index);
                    $('#frame').html(html);
                    if (uri[1]) {
                        $('#' + uri[1] + 'link').parent().addClass('active').siblings().removeClass('active');
                        $('#' + uri[1]).addClass('active').siblings().removeClass('active');
                    }
                });
            })

            //加载部门
            initDept();
            function initDept() {
                $.ajax({
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetAllActiveDeptList",
                    type: "post",
                    dataType: "xml",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    success: function (data) {
                        var dept = JSON.parse($(data).find("data").text());
                        state.setfDept(dept)
                        fDepts = dept;
                    },
                    error: function (message) {
                        alert("获取部门列表失败！");
                    }
                });
            }
        })
    })
    </script>
</body>
</html>
