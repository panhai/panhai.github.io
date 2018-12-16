var NAV = {
	show: function(parentNAV,items,list,index){
		var jPrentNav = $(parentNAV), oDOMprent = jPrentNav.get(0);
		var oItems = jPrentNav.find(".NAV_MENU");
		var oLists = jPrentNav.find(list);
		var oitems = jPrentNav.find(items).eq(index);
		
		console.log(oitems)

		var oCurList = oLists.eq(index);
		oCurList.addClass('cur');	
		oitems.addClass('on');

	},
	hide:function(parentNAV,items,list,index){
		var jPrentNav = $(parentNAV), oDOMprent = jPrentNav.get(0);
		var oItems = jPrentNav.find(".NAV_MENU");
		var oLists = jPrentNav.find(list);
		var oitems = jPrentNav.find(items).eq(index);
		var oCurList = oLists.eq(index);
		oitems.removeClass('on')
		oCurList.removeClass('cur');
	}
}


$(".NAV .NAV_MENU").mouseenter(function(){

	NAV.show(".NAV","h3.menu","div.nav-head-menu", $(this).index(".NAV .NAV_MENU"));


}).mouseleave(function(){
	NAV.hide(".NAV","h3.menu","div.nav-head-menu", $(this).index(".NAV .NAV_MENU"));
})



$(".CRUMB-I > dt").mouseenter(function(){
	$(this).siblings('dl').show().end().addClass('cur');
}).closest('.CRUMB-I').mouseleave(function(){
	$(this).find('dt').removeClass('cur').end().find('.NAV').hide();
})