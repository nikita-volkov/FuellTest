{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

exports.run = 
run = (f, cb) ->
  ###
  Calls the function with a new test execution context, summarizing the results and passing them to the callback. 
  ###

  tec = new TestExecutionContext
  startTime = Date.now()
  f.call tec

  cb1 = ->
    cb 
      assertions: tec.assertions
      failures: tec.failures
      time: Date.now() - startTime

  if tec.openAsyncCalls > 0 
    tec.allAsyncCallsClosedCallback = cb1
  else cb1()

  return





unaryAssertion = (partialMsg, predicate) ->
  (x) -> @assert (predicate x), "`#{x}` #{partialMsg}"

binaryAssertion = (partialMsg, predicate) ->
  (y, x) -> @assert (predicate y, x), "`#{x}` #{partialMsg} `#{y}`"

unaryResultAssertion = (partialMsg, predicate) ->
  (action, timeout) ->
    @assertAsync predicate, action, partialMsg, timeout

binaryResultAssertion = (partialMsg, predicate) ->
  (y, action, timeout) ->
    @assertAsync [predicate, y], action, "#{partialMsg} `#{y}`", timeout



class TestExecutionContext
  failures: []

  assertions: 0
  assert: (condition, msg) ->
    @assertions++
    if not condition then @failures.push msg

  openAsyncCalls: 0
  allAsyncCallsClosedCallback: ->
  assertAsync: 
    Function.composable (predicate, action, partialMessage, timeout = 100) ->
      @assertions++
      @openAsyncCalls++


      closeAsyncCall = =>
        @openAsyncCalls--
        if @openAsyncCalls == 0 then @allAsyncCallsClosedCallback()
        else if @openAsyncCalls < 0 then throw "Unexpected async call closure"

      calledBack = false
      timedOut = false
      action (x) =>
        if not timedOut
          calledBack = true
          if not predicate x
            @failures.push "Action result `#{x}` #{partialMessage}"
          closeAsyncCall()
      setTimeout(
        =>
          if not calledBack
            timedOut = true
            @failures.push "Action has not called back in #{timeout}ms"
            closeAsyncCall()
        timeout
      )

  ok: (x) ->
    @assert x, "`#{x}` is not ok"
  empty: (x) ->
    @assert (Object.empty x), "`#{x}` is not empty"
  isTrue: (x) -> 
    @assert x == true, "`#{x}` is not true"
  isNull: (x) ->
    @assert !x?, "`#{x}` is not null"
  equals: (y, x) ->
    @assert (Object.equals y, x), "`#{x}` does not equal `#{y}`"
  contains: (y, x) ->
    @assert (Array.contains y, x), "`#{x}` does not contain `#{y}`"
  elementOf: (y, x) ->
    @assert (Array.elementOf y, x), "`#{x}` is not an element of `#{y}`"
  includes: (y, x) ->
    @assert (Array.includes y, x), "`#{x}` does not include `#{y}`"
  partOf: (y, x) ->
    @assert (Array.partOf y, x), "`#{x}` is not a part of `#{y}`"
  instanceOf: (y, x) ->
    @assert (Object.instanceOf y, x), "`#{x}` is not an instance of `#{y}`"
  todo: -> 
    @assert false, "TODO"
  fails: (f) ->
    @assert(
      do ->
        try
          f()
          false
        catch e
          true
      "Function does not fail"
    )

  callsBackIn: (msecs, action) ->
    @assertAsync (-> true), action, "", msecs

  resultIsOk: 
    unaryResultAssertion "is not ok", Object.self
  resultIsEmpty: 
    unaryResultAssertion "is not empty", Object.empty
  resultIsNull:
    unaryResultAssertion "is not null", Object.isNull
  resultEquals: 
    binaryResultAssertion "does not equal", Object.equals
  resultContains: 
    binaryResultAssertion "does not contain", Array.contains
  resultIsElementOf:
    binaryResultAssertion "is not an element of", Object.elementOf
  resultIncludes:
    binaryResultAssertion "does not include", Array.includes
  resultIsPartOf:
    binaryResultAssertion "is not a part of", Array.partOf
  resultIsInstanceOf:
    binaryResultAssertion "is not an instance of", Object.instanceOf
