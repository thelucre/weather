<!--
Weather Detail Component

Shows the weather information for a given location
-->

<template lang='jade'>

transition(name='swipe-right' appear)
	.component--weather-detail
		.weather-detail--controls
			back-button(:link='{ name: "home" }')

		.weather-detail--content
			template(v-if='location && weatherData')
				h1.title {{ location.label }}

				.weather-detail--column
					condition(v-if='conditionID && condition'
						:conditionID='conditionID'
						:condition='condition'
						:daytime='daytime')

					daylight(v-if='sunrise && sunset && timestamp'
						:sunrise='sunrise'
						:sunset='sunset'
						:time='timestamp')

				.weather-detail--column
					stats(v-if='temperature || humidity || pressure'
						:temperature='temperature'
						:humidity='humidity'
						:pressure='pressure'
						:units='units'
					)

					temperature(v-if='highTemp && lowTemp'
						:high='highTemp'
						:low='lowTemp'
						:units='units')

					wind(v-if='windSpeed || windDirection'
						:speed='windSpeed'
						:direction='windDirection')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
config = require '../../config'
utils = require '../../utils'

module.exports =

	components:
		backButton: require '../back-button'
		condition: require './condition'
		stats: require './stats'
		wind: require './wind'
		daylight: require './daylight'
		temperature: require './temperature'

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

		###
		Parsing weather data to pass to components
		###
		# OpenWeather API key for weather type
		conditionID: -> return @weatherData?.weather?[0].id
		condition: -> return @weatherData?.weather?[0].main

		temperature: ->
			return @weatherData?.main?.temp?.toFixed(1)
		humidity: ->
			return null if !@weatherData?.main?.humidity
			return @weatherData?.main?.humidity+'%'
		pressure: ->
			return null if !@weatherData?.main?.pressure
			return utils.formatPressure @weatherData.main.pressure, @units

		lowTemp: -> return @weatherData?.main?.temp_min?.toFixed(1)
		highTemp: -> return @weatherData?.main?.temp_max?.toFixed(1)

		windSpeed: ->
			return null if !@weatherData?.wind?.speed
			return utils.formatWindSpeed @weatherData.wind.speed, @units
		windDirection: -> return @weatherData?.wind?.deg

		sunrise: -> return @weatherData?.sys?.sunrise
		sunset: -> return @weatherData?.sys?.sunset
		timestamp: -> return @weatherData.timestamp

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

	.title
		text-align center

	.weather-detail--controls
		background rgba(gray,0.1)
		overflow hidden
		position relative

	.weather-detail--content
		padding rem(0px) rem(40px)
		clearfix()

	.weather-detail--column
		width 50%
		display inline-block
		vertical-align middle
		max-width 440px

</style>
