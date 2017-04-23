<!--
Weather Wind Component

Show windspeed and direction
-->

<template lang='jade'>

.component--weather-wind
	p(v-if='speed') {{ speed }}
	p(v-if='direction') {{ direction }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		speed:
			type: [Number,String]

		direction:
			type: [Number,String]
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-wind
	weather-module-padding()
</style>
