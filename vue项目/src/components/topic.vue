<template>
	<div class="topic">
		<div class="main">
			<div class="topic_header">
				<div class="topic_full_title">
					<span class="put_top">置顶</span>
					<span>{{ data.title }}</span>
				</div>
				<div class="changes">
					<span>发布于 {{ data.create_at | timeFileter }}</span>
					<span>作者 {{ $route.query.loginname }}</span>
					<span>{{ data.visit_count }} 次浏览</span>
					<span>来自 {{ data.tab | translator }}</span>
				</div>
			</div>
			<div class="inner_topic">
				<div class="topic_content">
					<div v-html="data.content"></div>
				</div>
			</div>
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
			let _this = this;
			_this.axios({
			  method: 'get',
			  url: _this.$route.params.id,
			  baseURL: 'https://www.vue-js.com/api/v1/topic/',
			  responseType: 'json',
			  transformResponse: [
			  	function (res) {
			  		_this.data = res.data
			  		setTimeout(function () {
			  			let code = document.querySelectorAll('pre code');
							code.forEach((code)=>{
						    hljs.highlightBlock(code)
						  })
			  		}, 100)
			  	}
			  ]
			})
		}
	}
	
</script>

<style>
	.topic {
		font-size: .14rem;
	}
	code {
		white-space: pre-wrap;
	}
	.markdown-text img {
		max-width: 100%;
		width: 640px;
		height: auto;
	}
	h2 {
		margin: .3rem 0 .15rem;
		line-height: .4rem;
		border-bottom: 1px solid #eee;
		font-weight: 700;
		font-size: .26rem;
		color: #333;
	}
	.markdown-text h2:first-child {
		margin-top: 0;
	}
	p {
		margin: .15rem 0;
		line-height: 1.7em;
	}
	.inner_topic ul {
		margin: 0 0 .1rem .25rem;
	}
	.inner_topic li {
		line-height: 2em;
		list-style: initial;
	}
	.inner_topic li li {
		list-style: circle;
	}
	.topic_header {
		padding: .1rem;
		font-size: .22rem;
		font-weight: 700;
		color: #333;
	}
	.topic_full_title {
		margin: .1rem 0;
	}
	.put_top {
		padding: .02rem .04rem;
		border-radius: .03rem;
		font-size: .12rem;
		color: #fff;
		background: #369219;
	}
	.changes {
		line-height: .2rem;
		font-size: .12rem;
		font-weight: normal;
		font-family: "Helvetica Neue","Luxi Sans","DejaVu Sans",Tahoma,"Hiragino Sans GB",STHeiti!important;
		color: #838383;
	}
	.changes span:before {
		content: "•";
		margin-right: .03rem;
	}
	.inner_topic {
		padding: .1rem;
	}
	.topic_content {
		margin: 0 .1rem;
	}
</style>