// 我的好工作-通用
$(function(){
	if($("#Credit").size())
	{
		//画信用度的效果
		var creditValue=parseFloat($("#Credit").text());
		$("#Credit").empty().mouseenter(function(){
			tip.show();
		}).mouseleave(function(){
			tip.hide();
		});
		var paper=Raphael("Credit",165,15);
		paper.rect(0,0,160,10,5).attr({stroke:false,fill:'#d1e5ff'});
		paper.rect(0,0,10,10,5).attr({stroke:false,fill:'#1c72e4'})
			.animate({width:1.6*creditValue},1000);
		var tip=$("<code/>").appendTo($("#Credit"));
		if(creditValue>90)
		{
			tip.text("信用度越高，工资越高！").addClass("good");
		}
		else if(completeValue>80)
		{
			tip.text("信用度越高，工资越高！").addClass("find");
		}
		else
		{
			tip.text("珍惜每一次机会，勿再爽约").addClass("warn");
		}
	}
	if($("#Complete").size())
	{
		//画简历完整度的效果
		var completeValue=parseFloat($("#Complete").text()),
			Percentage=$("<div>").append(completeValue+'%').css({
				position:'absolute',
				width:'100%',
				height:'100%',
				textAlign:'center',
				lineHeight:isLow() ? '75px' : '80px',
				top:0,left:0,
				fontSize:18,
				color:'#6ba0e7',
				fontWeight:'bold'
			});
		$("#Complete").empty().css('position','relative').append(Percentage);
		paper=Raphael("Complete",75,75);
		paper.circle(35,35,35,35).attr({
			transform:isLow() ? 't1,1' : 't3,3',
			stroke:'#d1e5ff',
			'stroke-width':4
		});
		paper.ca.angle=function(percent){
			if(!percent) var path='M35,0Z';
			else
			var large=percent>=50 ? 1:0,
				per1=2*Math.PI/100,
				x=percent!=100 ? 35*(1+Math.sin(per1*percent)) : 34.99,
				y=percent!=100 ? 35*(1-Math.cos(per1*percent)) : 0,
				path='M35,0A35,35,0,'+ large +',1,'+ x +','+y;
			return {path:path};
		}
		paper.path("M35,0").attr({
			angle:0,
			transform:isLow() ? 't1,1' : 't3,3',
			stroke:'#6ba0e7',
			'stroke-width':4
		}).animate({
			angle:completeValue
		},1000);
	}
	
	//已在页面实现
	//var warmtip=$('<table class="FullScreenPlugin fixed fixed-top black5"><tr><td><div class="WarmTip"><a>知道了</a><q></q></div></td></tr></table>');
	//$("body").append(warmtip);
	//warmtip.find("q,a").click(function(){
	//	warmtip.fadeOut();
	//});
	
	var credittip=$('<table class="FullScreenPlugin fixed fixed-top black5"><tr><td><div class="CreditTip"><q></q>'
		+'<p>个人信用度是衡量一个求职者信誉的指标，如果您确定去面试之后却缺席面试或无故迟到，HR可以进行投诉，被投诉后您的信用度将会受到影响。</p>'
		+'<h5>信用度的高低是影响您的简历在企业简历库中排名的因素之一</h5>'
		+'</div></td></tr></table>').hide();
	$("body").append(credittip);
	credittip.find("q").click(function(){
		credittip.fadeOut();
	})
	$("#CreditTip").click(function(){
		credittip.fadeIn();
		$(".CreditTip").fadeIn();
	});
	
	//新增VIP图
	if($("#VIPMAP").length)
	{
		var value=$("#VIPMAP").text()*1;
		$("#VIPMAP").empty();
		var paper=Raphael("VIPMAP",265,15);
		paper.rect(1,1,204,12,5).attr({fill:'#ffeeaa',stroke:'#ffe57d'});
		paper.rect(3,3,200,8,3).attr({stroke:false,fill:'#ffe789'});
		paper.rect(3,3,value*.2,8,3).attr({stroke:false,fill:'#ffcc02'});
		paper.path('M'+(1+2+100*.2)+',1V13').attr({stroke:'#fff','stroke-width':1});
		paper.path('M'+(1+2+250*.2)+',1V13').attr({stroke:'#fff','stroke-width':1});
		paper.path('M'+(1+2+700*.2)+',1V13').attr({stroke:'#fff','stroke-width':1});
		$("#VIPMAP").append('<big>积分'+ value +'</big>');
		if(isIE6()) $("div.name ins").hover(function(){
			$(this).children().show();
		},function(){
			$(this).children().hide();
		});
	}
	
	//新增金勋章图
	$(".Profile del").hover(function(){
		$(this).addClass("on");
	},function(){
		$(this).removeClass("on");
	});
	$(".Profile i").hover(function(){
		$(this).addClass("on");
	},function(){
		$(this).removeClass("on");
	});
	
	//新增广告点击关闭
	$(".Advertise q").click(function(event){
		$(".Advertise").hide();
		event.preventDefault();
	});
});

