'use strict';

define('Man', function (require) {
    var _ = require('lodash');
    var $ = require('jquery');
    var state = require('state');

    function Man() {
        this.init();
    }
    Man.prototype.init = function () {
        $('body').append(this.html())
    }
    //处理单选或多选
    Man.prototype.initDept = function (data, single) {
        var html = ['<ul class="list-unstyled">'];
        var type = single ? 'radio' : 'checkbox';
        if (data.length > 0) {
            _.map(data, function (item, index) {
                var check = ''
                if (item.check) {
                    check = ' checked="true"'
                }
                html.push('<li><div class="',
                    type,
                    '">',
                    '<label><input type=',
                    type,
                    check,
                    ' value="',
                    item.DeptId,
                    '" name="dept"/>',
                    item.DeptName,
                    '</label></div></li>')
            })
        }
        html.push('</ul>');
        return html.join('')
    }
    //加载数据
    Man.prototype.setData = function (data, single) {
        this.single = single
        if (typeof data === 'object') {
            this.dept = data;
        } else {
            throw new Error('数据为空或格式不正确');
        }
    }
    //加载分组数据
    Man.prototype.setGroupData = function (data) {
        if (typeof data === 'object') {
            this.gDept = data;
        } else {
            throw new Error('数据为空或格式不正确');
        }
    }
    //显示选中部门
    Man.prototype.chooseMan = function (data) {
        var html = [];
        _.map(data, function (item, key) {
            html.push(
                '<span',
                ' data-deptid="',
                key,
                '">',
                item,
                '(',
                key,
                ')',
                ';</span>'
            )
        })
        $('.result-man').html(html.join(''));
    }

    //刷新部门
    Man.prototype.refresh = function (data, single) {
        var html = ['<ul class="list-unstyled">'];
        var type = single ? 'radio' : 'checkbox';
        if (data.length > 0) {
            _.map(data, function (item, index) {
                var check = ''
                if (item.check) {
                    check = ' checked="true"'
                }
                html.push('<li><div class="',
                    type,
                    '">',
                    '<label><span class="iconfont icon-sv-user"></span><input type=',
                    type,
                    check,
                    ' data-name="',
                    item.Name,
                    '" value="',
                    item.Employee_ID,
                    '" name="dept"/>',
                    item.Name,
                    '(',
                    item.Employee_ID,
                    ')-',
                    item.Dept_Name,
                    '</label></div></li>')
            })
        }
        html.push('</ul>')
        $('.choose-man').html(html.join(''));
    }
    //加载责任人样式
    Man.prototype.html = function () {
        var html = ['<div class= "modal" tabindex = "-1" role = "dialog" id = "leaderModal" data-backdrop="static" data-keyboard="false" style = "display: none;" >',
            '<div class="modal-dialog" role="document" style="width: 600px;">',
                '<div class="modal-content">',
                    '<div class="modal-header">',
                        '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>',
                        '<h4 class="modal-title">选择责任人</h4>',
                    '</div>',
                    '<div class="modal-body">',
                        '<div class="input-group">',
                            '<input type="text" class="form-control" id="textAssLeader" placeholder="请输入员工号或姓名">',
                                '<div class="input-group-addon" id="btSearchAssLeader">',
                                    '<span class="iconfont icon-sv-search"></span>',
                                '</div>',
                        '</div>',
                            '<div class="choose-man">',
                                '<ul class="list-unstyled" id="ulAssLeader">',
                                '</ul>',
                            '</div>',
                            '<div id="assLeaderSelectedList" class="result-man" data-value="" data-text=""></div>',
                        '</div>',
                        '<div class="form-group tac">',
                            '<button id="btConfirmSelectAssLeader" type="button" class="btn btn-primary-c">确定</button>',
                            '<button id="btResetSelectAssLeader" type="button" class="btn btn-default-c" data-dismiss="modal">取消</button>',
                        '</div>',
                    '</div>',
                '</div>',
            '</div>'];
        return html.join('');
    };
    
    //责任人搜索
    Man.prototype.search = function (data) {
        this.refresh(data, state.getSingle());
    }
    
    //选择责任人
    $(document).on('click', '#leaderModal li input', function (e) {
        var $this = $(e.target);
        var name = $this.data('name');
        var value = $this.val();
        state.setDeptType(state.dType);
        if ($this.prop('checked')) {
            state.setValue(state.dType, [value,name], state.getSingle())
        } else {
            state.deleteValue($this.val(), state.dType)
        }
        Man.prototype.chooseMan(state.getDept())
    })
   
    //责任人
    $(document).on('click', '[name="leader"]', function (e) {
        var $this = $(this);
        var $box = $this.closest('[data-index]').data('index');
        state.setPage($box);
        state.setDeptType('leader');
        Man.prototype.chooseMan(state.getDept());
    })
    $(document).on('click', '[name="employ"]', function (e) {
        var $this = $(this);
        var $box = $this.closest('[data-index]').data('index');
        state.setPage($box);
        state.setDeptType('employ');
        Man.prototype.chooseMan(state.getDept());
    })
    //双击删除
    $(document).on('dblclick', '.result-man span', function () {
        var $this = $(event.target)
        var deptid = $this.data('deptid')
        state.deleteValue(deptid, state.dType)
        Man.prototype.chooseMan(state.getDept())
        $('.choose-man').find('input[value="' + deptid + '"]').prop('checked', false);
    })
    //回车查询
    $(document).keydown(function (event) {
        var $this = $(event.target)
        if (event.keyCode == 13) {
            $('form').each(function () {
                event.preventDefault();
            });
            if ($this.next().hasClass('input-group-addon')) {
                $this.next().trigger('click')
            }
        }
    });
    return new Man();
});