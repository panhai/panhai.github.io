// 发布职位及公司资料用到的福利部分
$(function(){
	Boxes(".Welfares");
	//自定义福利，点叉关闭
	var WelAddup=$(".WelfaresAddup");
	WelAddup.delegate('a q','click',function(){
		var text=$.trim($(this).parent().text()),
			input=$(".WelfaresAddition"),
			items=input.val().split(','),
			index=$.inArray(text,items);
		if(index>=0) items.splice(index,1);
		input.val(items.join(','));
		$(this).parent().remove();
		if(WelAddup.children().length==0) WelAddup.hide();
		else WelAddup.show();
	});
	if(WelAddup.children().length==0) WelAddup.hide();
	else WelAddup.show();
	//自定义福利，点击添加
	$(".WelfareSubmit").click(function(){
		var text=$.trim($(".WelfareInput").val()),
			input=$(".WelfaresAddition"),
			values=input.val(),
			items=values ? values.split(',') : [],
			index=$.inArray(text,items),
			wels=$(".Welfares label"),
			welfares=wels.map(function(){
				return $(this).text();
			}).get(),
			index2=$.inArray(text,welfares);
		$(".WelfareInput").val('');
		if(index>=0)
		{//存在于自定义福利中
			alert("此福利已经存在！");
		}
		else if(index2>=0)
		{//存在于系统设定的福利中
			var wel=wels.eq(index2);
			if(wel.hasClass("checked"))
			{
				alert("此福利已经被勾选！");
			}
			else
			{
				wel.addClass("checked")
					.find(":checkbox").prop('checked',true);
			}
		}
		else if(items.length<3)
		{
			if (text == "") return;
			items.push(text);
			input.val(items.join(','));
			$(".WelfaresAddup").append('<a>'+ text +'<q>&nbsp;</q></a>')
			WelAddup.show();
		}
		else
		{
			alert('最多添加三项福利！');
		}
	});
});
