!function (factory) {
    if (typeof require === 'function' && typeof exports === 'object' && typeof module === 'object') {
        var target = module['exports'] || exports;
        factory(target);
    } else if (typeof define === 'function' && define.amd) {
        define(['jquery'], factory);
    } else {
        window.sm = factory;
    }
}(function ($) {
    function SM() {
    }
    SM.prototype.resetTextarea = function (selector) {
        $(document).on('keyup', selector, function (e) {
            var $this = $(e.target);
            $this.attr('data-height', $this.height())
            console.log(this.scrollHeight)
            if (!$this.data('height')) {
            }
            var height = $this.attr('data-height');
            var newHeight = this.scrollHeight;
            $this.height(newHeight)
        })
    }
    const sm = new SM();
    return sm
});