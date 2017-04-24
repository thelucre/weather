<!--
Temperature Component
-->

<template lang='jade'>

.component--weather-temperature
	.weather-temperature--gauge
		.weather-temperature--label-low
			p
				{{ low }}&nbsp;
				span.wi(:class='[unitIndicator]')
		.weather-temperature--label-high
			p
				{{ high }}&nbsp;
				span.wi(:class='[unitIndicator]')
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		units:
			type: String
			default: 'imperial'

		high:
			type: [String,Number]
			required: true

		low:
			type: [String,Number]
			required: true

	computed:
		unitIndicator: ->
			return if @units == 'imperial' then 'wi-fahrenheit' else 'wi-celsius'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-temperature
	gap = 70px
	height = 20px
	weather-module-padding()

	@media(min-width tablet+1px)
		margin rem(30px) 0

	.weather-temperature--gauge
		border-radius height
		height rem(height)
		background linear-gradient(90deg, blue, pink)
		width "calc(100% - %s)" % (gap*2)
		margin 0 auto
		position relative

	.weather-temperature--label-low,
	.weather-temperature--label-high
		position absolute
		text-align center

		p
			color dark-green
			font-size rem(20px)
			line-height rem(height)

		// .wi
		// 	font-size rem(20px)

	.weather-temperature--label-low
		left -1*rem(gap)

	.weather-temperature--label-high
		right -1*rem(gap)
</style>
