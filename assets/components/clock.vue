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
utils = require '../utils'

export default {
  data: ->
    # Time object with hh:mm:ss and meridiem
    time: null
    # Interval ID to cancel when component is destroyed
    intervalID: null

  # Kick off the timer
  mounted: ->
    @updateTime()
    @intervalID = setInterval @updateTime, 1000

  # Destroy the timer
  destroyed: -> clearInterval @intervalID if @intervalID

  methods:
    # Build a timer object and parse the hours/minutes/seconds and meridiem
    updateTime: ->
      date = new Date();
      @time = utils.formatTime date
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
