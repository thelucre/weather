<!--
Daylight Component

Shows daytime hours
-->

<template lang='jade'>

.component--weather-daylight
	p daylight hours
	p {{ sunrise }}
	p {{ time }}
	p {{ sunset }}
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
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
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--weather-daylight
	//
</style>
