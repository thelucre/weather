<!--
Test Vue Component
-->

<template lang='jade'>

.component--template
	//-
	add-location

	//- Selectable Locations
	template(v-for='location in $root.locations')
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
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--template
	//
</style>
