<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaderMeetingMission.aspx.cs" Inherits="OA30.SuperviseMission.UI.MainSite.LeaderMeetingMission" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>督查系统-<%=LbHeader %></title>
    <link rel="stylesheet" type="text/css" href="Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Css/picker.css" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <style type="text/css">
        /*.form-horizontal .control-label {
            width:auto;
        }*/
        .form-disabled input.form-control[data-target="#company"] {
            width:80%;
        }
       .mission-part {
            position:relative;
        }
        .trash {
            display: inline;
            position: absolute;
            right: 20px;
            top: 15px;
        }
        .form-disabled .is-edit .col-lg-6{
            margin-right:0;
        }
        .form-disabled .col-lg-6 {
            margin-right:-200px;
        }
        .mission-part h3 {
            margin-left:2px;
        }
        .mission-part .form-group textarea {
            height:80px;
        }
        
        .disabled-box textarea.disabled{
            height:25px;
            vertical-align:middle;
        }
        .disabled-box {
            height:25px;
        }
        .main3 {
            margin:10px 0;
            padding: 0 15px 15px;
            background:#fff;
        }
        .one-part {
            padding-left:30px;
            padding-right:30px;
        }
        .mission-part .form-group.tac.sn {
            margin-top:15px;
            margin-bottom:-20px;
        }
        .mission-part .form-group{
            margin-bottom:15px;
        }
        .mission-part .form-group textarea {
            margin-top:0px;
        }
        .mission-part .form-group .isupload{
            border: none;
        }

    </style>
</head>
<body class="mission-box">
    <div class="main">
        <div class="title clearfix">
            <h3 class="caption"><%=LbHeader %></h3>
            <div class="action">
                <button type="button" class="btn btn-default-s"><span class="iconfont icon-sv-download"></span>下载模板</button>
                <button type="button" class="btn btn-default-s"><span class="iconfont icon-sv-import"></span>导入</button>
            </div>
        </div>
        <div class="mission-part be-edit" data-index="1" style="padding:15px 0px;margin-top:15px;min-width: auto;">
            <%--<h3 class="mission-title">任务1</h3>--%>
            <div class="form-box form-horizontal">
                <div class="form-group form-customer" style="margin-top:0px">
                    <div class="sedit"style="margin-right:0px;">
                        <label class="col-lg-1 col-sm-1 col-xs-1 col-md-1 control-label">督查编号</label>
                        <div class="col-lg-7 col-sm-7 col-md-7 col-xs-7">
                            <span class="s" data-name="snName" style="display:none">南航督查</span>
                            <select name="snName" class="form-control dbi">
                            </select>
                            <span class="s" data-name="snYear" style="display:none">2018</span>
                            <select name="snYear" class="form-control dbi">
                            </select>
                            <span class="s" data-name="snCode" style="display:none">01号</span>
                            <input name="snCode" data-code="" type="text" class="form-control dbi" placeholder="" value="" disabled="disabled"  />
                            号
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-4 col-sm-4" style="position:relative">
                            <label class="dbi fw5" style="position:absolute">文件ID</label>
                            <input type="text" class="form-control dbi"style="width:95%;margin-left:50px;" data-id="" placeholder="后台自动生成" name="snId"  disabled="disabled" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">任务内容</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <textarea class="form-control th1" name="snText" placeholder="请输入任务内容"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">主办单位</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" name="snCompany" class="form-control" readonly="readonly" placeholder="请输入主办单位" data-toggle="modal" data-target="#company" data-dept="snCompany" data-backdrop="static" data-keyboard="false"/>
                        <input type="hidden" name="snCompanyIds"/>
                        <span class="iconfont icon-sv-add form-control-feedback" name="snCompany" data-toggle="modal" data-target="#company" data-dept="snCompany" data-backdrop="static" data-keyboard="false"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">协办单位</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" name="snOtherCompany" class="form-control" readonly="readonly" placeholder="请输入协办单位" data-toggle="modal" data-target="#company" data-dept="snOtherCompany" data-backdrop="static" data-keyboard="false"/>
                        <input type="hidden" name="snOtherCompanyIds" />
                        <span class="iconfont icon-sv-add form-control-feedback" name="snOtherCompany" data-toggle="modal" data-target="#company" data-dept="snOtherCompany" data-backdrop="static" data-keyboard="false"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">完成时间</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" data-name="endTime" readonly="readonly" placeholder="请输入完成时间" class="form-control input-time" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" name="snEndTime" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">启动时间</label>
                    <div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
                        <input type="text" readonly="readonly" data-name="startTime" placeholder="请输入启动时间" class="form-control input-time" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd" name="snStartTime" />
                    </div>
                </div>
                <div class="form-group tac sn">
                    <button type="button" class="btn btn-primary-c" data-btn="sure">添加</button>
                    <button type="button" class="btn btn-default-c" data-btn="reset">重置</button>
                </div>
            </div>
    </div>
        </div>
    <div id="mission"></div>
    <div class="one-part">
        <span>添加任务</span>
        <span id="newMission" class="iconfont icon-sv-add"></span>
    </div>
    <form method="post" runat="server">
        <div class="form-group sn tac">
            <input id="BtSave" value="提交" type="button" style="display: none;" class="btn btn-primary-c" />
            <asp:HiddenField ID="leaderMeetingMissionList" runat="server" />
            <asp:Button ID="BtSubmit" runat="server" Text="提交" class="btn btn-primary-c" OnClick="BtSave_Click" />
        </div>
    </form>


    <script id="template" type="x-tmpl-mustache">
        <div class="main3">
