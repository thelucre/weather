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
module.exports =
	mounted: -> console.log 'mounted!'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--template
	// 
</style>
