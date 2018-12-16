<template>
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container">
				<a href="/" class="brand">
					<img src="../assets/logo.png"/>
					<span>Vue.js</span>
				</a>
				<form class="navbar-search">
					<div class="search">
						<Input type="text" icon="android-search" />
					</div>
				</form>
				<ul class="nav">
					<li><a href="/">首页</a></li>
					<li><a href="http://www.hubwiz.com/course/?type=Vue.js&affid=vue-js">交互教程</a></li>
					<li><a href="">微信公众号</a></li>
					<li><a href="http://doc.vue-js.com/">VUE2.0</a></li>
					<li><a href="">参考资料</a></li>
					<li><a href="">API</a></li>
					<li><a href="">关于</a></li>
					<li><a href="">注册</a></li>
					<li><a href="">登录</a></li>
				</ul>
			</div>
		</div>
	</div>
</template>

<style>
	.ivu-input {
		height: .28rem !important;
		background: #eee;
	}
	.ivu-icon {
		width: .32rem !important;
		font-size: .19rem !important;
		line-height: .28rem !important;
	}
	
	.navbar {
		height: 1.7rem;
		background: #1c6132;
	}
	.navbar-inner {
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
		box-sizing: border-box;
		margin: 0 auto;
		padding: .05rem;
		height: 100%;
		width: 90%;
		/*background: red;*/
	}
	.navbar-inner .container {
		height: 100%;
		width: 100%;
		text-align: center;
		/*background: greenyellow;*/
	}
	.brand {
		display: inline-block;
		text-align: center;
		font-size: .2rem;
		color: #fff;
	}
	.brand img {
		width: .45rem;
		vertical-align: middle;
	}
	.navbar-search {
		margin: .04rem 0;
	}
	.search {
		margin: 0 auto;
		width: 2.33rem;
	}
	.nav {
		overflow: hidden;
	}
	.nav li {
		float: left;
		line-height: .2rem;
	}
	.nav a {
		display: block;
		padding: .10rem .16rem;
		font-size: .13rem;
		color: #eee;
	}
</style>