<template>
  <div id="app">
  	<navbar/>
  	<!--<div class="main"> 主视口 router-view 就是一个视口镜子-->
	    <router-view/>
  	<!--</div>-->
  	<backtotop/>
  </div>
</template>

<script>
	import navbar from './components/navbar.vue'
	import backtotop from './components/backtotop.vue'
		
	export default {
	  name: 'app',
	  components: {  //1 引入模块  2 保存到conponents 3  页面中使用 （需要一个镜子才可以显示router-view ）
	  	navbar,
	  	backtotop
	  }
	}
</script>

<style>
	* {
		margin: 0;
		padding: 0;
	}
	body {
		margin: 0 auto !important;
		padding: 0 .05rem !important;
		font-size: 14px;
		background: #e1e1e1 !important;
	}
	li {
		list-style: none;
	}
	a {
		text-decoration: none;
	}
	img,a,span,i {
		vertical-align: middle;
	}
	.main {
		margin-top: .2rem;
		border-radius: .03rem ;
		background: #fff;
		overflow: hidden;
	}
</style>


<!--  主页面 主要做页面引入模块使用，同时也可以对body 等元素做页面预处理  -->