<!--
Home Page Component

Show intro content and three main offices 
-->

<template lang='jade'>

transition(name='fade' appear)
	.component--home
		.banner

		.copy
			h1 Weather System
			p Unity Technologies has a truly global presence. The team, spread across 24 offices around the world, is working non-stop to continue democratizing game development. But...how's the weather? Have a look at the conditions of all Unity office locations or add your own city in the menu.


		.main-offices
			h4 The main offices

			router-link.btn(
				:to="{ name: 'location', params: { slug: 'san-francisco' }}"
			) San Francisco

			router-link.btn(
				:to="{ name: 'location', params: { slug: 'copenhagen' }}"
			) Copenhagen

			router-link.btn(
				:to="{ name: 'location', params: { slug: 'singapore' }}"
			) Singapore

		router-view(:key='$route.path')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	# mounted: -> console.log 'mounted!'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--home
	overflow hidden
	position relative
	background white
	box-shadow 0px 0px 60px rgba(black, 0.2)
	text-align center

	.banner
		height rem(250px)
		background-image url('/images/banner.gif')
		background-size cover
		background-position center 100%
		background-repeat no-repeat
		position relative

	.copy, .main-offices
		max-width rem(600px)
		margin 0 auto

	.main-offices
		padding rem(20px)
		padding-bottom rem(60px)

		a.btn
			margin 0 rem(10px)
			min-width 140px

</style>
