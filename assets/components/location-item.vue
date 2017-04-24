<!--
Location Item

Single location to select in the navigation.
Choosing the location will trigger a weather request or
load cached weather data
-->

<template lang='jade'>

.component--location-item
	router-link(@click.native='selected'
		:to="{ name: 'location', params: { slug: location.slug }}"
	) {{ location.label }}

	button(v-if='location.userDefined' @click='remove')
		span &#10005;
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {
	props:
		# Location object with values:
		# `slug`  - kebab case url slug
		# `label` - title case city name
		location:
			type: Object
			required: true

	methods:
		selected: -> EventBus.$emit 'location-updated', @location
		remove: -> EventBus.$emit 'remove-location', @location.slug
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--location-item
	background transparent
	display inline-block
	float left
	font-size rem(20px)
	font-weight text-light
	margin 0 1px 1px 0
	transition transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease
	box-shadow 0 0 0px rgba(black, 0.0)
	display inline-block
	width 100%
	position relative
	overflow hidden
	cursor pointer

	a
		color dark-green
		display block
		padding rem(10px) rem(20px)
		line-height 1.2

	&:hover
		background rgba(pink,0.7)

	@media(min-width tablet+1px)
		&:hover
			transform scale(1.05)
			box-shadow 0 0 10px rgba(black, 0.15)
			z-index 1
			background rgba(pink,0.7)

			button
				opacity 1

		&:active
			transform scale(0.97)

	button
		position absolute
		right rem(-40px)
		top 0
		bottom 0
		border 0
		background pink
		color white
		height 100%
		width rem(50px)
		transition right .3s ease, opacity .3s ease
		opacity 0
		text-align center
		padding 0
		display block
		user-select none

		span
			display block

		&:hover
			right rem(-2px)

	@media(max-width tablet)
		width 48%
		float left

		button
			right rem(-20px)
			opacity 1
			border-radius 50%
			width rem(32px)
			height @width
			line-height rem(28px)
			transform-origin center center
			transform translate(-50%, -50%) scale(0.7)
			top 50%

			&:hover
				right rem(-20px)
</style>
