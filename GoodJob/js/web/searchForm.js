// 高级搜索表单页
//附加表单伸缩
function Subform()
{
	var sf=$(".subform");
	var t=$(".switch-subform");
	var tx=t.html();
	t.click(function(){
		if(!this.on)
		{
			sf.slideDown();
			this.on=true;
			$(this).html("<span>收起</span><i class='on'></i>");
		}
		else
		{
			sf.slideUp();
			this.on=false;
			$(this).html(tx);
			$(".btns").last().hide();
			$(".btns").first().css("visibility",'visible');
		}
	});
}
//关键字placeholder
function SearchKey()
{
	if(!isLow())return;
	var txt='请输入职位名称、公司名称等关键字';
	var str_empty=/^[\s]*$/;//空
	if(!isLow())return;
	$(".search-text").val(txt).focus(function(){
		if(this.value==txt) this.value='';
	}).blur(function(){
		if(str_empty.test(this.value)) this.value=txt;
	});
}
//所有readonly的text都blur
function TextBlur()
{
	$(".search-item").focus(function(){this.blur()});
}
//显示子层
function ShowDiv()
{
	$(".search-form dfn").click(function(event){
		var tn=event.target.tagName.toLowerCase()
		if(tn=='i' || tn=='samp')
		$(this).addClass("on").children("div").show();
	}).mouseleave(function(){
		$(this).removeClass("on").children("div").hide();
	})
	.children("div").mouseleave(function(event){
		$(this).hide().parent().removeClass("on");
	}).mouseenter(function(){
		$(this).show().parent().addClass("on");
	})
	.find("blockquote").mouseenter(function(){
		$(this).addClass("on")
			.find("p").show();
	}).mouseleave(function(){
		$(this).removeClass("on")
			.find("p").hide();
	})
	.end().on("click","a",function(){
		if($(this).closest(".multiple").size()==0)
		{//单选的效果
			$(this).blur().closest("dfn")
				.find("input").val($(this).data('id'))
				.siblings("samp").html($(this).html())
				.siblings("div").mouseleave();
		}
		else
		{//多选的效果
			var picker=$(this).closest(".multiple").find(".picker");
			var list=picker.find(".picker-list");
			if($(this).hasClass("has"))
			{//已经选中的取消
				$(this).removeClass("has");
				if($(this).IN("p"))
				{
					if($(this).siblings(".has").size()==0)
					$(this).parent().siblings("var").removeClass("has");
				}
				list.find("[data-id='"+ $(this).data("id") +"']").remove();
			}
			else
			{//没选中的，看情况
				if(list.children().size()==3) alert("最多选择3个");
				//else if(list.find("[data-id='"+ $(this).data("id") +"']").size()>0) alert("该项目已经选中！");
				else
				{
					$(this).addClass("has");
					if($(this).IN("p")) $(this).parent().siblings("var").addClass("has");
					list.append('<li data-id="'+ $(this).data('id') +'"><span>'+ $(this).html() +'</span><q>&times;</q></li>');
				}
			}
		}
	}).find("a").attr("href", "javascript:void(0)");
	//多选采集的初始化
	if($(".picker").size())
	$(".picker").find(".picker-confirm").click(function(){
		//点击确定按钮
		var list=$(this).siblings(".picker-list");
		var ids=[],names=[];
		list.find("li").map(function(){
			ids.push($(this).data("id"));
			names.push($(this).find("span").text());
		});
		names=names.length ? names.join(',') : '不限';
		ids=ids.length ? ids.join(',') : '';
		$(this).closest(".multiple").siblings("input").val(ids)
			.siblings("samp").html(names)
			.attr("title",names)
			.siblings("div").mouseleave();
	}).siblings(".picker-list").delegate('li q','click',function(){
		var id=$(this).closest("li").data("id");
		$(this).closest(".multiple").find("[data-id='"+ id +"']").click();
	});
}
//保存及调用搜索器
function Actions()
{
	$(".actions var").click(function(){
		if($(this).hasClass("on"))
		{
			$(this).removeClass("on")
				.find("div").hide();
		}
		else
		{
			$(this).addClass("on")
				.find("div").show()
			.end().siblings("var").removeClass("on")
				.find("div").hide();
		}
	}).find("a").focus(function(){this.blur();});
	$("body").click(function(event){
		var t=event.target;
		if(!$(t).IN(".actions var"))
		$(".actions var").removeClass("on").find("div").hide();
	});
	$(".save input").click(function(event){
		event.stopPropagation()
	});
}
