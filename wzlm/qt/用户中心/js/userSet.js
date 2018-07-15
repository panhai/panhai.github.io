$(function() {
	//回到顶部
	$("#totop").click(function() {
		$('html , body').animate({
			scrollTop: 0
		}, 'slow');
	})
})

//把字符串数字遍历为* 
function ListX(str) {
	var strX = '';
	for(var i = 0; i < str.length; i++) {
		strX += '*';
	}
	return strX;
}
//显示密码  

//点击修改密码可以修改密码 （弹窗形式）
$(function() {
	$('.passworlds .relien').click(function() {
		$('#novisyPassword').show();
		$('.bg-box').show();

		return false;
	})
	//关闭修改密码框
	$('.fa-close').click(function() {
		$('#novisyPassword').hide();
		$('.bg-box').hide();
	})
	//确认修改
	$('.novisyPasswordBtn').click(function() {

		var passworldOld = $.trim($('.passworldOld').val());
		var passworldNew = $.trim($('.passworldNew').val()); //新密码
		var passworldNewX = $.trim($('.passworldNewX').val())
		var novisyPasswordBtn = $.trim($('.novisyPasswordBtn'));

		var regPassWorld = /^(?![^a-zA-Z]+$)(?!\D+$)/; //必须为数字和字母组成
		var bool = true;
		$('#novisyPassword .ned').each(function() {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus();
				bool = false;
				return false;
			}
		})
		if(bool) {

			//验证输入的原来密码是否正确
			//
			if(!regPassWorld.test(passworldOld)) {
				layer.msg('密码必须为数字和字母组成！');
				$('.passworldOld').focus();
				bool = false;
				return false;
			}
			if(passworldOld.length < 6 || passworldOld.length > 25) {
				layer.msg('密码长度在6-25之间！');
				$('.passworldOld').focus();
				bool = false;
				return false;
			}
			//验证新密码
			if(!regPassWorld.test(passworldNew)) {
				layer.msg('密码必须为数字和字母组成！');
				$('.passworldNew').focus();
				bool = false;
				return false;
			}
			if(passworldNew.length < 6 || passworldNew.length > 25) {
				layer.msg('密码长度在6-25之间！');
				$('.passworldNew').focus();
				bool = false;
				return false;
			}
			//确认密码
			if(passworldNew != passworldNewX) {
				layer.msg('两次密码输入不一致！');
				$('.passworldNewX').focus();
				bool = false;
				return false;
			}

			//提交修改 显示*******

			$('.userassWorlds').val(passworldNew);
			$('.userassWorlds').css('visibility', 'hidden')
			$('.userassWorlds-box').text(ListX(passworldNew));


			$('#novisyPassword').hide();
			$('.bg-box').hide();
			layer.msg('修改成功！');
			return false;
		}

		return false;
	})
})

