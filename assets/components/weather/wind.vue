<!--
Weather Wind Component

Show windspeed and direction
-->

<template lang='jade'>

.component--weather-wind

	.weather-wind--column.weather-wind--direction(v-if='direction')
		.weather-wind--vane(:style='styleObject')
			.wi.wi-wind

		p {{ cardinal }}

	.weather-wind--column.weather-wind--speed(v-if='speed')
		.wi.wi-strong-wind
		p {{ speed }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		speed:
			type: [Number,String]

		direction:
			type: [Number,String]

	data: ->
		cardinalLabels: ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]

	computed:
		cardinal: ->
			index = Math.round((@direction/22.5))
			return @cardinalLabels[index%16]

		styleObject: ->
			transform: "rotate(#{@direction}deg)"
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-wind
	weather-module-padding()
	clearfix()
	text-align center

	@keyframes pulse
		0%,100%
			transform rotate(-2deg)
		50%
			transform rotate(2deg)

	p
		color dark-green

	.weather-wind--column
		width 33%
		display inline-block

	.wi
		font-size rem(60px)
		color green

	.weather-wind--vane
		transform-origin center center
		display inline-block

		.wi-wind
			animation-name pulse
			animation-duration 1.5s
			animation-iteration-count infinite
			animation-timing-function ease-out
</style>
