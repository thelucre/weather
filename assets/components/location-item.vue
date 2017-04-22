<!--
Location Item

Single location to select in the navigation.
Choosing the location will trigger a weather request or
load cached weather data
-->

<template lang='jade'>

.component--location-item
	router-link(
		:to="{ name: 'location', params: { slug: location.slug }}")
		{{ location.label }}

	button(v-if='location.userDefined' @click='remove') Remove
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {
	props:
		# Location object with values:
		# `slug`  - kebab case url slug
		# `label` - title case city name
		location:
			type: Object
			required: true

	methods:
		remove: -> EventBus.$emit 'remove-location', @location.slug
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--location-item
	//
</style>
