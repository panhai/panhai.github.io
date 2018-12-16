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
				input=DL.find("input"),
				oldid=input.val();
			input.val(a.attr("alt"));
			if(oldid!=input.val())
			{
				if (typeof (JB) != "undefined") {
					JBValidatorContainer.closeMsg(input.get(0));
					JB.fireEvent(input.get(0), "change");
					//console.log('JBevent');
				}
				else
				{
					input.change();
					//console.log('normal 50');
				}
			}
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
	$(".ADDList").each(function(ind,ele){
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
				$(this).find("dt").html(str).attr('title','')
				.end().find("input:hidden").val('');
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
			var next=$(this).next(".ADDList");
		}
		//用上级ID填充地址列表，并初始化提示
		ele.fillWithPar=function(par){
			if(par!==undefined)
			{
				var arrs=this.key=='b' ? GetDistricts(par) : GetAreas(par);
				AddressFill(arrs,T);
				if(!par || id==='')this.setDT();
			}
			else $(this).find(".address").empty();
		}
		
		if(id!=='') ele.fillWithMe();
		else if(key[0]=='p') ele.fillWithPar(0);
		else
		{
			var previous=$(ele).prev(".ADDList"),
				parid=previous.find("input").val();
			if(parid) ele.fillWithPar(parid);
			else ele.reset();
		}
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
				ele.setDT();
			});
			if(DL.get(0).key=='p' && DL.nextAll(".districts").size())
			{//省值变，要清空区
				DL.nextAll(".districts").find(".addresses").empty();
			}
		}
	}
	NEXT.find("dt").click();
}

function Tags()
{
	$(".tags label").click(function(){
		var T=$(this);
		if(T.hasClass("checked"))
		{
			T.removeClass("checked");
			T.prev("input").get(0).checked=false;
		}
		else
		{
			T.addClass("checked");
			T.prev("input").get(0).checked=true;
		}
	});
}

function AddUp()
{
	var I = $(".addup input");
    var LI = $(".addup").closest("li");
	function init() {
	    //var x = $(".addup a span").map(function () { return $(this).text(); });
	    //I.val(x.get().join(","));
	    if (I.val()) {
	        var arr = I.val().split(',');
	        for (var n = 0; n < arr.length; n++) {
	            $(".addup").append('<a><span>' + arr[n] + '</span><q>&times;</q></a>');
	        }
	        LI.show();
	    }
	    else {
	        LI.hide();
	    }
	}
	init();
	$(".addup").delegate('a q', 'click', function () {
	    var T = $(this).parent();
	    var t = T.find("span").text();
	    T.remove();
	    var arr = I.val().split(',');
	    var arrTemp = new Array();
	    for (var i in arr) { if (arr[i] != t) { arrTemp.push(arr[i]); } }
	    I.val(arrTemp.join(','));
	});
	var N=$(".add-text");
	$(".add-btn").click(function(){
		var t=N.val();
		if(t)
		{
                        if (t.length > 10) { alert('福利长度不能大于10'); return false;}
			var arr=I.val().split(',');
			for(var i=0;i<arr.length;i++)
			{
				if(arr[i]==t){alert('该福利已经存在！');return false;}
			}
			if(arr.length>=3)
			{
				alert("最多输入三项");
			}
			else
			{
				if(arr[0])arr.push(t);
				else arr[0]=t;
				I.val(arr.join(','));
				$('<a><span>'+ t +'</span><q>&times;</q></a>').appendTo(".addup");
				LI.show();
				N.val('');
			}
		}
		else
		{
			alert("请输入福利！");
		}
	});
}
//地图的切换中心
function getBaiduMap()
{
	var map;
	map = new BMap.Map("mapContainer");          // 创建地图实例  
	map.addControl(new BMap.NavigationControl());    
	map.enableScrollWheelZoom();

	map.focus=function(lng,lat){
		var point=new BMap.Point(lng,lat);
		map.centerAndZoom(point,15);
		var marker = new BMap.Marker(point);        // 创建标注    
		map.addOverlay(marker);                     // 将标注添加到地图中
	}
	
	return map;
}
var map,cp,marker,local,menu,point,inited=false,defaultLng=113.30764967515,defaultLat=23.120049102076;

function MapInit()
{
	map=new getBaiduMap();
	map.addEventListener("rightclick", function(event){
	    point = event.point;
	});
	menu = new BMap.ContextMenu();
	menu.addItem(new BMap.MenuItem('在此添加标注',function(){
	    addMarker(point);
	},100));
	map.addContextMenu(menu);

	var addMarker = function (point) {
	    map.clearOverlays();
	    marker = new BMap.Marker(
                point,
                { icon: new BMap.Icon('/images/large_blue.gif', new BMap.Size(25, 37)), offset: new BMap.Size(0, -18) }
            );
	    marker.enableDragging();
	    $(".maplng").val(point.lng);
	    $(".maplat").val(point.lat);
	    map.centerAndZoom(point, 15);
	    marker.addEventListener("dragend", function (event) {
	        var pt = event.point;
	        //拖拽完成时的点坐标
	        $(".maplng").val(pt.lng);
	        $(".maplat").val(pt.lat);
	    });
	    map.addOverlay(marker);
	    if (typeof (JBValidatorContainer) != "undefined") {
	        JBValidatorContainer.closeMsg($(".maplng").get(0));
	        JBValidatorContainer.closeMsg($(".maplat").get(0));
	    }
	}

    //点击定位
	var myGeo = new BMap.Geocoder();//地址解析
	var getCurArea = function () {
	    var ids3 = $(".ADDList input:hidden").map(function () {
	        var temp = GetArea(this.value);
	        return temp == null ? "" : temp[0];
	    }).get().join('');
	    ids3.replace('北京北京', '北京');
	    ids3.replace('上海上海', '上海');
	    ids3.replace('天津天津', '天津');
	    ids3.replace('重庆重庆', '重庆');
	    return ids3;
	}
	$("#address_locate").click(function(){
		var detail=$(this).prev().val();
		if (!detail) { alert('请写入详细地址'); $(this).prev().focus(); return false; }
		var addr = getCurArea();
		myGeo.getPoint(addr + detail, function (p) {
		    if (p) {
		        map.clearOverlays();
		        addMarker(p);
		    } else { alert("找不到搜索的地址，请拖动地图在准确的位置单击右键进行标注"); }
		});
	});
	//当下拉列表触发隐藏域的change事件时，地图变化
	$(".ADDList input:hidden").change(function () {
	    var add_all = '', o = this;
	    add_all = GetArea(this.value)[0];
	    map.centerAndZoom(add_all,15);
	});
    //初始化坐标
	var initLng = parseFloat($(".maplng").val());
	var initLat = parseFloat($(".maplat").val());
	if (initLng > 0 && initLat > 0) {
	    var point = new BMap.Point(initLng, initLat);
	    map.centerAndZoom(point);
	    addMarker(point);
	    inited = true;
	} else {
	    map.centerAndZoom(getCurArea(),15);
	    inited = true;
	}
	//如果未从三个地址项中初始化，则初始化默认坐标
	if(!inited) map.centerAndZoom(new BMap.Point(defaultLng,defaultLat));
	
}