<!--
Test Vue Component
-->

<template lang='jade'>

.component--template
	unit-toggle(:units='units')

	//-
	add-location

	//- Selectable Locations
	template(v-for='location in locations')
		location-item(:location='location')

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

	computed:
		locations: -> return @$store.getters.allLocations
		slug: -> return @$route.params?.slug
		units: -> return @$store.getters.unitSystem

	watch:
		# Watch the route path to check for a weather data update
		'$route.params.slug': (nv, ov) ->
			return if !nv
			@fetch() unless ov == nv

		# If a new location is set, route to that slug
		'$store.state.location': (nv) ->
			return if nv == null
			if nv.slug != @$route.params.slug
				link =
					name: 'location'
					params:
						slug: nv.slug
				@$router.push link

	beforeMount: ->
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
	//
</style>
