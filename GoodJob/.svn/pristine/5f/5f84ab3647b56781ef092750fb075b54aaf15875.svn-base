// JavaScript Document
/*
id，效果的最外层DOM的ID，也可以使用JQ串
JQimg，在$(id)上使用find来查找到所有img的JQ选择器字串
JQparent，在JQimg的个体上，使用parentsUntil找到最直接可以获取尺寸的父级DOM的JQ选择器字串，如果为空的话则直接使用$(img).parent()
full，默认为false，使用最大全图模式，如果为true，使用最小满图模式

配合HTML及CSS，在JQparent所对应的父级元素中加入如下代码
<samp><i class='fa fa-spinner fa-spin'></i></samp>
可以形成在调用时显示圆圈LOADING的样式，等图片调用完成，并纠正位置之后，再显示图片
*/
function CHIpros(JQstr,JQimg,JQparent,full)
{
	if(!$(JQstr).size())return;
	full=full?true:false;
	if(!JQimg)JQimg="img";
	var imgs=$(JQstr).find(JQimg)
	imgs=imgs.toArray();
	//var loading="<samp><i class='fa fa-spinner fa-spin'></i></samp>";
	for(var i=0;i<imgs.length;i++)
	{
		var img=imgs[i];
		//$(img).parentsUntil(JQparent).eq(-1).append(loading);
		if(img.complete)
			s(img,function(){
				a(img);
			});
		else $(img).load(function(){
				var p=this;
				s(p,function(){
					a(p);
				});
			});
	}
	function a(img){var samp=$(img).parent().find("samp");if(samp)samp.fadeOut(500);}
	function s(img,cbfun)
	{
		var p=JQparent?$(img).closest(JQparent):$(img).parent();
		var pw=p.width();
		var ph=p.height();
		var w=$(img).width();
		var h=$(img).height();
		/*ratio parent*/var rp=pw/ph;
		/*ratio image*/var r=w/h;
		/*goal width height marginTop marginLeft*/var gw,gh,gt,gl;
		//过宽，且宽大于外围宽--满图，高用外围高与图片高之中较小的那个--全图，宽用外围宽
		if(r>rp && w>pw)gw=full?(Math.min(ph,h)*w/h):pw;
		//过高，且高大于外围高---满图，宽用外围宽与图片宽之中较小的那个---全图，高用外围高
		else if(r<rp && h>ph) gw=full?Math.min(pw,w):(w*ph/h);
		else if(r==rp) gw=Math.min(pw,w);//等比例按较小的尺寸计算
		else gw=w;//为了节省代码长度，把计算过程缩写成只先计算宽，高用等比缩的形式
		gh=gw*h/w;
		gt=(ph-gh)*0.5;
		gl=(pw-gw)*0.5;
		$(img).css({
			"width":gw+"px"
			,"height":gh+"px"
			,"marginTop":gt+"px"
			,"marginLeft":gl+"px"
		});
		p.css({"textAlign":"left"});
		if(cbfun)cbfun();
	}
}
//图片限宽缩小效果
function CHIimgs(id,maxW){$("#"+id).find('img').removeAttr("width").removeAttr("height").css({"maxWidth":maxW+"px"});}
//自动焦点失焦效果
function CHIblur(){$("a,:checkbox,:radio,:button,:submit,:reset").focus(function(){this.blur();});}
//层高平衡效果
function CHIbalance(leftid,rightid)
{
	if(!leftid)leftid="Left";
	if(!rightid)rightid="Right";
	var l=$("#"+leftid);
	var r=$("#"+rightid);
	var h=Math.max(l.height(),r.height());
	l.height(h);
	r.height(h);
}