//////////////////////新增会员中心全局使用的VIP提示，四个都在一起
function VIPs(classname)
{
	$("."+classname).show().siblings().hide().closest(".FullScreenPlugin").fadeIn();
}
$(function(){
	var strVar = "";
		strVar += "<table class=\"FullScreenPlugin fixed fixed-top black5 VIPs\"><tr><td>";
		strVar += "	<div class=\"VIP VIP-Guide\">";
		strVar += "    	<q><\/q>";
		strVar += "        <div class=\"VIP-topic\">创建完整简历，马上获得<span class=\"VIP-level\">求职特权V<sub>1<\/sub><\/span><\/div>";
		strVar += "        <p>您将拥有以下权限：<\/p>";
		strVar += "        <ul>";
		strVar += "        	<li><i>1<\/i><h6>更高的职位投递数量<\/h6><p>每天可投递的职位数量从10个增加到15个!<\/p><\/li>";
		strVar += "        	<li><i>2<\/i><h6>获得“最高求职成功率”职位推荐权<\/h6><p>好工作为您推送面试率最高，入职机率高的职位，找好工作就是这么简单!<\/p><\/li>";
		strVar += "        	<li><i>3<\/i><h6>职位邀请专享<\/h6><p>开通后可直接收到来自企业的职位投递邀请，满满都是工作机会！<\/p><\/li>";
		strVar += "        <\/ul>";
		strVar += "        <a href=\"new-RESUME.html\" class=\"VIP-go\">完善简历<\/a>";
		strVar += "    <\/div>";
		strVar += "    <div class=\"VIP VIP-Reach\">";
		strVar += "    	<q><\/q>";
		strVar += "        <div class=\"VIP-parts\">";
		strVar += "            <div class=\"VIP-topic\">尊敬的用户，恭喜您获得<span class=\"VIP-level\">求职特权V<sub>1<\/sub><\/span><\/div>";
		strVar += "            <div class=\"VIP-hr\"><span>还有更多特权等你来拿<\/span><\/div>";
		strVar += "            <div class=\"VIP-rates\">";
		strVar += "                <a href=\"new-vip.html\">详情<\/a>";
		strVar += "                <span><i>A<\/i>更多职位投递数量<\/span>";
		strVar += "                <span><i>B<\/i>诚信认证<\/span>";
		strVar += "                <span><i>C<\/i>专家职场解难<\/span>";
		strVar += "                <span><i>D<\/i>人才优先推荐<\/span>";
		strVar += "            <\/div>";
		strVar += "        <\/div>";
		strVar += "        <div class=\"VIP-parts2\">";
		strVar += "            <p>如何免费获得更多特权：<\/p>";
		strVar += "            <ul>";
		strVar += "                <li><i>1<\/i><h6>献爱心，送好友求职特权卡，让身边的人都找到好工作！<\/h6><p>（好友接受你赠送的求职特权卡后，你将获得相应积分，可升级为更高特权!)<\/p><\/li>";
		strVar += "                <li><i>2<\/i><h6>下载好工作APP、关注微信公众号，找工作更快更轻松！<\/h6><p>（<u>下载<\/u> 或 <u>关注<\/u> 送更多积分，免费超级特权等你来拿！）<\/p><\/li>";
		strVar += "            <\/ul>";
		strVar += "            <div class=\"VIP-code\"><img src=\"../images/v2/code-wx.jpg\" width=\"100\" height=\"100\"><span>扫描即可分享<\/span><\/div>";
		strVar += "        <\/div>";
		strVar += "    <\/div>";
		strVar += "    <div class=\"VIP VIP2\"><q><\/q><\/div>";
		strVar += "    <div class=\"VIP VIP3\"><q><\/q><a href=\"new-vip.html\"></a><\/div>";
		strVar += "<\/td><\/tr><\/table>";
	$("body").append(strVar);
	$(".VIPs").hide()
		.find("q").click(function(){
			$(this).parent().hide()
				.closest(".VIPs").fadeOut();
		});
});
////////////
///
/*
一级键名是“表单”容器的ID
单项数据二级键名是各组件的ID
列表数据二级键名是各记录的ID，三级键名才是各组件的ID

文本框/域为自身，有值则赋值，如果不写则会使用占位符
按钮（单多选）为自身，选中则为true，否则为false
下拉列表有隐藏的是隐藏域的ID，一般为整数值
无隐藏域的为输入框的ID，一般为字符串
*/
var Datas={
    AnchorProfile:{
		fullname:'张英',
		female:true,
		hometownCity:'271400',
		birthYear:1993,
		birthMonth:7,
		highestEducation:3,//大专
		experience:4,//1-3年
		mobile:'13411022562',
		email:'575859626@qq.com',
		idcard:'445678199307082428',
		state:2//在职，想换工作
	},
    AnchorOpinion:{
		wantJobtype:1,//全职
		wantProvince:'270000',
		wantCity:'271000',
		wantDistrict:'000000',
		wantSubjects:'1010,1012,1014',//互联网/电子商务 ,计算机软件 ,IT/计算机服务 
		wantPositions:'111012,111013,111018',//Html5,web前端,其他前端开发
		wantSalary:5//5000-8000
	},
    AnchorIntroduction:{
		introduction:'如何找到好的工作成为职场热门话题，事实上，要找到好工作，首先要做好简历，简历的重要部分之一是自我介绍，简历自我介绍不宜过长，也不能太短，如何写好简历中的自我介绍，以下举例三篇个人简历自我介绍范文，可供参考.'
	},
    AnchorEducations:{
		1:{
			education:4,//本科
			school:'华南理工大学',
			institute:'软件学院',
			major:'软件工程',
			educateYearFrom:1996,
			educateMonthFrom:3,
			educateYearTo:2001,
			educateMonthTo:8
		},
		2:{
			education:3,//大专
			school:'华南理工大学广州汽车学院',
			institute:'广州汽车学院',
			major:'汽车修理',
			educateYearFrom:2012,
			educateMonthFrom:5,
			educateYearTo:2013,
			educateMonthTo:12
		}
	},
    AnchorWorks:{
		1:{
			workCompany:'某个公司',
			workPosition:'产品销售',
			workYearFrom:2002,
			workMonthFrom:3,
			workYearTo:2005,
			workMonthTo:8,
			workDescription:'简历的重要部分之一是自我介绍，简历自我介绍不宜过长.\n1、也不能太短，如何写好简历中的自我介绍\n2、以下举例三篇个人简历自我介绍范文，可供参考.'
		},
		2:{
			workCompany:'广州冠鹏信息技术有限公司',
			workPosition:'程序员',
			workYearFrom:2012,
			workMonthFrom:6,
			workYearTo:2014,
			workMonthTo:4,
			workDescription:'广州冠鹏信息技术有限公司是国内首家推出新一代院校就业整体解决方案提供商，与国内各地著名高等院校、500强等大型企业和海量高价值中小企业深度合作.'
		}
	},
    AnchorProjects:{
		1:{
			projectCompany:'广州冠鹏信息技术有限公司',
			projectName:'好学校官方网站',
			projectPosition:'前端开发',
			projectYearFrom:2005,
			projectMonthFrom:1,
			projectYearTo:2006,
			projectMonthTo:2,
			projectDescription:'制作一个可供培训资讯分享的信息平台网站.'
		},
		2:{
			projectCompany:'广州冠鹏信息技术有限公司',
			projectName:'好工作官方网站第二版',
			projectPosition:'动画制作',
			projectYearFrom:2011,
			projectMonthFrom:5,
			projectYearTo:2013,
			projectMonthTo:2,
			projectDescription:'在第一版的基础上，制作功能类似的第二版.'
		}
	},
    AnchorSkills:{
		1:{
			skillName:'Photoshop',
			skillDegree:2,
			skillMonths:3
		},
		2:{
			skillName:'Dreamweaver',
			skillDegree:4,
			skillMonths:36
		},
		3:{
			skillName:'Fireworks',
			skillDegree:3,
			skillMonths:28
		}
	},
    AnchorOther:{
		others:'2014.1，获得优秀好学生奖\n2014.12，获得优秀员工奖\n好的工作成为职场热门话题，事实上，要找到好工作，首先要做好简历，简历的重要部分之一是自我介绍，简历自我介绍不宜过长，也不能太短.'
	},
    MyWork:{
        workLink: "http://www.93hgz.com/",
        workName: "好工作人才网",
        workContent: "好的工作成为职场热门话题，事实上，要找到好工作，首先要做好简历，简历的重要部分之一是自我介绍，简历自我介绍不宜过长，也不能太短." 
    },
    TrainingExperience: {
        1:{
            trainMechanism: "北大青鸟（广力校区）",
            trainSkill: "UI设计师",
            trainContent: "简历的重要部分之一是自我介绍，简历自我介绍不宜过长.1、也不能太短，如何写好简历中的自我介绍 2、以下举例三篇个人简历自我介绍范文，可供参考.",
            trainCertificate: "高级UI设计师证",
            trainYearFrom:2001,
            trainMonthFrom:1,
            trainYearTo:2002,
            trainMonthTo:2
        }
    }
};

