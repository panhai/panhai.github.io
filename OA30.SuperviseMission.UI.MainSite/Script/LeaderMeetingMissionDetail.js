'use strict';

define(function (require) {
    var dept = require('Dept')
    var state = require('state')
    var cm = require('common');
    var man = require('Man');
    var _ = require('lodash');
    var smId = getQueryString('smid');
    var smType = getQueryString('smtype');
    var flowId = getQueryString('flowid');
    var isLeader = $('#isLeader')[0].innerText; //当前用户是否为领导
    var page = $('#currentPage')[0].innerText;  //当前步骤对应的页面
    var loadingIndex;       //loading层的索引，用于关闭
    var OPINION_MAX_LENGTH = 1000;       //意见、退回理由最大输入长度
    var MISSION_FEEDBACK_MAX_LENGTH = 1000;       //任务反馈内容最大输入长度
    var HOST_DEPT_FEEDBACK_MAX_LENGTH = 1000;        //主办单位反馈内容最大输入长度
    var MEASURE_FEEDBACK_MAX_LENGTH = 500;       //措施反馈内容最大输入长度
    var SUB_MEASURE_FEEDBACK_MAX_LENGTH = 100;       //子措施反馈内容最大输入长度
    var MEASURE_MAX_LENHTH = 400;       //措施内容最大输入长度
    var SUB_MEASURE_MAX_LENHTH = 400;   //子措施内容最大输入长度

    //注册步骤函数
    switch (page) {
        case "1": RegisterPage1(); break;
        case "2": RegisterPage2(); break;
        case "3": RegisterPage3(); break;
        case "4": RegisterPage4(); break;
        case "5": RegisterPage5(); break;
        case "6": RegisterPage6(); break;
        case "7": RegisterPage7(); break;
        case "8": RegisterPage8(); break;
        case "9": RegisterPage9(); break;
        case "10": RegisterPage10(); break;
        case "11": RegisterPage11(); break;
        case "12": RegisterPage12(); break;
        case "13": RegisterPage13(); break;
        case "14": RegisterPage14(); break;
        case "15": RegisterPage15(); break;
        case "16": RegisterPage16(); break;
        case "17": RegisterPage17(); break;
        case "18": RegisterPage17(); break;
        default: layer.msg("无法获取当前步骤，请求异常！");

    }

    /*公用部分 开始*/

    //时间控件
    function showPicker() {
        $('.input-time').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        })
    }

    //获取请求参数
    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    };

    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
    Date.prototype.Format = function (fmt) { //author: meizz 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "H+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    //绑定任务详请方法
    function BindMissionDetail() {
        var jsonData = { smId: smId};
        $.ajax({
            type: "POST",
            data: JSON.stringify(jsonData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetMissionDetail",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var jsonData = JSON.parse(data.d.data);
                    for (var key in jsonData) {
                        var id = $('#' + key);
                        var value = $.trim(jsonData[key]).replace("&nbsp;", "");
                        var type = id.attr('data-type');
                        switch (type) {
                            case "time":
                                id.html(new Date(Date.parse(value.replace(/-/g, "/"))).Format("yyyy-MM-dd"));
                                break;
                            case "inputTime":
                                //用于固定流审批退回主办单位填写完成时间时的绑定
                                {
                                    if (value !== null && value !== '') {
                                        id.val(new Date(Date.parse(value.replace(/-/g, "/"))).Format("yyyy-MM-dd"));
                                    }
                                    break;
                                }
                            default:
                                id.html(value); //默认为label
                                break;
                        }
                    }
                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.alert("请求发生异常", { icon: 2 });
            }
        });
    }

    //绑定主办单位信息
    function BindMainDeptDetail() {
        var jsonData = { smId: smId, flowId: flowId };
        $.ajax({
            type: "POST",
            data: JSON.stringify(jsonData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetMainDeptDetail",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var jsonData = JSON.parse(data.d.data);
                    for (var key in jsonData) {
                        var id = $('#' + key);
                        var value = $.trim(jsonData[key]).replace("&nbsp;", "");
                        var type = id.attr('data-type');
                        switch (type) {
                            case "text": id.attr('value', value); break;
                            case "timeFormatForLabel": id.html(new Date(Date.parse(value.replace(/-/g, "/"))).Format("yyyy-MM-dd")); break;
                            case "time":
                                //用于固定流审批退回主办单位填写完成时间时的绑定
                                {
                                    if (value !== null && value !== '') {
                                        id.val(new Date(Date.parse(value.replace(/-/g, "/"))).Format("yyyy-MM-dd"));
                                    }
                                    break;
                                }
                            default:
                                id.html(value).attr('title', value); //默认为label
                                break;
                        }
                    }
                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.alert("请求发生异常", { icon: 2 });
            }
        });
    }

    //绑定所有主办单位信息
    function BindMainDeptList() {
        var jsonData = { smId: smId};
        $.ajax({
            type: "POST",
            data: JSON.stringify(jsonData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetMainDeptListDetail",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var jsonData = JSON.parse(data.d.data);
                    var html = '';
                    $.each(jsonData, function (index, obj) {
                        html+='<div class="detail-box detail-box2">';
                        html+='<div class="detail-part pr detail-line">';
                        html+='<h3 class="c">主办单位</h3>';
                        html+='<div class="detail-col detail-col-1">';
                        html+='<div class="col">';
                        html+='<span>主办单位</span>';
                        html += '<span title="' + obj.DeptName + '">' + obj.DeptName + '</span>';
                        html+='</div>';
                        html+='<div class="col">';
                        html+='<span>完成时间';
                        html+='</span>';
                        html += '<span>' + (new Date(Date.parse(obj.DeadLineTime.replace(/-/g, "/"))).Format("yyyy-MM-dd")) + '</span>';
                        html+='</div>';
                        html+='</div>';
                        html+='</div>';
                        html+='</div>';
                    });
                    $('#mainDeptList').append(html);
                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.alert("请求发生异常", { icon: 2 });
            }
        });
    }

    //完成进度点击事件
    $(document).on('click', '[data-operateid]', function (e) {
        var $this = $(e.target);
        var flag = $this.attr('data-operate');
        if (flag === 'true') {
            $this.attr('data-operate', 'false');    //更新标识，只会触发一次展开操作
            $('#' + $this.data('operateid')).show();
        }
    });

    //上传文件
    var fileSmId = '';  //任务、措施或子措施对应的附件表外键
    function Upload() {
        //防止DOM树没加载完毕就开始初始化了
        window.setTimeout(function () {
            $('input[type="file"]').fileupload({
                url: 'WebServices/SuperviseMissionWebServices.asmx/SaveSuperviseMissionAttachment',
                dataType: 'json',
                frame: true,
                maxFileSize: 1,
                add: function (e, data) {
                    fileSmId = $(e.target).attr('data-id');
                    $.each(data.files, function (index, file) {
                        if (file.size && (file.size / 1024 / 1024) > 5) {
                            layer.msg("文件不能大于5M！", { icon: 2 });
                            return;
                        }
                    });
                    data.formData = {
                        SmId: fileSmId
                    }
                    data.submit();
                },
                error: function (ex, textStatus, errorThrown) {
                    //由于返回的是xml 不能走success的回调函数，在这里做判断。;
                    var xmlObj = $.parseXML(ex.responseText);
                    var strMsg = "";
                    var status = "";
                    var dataMsg = "";
                    $(xmlObj).find('SuperviseMissionResponse').each(function () {
                        strMsg = $(this).children('message').text();
                        status = $(this).children('status').text();
                        dataMsg = $(this).children('data').text();
                    });
                    if (status === '1') {
                        layer.msg(strMsg, { icon: 1, time: 3000 });
                        //如果需要处理 在这里添加函数

                        //获取当前任务（或措施、或子措施）对应的附件列表对象
                        var $attchment = $('.attchmentList[data-id="' + fileSmId + '"]');

                        //执行重新绑定附件列表
                        LoadAttchmentList($attchment, fileSmId);
                    }
                    else {
                        layer.alert("上传附件失败:" + strMsg + dataMsg, { icon: 2 });
                        //如果需要处理 在这里添加函数
                    }
                }
            })
        }, 300);
    }

    //加载附件列表信息
    //Obj：需要加载内容的元素对象
    //Id:任务（或措施、或子措施）ID
    function LoadAttchmentList(Obj, Id) {
        //先置空对象的子孙元素
        Obj.html('');
        //请求接口获取数据源
        var jsonData = { SmId: Id };
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
                            html += "<div>";
                            html += '<a title="点击下载" target="_blank" style="color: Blue;text-decoration:none;" href="DownLoadAttachment.aspx?SmId=' + obj.SmId + '&AttachmentId=' + obj.AttachmentId + '" >' + obj.AttachmentName + '</a>';
                            html += '<span title="删除" class="iconfont icon-sv-fail" data-id="' + Id + '" data-attachmentid="' + obj.AttachmentId + '" >';
                            html += '</div>';
                        });
                        Obj.append(html);
                    }
                } else {
                    layer.msg(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2 });
            }
        });
    }

    //删除文件
    $(document).on('click', '.icon-sv-fail', function (e) {
        var $this = $(e.target)
        var Id = $this.data('id');
        var attachmentid = $this.data('attachmentid');
        layer.confirm('是否确认删除当前附件？', { btn: ["确认", "取消"] },
            function () {
                //确认删除
                var jsonData = { SmId: Id, AttachmentId: attachmentid };
                $.ajax({
                    type: "POST",
                    data: JSON.stringify(jsonData),
                    url: "WebServices/SuperviseMissionWebServices.asmx/DeleteSuperviseMissionAttachmentByAttachmentId",
                    contentType: 'application/json;charset=utf-8',
                    dataType: "json",
                    success: function (data) {
                        if (data.d.status == "1") {
                            layer.msg(data.d.message, { icon: 1 });
                            $this.parent('div').remove();
                        } else {
                            layer.msg(data.d.message, { icon: 2 });
                        }
                    },
                    error: function (xhr, textStatus) {
                        layer.msg("请求发生异常", { icon: 2 });
                    }
                });
            },
            function () {
                //取消
            });
    });

    //预加载不同意事件的返回上一步的相关信息
    function PrevStepInformationByStep(step) {
        //模态框方法
        $(document).on('click', '.check-ele', function (e) {
            var $this = $(e.target);
            var $box = $this.closest('.check-ele');
            if ($this.hasClass('check-all')) {
                if ($this.prop('checked'))
                    $box.find('input').prop('checked', true)
                else
                    $box.find('input').prop('checked', false)
            }
        });
        //获取数据
        $.ajax({
            type: "POST",
            data: JSON.stringify({ smId: smId, step: step }),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetPrevStepInformationByStep",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var list = data.d.myData;
                    var strHtml = "<div class='checkbox'><label><input class='check-all' type='checkbox' data-deptname='' data-deptid='' data-flowid='' data-smid='' />全选</label></div>";
                    for (var i = 0; i < list.length; i++) {
                        var items = list[i].split('|');
                        strHtml += "<div class='checkbox'><label><input type='checkbox' data-deptname='" + items[0] + "' data-deptid='" + items[1] + "' data-flowid='" + items[2] + "' data-smid='" + items[3] + "' />" + items[0] + "</label></div>";
                    }
                    $("#returnDeptList").html(strHtml);
                } else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2 });
            }
        });
    }

    function getCodeAndName(item) {
        var keyValues = {
            keys: "", values: ""
        };
        var keys = "";
        var values = "";
        for (var key in item) {
            keys += key + ";";
            values += item[key] + ";";
        }
        if (keys !== "") {
            keys = keys.substring(0, keys.length - 1);
        }
        if (values !== "") {
            values = values.substring(0, values.length - 1);
        }
        keyValues.keys = keys;
        keyValues.values = values;

        return keyValues;
    };

    //检查字符串长度
    function CheckStringLength(str, len, tips) {
        if (str === '' || str === undefined || str == null) {
            return false;
        }
        if (str.length > len) {
            layer.msg(tips + '长度不能超过' + len + '个字符', { icon: 7 });
            return false;
        }
        return true;
    }

    //检查是否选择审批意见类型
    function CheckOpinionTypeIsSelected() {
        var selectValue = $('select[name="opinion"]').val();
        if (selectValue === '0' || selectValue === '' || selectValue === undefined) {
            layer.msg('请先选择意见类型', { icon: 7, time: 2000 });
            return false;
        }
        return true;
    }

    //绑定自由流下一步步骤信息
    function BindFreeStepList(stepId, reuqestFlowId) {
        //目前只会请求一次
        var stepListObj = $('#stepList').children();
        //记录当前请求的flowId
        $('#stepList').attr('data-reuqestFlowId', reuqestFlowId);
        if (stepListObj.length === 0) {
            var jsonData = { smId: smId, flowId: reuqestFlowId };
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/GetNextStepFreeList",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        if (data.d.data !== '' && data.d.data !== null) {
                            var stepList = JSON.parse(data.d.data);
                            //循环遍历输出步骤信息
                            $('#stepList').html('');
                            var html = '';      //步骤html
                            var htmlForUser = '';//处理人html
                            var tabid = '';     //选中的步骤tabid
                            var stepid = '';    //选中的步骤ID

                            if (stepList.StepFreeList != null) {
                                $.each(stepList.StepFreeList, function (index, obj) {
                                    if (index === 0) {
                                        //设置第一个步骤为默认选中状态
                                        html += '<li role="presentation" class="active"><a href="#tab' +
                                            index +
                                            '" aria-controls="home" role="tab" data-toggle="tab" data-tabid="tab' + index + '" data-stepid="' +
                                            obj.NextStepId +
                                            '">' +
                                            obj.NextStepName +
                                            '</a></li>';
                                        stepid = obj.NextStepId;
                                        tabid = 'tab' + index;

                                        htmlForUser += '<div role="tabpanel" class="tab-pane active" id="tab' + index + '"></div>';
                                    } else {
                                        html += '<li role="presentation"><a href="#tab' +
                                            index +
                                            '" aria-controls="profile" role="tab" data-toggle="tab" data-tabid="tab' + index + '" data-stepid="' +
                                            obj.NextStepId +
                                            '">' +
                                            obj.NextStepName +
                                            '</a></li>';

                                        htmlForUser += '<div role="tabpanel" class="tab-pane" id="tab' + index + '"></div>';
                                    }
                                });
                            }

                            $('#stepList').append(html);//绑定步骤
                            $('#stepUserList').append(htmlForUser);//添加处理人信息呈现所在的div

                            if (stepid !== '') {
                                //加载默认选中步骤的处理人信息
                                BindStepUserList(tabid, stepid, reuqestFlowId);
                            }
                        }
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2, time: 2000 });
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发送异常", { icon: 2, time: 2000 });
                }
            });
        }
    }

    //绑定步骤对应的处理人/部门信息
    function BindStepUserList(tabId, stepId, reuqestFlowId) {
        if (stepId.toUpperCase() === 'JS' || stepId.toUpperCase() === 'FKJS') {
            //特殊步骤直接返回
            return;
        }
        //清空上次加载的信息
        $('#' + tabId).html('');
        var jsonData = { smId: smId, flowId: reuqestFlowId, stepId: stepId };
        $.ajax({
            type: "POST",
            data: JSON.stringify(jsonData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetUserListByStepFree",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    if (data.d.data !== '' && data.d.data !== null) {
                        var stepUserList = JSON.parse(data.d.data);
                        var html = '';
                        $.each(stepUserList,
                            function (index, obj) {
                                html += '<div class="radio"><label><input type="radio" name="nextStepUser" value="' + obj.MemberId + '" data-roletype="' + obj.RoleType + '" />' + obj.MemberName + '</label></div>';
                            });
                        $('#' + tabId).append(html);
                    }
                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2, time: 2000 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发送异常", { icon: 2, time: 2000 });
            }
        });
    }

    //监听步骤点击事件
    $('#agreeModal').on('show.bs.tab', function (e) {
        var $this = $(e.target);
        var stepid = $this.data('stepid');
        var tabid = $this.data('tabid');
        BindStepUserList(tabid, stepid, $this.parents('#stepList').attr('data-reuqestflowId'));
    });

    //操作记录公用部分
    $(document).on("click", "[name='btnOpreaHistory']", function (e) {
        $(".trOpreaHistory").html("");//清空
        var targetid = $(e.target).data("targetid");
        var targetitemid = $(e.target).data("targetitemid");

        var jsonData = { smid: smId, targetid: targetid, targetItemId: targetitemid, page: page };

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
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2, time: 2000 });
            },
            cache: false
        });
    });


    // 办结、中止、延期、调整跳转页面公用部分
    $(document).on('click', '[data-gotohref]', function (e) {
        var $this = $(e.target);
        var targetid = $this.data('targetid');
        var itemid = $this.data('itemid');
        var parentTargetItemId = $this.data('parenttargetitemid');
        var page = $this.data('type');
        var smtype = getQueryString("smtype");
        var url = 'LeaderMeetingMissionChangeModify.aspx?smid=' + smId + '&itemid=' + itemid + '&targetid=' + targetid + '&parentTargetItemId=' + parentTargetItemId + '&page=' + page + '&smtype=' + smtype;
        window.location.href = url;
    });

    //反馈记录公用部分
    $(document).on("click", "[name='btnFeedbackHistory']", function (e) {
        $(".trLeaderFeedbackHistrpy").html("");//清空
        $(".trMainDeptFeedbackHistory").html("");//清空
        var targetid = $(e.target).data("targetid");
        if (targetid == undefined) { targetid = ""; }
        var targetitemid = $(e.target).data("targetitemid");
        if (targetitemid == undefined) { targetitemid = ""; }

        var jsonData = { smid: smId, targetid: targetid, targetItemId: targetitemid };
        $.ajax({
            type: "POST",
            data: JSON.stringify(jsonData),
            url: "WebServices/SuperviseMissionWebServices.asmx/GetSmFeedbackFlowFinishList",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var flowlist1 = data.d.LeaderFeedbackFlow;
                    var flowlist2 = data.d.MainDeptFeedbackFlow;
                    var str1 = "";
                    var str2 = "";
                    for (var i = 0; i < flowlist1.length; i++) {
                        str1 += "<tr><td>" + flowlist1[i].Opintion + "</td><td>" + flowlist1[i].OperatorId + "</td><td>" + flowlist1[i].OperatorName + "</td><td>" + flowlist1[i].OperaTime + "</td></tr>";
                    }
                    for (var k = 0; k < flowlist2.length; k++) {
                        str2 += "<tr><td>" + flowlist2[k].Opintion + "</td><td>" + flowlist2[k].OperatorId + "</td><td>" + flowlist2[k].OperatorName + "</td><td>" + flowlist2[k].OperaTime + "</td></tr>";
                    }
                    $(".trLeaderFeedbackHistrpy").html(str1);
                    $(".trMainDeptFeedbackHistory").html(str2);
                } else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2, time: 2000 });
            }
        });
    });

    function ShowLoading() {
        ////0.1透明度的白色背景；设定最长等待10秒 
        loadingIndex = layer.load(2, { time: 10 * 1000, shade: [0.1, '#fff'] });
    }

    /*公用部分 结束*/

    //详情页
    function RegisterPage1() {
        // 撤回。
        $(document).on('click', '#rollBackPage1', function (e) {
            var requestParameter = { smId: smId, flowId: flowId };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(requestParameter),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/RollBack",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常。", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
}

    //办公厅审批
    function RegisterPage2() {
        //加载所有主办单位信息
        BindMainDeptList();

        //提交事件
        $(document).on('click', 'button[name="btnSubmit"]', function (e) {
            //验证是否选择了意见类型
            if (!CheckOpinionTypeIsSelected()) {
                return false;
            }

            var $this = $(e.target);
            var allowFlag = $this.data('type');
            var opinion = $.trim($('#opinion').val());
            var opinionType = $('select[name="opinion"]').val();
            //参数检查
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '审批意见')) {
                    return false;
                }
            }

            ShowLoading();
            var postData = { smId: smId, flowId: flowId, allowFlag: allowFlag, opinion: opinion, opinionType: opinionType }
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage2",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //办公厅审批退回拟稿
    function RegisterPage16() {
        //注册日期控件
        showPicker();
        //添加默认参数
        state.setIndex({
            single: false,
            snCompany: {},
            snOtherCompany: {},
        });
        
        //绑定信息
        var requestData = { smId: smId }
        $.ajax({
            type: "POST",
            data: JSON.stringify(requestData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetMissionDetail",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var jsonObj = JSON.parse(data.d.data);
                    //绑定部门信息
                    $('textarea[name="snText"]').html(jsonObj.TaskContent);
                    $('input[name="snCompany"]').attr('data-key', jsonObj.MainDeptId).attr('data-val', jsonObj.MainDeptName).val(jsonObj.MainDeptName);
                    $('input[name="snOtherCompany"]').attr('data-key', jsonObj.AssistDeptId).attr('data-val', jsonObj.AssistDeptName).val(jsonObj.AssistDeptName);
                    //字符串转对象
                    $('.mission-part').find('[data-obj]').each(function () {
                        var name = $(this).attr('name');
                        var k = $(this).data('key');
                        var v = $(this).data('val');
                        state.stringToObject(name, k, v);
                    });
                    //绑定标题、时间、文件ID
                    $('input[name="snStartTime"]').attr('value', new Date(Date.parse(jsonObj.StartTime.replace(/-/g, "/"))).Format("yyyy-MM-dd"));
                    $('input[name="snEndTime"]').attr('value',new Date(Date.parse(jsonObj.DeadLineTime.replace(/-/g, "/"))).Format("yyyy-MM-dd"));
                    $('input[name="snId"]').attr('value', jsonObj.SmId);

                    //获取督查字号。
                    $.ajax({
                        url: "WebServices/SuperviseMissionWebServices.asmx/GetDistinctSuperviseNumberNameList",
                        type: "post",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.status == "1") {
                               var superviseNumber = data.d.data;
                                var superviseNumberList = JSON.parse(superviseNumber);
                                var optionHtml = '<option value="">请选择</option>';
                                //遍历生成督查字号选项
                                $.each(superviseNumberList, function (index, obj) {
                                    optionHtml += '<option text="' + obj.Name + '" value="' + obj.DeptId + '">' + obj.Name + '</option>';
                                });
                                $('select[name="snName"]').append(optionHtml);
                                //绑定督查字
                                $("select[name='snName'] option[text='" + jsonObj.SpNumberName + "']").attr("selected", true);
                                //绑定年号、字号
                                $("select[name='snYear']").append('<option>' + jsonObj.SpNumberYear + '</option>');
                                $("input[name='snCode']").val(jsonObj.SpNumberCode);
                            }
                            else {
                                layer.msg(data.d.message, { icon: 2 });
                            }
                        },
                        error: function (message) {
                            layer.msg("获取督查字号列表失败！", { icon: 2 });
                        }
                    });


                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2 });
            }
        });

        //获取年号
        $(document).on("change", "select[name='snName']", function (e) {
            var $this = $(e.target);
            var deptId = $this.find('option:selected').val();
            if (deptId == "") {
                return;
            }
            var sName = $this.find("option:selected");
            var name = sName.text();
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
                        $("select[name='snYear']").html('').append(str);
                        $("select[name='snYear']").trigger("change");
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
            var deptId = $("select[name='snName']").val();
            var sName = $("select[name='snName'] option:selected");
            var sYear = $("select[name='snYear'] option:selected");
            var name = sName.text();
            var year = sYear.text();
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
                        $("input[name='snCode']").val(data.d.data);
                    } else {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                }
            });
        });

        //提交事件
        $(document).on('click', '[data-btn="sure"]', function (e) {
            //验证数据有效性
            if (!CheckDataValid('.mission-part .checkInput')) {
                return false;
            }

            var $this = $(e.target);
            var tData = state.page;
            var newData = _.map(tData, function (item, key) {
                var company = [];
                var companyIds = [];
                var office = [];
                var officeIds = [];
                _.map(item, function (v, k) {
                    if (v === undefined) {
                        item[k] = ''
                    }
                });

                var sc = _.map(item['snCompany'], function (sc, k) {
                    if (parseInt(k, 10) === 0) return false
                    company.push(sc);
                    companyIds.push(k);

                    return {
                        company:company,
                        companyIds:companyIds
                        }
                        });
                var so = _.map(item['snOtherCompany'], function (sc, k) {
                    office.push(sc);
                    officeIds.push(k);
                    return {
                        office:office,
                        officeIds:officeIds
                        }
                        });
                var jObj = _.assign({ }, item, {
                            DutyDeptName: company.join(';'),
                            DutyDeptId: companyIds.join(';'),
                            AssistDeptName: office.join(';'),
                            AssistDeptId: officeIds.join(';'),
                        });
                return jObj;
            });

            var postData = { smId: smId, flowId: flowId, leaderMeetingMission: {} };
            var snDeptId = $.trim($('select[name="snName"]').val());
            var snName = $.trim($('select[name="snName"] option:selected').text());
            var snYear = $.trim($('select[name="snYear"]').val());
            var snCode = $.trim($('input[name="snCode"]').val());
            var snText = $.trim($('textarea[name="snText"]').val());
            var snCompanyIds = newData[0].DutyDeptId;
            var snCompany = newData[0].DutyDeptName;
            var snOtherCompany = newData[0].AssistDeptName;
            var snOtherCompanyIds = newData[0].AssistDeptId;
            var snEndTime = $.trim($('input[name="snEndTime"]').val());
            var snStartTime = $.trim($('input[name="snStartTime"]').val());
            postData.leaderMeetingMission = {
                snName: snName, snYear: snYear, snCode: snCode, snText: snText,snDeptId:snDeptId,
                snCompanyIds: snCompanyIds, snCompany: snCompany, snOtherCompany: snOtherCompany,
                snOtherCompanyIds: snOtherCompanyIds, snEndTime: snEndTime, snStartTime: snStartTime
            };

            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/EditMissionDetail",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
        //取消事件
        $(document).on('click', '[data-btn="reset"]', function (e) {
            window.close();
        });

        //主办单位
        $(document).on('click', '[data-btn="snCompany"]', function (e) {
            state.setDeptType('snCompany');
                        });
        //协办单位
        $(document).on('click', '[data-btn="snOtherCompany"]', function (e) {
            state.setDeptType('snOtherCompany');
                        });
        //确定部门
        $(document).on('click', '[data-btn="deptSure"]', function (e) {
            $('[name="' +state.dType + '"]').val(state.getDeptByName());
            $('#company').modal('hide');
        });
    }

    //主办单位填写完成时间
    function RegisterPage3() {
        ////绑定任务详情
        //BindMissionDetail();
        //绑定主办单位信息
        BindMainDeptDetail();
        //初始化时间控件
        showPicker();

        //提交事件
        $(document).on('click', '#submit', function (e) {
            var deadLineTime = $('#DeadLineTime').val();
            var lmmId = $('#LmmId').val();
            if (deadLineTime === '' || deadLineTime === undefined || deadLineTime === null) {
                layer.msg("请先填写完成时间", { icon: 7 });
            }

            var postData = { smId: smId, lmmId: lmmId, flowId: flowId, deadLineTime: deadLineTime }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage3",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                       
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //固定流审批
    function RegisterPage4() {
        //绑定主办单位信息
        BindMainDeptDetail();
        //提交事件
        $(document).on('click', 'button[name="btnSubmit"]', function (e) {
            //验证是否选择了意见类型
            if (!CheckOpinionTypeIsSelected()) {
                return false;
            }

            var $this = $(e.target);
            var allowFlag = $this.data('type');
            var opinion = $.trim($('#opinion').val());
            var opinionType = $('select[name="opinion"]').val();
            //参数检查
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '审批意见')) {
                    return false;
                }
            }

            var postData = { smId: smId, flowId: flowId, allowFlag: allowFlag, opinion: opinion, opinionType: opinionType }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage4",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //办公厅确认
    function RegisterPage5() {
        var step = "BGTQR";
        //预加载不同意时，上一步的主办单位信息
        PrevStepInformationByStep(step);
        //加载所有主办单位信息
        BindMainDeptList();

        // 判断是否还有主办部门未到达BGTQR步骤，如果存在未到达则隐藏“同意”按钮。
        $.ajax({
            type: "POST",
            data: JSON.stringify({ smId: smId, step: step }),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/IsAllPass",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    var isPassed = data.d.data;
                    if (isPassed == "0") {
                        $('button[name="btnSubmit"]').attr('disabled', true);//.attr('title','还有流程未走完。');
                    }
                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2 });
            }
        });

        //同意提交事件
        $(document).on('click', 'button[name="btnSubmit"]', function (e) {
            //验证是否选择了意见类型
            if (!CheckOpinionTypeIsSelected()) {
                return false;
            }

            var $this = $(e.target);
            var allowFlag = $this.data('type');
            var opinion = $.trim($('#opinion').val());
            var opinionType = $('select[name="opinion"]').val();
            var remindType = $("[name='notice2']:checked").val();
            var remindInterval = -1;

            //参数检查
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '审批意见')) {
                    return false;
                }
            }
            if (remindType == "2") {
                remindInterval = 60;
            }
            else if (remindType == "3") {
                remindInterval = $("[name='day2']").val();
                if (!remindInterval) {
                    layer.msg("请输入自定义的提醒天数", { icon: 7 });
                    return;
                }
            } else if (remindType == '4') {
                remindInterval = $("[name='everymonth']").val();
                if (remindInterval == '') {
                    layer.msg("请输入每月几号提醒", { icon: 7 });
                    return;
                }

                if (!/^\d+$/.test(remindInterval)) {
                    layer.msg("输入的数字无效，请输入1到31之间的数字。", { icon: 7 });
                    return;
                }
                var day = parseInt(remindInterval, 10);
                if (day < 1 || day > 31) {
                    layer.msg("请输入1到31之间的数字。", { icon: 7 });
                    return;
                }
            }

            var postData = { smId: smId, flowId: flowId, remindType: remindType, remindInterval: remindInterval, allowFlag: allowFlag, opinion: opinion, opinionType: opinionType, flowids: [] };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage5",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });

        //不同意提交事件
        $(document).on('click', 'button[name="btn-disagree-confirm"]', function (e) {
            //验证是否选择了意见类型
            if (!CheckOpinionTypeIsSelected()) {
                return false;
            }

            var $this = $(e.target);
            var allowFlag = 0;
            var opinion = $('#opinion').val();
            var opinionType = $('select[name="opinion"]').val();
            var checkDepts = $("#returnDeptList :checked");
            var flowids = [];
            for (var k = 0; k < checkDepts.length; k++) {
                var tempid = $(checkDepts[k]).data("flowid");
                if (tempid)
                    flowids.push(tempid);
            }
            if (flowids.length < 1) {
                layer.msg("请选择退回的主办单位", { icon: 7 });
                return;
            }

            var postData = { smId: smId, flowId: flowId, remindType: -1, remindInterval: -1, allowFlag: allowFlag, opinion: opinion, opinionType: opinionType, flowids: flowids }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage5",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //主办单位任务推进
    function RegisterPage6() {
        //加载所有主办单位信息
        BindMainDeptList();
        //任务反馈进度
        $(document).on('click', '.btn-primary-c', function (e) {
            SendPage6(1);
        });

        //继续分解
        $(document).on('click', '.btn-default-c', function (e) {
            SendPage6(2);
        });

        function SendPage6(sendType) {
            var postData = { smId: smId, flowId: flowId, type: sendType }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage6",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            if (data.d.data !== null && data.d.data !== '' && data.d.data !== undefined && sendType == 2) {
                                //构造参数，跳转"措施分解"页面
                                var stepid = 'CSFJ';
                                var url = 'LeaderMeetingMissionDetail.aspx?smid=' + smId + '&flowid=' + data.d.data + '&smtype=' + smType + '&stepid=' + stepid + '&pagetype=FormPage';
                                window.location.href = url;
                            }
                            else {
                                window.close();
                            }
                            //这里先暂时关闭当前页面吧，如后期需优化再说
                            //window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        }
    }

    //任务反馈
    function RegisterPage7() {
        //注册上传附件方法
        Upload();
        //注册限制完成进度只能填数字的方法
        cm.numInput();

        //绑定完成进度、最新反馈与附件相关
        var postData = { smId: smId, flowId: flowId}
        $.ajax({
            type: "POST",
            data: JSON.stringify(postData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetLeaderMeetingMissionFeedbackDetail",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    if (data.d.data === "") {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                    else {
                        var jsonObj = JSON.parse(data.d.data);
                        //防止第一次反馈时，完成进度赋值为0
                        if (jsonObj.FinishPercent !== "" && jsonObj.FinishPercent !== null && jsonObj.FinishPercent !== undefined) {
                            //$('#opinion').val(jsonObj.Opinion);
                            $('#finishPercent').val(jsonObj.FinishPercent);
                        }
                        //绑定主办单位与完成时间
                        $('#lmmId').html(jsonObj.LmmId);
                        $('#DeptName').html(jsonObj.DeptName).attr('title', jsonObj.DeptName);
                        $('#DeadLineTime').html(jsonObj.DeadLineTime);

                        //绑定附件相关
                        $('input[type="file"]').attr('data-id', jsonObj.LmmId);
                        $('.attchmentList').attr('data-id', jsonObj.LmmId);

                        //绑定附件列表
                        LoadAttchmentList($('.attchmentList'), jsonObj.LmmId);
                    }

                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2 });
            }
        });

        //提交反馈
        $(document).on('click', '.btn-primary-c', function (e) {
            //验证数据有效性
            if (!CheckDataValid('.checkInputForRWFK')) {
                return false;
            }
            var finishPercent = $.trim($('#finishPercent').val());
            var opinion = $.trim($('#opinion').val());
            var lmmId = $.trim($('#lmmId').html());
            
            if (!CheckStringLength(opinion, HOST_DEPT_FEEDBACK_MAX_LENGTH, '最新反馈')) {
                return false;
            }

            var postData = { smId: smId, lmmId: lmmId, flowId: flowId, finishPercent: finishPercent, opinion: opinion }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage7",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //措施分解
    function RegisterPage8() {
        //绑定当前主办单位信息
        var postData = { smId: smId, flowId: flowId }
        $.ajax({
            type: "POST",
            data: JSON.stringify(postData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/GetLeaderMeetingMissionFeedbackDetail",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    if (data.d.data === "") {
                        layer.msg(data.d.message, { icon: 2 });
                    }
                    else {
                        var jsonObj = JSON.parse(data.d.data);
                        //绑定主办单位与完成时间
                        $('#lmmId').html(jsonObj.LmmId);
                        $('#DeptName').html(jsonObj.DeptName).attr('title', jsonObj.DeptName);
                        $('#DeadLineTime').html(jsonObj.DeadLineTime);
                    }

                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, { icon: 2 });
                }
                else {
                    layer.alert(data.d.message, { icon: 2 });
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", { icon: 2 });
            }
        });

        //提交事件
        $(document).on('click', '.main .btn-primary-c', function (e) {
            var lmmId = $.trim($('#lmmId').html());
            var postData = { smId: smId, flowId: flowId, lmmId: lmmId, measureList: [] };
            if (state.page.length === 0) {
                layer.msg('请先添加措施', { icon: 7 });
                return false;
            }
            for (var i = 0; i < state.page.length; i++) {
                if (!state.page[i].isDel) {
                    //必填项非空检查
                    if (isNotNull(state.page[i].text)) {
                        layer.msg('措施内容不能为空', { icon: 7 });
                        return false;
                    }
                    if (isNotNull(getCodeAndName(state.page[i].office).keys)) {
                        layer.msg('请选择责任处室', { icon: 7 });
                        return false;
                    }
                    if (isNotNull(state.page[i].endTime)) {
                        layer.msg('请选择完成时间', { icon: 7 });
                        return false;
                    }

                    //检查措施内容长度，防止修改后超出限制长度
                    if (!CheckStringLength(state.page[i].text, MEASURE_MAX_LENHTH, '措施')) {
                        return false;
                    }

                    var Name = state.page[i].text;
                    var AssDeptNames = getCodeAndName(state.page[i].company).values;
                    var AssDeptIds = getCodeAndName(state.page[i].company).keys;
                    var DeadLineTime = state.page[i].endTime;
                    var DutyDeptName = getCodeAndName(state.page[i].office).values;
                    var DutyDeptId = getCodeAndName(state.page[i].office).keys;
                    var MeasureItem = {
                        Name: Name, AssDeptNames: AssDeptNames, AssDeptIds: AssDeptIds
                        , DeadLineTime: DeadLineTime, DutyDeptName: DutyDeptName, DutyDeptId: DutyDeptId,
                    }

                    postData.measureList.push(MeasureItem);
                }
            }

            if (postData.measureList.length === 0) {
                layer.msg('请先添加措施', { icon: 7 });
                return false;
            }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage8",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, { icon: 2 });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", { icon: 2 });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //责任处室处理措施
    function RegisterPage9() {
        //措施反馈进度
        $(document).on('click', '.btn-primary-c', function (e) {
            SendPage9(1);
        });

        //继续分解
        $(document).on('click', '.btn-default-c', function (e) {
            SendPage9(2);
        });

        function SendPage9(sendType) {
            var postData = { smId: smId, flowId: flowId, type: sendType }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(postData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage9",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            if (data.d.data !== null && data.d.data !== '' && data.d.data !== undefined && sendType == 2) {
                                //构造参数，跳转"责任处室分解子措施"页面
                                var stepid = 'ZRCSFJZCS';
                                var url = 'LeaderMeetingMissionDetail.aspx?smid=' + smId + '&flowid=' + data.d.data + '&smtype=' + smType + '&stepid=' + stepid + '&pagetype=FormPage';
                                window.location.href = url;
                            }
                            else {
                                window.close();
                            }
                        });

                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        }
    }

    //措施反馈
    function RegisterPage10() {
        //注册上传附件方法
        Upload();
        //遍历并绑定附件列表信息
        var $attchmentUl = $('.attchmentList');
        if ($attchmentUl.length !== 0) {
            $.each($attchmentUl, function (index, obj) {
                LoadAttchmentList($(obj), $(obj).data('id'));
            });
        }

        //注册限制完成进度只能填数字的方法
        cm.numInput();

        //措施进度反馈事件
        $(document).on('click', '.btn10Submit', function (e) {
            var $this = $(e.target);
            var TargetId = $this.attr('data-targetId');
            var ItemId = $this.attr('data-itemId');
            var ItemFlowId = $this.attr('data-flowid');

            //验证数据有效性
            //以ItemId构造一个自定义类名，防止同一个人反馈多个措施时，数据验证方法无法正确定位对应的措施输入框组
            if (!CheckDataValid('div[class*=' + ItemId + '_Div]')) {
                return false;
            }

            //通过遍历输出措施时的Id规则，获取对应的值
            var Finsh_Precent = $.trim($('#' + ItemId + '_FinshPrecent').val());
            var Opinion = $.trim($('#' + ItemId + '_Opinion').val());

            //参数检查
            if (!CheckStringLength(Opinion, MEASURE_FEEDBACK_MAX_LENGTH, '最新反馈')) {
                return false;
            }

            var jsonData = { smId: smId, flowid: flowId, entity: { TargetId: TargetId, ItemId: ItemId, Finsh_Precent: Finsh_Precent, Opinion: Opinion, FlowId: ItemFlowId } };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage10",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //责任处室分解子措施
    function RegisterPage11() {
        $(document).on('click', '#btnSubmit', function () {
            if (state.page.length === 0) {
                layer.msg('请先添加子措施', { icon: 7 });
                return false;
            }

            var data = { smId: smId, flowid: flowId, subMeasures: [] };
            for (var i = 0; i < state.page.length; i++) {
                if (!state.page[i].isDel) {
                    //必填项非空检查
                    if (isNotNull(state.page[i].text)) {
                        layer.msg('子措施内容不能为空', { icon: 7 });
                        return false;
                    }
                    if (isNotNull(getCodeAndName(state.page[i].person).keys)) {
                        layer.msg('请选择责任人', { icon: 7 });
                        return false;
                    }
                    if (isNotNull(state.page[i].endTime)) {
                        layer.msg('请选择完成时间', { icon: 7 });
                        return false;
                    }
                    //检查子措施内容长度，防止修改后超出限制长度
                    if (!CheckStringLength(state.page[i].text, SUB_MEASURE_MAX_LENHTH, '子措施')) {
                        return false;
                    }

                    var TargetId = state.page[i].targetId;
                    var MeasureId = state.page[i].measureId;
                    var ItemName = state.page[i].text;
                    var AssDeptName = getCodeAndName(state.page[i].company).values;
                    var AssDeptId = getCodeAndName(state.page[i].company).keys;
                    var DeadLine = state.page[i].endTime;
                    var DutyUserName = getCodeAndName(state.page[i].person).values;
                    var DutyUserId = getCodeAndName(state.page[i].person).keys;
                    var SubMeasureItem = { TargetId: TargetId, MeasureId: MeasureId, ItemName: ItemName, AssDeptName: AssDeptName, AssDeptId: AssDeptId, DeadLine: DeadLine, DutyUserName: DutyUserName, DutyUserId: DutyUserId };

                    data.subMeasures.push(SubMeasureItem);
                }
            }

            if (data.subMeasures.length === 0) {
                layer.msg('请先添加子措施', { icon: 7 });
                return false;
            }
            else {
                //所有可分解的措施，必须至少分解一个才能提交
                var measureCount = $('[data-measureid]').length;//可分解的措施个数
                var arryMeasureCount = 0;   //当前已分解的措施个数
                var measureIdArry = _.map(data.subMeasures, 'MeasureId');//当前数组中的措施ID集合
                var newArry = _.uniq(measureIdArry);//对措施ID集合进行去重处理
                if (newArry.length != measureCount) {
                    layer.msg('请先添加子措施', { icon: 7 });
                    return false;
                }
            }
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(data),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage11",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //子措施反馈
    function RegisterPage12() {
        //注册上传附件方法
        Upload();
        //遍历并绑定附件列表信息
        var $attchmentUl = $('.attchmentList');
        if ($attchmentUl.length !== 0) {
            $.each($attchmentUl, function (index, obj) {
                LoadAttchmentList($(obj), $(obj).data('id'));
            });
        }

        //注册限制完成进度只能填数字的方法
        cm.numInput();

        //子措施进度反馈事件
        $(document).on('click', '.btn12Submit', function (e) {
            var $this = $(e.target);
            var TargetId = $this.attr('data-targetId');
            var ItemId = $this.attr('data-itemId');
            var ItemFlowId = $this.attr('data-flowid');

            //验证数据有效性
            //以ItemId构造一个自定义类名，防止同一个人反馈多个子措施时，数据验证方法无法正确定位对应的子措施输入框组
            if (!CheckDataValid('div[class*=' + ItemId + '_Div]')) {  
                return false;
            }
            
            //通过遍历输出子措施时的Id规则，获取对应的值
            var Finsh_Precent = $.trim($('#' + ItemId + '_FinshPrecent').val());
            var Opinion = $.trim($('#' + ItemId + '_Opinion').val());

            //参数检查
            if (!CheckStringLength(Opinion, SUB_MEASURE_FEEDBACK_MAX_LENGTH, '最新反馈')) {
                return false;
            }

            var jsonData = { smId: smId, flowid: flowId, entity: { TargetId: TargetId, ItemId: ItemId, Finsh_Precent: Finsh_Precent, Opinion: Opinion, FlowId: ItemFlowId } };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage12",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });
    }

    //责任处室措施反馈
    function RegisterPage13() {
        //注册限制完成进度只能填数字的方法
        cm.numInput();

        //退回模态窗口打开前事件
        $('#backModal').on('show.bs.modal', function (e) {
            //判断当前子措施是否已发送至责任处室措施反馈步骤
            var $releated = $(e.relatedTarget); //获取触发器的元素（即哪个子措施对应的"退回"按钮对象）
            var flowId = $.trim($releated.attr('data-flowId'));
            if (flowId === '' || flowId === null || flowId === undefined) {
                layer.msg('当前子措施尚未反馈', { icon: 7, time: 2000 });
                return false;
            }
            //将当前操作的子措施流程ID赋值至模态框"确定"按钮对象
            var $this = $(e.target);
            $this.find('[data-sure="agree"]').attr('data-flowId', flowId);
            
        });

        //退回处理
        $(document).on('click', '[data-sure="agree"]', function (e) {
            var $this = $(e.target);
            var opinion = $.trim($('#backReason').val());
            if (opinion !== '' && opinion !== null && opinion !== undefined && opinion.length > 100) {
                layer.msg('退回理由最大长度不能超过100个字符', { icon: 7, time: 2000 });
            }
            var flowId = $this.attr('data-flowId');

            var jsonData = { smId: smId, flowId: flowId, opinion: opinion };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendBackByZRCSCSFK",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });

        //监听发送下一步模态框打开前事件
        $('#agreeModal').on('show.bs.modal', function (e) {
            //这里的flowId要取当前措施对应子措施的其中一个的flowId
            var $releated = $(e.relatedTarget); //获取触发器的元素（即哪个措施对应的"同意"按钮对象）
            //获取当前措施的任意子措施的flowId
            var $subItem = $releated.closest('.ItemDiv').find('[data-flowId]');
            var currentFlowId='';
            $.each($subItem, function (index, obj) {
                var tempFlowId = $(obj).attr('data-flowId');
                if (tempFlowId !== null && tempFlowId !== undefined && tempFlowId !== '') {
                    currentFlowId = tempFlowId;
                    return false;
                }
            });
            if (currentFlowId === '') {
                layer.msg('获取当前措施的流程ID出错，请刷新待办列表重新进入页面！', { icon: 2, time: 3000 });
                return false;
            }
            BindFreeStepList("ZRCSCSFK", currentFlowId);
        });

        //发送事件
        $('#agreeModal').on('click', '.btn-primary-s', function (e) {
            //验证数据有效性
            if (!CheckDataValid('#agreeModal .checkInput')) {
                return false;
            }

            var $this = $(e.target);
            var $modal = $this.closest('#agreeModal');
            var requestFlowId = $modal.find('#stepList').attr('data-reuqestflowid');
            var $nextStep = $modal.find('#stepList').children('.active').children('a');
            var $nextStepUser = $modal.find('#stepUserList').children('.active').find('input[name="nextStepUser"]:checked');
            var finishPercent = $.trim($modal.find('#finishPercent_Modal').val());
            var opinion = $.trim($modal.find('#opinion_Modal').val());
            var nextStepId = $nextStep.data('stepid');
            var nextStepName = $nextStep[0].innerText;
            var nextUserId = $nextStepUser.val();
            var roleType = $nextStepUser.attr('data-roletype');

            //参数检查
            if (!CheckStringLength(opinion, MEASURE_FEEDBACK_MAX_LENGTH, '反馈意见')) {
                return false;
            }
            if (nextStepId === '' || nextStepId === undefined || nextStepId === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextStepName === '' || nextStepName === undefined || nextStepName === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextUserId === '' || nextUserId === undefined || nextUserId === null) {
                layer.msg("请先选择当前骤对应的处理部门/处理人信息", { icon: 7 });
                return false;
            }
            var nextUserName = $nextStepUser.parent()[0].innerText;
            var jsonData = {
                smId: smId, flowId: requestFlowId,
                entity: {
                    TargetId: '', Percent: finishPercent, Opinion: opinion,
                    NextStep: {
                        StepId: nextStepId, StepName: nextStepName, UserId: nextUserId, UserName: nextUserName, RoleType: roleType
                    }
                }
            };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage13",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
            
        });

    }

    //主办单位任务反馈
    function RegisterPage14() {
        //注册限制完成进度只能填数字的方法
        cm.numInput();

        //退回模态窗口打开前事件
        $('#backModal').on('show.bs.modal', function (e) {
            //判断当前措施是否已发送至审核步骤
            var $releated = $(e.relatedTarget); //获取触发器的元素（即哪个措施对应的"退回"按钮对象）
            var flowId = $.trim($releated.attr('data-flowId'));
            if (flowId === '' || flowId === null || flowId === undefined) {
                layer.msg('当前措施尚未反馈', { icon: 7, time: 2000 });
                return false;
            }
            //将当前操作的措施流程ID赋值至模态框"确定"按钮对象
            var $this = $(e.target);
            $this.find('[data-sure="agree"]').attr('data-flowId', flowId);

        });

        //退回处理
        $(document).on('click', '[data-sure="agree"]', function (e) {
            var $this = $(e.target);
            var opinion = $.trim($('#backReason').val());
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '退回理由')) {
                    return false;
                }
            }
            var flowId = $this.attr('data-flowId');

            var jsonData = { smId: smId, flowId: flowId, opinion: opinion };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendBackByZBDWRWFK",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });

        //监听发送下一步模态框打开前事件
        $('#agreeModal').on('show.bs.modal', function (e) {
            //这里的flowId要取当前主办单位对应措施的其中一个的flowId
            var $releated = $(e.relatedTarget); //获取触发器的元素（即哪个措施对应的"同意"按钮对象）
            //获取当前主办单位的任意措施的flowId
            var $subItem = $releated.closest('.ItemDiv').find('[data-flowId]');
            var currentFlowId = '';
            $.each($subItem, function (index, obj) {
                var tempFlowId = $(obj).attr('data-flowId');
                if (tempFlowId !== null && tempFlowId !== undefined && tempFlowId !== '') {
                    currentFlowId = tempFlowId;
                    return false;
                }
            });
            if (currentFlowId === '') {
                layer.msg('获取当前措施的流程ID出错，请刷新待办列表重新进入页面！', { icon: 2, time: 3000 });
                return false;
            }
            BindFreeStepList("ZBDWRWFK", currentFlowId);
        });

        //发送事件
        $('#agreeModal').on('click', '.btn-primary-s', function (e) {
            //验证数据有效性
            if (!CheckDataValid('#agreeModal .checkInput')) {
                return false;
            }

            var $this = $(e.target);
            var $modal = $this.closest('#agreeModal');
            var requestFlowId = $modal.find('#stepList').attr('data-reuqestflowid');
            var $nextStep = $modal.find('#stepList').children('.active').children('a');
            var $nextStepUser = $modal.find('#stepUserList').children('.active').find('input[name="nextStepUser"]:checked');
            var finishPercent = $.trim($modal.find('#finishPercent_Modal').val());
            var opinion = $.trim($modal.find('#opinion_Modal').val());
            var nextStepId = $nextStep.data('stepid');
            var nextStepName = $nextStep[0].innerText;
            var nextUserId = $nextStepUser.val();
            var roleType = $nextStepUser.attr('data-roletype');

            //参数检查
            if (!CheckStringLength(opinion, HOST_DEPT_FEEDBACK_MAX_LENGTH, '反馈意见')) {
                return false;
            }
            if (nextStepId === '' || nextStepId === undefined || nextStepId === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextStepName === '' || nextStepName === undefined || nextStepName === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextUserId === '' || nextUserId === undefined || nextUserId === null) {
                layer.msg("请先选择当前骤对应的处理部门/处理人信息", { icon: 7 });
                return false;
            }
            var nextUserName = $nextStepUser.parent()[0].innerText;
            var jsonData = {
                smId: smId, flowId: requestFlowId,
                entity: {
                    TargetId: '', Percent: finishPercent, Opinion: opinion,
                    NextStep: {
                        StepId: nextStepId, StepName: nextStepName, UserId: nextUserId, UserName: nextUserName, RoleType: roleType
                    }
                }
            };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage14",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });

        });
    }

    //办公厅任务反馈 
    function RegisterPage15() {
        //注册限制完成进度只能填数字的方法
        cm.numInput();

        //退回模态窗口打开前事件
        $('#backModal').on('show.bs.modal', function (e) {
            //判断当前主办单位是否已发送至审核步骤
            var $releated = $(e.relatedTarget); //获取触发器的元素（即哪个主办单位对应的"退回"按钮对象）
            var flowId = $.trim($releated.attr('data-flowId'));
            if (flowId === '' || flowId === null || flowId === undefined) {
                layer.msg('当前主办单位尚未反馈', { icon: 7, time: 2000 });
                return false;
            }
            //将当前操作的主办单位流程ID赋值至模态框"确定"按钮对象
            var $this = $(e.target);
            $this.find('[data-sure="agree"]').attr('data-flowId', flowId);

        });

        //退回处理
        $(document).on('click', '[data-sure="agree"]', function (e) {
            var $this = $(e.target);
            var opinion = $.trim($('#backReason').val());
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '退回理由')) {
                    return false;
                }
            }
            var flowId = $this.attr('data-flowId');

            var jsonData = { smId: smId, flowId: flowId, opinion: opinion };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendBackByBGTRWFK",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });

        //监听发送下一步模态框打开前事件
        $('#agreeModal').on('show.bs.modal', function (e) {
            //这里的flowId取当前url的即可
            if (flowId === '') {
                layer.msg('获取当前主办单位的流程ID出错，请刷新待办列表重新进入页面！', { icon: 2, time: 3000 });
                return false;
            }
            BindFreeStepList("BGTRWFK", flowId);
        });

        //发送事件
        $('#agreeModal').on('click', '.btn-primary-s', function (e) {
            //验证数据有效性
            if (!CheckDataValid('#agreeModal .checkInput')) {
                return false;
            }

            var $this = $(e.target);
            var $modal = $this.closest('#agreeModal');
            var $nextStep = $modal.find('#stepList').children('.active').children('a');
            var $nextStepUser = $modal.find('#stepUserList').children('.active').find('input[name="nextStepUser"]:checked');
            var finishPercent = $.trim($modal.find('#finishPercent_Modal').val());
            var opinion = $.trim($modal.find('#opinion_Modal').val());
            var nextStepId = $nextStep.data('stepid');
            var nextStepName = $nextStep[0].innerText;
            var nextUserId = $nextStepUser.val();
            var roleType = $nextStepUser.attr('data-roletype');
            var nextUserName = '';
            //参数检查
            if (!CheckStringLength(opinion, MISSION_FEEDBACK_MAX_LENGTH, '反馈意见')) {
                return false;
            }
            if (nextStepId === '' || nextStepId === undefined || nextStepId === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextStepId !== "JS" && nextStepId !== "FKJS") {
                if (nextStepName === '' || nextStepName === undefined || nextStepName === null) {
                    layer.msg("请先选择下一步骤信息", { icon: 7 });
                    return false;
                }
                if (nextUserId === '' || nextUserId === undefined || nextUserId === null) {
                    layer.msg("请先选择当前骤对应的处理部门/处理人信息", { icon: 7 });
                    return false;
                }
                nextUserName = $nextStepUser.parent()[0].innerText;
            }
            var jsonData = {
                smId: smId, flowId: flowId,
                entity: {
                    TargetId: '', Percent: finishPercent, Opinion: opinion,
                    NextStep: {
                        StepId: nextStepId, StepName: nextStepName, UserId: nextUserId, UserName: nextUserName, RoleType: roleType
                    }
                }
            };
            if (nextStepId === "JS") {
                layer.confirm('是否确认结束整个流程？', { btn: ['确认', '取消'] }, function () {
                    SendPage15(jsonData);
                }, function () {
                });
            }
            else {
                SendPage15(jsonData);
            }
        });
    }

    //办公厅任务反馈发送
    function SendPage15(jsonData) {
        ShowLoading();
        $.ajax({
            type: "POST",
            data: JSON.stringify(jsonData),
            url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPage15",
            contentType: 'application/json;charset=utf-8',
            dataType: "json",
            success: function (data) {
                if (data.d.status == "1") {
                    layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                        window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                    });
                } else if (data.d.status == "0") {
                    layer.msg(data.d.message, {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
                else {
                    layer.alert(data.d.message, {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            },
            error: function (xhr, textStatus) {
                layer.msg("请求发生异常", {
                    icon: 2
                });
                layer.close(loadingIndex);
            }
        });
    }

    //部门审核、部门审批、秘书处理发送处理
    function RegisterPage17() {
        //审核审批步骤隐藏意见下拉框
        if (page == "17") {
            $('.opinion-type').hide();
        }

        //监听发送下一步模态框打开前事件
        $('#agreeModal').on('show.bs.modal', function (e) {
            //领导发送的处理
            if (isLeader==="True") {
                SendByLeader('1');
                return false;
            }
            //秘书处理步骤验证是否选择了意见类型
            if (page == "18") {
                if (!CheckOpinionTypeIsSelected()) {
                    return false;
                }
            }

            //当前步骤无需输入完成进度、反馈意见相关信息
            $('.feedback-details').hide();
            var currentStep = getQueryString('stepid');
            BindFreeStepList(currentStep, flowId);
        });

        //同意事件
        $('#agreeModal').on('click', '.btn-primary-s', function (e) {
            var $this = $(e.target);
            var opinion = $.trim($('#opinion').val());
            var opinionType = $('select[name="opinion"]').val();
            var $modal = $this.closest('#agreeModal');
            var $nextStep = $modal.find('#stepList').children('.active').children('a');
            var $nextStepUser = $modal.find('#stepUserList').children('.active').find('input[name="nextStepUser"]:checked');
            var nextStepId = $nextStep.data('stepid');
            var nextStepName = $nextStep[0].innerText;
            var nextUserId = $nextStepUser.val();
            var roleType = $nextStepUser.attr('data-roletype');

            //参数检查
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '审批意见')) {
                    return false;
                }
            }
            if (nextStepId === '' || nextStepId === undefined || nextStepId === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextStepName === '' || nextStepName === undefined || nextStepName === null) {
                layer.msg("请先选择下一步骤信息", { icon: 7 });
                return false;
            }
            if (nextUserId === '' || nextUserId === undefined || nextUserId === null) {
                layer.msg("请先选择当前骤对应的处理人信息", { icon: 7 });
                return false;
            }
            var nextUserName = $nextStepUser.parent()[0].innerText;
            var jsonData = {
                smId: smId, flowId: flowId, opinion: opinion, opinionType: opinionType, nextStep: {
                    StepId: nextStepId, StepName: nextStepName, UserId: nextUserId, UserName: nextUserName, RoleType: roleType
                }
            };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPageByFreeFlow",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });

        });

        //不同意事件
        $(document).on('click', '.btn-default-c', function (e) {
            //领导发送的处理
            if (isLeader === "True") {
                SendByLeader('0');
                return false;
            }
            var opinion = $.trim($('#opinion').val());
            var opinionType = $('select[name="opinion"]').val();
            //参数检查
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '审批意见')) {
                    return false;
                }
            }
            var jsonData = { smId: smId, flowId: flowId, opinion: opinion, opinionType: opinionType };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/ReurnBackPrevStep",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        });

        //领导发送的处理
        function SendByLeader(allowFlag) {
            var opinion = $.trim($('#opinion').val());
            //参数检查
            if (opinion !== '' && opinion !== null && opinion !== undefined) {
                if (!CheckStringLength(opinion, OPINION_MAX_LENGTH, '审批意见')) {
                    return false;
                }
            }
            var jsonData = { smId: smId, flowId: flowId, opinion: opinion, allowFlag: allowFlag };
            ShowLoading();
            $.ajax({
                type: "POST",
                data: JSON.stringify(jsonData),
                url: "WebServices/LeaderMeetingMissionWebService.asmx/SendPageForLeader",
                contentType: 'application/json;charset=utf-8',
                dataType: "json",
                success: function (data) {
                    if (data.d.status == "1") {
                        layer.msg(data.d.message, { icon: 1, time: 1500 }, function () {
                            window.close();// 成功后要关闭窗口或置为不可点击，否则用户重复点击会报错。
                        });
                    } else if (data.d.status == "0") {
                        layer.msg(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                    else {
                        layer.alert(data.d.message, {
                            icon: 2
                        });
                        layer.close(loadingIndex);
                    }
                },
                error: function (xhr, textStatus) {
                    layer.msg("请求发生异常", {
                        icon: 2
                    });
                    layer.close(loadingIndex);
                }
            });
        }
    }
   

    return {
        CheckStringLength: CheckStringLength,
        MEASURE_MAX_LENHTH: MEASURE_MAX_LENHTH,
        SUB_MEASURE_MAX_LENHTH: SUB_MEASURE_MAX_LENHTH,
        CurrentPage: page
    }
});