//表单验证提交验证
$(function() {
	
	//当失去焦点时判断
	/*qq
	 * email
	 * url
	 * bank
	 * 
	 * 
	 * 
	 */
	$('#qq').blur(function(){
		var qqcont = $.trim($(this).val());
		var regQQ = /^[1-9][0-9]{4,9}$/;
		if(qqcont){
			if(!regQQ.test(qqcont)){
				layer.msg("输入的QQ格式不准确！");
				$(this).focus();
				return false;
			}
		}
	})
	
	$('#email').blur(function(){
		var email = $.trim($('#email').val());
		var regEmail = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		if(email){
			if(!regEmail.test(email)){
				layer.msg("输入的邮箱格式不准确！");
				$(this).focus();
				return false;
			}
		}
	})
	
	$('#webUrl').blur(function(){
		var webUrl = $.trim($('#webUrl').val());
		var regUrl = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		if(webUrl){
			if(!regUrl.test(webUrl)){
				layer.msg("输入的网址格式不准确！");
				$(this).focus();
				return false;
			}
		}
	})
	
	$('#bankAccount').blur(function(){
		var newBankNum = $.trim($('#bankAccount').val());
		var num = /^\d*$/; //全数字 17-19
		if(newBankNum){
			if(!num.test(newBankNum) || newBankNum.length<17 || newBankNum.length >19){
				layer.msg("银行卡号必须全是数字而长度在17-19之间");
				$(this).focus();
				return false;
			}
		}
	})
	
	

	$('#BaoCun').click(function() {
		/*
		 * 1固定电话 验证
		 * 2 qq号码 验证
		 * 3 电子邮箱 验证
		 * 4 网址 验证
		 * 5 银行卡号 （16-19全部数字组成） 验证
		 * 6 qq,电子邮箱，所在地区，网站名称，网站地址，负责人，银行卡号，开户银行，开户名必须填写
		 * 7 点击提交不可跳转
		 * 8 
		 */
		//获取验证选项
		var fixedTel = $('#fixedTel').val(); //固定电话
		var qq = $.trim($('#qq').val());
		var email = $.trim($('#email').val());
		var webUrl = $.trim($('#webUrl').val());
		var newBankNum = $.trim($('#bankAccount').val());
		var phone = $.trim($('.phones').val()); //联系方式  手机号码
		//1 获取必填选项
		var provinceCity = $('.province').val(); //省份
		var City = $('.city').val(); //市
		var webName = $.trim($('#webName').val());
		var fzPerson = $.trim($('#fzPerson').val()); //负责人
		var bankName = $.trim($('#bank').val());
		var accountName = $.trim($('#accountName').val());
		//获取不可修改的基本信息
		var username = $('.username').text();
		var usernamePassWorld = $('#password').val();
		var userPhone = $('.h').text();
		
		// 验证正则
		var mobile = /^0\d{2,3}-?\d{7,8}$/; //固定电话
		var tel = /^\d{3,4}-?\d{7,9}$/; //手机
		var regEmail = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		var regUrl = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		var regBankAccount = /^\d{19}$/g;
		var strBin = "10,18,30,35,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,60,62,65,68,69,84,87,88,94,95,98,99";
		var regQQ = /^[1-9][0-9]{4,9}$/;
		var regName = /[^\w\u4e00-\u9fa5]/g; //数字，字母（不分大小写），汉字，下划线。
		var num = /^\d*$/; //全数字
		var bool = true;

		$('.first-form .need').each(function(index, el) {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'));
				$(this).focus()
				bool = false;
				return false;
			}
		})

		if(bool) {
			//判断qq
			if(!regQQ.test(qq)) {
				layer.msg('请输入正确的qq号！')
				$('#qq').focus();
				bool = false;
				return false;
			}
			//判断电子邮箱
			if(!regEmail.test(email)) {
				layer.msg('请输入正确的邮箱格式！')
				$('#email').focus();
				bool = false;
				return false;
			}

			//判断网址
			if(!regUrl.test(webUrl)) {
				layer.msg('网址格式不正确！')
				$('#webUrl').focus();
				bool = false;
				return false;
			}
			//判断银行卡号
			if(newBankNum.length < 16 || newBankNum.length > 19) {
				layer.msg('银行卡号长度必须在16到19之间!')
				$('#bankAccount').focus();
				bool = false;
				return false;
			}
			if(!num.test(newBankNum)) {
				layer.msg('银行卡号必须全为数字!')
				$('#bankAccount').focus();
				bool = false;
				return false;
			}

			//判断开户名
			if(regName.test(accountName)) {
				layer.msg('用户名由数字，字母，汉字，下划线组成，不可含有非法字符！')
				$('#accountName').focus();
				bool = false;
				return false;
			}
			if(getLength(accountName) < 5 || getLength(accountName) > 25) {
				layer.msg('开户名长度在5到25字符之间！')
				$('#accountName').focus();
				bool = false;
				return false;
			}
			//座机电话格式

			if(fixedTel) {
				if(mobile.test(fixedTel)) {
					layer.msg('固定电话联系号码格式不正确！')
					$('#fixedTel').focus();
					bool = false;
					return false;
				}
			}
			//判断手机格式
			if(phone) {
				if(!tel.test(phone)) {
					layer.msg('手机号码格式不正确！')
					$('.phones').focus();
					bool = false;
					return false;
				}
			}
			if(bool) {
				//显示设置有信息的页面，替换当前页面
				$('.first-form').hide();
				$('#keep').show();
				$('#content-box .content-list').css('padding', 0); //必须去掉padding，不谈页面布局有问题。

				//把首次设置的信息渲染到第个页面
				/*
				 * 显示基本信息
				 */
				$('.username').val(username);
				$('.usenamePhone-x').val(userPhone);
				$('.fixedPhone-x').val(fixedTel);
				$('.qq-x').val(qq);
				$('.email-x').val(email);
				$('.city-x').val((provinceCity + City));
				/*
				 * 显示推广的网站  添加的时间
				 */

				var times = new Date();
				var year = times.getFullYear();
				var month = times.getMonth() + 1;
				var day = getStr(times.getDate());
				var newTimses = year + '.' + month + '.' + day;

				$('.listmsg').children('td').eq(0).html(webName);
				$('.listmsg').children('td').eq(1).html(webUrl);
				$('.listmsg').children('td').eq(2).html(fzPerson);
				$('.listmsg').children('td').eq(3).html(phone);
				$('.listmsg').children('td').eq(4).html(newTimses);
				/*
				 * 显示到帐银行信息
				 */
				var firsttbankNum = $('.firstt-bankNum').val();
				var firsttbankName = $('.firstt-bankName').val();
				var firsttpersonName = $('.firstt-personName').val();
				//设置银行帐号不可见，显示他的假 ，只显示最后四位数
				$('.visity-box').html(formatBankNumber(firsttbankNum));
				$('.visity-box').show();
				$('.secend-bankNum').css('visibility', 'hidden');

				$('.secend-bankNum').val(firsttbankNum); //银行卡号
				$('.secend-bankList').val(firsttbankName); //开户银行
				$('.secend-bankPersonName').val(firsttpersonName); //开户人

			
				layer.msg('保存成功！')
				return false;
			}

			return false;
		}

		return false;

	})
	var newWeblist = $('.webList').last().clone(); 
	var num = 0;
	//初次设置页面点击添加推广网站
	$('#AddWeb').click(function() {
		num++;
		var newWeblist = $('.webList').last().clone();
		newWeblist.attr('id', 'webList' + num);
		newWeblist.find('input').val("");
		newWeblist.append('<br />')
		$('.webList').last().after(newWeblist);
		
		return false;
	})

})

