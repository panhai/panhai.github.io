'use strict';

define('csTable', function (require) {
	'use strict';

	var $ = require('jquery');

	var Row = function Row(element) {
		// jscs:disable requireDollarBeforejQueryAssignment
		this.element = $(element);
		// jscs:enable requireDollarBeforejQueryAssignment
	};

	Row.prototype.show = function () {
		var $this = this.element;
		var $ul = $this.closest('tr');
		var selector = $this.data('row');
		console.log($this);
	};

	// TAB PLUGIN DEFINITION
	// =====================

	function Plugin(option) {
		return this.each(function () {
			var $this = $(this);
			var data = $this.data('bs.row');

			if (!data) $this.data('bs.row', data = new Row(this));
			if (typeof option == 'string') data[option]();
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

	// TAB DATA-API
	// ============

	var clickHandler = function clickHandler(e) {
		e.preventDefault();
		Plugin.call($(this), 'show');
	};

	$(document).on('click.bs.row.data-api', '[data-row="add"]', clickHandler).on('click.bs.row.data-api', '[data-row="save"]', clickHandler).on('click.bs.row.data-api', '[data-row="edit"]', clickHandler).on('click.bs.row.data-api', '[data-row="delete"]', clickHandler);
});