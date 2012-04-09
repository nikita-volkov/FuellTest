{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Numbers, Object, Optional, Optionals, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
{Path, Paths, Environment} = require "FuellSys"
Test = require "./Test"
MultisuiteSummary = require "./MultisuiteSummary"
SuiteByNamePairs = require "./SuiteByNamePairs"
CoffeeScript  = require 'coffee-script'


exports.testDirectory = 
testDirectory = (useFormatting, path, cb) ->
  files = Paths.byExtension "coffee", Path.deepPaths path
  suiteByNamePairs = 
    Array.results(
      (p) -> [
        Path.relativeTo path + "/", Path.withoutExtension p
        Map.pairs fileTests p
      ]
      files
    )
  SuiteByNamePairs.run suiteByNamePairs, (summary) ->
    console.log MultisuiteSummary.text useFormatting, summary
    cb?()

exports.testFile = 
testFile = (useFormatting, path, cb) ->
  throw "Unimplemented: Runner.testFile"


fileTests = (file) ->
  Object.member "tests", coffeeScriptExports file

coffeeScriptExports = (file) ->
  CoffeeScript = require "coffee-script"
  code = Path.fileContents file
  js = CoffeeScript.compile code, {filename: file}
  js = js + "\nreturn exports;"
  require.main._compile js
