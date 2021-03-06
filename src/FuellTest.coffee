{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
Runner = require "./FuellTest/Runner"
HarnessSummary = require "./FuellTest/HarnessSummary"
SuiteByNamePairs = require "./FuellTest/SuiteByNamePairs"


exports[k] = v for k, v of {
  # testDirectory: 
  #   Runner.testDirectory
  # testFile: 
  #   Runner.testFile
  runSuite: (format, name, testByNamePairs, cb) ->
    throw "Unimplemented: FuellTest.runSuite"
  runHarness: (format, name, suiteByNamePairs, cb) -> 
    SuiteByNamePairs.run suiteByNamePairs, (summary) -> 
      console.log HarnessSummary.text format, name, summary
      cb?()
  # multisuiteSummaryText  : HarnessSummary.text
