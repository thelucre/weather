<!--
Unit Toggle Component

Switches between 'imperial' and 'metric' unit systems
-->

<template lang='jade'>

.component--unit-toggle(@click='toggleUnits'
	:class="[units]")
	.unit °C
	.unit °F

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {
	props:
		# Type of units (metric|imperial)
		units:
			type: String
			required: true

	mounted: -> console.log @units

	methods:
		toggleUnits: -> EventBus.$emit 'toggle-units'

}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--unit-toggle
	width 100px
	background rgba(white,0.3)
	position relative
	clearfix()
	cursor pointer
	transition transform 200ms ease

	&:hover
		transform scale(1.02)

	&:active
		transform scale(1)

	.unit
		width 50%
		height 48px
		float left
		transition color 200ms ease
		font-size rem(26px)
		font-weight text-light
		text-align center
		line-height 49px
		padding-right 2px
		color rgba(white,0.7)

	&:before
		content ''
		display block
		fill(white)
		width 50%
		z-index -1
		transition left 200ms ease

	&.metric
		.unit:first-of-type
			color dark-green

	&.imperial
		.unit:last-of-type
			color dark-green
		&:before
			left 50%

</style>