<div class="mission-part" data-index="{{index}}">
	<h3 class="mission-title">任务{{index}}</h3>
		<div class="form-box form-horizontal">
            <a href="javascript:void(0)" class="iconfont icon-sv-reduce trash" style="display:none;"></a>
			<div class="form-group form-customer sn">
                <div class="sedit">
				<label class="col-lg-1 col-sm-1 col-xs-1 col-md-1 control-label">督查编号</label>
				<div class="col-lg-6 col-sm-6 col-md-6 col-xs-6">
                    <span class="s" data-name="snName" style="display:none">南航督查</span>
                    <select name="snName" class="dbi fcc">
                    </select>
                    <span class="s" data-name="snYear" style="display:none">2018</span>
                    <select name="snYear" class="dbi fcc">
                    </select>
                    <span class="s" data-name="snCode" style="display:none">01号</span>
                    <input name="snCode" data-code="" type="text" class="dbi fcc" placeholder="" value="" disabled="disabled"  />
                    号
                </div>
				<div class="col-lg-5 col-md-5 col-xs-5 col-sm-5">
					<label class="dbi">文件ID</label>
					<input type="text" class="form-control dbi" data-name="id" placeholder="后台自动生成" name="snId" value="" disabled>
				</div>
                </div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">任务内容</label>
				<div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
						<textarea class="form-control th1" name="snText" placeholder="请输入任务内容"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">主办单位</label>
				<div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
						<input type="text" class="form-control" name="snCompany" readonly="readonly" placeholder="请输入主办单位" data-toggle="modal" data-target="#company" data-tag="leader" data-dept="snCompany"/>
                        <input type="hidden" name="snCompanyIds" />
						<span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#company" data-tag="leader" data-dept="snCompany"></span>
								
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">协办单位</label>
				<div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
						<input type="text" class="form-control" name="snOtherCompany" readonly="readonly" placeholder="请输入协办单位" name="" data-toggle="modal" data-target="#company" >
                        <input type="hidden" name="snOtherCompanyIds"/>
						<span class="iconfont icon-sv-add form-control-feedback" data-toggle="modal" data-target="#company" data-tag="company" data-dept="snOtherCompany"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">完成时间</label>
				<div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
					<input type="text" readonly="readonly" placeholder="请输入完成时间" name="snEndTime" class="form-control input-time" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd">
				</div>
			</div>
			<div class="form-group">
				<label class="col-lg-1 col-md-1 col-sm-1 col-xs-1 control-label">启动时间</label>
				<div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
					<input type="text" readonly="readonly" placeholder="请输入启动时间" name="snStartTime" class="form-control input-time" data-date="" data-date-format="yyyy-mm-dd" data-link-field="search" data-link-format="yyyy-mm-dd">
				</div>
			</div>
			<div class="form-group tac sn">
				<button type="button" class="btn btn-primary-c" data-btn="sure">添加</button>
				<button type="button" class="btn btn-default-c" data-btn="reset">重置</button>
			</div>
		</div>
