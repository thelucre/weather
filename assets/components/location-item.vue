<!--
Location Item

Single location to select in the navigation.
Choosing the location will trigger a weather request or
load cached weather data
-->

<template lang='jade'>

.component--location-item
	router-link(
		:to="{ name: 'location', params: { location: location.slug }}")
		{{ location.label }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
module.exports =
	props:
		# Location object with values:
		# `slug`  - kebab case url slug
		# `label` - title case city name
		location:
			type: Object
			required: true

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--location-item
	//
</style>