$(function() {
	/*
	 * 
	 保存后的信息页面，开始不可编辑
	*/
	$(function() {
		$('#keep input').attr('disabled', true);
	})
	//基本信息修改
	$('.infoAdd').click(function() {
		//点击修改可以编辑
		$('.infoTable input').attr('disabled', false);
		//显示保存按钮
		$('.infoTableBtn').show();
		$('.infoTableBtn2').show();
		var username = $('.usename-x').val();
		var usenamePhone = $('.usenamePhone-x').val();
		var fixedPhone = $('.fixedPhone-x').val();
		var qq = $('.qq-x').val();
		var email = $('.email-x').val();
		var city = $('.city-x').val();
		
		////取消保存
		$('.infoTableBtn2').click(function(){
			$('.usename-x').val(username);
			$('.usenamePhone-x').val(usenamePhone);
			$('.fixedPhone-x').val(fixedPhone);
			$('.qq-x').val(qq);
			$('.email-x').val(email);
			$('.city-x').val(city);
			
			$(this).hide();
			$('.infoTableBtn').hide();
			$('.infoTableBtn2').hide();
			$('.infoTable input').attr('disabled', true);
		})
		
		//保存基本信息
	$('.infoTableBtn').click(function() {
		//获取修改的信息
		//异步提交数据
		//禁止编写信息
		//按钮消失
		var username = $('.usename-x').val();
		var usenamePhone = $('.usenamePhone-x').val();
		var fixedPhone = $('.fixedPhone-x').val();
		var username = $('.usename-x').val();
		var qq = $('.qq-x').val();
		var email = $('.email-x').val();
		var city = $('.city-x').val();
		$(this).hide();
		$('.infoTableBtn2').hide();
		$('.infoTable input').attr('disabled', true);
		layer.msg('修改成功？');
		
	})
	
		
		
		
	})
	

})
//获取字符长度
function getLength(str) {
	return str.replace(/[^\x00-xff]/g, 'xx').length;
}
//时间转换为字符串
function getStr(n) {
	if(n < 10) {
		return '0' + n;
	} else {
		return "" + n;
	}

}

