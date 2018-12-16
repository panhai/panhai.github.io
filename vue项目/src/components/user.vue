<template>
	<div class="user">
		<div class="main">
			<div class="breadcrumb">
				<div class="header">
					<a href="/">主页</a>
					<span class="divider">/</span>
					<span class="dark">{{ loginname }}的主页</span>
				</div>
			</div>
			<div class="inner_userinfo">
				<div class="user_big_avatar">
					<img :src="data.avatar_url"/>
					<span class="dark">{{ data.loginname }}</span>
				</div>
				<div class="unstyled">
					<span>{{ data.score }} 积分</span>
					<div class="unstyled" v-if="data.githubUsername">
						<i class="iconfont icon-home"></i>
						<a :href="githubUrl" class="dark">{{ githubUrl }}</a>
						<br />
						<i class="iconfont icon-pinnedoctocat"></i>
						<a :href="githubUrl" class="dark">@{{ data.githubUsername }}</a>
					</div>
					<p class="col_fade">注册时间 {{ data.create_at | timeFileter }}</p>
				</div>
			</div>
		</div>
		<div class="title">最近创建的问题</div>
		<div class="cell" v-for="item in data.recent_topics">
			<a href="javascript:;" @click="goTopic(item.id,item.author.loginname)">
				{{ item.title }}
			</a>		
		</div>
		<div class="title">最近参与的问题</div>
		<div class="cell"v-for="item in data.recent_replies">
			<a href="javascript:;" @click="goTopic(item.id,item.author.loginname)">
				{{ item.title }}
			</a>
		</div>
	</div>
</template>

<script>
	export default {
		data () {
			return {
				data: {}
			}
		},
		mounted () {
			let _this = this
  		_this.axios({
			  method: 'get',
			  url: _this.loginname,
			  baseURL: 'https://www.vue-js.com/api/v1/user/',
			  responseType: 'json',
			  transformResponse: [
			  	function (res) {
			  		_this.data = res.data
			  		console.log(_this.data)
			  	}
			  ]
			})
		},
		computed: {
			loginname () {
				return this.$route.params.loginname
			},
			githubUrl () {
				return 'https://github.com/' + this.$route.params.loginname
			}
		},
		methods: {
			viewMore (loginname) {
				this.$router.push('/user/user_replies/' + loginname)
			},
			goTopic (id, loginname) {
	  		this.$router.push({path:'/topic/' + id,query:{loginname: loginname}})
	  	}
		}
	}
</script>

<style>
	.user .divider {
		font-size: 18px;
		color: #ccc;
	}
	.inner_userinfo {
		padding: 10px;
		border-top: 1px solid #e5e5e5;
		overflow: hidden;
	}
	.user_big_avatar img {
		width: 40px;
		border-radius: 3px;
	}
	.user .dark {
		margin-left: 5px;
		line-height: 2em;
		color: #778087;
	}
	.unstyled {
		margin-bottom: 10px;
	}
	.col_fade {
		color: #ababab;
	}
	.iconfont {
		font-size: 16px;
		color: #a1a1a1;
	}
	.user .title {
		padding: 10px;
		border-radius: 3px 3px 0 0;
		background: #f6f6f6;
	}
	.user .cell {
		padding: 10px;
		border-top: 1px solid #f0f0f0;
		background: #fff;
	}
	.user .more {
		border-top: 1px solid #f0f0f0;
		padding: 10px;
		background: #fff;
	}
</style>