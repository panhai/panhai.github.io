<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewYear.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.NewYear" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>督查系统-<%=LbHeader%></title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <link rel="stylesheet" type="text/css" href="Css/smtheme.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="title clearfix">
                <h3 class="caption"><%=LbHeader%></h3>
                <div class="action">
                    <button type="button" class="btn btn-default-s"><span class="iconfont icon-sv-download"></span>下载模板</button>
                    <button type="button" class="btn btn-default-s"><span class="iconfont icon-sv-import"></span>导入</button>
                </div>
            </div>
            <div class="form-box form-horizontal">
                <div class="form-group form-customer">
                    <label class="col-lg-1 col-sm-1 col-xs-1 col-md-1 control-label">督查编号</label>
                    <div class="col-lg-7 col-sm-7 col-md-7 col-xs-7">
                        <asp:DropDownList ID="DDL_SP_NUMBER_NAME" runat="server" class="form-control dbi">
                        </asp:DropDownList>
                        <select id="DDL_SP_NUMBER_YEAR" class="form-control dbi">
                        </select>
                        <asp:TextBox ID="Tb_SP_NUMBER_CODE" runat="server" Text="" class="form-control dbi" disabled="disabled"></asp:TextBox>
                        号
                    </div>
                    <div class="col-lg-4 col-md-4 col-xs-4 col-sm-4" style="position:relative">
                        <label class="dbi fw5" style="position:absolute">文件ID</label>
                        <asp:TextBox ID="Tb_SM_ID" runat="server" Text="" class="form-control dbi" disabled="disabled" placeholder="后台自动生成" style="width:95%;margin-left:50px;"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">任务内容</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <asp:TextBox ID="Tb_TASK_CONTENT" runat="server" class="form-control" placeholder="请输入任务内容" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">主管领导</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <asp:TextBox ID="Tb_MainLeader" ReadOnly="true" runat="server" class="form-control" placeholder="请输入主管领导" data-toggle="modal" data-target="#mainLeader"></asp:TextBox>
                        <span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#mainLeader" data-tag="mainLeader"></span>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">协管领导</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <asp:TextBox ID="Tb_AssLeader" ReadOnly="true" runat="server" class="form-control" placeholder="请输入协管领导" data-toggle="modal" data-target="#assLeader"></asp:TextBox>
                        <span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#assLeader" data-tag="assLeader"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">主办单位</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <asp:TextBox ID="Tb_MainDept" ReadOnly="true" runat="server" class="form-control" placeholder="请输入主办单位" data-toggle="modal" data-target="#companyMain" data-tag="companyMain"></asp:TextBox>
                        <span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#companyMain" data-tag="companyMain"></span>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">协办单位</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <asp:TextBox ID="Tb_AssDept" runat="server" ReadOnly="true" class="form-control" placeholder="请输入协办单位" data-toggle="modal" data-target="#companyAssi" data-tag="companyAssi"></asp:TextBox>
                        <span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#companyAssi" data-tag="companyAssi"></span>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label"></label>
                    <asp:Label ID="LbMessage" runat="server" Text="" ForeColor="Red" style="padding-left:20px;"></asp:Label>
                </div>
                <div class="form-group tac">
                    <asp:Button ID="BtSave" runat="server" Text="确定" class="btn btn-primary-c" OnClick="BtSave_Click" />
                    <button id="btResetAll" type="button" class="btn btn-default-c">重置</button>
                </div>
            </div>
        </div>
        <div class="modal" tabindex="-1" role="dialog" id="mainLeader" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document" style="width: 600px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">选择主管领导</h4>
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <input type="text" class="form-control" id="textMainLeader" placeholder="请输入员工号或姓名" />
                            <div class="input-group-addon" id="btSearchMainLeader">
                                <span class="iconfont icon-sv-search"></span>
                            </div>
                        </div>
                        <div class="choose-area">
                            <ul class="list-unstyled" id="ulMainLeader">
                            </ul>
                        </div>
                        <div id="mainLeaderSelectedList" class="result-area" data-value="" data-text=""></div>
                    </div>
                    <div class="form-group tac">
                        <button id="btConfirmSelectMianLeader" type="button" class="btn btn-primary-c">确定</button>
                        <button id="btResetSelectMainLeader" type="button" class="btn btn-default-c" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
         <div class="modal" tabindex="-1" role="dialog" id="assLeader" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document" style="width: 600px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">选择协管领导</h4>
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <input type="text" class="form-control" id="textAssLeader" placeholder="请输入员工号或姓名" />
                            <div class="input-group-addon" id="btSearchAssLeader">
                                <span class="iconfont icon-sv-search"></span>
                            </div>
                        </div>
                        <div class="choose-area">
                            <ul class="list-unstyled" id="ulAssLeader">
                            </ul>
                        </div>
                        <div id="assLeaderSelectedList" class="result-area" data-value="" data-text=""></div>
                    </div>
                    <div class="form-group tac">
                        <button id="btConfirmSelectAssLeader" type="button" class="btn btn-primary-c">确定</button>
                        <button id="btResetSelectAssLeader" type="button" class="btn btn-default-c" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal company-modal" tabindex="-1" role="dialog" id="companyMain" data-backdrop="static" data-keyboard="false">
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
                                        <input type="text" class="form-control" id="txtMainDept" placeholder="选择部门" />
                                        <div class="input-group-addon" id="btSearchMainDept">
                                            <span class="iconfont icon-sv-search"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col">
                                <div class="form-group dropdown">
                                    <select id="myGroupDept1" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="choose-area">
                            <ul class="list-unstyled" id="ulMainDept">
                            </ul>
                        </div>
                        <div class="result-area" id="mainDeptList" data-value="" data-text="">
                        </div>
                        <div class="form-group tac">
                            <button type="button" class="btn btn-primary-c" id="btConfirmMainDept">确定</button>
                            <button type="button" class="btn btn-default-c" data-dismiss="modal" id="btResetMainDept">取消</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal company-modal" tabindex="-1" role="dialog" id="companyAssi" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document" style="width: 610px;margin:30px auto;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">选择协办单位</h4>
                    </div>
                    <div class="modal-body">
                        <div class="clearfix">
                            <div class="col-sm-6 col">
                                <div class="form-group">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtAssDept" placeholder="选择部门" />
                                        <div class="input-group-addon" id="btSearchAssDept">
                                            <span class="iconfont icon-sv-search"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col">
                                <div class="form-group dropdown">
                                    <select id="myGroupDept2" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="choose-area" id="chooseArea">
                            <ul class="list-unstyled" id="ulAssDept">
                            </ul>
                        </div>
                        <div class="result-area" id="assDeptList" data-value="" data-text="">
                        </div>
                        <div class="form-group tac">
                            <button id="btConfirmAssDept" type="button" class="btn btn-primary-c">确定</button>
                            <button id="btResetAssDept" type="button" class="btn btn-default-c" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdYear" runat="server" />
        <asp:HiddenField ID="hdTempYear" runat="server" />
        <asp:HiddenField ID="hdCode" runat="server" />
        <asp:HiddenField ID="hdTempCode" runat="server" />
        <asp:HiddenField ID="hdEmpid" runat="server" />
        <asp:HiddenField ID="hdEmpName" runat="server" />
        <asp:HiddenField ID="hdMainLeaderNames" runat="server" />
        <asp:HiddenField ID="hdMainLeaderIds" runat="server" />
        <asp:HiddenField ID="hdAssLeaderNames" runat="server" />
        <asp:HiddenField ID="hdAssLeaderIds" runat="server" />
        <asp:HiddenField ID="hdMainDeptNames" runat="server" />
        <asp:HiddenField ID="hdMainDeptIds" runat="server" />
        <asp:HiddenField ID="hdAssDeptNames" runat="server" />
        <asp:HiddenField ID="hdAssDeptIds" runat="server" />
        <asp:HiddenField ID="hdCurSelectedNumberName" runat="server" />
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
        requirejs(['jquery', 'bootstrap', 'mustache', 'picker','toast'], function ($) {
            //弹窗多选
            $('#companyAssi').on('shown.bs.modal', function (e) {
                $('#txtMainDept,#txtAssDept').val('');
                $('#textMainLeader,#textAssLeader').val('');
                //var self = $(e.target).find('.result-area')
                //var area = self.data(area)
                //if (area.area) {
                //    self.html(area.area.join(';'));
                //} else {
                //    self.empty();
                //}
            });
            $('#company').on('shown.bs.modal', function (e) {
                $('#txtMainDept,#txtAssDept').val('');
                $('#textMainLeader,#textAssLeader').val('');
                //var self = $(e.target).find('.result-area')
                //var area = self.data(area)
                //if (area.area) {
                //    self.html(area.area.join(';'));
                //} else {
                //    self.empty();
                //}
            });
            var init = {
                //设置年号默认值
                setDefaultSPNameCode: function () {
                    var tempYearList = $("#hdTempYear").val().split(',');
                    if (tempYearList.length > 0) {
                        var str = "";
                        var selectYear = $("#hdYear").val();
                        for (var i = 0; i < tempYearList.length; i++) {
                            if (selectYear == tempYearList[i])
                                str += "<option selected='selected'>" + tempYearList[i] + "</option>";
                            else
                                str += "<option>" + tempYearList[i] + "</option>";
                        }
                        $("#DDL_SP_NUMBER_YEAR").html(str);
                    }
                    $("#Tb_SP_NUMBER_CODE").val($("#hdCode").val());
                },
                //加载主办单位、协办单位数据
                loadAllDeptData: function (ids) {
                    $.ajax({
                        type: "POST",
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetAllDeptListNoContainAll",
                        contentType: 'application/json;charset=utf-8',
                        dataType: "json",
                        success: function (data) {
                            if (data.d.status == "1") {
                                var jp = JSON.parse(data.d.data);
                                render.renderDeptList(jp, ids);//主办单位、协办单位
                                for (var item in ids) {
                                    eventChange.deptSelectChange(ids[item]);
                                }
                            } else {
                                layer.msg(data.d.message, { icon:2,time:1000});
                            }
                        },
                        error: function (xhr, textStatus) {
                            layer.msg("请求发生异常。", { icon:2,time:1000});
                        }
                    });
                },
                
                //根据名称查询部门
                loadDeptDataByName: function (name, ids) {
                    $.ajax({
                        type: "POST",
                        data: JSON.stringify({ name: name }),
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetDeptListByName",
                        contentType: 'application/json;charset=utf-8',
                        dataType: "json",
                        success: function (data) {
                            if (data.d.status == "1") {
                                var jp = JSON.parse(data.d.data);
                                render.renderDeptList(jp, ids);//主办单位、协办单位
                                for (var item in ids) {
                                    eventChange.deptSelectChange(ids[item]);
                                }
                            } else {
                                layer.msg(data.d.message, { icon:2,time:1000});
                            }
                        },
                        error: function (xhr, textStatus) {
                           layer.msg("请求发生异常。", { icon:2,time:1000});
                        }
                    });
                },
                //加载我的部门地址组
                loadMyDeptGroup: function () {
                    $.ajax({
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetGroupListByUser2",
                        type: "post",
                        dataType: "json",
                        contentType: 'application/json;charset=utf-8',
                        success: function (data) {
                            if (data.d.status == "1") {
                                var list = data.d.List;
                                render.renderMyGroupDeptList(list, ["myGroupDept1"]);
                                render.renderMyGroupDeptList(list, ["myGroupDept2"])
                                eventChange.myGroupDeptSelectChange();
                            } else {
                                layer.msg(data.d.message, { icon:2,time:1000});
                            }
                        },
                        error: function (xhr, textStatus) {
                            layer.msg("获取部门组列表失败！", { icon:2,time:1000});
                        }
                    });
                },
            }
            //渲染html页面函数
            var render = {
                //渲染部门列表
                renderDeptList: function (data, ids) {
                    var html = "";
                    var value = $('#' + ids).closest('.choose-area').next('.result-area').data('value')
                    for (var i = 0; i < data.length; i++) {
                        var inputChecked = '<input type="checkbox" value="1" />'
                        if (value.indexOf(data[i].DeptId) > -1) {
                           inputChecked = '<input checked type="checkbox" value="1" />'
                        }
                        if (data[i].DeptName !== '' && data[i].DeptId !== '0') {
                            html += '<li data-deptname=' + data[i].DeptName + ' data-deptid=' + data[i].DeptId + '><div class="checkbox"><label><span class="iconfont icon-sv-tree"></span>' + data[i].DeptName + inputChecked + '</label></div></li>';
                        }
                    }
                    for (var item in ids) {
                        $("#" + ids[item]).empty().append(html);
                    }
                },
                //渲染领导（员工）列表
                renderLeaderList: function (data, ids) {
                    var html = "";
                    for (var i = 0; i < data.length; i++) {
                        var input = '<input type="checkbox" />';
                        if ($('#' + ids).closest('.choose-area').next().find('[data-empid="' + data[i].Employee_ID + '"]').length > 0) {
                            input = '<input type="checkbox" checked="true"/>';
                        }
                        html += ' <li data-name=' + data[i].Name + ' data-empid=' + data[i].Employee_ID + '><div class="checkbox"><label><span class="iconfont icon-sv-user"></span>' + data[i].Name + "（" + data[i].Employee_ID + "）-" + data[i].Dept_Name + input + '</label></div>';
                    }
                    for (var item in ids) {
                        $("#" + ids[item]).empty().append(html);
                    }
                },
                //渲染个人地址组
                renderMyGroupDeptList: function (data, ids) {
                    var html = "<option value=''>全部</option>";
                    for (var i = 0; i < data.length; i++) {
                        html += "<option value='" + data[i].GroupId + "'>" + data[i].GroupName + "</option>";
                    }
                    for (var item in ids) {
                        $("#" + ids[item]).empty().append(html);
                    }
                },
            }
            //回车查询
            $(document).keydown(function (event) {
                var $this = $(event.target)
                if (event.keyCode == 13) {     
                    $('form').each(function() {       
                        event.preventDefault();     
                    }); 
                    if ($this.next().hasClass('input-group-addon')) {
                        $this.next().trigger('click')
                    }
                }
            });
            var eventChange = {
                //部门列表绑定事件
                deptSelectChange: function (id) {
                    $('#' + id + ' li input').off('change').on('change', function (e) {
                        var self = $(e.target);
                        var areaValue = self.closest('.choose-area').next('.result-area').data('value');
                        var areaText = self.closest('.choose-area').next('.result-area').data('text');
                        if (areaValue == "")
                            areaValue = [];
                        if (areaText == "")
                            areaText = [];
                        var chooseValueList = areaValue;
                        var chooseTextList = areaText;
                        var deptname = self.closest('li').data('deptname');
                        var deptid = self.closest('li').data('deptid');
                        if (self.is(':checked')) {
                            chooseTextList.push(deptname);
                            chooseValueList.push(deptid);
                        } else {
                            chooseTextList.splice(chooseTextList.indexOf(deptname), 1);
                            chooseValueList.splice(chooseValueList.indexOf(deptid), 1);
                        }
                        
                        self.closest('.choose-area').next('.result-area').data('text', chooseTextList);
                        self.closest('.choose-area').next('.result-area').data('value', chooseValueList);
                        createHtml(self.closest('.choose-area').next('.result-area'),chooseValueList);
                    });
                    var createHtml = function (obj, chooseValueList) {
                        var chooseList = obj.data('text');
                        var html = '';
                        for (var i = 0, len = chooseList.length; i < len; i++) {
                            html += '<span data-deptId="'+chooseValueList[i]+'">' + chooseList[i] + ';</span>'
                        }
                        obj.html(html);
                    };
                },
                //员工列表绑定事件
                leaderSelectChange: function (id,keyValue) {
                    $("#" + id + " li").off("change").on("change", function (e) {
                        var self = $(e.target);
                        var $areaFiled = $("#" + keyValue + "");
                        var areaValue = $areaFiled.data('value');
                        var areaText = $areaFiled.data('text');
                        var areaKey = $areaFiled.data('key');
                        if (areaValue == "")
                            areaValue = [];
                        if (areaText == "")
                            areaText = [];
                        if (areaKey == "" || areaKey == undefined)
                            areaKey = [];

                        var chooseValueList = areaValue;
                        var chooseTextList = areaText;
                        var chooseKeyValue = areaKey;
                        var name = self.closest('li').data('name');
                        var empid = self.closest('li').data('empid');
                        var text = name + "（" + empid + "）";
                        if (self.is(':checked') && chooseKeyValue.indexOf(empid) === -1) {
                            chooseValueList.push(name + ";" + empid);
                            chooseTextList.push(text);
                            chooseKeyValue.push(empid)
                        } else {
                            chooseValueList.splice(chooseValueList.indexOf(name + ";" + empid), 1);
                            chooseTextList.splice(chooseTextList.indexOf(text), 1);
                            chooseKeyValue.splice(chooseKeyValue.indexOf(empid),1)
                        }

                        $areaFiled.data('value', chooseValueList);
                        $areaFiled.data('text', chooseTextList);
                        $areaFiled.data('key', chooseKeyValue);
                        createHtml(chooseTextList,keyValue,chooseKeyValue);
                    });
                    var createHtml = function (chooseTextList, keyValue,chooseKeyValue) {
                        var html = '';
                        for (var i = 0, len = chooseTextList.length; i < len; i++) {
                            html += '<span data-empid="'+chooseKeyValue[i]+'">' + chooseTextList[i] + ';</span>'
                        }
                        $("#" + keyValue + "").html(html);
                    };
                },
                myGroupDeptSelectChange: function () {
                    $("#myGroupDept1,#myGroupDept2").on("change", function (e) {
                        var groupid = e.target.value;
                        var targetid = e.target.id;
                        var keyValue = { "myGroupDept1": "ulMainDept", "myGroupDept2": "ulAssDept" };
                        if (groupid == "") {
                            init.loadAllDeptData([keyValue[targetid]]);
                            return;
                        }
                        $.ajax({
                            type: "POST",
                            data: JSON.stringify({ groupId: groupid }),
                            url: "WebServices/SuperviseMissionWebServices.asmx/GetGroupDepts",
                            contentType: 'application/json;charset=utf-8',
                            dataType: "json",
                            success: function (data) {
                                if (data.d.status == "1") {
                                    render.renderDeptList(data.d.List, [keyValue[targetid]]);
                                    eventChange.deptSelectChange(keyValue[targetid]);
                                } else {
                                   layer.msg(data.d.message, { icon:2,time:1000});
                                }
                            },
                            error: function (xhr, textStatus) {
                                layer.msg("请求发生异常。", { icon:2,time:1000});
                            }
                        });
                    });
                },
            }
            init.setDefaultSPNameCode();
            init.loadAllDeptData(["ulMainDept", "ulAssDept"]);
            init.loadMyDeptGroup();
            var resetData = {
                mainLeader: function () {
                    $("#mainLeaderSelectedList").data('value', '').data('text', '').html('');
                    $("#Tb_MainLeader").val('');
                    $("#hdMainLeaderIds").val("");
                    $("#hdMainLeaderNames").val("");
                },
                assLeader: function () {
                    $("#assLeaderSelectedList").data('value', '').data('text', '').html('');
                    $("#Tb_AssLeader").val('');
                    $("#hdAssLeaderIds").val("");
                    $("#hdAssLeaderNames").val("");
                },
                mainDept: function () {
                    $("#mainDeptList").val("value", "").data("text", "").html("");
                    $("#Tb_MainDept").val("");
                    $("#hdMainDeptNames").val("");
                    $("#hdMainDeptIds").val("")
                    init.loadAllDeptData(["ulMainDept"]);
                    ;
                },
                assiDept: function () {
                    $("#assDeptList").val("value", "").data("text", "").html("");
                    $("#Tb_AssDept").val("");
                    $("#hdAssDeptNames").val("");
                    $("#hdAssDeptIds").val("")
                    init.loadAllDeptData(["ulAssDept"]);
                }
            };
            //获取年号
            $("#DDL_SP_NUMBER_NAME").on("change", function () {
                var deptId = $(this).val();
                if (deptId == "") {
                    $("#DDL_SP_NUMBER_YEAR").empty();
                    $("#Tb_SP_NUMBER_CODE").val("");
                    $("#hdYear").val("");
                    $("#hdTempYear").val("");
                    $("#hdCode").val("");
                    $("#hdTempCode").val("");
                    return;
                }
                var name = $(this).find("option:selected").text();
                $('#hdCurSelectedNumberName').val(name);
                var jsonData = { deptId: deptId, name: name };
                var tempYearList = [];
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
                                str += "<option>" + years[i] + "</option>";
                                tempYearList.push(years[i]);
                            }
                            $("#DDL_SP_NUMBER_YEAR").empty().append(str);
                            $("#DDL_SP_NUMBER_YEAR").trigger("change");
                        } else {
                            layer.msg(data.d.message, { icon:2,time:1000});
                        }
                        $("#hdTempYear").val(tempYearList);
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon:2,time:1000});
                    }
                });
            });
            //获取序号
            $("#DDL_SP_NUMBER_YEAR").on("change", function () {
                var deptId = $("#DDL_SP_NUMBER_NAME").val();
                var name = $("#DDL_SP_NUMBER_NAME").find("option:selected").text();
                var year = $("#DDL_SP_NUMBER_YEAR").find("option:selected").text();
                $("#hdYear").val(year);
                if (deptId == "" || name == "" || year == "")
                    return;

                var jsonData = { deptId: deptId, name: name, year: year };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetSuSuperviseNumberCode",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            $("#Tb_SP_NUMBER_CODE").val(data.d.data);
                            $("#hdCode").val(data.d.data);
                        } else {
                            layer.msg(data.d.message, { icon:2,time:1000});
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon:2,time:1000});
                    }
                });
            });

            //选择主管领导
            $("#btSearchMainLeader").on("click", function () {
                var mainLeader = $("#textMainLeader").val();
                if (mainLeader == "")
                    return;
                $.ajax({
                    type: "POST",
                    data: JSON.stringify({ UserId: mainLeader }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            var jd = JSON.parse(data.d.data);
                            render.renderLeaderList(jd, ["ulMainLeader"]);
                            eventChange.leaderSelectChange("ulMainLeader", "mainLeaderSelectedList");
                        } else {
                            layer.msg(data.d.message, { icon:2,time:1000});
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon:2,time:1000});
                    }
                });
            });
            //选择协管领导
            $("#btSearchAssLeader").on("click", function () {
                var assLeader = $("#textAssLeader").val();
                if (assLeader == "")
                    return;
                $.ajax({
                    type: "POST",
                    data: JSON.stringify({ UserId: assLeader }),
                    url: "WebServices/SuperviseMissionWebServices.asmx/GetUserInfoByUserIdOrName",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            var jd = JSON.parse(data.d.data);
                            render.renderLeaderList(jd, ["ulAssLeader"]);
                            eventChange.leaderSelectChange("ulAssLeader", "assLeaderSelectedList");
                        } else {
                            layer.msg(data.d.message, { icon:2,time:1000});
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常。", { icon:2,time:1000});
                    }
                });
            });

            var TASK_CONTENT_MAX_LENGTH = 400;    // 任务内容数最大限长量。
            //确定验证
            $(document).on('click', '#BtSave', function (e) {
                var $this = $(e.target)
                var errorText = ['提交失败！']
                $this.closest('.form-box').each(function () {
                    if ($(this).find('#DDL_SP_NUMBER_NAME').val() === '') {
                        errorText.push('请选择督查编号。')
                    }
                    if (jQuery.trim($(this).find('[name="Tb_TASK_CONTENT"]').val())=== ''){
                        errorText.push('任务内容不能为空')
                    }
                    if (jQuery.trim($(this).find('[name="Tb_TASK_CONTENT"]').val()).length>TASK_CONTENT_MAX_LENGTH) {
                        errorText.push('任务内容字符数不能大于' + TASK_CONTENT_MAX_LENGTH + '个字符。');
                    }
                    if ($(this).find('[name="Tb_MainLeader"]').val() === '') {
                        errorText.push('主管领导不能为空')
                    }
                    if ($(this).find('[name="Tb_AssLeader"]').val() === '') {
                        errorText.push('协管领导不能为空')
                    }
                    if ($(this).find('[name="Tb_MainDept"]').val() === '') {
                        errorText.push('主办单位不能为空')
                    }
                });
                if (errorText.length > 1) {
                    // 只提示首项。
                    layer.msg(errorText[1], { icon: 2,time:1000 });
                    return false
                }
            });

            //确定主管领导
            $("#btConfirmSelectMianLeader").on("click", function () {
                var leaderList = $("#mainLeaderSelectedList").data('value');
                var names = [];
                var ids = [];
                var html = "";
                for (var i = 0; i < leaderList.length; i++) {
                    var ne = leaderList[i].split(";");
                    html += ne[0] + "（" + ne[1] + "）;";
                    names.push(ne[0]);
                    ids.push(ne[1]);
                }
                $("#Tb_MainLeader").val(html);
                $("#hdMainLeaderNames").val(names);
                $("#hdMainLeaderIds").val(ids);
                $("#mainLeader").modal("hide");
            });
            //删除部门
            $(document).on('dblclick', '.result-area span', function (e) {
                var $this = $(this)
                var deptId = $this.data('deptid')
                var empId = $this.data('empid')
                var cId = $this.closest('.result-area').attr('id')

                var deptValue = $('#'+cId).data('value');
                var deptText = $('#'+cId).data('text');

                var empKey = $('#'+cId).data('key');
                var empValue = $('#'+cId).data('value');
                var empText = $('#'+cId).data('text');
                if (empId) {
                    var eIndex = empKey.indexOf(empId)
                    $this.closest('.result-area').prev().find('[data-empid="' + empId + '"] input').prop('checked', false)
                    empKey.splice(eIndex, 1)
                    empValue.splice(eIndex, 1)
                    empText.splice(eIndex, 1)
                    
                    $('#'+cId).data('key', empKey)
                    $('#'+cId).data('value',empValue)
                    $('#'+cId).data('text',empText)
                }
                if (deptId) {
                    var dIndex = deptValue.indexOf(deptId)
                    $this.closest('.result-area').prev().find('[data-deptid="' + deptId + '"] input').prop('checked', false)
                    deptValue.splice(dIndex, 1)
                    deptText.splice(dIndex, 1)

                    $('#'+cId).data('value',deptValue)
                    $('#'+cId).data('text', deptText)
                }
                $this.remove()
            })
            //确定协管领导
            $("#btConfirmSelectAssLeader").on("click", function () {
                var leaderList = $("#assLeaderSelectedList").data('value');
                var names = [];
                var ids = [];
                var html = "";
                for (var i = 0; i < leaderList.length; i++) {
                    var ne = leaderList[i].split(";");
                    html += ne[0] + "（" + ne[1] + "）;";
                    names.push(ne[0]);
                    ids.push(ne[1]);
                }
                $("#Tb_AssLeader").val(html);
                $("#hdAssLeaderNames").val(names);
                $("#hdAssLeaderIds").val(ids);
                $("#assLeader").modal("hide");
            });
            //重置主管领导数据
            $("#btResetSelectMainLeader").on("click", function () {
                //resetData.mainLeader();
            });
            $("#btResetSelectAssLeader").on("click", function () {
                //resetData.assLeader();
            });
            $("#btConfirmMainDept").on("click", function () {
                var mainDeptListText = $("#mainDeptList").data('text');
                var mainDeptListValue = $("#mainDeptList").data('value');
                var names = [];
                var ids = [];
                var html = "";
                for (var i = 0; i < mainDeptListText.length; i++) {
                    html += mainDeptListText[i] + "；";
                    names.push(mainDeptListText[i]);
                    ids.push(mainDeptListValue[i]);
                }
                $("#Tb_MainDept").val(html);
                $("#hdMainDeptNames").val(names);
                $("#hdMainDeptIds").val(ids);
                $("#companyMain").modal("hide");
            });
            $("#btConfirmAssDept").on("click", function () {
                var assDeptListText = $("#assDeptList").data('text');
                var assDeptListValue = $("#assDeptList").data('value');
                var names = [];
                var ids = [];
                var html = "";
                for (var i = 0; i < assDeptListText.length; i++) {
                    html += assDeptListText[i] + "；";
                    names.push(assDeptListText[i]);
                    ids.push(assDeptListValue[i]);
                }
                $("#Tb_AssDept").val(html);
                $("#hdAssDeptNames").val(names);
                $("#hdAssDeptIds").val(ids);
                $("#companyAssi").modal("hide");
            });
            $("#btResetMainDept").on("click", function () {
                //resetData.mainDept();
            });
            $("#btResetAssDept").on("click", function () {
                //resetData.assiDept();
            });
            $("#btResetAll").on("click", function () {
                window.location.reload();
            });
            $("#btSearchMainDept").on("click", function () {
                var name = $("#txtMainDept").val();
                init.loadDeptDataByName(name, ["ulMainDept"]);
            });
            $("#btSearchAssDept").on("click", function () {
                var name = $("#txtAssDept").val();
                init.loadDeptDataByName(name, ["ulAssDept"]);
            });

            //默认加载主管领导
            $('#mainLeader').on('shown.bs.modal', function (e) {
                var $ulMainLeader = $('#ulMainLeader').children();
                $('#txtMainDept,#txtAssDept').val('');
                $('#textMainLeader,#textAssLeader').val('');
                
                //未选中主管领导时，加载默认主管领导
                if ($ulMainLeader.length === 0) {
                    $.ajax({
                        type: "POST",
                        data: '',
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetDefaultLeader",
                        contentType: 'application/json;charset=utf-8',
                        dataType: "json",
                        success: function (data) {
                            if (data.d.status == "1") {
                                if (data.d.data !== '' && data.d.data !== null) {
                                    var leaderList = JSON.parse(data.d.data);
                                    render.renderLeaderList(leaderList, ["ulMainLeader"]);
                                    eventChange.leaderSelectChange("ulMainLeader", "mainLeaderSelectedList");
                                }
                            } else {
                                layer.msg(data.d.message, { icon:2,time:1000});
                            }
                        },
                        error: function (xhr, textStatus) {
                            layer.msg("请求发生异常。", { icon:2,time:1000});
                        }
                    });
                }
            });
            //默认加载协管领导
            $('#assLeader').on('shown.bs.modal', function (e) {
                var $ulAssLeader = $('#ulAssLeader').children();
                $('#txtMainDept,#txtAssDept').val('');
                $('#textMainLeader,#textAssLeader').val('');
                //未选中协管领导时，加载默认协管领导
                if ($ulAssLeader.length === 0) {
                    $.ajax({
                        type: "POST",
                        data: '',
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetDefaultLeader",
                        contentType: 'application/json;charset=utf-8',
                        dataType: "json",
                        success: function (data) {
                            if (data.d.status == "1") {
                                var leaderList = JSON.parse(data.d.data);
                                render.renderLeaderList(leaderList, ["ulAssLeader"]);
                                eventChange.leaderSelectChange("ulAssLeader", "assLeaderSelectedList");
                            } else {
                                layer.msg(data.d.message, { icon:2,time:1000});
                            }
                        },
                        error: function (xhr, textStatus) {
                            layer.msg("请求发生异常。", { icon:2,time:1000});
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>
