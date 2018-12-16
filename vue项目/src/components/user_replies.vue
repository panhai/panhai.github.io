<template>
	<div class="user_replies">
		<div class="main">
			<breadcrumb :loginname="loginname"/>
		</div>
		<list />
	</div>
</template>

<script>
	import list from '@/components/home/list'
	
	export default {
		components: {
			list
		},
		computed: {
			loginname () {
				return this.$route.params.loginname
			}
		}
	}
</script>

<style>
</style>