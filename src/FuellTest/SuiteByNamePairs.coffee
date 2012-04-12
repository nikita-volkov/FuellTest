{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Numbers, Object, Optional, Optionals, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
TestByNamePairs = require "./TestByNamePairs"

exports.run = 
run = (suiteByNamePairs, cb) ->
  ###
  Parallelly runs all test suites, summarizing the results and passing them to the callback. Is intended to be used for running all test suites of the project.

  suite is a testByNamePairs
  ###
  startTime = Date.now()

  Pairs.processValuesBy TestByNamePairs.run, suiteByNamePairs, 
    (suiteSummaryByNamePairs) ->
      failedSuiteSummaryByNamePairs = 
        Array.matches (([_, s]) -> s.testsPassed != s.testsRun), suiteSummaryByNamePairs

      cb {
        time: Date.now() - startTime
        assertionsRun:
          Numbers.union Array.results (([_, s]) -> s.assertionsRun), suiteSummaryByNamePairs
        assertionsPassed:
          Numbers.union Array.results (([_, s]) -> s.assertionsPassed), suiteSummaryByNamePairs
        testsRun:
          Numbers.union Array.results (([_, s]) -> s.testsRun), suiteSummaryByNamePairs
        testsPassed:
          Numbers.union Array.results (([_, s]) -> s.testsPassed), suiteSummaryByNamePairs
        suitesRun:
          suiteSummaryByNamePairs.length
        suitesPassed:
          suiteSummaryByNamePairs.length - failedSuiteSummaryByNamePairs.length
        failedSuiteSummaryByNamePairs
      }


  
# pairs = Map.pairs {
#   "suite 1": Map.pairs {
#     "test 1": ->
#       @equals 5, 5
#       @equals 5, 2
#       @equals 5, 3
#     "test 2": ->
#       @equals 5, 5
#       @equals 5, 5
#   }
# }

# run pairs, (summary) ->
#   console.log summary.failedSuiteSummaryByNamePairs