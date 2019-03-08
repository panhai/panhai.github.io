'use strict';

define('Dept', function (require) {
    var _ = require('lodash');
    var $ = require('jquery');
    var state = require('state');

    function Dept(data) {
        this.dept = [];
        this.single = false;
        this.field = {
            
        }
    }
    Dept.prototype.init = function () {
        $('body').append(this.html())
    }
    //处理单选或多选
    Dept.prototype.initDept = function (data, single) {
        var html = ['<ul class="list-unstyled">'];
        var type = single ? 'radio' : 'checkbox';
        if (data.length > 0) {
            _.map(data, function (item, index) {
                var check = ''
                if (item.check) {
                    check = ' checked="true"'
                }
                if (item.DeptName !== '' && item.DeptId !== '0') {
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
                }
            })
        }
        html.push('</ul>');
        return html.join('')
    }
    //加载数据
    Dept.prototype.setData = function (data, single) {
        this.single = single
        if (typeof data === 'object') {
            this.dept = data;
        } else {
            throw new Error('数据为空或格式不正确');
        }
    }
    //加载分组数据
    Dept.prototype.setGroupData = function (data) {
        if (typeof data === 'object') {
            this.gDept = data;
        } else {
            throw new Error('数据为空或格式不正确');
        }
    }
    //显示选中部门
    Dept.prototype.chooseDept = function (data) {
        var html = [];
        _.map(data, function (item,key) {
            html.push(
                '<span',
                ' data-deptid="',
                key,
                '">',
                item,
                ';</span>'
            )
        })
        $('.result-area').html(html.join(''));
    }
    
    //刷新部门
    Dept.prototype.refresh = function (data, single) {
        var html = ['<ul class="list-unstyled">'];
        var type = single ? 'radio' : 'checkbox';
        if (data.length > 0) {
            _.map(data, function (item, index) {
                var check = ''
                if (item.check) {
                    check = ' checked="true"'
                }
                if (item.DeptName !== '' && item.DeptId !== '0') {
                    html.push('<li><div class="',
                        type,
                        '">',
                        '<label><span class="iconfont icon-sv-tree"></span><input type=',
                        type,
                        check,
                        ' value="',
                        item.DeptId,
                        '" name="dept"/>',
                        item.DeptName,
                        '</label></div></li>')
                }
            })
        }
        html.push('</ul>')
        $('.choose-area').html(html.join(''));
    }
    //加载部门样式
    Dept.prototype.html = function () {
        var html = ['<div class="modal company-modal" tabindex="-1" role="dialog" id="company" style="display: none;" data-backdrop="static" data-keyboard="false">',
            '<div class="modal-dialog" role="document" style="width: 610px;margin:30px auto;">',
            '<div class="modal-content">',
            '<div class="modal-header">',
            '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>',
            '<h4 class="modal-title">选择单位</h4>',
            '</div>',
            '<div class="modal-body">',
            '<div class="clearfix">',
            '<div class="col-sm-6 col" style="padding-left:0;">',
            '<div class="form-group">',
            '<div class="input-group">',
            '<input type="text" class="form-control search-dept" placeholder="选择部门" />',
            '<div class="input-group-addon sdept">',
            '<span class="iconfont icon-sv-search"></span>',
            '</div>',
            '</div>',
            '</div>',
            '</div>',
            '<div class="col-sm-6 col" style="padding-right:0;">',
            '<div class="form-group dropdown" id="gDept">',
            //this.setDeptGroup(this.gDept),
            '</div>',
            '</div>',
            '</div>',
            '<div class="choose-area" id="chooseArea">',
            this.initDept(this.dept, this.single),
            '</div>',
            '<div class="result-area" id="resultArea" data-area="">',
            '</div>',
            '<div class="form-group sn tac">',
            '<button type="button" class="btn btn-primary-c" data-btn="deptSure">确定</button>',
            '<button type="button" class="btn btn-default-c" data-dismiss="modal">取消</button>',
            '</div>',
            '</div>',
            '</div>',
            '</div>',
            '</div>'];
        return html.join('');
    };
    //部门分组
    Dept.prototype.setDeptGroup = function () {
        var data = state.getDeptGroup();
        var html = ['<select class="form-control gdept" name="groupSelect">'];
        html.push('<option value="" disabled="disabled">请选择部门组</option>');
        html.push('<option value="">全部</option>');
        _.map(data, function (item, key) {
            html.push('<option value="',
                item.DeptIds.join(','),
                '">',
                item.GroupName,
                '</option>');
        })
        html.push('</select>');
        setTimeout(function () {
            $('#gDept').html(html.join(''));
        },1000)
    }
    //部门搜索
    Dept.prototype.search = function (word) {
        $.proxy(function () {
        },this)
    }
   
    //选择部门
    $(document).on('click', '#company li input' ,function (e) {
        var $this = $(e.target);
        var name = $this.parent().text();
        var value = $this.val();
        if ($this.prop('checked')) {
            state.setDeptCheck(value);
            state.setValue(state.dType, [value,name])
        } else {
            state.setDeptunCheck(value);
            state.deleteValue($this.val(), state.dType)
        }
        Dept.prototype.chooseDept(state.getDept())
        
    })
    //责任处室
    $(document).on('click', '[name="office"]', function (e) {
        var $this = $(this);
        var $box = $this.closest('[data-index]').data('index');
        state.setPage($box);
        state.setSingle($this.data('single') || false);
        state.setDeptType('office');
        Dept.prototype.refresh(state.getAllDept(), state.getSingle());
        Dept.prototype.chooseDept(state.getDept());
        $('#company li input').prop('checked', false)
        _.map(state.getDept(), function (item, key) {
            $('#company li input[value="' + key + '"]').prop('checked', true)
        })
    })
    //部门
    $(document).on('click', '[name="company"]', function (e) {
        var $this = $(this);
        var $box = $this.closest('[data-index]').data('index');
        state.setPage($box);
        state.setSingle($this.data('single')||false);
        state.setDeptType('company');
        Dept.prototype.refresh(state.getAllDept(), state.getSingle());
        Dept.prototype.chooseDept(state.getDept());
        $('#company li input').prop('checked', false)
        _.map(state.getDept(), function (item, key) {
            $('#company li input[value="' + key + '"]').prop('checked', true)
        })
    })
    //协办单位
    $(document).on('click', '[name="snOtherCompany"]', function (e) {
        var $this = $(this);
        var $box = $this.closest('[data-index]').data('index');
        state.setPage($box);
        state.setDeptType('snOtherCompany');
        Dept.prototype.refresh(state.getAllDept(), state.getSingle());
        Dept.prototype.chooseDept(state.getDept());
        $('#company li input').prop('checked', false)
        _.map(state.getDept(), function (item, key) {
            $('#company li input[value="' + key + '"]').prop('checked', true)
        })
    })
    //主办单位
    $(document).on('click', '[name="snCompany"]', function (e) {
        var $this = $(this);
        var $box = $this.closest('[data-index]').data('index');
        state.setPage($box);
        state.setSingle($this.data('single') || false);
        state.setDeptType('snCompany');
        Dept.prototype.refresh(state.getAllDept(), state.getSingle());
        Dept.prototype.chooseDept(state.getDept());
        $('#company li input').prop('checked', state.getSingle())
        _.map(state.getDept(), function (item, key) {
            $('#company li input[value="' + key + '"]').prop('checked', true)
        })
    })
    //搜索部门
    $(document).on('click', '#company .sdept', function (e) {
        var $this = $(e.target);
        var $box = $this.closest('.input-group').find('input')
        var $word = $box.val()
        var result = state.searchfDept($word)
        if ($.trim($word) === '') return
        $('.gdept').val('');
        Dept.prototype.refresh(result, state.getSingle())
        Dept.prototype.chooseDept(state.getDept());
        $('#company li input').prop('checked', false)
        _.map(state.getDept(), function (item, key) {
            $('#company li input[value="' + key + '"]').prop('checked', true)
        })
    })
    //搜索部门
    $(document).on('change', '.search-dept', function (e) {
        var $this = $(e.target);
        var $box = $this.closest('.input-group').find('input')
        var $word = $box.val()
        if ($.trim($word) === '') {
            Dept.prototype.refresh(state.getAllDept(), state.getSingle())
            Dept.prototype.chooseDept(state.getDept());
            $('#company li input').prop('checked', false)
            _.map(state.getDept(), function (item, key) {
                $('#company li input[value="' + key + '"]').prop('checked', true)
            })
        }
    })
    //部门分组
    $(document).on('change', '.gdept', function (e) {
        var $this = $(e.target);
        var $value = $this.val();
        $('.search-dept').val('');
        if ($value === '') {
            Dept.prototype.refresh(state.getAllDept(), state.getSingle())
        } else {
            var result = state.searchDeptGroup($value);
            Dept.prototype.refresh(result, state.getSingle())
        }
    })
    //重置部门
    $(document).on('click', '[data-modal-btn="reset"]', function (e) {
        var $this = $(this)
        $this.closest('.modal-body').find('.result-area').html('');
        state.setObjectNull(state.dType);
        for (var key in state.getDept()) {
            state.setDeptunCheck(key);
            $('.choose-area input[value="' + key + '"]').prop('checked', false)
        }
    })
    //双击删除
    $(document).on('dblclick', '.result-area span', function () {
        var $this = $(event.target)
        var deptid = $this.data('deptid')
        state.deleteValue(deptid, state.dType)
        state.setDeptunCheck(deptid);
        Dept.prototype.chooseDept(state.getDept())
        $('.choose-area').find('input[value="' + deptid + '"]').prop('checked', false);
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
    var dept = new Dept()
    return dept;
});