//初始化几个年份列表
//这整段要放在v2/all.js之前，不然初始化的时候没有正确的值选项，会初始化错误
function initYearList(obj) {
    $(obj).data('options', 10);
    var from = $(obj).data("from") * 1,
        to = $(obj).data("to"),
        str = [],
        bit_ten = Math.floor(from % 100 / 10),
        key = obj.className.match('birth');
    /*key=this.className.indexOf('birth')>=0 ? '后':'年'*/;
    if (to == 'now') to = (new Date()).getFullYear();
    for (var n = from; n <= to; n++) {
        if (key) {
            var this_bit_ten = Math.floor(n % 100 / 10);
            if (bit_ten != this_bit_ten)//如果本数的十位不等于当前的十位，则为新十位
            {
                str.unshift('<b>', bit_ten, '0后</b>');
                bit_ten = this_bit_ten;
            }
        }
        str.unshift('<a data-id="' + n + '" href="javascript:void(0)">' + n + '</a>');
    }
    var bit_one = n % 10;
    if (bit_one != 9 && bit_one != 0) {
        for (var m = 9; m >= bit_one; m--)
            str.unshift('<s> </s>');
    }
    key && str.unshift('<b>', bit_ten, '0后</b>');
    $(obj).find("dd.normal").html(str.join(''));
}
$(function(){
	$(".YEARS").each(function(){
	    initYearList(this);
	});
	$(".MONTHS").data("autofill",'1,12,1')
})
