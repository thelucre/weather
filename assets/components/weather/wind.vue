<!--
Weather Wind Component

Show windspeed and direction
-->

<template lang='jade'>

.component--weather-wind
	p {{ speed }}
	p {{ direction }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		speed:
			type: [Number,String]
			required: true

		direction:
			type: [Number,String]
			required: true
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-wind
	//
</style>
