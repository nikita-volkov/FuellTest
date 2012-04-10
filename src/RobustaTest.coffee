{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
Runner = require "./RobustaTest/Runner"
MultisuiteSummary = require "./RobustaTest/MultisuiteSummary"
SuiteByNamePairs = require "./RobustaTest/SuiteByNamePairs"


exports[k] = v for k, v of {
  testDirectory: 
    Runner.testDirectory
  testFile: 
    Runner.testFile
  runSuites: (format, suites, cb) -> 
    SuiteByNamePairs.run suites, (summary) -> 
      console.log MultisuiteSummary.text format, summary
      cb?()
  # multisuiteSummaryText  : MultisuiteSummary.text
}