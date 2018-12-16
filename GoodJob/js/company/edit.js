// 修改企业资料
//上传图片，点叉移除
function Figure()
{
	$(".figure,.photo").delegate("q",'click',function(){
		$(this).parent().remove();
	});
}
//所有的下拉列表行为
function AllSelect()
{//timer是在dl上的
	$(".select dt").click(function(){
		var p=$(this).parent().get(0);
		clearTimeout(p.timer);
		p.timer=0;
		$(this).parent().css('zIndex',222222)
			.find("dd").addClass("on")
		//下边的是要把其它打开的下拉列表关掉，不关掉本身的
		.closest("dl").siblings().css('zIndex',111)
			.find("dd").removeClass("on")
		.closest(".tr").siblings().find("dl").css('zIndex',111)
			.find("dd").removeClass("on");
		
		//自动关闭错误消息提示层
		if (typeof (JBValidatorContainer) != "undefined") {
		    JBValidatorContainer.closeMsg($(this).siblings("input").get(0));
		}
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
//附加福利
function AddUp() {
    var I = $(".addup input");
    var LI = $(".addup").closest("li");
    function init() {
        //		if($(".addup a").size())
        //		{
        //			var x=$(".addup a span").map(function(){return $(this).text();});
        //			I.val(x.get().join(","));
        //			LI.show();
        //		}
        if (I.val()) {
            var arr = I.val().split(',');
            for (var n = 0; n < arr.length; n++) {
                $(".addup").append('<a><span>' + arr[n] + '</span><q>&times;</q></a>');
            }

            LI.show();
        }
        else {
            LI.hide();
            //			I.val('');
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
    var N = $(".add-text");
    $(".add-btn").click(function () {
        var t = N.val();
        if (t) {
            if (t.length > 10) { alert('福利长度不能大于10'); return false; }
            var arr = I.val().split(',');
            for (var i = 0; i < arr.length; i++) {
                if (arr[i] == t) { alert('该福利已经存在！'); return false; }
            }
            if (arr.length >= 3) {
                alert("最多输入三项");
            }
            else {
                if (arr[0]) arr.push(t);
                else arr[0] = t;
                I.val(arr.join(','));
                $('<a><span>' + t + '</span><q>&times;</q></a>').appendTo(".addup");
                LI.show();
                N.val('');
            }
        }
        else {
            alert("请输入福利！");
        }
    });
}
//地址列表的行为
function ADDList()
{
    var blurTimeout = null;
	var Root=$(".ADDList");
	var MainList=$("dd",Root);
	var Static=$(".AddressStatic");
	var Dynamic=$(".AddressDynamic");
	var tabs=$(".ADDTabs");
	var lists=$(".ADDLists");
	var input=Root.find(".address_tip");
	tabs.find("b").click(function(){
		var ind=$(this).index();
		$(this).addClass("cur").siblings().removeClass("cur");
		lists.eq(ind).show().siblings(".ADDLists").hide();
	}).eq(0).click();
	lists.find("div:last-child").css('border',0);
	MainList.delegate("a",'click',function(){
	    if (blurTimeout) { clearTimeout(blurTimeout); }
		Root.find("input:hidden").val($(this).attr("alt"));
		input.val($(this).text());
		MainList.removeClass("on");
	});
	
	var normal=$("<div>").addClass("normal");
	
	input.focus(function(){
		this.select();
		Static.show();
		Dynamic.hide();
	}).keyup(function(){
		var key=this.value;
		if(!key)
		{
			Static.show();
			Dynamic.hide();
			return;
		}
		var ads=GetAreasByRegexp(key);
		var str='';
		Static.hide();
		if(ads.length)
		{
			var cnt=0;
			for(var n in ads)
			{
				cnt++;
				str+='<a href="javascript:void(0)" alt="'+ ads[n][2] +'">'+ ads[n][0] +'</a>';
				//if(cnt>5) break;
			}
			Dynamic.html(str);
		}
		else
		{
			Dynamic.html('对不起找不到，'+ key);
		}
		Dynamic.show();
	}).blur(function () {
	    var key = this.value;
	    blurTimeout = setTimeout(function () {
	        var cityId = getAreaIDByCityName(key);
	        Root.find("input:hidden").val(cityId);
	        MainList.removeClass("on");
	    }, 200);
	});
}
//一些上传
function UploadDiv(JQstr)
{
	var CenterDiv=$(".UploadDiv");
	var Center=CenterDiv.get(0);
	$(JQstr).click(Center.open);
}
