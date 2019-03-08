'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

define('row', function (require) {
	var _this = this;

	var $ = require('jquery');
	/**
 	new({
 		target:'#html',
 		fields:[{
 			type:'text',
 			place:'部门名称',
 			value:'1'
 		}]
 	})
 **/
	var Row = function Row() {};
	Row.prototype.init = function (options) {
		_this.options = $.extend({}, options);
	};
	Row.prototype.create = function () {
		var fields = _this.options.fields;

		var html = '<tr>';
		html += '<td>' + _this._saveHtml + '</td>';
		Object.keys(fields).forEach(function (key) {
			if (typeof fields[key] === 'string') {
				html += '<span>' + fields[key] + '</span>';
			} else if (_typeof(fields[key]) === 'object') {
				html += '<td>' + _this._type(fields[key]) + '</td>';
			}
		});
		html += '</tr>';
		_this.target.html(html);
	};
	Row.prototype._type = function (field) {
		var html = '';
		var type = field.type,
		    name = field.name;

		switch (type) {
			case 'text':
				html = '<input type="text" name="' + (name || 'text') + '" />';
				break;
			case 'yes':
				html = '<select name="' + (name || 'yes') + '"><option value="1">\u662F</option><option value="0">\u5426</option><select>';
				break;
			case 'select':
				html = '<select name="' + (name || 'yes') + '"><option value="1">\u662F</option><option value="0">\u5426</option><select>';
				break;
			default:
				html = '';
				break;
		}
		return html;
	};
	Row.prototype._deleteHtml = function () {
		var html = '<span class="delete">删除</span>';
		return html;
	};
	Row.prototype._saveHtml = function () {
		var html = '<span class="save">保存</span><span class="save">取消</span>';
		return html;
	};
	Row.prototype._editHtml = function () {
		var html = '<span class="delete">删除</span><span class="edit">编辑</span>';
		return html;
	};
	Row.prototype.save = function () {};
	Row.prototype.edit = function () {};
	Row.prototype.delete = function () {};
	var row = new Row();

	return {
		save: row.save,
		delete: row.delete,
		edit: row.edit,
		create: row.create,
		init: row.init
	};
});