// 企业展示
//搜索列表的前两个下拉列表
function SearchSelect()
{
	$(".jobs-search div").mouseenter(function(){
		$(this).find("ul").show();
	}).mouseleave(function(){
		$(this).find("ul").hide();
	}).find("li").click(function(){
		$(this).closest("div").find("b").text($(this).text());
		$(this).parent().hide();
		$(this).find("a").attr("href","javascript:void(0)");
	});
}
//低端不支持placeholder的行为
function SearchKeyword()
{
	var str_empty=/^[\s]*$/;//空
	if(!isLow())return;
	$(".jobs-text").val("关键字").focus(function(){
		if(this.value=='关键字') this.value='';
	}).blur(function(){
		if(str_empty.test(this.value)) this.value='关键字';
	});
}