<!--
Test Vue Component
-->

<template lang='jade'>

.component--template
	nav
		a(href="#") Unity3D
		router-link( :to="{ name: 'home' }") Home

	header
		clock
		unit-toggle(:units='units')

	aside
		office-menu(:locations='officeLocations')

		add-location

		h5 User Locations
		template(v-if='userLocations.length')
			location-item(v-for='location in userLocations'
				:key="location.slug"
				:location='location')

	.content-pane
		//- Routed app view to host weather detail components
		router-view

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {
	components:
		locationItem: require './location-item'
		addLocation: require './add-location'
		unitToggle: require './unit-toggle'
		clock: require './clock'

	computed:
		locations: -> return @$store.getters.allLocations
		officeLocations: -> return @$store.getters.officeLocations
		userLocations: -> return @$store.getters.userLocations

		slug: -> return @$route.params?.slug
		units: -> return @$store.getters.unitSystem

	watch:
		# Watch the route path to check for a weather data update
		'$route.params.slug': (nv, ov) ->
			return @$store.dispatch 'clearActiveLocation' if !nv
			@fetch() unless ov == nv

		# If a new location is set, route to that slug
		# If there's no active location, go back home
		'$store.state.location': (nv) ->
			if nv == null && @$route.params?.slug
				@$router.push name: 'home'
			else if nv?.slug != @$route.params?.slug
				link =
					name: 'location'
					params:
						slug: nv.slug
				@$router.push link

	beforeMount: ->
		# Fetch data from cache / API if we're on a child page
		@fetch() if @slug

		# This controller will be decoupled from the components
		# Using a global event bus we can catch relevant events and
		# not require specific components to fire them
		EventBus.$on 'add-location', @tryToAddLocation
		EventBus.$on 'remove-location', @removeLocation
		EventBus.$on 'toggle-units', @toggleUnits

	methods:
		# Get weather data for the current location
		fetch: -> @$store.dispatch 'setActiveLocation', @slug

		tryToAddLocation: (location) -> @$store.dispatch 'addLocation', location

		removeLocation: (slug) -> @$store.dispatch 'removeLocation', slug

		toggleUnits: -> @$store.dispatch 'toggleUnits'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--template
	max-width max-w
	margin 0 auto

	header
		text-align right
		padding-bottom rem(10px)

	aside
		width 200px
		float left
		margin-top rem(50px)
		background lime

		h5
			margin 0
			color white

	.content-pane
		margin-left 200px

	// Override specific component styles at the controller level
	.component--clock
		display inline-block
		line-height 50px
		vertical-align top
		margin-right 1rem

	.component--unit-toggle
		display inline-block
</style>
