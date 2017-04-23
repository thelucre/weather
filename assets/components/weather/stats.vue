<!--
Weather Stats Component

Shows current temp, barometric pressure, & humidity
-->

<template lang='jade'>

.component--weather-stats
	.weather-stats--column.temperature(v-if='temperature')
		.wi.wi-thermometer
		p
			{{ temperature }}&nbsp;
			span.wi(:class='[unitIndicator]')

	.weather-stats--column.barometer(v-if='pressure')
		.wi.wi-barometer
		p {{ pressure }}

	.weather-stats--column.humidity(v-if='humidity')
		.wi.wi-humidity
		p {{ humidity }}
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
	weather-module-padding()
	clearfix()

	.weather-stats--column
		width (100%/3)
		float left
		text-align center

	p, p .wi
		color dark-green
		font-size rem(18px)

	// Icons
	.wi
		color green
		font-size rem(40px)
		text-align middle
		margin-bottom rem(20px)
		transform translateX(-25%)
</style>
