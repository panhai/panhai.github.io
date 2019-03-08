'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

(function (factory) {
    if (typeof define === 'function' && define.amd) define(['jquery'], factory); else if ((typeof exports === 'undefined' ? 'undefined' : _typeof(exports)) === 'object') factory(require('jquery')); else factory(jQuery);
})(function ($, undefined) {
    var DEFAULTS = {};
    var Row = function Row(element, option) {
        this.id = 0;
        this.element = $(element);
        var fields = option.fields;

        this.option = $.extend({}, DEFAULTS, option);
        this.editHtml = this._newHtml();
        this.saveHtml = this._editHtml();
        if (this.option.editBtn) {
            this.editHtml = this.success(this.option.editBtn);
        }
        if (this.option.saveBtn) {
            this.saveHtml = this.success(this.option.saveBtn);
        }
    };
    //显示提示
    function showTips(tips, addClassName, removeClassName) {
        var $tips = $("#tips-alert");
        $tips.css('display', 'block');
        $tips.addClass(addClassName);
        $tips.removeClass(removeClassName);
        $tips.html(tips);
        setTimeout(function () {
            $tips.css('display', 'none');
        }, 3000);
    }
    Row.prototype.add = function () {
        var _this = this;
        if ($('[data-add="1"]').length > 0) {
            return false
        }
        this.option.addBtn.push('add');
        var addBtn = this.option.addBtn ? this.success(this.option.addBtn) : this._newHtml();
        ++this.id;
        var fields = this.option.fields;

        var html = '<tr data-add="1" id="row' + this.id + '">';
        html += '<td>' + addBtn + '</td>';
        for (var key in fields) {
            if (typeof fields[key] === 'string') {
                html += '<td><span>' + fields[key] + '</span></td>';
            } else if (_typeof(fields[key]) === 'object') {
                html += '<td>' + _this._type(fields[key]) + '</td>';
            }
        }
        /*
        Object.keys(fields).forEach(function (key) {
            if (typeof fields[key] === 'string') {
                html += '<td><span>' + fields[key] + '</span></td>';
            } else if (_typeof(fields[key]) === 'object') {
                html += '<td>' + _this._type(fields[key]) + '</td>';
            }
        });
        */
        html += '</tr>';
        this.element.find('tbody').prepend(html);
        //this.element.find('tbody .form-group .icon-sv-reduce').replace(<span class="iconfont icon-sv-add" data-row="select" data-target="#option"></span>)
    };
    Row.prototype._type = function (field) {
        var html = '';
        var type = field.type,
		    name = field.name,
		    value = field.value,
		    template = field.template;

        switch (type) {
            case 'text':
                html = '<input type="text" class="form-control" name="' + (name || 'text') + '" value="' + value + '"/>';
                break;
            case 'yes':
                html = '<select name="' + (name || 'yes') + '" class="form-control"><option value="1">\u662F</option><option value="0">\u5426</option><select>';
                break;
            case 'select':
                var oldHtml = $(template).html();
                var reg = /<span.*?data-row="unselect".*?span>/ig;
                var newHtml = '<span class="iconfont icon-sv-add" data-row="select" data-target="' + template + '"></span>';
                html = oldHtml.replace(reg, newHtml);
                break;
            default:
                html = '';
                break;
        }
        return html;
    };

    Row.prototype._status = function (type) {
        var html = '';
        switch (type) {
            case 'save':
                html = '<button data-row="save" type="button" class="btn btn-sm btn-default">\u4FDD\u5B58</button>';
                break;
            case 'edit':
                html = '<button data-row="edit" type="button" class="btn btn-sm btn-default">\u7F16\u8F91</button>';
                break;
            case 'cancel':
                html = '<button data-row="cancel" type="button" class="btn btn-sm btn-default">\u53D6\u6D88</button>';
                break;
            case 'delete':
                html = '<button data-row="erase" type="button" class="btn btn-sm btn-default">\u5220\u9664</button>';
                break;
            default:
                html = '';
                break;
        }
        return html;
    };
    Row.prototype._getId = function () {
        return this.id;
    };
    Row.prototype._deleteHtml = function () {
        var html = '<span class="delete">删除</span>';
        return html;
    };
    Row.prototype._newHtml = function () {
        var html = '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-default">\u4FDD\u5B58</button><button type="button" class="btn btn-default cancel" data-row="cancel">\u53D6\u6D88</button></div>';
        return html;
    };
    Row.prototype._saveHtml = function () {
        var html = '<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-default">\u4FDD\u5B58</button><button type="button" class="btn btn-default cancel" data-row="cancel">\u53D6\u6D88</button></div>';
        return html;
    };
    Row.prototype._editHtml = function () {
        var html = '<div class="btn-group btn-group-sm" role="group"><button type="button" class="btn btn-default edit" data-row="edit">\u7F16\u8F91</button><button type="button" class="btn delete btn-default cancel" data-row="erase">\u5220\u9664</button></div>';
        return html;
    };
    Row.prototype.save = function (_relatedTarget) {
        var e = _relatedTarget;
        var self = e.closest('tr');
        var event = $.Event('row.save', { relatedTarget: e });
        this.element.trigger(event);
        var saveBtn = this.option.saveBtn;
        //self.html(this.saveHtml)

        self.find('[data-type]').each(function () {
            $(this).attr('disabled', true).addClass('disabled');
        });
        e.closest('td').html(this.saveHtml);
        self.children().eq(0).html(this.saveHtml);
        //$(target).closest('tr').children().eq(0).html(this._editHtml())
    };
    Row.prototype.row = function (_relatedTarget) {
        //return this.isShown ? this.hide() : this.show(_relatedTarget)
    };
    Row.prototype.edit = function (e) {
        var relatedTarget = e;
        var event = $.Event('row.edit', { relatedTarget: relatedTarget });
        this.element.trigger(event);
        var self = e.closest('tr');
        self.find('[data-type]').each(function () {
            $(this).removeAttr('disabled').removeClass('disabled');
        });
        self.children().eq(0).html(this.editHtml);
    };
    Row.prototype.erase = function (e) {
        var _relatedTarget = e;
        var event = $.Event('row.delete', { relatedTarget: _relatedTarget });
        e.closest('tr').remove();
    };
    Row.prototype.cancel = function (e) {
        var relatedTarget = e;
        var event = $.Event('row.cancel', { relatedTarget: relatedTarget });
        this.element.trigger(event);
        var self = e.closest('tr');
        self.find('[data-type]').each(function () {
            $(this).attr('disabled', true).addClass('disabled');
        });
        self.children().eq(0).html(this.editHtml);
    };
    Row.prototype.select = function (e) {
        var relatedTarget = e;
        var event = $.Event('row.select', { relatedTarget: relatedTarget });
        this.element.trigger(event);
        var html = $($(e).data('target')).html();
        $(e).closest('td').append(html);
    };
    Row.prototype.unselect = function (e) {
        var _relatedTarget = e;
        var event = $.Event('row.unselect', { relatedTarget: _relatedTarget });
        this.element.trigger(event);
        $(e).closest('div').remove();
    };
    Row.prototype.success = function (args) {
        var _this2 = this;

        var html = '';
        if (typeof args === 'string') {
            html += this._status(args);
        } else if ((typeof args === 'undefined' ? 'undefined' : _typeof(args)) === 'object' && args instanceof Array) {
            html += '<div class="btn-group btn-group-sm" role="group">';
            /*
            Object.keys(args).forEach(function (key) {
                html += _this2._status(args[key]);
            });
            */
            for (var key in args) {
                html += _this2._status(args[key]);
            }
            html += '<div>';
        }
        if (args.indexOf('add') > 0) {
            var newHtml = ' data-row="erase" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button>';
            var reg = /(.*?)data-row="cancel".*?button>(.*?)$/ig;
            html = html.replace(reg, '$1' + newHtml + '$2');
        }
        return html;
    };

    function Plugin(option, _relatedTarget) {
        return this.each(function () {
            var $this = $(this);
            var data = $this.data('bs.row');
            var options = $.extend({}, DEFAULTS, $this.data(), (typeof option === 'undefined' ? 'undefined' : _typeof(option)) == 'object' && option);
            if (!data) $this.data('bs.row', data = new Row(this, options));
            if (typeof option == 'string') data[option](_relatedTarget);
        });
    }

    var old = $.fn.csTable;

    $.fn.csTable = Plugin;
    $.fn.csTable.Constructor = Row;

    // TAB NO CONFLICT
    // ===============

    $.fn.csTable.noConflict = function () {
        $.fn.csTable = old;
        return this;
    };

    var EventHandle = function EventHandle(e) {
        e.preventDefault();
        var type = $(this).data('row');
        if (type !== 'edit' && type !== 'select' && type !== 'unselect' && type !== 'erase' && type !== 'save' && type !== 'add' && type !== 'cancel') {
            return;
        }
        // if(type === 'save'){
        // 	Plugin.call($(this),type,Row.option)
        // }else{
        Plugin.call($(this), type, $(this));
        // }
        // switch(type){
        // 	case 'edit':
        //     	$(e.target).trigger($.Event( "row.edit",{relatedTarget: $(this)}));
        // 	break
        // 	case 'delete':
        // 		$(e.target).trigger($.Event( "row.delete",{relatedTarget: $(this)}));
        // 	break
        // 	case 'save':
        // 		$(e.target).trigger($.Event( "row.save",{relatedTarget: $(this)}));
        // 	break
        // 	case 'add':
        // 		$(e.target).trigger($.Event( "row.add",{relatedTarget: $(this)}));
        // 	break
        // 	default:
        // 		$(e.target).trigger($.Event( "row.cancel",{relatedTarget: $(this)}));
        // 	break
        // }
    };

    $(document).on('click', '[data-row^="save"]', EventHandle);
    $(document).on('click', '[data-row^="erase"]', EventHandle);
    $(document).on('click', '[data-row^="edit"]', EventHandle);
    $(document).on('click', '[data-row^="cancel"]', EventHandle);
    $(document).on('click', '[data-row="select"]', EventHandle);
    $(document).on('click', '[data-row="unselect"]', EventHandle);
    //$(document).on('click', '[data-row^="add"]', EventHandle)

    // const clickHandler1 = function (e) {
    //    	e.preventDefault()
    //     Plugin.call($(this), 'delete',$(this))
    // }
    //$(document).on('row.delete', '[data-row="delete"]',clickHandler1)
});