<!--
Test Vue Component
-->

<template lang='jade'>

.component--weather-condition
	p.wi(:class='[conditionIcon]')
	h5.label {{ condition }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	data: ->
		# Map for determining icon based on API weather code
		keys:
			200: day: 'wi-day-thunderstorm', night: 'wi-night-alt-storm-showers'
			201: day: 'wi-day-thunderstorm', night: 'wi-night-alt-storm-showers'
			202: day: 'wi-day-thunderstorm', night: 'wi-night-alt-storm-showers'
			210: day: 'wi-day-lightning', night: 'wi-night-alt-lightning'
			211: day: 'wi-day-lightning', night: 'wi-night-alt-lightning'
			212: day: 'wi-day-lightning', night: 'wi-night-alt-lightning'
			221: day: 'wi-day-lightning', night: 'wi-night-alt-lightning'
			230: day: 'wi-day-thunderstorm', night: 'wi-night-alt-storm-showers'
			231: day: 'wi-day-thunderstorm', night: 'wi-night-alt-storm-showers'
			232: day: 'wi-day-thunderstorm', night: 'wi-night-alt-storm-showers'
			300: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			301: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			302: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			310: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			311: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			312: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			313: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			314: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			321: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			500: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			501: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			502: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			503: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			504: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			511: day: 'wi-day-hail', night: 'wi-night-alt-hail'
			520: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			521: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			522: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			531: day: 'wi-day-rain', night: 'wi-night-alt-rain'
			600: day: 'wi-day-snow', night: 'wi-night-alt-snow-wind'
			601: day: 'wi-day-snow', night: 'wi-night-alt-snow-wind'
			602: day: 'wi-day-snow', night: 'wi-night-alt-snow-wind'
			611: day: 'wi-day-snow', night: 'wi-night-alt-snow-wind'
			612: day: 'wi-day-snow', night: 'wi-night-alt-snow-wind'
			615: day: 'wi-day-rain-mix', night: 'wi-night-sleet'
			616: day: 'wi-day-rain-mix', night: 'wi-night-sleet'
			620: day: 'wi-day-rain-mix', night: 'wi-night-sleet'
			621: day: 'wi-day-rain-mix', night: 'wi-night-sleet'
			622: day: 'wi-day-rain-mix', night: 'wi-night-sleet'
			701: day: 'wi-day-haze', night: 'wi-fog'
			# 711: smoke
			721: day: 'wi-day-haze', night: 'wi-fog'
			# 731: sand, dust whirls
			741: day: 'wi-day-fog', night: 'wi-night-fog'
			# 751: sand
			# 761: dust
			# 762: volcanic ash
			# 771: squalls
			# 781: tornado
			800: day: 'wi-day-sunny', night: 'wi-night-clear'
			801: day: 'wi-day-cloudy-high', night: 'wi-night-alt-partly-cloudy'
			802: day: 'wi-day-cloudy-high', night: 'wi-night-alt-partly-cloudy'
			803: day: 'wi-day-cloudy-high', night: 'wi-night-alt-partly-cloudy'
			804: day: 'wi-day-cloudy-high', night: 'wi-night-alt-partly-cloudy'
			# 900: tornado
			# 901: tropical storm
			# 902: hurricane
			# 903: cold
			904: day: 'wi-hot', night: 'wi-hot'
			905: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			# 906: hail
			# 951: calm
			952: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			953: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			954: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			955: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			956: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			957: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			958: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			959: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			960: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			961: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'
			962: day: 'wi-day-windy', night: 'wi-night-cloudy-windy'

	props:
		# Type of weather condition, ID from OpenWeather
		conditionID:
			type: [String,Number]
			required: true

		condition:
			type: String
			required: true

		daytime:
			type: [Boolean]
			required: false
			default: true

	computed:
		# Pick the icon based on the time of day and the weather code
		conditionIcon: ->
			icon = @keys[@conditionID]
			return icon?[if @daytime then 'day' else 'night']
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-condition
	weather-module-padding()
	text-align center
	padding-top 0

	.label
		color dark-green

	// icon class
	.wi
		font-size rem(200px)
		line-height 1
		color green

		&:before
			vertical-align text-bottom

			@media(max-width tablet)
				vertical-align initial

</style>
