<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.BasicData.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查系统</title>
    <style type="text/css">
        .list-part {
            height: 800px;
            margin-top: -10px;
        }
    </style>
</head>
<body>

    <div class="main">
        <div class="list-part">

            <ul class="nav nav-tabs" role="tablist">


                <li role="presentation" class="active"><a id="personallink" href="#personal" aria-controls="personal" role="tab" data-toggle="tab">个人设置</a></li>



                <li role="presentation"><a id="departmentlink" href="#department" aria-controls="department" role="tab" data-toggle="tab">部门管理员</a></li>



                <li role="presentation"><a id="superlink" href="#super" aria-controls="super" role="tab" data-toggle="tab">超级管理员</a></li>



                <li role="presentation"><a id="parameterlink" href="#parameter" aria-controls="parameter" role="tab" data-toggle="tab">参数配置</a></li>


            </ul>

            <div class="tab-content">


                <div role="tabpanel" class="tab-pane setting active" id="personal">

                    <div class="grid">
                        <a href="SmBasicDataAuthorizeManage.aspx?PageType=BasicDataNormalPage">
                            <p>
                                <span class="iconfont icon-sv-pen"></span>
                            </p>
                            <strong>督查委托</strong>
                        </a>
                    </div>

                    <div class="grid">
                        <a href="SmBasicDataPersonalDeptGroupManage.aspx?PageType=BasicDataNormalPage">
                            <p>
                                <span class="iconfont icon-sv-pen"></span>
                            </p>
                            <strong>个人部门组设置</strong>
                        </a>
                    </div>

                </div>


                <% if (IsSuperManager || IsDeptManager)
                    { %>
                <div role="tabpanel" class="tab-pane setting " id="department">

                    <div class="grid">
                        <a href="SmBasicDtataDeptRoleManage.aspx?PageType=DeptManagePage">
                            <p>
                                <span class="iconfont icon-sv-pen"></span>
                            </p>
                            <strong>部门角色设置</strong>
                        </a>
                    </div>

                    <div class="grid">
                        <a href="SmBasicDtataDeptDefaultLeaderManage.aspx?PageType=DeptManagePage">
                            <p>
                                <span class="iconfont icon-sv-pen"></span>
                            </p>
                            <strong>部门默认领导</strong>
                        </a>
                    </div>


                    <div class="grid">
                        <a href="SmBasicDataSuperviseNumberManage.aspx?PageType=DeptManagePage">
                            <p>
                                <span class="iconfont icon-sv-pen"></span>
                            </p>
                            <strong>督查字号</strong>
                        </a>
                    </div>

                    <div class="grid">
                        <a href="SmBasicDataDeptAuthorizationManage.aspx?PageType=DeptManagePage">
                            <p>
                                <span class="iconfont icon-sv-pen"></span>
                            </p>
                            <strong>部门管理员授权</strong>
                        </a>
                    </div>

                </div>
                <% }
                    else
                    { %>
                <div role="tabpanel" class="tab-pane setting " id="department">
                    <div class="error-box">
                        <div class="error-icon"></div>
                        <p class="error-message">您没有访问该页面的权限，系统不允许进行相关操作。</p>
                    </div></div>
                    <% } %>




                    <% if (IsSuperManager)
                        { %>
                    <div role="tabpanel" class="tab-pane setting " id="super">

                        <div class="grid" id="operation-authorization">
                            <a href="SmBasicDataOperationAuthorizationManage.aspx?PageType=SupserManagePage">
                                <p>
                                    <span class="iconfont icon-sv-pen"></span>
                                </p>
                                <strong>运维管理员授权</strong>
                            </a>
                        </div>

                        <div class="grid">
                            <a href="SmOpreationLogManage.aspx?PageType=SupserManagePage">
                                <p>
                                    <span class="iconfont  icon-sv-pen "></span>
                                </p>
                                <strong>督查日志</strong>
                            </a>
                        </div>

                        <div class="grid">
                            <a href="SuperivseMissionFormManage.aspx?PageType=FormManagePage" target="_blank">
                                <p>
                                    <span class="iconfont  icon-sv-pen "></span>
                                </p>
                                <strong>运维管理员工具</strong>
                            </a>
                        </div>
                    </div>
                    <% }
                        else
                        { %>
                    <div role="tabpanel" class="tab-pane setting " id="super">
                        <div class="error-box">
                            <div class="error-icon"></div>
                            <p class="error-message">您没有访问该页面的权限，系统不允许进行相关操作。</p>
                        </div></div>
                        <% } %>



                        <% if (IsSystemManager)
                            { %>
                        <div role="tabpanel" class="tab-pane setting " id="parameter">

                            <div class="grid">
                                <a href="SmSystemStepManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>步骤定义</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmSystemRoleManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>角色定义</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmSystemStepRoleManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>步骤角色定义</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmSystemWorkFlowFreeManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>自由流程定义</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmSystemWorkFlowStaticManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>固定流程定义</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmSystemWorkFlowStaticDetailManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>固定流程配置</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>系统参数设置</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmBasicDataOpinionTypeManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>意见类型</strong>
                                </a>
                            </div>

                            <div class="grid">
                                <a href="SmSystemTypeDefintionManage.aspx?PageType=SystemManagePage">
                                    <p>
                                        <span class="iconfont icon-sv-pen"></span>
                                    </p>
                                    <strong>文件类型</strong>
                                </a>
                            </div>
                        </div>
                        <% }
                            else
                            { %>
                        <div role="tabpanel" class="tab-pane setting " id="parameter">
                            <div class="error-box">
                                <div class="error-icon"></div>
                                <p class="error-message">您没有访问该页面的权限，系统不允许进行相关操作。</p>
                            </div></div>
                            <% } %>
                        </div>
        </div>
    </div>
            
