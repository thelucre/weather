<!--
Test Vue Component
-->

<template lang='jade'>

.component--template
	p(@click="$store.dispatch('toggleUnits')") Units: {{ $store.state.units }}

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
import EventBus from '../events'

export default {
	components:
		locationItem: require './location-item'
		addLocation: require './add-location'

	computed:
		locations: -> return @$store.getters.allLocations
		slug: -> return @$route.params.slug

	watch:
		# Watch the route path to check for a weather data update
		'$route.params.slug': (nv, ov) -> @fetch() unless ov == nv

	beforeMount: ->
		@fetch() if @slug

		# This controller will be decoupled from the components
		# Using a global event bus we can catch relevant events and
		# not require specific components to fire them
		EventBus.$on 'add-location', @tryToAddLocation
		EventBus.$on 'remove-location', @removeLocation

	methods:
		# Get weather data for the current location
		fetch: -> @$store.dispatch 'setActiveLocation', @slug

		tryToAddLocation: (location) -> @$store.dispatch 'addLocation', location

		removeLocation: (slug) -> @$store.dispatch 'removeLocation', slug
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--template
	//
</style>
