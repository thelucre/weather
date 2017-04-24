<!--
Test Vue Component
-->

<template lang='jade'>

.component--office-menu(:class='{ active: active }')
	.label(@mouseover='activate')
		h5 All Office Locations

	transition(name='scale-fade-fast')

		.location-menu(v-if='active || navigationOpen'
			@mouseleave='deactivate')

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

	computed:
		navigationOpen: -> @$store.getters.navigationOpen

	mounted: ->
		EventBus.$on 'location-updated', @deactivate

	methods:
		activate: -> @active = true if !@navigationOpen

		deactivate: -> @active = false if !@navigationOpen

		toggle: -> @active = !@active if !@navigationOpen
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

	.component--location-item
		a
			color white

	.location-menu
		padding rem(20px)
		background linear-gradient(160deg, blue -500%, dark-green)
		box-shadow 0 0 640px rgba(black, 0.5)
		clearfix()
		gpu-cache()

	// Desktop styles
	@media(min-width tablet+1px)
		.component--location-item
			width 33%

		.location-menu
			position absolute
			width rem(800px)
			left 100%
			top rem(-20px)
			z-index 2

			@media(max-width tablet-landscape)
				width rem(650px)

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

		// When open
		&.active
			.label
				transform scale(1.02)

	@media(max-width tablet)
		.location-menu
			padding rem(20px) 0
</style>
