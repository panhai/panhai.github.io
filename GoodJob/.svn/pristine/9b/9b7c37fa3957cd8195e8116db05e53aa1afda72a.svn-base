// JavaScript Document
//搜索栏的地址列表
function SearchList()
{
	var t=$(".top-search-list");
	var i=$(".top-search-item");
	var tar=$(".top-filter-list");
	var inf=tar.find("dt");
	var list=tar.find("dd");
	i.focus(function(){
		this.select();
	    if (t.timer) { clearTimeout(t.timer); }
	    t.show();
		tar.hide();
	}).keyup(function(){
		var v=this.value;
		if(!v)
		{
			tar.hide();
			return;
		}
		t.hide();
		var ads=GetAreasByRegexp(v);
		var str='';
		if(ads.length)
		{
			inf.html(v +'，若缩小范围，请输入全拼');
			var cnt=0;
			for(var n=0;n<ads.length;n++)
			{
				cnt++;
				str+='<a href="javascript:void(0)" data-id="'+ads[n][2]+'">'+ ads[n][0] +'</a>';
				if(cnt>5) break;
			}
			tar.show();
			list.html(str).find("a").click(function(){
			    i.val(this.innerHTML);
			    //
			    $(this).parent().parent().find("a").removeClass("cur");			 
			    $(".top-search-list dd a").removeClass("cur");
			    $(this).addClass("cur");
			    goSearch();
			    return false;
			});
		}
		else
		{
			inf.html('对不起找不到，'+ v);
		}
	});
	t.close=function(){
		t.timer = setTimeout(function () {
			t.hide();
			tar.hide();
		},200);
	}
	$("body").click(function(event){
		var TAR=$(event.target);
		if(!TAR.IN(t) && !TAR.is(i)) t.close();
	});
	t.find("a").click(function () {
	    i.val($(this).text());
	    i.data("id", $(this).prop("id"));
		t.close();
	});
}
