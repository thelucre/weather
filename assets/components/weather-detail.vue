<!--
Weather Detail Component

Shows the weather information for a given location
-->

<template lang='jade'>

.component--weather-detail
	template(v-if='location')
		p {{ location.label }}
		pre {{ location }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
config = require '../config'
module.exports =

	props:
		# City name
		slug:
			type: String
			required: true
			default: null

	computed:
		location: -> return @$store.getters.activeLocation

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-detail
	//
</style>
