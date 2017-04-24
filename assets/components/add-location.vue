<!--
Add Location Component
-->

<template lang='jade'>

.component--add-location
	h5 Add Your Location

	form(@submit.prevent.stop='addLocation')
		input(v-model='location' placeholder='enter a city')
		button(type='submit'
			:disabled='isDisabled') Add It
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {
	data: -> location: ''

	computed:
		isDisabled: ->return @location.trim() == ''

	beforeMount: ->
		EventBus.$on 'location-created', @clearInputs

	methods:
		addLocation: -> EventBus.$emit 'add-location', @location

		clearInputs: -> @location = ''
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--add-location
	padding rem(16px)

	form
		margin-top rem(10px)
		position relative

	input
		border 0
		background rgba(white, 0.4)
		padding rem(8px)
		display inline-block
		width 100%
		font-size rem(18px)
		color white
		text-align center

		+placeholder()
			color white
			font-weight text-light

	button[type="submit"]
		border 0
		display block
		background linear-gradient(45deg, lime, green)
		width 100%
		padding rem(10px)
		color white
		margin-top rem(1px)
		text-transform uppercase
		letter-spacing rem(1px)
		font-weight text-light
		box-shadow 0 0 0px rgba(black, 0.0)
		transition transform .3s ease, box-shadow .3s ease, opacity .3s ease
		gpu-cache()

		&:not(:disabled)
			&:hover
				transform scale(1.05)
				box-shadow 0 0 10px rgba(black, 0.15)

			&:active
				transform scale(0.97)

		&:disabled
			opacity 0.4
</style>
