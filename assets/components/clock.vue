<!--
Test Vue Component
-->

<template lang='jade'>

.component--clock
  template(v-if='time')
    span {{ time.time }}
    span.meridiem  {{ time.meridiem }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
  data: ->
    time: null
    intervalID: null

  mounted: -> @intervalID = setInterval @updateTime, 1000
  destroyed: -> clearInterval @intervalID if @intervalID

  methods:
    updateTime: ->
      date = new Date();
      @time =
        time: "#{date.getHours()%12}:#{date.getMinutes()}:#{date.getSeconds().toString().padStart(2, '0');}"
        meridiem: if date.getHours() > 12 then 'pm' else 'am'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--clock
  font-weight text-ultra-light
  font-size rem(40px)

	.meridiem
		text-transform uppercase
		font-size rem(30px)
</style>
