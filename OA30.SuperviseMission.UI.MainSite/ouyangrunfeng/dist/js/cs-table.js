'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

(function (factory) {
	if (typeof define === 'function' && define.amd) define(['jquery'], factory);else if ((typeof exports === 'undefined' ? 'undefined' : _typeof(exports)) === 'object') factory(require('jquery'));else factory(jQuery);
})(function ($, undefined) {
	var DEFAULTS = {};
	var Row = function Row(element, option) {
		this.id = 0;
		this.element = $(element);
		var fields = option.fields;

		this.option = $.extend({}, DEFAULTS, option);
		this.editHtml = this._newHtml();
		if (this.option.editBtn) {
			this.editHtml = this.success(this.option.editBtn);
		}
	};

	Row.prototype.add = function () {
		var _this = this;

		var addBtn = this.option.addBtn ? this.success(this.option.addBtn) : this._newHtml();
		++this.id;
		var fields = this.option.fields;

		var html = '<tr id="row' + this.id + '">';
		html += '<td>' + addBtn + '</td>';
		Object.keys(fields).forEach(function (key) {
			if (typeof fields[key] === 'string') {
				html += '<td><span>' + fields[key] + '</span></td>';
			} else if (_typeof(fields[key]) === 'object') {
				html += '<td>' + _this._type(fields[key]) + '</td>';
			}
		});
		html += '</tr>';
		this.element.find('tbody').prepend(html);
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
				html = $(template).html();
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
				html = '<button data-row="delete" type="button" class="btn btn-sm btn-default">\u5220\u9664</button>';
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
		var html = '<div class="btn-group btn-group-sm" role="group"><button type="button" class="btn btn-default edit" data-row="edit">\u7F16\u8F91</button><button type="button" class="btn delete btn-default cancel" data-row="delete">\u5220\u9664</button></div>';
		return html;
	};
	Row.prototype.save = function (e) {

		$(target).closest('tr').find('[data-type]').each(function () {
			$(this).attr('disabled', true).addClass('disabled');
		});
		//$(target).closest('tr').children().eq(0).html(this._editHtml())
	};
	Row.prototype.row = function (_relatedTarget) {
		console.log(_relatedTarget, 123);
		//return this.isShown ? this.hide() : this.show(_relatedTarget)
	};
	Row.prototype.edit = function (e) {
		var self = e.closest('tr');
		self.find('[data-type]').each(function () {
			$(this).removeAttr('disabled').removeClass('disabled');
		});
		self.children().eq(0).html(this.editHtml);
	};
	Row.prototype.delete = function (e) {
		e.closest('tr').remove();
	};
	Row.prototype.cancel = function (e) {
		console.log(e.data('type'));
		var self = e.closest('tr');
		console.log(self);
		self.find('[data-type]').each(function () {
			$(this).attr('disabled', true).addClass('disabled');
		});
		self.children().eq(0).html(this.editHtml);
	};
	Row.prototype.success = function (args) {
		var _this2 = this;

		var html = '';
		if (typeof args === 'string') {
			html += this._status(args);
		} else if ((typeof args === 'undefined' ? 'undefined' : _typeof(args)) === 'object' && args instanceof Array) {
			html += '<div class="btn-group btn-group-sm" role="group">';
			Object.keys(args).forEach(function (key) {
				html += _this2._status(args[key]);
			});
			html += '<div>';
		}
		return html;
	};

	function Plugin(option, _relatedTarget) {
		return this.each(function () {
			var $this = $(this);
			var data = $this.data('bs.row');
			if (!data) $this.data('bs.row', data = new Row(this, option));
			console.log(data);
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
		if (type !== 'edit' && type !== 'delete' && type !== 'save' && type !== 'add' && type !== 'cancel') {
			return;
		}
		Plugin.call($(this), type, $(this));
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
	$(document).on('click', '[data-row^="delete"]', EventHandle);
	$(document).on('click', '[data-row^="edit"]', EventHandle);
	$(document).on('click', '[data-row^="cancel"]', EventHandle);
	//$(document).on('click', '[data-row^="add"]', EventHandle)

	// const clickHandler1 = function (e) {
	//    	e.preventDefault()
	//     Plugin.call($(this), 'delete',$(this))
	// }
	//$(document).on('row.delete', '[data-row="delete"]',clickHandler1)
});