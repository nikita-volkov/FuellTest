{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
{Path} = require "FuellSys"
# Test = require "./RobustaTest/Test"


# someAction = (cb) ->
#   setTimeout(
#     -> cb 5
#     100
#   )
# test = ->
#   @equals 3, 4
#   @equals 3, 5
#   @equals 5, 5
#   @resultEquals 5, someAction
#   @resultEquals 6, someAction
#   @resultEquals 6, someAction
#   @resultEquals 7, someAction


# Test.run test, (summary) ->
#   # console.log testSummaryRender true, summary



# require "./RobustaTest/TotalSummary"
# path = "SampleTest"
# absPath = process.cwd() + "/test/" + path
# relativePath = FuellSys.Path.relativeTo __filename, absPath
# console.log require relativePath


# require "./RobustaTest/TestByNamePairs"
# require "./RobustaTest/SuiteByNamePairs"

RobustaTest = require "./RobustaTest"

RobustaTest.testDirectory "test"
