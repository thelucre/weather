<!--
Test Vue Component
-->

<template lang='jade'>

.component--template
	p hiya!
	router-view
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
	mounted: -> console.log 'mounted!'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--template
	//
</style>
