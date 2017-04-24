<!--
Test Vue Component
-->

<template lang='jade'>

.component--controller

	header
		nav
			a(href='https://unity3d.com/' target='_blank')
				img(src='./images/unity-logo.svg')
			router-link( :to="{ name: 'home' }") Weather

		clock
		unit-toggle(:units='units')
		navigation-toggle

	navigation

	.content-pane
		//- Routed app view to host weather detail components
		router-view

	error-panel(v-if='error')
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import EventBus from '../logic/events'

export default {
	components:
		unitToggle: require './unit-toggle'
		clock: require './clock'
		navigation: require './navigation'
		navigationToggle: require './navigation-toggle'
		errorPanel: require './error-panel'

	computed:
		units: -> return @$store.getters.unitSystem
		slug: -> return @$route.params?.slug
		error: -> return @$store.getters.errorMessage

	watch:
		# Watch the route path to check for a weather data update
		'$route.params.slug': (nv, ov) ->
			return @$store.dispatch 'clearActiveLocation' if !nv
			@fetch() unless ov == nv

		# If a new location is set, route to that slug
		# If there's no active location, go back home
		'$store.state.location': (nv) ->
			if nv == null && @$route.params?.slug
				@$router.push name: 'home'
			else if nv?.slug != @$route.params?.slug
				link =
					name: 'location'
					params:
						slug: nv.slug
				@$router.push link

	beforeMount: ->
		# Fetch data from cache / API if we're on a child page
		@fetch() if @slug

		# This controller will be decoupled from the components
		# Using a global event bus we can catch relevant events and
		# not require specific components to fire them
		EventBus.$on 'add-location', @tryToAddLocation
		EventBus.$on 'remove-location', @removeLocation
		EventBus.$on 'toggle-units', @toggleUnits

	methods:
		# Get weather data for the current location
		fetch: -> @$store.dispatch 'setActiveLocation', @slug

		tryToAddLocation: (location) -> @$store.dispatch 'addLocation', location

		removeLocation: (slug) -> @$store.dispatch 'removeLocation', slug

		toggleUnits: -> @$store.dispatch 'toggleUnits'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--controller
	max-width max-w
	margin 0 auto

	nav
		float left

		img
			width 90px

		a, img
			line-height 1.8
			vertical-align middle

		a.router-link-active
			font-size rem(28px)
			font-weight text-ultra-light
			margin-left rem(20px)

	header
		text-align right
		padding-bottom rem(10px)
		clearfix()

	.content-pane
		margin-left 200px

	// Override specific component styles at the controller level
	.component--clock
		display inline-block
		line-height 50px
		vertical-align top
		margin-right 1rem

	.component--unit-toggle
		display inline-block

	// Main page break
	@media(max-width tablet)
		nav img
			width 70px

		.content-pane
			margin-left 0

	@media(max-width mobile-landscape)
		.component--clock
			display none
</style>
