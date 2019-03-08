'use strict';

define(['demo'], function (require) {
	function demo() {}
	demo.prototype.add = function (a, b) {
		return a + b;
	};
	return new demo();
});