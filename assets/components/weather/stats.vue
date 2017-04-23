<!--
Weather Stats Component

Shows current temp, barometric pressure, & humidity 
-->

<template lang='jade'>

.component--weather-stats
	.temperature(v-if='temperature')
		.wi.wi-thermometer
		span {{ temperature }}
		span.wi(:class='[unitIndicator]')

	.barometer(v-if='pressure')
		.wi.wi-barometer
		span {{ pressure }}

	.humidity(v-if='humidity')
		.wi.wi-humidity
		span {{ humidity }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		units:
			type: String
			default: 'imperial'

		temperature:
			type: [String,Number]
			default: null

		pressure:
			type: String
			default: null

		humidity:
			type: String
			default: null

	computed:
		unitIndicator: ->
			return if @units == 'imperial' then 'wi-fahrenheit' else 'wi-celsius'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-stats
	.wi
		font-size rem(20px)
		text-align middle
</style>
