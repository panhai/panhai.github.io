//撤销投诉
$('.revoke').on('click',function(){
	
	layer.confirm('确定撤销投诉吗？撤销后此订单不可再申请投诉。',{title:'撤销投诉'},function(index){
		//do.....
		
		layer.close(index);
	})
	return false;
})