$(function() {
	//推广网站弹框添加
	/*
	 * 1 点击添加 (显示弹框)body背景颜色变暗 框内容清零
	 * 2 点击保存 (三个必填，负责人和网站地址需要验证)
	 * 3 成功保存后弹框消失，不做跳转，推广网站信息添加一行信息
	 */
	$('body').on('click', '#addWebMsg', function() {
		$('#AddWebMsg-boxs').show();
		$('#AddWebMsg-boxs input').val(""); //清空
		$('.bg-box').show();
	})
	//删除弹框  
	$('body').on('click', '.fa-close', function() {
		$('#AddWebMsg-boxs').hide();
		$('.bg-box').hide();
	})
	
	//保存添加推广网站的信息
	//把最后一行tr信息保存，以便后面复制添加(避免删除完了复制表头)
	var trdata = $('table.addTable tr').last().prop("outerHTML"); //吧jq对象转换为原生元素结构html字符串

	$('body').on('click', '#AddWebMsgBtn', function() {
		var webMname = $.trim($('#webName-t').val());
		var webUrl = $.trim($('#webUrl-t').val());
		var person = $.trim($('#person-t').val());
		var phones = $.trim($('#phones-t').val());
		var bl = true;
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[0-9]{1})|(17[0-9]{1}))+\d{8})$/; //固定电话
		var tel = /^\d{3,4}-?\d{7,9}$/; //手机
		var regUrl = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		var regName = /[^\w\u4e00-\u9fa5]/g; //数字，字母（不分大小写），汉字，下划线。

		$(trdata).children('td').eq(0).html(webMname)
		console.log($(trdata).children('td').eq(0).html())
		console.log(phones)
		$('.bx').each(function(ev) {
			if(!$(this).val()) {
				layer.msg($(this).attr('placeholder'))
				$(this).focus();
				bl = false;
				return false;
			}
		})

		if(person) {
			if(regName.test(person)) {
				layer.msg('用户名由数字，字母，汉字，下划线组成，不可含有非法字符！')
				$('#person-t').focus();
				bl = false;
				return false;
			}
			if(getLength(person) < 5 || getLength(person) > 25) {
				layer.msg('用户名必须在5到25字符之间')
				$('#person-t').focus();
				bl = false;
				return false;
			}
		}

		if(webUrl) {
			if(!regUrl.test(webUrl)) {
				layer.msg('您输入的网址格式不正确，请您重新输入');
				$('#webUrl-t').focus();
				bl = false;
				return false;
			}
		}
		if(phones) {
			if(!tel.test(phones)) {
				layer.msg('您输入手机格式不正确！');
				$('#phones-t').focus();
				bl = false;
				return false;
			}
		}
		if(bl) {
			//保存添加的信息
			layer.msg('保存成功！')
			//添加框消失，然后推广信息添加一行信息(输入的信息遍历到新加的一行)

			//添加时间
			var time = new Date();
			var year = time.getFullYear();
			var month = time.getMonth() + 1;
			var dates = getStr(time.getDate());
			var newtime = year + '.' + month + '.' + dates;

			var tr = $(trdata).clone(true);
			tr.children('td').eq(0).html(webMname)
			tr.children('td').eq(1).html(webUrl)
			tr.children('td').eq(2).html(person)
			tr.children('td').eq(3).html(phones)
			tr.children('td').eq(4).html(newtime)

			$('.addTable').append(tr);
			$('#AddWebMsg-boxs').hide();
			$('.bg-box').hide();
			return false;
		}
		return false;
	})
})

//修改和删除已经有的推广网站信息
$(function() {
	//删除一行信息
	$("body").on('click', '.addTable .remove', function() {
		var _this = this;
		layer.confirm('确定删除吗？',{
			btn:['确定','取消']
		},function(rtrt){
			$(_this).parent().parent('tr').remove();
			layer.close(rtrt);
		});
	})

	//关闭弹框
	$('.fa-close').click(function() {
		$('#webT').hide();
		$('.bg-box').hide();
	})
	//修改信息
	$("body").on('click', '.revise', function() {
		$('#webT').show();
		$('.bg-box').show();
		$('#webT input').attr('disabled', false);
		//显示当前的信息
		var webname1 = $(this).parent().parent().children('td').eq(0).text();
		var webUrl1 = $(this).parent().parent().children('td').eq(1).text();
		var webPerson = $(this).parent().parent().children('td').eq(2).text();
		var webPhone = $(this).parent().parent().children('td').eq(3).text();

		//设置input显示的value值
		$('#webT input').eq(0).val(webname1);
		$('#webT input').eq(1).val(webUrl1);
		$('#webT input').eq(2).val(webPerson);
		$('#webT input').eq(3).val(webPhone);

		var that = this; //存下this,后面可以用。
		//保存修改的信息
		$('#webT .webT-btn').on('click', function() {

			var webname2 = $('#webT input').eq(0).val();
			var webUrl2 = $('#webT input').eq(1).val();
			var webPerson2 = $('#webT input').eq(2).val();
			var webPhone2 = $('#webT input').eq(3).val();

			//修改信息保存到列表

			$(that).parent().parent().children('td').eq(0).text(webname2);
			$(that).parent().parent().children('td').eq(1).text(webUrl2);
			$(that).parent().parent().children('td').eq(2).text(webPerson2);
			$(that).parent().parent().children('td').eq(3).text(webPhone2);

			$('.bg-box').hide();
			$('#webT').hide();
			layer.msg('修改成功！');
			return false;
		})
		
	})

})