</div>
        </div>
    </script>
    <script id="deptTemplate" type="x-tmpl-mustache">
        <ul class="list-unstyled">{{{deptHtml}}}</ul>
    </script>
    <script id="deptGroupTemplate" type="x-tmpl-mustache">
        {{{deptGroupHtml}}}
    </script>
    <script src="Script/require.js"></script>
</body>
</html>
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
    require(['jquery', 'mustache','state','common', 'lodash', 'bootstrap', 'picker','toast'], function ($, Mustache,state,cm,_) {

        function getQueryString(name) {
            var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
            var r = window.location.search.substr(1).match(reg);
            if (r != null) {
                return unescape(r[2]);
            }
            return null;
        };
        //加载部门和部门组
        cm.initDept();
        cm.initDeptGroup();
        //日历控件
        cm.showPicker();
        //textare自适应
        //cm.resetTextarea();
        //设置默认的postData
        state.setIndex({
            snName: '',
            snYear: '',
            snDeptId: '',
            snId: '',
            snEndTime: '',
            snStartTime: '',
            snText: '',
            snCompany: {},
            snCompanyIds: {},
            snOtherCompany: {},
            snOtherCompanyIds: {},
            snIsDel: true,
            single:false
        })

        var superviseNumber = '';
        //获取督查字号缓存到本地。
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetDistinctSuperviseNumberNameList",
            type: "post",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d.status == "1") {
                    superviseNumber = data.d.data;
                    bindSuperviseNumber();//先绑定第一个任务的督查字号
                }
                else {
                    layer.msg(data.d.message, { icon: 2 });
                }
            },
            error: function (message) {
                layer.msg("获取督查字号列表失败！", { icon: 2 });
            }
        });

        //确定部门
        $(document).on('click', '[data-btn="deptSure"]', function (e) {
            $('[data-index="' + (state.getPage() + 1) + '"]').find('[name="' + state.dType + '"]').val(state.getDeptByName());
            $('#company').modal('hide');
        })
        //取消
        $(document).on('click', '[data-btn="reset"]', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('[data-index]');
            state.setPage($box.data('index'));
            $box.find('.form-control').each(function () {
                $(this).val('');
                if (this.name == "snYear") {
                    $(this).empty();
                }
            })
            state.setValue('snName', '')
            state.setValue('snYear', '')
            state.setValue('snDeptId', '')
            state.setValue('snId', '')
            state.setValue('snEndTime', '')
            state.setValue('snStartTime', '')
            state.setValue('snText', '')
            state.setValue('snCompanyIds', '')
            state.setValue('snOtherCompanyIds', '')
            state.page[state.getPage()].snCompany = {}
            state.page[state.getPage()].snOtherCompany = {}
        })
        //新建任务
        $('#newMission').on('click', function (e) {
            state.setIndex({
                snName: '',
                snYear: '',
                snDeptId: '',
                snId: '',
                snEndTime: '',
                snStartTime: '',
                snText: '',
                snCompany: {},
                snCompanyIds: {},
                snOtherCompany: {},
                snOtherCompanyIds: {},
                snIsDel: true,
                single:false
            })
            var index = state.getIndex();
            e.stopPropagation();
            var template = $('#template').html();
            Mustache.parse(template);
            var rendered = Mustache.render(template, { index: index });
            $('#mission').append(rendered);
            cm.showPicker();
            state.setPage(index);
            bindSuperviseNumber();
        });
        var index = state.getPage() - 1;
        //设置主办单位字段
        $(document).on('click', '[data-index="'+ index +'"] [name="snOtherCompany"]', function () {
            state.setSingle(false);
            state.setDeptType('snOtherCompany');
        })
        //设置协办单位字段
        $(document).on('click', '[data-index="'+ index +'"] [name="snCompany"]', function () {
            state.setSingle(false);
            state.setDeptType('snCompany');
        })
        //绑定督查字号列表。
        function bindSuperviseNumber() {
            var $selectSuperviseNumber = $("[data-index='" + (state.getPage() + 1) + "'] [name='snName']");
            if ($selectSuperviseNumber.length > 0 && superviseNumber !== '') {
                var superviseNumberList = JSON.parse(superviseNumber);
                var optionHtml = '<option value="">请选择</option>';
                //遍历生成督查字号选项
                $.each(superviseNumberList, function (index, obj) {
                    optionHtml += '<option value="' + obj.DeptId + '">' + obj.Name + '</option>';
                });
                $.each($selectSuperviseNumber, function (index, obj) {
                    //已绑定字号的元素不再执行绑定
                    if ($(obj).children().length === 0) {
                        $(obj).append(optionHtml);
                    }
                });
            }
        }

        //获取年号
        $(document).on("change","select[name='snName']", function (e) {
            var $this = $(e.target);
            //var $index = $this.closest('[data-index]');
            var $box = $this.closest('[data-index]');
            var $index = $box.data('index');
            var deptId = $this.find('option:selected').val();
            if (deptId == "") {
                return;
            }
            var sName = $this.find("option:selected");
            var name = sName.text();
            $this.prev().text(name);
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
                            str += "<option>" + years[i] + "</option>";
                        }
                        $box.find("select[name='snYear']").html('').append(str);
                        state.setPage($index);
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
        $(document).on("change", "select[name='snYear']", function (e, a, b) {
            var $this = $(e.target);
            var $box = $this.closest('[data-index]');
            var deptId = $box.find("select[name='snName']").val();
            var sName = $box.find("select[name='snName'] option:selected");
            var sYear = $box.find("select[name='snYear'] option:selected");
            var name = sName.text();
            var year = sYear.text();
            $box.find("select[name='snName']").prev().text(name);
            $box.find("select[name='snYear']").prev().text(year);
            if (deptId === "" || deptId === undefined || name === "" || name === undefined || year === "" || year === undefined)
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
                        $box.find("input[name='snCode']").val(data.d.data);
                        $box.find("input[name='snCode']").prev().text(data.d.data);
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                }
            });
        });

        
        //确认后显示信息
        $(document).on('click', '[data-btn="sure"]', function (e) {
            
            //var $this = $(e.target).closest('[data-index]');
            var $this = $(e.target)
            var $box = $this.closest('[data-index]');
                if (requiredFieldValidator($this)) {
                    var $input = $box.find('.form-customer input');
                    var $num = $box.find('input.num');
                    var $area = $box.find('textarea');
                    var $value = $input.val();
                    var $index = $box.data('index');
                    $this.closest('.mission-part').addClass('be-edit');
                    $box.find('.form-box').addClass('form-disabled');
                    
                    //$box.find('.form-box').find('.form-control').attr('disabled', true).addClass('disabled').attr('placeholder', '').parent().addClass('disabled-box');
                   
                   //解决ff浏览器无法点击disabled元素
                    $box.find('.form-box').find('.form-control').addClass('disabled isupload').attr('placeholder', '').parent().addClass('disabled-box');
                   
                    $box.find('.sedit .fcc').hide();
                    $box.find('.sedit').show();
                    $this.parent().prevAll('.trash').show();
                    $num.val(['【', $num.val(), '】'].join(''));
                    $input.each(function () {
                        var len = $(this).val().length;
                        $(this).width(len * (len > 5 ? 10 : 8));
                    })
                    state.setPage($index);
                    state.setValue("snIsDel", false);
                    $box.find('[data-btn="sure"],[data-btn="reset"]').hide();
                    $('#BtSave').show();

                    //解决ff浏览器无法点击disabled元素
                    $('.isupload').on('focus',function () {
                        $(this).removeClass('isupload')
                    })
                }
                
            });

        //false 是没通过验证 
        function requiredFieldValidator($this) {
            //var $formBox = $this.closest('.form-box');
            var $formBox = $this.closest('[data-index]');
            var snName = $formBox.find('[name="snName"] option:selected').val();
            var snYear = $formBox.find('[name="snYear"] option:selected').val();
            var snCode = $formBox.find('[name="snCode"]').val();
            var snText = $formBox.find('[name="snText"]').val();
            var snCompany = $formBox.find('[name="snCompany"]').val();
            var snOtherCompany = $formBox.find('[name="snOtherCompany"]').val();
            state.setValue('snName', $formBox.find('[name="snName"] option:selected').text());
            state.setValue('snYear', snYear);
            state.setValue('snDeptId', snName);
            state.setValue('snCode', snCode);
            state.setValue('snText', snText);
            //var snEndTime = $formBox.find('[name="snEndTime"]').val();完成时间非必填
            $formBox.find('[name="snEndTime"],[name="snOtherCompany"],[name="snCompany"],[name="snText"],[name="snStartTime"]')
                .blur();
            var snStartTime = $formBox.find('[name="snStartTime"]').val();
            if (isRequestNotNull(snName) ||
                isRequestNotNull(snYear) ||
                isRequestNotNull(snCode) ||
                isRequestNotNull(snText) ||
                isRequestNotNull(snCompany) ||
                //isRequestNotNull(snOtherCompany) ||
                isRequestNotNull(snStartTime)) {
                layer.msg('除协办单位、完成时间外，所有字段必须填写', { icon: 7 });
                return false;
            }
            if (snText.length > 400) {
                layer.msg('任务内容最大长度不能超过400个字符', { icon: 7 });
                return false;
            }

            return true;
        }

        function isRequestNotNull(obj) {
            obj = $.trim(obj);
            if (obj.length == 0 || obj == null || obj == undefined) {
                return true;
            } else {
                return false;
            }
        }

        function changeClassByNull($this) {
            if (isRequestNotNull($this.val())) {
                $this.addClass("error");
            } else {
                $this.removeClass("error");
            }
        }
        //修改督查编号
        $(document).on('click', '.sedit .s', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.sedit');
            var $name = $this.data('name');
            $box.find('.fcc').show();
            $box.find('.s').hide();
        })
         //移开督查编号保存
        $(document).on('blur', '.sedit', function (e) {
            var $this = $(e.target)
            var $box = $this.closest('.sedit');
            var $cBox = $this.closest('[data-index]');
            var snName = $box.find('[name="snName"] option:selected').val();
            var snYear = $box.find('[name="snYear"] option:selected').val();
            var snCode = $box.find('[name="snCode"]').val();
            var snCompany = $box.find('[name="snCompany"]').val();
            var snOtherCompany = $box.find('[name="snOtherCompany"]').val();
            state.setValue('snName', $box.find('[name="snName"] option:selected').text());
            state.setValue('snYear', snYear);
            state.setValue('snDeptId', snName);
            state.setValue('snCode', snCode);
            if ($('[data-index="' + (state.getPage() + 1) + '"] [data-btn="sure"]').is(':hidden')) {
                if ($this.hasClass('form-control') || $this.hasClass('s') || $this.hasClass('fcc')) {
                    return false;
                }
                $box.find('.fcc').hide();
                //$box.find('.s').show();
                $this.parent().addClass('disabled');
            }
        })
        
        //点击编辑
        $(document).on('click', '.form-group:not(.form-customer)', function (e) {
            var $this = $(e.target)
            $this.closest('.mission-part').removeClass('be-edit');
            $this.removeClass('disabled').removeAttr('disabled');
            $this.parent().removeClass('disabled-box');
        })
        //编辑改变state
        $(document).on('click', '.main .form-group', function (e) {
            var $this = $(e.target);
            var $name = $this.attr('name');
            var $index = $this.closest('[data-index]').data('index');
            state.setPage($index);
        })
        //点击空白处隐藏编辑
        $(document).on('click','.mission-part',function (e) {
            var $this = $(e.target)
            if ($('[data-index="' + (state.getPage() + 1) + '"] [data-btn="sure"]').is(':hidden')) {
                if ($this.hasClass('form-control')) {
                    return false;
                }
                $this.find('.form-group:not(.sn)').trigger('blur');
                $this.find('.sedit').trigger('blur');
            }
        })
        $(document).on('change', '.main .form-group .form-control,.main .form-group .fcc', function (e) {
            var $this = $(e.target);
            var $name = $this.attr('name');
            var $index = $this.closest('[data-index]').data('index');
            var $value = $this.val();
            state.setPage($index);
            if ($name === 'snText') {
                state.setValue($name,$value);
            }
            if ($name === 'snName') {
                setTimeout(function () {
                    state.setValue('snYear', $('[data-index="'+ $index +'"] select[name="snYear"] option:selected').val());
                    state.setValue('snCode', $('[data-index="'+ $index +'"] [name="snCode"]').val());
                }, 500)
                state.setValue('snDeptId', $value);
                state.setValue('snName', $('[data-index="'+ $index +'"] select[name="snName"] option:selected').text());
            }
        })
        //离开保存
        $(document).on('blur', '.form-group:not(.sn)', function (e) {
            var $this = $(e.target);
            if (!isRequestNotNull($this)) {
                if ($this.closest(".mission-part").find('[data-btn="sure"]').is(':hidden')) {
                    $this.find('input.form-control[type="text"],textarea').addClass('disabled').attr("disabled", "disabled");
                    $this.find('input.form-control[type="text"],textarea').parent().addClass('disabled-box');
                }
                if ($this.hasClass('.form-control')) {
                    var index = $this.closest('.mission-part').data('index')
                    var name = $this.attr('name')
                    var value = $this.val()
                    state.setPage(index)
                    state.setValue(name,value)
                }
            }
        });
        //删除任务
        $(document).on('click', '.trash', function (e) {
            var $this = $(e.target);
            var $index = $this.closest('.mission-part').attr('data-index');
            state.setPage($index);
            state.setValue("snIsDel", true);
            $this.closest('.mission-part').remove();
        })
        
        $("#BtSubmit").css("display", "none");
        $("#BtSave").on("click", function () {
            var loadIndex = layer.load(1, { time: 10 * 1000, shade: [0.1, '#fff'] });//加载loading层，防止多次触发提交
            //过滤未保存或已删除的任务
            var postData = [];
            var smType=getQueryString("smtype");
            var tData = _.filter(state.page, function (d) {
                return !d.snIsDel
            });
            var newData = _.map(tData, function (item, key) {
                var snCompany = [];
                var snCompanyIds = [];
                var snOtherCompany = [];
                var snOtherCompanyIds = []; 
                var sc = _.map(item['snCompany'], function (sc, k) {
                    if (parseInt(k,10) === 0) return false
                    snCompany.push(sc)
                    snCompanyIds.push(k)
                    return {
                        snCompany:snCompany,
                        snCompanyIds:snCompanyIds
                    }
                })
                var so = _.map(item['snOtherCompany'], function (sc, k) {
                    if (parseInt(k,10) === 0) return false
                    snOtherCompany.push(sc)
                    snOtherCompanyIds.push(k)
                    return {
                        snOtherCompany:snOtherCompany,
                        snOtherCompanyIds:snOtherCompanyIds
                    }
                })
                return _.assign({}, item, {
                    snCompany: snCompany.join(';'),
                    snCompanyIds: snCompanyIds.join(';'),
                    snOtherCompany: snOtherCompany.join(';'),
                    snOtherCompanyIds: snOtherCompanyIds.join(';'),
                })
            })
            if (newData.length === 0) {
                layer.msg("请先添加任务数据", { icon: 7 });
                layer.close(loadIndex);
                return false;
            }
            //这里不使用提交表单的方式保存，因为后台一报错，前端的数据就会被清空
            //$("#leaderMeetingMissionList").val(JSON.stringify(state));
            //$("#BtSubmit").click();

            var jsonData = { smType: smType, leaderMeetingMissions: newData };
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SaveNGData",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        //toast({ message: data.d.message, type: 'success' });
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            //成功后，1.5后自动关当前页面
                            window.close();
                        });
                    }
                    //else if (data.d.status == "0") {
                    //    layer.msg(data.d.message, { icon: 2 });
                    //    layer.close(loadIndex);
                    //}
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadIndex);
                }
            });
        });
    });

</script>
