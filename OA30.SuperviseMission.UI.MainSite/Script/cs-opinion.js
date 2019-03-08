'use strict';
(function (factory) {
    if (typeof define === 'function' && define.amd) define(['jquery'], factory); else if ((typeof exports === 'undefined' ? 'undefined' : _typeof(exports)) === 'object') factory(require('jquery')); else factory(jQuery);
})(function ($, undefined) {
    var DEFAULTS = {

    }
    var Opinion = function (ele) {
        this.type = '';
        this.opinion = [];
        this.ele = ele;
        //this.init();
    }
    Opinion.prototype.init = function () {
        this.renderOpinion();
    }
    Opinion.prototype.renderOpinion = function () {
        var self = this;
        this.fetchOpinion(function (data) {
            var html = ['<div class="f-so"><span>意见类型<b class="fsb">*</b></span><select class="form-control" name="opinion">'];
            var len = data.length;
            if (len > 0) {
                for (var i = 0; i < len; i++) {
                    if (i === 0) {
                        html.push('<option value="0">--请选择意见类型--</option>');
                    }
                    if (data[i].ActivityFlag) {
                        html.push(
                            '<option value="',
                            data[i].TypeId,
                            '">',
                            data[i].TypeName,
                            '</option>'
                        );
                    }
                }
            }
            html.push('</select></div>');
            $(self.ele).html(html.join(''));
            self.bindEvent();
        })
    }
    Opinion.prototype.fetchOpinion = function (fn) {
        $.ajax({
            url: "WebServices/SuperviseMissionWebServices.asmx/GetOpinionTypeList",
            type: "post",
            dataType: "xml",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function (data) {
                var opinion = JSON.parse($(data).find("data").text());
                fn(opinion);
            },
            error: function (message) {
                alert("获取部门组列表失败！");
            }
        });
    }
    Opinion.prototype.setType = function (type) {
        this.type = type;
    }
    Opinion.prototype.getType = function () {
        return this.type;
    }
    Opinion.prototype.bindEvent = function () {
        var self = this;
        $(this.ele).on('change', function (e) {
            var $this = $(e.target);
            var val = $this.find('option:selected').val();
            self.setType(val);
        })
    }

    function Plugin(option, _relatedTarget) {
        return this.each(function () {
            var $this = $(this);
            var data = $this.data('bs.opinion');
            var options = $.extend({}, DEFAULTS, $this.data(), (typeof option === 'undefined' ? 'undefined' : _typeof(option)) == 'object' && option);
            if (!data) $this.data('bs.opinion', data = new Opinion(this, options));
            if (typeof option == 'string') data[option](_relatedTarget);
        });
    }

    var old = $.fn.csOpinion;

    $.fn.csOpinion = Plugin;
    $.fn.csOpinion.Constructor = Opinion;

    $.fn.csOpinion.noConflict = function () {
        $.fn.csOpinion = old;
        return this;
    };

    $(function () {
        $('.opinion-type').csOpinion('init');
    });

});