//显示银行卡号最后四位数，前面显示*号。
function formatBankNumber(bankNumber) {
	var newstr = "";
	for(var i = 0; i < bankNumber.length - 4; i++) {
		newstr += '*';
	}
	return newstr + bankNumber.substr(-4);
}

//修改银行账号信息
$(function() {
	//关闭提示框
	$('.fa-close').click(function() {
		$('#bankNo').hide();
		$('.bg-box').hide();
	})
	//点击确认修改
	$('#resiveBankMsg').click(function() {
		var teday = new Date().getDate();
		if(teday <= 10) {
			//显示不可以编辑的提示框;
			$('#bankNo').show();
			$('.bg-box').show();

		} else {
			//显示弹框，可编辑
			$('#BankMsBox').show();
			$('.bg-box').show();
			//获取显示银行信息
			var newBankNum = $('.secend-bankNum').val(); //银行卡号
			var bankList = $('.secend-bankList').val(); //开户银行
			var bankName = $('.secend-bankPersonName').val(); //开户人

			$('.bankNumx').val(newBankNum);
			$('.bankNamex').val(bankList);
			$('.namex').val(bankName);
		}
	})
	//关闭弹框
	$('.fa-close').on('click', function() {
		$('#BankMsBox').hide();
		$('.bg-box').hide();
	})
	//点击保存修改
	$('.BankMsBoxbtn').click(function() {

		/*
		 * 银行卡号，开户银行，开户名必填
		 * 卡号，开户名验证，银行卡号保存后显示最后四位数字，其他为*号代替
		 */
		newBankNum = $.trim($('.bankNumx').val());
		var bankListx = $.trim($('.bankNamex').val());
		var bankNamex = $.trim($('.namex').val());

		var regName = /[^\w\u4e00-\u9fa5]/g; //数字，字母（不分大小写），汉字，下划线。
		var regBankAccount = /^\d{19}$/g;
		var num = /^\d*$/;
		var bol = true;

		$('#BankMsBox input.ned').each(function() {
			if(!$(this).val()) {
				$(this).focus();
				layer.msg($(this).attr('placeholder'));
				bol = false;
				return false;
			}
		})

		if(newBankNum) {
			if(!num.test(newBankNum)) {
				layer.msg('卡号必须全是数字')
				$('#bankNums').focus();
				bol = false;
				return false;
			}
			if(newBankNum.length < 16 || newBankNum.length > 19) {
				layer.msg('银行卡号在16到19之间')
				$('#bankNums').focus();
				bol = false;
				return false;
			}
		}

		if(bankNamex) {
			if(regName.test(bankNamex)) {
				layer.msg('用户名由数字，字母，汉字，下划线组成。不可含有非法字符')
				$('#names').focus();
				bol = false;
				return false;
			}
			if(getLength(bankNamex) < 5 || getLength(bankNamex) > 25) {
				layer.msg('开户名称长度在5到25之间')
				$('#names').focus();
				bol = false;
				return false;
			}
		}

		if(bol) {
			layer.msg('修改成功！');

			var secendBankNum = $('.bankNumx').val();
			var secendBankList = $('.bankNamex').val();
			var secendBankPersonName = $('.namex').val();

			$('.secend-bankNum').val(secendBankNum)
			$('.visity-box').html(formatBankNumber(secendBankNum)); //显示最后四位数
			$('.secend-bankList').val(secendBankList)
			$('.secend-bankPersonName').val(secendBankPersonName)

			$('#BankMsBox').hide();
			$('.bg-box').hide();
			return false;
		}

		return false;
	})
})