//初始化几个年份列表
//这整段要放在v2/all.js之前，不然初始化的时候没有正确的值选项，会初始化错误
function initYearList(obj) {
    $(obj).data('options', 10);
    var from = $(obj).data("from") * 1,
        to = $(obj).data("to"),
        str = [],
        bit_ten = Math.floor(from % 100 / 10);

    if (to == 'now') to = (new Date()).getFullYear();
    str.push('<span class="YEARS-ctrL"></span>');
    str.push('<span class="YEARS-ctrR"></span>');
    str.push('<div class="YEARS-in"></div>')
    $(obj).find('dd.normal').html(str.join(''));
    str = [];
    for (var n = from; n <= to; n++) {

        var this_bit_ten = Math.floor(n % 100 / 10);
        str.unshift('<a data-id="' + n + '" href="javascript:void(0)">' + n + '</a>');
    }

    $(obj).find("dd.normal").find(".YEARS-in").append(str.join(''));


}
$(function(){
    $(".YEARS").each(function(){
        initYearList(this);
    });
    $(".MONTHS").data("autofill",'1,12,1')



    $(".YEARS-ctrL").click(function(){

        var o = $(this).siblings(".YEARS-in"),
            marTop = o.position().top,
            top = (parseInt(o.css("top")));

        if( top <0){
            o.css("top",(90+marTop)-6+'px')
            $(this).siblings(".YEARS-ctrR").show();
        
            if( top /90 == (-1)){
                $(this).hide();
            }
        }
    });
    $(".YEARS-ctrR").click(function(){
        var o = $(this).siblings(".YEARS-in"),
            marTop = o.position().top,
            height = o.height(),
            top = -(parseInt(o.css("top"))),
            cs = Math.floor(height / 90);
        if(height- top >90 ){
            o.css("top",(-90+marTop)-6+'px')
            $(this).siblings(".YEARS-ctrL").show();

            if(top / 90 ==( cs-1)){
                $(this).hide();
                $(this).siblings(".YEARS-ctrR").show();
            }
        }
    })


})
