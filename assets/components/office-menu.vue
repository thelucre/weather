<!--
Test Vue Component
-->

<template lang='jade'>

.component--office-menu(:class='{ active: active }')
	.label(@mouseover='activate')
		h5 All Office Locations

	transition(name='scale-fade-fast')
		.location-menu(v-if='active' @mouseleave='deactivate')
			location-item(v-for='location in locations'
				:key="location.slug"
				:location='location')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {

	props:
		locations:
			type: [Object, Array]

	data: ->
		active: false

	components:
		locationItem: require './location-item'

	mounted: -> EventBus.$on 'location-updated', @deactivate

	methods:
		activate: -> @active = true

		deactivate: -> @active = false

		toggle: -> @active = !@active
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--office-menu
	position relative

	.label
		padding rem(26px) rem(16px)
		background linear-gradient(160deg, blue -200%, dark-green)
		transition transform 0.3s ease
		cursor pointer

	.location-menu
		position absolute
		width 800px
		left 100%
		top rem(-20px)
		z-index 2
		padding rem(20px)
		background linear-gradient(160deg, blue -500%, dark-green)
		box-shadow 0 0 640px rgba(black, 0.5)

		// hidden mouse target
		&:before
			content ''
			display block
			position absolute
			left -200px
			top 0
			height 120px
			width 200px
			cursor pointer

	.component--location-item
		width 33%

		a
			color white

	// When open
	&.active
		.label
			transform scale(1.02)
</style>
