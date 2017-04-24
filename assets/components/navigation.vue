<!--
Navigation Component

Displays as the sidebar in dasktop and
the accordion nav in mobile
-->

<template lang='jade'>

.component--navigation(:class='{ open: open }')
	//- Mobile navigation toggle
	.component--navigation--toggle
		.bar
		.bar
		.bar

	office-menu(:locations='officeLocations')

	add-location

	.controller--user-locations(v-if='userLocations.length')
		location-item(v-for='location in userLocations'
			:key="location.slug"
			:location='location')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	components:
		officeMenu: require './office-menu'
		locationItem: require './location-item'
		addLocation: require './add-location'

	computed:
		locations: -> return @$store.getters.allLocations
		officeLocations: -> return @$store.getters.officeLocations
		userLocations: -> return @$store.getters.userLocations
		open: -> @$store.getters.navigationOpen
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--navigation
	width 200px
	float left
	margin-top rem(20px)
	background linear-gradient(180deg, blue -100%, green)
	transition none

	.component--navigation--toggle
		display none

	h5
		margin 0
		color white

	.controller--user-locations
		padding-bottom rem(16px)
		clearfix()
		h5
			padding rem(16px)

		// Overriding component styles for the sidebar
		.component--location-item
			&:hover
				background linear-gradient(45deg, lime, green)

			a
				color white

	// Main page break
	@media(max-width tablet)
		width 100%
		float none
		position absolute
		z-index 4
		left 0
		margin-top 0
		transition transform .3s ease

		// Hidden state
		transform translateX(-100%)

		// Visible state
		&.open
			transform none
</style>
