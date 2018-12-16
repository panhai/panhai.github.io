(function($){

    var ImgCenter = {
        imgs: [],
        wrapperH : 0,
        wrapperW : 0,

        init: function( target ){
            var wrapper = $(target);
            this.imgs =  wrapper.find("img");
            wrapper = this.imgs.parent();
            this.wrapperH = wrapper.outerHeight();
            this.wrapperW = wrapper.outerWidth();
            this.center();

        },
        center: function(){
            var self = this;
            this.imgs.each(function(index, el) {
                var height = (self.wrapperH - $(el).height()) / 2;
                var width = (self.wrapperW - $(el).width()) / 2;
                $(el).css({"marginTop":height, "marginLeft": width});
            });
        }
    }
    window.ImgCenter = ImgCenter;
})(jQuery)