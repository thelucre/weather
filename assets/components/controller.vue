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
module.exports =

	components:
		locationItem: require './location-item'
		addLocation: require './add-location'

	computed:
		locations: -> @$store.getters.allLocations
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--template
	//
</style>
