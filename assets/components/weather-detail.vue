<!--
Weather Detail Component

Shows the weather information for a given location
-->

<template lang='jade'>

transition(name='swipe-right' appear)
	.component--weather-detail
		.controls
			.back-button
				router-link(:to="{ name: 'home' }") Back
				.bkgd

		.content
			template(v-if='location && weatherData')
				h1 {{ location.label }}
				p {{ weatherData }}
				weather-condition(v-if='conditionID && condition'
					:conditionID='conditionID'
					:condition='condition'
					:daytime='daytime')

				.temperature(v-if='temperature')
					.wi.wi-thermometer
					span {{ temperature }}

				.barometer(v-if='pressure')
					.wi.wi-barometer
					span {{ pressure }}

				.humidity(v-if='humidity')
					.wi.wi-humidity
					span {{ humidity }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
config = require '../config'
utils = require '../utils'

module.exports =

	components:
		weatherCondition: require './weather-condition'

	props:
		# City name
		slug:
			type: String
			required: true
			default: null

	computed:
		location: -> return @$store.getters.activeLocation
		weatherData: -> return @location?.weather?[@units]
		units: -> return @$store.getters.unitSystem

		### Parsing weather data ###
		# OpenWeather API key for weather type
		conditionID: -> return @weatherData?.weather?[0].id
		condition: -> return @weatherData?.weather?[0].main

		temperature: -> return @weatherData?.main?.temp
		humidity: ->
			return null if !@weatherData?.main?.humidity
			return @weatherData?.main?.humidity+'%'
		pressure: ->
			return null if !@weatherData?.main?.pressure
			return utils.formatPressure @weatherData.main.pressure, @units
		lowTemp: -> @weatherData?.main?.temp_min
		highTemp: -> @weatherData?.main?.temp_max

		# Are we between sunset and sunrise (local time)?
		daytime: ->
			# Defaults to true
			return true if !@weatherData?.sys
			return (
				@weatherData.timestamp >= @weatherData.sys.sunrise and
				@weatherData.timestamp <= @weatherData.sys.sunset
			)

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-detail
	fill(off-white)
	text-align left

	.controls
		background rgba(gray,0.1)
		overflow hidden
		position relative

	.content
		padding rem(0px) rem(40px)

	.back-button
		transition transform .2s ease
		transform-origin center left
		display inline-block
		a
			position relative
			padding rem(10px) rem(20px)
			padding-right rem(40px)
			display inline-block
			z-index 1
			text-transform uppercase
			font-weight text-bold
			font-size rem(14px)
			transition letter-spacing .2s ease

		.bkgd
			transform skew(-20deg)
			content ''
			width 120px
			position absolute
			background pink
			top 0
			left -20px
			bottom 0
			display block
			padding rem(30px)
			z-index 0
			transition width .2s ease

		&:hover
			a
				letter-spacing 2px
			.bkgd
				width 140px

		&:active
			a
				letter-spacing 1px
			.bkgd
				width 130px
</style>
