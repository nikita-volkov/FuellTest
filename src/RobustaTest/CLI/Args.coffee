{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Numbers, Object, Optional, Optionals, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

# exports.settings = 
# settings = (args) ->
#   if String.doesMatch /^[^-]/, args[0] 
#     if Path.dirExists
#       dir = args[0]
#     else if Path.fileExists
#       file = args[0]
#   {
#     dir
#     file
#     noFormatting:
#       Array.contains "--no-formatting", args
#   }



# parsing = (args) ->
#   target:
#     args[0] if String.doesMatch /^[^-]/, args[0]
#   noFormatting:
#     Array.contains "--no-formatting", args
# exports.settings = 
# settings = (args) ->
#   p = parsing args
#   {
#     dir: 
#       if p.target?
#         p.target if Path.dirExists p.target 
#       else "test"
#     file: 
#       p.target if p.target? && Path.fileExists p.target
#     useFormatting:
#       !p.noFormatting
#   }


exports.settings = 
settings = (args) ->
  target:
    args[0] if String.doesMatch /^[^-]/, args[0]
  noFormatting:
    Array.contains "--no-formatting", args
