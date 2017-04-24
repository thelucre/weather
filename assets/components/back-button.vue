<!--
Back Button Component

Generic link component that rests at the top of a content pane
-->

<template lang='jade'>

.component--back-button
	router-link(:to="link") Back
	.bkgd
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		link:
			type: [Object,String]
			required: true
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--back-button
	transition transform .2s ease
	transform-origin center left
	display inline-block
	a
		position relative
		padding rem(10px) rem(20px)
		padding-right rem(80px)
		display inline-block
		z-index 1
		text-transform uppercase
		font-weight text-bold
		font-size rem(14px)
		transition letter-spacing .2s ease

	.bkgd
		transform skew(-20deg)
		content ''
		width 120px
		position absolute
		background pink
		top 0
		left -20px
		bottom 0
		display block
		padding rem(30px)
		z-index 0
		transition width .2s ease

	&:hover
		a
			letter-spacing 2px
		.bkgd
			width 140px

	&:active
		a
			letter-spacing 1px
		.bkgd
			width 130px
</style>
