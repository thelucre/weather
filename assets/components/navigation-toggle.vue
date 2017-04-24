<!--
Menu Toggle Component

Opens/Closes the navigation in mobile views
-->

<template lang='jade'>
.component--navigation-toggle(:class='{ open: open }'
	@click='toggle')
	.bar
	.bar
	.bar
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'
$win = $(window)
export default {
	computed:
		open: -> @$store.getters.navigationOpen

	mounted: ->
		EventBus.$on 'location-updated', @close
		EventBus.$on 'location-created', @close
		$win.on 'resize', @checkForDesktop

	destroyed: ->
		# Clear event handlers
		$win.off 'resize', @checkForDesktop

	methods:
		toggle: -> @$store.dispatch 'toggleNavigation'
		close: -> @$store.dispatch 'closeNavigation'
		checkForDesktop: -> @close() if (@open && $win.outerWidth() > 768)
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--navigation-toggle
	@media(min-width tablet+1px)
		display none

	display inline-block
	width rem(50px)
	margin-left rem(10px)
	vertical-align super

	.bar
		height 3px
		background white
		transform-origin center center
		transition transform .3s ease, color .3s ease, opacity .1s ease

		&:not(:last-of-type)
			margin-bottom rem(12px)

	// Open state
	&.open
		.bar:first-of-type, .bar:last-of-type
			background pink

		.bar:first-of-type
			transform translateY(rem(16px)) rotate(45deg)

		.bar:last-of-type
			transform translateY(rem(-16px)) rotate(-45deg)

		.bar:nth-of-type(2)
			opacity 0
</style>
