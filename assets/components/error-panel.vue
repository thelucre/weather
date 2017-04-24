<!--
Error Panel Component

Wil popup in the footer if there are problems that the user should know about
-->

<template lang='jade'>

transition(name='swipe-up')
	.component--error-panel
		p {{ error }}
		.close(@click='clear') &#10005;
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	computed:
		error: -> return @$store.getters.errorMessage

	methods:
		clear: -> @$store.dispatch 'clearError'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--error-panel
	transition transform .3s ease
	background white
	position fixed
	border-top 2px solid pink
	color dark-grey
	padding rem(16px) rem(50px) rem(16px) rem(20px)
	text-align center
	bottom 0
	left 0
	right 0
	z-index 10

	@media(max-width tablet)
		p
			text-align left
			max-width 80%

	.close
		background pink
		position absolute
		right rem(15px)
		height rem(30px)
		width @height
		line-height @width
		color white
		border-radius 50%
		transform translateY(-50%)
		top 50%
		transition transform .3s ease
		cursor pointer

		&:hover
			transform translateY(-50%) scale(1.1)

		&:active
			transform translateY(-50%) scale(0.97)
</style>
