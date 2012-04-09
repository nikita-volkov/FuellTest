###
The whole thing could be titled EZTest, FuellTest
###
{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
{Path, Paths, Environment} = require "FuellSys"
Test = require "./RobustaTest/Test"
MultisuiteSummary = require "./RobustaTest/MultisuiteSummary"
SuiteByNamePairs = require "./RobustaTest/SuiteByNamePairs"
CoffeeScript  = require 'coffee-script'




exports[k] = v for k, v of {
  testDirectory: 
    Runner.testDirectory
  testFile: 
    Runner.testFile
  multisuiteSummaryText: 
    MultisuiteSummary.text

}