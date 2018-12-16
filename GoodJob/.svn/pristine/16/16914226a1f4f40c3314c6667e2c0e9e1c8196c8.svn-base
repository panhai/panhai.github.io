// 个人简历 
//画圈圈
function Circle(MAX)
{
//	var MAX=90;
	if(MAX<0 || isNaN(MAX))MAX=0;
	if(MAX>100)MAX=100;
	function a2t(angle){return angle*PI/180;}
	var o=document.getElementById("Percentage");
	var PI=Math.PI;
	var ctx=o.getContext("2d");
	ctx.lineWidth=5;
	var start=0,from=-90;
	var delta=5;
	var x=y=45,r=40;
	var timer=setInterval(function(){
		var a1=start+from,a2=start+delta*2+from;
		if(a1>=360+from)a1=360+from;
		if(a2>=360+from)a2=360+from;
		arc(a1,a2,'#eee');
		start+=delta;
		if(start>=360) {clearInterval(timer);timer=0;}
	},30);
	
	var timer2;
	var begin=0,over=MAX/100*360;
	setTimeout(function(){
		timer2=setInterval(function(){
			var a1=begin+from,a2=begin+delta*2+from;
			if(a2>over+from)a2=over+from;
			arc(a1,a2,'#ff9500');
			begin+=delta;
			if(begin>=over) {clearInterval(timer2);timer2=0;}
		},30);
	},1000);
	
	function arc(a1,a2,color)
	{
		var point=getPoint(a1);
		var t1=a2t(a1),t2=a2t(a2);
		ctx.beginPath();
		ctx.moveTo(point[0],point[1]);
		ctx.arc(x,y,r,t1,t2);
		ctx.strokeStyle=color;
		ctx.stroke();
	}
	
	function getPoint(angle)
	{
		var arr=[];
		var t=a2t(angle)
		arr[0]=r*Math.cos(t)+x;
		arr[1]=r*Math.sin(t)+y;
		return arr;
	}
}
//初始化单选按钮组
function Radios()
{
	$(":radio").parent().click(function(){
		$(this).addClass("checked").find(":radio").get(0).checked=true;
		$(this).siblings().removeClass("checked")
	});
	$(":checkbox").parent().click(function(){
		var box=$(this).find(":checkbox").get(0);
		if(isLow())
		{//此处，低端无法触发隐藏的复选框，不知道IE9+以上怎么样
			box.checked=!box.checked;
		}
		if(box.checked) $(this).addClass("checked");
		else $(this).removeClass("checked")
	});
	$(":checked").parent().addClass("checked");
}
//所有的下拉列表行为
function AllSelect()
{//timer是在dl上的
	$(".select dt").click(function(){
		var p=$(this).parent().get(0);
		clearTimeout(p.timer);
		p.timer=0;
		$(this).parent().css('zIndex',222)
			.find("dd").addClass("on")
		//下边的是要把其它打开的下拉列表关掉，不关掉本身的
		.closest("dl").siblings().css('zIndex',111)
			.find("dd").removeClass("on")
		.closest(".tr").siblings().find("dl").css('zIndex',111)
			.find("dd").removeClass("on");
		;
	})
	//父级，离开要延迟500毫秒
	.parent().mouseleave(function(){
		var t=this;
		if(!t.timer) t.timer=setTimeout(function(){
			$(t).css('zIndex',111)
				.find("dd").removeClass("on")
			;
		},500);
	}).mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
	});
	//下边只初始化普通的下拉列表的点击行为，它们的内容不会变，地址列表额外初始化
	$(".select").not(".ADDList").find("dd a")
		.attr("href","javascript:void(0)")
		.click(function(){
			var a=$(this),
				DL=a.closest("dl"),
				DT=DL.find("dt"),
				DD=DL.find("dd"),
				input=DL.find("input")
			
			input.val(a.attr("alt"));
			DT.html(a.html() + '<i></i>');
			DD.removeClass("on");
		});
	//大的职位选择框
	$(".subbie").find("blockquote").mouseenter(function(){
		$(this).addClass("on")
			.find("p").show();
	}).mouseleave(function(){
		$(this).removeClass("on")
			.find("p").hide();
	});
}
//初始化地址，只根据各自input的值来初始化
function AddressInit()
{
	$(".ADDList").map(function(ind,ele){
		var T=$(ele),
			dt=T.find("dt"),
			dd=T.find("dd"),
			adds=T.find(".addresses"),
			input=T.find("input"),
			id=input.val();
		
		var key=[0,0];
		if(T.hasClass("province")) key=['p','省份'];
		else if(T.hasClass("cities")) key=['c','城市'];
		else if(T.hasClass("districts")) key=['d','区域'];
		else if(T.hasClass("hots")) key=['b','商圈'];
		
		ele.name=key[1];
		ele.key=key[0];
		//还原隐藏域及DT中的内容
		ele.reset=function(){
			$(this).find("input").val('');
			this.setDT();
		}
		//根据自身的隐藏域的值，设置DT中的内容
		ele.setDT=function(str){
			if(!str)
			{//参数为空就初始化文字
				str='<span>请选择'+ this.name +'</span><i></i>';
				$(this).find("dt").html(str).attr('title','');
			}
			else
			{//有地址名就显示地址名，并给提示
				$(this).find("dt").html(str + '<i></i>').attr('title',str);
			}
		}
		//用自身ID填充地址列表，并显示地名
		ele.fillWithMe=function(){
			var me=$(this).find("input").val();
			if(me)
			{
				var myArr=GetArea(me);
				this.setDT(myArr[0]);
				var par=myArr[1];
				this.fillWithPar(par);
			}
			else
			{
				$(this).find(".address").empty();
				this.setDT();
			}
		}
		//用上级ID填充地址列表，并初始化提示
		ele.fillWithPar=function(par){
			if(par!=undefined)
			{
				var arrs=this.key=='b' ? GetDistricts(par) : GetAreas(par);
				AddressFill(arrs,T);
				if(!par)this.setDT();
			}
			else $(this).find(".address").empty();
		}
		if(id) ele.fillWithMe();
		else if(key[0]=='p') ele.fillWithPar(0);
		else ele.reset();
	});
}
//填充地址列表，将参数arr中的内容，填充到DL的.addresses中
function AddressFill(arr,DL)
{
	var dl=DL.get(0);
	var ads=DL.find(".addresses");
	var str='';
	for(var n in arr)
	{
		var add=arr[n];
		str+='<a href="javascript:void(0)" alt="'+ add[2] +'" title="'+ add[0] +'">'+ add[0] +'</a>';
	}
	ads.html(str);
	
	//给地址列表增加行为
	var input=DL.find('input'),
		DD=DL.find("dd");
	DL.find(".addresses a").click(function(){
		var priID=input.val();
		var a=$(this).blur(),
			newID=a.attr("alt"),
			remain=newID==priID;
		if(!remain)
		{
			input.val(newID);
			dl.setDT(a.html());
		}
		DD.removeClass("on");
		AddressNext(DL,remain);
	});
}
//初始化下级地址列表，DL是刚刚触发的dl的JQ对象
function AddressNext(DL,remain)
{//区域及商圈不涉及下级
	var dl=DL.get(0);
	if(!DL.next().size() || dl.name=='商圈')return;
	var NEXT=DL.next();
	if(dl.name!='区域')
	{
		var next=NEXT.get(0),
			par=DL.find("input").val();
		
		if(!remain)
		{//如果上级变化了，下级就要还原
			next.fillWithPar(par);
			DL.nextAll().map(function(ind,ele){
				ele.setDT();
			});
			if(DL.get(0).key=='p' && DL.nextAll(".districts").size())
			{//省值变，要清空区
				DL.nextAll(".districts").find(".addresses").empty();
			}
		}
//		var HOTS=DL.nextAll(".hots");
//		if(HOTS.size())
//		{
//			if(DL.get(0).key=='c')
//			{//市值有变化，商圈重新填充
//				var arr=GetDistricts(DL.find("input").val());
//				AddressFill(arr,HOTS);
//				if(!remain) HOTS.get(0).setDT();
//			}
//			else if(DL.get(0).key=='p' && !remain)
//			{//省值有变化，商圈清空
//				HOTS.find(".addresses").empty();
//			}
//		}
	}
	NEXT.find("dt").click();
}
//浏览模式，单项式single两种不能同时存在，列表式list会同时存在
function ViewMode()
{
	$(".view-mode").show();
	$(".edit-mode").hide();
	$("h3").find("i").click(function(){
		//在这里插入点击“编辑”要准备的过程
		$(this).hide()
			.closest(".resume").find(".edit-mode").show()
			.siblings(".view-mode").hide();
	}).end()
	.find("s").click(function(){
		//在这里插入点击“添加”要准备的过程
		$(this).closest(".resume").find(".edit-mode").show();
	});
	$(".resume").find(":reset,:submit").click(function(){
		if(this.type=='reset')
		{//点击取消要执行的过程
		}
		else
		{//点击保存要执行的过程
		}
		$(this).closest(".edit-mode").hide()
			.siblings(".view-mode").show()
			.closest(".resume").find("h3 i").show();
	})
}
//复杂的浏览信息列表的编辑及删除行为
function ComplexAct()
{
	$(".complex").find("i").click(function(){
		$(this).closest("dl").hide();
	})
	.end().find("q").click(function(){
		var result=confirm("真的要删除本条信息吗？");
		if(result)
		{
			//删除的行为加在前边
			$(this).closest("dl").remove();
		}
	});
}