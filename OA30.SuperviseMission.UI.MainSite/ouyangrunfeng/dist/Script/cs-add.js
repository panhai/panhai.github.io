'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

(function (factory) {
	if (typeof define === 'function' && define.amd) define(['jquery'], factory);else if ((typeof exports === 'undefined' ? 'undefined' : _typeof(exports)) === 'object') factory(require('jquery'));else factory(jQuery);
})(function ($, undefined) {
	var DEFAULTS = {};
	var Action = function Action(element, option) {
		this.id = 0;
		this.element = $(element);
		var fields = option.fields;

		this.option = $.extend({}, DEFAULTS, option);
		this.editHtml = this._newHtml();
		if (this.option.editBtn) {
			this.editHtml = this.success(this.option.editBtn);
		}
	};

	Action.prototype.init = function (args) {};

	function Plugin(option, _relatedTarget) {
		return this.each(function () {
			var $this = $(this);
			var data = $this.data('cs.add');
			if (!data) $this.data('cs.add', data = new Add(this, option));
			console.log(data);
			if (typeof option == 'string') data[option](_relatedTarget);
		});
	}

	var old = $.fn.csAction;

	$.fn.csAction = Plugin;
	$.fn.csAction.Constructor = Action;

	// TAB NO CONFLICT
	// ===============

	$.fn.csAction.noConflict = function () {
		$.fn.csAction = old;
		return this;
	};

	var EventHandle = function EventHandle(e) {
		e.preventDefault();
		Plugin.call($(this), type, $(this));
	};

	$(document).on('click', '[data-air^="add"]', EventHandle);
});