$(function() {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');

	function isFocus(e) {
		alert(UE.getEditor('editor').isFocus());
		UE.dom.domUtils.preventDefault(e)
	}

	function setblur(e) {
		UE.getEditor('editor').blur();
		UE.dom.domUtils.preventDefault(e)
	}

	function insertHtml() {
		var value = prompt('插入html代码', '');
		UE.getEditor('editor').execCommand('insertHtml', value)
	}

	function createEditor() {
		enableBtn();
		UE.getEditor('editor');
	}

	function getAllHtml() {
		alert(UE.getEditor('editor').getAllHtml())
	}

	function getContent() {
		var arr = [];
		arr.push("使用editor.getContent()方法可以获得编辑器的内容");
		arr.push("内容为：");
		arr.push(UE.getEditor('editor').getContent());
		alert(arr.join("\n"));
	}

	function getPlainTxt() {
		var arr = [];
		arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
		arr.push("内容为：");
		arr.push(UE.getEditor('editor').getPlainTxt());
		alert(arr.join('\n'))
	}

	function setContent(isAppendTo) {
		var arr = [];
		arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
		UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
		alert(arr.join("\n"));
	}

	function setDisabled() {
		UE.getEditor('editor').setDisabled('fullscreen');
		disableBtn("enable");
	}

	function setEnabled() {
		UE.getEditor('editor').setEnabled();
		enableBtn();
	}

	function getText() {
		//当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
		var range = UE.getEditor('editor').selection.getRange();
		range.select();
		var txt = UE.getEditor('editor').selection.getText();
		alert(txt)
	}

	function getContentTxt() {
		var arr = [];
		arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
		arr.push("编辑器的纯文本内容为：");
		arr.push(UE.getEditor('editor').getContentTxt());
		alert(arr.join("\n"));
	}

	function hasContent() {
		var arr = [];
		arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
		arr.push("判断结果为：");
		arr.push(UE.getEditor('editor').hasContents());
		alert(arr.join("\n"));
	}

	function setFocus() {
		UE.getEditor('editor').focus();
	}

	function deleteEditor() {
		disableBtn();
		UE.getEditor('editor').destroy();
	}

	function disableBtn(str) {
		var div = document.getElementById('btns');
		var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
		for(var i = 0, btn; btn = btns[i++];) {
			if(btn.id == str) {
				UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
			} else {
				btn.setAttribute("disabled", "true");
			}
		}
	}

	function enableBtn() {
		var div = document.getElementById('btns');
		var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
		for(var i = 0, btn; btn = btns[i++];) {
			UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
		}
	}

	function getLocalData() {
		alert(UE.getEditor('editor').execCommand("getlocaldata"));
	}

	function clearLocalData() {
		UE.getEditor('editor').execCommand("clearlocaldata");
		alert("已清空草稿箱")
	}
	
	$('#bnm').click(function(){
		console.log($('.contentForm').text())
		var ccc = UE.getEditor('editor').getContentTxt()
		console.log(ccc)
	})
	
})

$(function(){
	$('.contentForm').text();
	console.log($('.contentForm').text())
	$('#bnm').click(function(){
		console.log($('.contentForm').text());
	})
})

//切换标题
$(function(){
	$('.titleBox a').click(function(){
		$(this).addClass('active').siblings('a').removeClass('active');
	})
})
//新增加菜单
$(function(){
	$('body').on('click','.titleBox .addlist',function(){
		$('.motai').show();
		$('.addTiltle').show();
	})
	
	//关闭
	$('.fa-close').click(function(){
		$('.motai').hide();
		$('.addTiltle').hide();
	})
	//确认
	$('body').on('click','.QRBtn',function(){
		var htmls = $('.titleBox a').eq(1).clone(true);
		var texts = $('.cdinput').val();
		$(htmls).children('span').text("");
		console.log($(htmls).html())
		if($('.cdinput').val()==""){
			layer.msg('请填写新增的菜单');
			$('.cdinput').focus();
			return false;
		}else{
			layer.confirm('确定删除吗？',{icon:3,title:'提示'},function(index){
				$(htmls).children('span').text(texts);
				$('.titleBox a').last().after($(htmls))
				layer.close(index);
			})
			$('.cdinput').val("");
			$('.motai').hide();
			$('.addTiltle').hide();
			return false;
		}
		
		return false;
	})
})
//发布信息
$(function(){
	//点击发布
	$('.formBtn .submit').click(function(){
		
		var contnetText = UE.getEditor('editor').getContentTxt(); //获取输入框文本内容
		var formTitle = $.trim($('#formBox .form-title').val());//标题内容
		
		layer.confirm('确认发布吗？',{icon:3},function(index){
			//do somehting
			
			$('.formBtn .reset').click();
			layer.close(index);
		});
		
		return false;
	})
	//点击取消
	$('.formBtn .reset').click(function(){
		UE.getEditor('editor').setContent("");
	})
})

//删除菜单
$(function(){
	var n = 0;
	$('.delList').on('click',function(){
		n++;
		if(n%2 == 1){
			$('.titleBox a i').show();
		}else{
			$('.titleBox a i').hide();
		}
		
	})
	$('.titleBox a i').click(function(){
		var _this = this;
		layer.confirm('确定删除吗？',{icon:3,title:'提示'},function(index){
			$(_this).parent().remove();
			layer.close(index);
		})
		
	})
})
