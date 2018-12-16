<template>
	<div class="main">
	  <div class="home">
	  	<div class="header">
	  		<router-link to="/home/all">全部</router-link>
	  		<router-link to="/home/good">精华</router-link>
	  		<router-link to="/home/weex">weex</router-link>
	  		<router-link to="/home/share">分享</router-link>
	  		<router-link to="/home/ask">问答</router-link>
	  		<router-link to="/home/job">招聘</router-link>
	  	</div>
	  	<!--<list :tab="$route.params.tab" />--> 
	  	<list />
	  </div>
  </div>
</template>

<script>
import list from '@/components/home/list'// 引入.vue文件
import store from '@/vuex/store'         //引入.js文件

export default {    //输出
  name: 'home',
  data () {
    return {
    	tab:''
    }
  },
  mounted () {
  	this.fn()
  },
  methods: {
  	fn () {
  		this.$store.commit('tab', this.$route.params.tab);
  	}
  },
  computed: {
  	tab () {
  		return this.$route.params.tab
  	}
  },
  watch: {
  	tab () {
  		this.fn();
  	}
  },
  components: {
  	list
  },
  store
}
</script>

<style>
	.ivu-card-bordered:first-child {
		border-top: none;
	}
	.home .header {
		padding: .1rem 0;
		border-bottom: 1px solid #ddd;
		background: #f6f6f6;
	}
	.home .header a {
		display: inline-block;
		margin: 0 .1rem;
		padding: .03rem .038rem;
		font-size: .14rem;
		color: #369219;
	}
	.home .header .router-link-active {
		border-radius: 3px;
		color: #eee;
		background: #369219;
	}
</style>
