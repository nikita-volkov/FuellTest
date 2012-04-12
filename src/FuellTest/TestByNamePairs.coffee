{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Numbers, Object, Optional, Optionals, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
Test = require "./Test"

exports.run = 
run = (pairs, cb) ->
  ###
  Parallelly runs all test suites, summarizing the results and passing them to the callback.
  ###
  startTime = Date.now()

  Pairs.processValuesBy Test.run, pairs, (testSummaryByNamePairs) ->
    failedTestSummaryByNamePairs = 
      Array.matches(
        ([_, s]) -> s.assertionsPassed != s.assertionsRun
        testSummaryByNamePairs
      )

    cb {
      time: Date.now() - startTime
      assertionsRun: 
        Numbers.union Array.results(
          ([_, s]) -> s.assertionsRun
          testSummaryByNamePairs
        )
      assertionsPassed: 
        Numbers.union Array.results(
          ([_, s]) -> s.assertionsPassed
          testSummaryByNamePairs
        )
      testsRun: testSummaryByNamePairs.length
      testsPassed: testSummaryByNamePairs.length - failedTestSummaryByNamePairs.length
      failedTestSummaryByNamePairs
    }


# pairs = Map.pairs {
#     "test 1": ->
#       @equals 5, 5
#       @equals 5, 2
#       @equals 5, 3
#     "test 2": ->
#       @equals 5, 5
#       @equals 5, 5
# }

# run pairs, (summary) ->
#   console.log summary