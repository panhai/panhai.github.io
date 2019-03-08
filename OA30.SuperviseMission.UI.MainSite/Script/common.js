'use strict';

define(function (require) {
    var dept = require('Dept')
    var state = require('state')
    var man = require('Man')
    require('picker')
    //设置值
    //state.setState({
    //    single: false,
    //    company: {},
    //    deptGroup: {}
    //})
    //获取部门信息
    function getDept(data) {
        state.setfDept(data)
        dept.setData(data, state.getSingle())
        dept.init()
    }
    //获取部门分组
    function getDeptGroup(data) {
        state.setDeptGroup(data)
        dept.setDeptGroup()
    }
    //搜索责任人
    function getPerson(data) {
        console.log(data)
        man.search(data)
    }
    //时间控件
    function showPicker() {
        $('.input-time').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            format:'yyyy-mm-dd',
            startView: 2,
            startDate:new Date(),
            minView: 2,
            forceParse: 0
        }).on('changeDate', function (ev) {
            var $name = $(ev.target).attr('name');
            console.log($(ev.target).val())
            var $val = $(ev.target).val()
            if ($name) {
                state.setValue($name, $val)
            }
            state.setValue('endTime', $val)
            console.log(state)
        })
    }
    
    //限制输入数字，可小数
    function numInput() {
        $(document).on('keyup', '[data-type="num"]', function (e) {
            var $this = $(e.target);
            var $val = $this.val();
            var $newValue = $val.replace(/[^1-9]/g, '');
            if ($val.length == 1) {
                $newValue = $val.replace(/[^1-9]/g, '');
            } else {
                $newValue = $val.replace(/\D/g, '');
                if ($newValue > 100) {
                    $newValue = 100;
                }
            }
            $this.val($newValue);
        })
        $(document).on('afterpaste', '[data-type="num"]', function (e) {

        })
    }
    //获取部门组列表。
    function initDept() {
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetGroupListByUser",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                var deptGroup = JSON.parse($(data).find("data").text());
                getDeptGroup(deptGroup);
            },
            error: function (message) {
                alert("获取部门组列表失败！");
            }
        });
    }
    //获取部门列表。
    function initDeptGroup() {
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetAllActiveDeptList",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                var dept = JSON.parse($(data).find("data").text());
                getDept(dept);
            },
            error: function (message) {
                alert("获取部门列表失败！");
            }
        });
    }
                        
    function resetTextarea(selector) {
        //textarea高度自适应
        var cName = selector ? ('textarea' + selector) : '.main textarea:not()';
        $(document).on("keyup", cName, function () {
            var $this = $(this);
            if (!$this.attr('initAttrH')) {
                $this.attr('initAttrH', $this.outerHeight());
            }
            $this.css({ height: $this.attr('initAttrH'), 'overflow-y': 'hidden' }).height(this.scrollHeight - 16).parent().height(this.scrollHeight - 16);
        })
    }

    return {
        getDept: getDept,
        getDeptGroup: getDeptGroup,
        resetTextarea: resetTextarea,
        showPicker: showPicker,
        getPerson: getPerson,
        numInput: numInput,
        initDept: initDept,
        initDeptGroup: initDeptGroup,
    }
});