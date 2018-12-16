<template>
	<transition name="backtotop">
		<div class="backtotop" v-if="show" @click="backtotop()">返回顶部</div>
	</transition>	
</template>

<script>
	import store from '@/vuex/store'
	
	export default {
	  data () {
	  	return {
	  		show: false
	  	}
	  },
	  methods: {
	  	backtotop () {
			let isScroll = this.$store.state.scroll
	  		let timer = setInterval(function () {
					if (document.documentElement.scrollTop == 0) clearInterval(timer);
					window.scrollBy(0, -100);
				}, 5);
				if (isScroll.scrollTop) {
					let timer2 = setInterval(function () {
						if (isScroll.scrollTop == 0) clearInterval(timer2);
						isScroll.scrollBy(0, -100);
					}, 5);
				}
	  	}
	  },
	  mounted () {
	  	let _this = this
			let isScroll = this.$store.state.scroll
			//回到顶部
	  	isScroll.onscroll = function () {
	  		if (this.scrollTop >= 180) {
	  			_this.show = true
	  		} else {
	  			_this.show = false
	  		}
	  	}
	  	console.log(isScroll.onscroll)
	  	window.onscroll = function () {
	  		if (document.documentElement.scrollTop >= 180) {
	  			_this.show = true
	  		} else {
	  			_this.show = false
	  		}
	  	}
	  },
	  store
	}
</script>

<style>
	.backtotop-enter-active, .backtotop-leave-active {
	  transition: opacity .5s
	}
	.backtotop-enter, .backtotop-leave-to {
	  opacity: 0
	}
	.backtotop {
		position: fixed;
		right: 0;
		top: 4.3rem;
		z-index: 2;
		padding: .12rem 0 .12rem .05rem;
		width: .24rem;
		text-align: center;
		font-size: .14rem;
		color: gray;
		border: 0.01rem solid #ccc;
		border-right: 0;
		border-radius: .12rem 0 0 .12rem;
		background: #f5f5f5;
		cursor: pointer;
		-webkit-box-sizing: content-box;
		-moz-box-sizing: content-box;
		box-sizing: content-box;
	}
	.backtotop:active {
		background: #eee;
	}
	
	
	
</style>