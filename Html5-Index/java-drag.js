$().extend('drag',function(){										//这里传进来的是一个数组,里面包含能被拖动的标签对象,传几个数据长度就为几
	var tags=arguments;
	for(var i=0;i<this.elements.length;i++){
			this.elements[i].addEventListener('mousedown',function(e){
				
				//alert(odiv.offsetLeft);										//获取的是login对象所在的框最左边到屏幕左边的位置
				//alert(e.clientX);													//获取的是点击的位置到屏幕左边的位置	
				
				var chaLeft=e.clientX - this.offsetLeft;				//这里的this代表的是this.elements[i]
				var chaTop=e.clientY - this.offsetTop;
				var _this = this;
				var flag=false;
				
				//alert($().getTagName('h2').getElements(0));
				for(var i=0;i<tags.length;i++){
					if(e.target==tags[i]){
						flag=true;
						break;
					}
				}
				if(flag){
					window.addEventListener('mousemove',move,false);
					window.addEventListener('mouseup',up,false);
				}
				function move(e){
					var left=e.clientX - chaLeft;
					var top=e.clientY - chaTop;
					if(left<0){															//这两个if条件语句约束了,登录框不能拉倒边界外边
						left=0;
					}
					else if(left<=getScroll().left){
						left=getScroll().left;
					}else if(left>window.innerWidth +getScroll().left - _this.offsetWidth){
						left=window.innerWidth+ getScroll().left - _this.offsetWidth;
					}
					if(top<0){
						top=0;
					}else if(top<=getScroll().top){
						top=getScroll().top;
					}else if(top>window.innerHeight +getScroll().top- _this.offsetHeight){
						top=window.innerHeight +getScroll().top - _this.offsetHeight;
					}
					_this.style.left=left+'px';
					_this.style.top=top+'px';		
				}
				
				function up(){
					window.removeEventListener('mousemove',move,false);
				}
						
			},false)	
		}
		return this;
})


