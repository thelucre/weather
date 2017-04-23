<!--
Daylight Component

Shows daytime hours
-->

<template lang='jade'>

.component--weather-daylight

	.weather-daylight--ruler
		.ruler.weather-daylight--night
		.ruler.weather-daylight--day(:style='styleObject')
		.marker.time.wi.wi-small-craft-advisory(:style='{left: timePercent}')
		.marker.sunrise.wi.wi-sunrise(:style='{left: dayPercent}')
		.marker.sunset.wi.wi-sunset(:style='{right: dayPercent}')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
utils = require '../../utils'
moment = require 'moment'

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

		timePercent: ->
			night = @secondsInDay - (@sunset - @sunrise)
			beginning = @sunrise - night/2
			diff = (@time-beginning)/@secondsInDay
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

	.weather-daylight--ruler
		position relative

	.ruler
		background slate
		border-radius rem(20px)
		height @border-radius

	.weather-daylight--night
		width 100%

	.weather-daylight--day
		fill(yellow)
		width initial

	.marker
		position absolute
		top rem(-30px)
		color green
		font-size rem(26px)

	.sunset, .sunrise
		top rem(36px)

	.sunrise
		transform translateX(-40%)

	.sunset
		transform translateX(40%)
</style>
