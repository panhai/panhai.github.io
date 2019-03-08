'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

define('row', function (require) {
	var $ = require('jquery');
	function Row(options) {
		var defaultOptions = {
			target: '.html'
		};
		this.options = $.extend({}, defaultOptions, options);
		this.id = 0;
	}

	Row.prototype.init = function () {};

	Row.prototype.add = function () {
		var _this = this;

		++this.id;
		var _options = this.options,
		    fields = _options.fields,
		    target = _options.target;

		var html = '<tr id="row' + this.id + '">';
		html += '<td>' + this._newHtml() + '</td>';
		Object.keys(fields).forEach(function (key) {
			if (typeof fields[key] === 'string') {
				html += '<td><span>' + fields[key] + '</span></td>';
			} else if (_typeof(fields[key]) === 'object') {
				html += '<td>' + _this._type(fields[key]) + '</td>';
			}
		});
		html += '</tr>';
		$(target).find('tbody').prepend(html);
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
	Row.prototype.edit = function (e) {
		var target = e.target;

		$(target).closest('tr').find('[data-type]').each(function () {
			$(this).removeAttr('disabled').removeClass('disabled');
		});
		//e.closest('tr').children().eq(0).html(this._saveHtml())
	};
	Row.prototype.delete = function (e) {
		var target = e.target;


		var hidden = $.Event("row.delete", { relatedTarget: $(e.target) });
		$(target).trigger(hidden);
		$(e.target).closest('tr').remove();
	};
	Row.prototype.cancel = function (e) {
		var target = e.target;

		$(target).closest('tr').find('[data-type]').each(function () {
			$(this).attr('disabled', true).addClass('disabled');
		});
		//$(target).closest('tr').children().eq(0).html(this._editHtml())
	};
	Row.prototype.success = function (e, args) {
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
		$(e.target).closest('td').html(html);
	};
	var EventHandle = function EventHandle(e) {
		var target = e.target;

		var type = $(target).data('row');
		switch (type) {
			case 'edit':
				$(e.target).trigger($.Event("row.edit", { relatedTarget: $(e.target) }));
				break;
			case 'delete':
				$(e.target).trigger($.Event("row.edit", { relatedTarget: $(e.target) }));
				break;
			case 'save':
				$(e.target).trigger($.Event("row.save", { relatedTarget: $(e.target) }));
				break;
			case 'add':
				$(e.target).trigger($.Event("row.add", { relatedTarget: $(e.target) }));
				break;
			default:
				$(e.target).trigger($.Event("row.cancel", { relatedTarget: $(e.target) }));
				break;

		}
	};
	// $(document).on('click', '[data-row^="save"]', EventHandle)
	// $(document).on('click', '[data-row^="delete"]', EventHandle)
	// $(document).on('click', '[data-row^="edit"]', EventHandle)
	// $(document).on('click', '[data-row^="cancel"]', EventHandle)
	// $(document).on('click', '[data-row^="add"]', EventHandle)
	// $(document).on('click', '[data-row^="save"]', EventHandle)
	// $(document).on('click', '[data-row^="cancel"]', $.proxy(Row.prototype.cancel,new Row))
	// $(document).on('click', '[data-row^="delete"]', $.proxy(Row.prototype.delete,new Row))
});