</body>
</html>

<div class="modal fade" tabindex="-1" role="dialog" id="leader">
    <div class="modal-dialog" role="document" style="width: 340px;margin:30px auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">选择主管领导</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <input type="text" class="form-control" id="leader-input1" placeholder="请输入员工号或姓名" />
                    <div class="input-group-addon">
                        <span class="iconfont icon-sv-search"></span>
                    </div>
                </div>
                <div class="choose-area">

                    <ul class="list-unstyled">

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>张三</label>
                            <input type="checkbox" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>李四</label>
                            <input type="checkbox" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>王五</label>
                            <input type="checkbox" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>周六</label>
                            <input type="checkbox" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>林七</label>
                            <input type="checkbox" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>毛八</label>
                            <input type="checkbox" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>吴九</label>
                            <input type="checkbox" />
                        </li>

                    </ul>
                </div>
                <div class="result-area">
                </div>
                <div class="form-group tac">
                    <button type="button" class="btn btn-primary-c">确定</button>
                    <button type="button" class="btn btn-default-c" data-dismiss="modal">重置</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade company-modal" tabindex="-1" role="dialog" id="company">
    <div class="modal-dialog" role="document" style="width: 610px;margin:30px auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">选择主办单位</h4>
            </div>
            <div class="modal-body">
                <div class="clearfix">
                    <div class="col-sm-6 col">
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" class="form-control" id="leader-input" placeholder="选择部门">
                                <div class="input-group-addon">
                                    <span class="iconfont icon-sv-search"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col">
                        <div class="form-group dropdown">
                            <div class="input-group">
                                <input type="text" class="form-control" id="leader-input2" placeholder="选择自定义组" />
                                <div class="input-group-addon" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="iconfont icon-sv-arrow-down"></span>
                                </div>
                                <ul class="dropdown-menu" aria-labelledby="dLabel">
                                    <li>
                                        <input type="checkbox" name="" /><label>自定义组</label></li>
                                    <li>
                                        <input type="checkbox" name="" /><label>自定义组</label></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="choose-area" id="chooseArea">

                    <ul class="list-unstyled">

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航飞行部</label>
                            <input type="checkbox" value="1" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航信息中心</label>
                            <input type="checkbox" value="2" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航财务部</label>
                            <input type="checkbox" value="4" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航飞行保障部</label>
                            <input type="checkbox" value="3" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航后勤部</label>
                            <input type="checkbox" value="5" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航培训部</label>
                            <input type="checkbox" value="6" />
                        </li>

                        <li>
                            <span class="iconfont icon-sv-user"></span>
                            <label>南航客舱部</label>
                            <input type="checkbox" value="7" />
                        </li>

                    </ul>
                </div>
                <div class="result-area" id="resultArea">
                </div>
                <div class="form-group tac">
                    <button type="button" class="btn btn-primary-c">确定</button>
                    <button type="button" class="btn btn-default-c" data-dismiss="modal">重置</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="Script/require.js"></script>
<script type="text/javascript">
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

    require(['jquery', 'bootstrap'],
        function ($) {

            $('.nav').on('shown.bs.tab', function (e) {
                if ('parentIFrame' in window) {
                    setTimeout(parentIFrame.size.bind(parentIFrame, 500));
                }
            })


            init();
            function init() {
                var id = window.location.hash;
                if (id !== "") {
                    $(id).show().siblings().hide();
                    $('.nav-tabs').find('[href="' + id + '"]').parent().addClass('active').siblings().removeClass('active');
                }
            };


        });

    $('.error-box').css('display', 'none');
    $("a[data-toggle='tab']").on('click', function (e) {
        var tabHref = $(this).attr("href");
        $('.error-box').css('display', 'none');
        $(tabHref).children('.error-box').css('display', 'block');
    })


</script>
