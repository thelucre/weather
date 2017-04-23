<!--
Test Vue Component
-->

<template lang='jade'>

transition(name='fade' appear)
	.component--home
		.banner

		.copy
			h1 How's the weather?
			p Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Aenean lacinia bibendum nulla sed consectetur. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Etiam porta sem malesuada magna mollis euismod.

		.main-offices
			p sanfranc
			p copenhagen
			p singapore

		router-view(:key='$route.path')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	mounted: -> console.log 'mounted!'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--home
	overflow hidden
	position relative
	background white
	box-shadow 0px 0px 60px rgba(black, 0.2)

	.banner
		height rem(250px)
		background-image url('/images/banner.jpg')
		background-size cover
		background-repeat no-repeat

	.copy
		max-width rem(600px)
		margin 0 auto
		text-align center
</style>
