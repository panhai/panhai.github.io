	
$('body').on('click','.alert',function(){
	alertWx();//开始弹框
	
	return false;
})
setTimeout(function(){
	$('#closeid').click()
},180000)
