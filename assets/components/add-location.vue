<!--
Add Location Component
-->

<template lang='jade'>

.component--add-location
	input(v-model='location')
	button(@click='addLocation')
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../events'

export default {
	data: -> location: ''

	beforeMount: ->
		EventBus.$on 'location-created', @clearInputs

	methods:
		addLocation: -> EventBus.$emit 'add-location', @location

		clearInputs: -> @location = ''
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--add-location
	input
		border 0
		background rgba(white, 0.2)
</style>
