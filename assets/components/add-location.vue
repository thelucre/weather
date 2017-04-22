<!--
Add Location Component
-->

<template lang='jade'>

.component--add-location
	input(v-model='location')
	button(@click='tryToAddLocation')
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
module.exports =
	data: -> location: ''

	methods:
		tryToAddLocation: ->
			@$store.dispatch 'addLocation', @location
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--add-location
	input
		border 0
		background rgba(white, 0.2)
</style>
