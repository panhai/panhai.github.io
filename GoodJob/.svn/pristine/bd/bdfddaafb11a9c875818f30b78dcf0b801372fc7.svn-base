//帮助中心

//简单的radio组效果，适用于label中包裹的radio，且没有特殊行为的
function SimpleRadios(Context)
{
	$(Context).find("label").has(":radio").click(function(){
		$(this).addClass("checked").find(":radio").get(0).checked=true;
		$(this).siblings().removeClass("checked");
	});
}
//上传图片，点叉移除
function Figure()
{
	$(".figure,.photo").delegate("q",'click',function(){
		$(this).parent().remove();
	});
}
//提问列表
function List()
{
	$(".asks li h3").click(function(){
		if($(this).hasClass('cur'))
		{
			$(this).removeClass('cur')
				.next().hide();
		}
		else
		{
			$(this).addClass('cur')
				.next().show();
		}
	});
}