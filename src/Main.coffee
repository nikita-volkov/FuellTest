{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

Test = require "./RobustaTest/Test"


someAction = (cb) ->
  setTimeout(
    -> cb 5
    100
  )
test = ->
  @equals 3, 4
  @equals 3, 5
  @equals 5, 5
  @resultEquals 5, someAction
  @resultEquals 6, someAction
  @resultEquals 6, someAction
  @resultEquals 7, someAction


Test.run test, (summary) ->
  console.log summary