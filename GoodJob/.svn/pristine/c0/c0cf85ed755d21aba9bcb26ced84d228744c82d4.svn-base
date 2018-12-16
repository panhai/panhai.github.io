// 个人简历 
//画圈圈
function Circle(MAX)
{
	$("#Percentage").next("b").html(MAX+"%");
	var r=40;
	var w/*strokeWidth*/=5;
	var d=isLow() ? -3 : 0;
	var raphael=Raphael("Percentage",90,90);
	/*angle from,angle to,radius,stroke-width*/
	raphael.customAttributes.arc=function(af,at,r,w){
		var PI=Math.PI,
			Rad=PI/180,
			cos=Math.cos,
			sin=Math.sin,
			x0=r+w,
			y0=r+w,
			obj={
				R:r,
				Large:((at-af)>180)*1,
				xF:x0+r*cos(af*Rad-PI/2)+d,
				yF:y0+r*sin(af*Rad-PI/2)+d,
				xT:x0+r*cos(at*Rad-PI/2)+d,
				yT:y0+r*sin(at*Rad-PI/2)+d
			}
		;
		var path=this.paper.raphael.fullfill("M{xF},{yF}A{R},{R},0,{Large},1,{xT},{yT}",obj);
		return {path:path};
	}
	
	var p=raphael.path().attr({"stroke":"#ccc","stroke-width":5,"arc":[0,0.01,r,5]})
		.animate({"arc":[0,359.99,r,5]},3000);
	var pp=raphael.path().attr({"stroke":"#ff5e00","stroke-width":5,"arc":[0,0.01,r,5]});
	var per=MAX;
	var a=Raphael.animation({"arc":[0,per*3.6,r,5]},per*30);
	pp.animate(a.delay(500));
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
	//在校生状态最多选一个
	var boxes=$("[name=atSchool]");
	//alert(boxes.size());
	boxes.parent().click(function(){
		var box=$(this).find(":checkbox").get(0);
		if(box.checked)
		{
			boxes.not(box).map(function(ind,ele){
				ele.checked=false;
				$(ele).parent().removeClass("checked");
			});
		}
	})
}
//所有的下拉列表行为
function AllSelect()
{//timer是在dl上的
	$(".select dt").click(function(){
		var p=$(this).parent().get(0);
		clearTimeout(p.timer);
		p.timer=0;
		var v=$(this).parent().find("input:hidden").val();
		$(this).parent().css('zIndex',222)
			.find("dd").addClass("on")
			.find("a").removeClass("cur")
			.filter("[alt='"+ v +"']").addClass("cur")
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
		},($(t).hasClass("JOBS") ? 1000 : 500));
	}).mouseenter(function(){
		clearTimeout(this.timer);
		this.timer=0;
	});
	//下边只初始化普通的下拉列表的点击行为，它们的内容不会变，地址列表额外初始化
	$(".select").not(".ADDList,.JOBS").find("dd a")
		.attr("href","javascript:void(0)")
		.click(function(){
			var a=$(this),
				DL=a.closest("dl"),
				DT=DL.find("dt"),
				DD=DL.find("dd"),
				input=DL.find("input")
			
			input.val(a.attr("alt"));
			if (JB) JB.fireEvent(input.get(0), "change");
			else input.change();
			DT.html(a.html() + '<i></i>');
			DD.removeClass("on");
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
			$(this).find("input").val('').change();
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
				AddressFill(arrs,T,this.name=='区域');
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
function AddressFill(arr,DL,nolimit)
{
	var dl=DL.get(0);
	var ads=DL.find(".addresses");
	var str='';
	for(var n in arr)
	{
		var add=arr[n];
		str+='<a href="javascript:void(0)" alt="'+ add[2] +'" title="'+ add[0] +'">'+ add[0] +'</a>';
	}
	if(nolimit) str+='<a href="javascript:void(0)" alt=" " title="不限">不限</a>';
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
			input.val(newID).change();
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
				//ele.setDT();
				ele.reset();
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
		var T=$(this).closest(".resume").find(".edit-mode");
		$(this).hide();
		T.find("form").map(function(ind,ele){FormRebuild(ele);});
		T.show().siblings(".view-mode").hide();
	}).end()
	.find("s").click(function(){
		//在这里插入点击“添加”要准备的过程
		var T=$(this).closest(".resume").find(".edit-mode");
		T.find("form").map(function(ind,ele){FormReborn(ele);});
		T.show();
	});
	$(".resume").find(":reset,:submit").click(function(){
		var V=$(this).closest(".resume").find(".view-mode").children();
		if(this.type=='reset')
		{//点击取消要执行的过程
		}
		else
		{//点击保存要执行的过程
			
		}
		$(this).closest(".edit-mode").hide()
			.siblings(".view-mode").show()
				.children().children().show()
			.closest(".resume").find("h3 i").show();
	})
}
//复杂的浏览信息列表的编辑及删除行为
function ComplexAct()
{
	$(".view-mode").find("i").click(function(){
		var em=$(this).closest(".resume").find(".edit-mode");
		var p=$(this).closest(".view-mode").hide();
		em.insertBefore(p);
		
		var F=$(this).closest(".resume").find("form").get(0);
		//这里边要加入AJAX读数据的过程
		/*
		Datas[F.id]={};
		*/
		FormRebuild(F);
		em.show();
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
//利用与FORM同ID名的JSON对象，初始化表单
function FormRebuild(DOMform)
{
	var arr=$(DOMform).find("input,textarea").toArray();
	for(var n=0;n<arr.length;n++)
	{
		var i=arr[n];
		if(DOMform.id && Datas[DOMform.id] && Datas[DOMform.id][i.id])
		{
			var data=Datas[DOMform.id][i.id];
			FormSet(i.id,data);
		}
	}
}
//生成一个全新的空表单
function FormReborn(DOMform)
{
	var arr=$(DOMform).find("input,textarea").toArray();
	for(var n=0;n<arr.length;n++)
	{
		var i=arr[n];
		FormSet(i.id,'');
	}
}
//要设置ID组件，值为val
function FormSet(ID,val)
{
	var t=$("#"+ID);
	if(!t.size() || val===undefined)return;
	switch(t.get(0).type)
	{
		case "text":
		case "textarea":
			t.val(val);
			break;
		case "radio":
			var b=Boolean(val);
			if(!b)return;
			var rs=document.getElementsByName(t.get(0).name);
			for(var x=0;x<rs.length;x++)
			{
				var r=rs[x];
				if(r.id==ID)
				{
					r.checked=true;
					$(r).closest("label").addClass("checked")
						.siblings().removeClass("checked");
					return;
				}
			}
			break;
		case "checkbox":
			var b=Boolean(val);
			t.get(0).checked=b;
			if(b) t.closest("label").addClass("checked");
			else t.closest("label").removeClass("checked");
			break;
		case "hidden":
			t.val(val);
			var T=t.closest(".select");
			if(T.size())
			{//如果是下拉列表的，需要设置显示字；选定状态在点击之后确认
				val=parseInt(val);
				if(T.hasClass("ADDList"))
				{//地址列表读取数据中的地址名
					T.get(0).fillWithMe();
					if(!val) T.get(0).reset();
					else
					{
						str=GetArea(val);
						if(str)str=str[0];
						T.find("dt").html(str + '<i></i>');
					}
				}
				else
				{//普通下拉列表读取列表中对应值
					str=T.find("dd a").filter("[alt="+ val +"]");
					if(str.size()) str=str.html();
					else str="<span>请选择</span>";
					T.find("dt").html(str + '<i></i>');
				}
			}
			break;
		default:break;
	}
}

//大的职位选择框，在本页有多选功能，所以要剔除之前的效果
function Subbie(ids)
{
	var T=$(".subbie-tags.JOBS");//存放标签的地方
	var S=$(".JOBS .subbie");
	var N=S.siblings(".normal");
	var I=$(".job-input");
	var names={};
	var DL=$("dl.JOBS");
	DL.find("dt")
		.click(function(){
			var jobs=DL.find(".normal").children();
			if(jobs.size())
			{
				S.hide();
				N.show();
			}
			else
			{
				N.hide();
				S.show();
			}
		})
	;
	N.delegate("a",'click',function(){AddUp(this);});
	
	I.keyup(function(){
		S.hide();
		var v=I.val();
		if(v=='')
		{
			N.html('<span>请输入关键字</span>');
		}
		else
		{
			var jobs=GetPositionsByKeywords(v);
			var str='';
			if(jobs.length==0)
			{
				N.html('<span>查无结果</span>');
			}
			else
			{
				for(var x=0;x<jobs.length;x++)
				{
					var id=jobs[x][2],name=jobs[x][0];
					str+='<a href="#" title="'+ name +'"><input type="checkbox" value="'+ id +'" id="BoxCopy'+ id +'"'+ ck +'><label for="BoxCopy'+ id +'">'+id+ name +'</label></a>';
				}
				N.html(str);
				N.find("input").map(function(ind,ele){
					var /*original*/org=ele.id.replace('Copy','')
					org=document.getElementById(org);
					if(org)
					{
						ele.checked=org.checked;
					}
				});
			}
		}
		N.show();
	});
	
	if(01)
	{
		var id=0;
		var ps=GetPositions(0);
		var str='<table><tbody>';
		for(var i=0;i<ps.length;i++)
		{
			str+='<tr><th>'+ ps[i][0] +'</th><td>';
			
			var kids=GetPositions(ps[i][2]);
			
			for(var j=0;j<kids.length;j++)
			{
				var n=kids[j][0];
				var sn=n.substring(0,10);
				str+='<blockquote'+ (j%4==3 ? ' class="last"' : '') +'><var><a href="#" title="'+ n +'">'+ sn +'<i></i></a></var><p>';
				
				var nodes=GetPositions(kids[j][2]);
				for(var k=0;k<nodes.length;k++)
				{
					var n=nodes[k],
						name=n[0],
						id=n[2],ck;
					if(ids.indexOf(id)>=0)
					{
						names[id]=name;
						ck='checked'
					}
					else ck='';
					str+='<a href="#" title="'+ name +'"><input type="checkbox" value="'+ id +'" id="Box'+ id +'"'+ ck +'><label for="Box'+ id +'">'+ name +'</label></a>';
				}
				
				str+='</p></blockquote>';
			}
			
			str+='</td></tr>';
		}
		str+='</tbody></table>';
		
		S.html(str);
	}
	
	S.find("blockquote").mouseenter(function(){
		$(this).addClass("on").find("p").show();
	}).mouseleave(function(){
		$(this).removeClass("on").find("p").hide();
	})
	.end()
	.find("a").attr("href","javascript:void(0)").unbind("click")
	//.has("label")
	.end()
	.find("p a")
	.click(function(){AddUp(this);});
	
	function AddUp(tar)
	{
		var i=$(tar).find(":checkbox").get(0);
		var another=i.id.indexOf('Copy')>=0 ? i.id.replace('Copy','') : i.id.replace('Box','BoxCopy');
		another=document.getElementById(another);
		var v=i.value;
		if(i.checked)
		{
			if(S.find(":checkbox:checked").size()>3)
			{
				i.checked=false;
				alert("最多选择3个");
			}
			else
			{
				if(!T.find("a[alt='"+ v +"']").size())
				T.prepend('<a alt="'+ v +'"><span>'+ $(tar).text() +'</span><q>&times;</q></a>');
				if(another)another.checked=true;
			}
		}
		else
		{
			T.find("a[alt='"+ v +"']").remove();
			if(another)another.checked=false;
		}
		fresh();
	}
	
	T.delegate("a q",'click',function(){
		var T=$(this).closest("a");
		var V=parseInt(T.attr("alt"));
		T.remove();
		S.find(":checkbox[value="+ V +"]").map(function(){this.checked=false;});
		N.find(":checkbox[value="+ V +"]").map(function(){this.checked=false;});
		fresh();
	});
	
	if(ids)
	{
		for(var x in names)
		{
			T.append('<a alt="'+ x +'"><span>'+ names[x] +'</span><q>&times;</q></a>');
		}
	}
	
	function fresh()
	{
		var HAS=S.find(":checked").closest("blockquote");
		HAS.find("var a").addClass("has");
		S.find("blockquote").not(HAS).find("var a").removeClass("has");
		if(isLow()) T.height((T.children().size() ? 35 : 'auto'));
	}
	fresh();
}
//点击导入简历
function ImportStart()
{
	var CenterDiv=$('.ImportStart');
	var Center=CenterDiv.get(0);
	Center.open();
	$(".ImportStep1").show().siblings("dd").hide();
}
//第一步中点击导入
function ImportAction()
{
	//验证帐号等步骤
	$(".ImportStep2").show().siblings("dd").hide();
}
//第二步中点击导入
function ImportFinish()
{
	//覆盖现有信息
	$(".ImportStep3").show().siblings("dd").hide();
}



//新的行业选择大框
function Professions(ids)
{
	var T=$(".subbie-tags.PROS");//存放标签的地方
	var S=$(".PROS .subbie");
	var N=S.siblings(".normal");
	var I=$(".pro-input");
	var names={};
	var DL=$("dl.PROS");
	DL.find("dt")
		.click(function(){
			var jobs=DL.find(".normal").children();
			if(jobs.size())
			{
				S.hide();
				N.show();
			}
			else
			{
				N.hide();
				S.show();
			}
		})
	;
	N.delegate("a",'click',function(){AddUp(this);});
	
	I.keyup(function(){
		S.hide();
		var v=I.val();
		if(v=='')
		{
			N.html('<span>请输入关键字</span>');
		}
		else
		{
			var jobs=GetSubjectsByKeywords(v);//这个函数在subjects.js文件里边没有
			var str='';
			if(jobs.length==0)
			{
				N.html('<span>查无结果</span>');
			}
			else
			{
				for(var x=0;x<jobs.length;x++)
				{
					var id=jobs[x][2],name=jobs[x][0];
					str+='<a href="#" title="'+ name +'"><input type="checkbox" value="'+ id +'" id="BoxCopy'+ id +'"'+ ck +'><label for="BoxCopy'+ id +'">'+id+ name +'</label></a>';
				}
				N.html(str);
				N.find("input").map(function(ind,ele){
					var /*original*/org=ele.id.replace('Copy','')
					org=document.getElementById(org);
					if(org)
					{
						ele.checked=org.checked;
					}
				});
			}
		}
		N.show();
	});
	
	if(01)
	{
		var id=0;
		var ps=GetSubjects(0);
		var str='<table><tbody>';
		for(var i=0;i<ps.length;i++)
		{
			str+='<tr><th>'+ ps[i][0] +'</th><td>';
			
			var kids=GetSubjects(ps[i][2]);
			
			for(var j=0;j<kids.length;j++)
			{
				var name=kids[j][0],id=kids[j][2],ck;
				var sn=name.substring(0,10);
				if(ids.indexOf(id)>=0)
				{
					names[id]=name;
					ck='checked'
				}
				else ck='';
				str+='<code'+ (j%4==3 ? ' class="last"' : '') +'><label title="'+ name +'"><input type="checkbox" value="'+ id +'" id="Box'+ id +'"'+ ck +'>'+ sn +'</label></code>';
			}
			
			str+='</td></tr>';
		}
		str+='</tbody></table>';
		
		S.html(str);
	}
	
	S.find("label").click(function(){AddUp(this);});
	
	function AddUp(tar)
	{
		var i=$(tar).find(":checkbox").get(0);
		var another=i.id.indexOf('Copy')>=0 ? i.id.replace('Copy','') : i.id.replace('Box','BoxCopy');
		another=document.getElementById(another);
		var v=i.value;
		if(i.checked)
		{
			if(S.find(":checkbox:checked").size()>3)
			{
				i.checked=false;
				alert("最多选择3个");
			}
			else
			{
				if(!T.find("a[alt='"+ v +"']").size())
				T.prepend('<a alt="'+ v +'"><span>'+ $(tar).text() +'</span><q>&times;</q></a>');
				if(another)another.checked=true;
			}
		}
		else
		{
			T.find("a[alt='"+ v +"']").remove();
			if(another)another.checked=false;
		}
	}
	
	T.delegate("a q",'click',function(){
		var T=$(this).closest("a");
		var V=parseInt(T.attr("alt"));
		//console.log(S.find(":checkbox[value]").size());
		T.remove();
		S.find(":checkbox[value="+ V +"]").map(function(){this.checked=false;});
		N.find(":checkbox[value="+ V +"]").map(function(){this.checked=false;});
	});
	
	if(ids)
	{
		for(var x in names)
		{
			T.append('<a alt="'+ x +'"><span>'+ names[x] +'</span><q>&times;</q></a>');
		}
	}
	
}

function Schools()
{
	$(".schools").on('keyup focus click',function(event){
		var key=event.which;
		if($.inArray(key,[40,38,13])>=0 && event.type=='keyup')return true;
		key=this.value;
		var dl=$(this).closest('dl'),
			dd=dl.find('dd');
			tip=dd.find('.tip'),
			result=dd.find('.matches')
		if(!key)
		{//无关键字则收回提示及匹配
			tip.html('请输入关键字').show();
			result.hide();
			return true;
		}
		if(typeof GetUniversitiesByKeyword =='undefined')
		{
			alert('缺少包含文件universities.js');
			return false;
		}
		var univs=GetUniversitiesByKeyword(key),count=univs.length;
		if(count)
		{//最大选项数，如果不设置则显示全部
			var matches=dl.data("matches"),str=[];
			if(!matches) matches=count;
			var over=Math.min(matches,count);
			for(var n=0;n<over;n++)
			{
				var university=univs[n];
				str.push('<a href="javascript:void(0)" title="', university ,'">', university ,'</a>');
			}
			result.html(str.join('')).show();
			tip.hide();
		}
		else
		{//修改提示
			tip.html('对不起，找不到符合'+ key +'的学校').show();
			result.hide();
		}
	});
}