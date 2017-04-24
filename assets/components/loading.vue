<!--
Loading Component

Displays when XHR requests are blocking
-->

<template lang='jade'>

transition(name='fade' appear)
	.component--loading
		.loader--spinner
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
# export default {
# 	mounted: -> console.log 'mounted!'
# }
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--loading
	spinnerColor = dark-green
	spinnerHeight = 1.5rem
	spinnerScale = 2rem

	width rem(100px)
	position absolute
	right rem(16px)
	top @right
	z-index 2

	.loader--spinner,
	.loader--spinner:before,
	.loader--spinner:after
		background spinnerColor
		-webkit-animation load1 1s infinite ease-in-out
		animation load1 1s infinite ease-in-out
		width 1em
		height spinnerHeight

	.loader--spinner
		color spinnerColor
		text-indent -9999em
		margin spinnerHeight*2 auto
		position relative
		font-size 11px
		-webkit-transform translateZ(0)
		-ms-transform translateZ(0)
		transform translateZ(0)
		-webkit-animation-delay -0.16s
		animation-delay -0.16s

	.loader--spinner:before,
	.loader--spinner:after
		position absolute
		top 0
		content ''

	.loader--spinner:before
		left -1.5em
		-webkit-animation-delay -0.32s
		animation-delay -0.32s

	.loader--spinner:after
		left 1.5em

	@keyframes load1
		0%,
		80%,
		100%
			box-shadow 0 0
			height spinnerHeight

		40%
			box-shadow 0 -2em
			height spinnerScale

</style>
