window.addEventListener('DOMContentLoaded',function(){
	
	//设置导航条的  个人中心
	//$().getClass('member').hover(function(){alert('张刚仁');	},function(){ert('景甜');});	 //传两个函数 这种事件类型问什么会乱码？要怎么编码
	$('.member').hover(function(){
		$('.member_ul').show();
		$('.member').css('background','url(images/arrow.png) no-repeat 70px center');
		$('.member_ul').animate({
			step:30,
			mul:{
				opacity : 100,
				height : 120
						
			}
		})
	},function(){
		$('.member').css('background','url(images/arrow2.png) no-repeat 70px center');	
		$('.member_ul').animate({
			step:30,
			mul:{
				
				height : 0	,
				opacity : 30
					
			},
			fn : function(){
				$('.member_ul').hide();
			}
			
		})
	})
	
	//登录框的设置
	
	//$().getClass('login').click(function(){$().getId('login').css('display','block');});
	//$().getClass('login').click(function(){$().getId('screen').lock();})    //为什么这样写遮罩和登录框不能同时显示
	//因为不能分别设置不同样的$().getClass('login').click()事件,这样写会把前面的事件替换掉,都是同一个标签下的click事件要写在一个里面的
	
	$('#login').center(350,250).resize(function(){
		//$().getId('login').center(350,250);
		if($('#login').css('display')=='block')
		{
				$('#screen').lock();
		};
	});												//浏览器窗口动时执行的函数  //浏览器要改变的事件写在一起
	$('.login').click(function(){
		$('#login').css('display','block');
		$('#login').center(350,250);
		$('#screen').lock().animate({
			attr:'o',
			target:30,
			type:0
		})
	});
	
	
	$('#reg').center(600,550).resize(function(){
		if($('#reg').css('display')=='block')
		{
				$('#screen').lock();
		};
	});												
	$('.reg').click(function(){
		$('#reg').css('display','block');
		$('#reg').center(600,550);
		$('#screen').lock().animate({
			attr:'o',
			target:30,
			type:0
		})
	});
	
	//先执行渐变动画，动画完毕后再执行关闭unlock
	$('#login .close').click(function(){
		$('#login').css('display','none');
		$('#screen').animate({
			attr:'o',
			target:0,
			type:0,
			fn:function(){
				$('#screen').unlock();
			}
			
		})
	});
	$('#reg .close').click(function(){
		$('#reg').css('display','none');
		$('#screen').animate({
			attr:'o',
			target:0,
			type:0,
			fn:function(){
				$('#screen').unlock();
			}
			
		})
	});
	
	$('#reg').center(600,550).resize(function(){
		if($('#reg').css('display')=='block')
		{
				$('#screen').lock();
		};
	});												
	$('.reg').click(function(){
		$('#reg').css('display','block');
		$('#reg').center(600,550);
		$('#screen').lock().animate({
			attr:'o',
			target:30,
			type:0
		})
	}
	);
	
	//查看大图片
	$('#photo_big').center(620,511).resize(function(){
		if($('#photo_big').css('display')=='block')
		{
				$('#screen').lock();
		};
	});
	$('#photo dl dt img').click(function(){
		$('#photo_big').css('display','block');
		$('#photo_big').center(620,511);
		$('#screen').lock().animate({
			attr:'o',
			target:30,
			type:0
		})
		var temp_img=new Image();
		temp_img.src=$(this).attr('bigsrc');
		$(temp_img).bind('load',function(){			//这个image下的onload事件是在这个对象加载完图片时执行
			$('#photo_big .big img').attr('src', temp_img.src).animate({
			attr : 'o',					
			target : 100,
			step : 10
			}).css('width', '600px').css('height', '450px').css('top', 0).css('opacity','0');
		})
		
		//实现了图片的前后相邻图片的预加载
		var children = this.parentNode.parentNode;				//获取点击时的那个dl标签
		next_prev(children);
	})
	
	$('#photo_big .close').click(function(){
		$('#photo_big').css('display','none');
		$('#screen').animate({
			attr:'o',
			target:0,
			type:0,
			fn:function(){
				$('#screen').unlock();
			}	
		})
		$('#photo_big .big img').attr('src', 'images/loading.gif').css('width', '32px').css('height', '32px').css('top', '190px');
	});
	
	
	function next_prev(children){
		var prev=prevIndex($(children).index(),children.parentNode);			//获取点击时的那个dl标签的上一个dl标签
		var next=nextIndex($(children).index(),children.parentNode);			//获取点击时的那个dl标签的下一个dl标签
		
		//alert($('#photo dl dt img').index());  //这里并不能这样查询索引,因为$('#photo dl dt img')父标签下的image标签就一个
		
		var prev_image = new Image();		//为上张大图片创建一个对象用于保存src		
		var next_image = new Image();
		
		//这下面是已经开始缓存左右的两张图片
		prev_image.src=$('#photo dl dt img').eq(prev).attr('bigsrc');
		next_image.src=$('#photo dl dt img').eq(next).attr('bigsrc');
		
		$('#photo_big .big .left').attr('src',prev_image.src);					//给span标签添加属性以便更换下一张图片
		$('#photo_big .big .right').attr('src',next_image.src);
		$('#photo_big .big img').attr('index',$(children).index());			//给大图片添加当前的位置的索引，用于保存
		$('#photo_big .big .index').html($(children).index()+1+'/'+$('#photo dl dt img').length());
	}
		
	//左右切换图片的图标
	$('#photo_big .big .left').hover(function(){				//左边
		$('#photo_big .big .sl').animate({
			attr : 'o',
			target : 50,
			step : 10
		})
	},function(){
		$('#photo_big .big .sl').animate({
			attr : 'o',
			target : 0,
			step : 10
		})
	})
	$('#photo_big .big .right').hover(function(){			//右边
		$('#photo_big .big .sr').animate({
			attr : 'o',
			target : 50,
			step : 10
		})
	},function(){
		$('#photo_big .big .sr').animate({
			attr : 'o',
			target : 0,
			step : 10
		})
	})
	
	//切换上一张
	//这里新建的图片对象实现了在服务器端快速点击上一张或下一张,
	//图片未加载成功时显示loading图片当加载成功时再执行渐变动画
	$('#photo_big .big .left').click(function(){			
		$('#photo_big .big img').attr('src','images/loading.gif').css('width', '32px').css('height', '32px').css('top', '190px');
		var big_img =new Image();
		big_img.src=$(this).attr('src');				//这里是把保存到span里面的属性直接赋值到img里
		$(big_img).bind('load',function(){
			$('#photo_big .big img').attr('src',big_img.src).animate({
				attr : 'o',
				target : 100,
				step : 10
			}).css('opacity','0').css('width', '600px').css('height', '450px').css('top', 0);
		})													
		var children = $('#photo dl dt img').getElements(prevIndex($('#photo_big .big img').attr('index'),$('#photo').getElements(0))).parentNode.parentNode;
		//这里是将保存到大图片里小图片的索引属性来求上一个小图片的索引的dl标签
		//然后再进行各种图片的img对象的创建并进行children的赋值开始循环
		next_prev(children);
	});
	//切换下一张
	$('#photo_big .big .right').click(function(){
		$('#photo_big .big img').attr('src','images/loading.gif').css('width', '32px').css('height', '32px').css('top', '190px');
		var big_img =new Image();
		big_img.src=$(this).attr('src');				//这里是把保存到span里面的属性直接赋值到img里
		$(big_img).bind('load',function(){
			$('#photo_big .big img').attr('src',big_img.src).animate({
				attr : 'o',
				target : 100,
				step : 10
			}).css('opacity','0').css('width', '600px').css('height', '450px').css('top', 0);
		})		//这里是同时执行的可以先将透明度设置为0,动画是最慢执行的
		var children = $('#photo dl dt img').getElements(nextIndex($('#photo_big .big img').attr('index'),$('#photo').getElements(0))).parentNode.parentNode;
		next_prev(children);
	})
	
	//拖拽图片
	$('#photo_big').drag($('#photo_big h2').getElements(0));
	//拖拽登录框
	$('#login').drag($('#login h2').getElements(0));		//这里面以数组的形式传进来
	//拖拽注册框
	$('#reg').drag($('#reg h2').getElements(0));	
	//分享侧栏的初始位置
	$('#share').css('top',(getScroll().top+(window.innerHeight-$('#share').getElements(0).offsetHeight)/2)+'px');
	
	/*window.addEventListener('scroll',function(){
		$('#share').animate({
			attr:'y',
			target:getScroll().top+(window.innerHeight-$('#share').getElements(0).offsetHeight)/2,
			step:30
		})						//这里有个bug未解决，就是侧栏的上下缓冲动画和侧栏的显示动画用的同一个定时器，产生了替代
	},false)*/
	
	$(window).bind('scroll',function(){			//可以替换掉上面的写法
		$('#share').animate({
			attr:'y',
			target:getScroll().top+(window.innerHeight-$('#share').getElements(0).offsetHeight)/2,
			step:30
		})						
	})
	
	//分享侧栏的动画效果
	$('#share').hover(function(){
		$('#share').animate({
			attr:'x',
			target:0,
			step:30,
			type:0
		})
		
	},function(){
		$('#share').animate({
			'attr':'x',
			'target':-211,
			'step':30,
			'type':0
		})
		
	})
	
	//滑动导航
	$('#nav .about li').hover(function(){
		var target = $(this).getElements(0).offsetLeft;		//这里有点搞不懂,为什么这里的this可以直接获取对应的li标签
		$('#nav .nav_bg').animate({
			attr : 'x',
			target : target+20,
			type : 0,
			step:15,
			fn : function () {
				$('#nav .white').animate({
					attr : 'x',
					target : -target		//因为white是第三层在第二层nav_bg里面，最燃第二层向右移动，
				});								//但是第三层还是要相对于第二层要向左移动
			}
			
		})
		
	},function(){
		$('#nav .nav_bg').animate({
			attr : 'x',
			target : 20,
			type : 0,
			step:15,
			fn : function () {
				$('#nav .white').animate({
					attr : 'x',
					target : 0
				});
			}
			
		})
	})
	
	//菜单切换
	//这节课的疑问就是这里的call不能理解
	$('#sidebar h2').toggle(function(){
		//alert(this);				//在没有用call(this)时,这里的this为什么是Arguments
		$(this).next().animate({
			mul : {
				height : 0,
				opacity :0
			}	
		});	
		
	},function(){
		$(this).next().animate({
			mul : {
				height : 150,
				opacity : 100
			}
		})
	})
	
	//alert($('form').form('user').getElements(0).value);
	//alert($('form').form('user').value());						//跟上面的效果一样
	//$('form').form('user').value('你好');
	
	//表单验证
	$('form').getElements(0).reset();
	
	$('form').form('user').bind('focus',function(){
		$('#reg .info_user').css('display','block');
		$('#reg .error_user').css('display', 'none');
		$('#reg .succ_user').css('display', 'none');
	}).bind('blur',function(){
		if(trim($('form').form('user').value())==''){
			$('#reg .info_user').css('display', 'none');
			$('#reg .error_user').css('display', 'none');
			$('#reg .succ_user').css('display', 'none');
		}else if(!check_user()){
			$('#reg .error_user').css('display', 'block');
			$('#reg .info_user').css('display', 'none');
			$('#reg .succ_user').css('display', 'none');
		}else{
			$('#reg .succ_user').css('display', 'block');
			$('#reg .error_user').css('display', 'none');
			$('#reg .info_user').css('display', 'none');
		}	
	})
	
	function check_user(){
		if(/[\w]{2,20}/.test(trim($('form').form('user').value()))) return true;	
	}
	
	
	//表单的密码验证
	$('form').form('pass').bind('focus',function(){
		$('#reg .info_pass').css('display','block');
		$('#reg .error_pass').css('display', 'none');
		$('#reg .succ_pass').css('display', 'none');
	}).bind('blur',function(){
		if(trim($(this).value())==''){
			$('#reg .info_pass').css('display','none');
		}else if(check_pass()){
			$('#reg .info_pass').css('display','none');
			$('#reg .error_pass').css('display', 'none');
			$('#reg .succ_pass').css('display', 'block');
		}else{
			$('#reg .info_pass').css('display','none');
			$('#reg .error_pass').css('display', 'block');
			$('#reg .succ_pass').css('display', 'none');
		}
		
	})
	
	//确认密码
	$('form').form('notpass').bind('focus',function(){
		$('#reg .info_notpass').css('display','block');
		$('#reg .error_notpass').css('display', 'none');
		$('#reg .succ_notpass').css('display', 'none');
	}).bind('blur',function(){
		if(trim($(this).value())==''){
			$('#reg .info_notpass').css('display','none');
		}else if(check_notpass()){
			$('#reg .info_notpass').css('display','none');
			$('#reg .error_notpass').css('display', 'none');
			$('#reg .succ_notpass').css('display', 'block');
		}else{
			$('#reg .info_notpass').css('display','none');
			$('#reg .error_notpass').css('display', 'block');
			$('#reg .succ_notpass').css('display', 'none');
		}
	})
	
	function check_notpass(){
		if(trim($('form').form('notpass').value())==trim($('form').form('pass').value())) return true;
	}
	
	
	//提问
	function check_ques(){
		if($('form').form('ques').value()!=0) return true;
	}
	
	//回答验证
	$('form').form('ans').bind('focus',function(){
		$('#reg .info_ans').css('display','block');
		$('#reg .error_ans').css('display', 'none');
		$('#reg .succ_ans').css('display', 'none');
	}).bind('blur',function(){
		if(trim($(this).value())==''){
			$('#reg .info_ans').css('display','none');
		}else if(check_ans()){
			$('#reg .info_ans').css('display','none');
			$('#reg .error_ans').css('display', 'none');
			$('#reg .succ_ans').css('display', 'block');
		}else{
			$('#reg .info_ans').css('display','none');
			$('#reg .error_ans').css('display', 'block');
			$('#reg .succ_ans').css('display', 'none');
		}
	})
	
	function check_ans(){
		if(trim($('form').form('ans').value()).length>=2&&trim($('form').form('ans').value()).length<=32) return true;
	}
	
	
	//邮箱验证
	$('form').form('email').bind('focus',function(){
		//邮箱选择
		if($(this).value().indexOf('@')==-1){
			$('#reg .all_email').css('display','block');
		}
		
		$('#reg .info_email').css('display','block');
		$('#reg .error_email').css('display', 'none');
		$('#reg .succ_email').css('display', 'none');
	}).bind('blur',function(){
		//邮箱选择
		$('#reg .all_email').css('display','none');
		
		if(trim($(this).value())==''){
			$('#reg .info_email').css('display','none');
		}else if(check_email()){
			$('#reg .info_email').css('display','none');
			$('#reg .error_email').css('display', 'none');
			$('#reg .succ_email').css('display', 'block');
		}else{
			$('#reg .info_email').css('display','none');
			$('#reg .error_email').css('display', 'block');
			$('#reg .succ_email').css('display', 'none');
		}
		
	})
	
	function check_email(){
		if(/^[\w_\.]+@[\w]+(\.[a-zA-Z]{2,4}){1,2}$/.test(trim($('form').form('email').value()))) return true;
	}
	
	//邮箱选择hover事件
	$('#reg .all_email li').hover(function(){
		hover=$(this).getElements(0).innerText;
		/*$(this).bind('keyup',function(e){
			if(e.keyCode==13){
				$('form').form('email').value($(this).getElements(0).innerText);
				$('#reg .all_email').css('display', 'none');
			}
			
		})*/
		$(this).css('background','#ccc');
		$(this).css('color','maroon');
	},function(){
		$(this).css('background','white');
		$(this).css('color','#666');
	})
	
	//邮箱的快捷输入提示
	$('form').form('email').bind('keyup',function(e){
		if($(this).value().indexOf('@')==-1){
			$('.all_email li span').html($(this).value());
			$('#reg .all_email').css('display','block');			
		}else {
			$('#reg .all_email').css('display','none');
		}
		
		$('#reg .all_email li').css('background','white');
		$('#reg .all_email li').css('color','#666');
		
		if(e.keyCode==40){
			if(this.index==undefined || this.index>=$('#reg .all_email li').length()-1){
				this.index=0;
			}else{
				this.index++;
			}
			$('#reg .all_email li').eq(this.index).css('background','#ccc');
			$('#reg .all_email li').eq(this.index).css('color','maroon');
		}
		if(e.keyCode==38){
			if(this.index==undefined || this.index<=0){
				this.index=$('#reg .all_email li').length()-1;
			}else{
				this.index--;
			}
			$('#reg .all_email li').eq(this.index).css('background','#ccc');
			$('#reg .all_email li').eq(this.index).css('color','maroon');
		}
		if(e.keyCode==13){
			if(this.index!=undefined){
				$(this).value($('#reg .all_email li').eq(this.index).getElements(0).innerText);
			}
			$(this).value(hover);				//在hover事件里面定义的全局变量hover就是鼠标hover到的那个属性的innerText内容
			$('#reg .all_email').css('display', 'none');
			this.index=undefined;
		}
		
	})
	
	//邮箱的点击快捷输入
	$('#reg .all_email li').bind('mousedown',function(){
		$('form').form('email').value($(this).getElements(0).innerText);	
	})
	
	//密码的三个属性验证
	$('form').form('pass').bind('keyup',function(){			
		check_pass();
	})
	
	function check_pass(){
		var value = trim($('form').form('pass').value());		//去除可空格后再取长度
		var value_length=value.length;
		var code_length=0;
		var flag =false;
		
		if(value_length>=6&&value_length<=20){
			$('.info_pass .q1').html('●').css('color','green');
		}else{
			$('.info_pass .q1').html('○').css('color', '#666');
		}
		if(value_length>0 && !/\s/.test(value)){		//这里的value中间如果有空格正则并没有将它们清除,只清楚了左边和右边
			$('.info_pass .q2').html('●').css('color','green');
		}else{
			$('.info_pass .q2').html('○').css('color', '#666');
		}
		
		
		//密码强度验证
		if(/[0-9]/.test(value)){
			code_length++;
		}
		if(/[a-z]/.test(value)){
			code_length++;
		}
		if(/[A-Z]/.test(value)){
			code_length++;
		}
		if(/[^0-9A-Za-z]/.test(value)){
			code_length++;
		}
		
		if(code_length>=2){
			$('.info_pass .q3').html('●').css('color','green');
		}else{
			$('.info_pass .q3').html('○').css('color', '#666');
		}
		
		if(code_length>=3&&value_length>=10){
			$('.info_pass .s1').css('color','green');
			$('.info_pass .s2').css('color','green');
			$('.info_pass .s3').css('color','green');
			$('.info_pass .s4').html('高').css('color','green');
		}else if(code_length>=2&&value_length>=8){
			$('.info_pass .s1').css('color','#f60');
			$('.info_pass .s2').css('color','#f60');
			$('.info_pass .s3').css('color','#ccc');
			$('.info_pass .s4').html('中').css('color','#f60');	
		}else if(code_length>=1){
			$('.info_pass .s1').css('color','maroon');
			$('.info_pass .s2').css('color','#ccc');
			$('.info_pass .s3').css('color','#ccc');
			$('.info_pass .s4').html('低').css('color','maroon');
		}else{
			$('.info_pass .s1').css('color','#ccc');
			$('.info_pass .s2').css('color','#ccc');
			$('.info_pass .s3').css('color','#ccc');
			$('.info_pass .s4').css('color','#ccc').html('');
		}
		
		if(value_length >= 6 && value_length <= 20 && !/\s/.test(value) && code_length >= 2) {
			return true;
		}else{
			return false;
		}
	}
	
	
	//年月日
	var year = $('form').form('year');
	var month = $('form').form('month');
	var day = $('form').form('day');
	var day31=[1,3,5,7,8,10,12];
	var day30=[4,6,9,11];
	
	for (var i = 1950; i <= 2018; i ++) {
		year.getElements(0).add(new Option(i, i), undefined);
	}
	for (var i = 1; i <= 12; i ++) {
		month.getElements(0).add(new Option(i, i), undefined);
	}
	month.bind('change',select_day);
	year.bind('change',select_day);
	
	function select_day(){
		if(month.value()!=0&&year.value()!=0){
			day.getElements(0).options.length = 1;
			if(inArray(day30,parseInt(month.value()))){		//数据的value属性都是string类型,在基础库里是判断的全等所以这里要
				days=30;															//转化为int型，因为数组里的都是整形变量
			}else if(inArray(day31,parseInt(month.value()))){
				days=31;
			}else{
				if((parseInt(year.value()) % 4 == 0 && parseInt(year.value()) % 100 != 0) || parseInt(year.value()) % 400 == 0){
					days=29;
				}else{
					days=28;
				}
			}
			for(var i=1;i<=days;i++){
				day.getElements(0).add(new Option(i,i),undefined);
			}
		}else {
			//清理之前的注入
			day.getElements(0).options.length = 1;
		}
		
	}
	
	function check_birthday(){
		if($('form').form('year').value()!=0&&$('form').form('month').value()!=0&&$('form').form('day').value()!=0) return true;
	}
	
	//备注			//为什么这里不能再直接用change事件，当用paste事件时要设置延迟
						//粘贴事件会在内容粘贴到文本框之前触发
	$('form').form('ps').bind('keyup',check_ps).bind('paste',function(){
		setTimeout(check_ps,10);
	});
	function check_ps(){
		var num=200-$('form').form('ps').value().length;
		if(num>0){
			$('#reg .num').html(num);
			$('# reg .ps').css('display','block');
			$('# reg .ps2').css('display','none');
			return true;
		}else{
			$('#reg .num2').html(Math.abs(num)).css('color','red');
			$('# reg .ps').css('display','none');
			$('# reg .ps2').css('display','block');
			return false;
		}
	}
	//备注清尾
	$('#reg .clear').bind('click',function(){
		$('form').form('ps').value($('form').form('ps').value().substring(0,200));
		check_ps();
	})
	
	
	//提交
	$('form').form('sub').bind('click',function(){
		var flag = true;
		if(!check_user()){
			$('#reg .error_user').css('display','block');
			flag = false;
		}
		if(!check_pass()){
			$('#reg .error_pass').css('display','block');
			flag = false;
		}
		if(!check_notpass()){
			$('#reg .error_notpass').css('display', 'block');
			flag = false;
		}
		if(!check_ques()){
			$('#reg .error_ques').css('display', 'block');
			flag = false;
		}
		if(!check_ans()){
			$('#reg .error_ans').css('display', 'block');
			flag = false;
		}
		if(!check_email()){
			$('#reg .error_email').css('display', 'block');
			flag = false;
		}
		if(!check_birthday()){
			$('#reg .error_birthday').css('display', 'block');
			flag = false;
		}
		if(!check_ps()){
			flag = false;
		}
		if(flag){
			$('form').getElements(0).submit();				//submit是form下的方法
		}
	})
	
	/*//轮播图初始化
	$('#banner img').css('opacity','0');
	$('#banner img').eq(0).css('opacity','1');
	$('#banner ul li').eq(0).css('color','#333');	
	$('#banner strong').html($('#banner img').attr('alt'));
	
	//自动轮播图
	var banner_index = 1;
	var banner_timer=setInterval(banner_fn,3000)
	
	
	function banner(obj){
		$('#banner img').css('opacity','0');					//为什么这里这么写hover的时候会显示混乱
		$('#banner img').eq($(obj).index()).animate({
			attr : 'o',
			target : 100,
			step : 10
		});
		$('#banner ul li').css('color','#999');	
		$(obj).css('color','#333');	
		$('#banner strong').html($('#banner img').eq($(obj).index()).attr('alt'));
	}
	
	function banner_fn(){
		if(banner_index>2) banner_index=0;
		banner($('#banner ul li').eq(banner_index).getElements(0));		
		banner_index++;																			
	}
	//手动轮播图
	$('#banner ul li').hover(function(){
		clearInterval(banner_timer);
		banner(this);						
	},function(){
			banner_index = $(this).index()+1;
			banner_timer=setInterval(banner_fn,3000)
	})*/
	
	//轮播图初始化
	$('#banner img').css('opacity','0');
	$('#banner img').eq(0).css('opacity','1');
	$('#banner ul li').eq(0).css('color','#333');	
	$('#banner strong').html($('#banner img').attr('alt'));
	
	//设置轮播图的类别,1是透明度轮播,2是上下轮播
	var banner_type=2;
	//自动轮播图
	var banner_index = 1;
	var banner_timer=setInterval(banner_fn,3000)
	
	if(banner_type==1){
		function banner(obj,prev){
			$('#banner img').eq(prev).animate({
				attr : 'o',
				target : 0,
				step : 1	
			}).css('zIndex', '1');
			$('#banner img').eq($(obj).index()).animate({
				attr : 'o',
				target : 100,
				step : 10
			}).css('zIndex', '2');
			$('#banner ul li').css('color','#999');	
			$(obj).css('color','#333');	//这里的obj是传过来的	一个对象就跟$(this)差不多省略了$('#banner ul li').eq($(obj).index())
			$('#banner strong').html($('#banner img').eq($(obj).index()).attr('alt'));
		}
	}else{
		function banner(obj,prev){
			$('#banner img').eq(prev).animate({
				attr : 'y',
				target : 150,
				step : 10	
			}).css('opacity','100');
			$('#banner img').eq($(obj).index()).animate({
				attr : 'y',
				target : 0,
				step : 10
			}).css('top', '-150px').css('opacity','100');
			$('#banner ul li').css('color','#999');	
			$(obj).css('color','#333');	//这里的obj是传过来的	一个对象就跟$(this)差不多省略了$('#banner ul li').eq($(obj).index())
			$('#banner strong').html($('#banner img').eq($(obj).index()).attr('alt'));
		}
	}
	function banner_fn(){
		if(banner_index>2) banner_index=0;
		banner($('#banner ul li').eq(banner_index).getElements(0),banner_index==0? $('#banner ul li').length()-1 : banner_index -1);		
																		//这里如果不用getElements(0)返回的是Base，
		banner_index++;																			//用了之后返回的就是一个对象
	}
	//手动轮播图
	$('#banner ul li').hover(function(){
		clearInterval(banner_timer);
		if($(this).css('color')!='rgb(51, 51, 51)'){				//浏览器返回的都是rgb
			banner(this,banner_index == 0 ? $('#banner ul li').length() - 1 : banner_index - 1);	//这里的this是hover到的那个li标签对象,不是所有的Li标签
		}			
	},function(){
			banner_index = $(this).index()+1;
			banner_timer=setInterval(banner_fn,3000);
	})
	
	
	//延迟加载
	
	//问题1更换图片地址
	//alert($('.wait_load').css('src'));		//这种方法是获取不到行内的属性的，只能获取css样式表中的css样式
	//$('.wait_load').attr('src',$('.wait_load').eq(0).attr('xsrc'));

	//问题2：获取图片元素到最外层顶点元素的距离
	/*setTimeout(yan,10);				//因为是先加载js框架再加载图片所以谷歌浏览器要设置延迟才能完美支持
	function yan(){							//如果不设置延迟执行js代码时，图片还未加载
		alert($('.wait_load').getElements(0).offsetTop);
		alert($('.wait_load').getElements(0).offsetHeight);
	}*/
	//$('.wait_load').getElements(0).offsetTop;			//这种方法浏览器都支持
	
	//问题3：获取页面可视区域的最低点的位置
	//alert(window.innerHeight+getScroll().top);
	
	$('.wait_load').css('opacity','0');
	$(window).bind('scroll',function(){
		setTimeout(function(){						//设置滚动条事件的时候最好设置一个延迟
			for(var i=0;i<$('.wait_load').length();i++){
				if(window.innerHeight+getScroll().top>$('.wait_load').getElements(i).offsetTop){	//判断是否到了那个图片的位置
					$('.wait_load').eq(i).attr('src',$('.wait_load').eq(i).attr('xsrc')).animate({
						attr : 'o',
						target : 100,
						step : 10
					});
				}
			}
		},100)
	})
	
	//点击加载大图片
	/*$('#photo_big .big img').attr('src', 'http://h.hiphotos.baidu.com/album/s%3D1600%3Bq%3D100/sign=0686e4a05982b2b7a39f3dc2019df09e/d01373f082025aaf03cd026ffbedab64024f1a92.jpg').animate({
		attr : 'o',						//如果这么更换图片的src地址,会使loading图片的尺寸也变大了
		target : 100,
		step : 10
	}).css('width', '600px').css('height', '450px').css('top', 0).css('opacity','0');*/
	//alert($('#photo_big .big img').getElements(0));
	
	//创建一个可以临时的图片对象用于保存图片的src地址
	/*var temp_img=new Image();
	temp_img.src='http://h.hiphotos.baidu.com/album/s%3D1600%3Bq%3D100/sign=0686e4a05982b2b7a39f3dc2019df09e/d01373f082025aaf03cd026ffbedab64024f1a92.jpg';
	$(temp_img).bind('load',function(){			//这个image下的onload事件是在这个对象加载完图片时执行
		$('#photo_big .big img').attr('src', temp_img.src).animate({
		attr : 'o',						//如果这么更换图片的src地址,会使loading图片的尺寸也变大了
		target : 100,
		step : 10
		}).css('width', '600px').css('height', '450px').css('top', 0).css('opacity','0');
	})*/
},false)		//最后的括号











