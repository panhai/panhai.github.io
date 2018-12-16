// 开通企业招聘服务，及企业资料修改共同使用
$(function(){
	///////////////////////////////////////////////////////////////////////////////////////////////////////////填充行业大列表
	var str=[];
	array=subjectArray;strTH=null;strTD=null;
	level1Reset=true;level2Reset=true;
	for(var n=0;n<array.length;n++)
	{
		var id=array[n][2],name=array[n][0];
		if(id.indexOf('00')>=0)
		{//一级名称，加入表头，并重起一行
			if(!level1Reset) str.push('</td></tr>');
			str.push('<tr><th>'+ name.replace(/[\|\/]/g,'　') +'</th><td>');
			level1Reset=false;
		}
		else
		{//二级名称，直接加入链接
			str.push('<a data-id="'+ id +'">'+ name +'</a> ');
		}
	}
	$(".filter-profs tbody").html(str.join(''));
	//地图行为 已在页面实现
	//var Map=BaiduMap("MapContainer",{editable:true});
	//更换城市时，自动锁定新中心 已在页面实现
	//$(".Cities input[type=hidden]").change(function(){
	//	var city=GetArea(this.value),
	//		name=city[0];
	//	Map.search(name);
	//});
	//点击定位，至少要有城市 已在页面实现
	//$(".Locate").click(function(){
	//	var detail=$(".AddressDetail").val(),
	//		city=$(".Cities input[type=hidden]").val(),
	//		names=[];
	//	if(!city)
	//	{
	//		alert("请选择城市！");
	//		return false;
	//	}
	//	if(!detail)
	//	{
	//		alert("请输入详细地址！");
	//		return false;
	//	}
	//	names.push(GetArea(city)[0]);
	//	names.push(detail);
	//	Map.search(names.join(''));
	//});
	/*根据点击的项目不同，上传的要求也不同*/
	var upload=$(".Upload"),
		uptitle=upload.find(".CENTERTOPIC b"),
		upsize=upload.find(".filesize");
	//相册点击叉 删除功能已在页面实现
	//$(".figure").delegate("q",'click',function(){
	//	alert("删除相片的过程");
	//	$(this).parent().find("q,img").remove();
	//})
	//.find("p").click(function(){
	//	uptitle.text("上传企业相册");
	//	upsize.text(5);
		/*点击没有图片的加号时
		$(this).before($("<img src='缩略图地址'>"));
		$(this).after($("<q/>"));
		$(this).hide();
		*/
		/*点击有图片的加号时
		$(this).prev("img").remove();
		$(this).before($("<img src='缩略图地址'>"));
		$(this).hide();
		*/
	//});
	//点击上传LOGO，标题变，尺寸变5M
	$(".logo,.upload[data-url='logo']").click(function(){
		uptitle.text("上传企业LOGO");
		upsize.text(5);
		/*当没有logo时，点击上传蓝块，成功后执行
		$(".upload[data-url='logo']").hide();
		$(".logo").append($("<img src='缩略图的地址'>")).show();
		*/
		/*当有logo时，点击logo，上传成功后执行
		$(".logo").find("img").remove();
		$(".logo").append($("<img src='新缩略图的地址'>"));
		*/
	});
	//点击上传执照，标题变，尺寸变10M
	$(".licence,upload[data-url='licence']").click(function(){
		uptitle.text("上传营业执照");
		upsize.text(10);
		/*当没有执照时，点击上传蓝块，成功后执行
		$(".upload[data-url='licence']").hide();
		$(".licence").append($("<img src='缩略图的地址'>")).show();
		*/
		/*当有执照时，点击执照，上传成功后执行
		$(".licence").find("img").remove();
		$(".licence").append($("<img src='新缩略图的地址'>"));
		*/
	});
	//动态化figure的行为，有图片的里边的p（加号）要隐藏，鼠标放上去时出来，没图片的p不管
	$("body").delegate(".figure:has(img[src!=''])",'mouseenter',function(){
		$(this).find("p").show();
	}).delegate(".figure:has(img)",'mouseleave',function(){
		$(this).find("p").hide();
	}).find(".figure:has(img) p").hide();


	
});
$(window).load(function(){
	CHIpros(".logo,.figure,.licence",'','',true);
	//getImage();
});