function FormRebuild(id,datas)
{
	//以布局顺序为优先，以保证初始化正常
	$("#"+id).find(".item dfn").children().each(function(){
		var tag=this.tagName.toLowerCase();
		switch(tag)
		{
			case 'input':
			case 'textarea':
				if(this.type=='text' || tag=='textarea')
				{
					if(!datas) this.value='';
					else
					{
						var id=this.id;
						if(!id) break;
						var value=id in datas ? datas[id]:'';
						this.value=value;
					}
					INPUT.init.call(this);
				}
				break;
			case 'dl':
				if($(this).hasClass("SELECT"))
				{
					var input=$(this).find("input[type=hidden]");
					if(!input.size()) input=$(this).find("input[type=text]");
					var id=input.attr('id');
					if(!id) break;
					if(!datas) input.val('');
					else
					{
						var value=id in datas ? datas[id]: '';
						if(value!=='')
						{
							input.val(value);
						}
					}
					SELECT.init.call(this);
					if($(this).hasClass("ADDRESS"))
					{
						ADDRESS.init.call(this);
					}
				}
				break;
			case 'label':
				if(datas)
				{
					var input=$(this).find("input"),
						id=input.attr('id');
					if(!id) break;
					var bool=id in datas ? Boolean(datas[id]) : false;
					if(bool) $(this).click();
				}
				break;
			default:
		}
	});
}
//初始化数据，id为“表单”容器的ID，subid为列表中某条记录的id，如果是单项数据则可忽略
function FormInit(id,subid)
{
	if(!(id in Datas)) return false;
	var datas=Datas[id];
	if(subid && (subid in datas)) datas=datas[subid];
	FormRebuild(id,datas);
}
//完全清空一个表单，用于列表数据的追加
function FormReset(id){FormRebuild(id,'');}
