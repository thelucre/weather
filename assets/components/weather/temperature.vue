<!--
Temperature Component
-->

<template lang='jade'>

.component--weather-temperature
	p {{ high }}
	p {{ low }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	props:
		high:
			type: [String,Number]
			required: true

		low:
			type: [String,Number]
			required: true
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-temperature
	//
</style>
