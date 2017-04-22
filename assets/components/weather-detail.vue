<!--
Weather Detail Component

Shows the weather information for a given location
-->

<template lang='jade'>

.component--weather-detail
	p {{ location.name }}
	pre(v-if='weather') {{ weather }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
config = require '../config'
module.exports =

	props:
		# City name
		location:
			type: String
			required: true
			default: null

	data: ->
		# Weather data from OpenWeather API
		weather: null

	watch:
		# Watch the route path to check for a weather data update
		'$route.params.location': (nv, ov) -> @fetch() unless ov == nv

	beforeMount: -> @fetch()

	methods:
		# Get weather data for the current location
		fetch: ->
			this.axios.get('/weather', {
				params:
					q: @location
					units: 'imperial'
					appid: config.api.key
			}).then (res) => @weather = res.data
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-detail
	//
</style>
