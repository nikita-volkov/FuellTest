{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Maps, Number, Numbers, Object, Optional, Optionals, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"


exports.markup =
markup = (options) ->
  basic = 
    if options.useFormatting
      reset       : "\x1B[0m"
      red         : "\x1B[31m"
      green       : "\x1B[32m"
      yellow      : "\x1B[33m"
      blue        : "\x1B[34m"
      magenta     : "\x1B[35m"
      cyan        : "\x1B[36m"
      bright      : "\x1B[1m"
      dimmed      : "\x1B[2m"
      underlined  : "\x1B[4m"
      inverse     : "\x1B[7m"
    else
      reset       : ""
      red         : ""
      green       : ""
      yellow      : ""
      blue        : ""
      magenta     : ""
      cyan        : ""
      bright      : ""
      dimmed      : ""
      underlined  : ""
      inverse     : ""

  styles = 
    header      : basic.reset 
    normal      : basic.reset + basic.dimmed
    failure     : basic.reset + basic.red
    success     : basic.reset + basic.green
    
  Map.union basic, styles