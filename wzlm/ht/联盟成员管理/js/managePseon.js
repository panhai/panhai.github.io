(function() {

	
	//tab 切换
	$(function() {
		$('.tab button').click(function() {
			$(this).addClass('bgColor').siblings().removeClass('bgColor');
		})
	})
	
	//操作删除
	$(function() {
		//点击删除，删除当前的一行
		$('.deletes').click(function() {
			var start = $(this).parent().siblings('td').children('input.chek').is(':checked');
			console.log($(this).parent().siblings('td').children('input.chek'))
			if(!start){
				layer.msg('请勾选项目')
				return false;
			}
			var _this = this;
			layer.confirm('确定删除吗？', {icon: 3, title:'提示'}, function(index){
			  //do something
			  $(_this).parent().parent().remove();
			  layer.close(index);
			});
			return false;
		})
		//全部选择和删除
		var num = 0;
		var bol = false;
		$('.pageing .all').click(function() {
			num++;
			if(num % 2 == 0) {
				$('input').prop('checked', false);
				bol = false;
				$('.myTable td img').hide();

			} else {
				$('input').prop('checked', true)
				bol = true;
				$('.myTable td img').show();
			}
		})
		//全部删除
		$('.delete').click(function() {
			//如果input checked ==true 则删除当前的行 
			$('td input').each(function() {
				if($(this).prop('checked') == true) {
					$(this).parent().parent().remove();
				}
			})
		})
		//单项选择
		$('td input').click(function() {

			if($(this).prop('checked') == true) {
				$(this).siblings('.tg').children('img').show();
			} else {
				$(this).siblings('.tg').children('img').hide();
			}
		})
	})
	
	//确定提交
	$(function() {
		$('.search .btn').click(function() {

			return false;
		})
	})
	//批量修改状态 chek over noover
	$('.chekk .over').on('click',function(){
		layer.confirm('确定审核通过吗？',{icon:3,title:'提示'},function(index){
			
			$('.myTable td input').each(function(){
				var start = $(this).is(':checked');
				if(start){
					$(this).parent('td').siblings('.zt').text('已通过');
					$(this).parent('td').siblings('.zt').css('color','#333333')
				}
			})
			
			layer.close(index)
		})
	})
	//不通过
	$('.chekk .noover').on('click',function(){
		layer.confirm('确定审核不通过吗？',{icon:3,title:'提示'},function(index){
			
			$('.myTable td input').each(function(){
				var start = $(this).is(':checked');
				if(start){
					$(this).parent('td').siblings('.zt').text('不通过');
					$(this).parent('td').siblings('.zt').css('color','#ff2c40');
				}
			})
			
			layer.close(index)
		})
	})
	
	function getStr(m){
		if(m<10){
			return "0"+m;
		}else{
			return ""+m;
		}
	}
	
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		
		laydate.render({
			elem:'#year',
			value:(new Date().getFullYear())+'-'+getStr(new Date().getMonth()+1)+'-'+(new Date().getDate())
		});
		laydate.render({
			elem:'#month'
		})
	})

})()


/*成员资料修改*/
/*推广网站修改*/
/*新增推广网站*/
/*银行帐号更新*/
$(function(){
	/*帐号信息完善*/
	
	//关闭弹框
	$('.closed').click(function(){
		$('form').hide();
		$('.zhezhao').hide();
	})
	
	//查看帐号信息完善
	$('.look-a').click(function(){
		$('.status1').show();
		$('.zhezhao').show();
	})
	$('.look-b').click(function(){
		$('.status2').show();
		$('.zhezhao').show();
	})
	$('.look-c').click(function(){
		$('.status3').show();
		$('.zhezhao').show();
	})
	$('.look-d').click(function(){
		$('.status4').show();
		$('.zhezhao').show();
	})
	$('.look-e').click(function(){
		$('.status5').show();
		$('.zhezhao').show();
	})
})
