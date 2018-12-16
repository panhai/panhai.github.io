<template>
	<div class="list">
		<Scroll id="isScroll" :on-reach-bottom="handleReachBottom" :on-reach-top="handleReachTop">
      <Card class="li" dis-hover v-for="(item, index) in data" :key="index">
      	<a @click="goUser(item.author.loginname)" class="user_avatar">
					<img :src="item.author.avatar_url"/>
				</a>
				<a href="javascript:;" @click="goTopic(item.id,item.author.loginname)" class="topic_title_wrapper">
					
					<span class="put_top top" v-if="item.top">置顶</span>
					<span class="put_top good" v-else-if="item.good">精华</span>
					<span class="put_top tab" v-else-if="tab == 'all'">{{ item.tab | translator }}</span>
					
					<span class="title">{{ item.title }}</span>
					<span class="reply_count">
						<span class="count_of_replies">{{ item.reply_count }}</span>
						<span class="count_seperator">/</span>
						<span class="count_of_visits">{{ item.visit_count }}</span>
					</span>
					<span class="last_active_time">{{ item.last_reply_at | timeFileter }}</span>
				</a>
      </Card>
   </Scroll>
	</div>
</template>

<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
	import store from '@/vuex/store' //引入 .js文件  （状态管理文件）
	
	export default {
	  data () {
	    return {
	    	data: [],
	    	pageNum: {
	    		all: 2,
	    		good: 2,
	    		weex: 2,
	    		share: 2,
	    		ask: 2,
	    		job: 2
	    	}
	    }
	  },
	  methods: {
	  	request () {
	  		let _this = this
	  		_this.axios({
				  method: 'get',
				  url: '/api/v1/topics',
				  params: {
				  	tab: _this.tab,
				  	limit: 20,
				  	page: 1
				  },
				  baseURL: 'https://www.vue-js.com',
				  responseType: 'json',
				  transformResponse: [
				  	function (res) {
				  		_this.data = res.data
				  		console.log(res)
				  	}
				  ]
				})
	  	},
	  	goUser (loginname) {
	  		this.$router.push('/user/' + loginname)
	  	},
	  	goTopic (id, loginname) {
	  		this.$router.push({path:'/topic/' + id,query:{loginname: loginname}})
	  	},
	  	//上拉刷新
	  	handleReachTop () {
	      return new Promise(resolve => {
	        setTimeout(() => {
	          this.request()
	          resolve();
	        }, 200);
	      });
	    },
	  	//下拉加载更多
	    handleReachBottom () {
	      return new Promise(resolve => {
	        setTimeout(() => {
	        	let _this = this
			  		_this.axios({
						  method: 'get',
						  url: '/api/v1/topics',
						  params: {
						  	tab: _this.tab,
						  	limit: 20,
						  	page: _this.pageNum[_this.tab]
						  },
						  baseURL: 'https://www.vue-js.com',
						  responseType: 'json',
						  transformResponse: [
						  	function (res) {
						  		_this.pageNum[_this.tab]++
						  		for (let i = 0, len = res.data.length; i < len; i++) {
						  			_this.data.push(res.data[i])
						  		}
						  	}
						  ]
						})
			  		resolve();
	        }, 300);
	      });
	    }
	  },
	  mounted () {
	  	this.$store.commit('scroll', isScroll.children[0]);
	  	this.request();
	  },
	  computed: {
	  	tab () {
	  		return this.$store.state.tab
	  	}
	  },
	  watch: {
	  	tab () {
	  		this.pageNum[this.tab] = 2
	  		this.request();
	  	}
	  },
	  store
	}
</script>

<style>
	.ivu-scroll-container {
		height: 6.2rem !important;
	}
	.ivu-card-bordered {
		border-radius: 0 !important;
	}
	.ivu-card-body {
		padding: 0 !important;
	}
	.list .li {
		margin-top: -0.1rem;
		padding: .1rem;
		line-height: .42rem;
	}
	.topic_title_wrapper {
		display: block;
		position: relative;
		padding-left: .4rem;
		height: 100%;
	}
	.user_avatar {
		position: relative;
		z-index: 2;
		float: left;
	}
	.user_avatar img {
		width: .3rem;
	}
	.topic_title_wrapper .put_top {
		padding: .02rem .04rem;
		border-radius: .03rem;
		font-size: .12rem;
		color: #999;
		background: #e5e5e5;
	}
	.topic_title_wrapper .good,
	.topic_title_wrapper .top {
		background: #369219;
		color: #fff;
	}
	.topic_title_wrapper .last_active_time {
		position: absolute;
		right: 0;
		bottom: .1rem;
		height: .28rem;
		font-size: .12rem;
		color: #778087;
	}
	.topic_title_wrapper .title {
		display: inline-block;
		width: 2rem;
		font-size: .14rem;
		color: #888;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	.reply_count {
		position: absolute;
		left: .77rem;
		bottom: .07rem;
		height: .2rem;
		font-size: 0;
	}
	.reply_count span {
		font-size: .1rem;
	}
	.count_of_replies {
		color: #9e78c0;
	}
	.count_seperator {
		color: #666;
	}
	.count_of_visits {
		color: #9e78c0;
	}
	</style>