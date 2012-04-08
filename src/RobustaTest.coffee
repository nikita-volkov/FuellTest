###
The whole thing could be titled EZTest, FuellTest
###
{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
{Path, Paths, Environment} = require "FuellSys"
Test = require "./RobustaTest/Test"
TotalSummary = require "./RobustaTest/TotalSummary"
SuiteByNamePairs = require "./RobustaTest/SuiteByNamePairs"
CoffeeScript  = require 'coffee-script'



# totalSummaryText = TotalSummary.text
# runCommand = Command.run

exports.testDirectory = 
testDirectory = (dir, cb) ->
  files = Paths.byExtension "coffee", Path.deepPaths dir
  suiteByNamePairs = 
    Array.results(
      (p) -> [
        Path.relativeTo dir + "/", Path.withoutExtension p
        Map.pairs fileTests p
      ]
      files
    )
  SuiteByNamePairs.run suiteByNamePairs, (summary) ->
    console.log TotalSummary.text false, summary


fileTests = (file) ->
  Object.member "tests", coffeeScriptExports file

coffeeScriptExports = (file) ->
  CoffeeScript = require "coffee-script"
  code = Path.fileContents file
  js = CoffeeScript.compile code, {filename: file}
  js = js + "\nreturn exports;"
  require.main._compile js
