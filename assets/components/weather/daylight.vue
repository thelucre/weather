<!--
Daylight Component

Shows daytime hours
-->

<template lang='jade'>

.component--weather-daylight

	.weather-daylight--ruler
		.ruler.weather-daylight--night
		.ruler.weather-daylight--day(:style='styleObject')
		.marker.time.wi.wi-direction-down(:style='{left: timePercent}')
		.marker.sunrise.wi.wi-sunrise(:style='{left: dayPercent}')
		.marker.sunset.wi.wi-sunset(:style='{right: dayPercent}')

	h5.label Daylight hours
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
utils = require '../../utils'

export default {
	props:
		sunrise:
			type: Number
			required: true
		sunset:
			type: Number
			required: true
		time:
			type: Number
			required: true

	computed:
		sunriseString: ->
			date = new Date @sunrise*1000
			return utils.formatTime date

		sunsetString: ->
			date = new Date @sunset*1000
			return utils.formatTime date

		timeString: ->
			date = new Date @time*1000
			return utils.formatTime date

		secondsInDay: -> return (60*60*24)

		# Calculate the actual time of day (this is not exact due to timezones)
		timePercent: ->
			night = @secondsInDay - (@sunset - @sunrise)
			beginning = @sunrise - night/2
			diff = (@time-beginning)/@secondsInDay

			# Some timestamps end up negative, so reverse the value
			diff = 1 - Math.abs(diff) if diff < 0

			diff = ((diff*100)%100).toFixed(5)+'%'
			return diff

		dayPercent: ->
			diff = (@secondsInDay - (@sunset - @sunrise))/@secondsInDay
			diff = (diff/2*100).toFixed(5)+'%'
			return diff

		styleObject: ->
			left: @dayPercent
			right: @dayPercent
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-daylight
	weather-module-padding()
	max-width 350px
	margin 0 auto

	.label
		color dark-green
		text-align center
		margin-top rem(60px)

	.weather-daylight--ruler
		position relative

	.ruler
		border-radius rem(20px)
		height @border-radius

	.weather-daylight--night
		width 100%
		background lighten(dark-green,10%)

	.weather-daylight--day
		fill(rgba(yellow,0.95))
		width initial

	.marker
		position absolute
		top rem(-30px)
		color green
		font-size rem(26px)

	.time
		font-size rem(36px)
		color dark-green
		transform translateX(-50%)

	.sunset, .sunrise
		top rem(36px)

	.sunrise
		transform translateX(-40%)

	.sunset
		transform translateX(40%)
</style>
