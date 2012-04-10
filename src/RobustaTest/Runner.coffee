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
  code = Path.fileContents file
  js = CoffeeScript.compile code, {filename: file}
  jsCodeExports file, js

jsCodeExports = (path, code) ->
  ###
  Fairly stolen from coffeescript
  ###
  code = code + "\nreturn exports;"

  mainModule = require.main

  # Set the filename.
  mainModule.filename = path

  # Clear the module cache.
  mainModule.moduleCache and= {}

  # Assign paths for node_modules loading
  mainModule.paths = require('module')._nodeModulePaths Path.dir path

  mainModule._compile code, mainModule.filename