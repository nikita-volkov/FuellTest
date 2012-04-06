{Action, Actions, Array, Arrays, Environment, Function, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, SortedArray, String, Strings} = require "./FueL"
Assert = require "assert"

unaryAssertion = (partialMsg, p) ->
  (x) -> Assert.ok (p x), "`#{x}` #{partialMsg}"

binaryAssertion = (partialMsg, p) ->
  (y, x) -> Assert.ok (p y, x), "`#{x}` #{partialMsg} `#{y}`"

functionFails = (f) ->
  try
    f()
    false
  catch e
    true
    
exports[k] = v for k, v of {
  ok           : unaryAssertion "is not ok", Object.self
  isTrue       : unaryAssertion "is not true", (x) -> x == true
  empty        : unaryAssertion "is not empty", Object.empty
  isNull       : unaryAssertion "is not null", Object.isNull
  equals       : binaryAssertion "does not equal", Object.equals
  contains     : binaryAssertion "does not contain", Array.contains
  elementOf    : binaryAssertion "is not an element of", Object.elementOf
  partOf       : binaryAssertion "is not a part of", Array.partOf
  includes     : binaryAssertion "does not include", Array.includes
  instanceOf   : binaryAssertion "is not an instance of", Object.instanceOf
  fails        : unaryAssertion "does not fail", functionFails
  todo         : -> throw "todo"
  callsBackIn  : (msecs, action) ->
    Action.checkCallsBackIn msecs, action, (result) -> 

}



# exports[k] = v for k, v of {
#   ok                  : Assert.ok
#   mustBeOk            : Assert.ok
#   mustBeTrue          : Assert.ok
#   mustEqual           : binaryAssertion Object.equals, "does not equal"
#   mustContain         : binaryAssertion Array.contains, "does not contain"
#   mustBeAnElementOf   : binaryAssertion Object.elementOf, "is not an element of"
#   mustBeAPartOf       : binaryAssertion Array.partOf, "is not a part of"
#   mustInclude         : binaryAssertion Array.includes, "does not include"
#   mustBeAnInstanceOf  : binaryAssertion Object.instanceOf, 
#                         "is not an instance of"
#   mustFail            : unaryAssertion fails, "does not fail"
#   todo                : -> throw "TODO"
# }

