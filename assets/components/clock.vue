<!--
Test Vue Component
-->

<template lang='jade'>

.component--clock
  template(v-if='time')
    h3
      span {{ time.time }}
      span.meridiem  {{ time.meridiem }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default {
  data: ->
    # Time object with hh:mm:ss and meridiem
    time: null
    # Interval ID to cancel when component is destroyed
    intervalID: null

  # Kick off the timer
  mounted: -> @intervalID = setInterval @updateTime, 1000

  # Destroy the timer
  destroyed: -> clearInterval @intervalID if @intervalID

  methods:
    # Build a timer object and parse the hours/minutes/seconds and meridiem
    updateTime: ->
      date = new Date();
      seconds = date.getSeconds().toString().padStart(2, '0')
      minutes = date.getMinutes().toString().padStart(2, '0')
      @time =
        time: "#{date.getHours()%12}:#{minutes}:#{seconds}"
        meridiem: if date.getHours() > 12 then 'pm' else 'am'
}
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus'>
.component--clock
  *
    color white
    margin 0
		
  .meridiem
    text-transform uppercase
    font-size rem(30px)
</style>
