{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
{Path} = require "FuellSys"
Runner = require "./RobustaTest/Runner"


settings = do ->
  args = Array.dropping 2, process.argv

  target:
    if args[0] && String.doesMatch /^[^-]/, args[0] then args[0]
    else "test"
  format:
    Array.containsAnyOf ["--format", "-f"], args


if Path.dirExists settings.target
  Runner.testDirectory settings.format, settings.target, ->
else if Path.fileExists settings.target
  Runner.testFile settings.format, settings.target, ->
else
  throw "Path `#{settings.target}` does not exist"

