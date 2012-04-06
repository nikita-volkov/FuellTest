
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
      # failedStatusByMessageMap: {}
      assertions: tec.assertions
      failures: tec.failures
      time: Date.now() - startTime

  if tec.openAsyncCalls > 0 
    tec.allAsyncCallsClosedCallback = cb1
  else cb1()

  return
  # if tec.passed + tec.failed == tec.assertions then cb1()
  # else tec.assertionCloseCallback = cb1


class TestExecutionContext
  assertions: 0
  failures: []
  todo: -> 
    @failures.push "TODO"
  assert: (condition, msg) ->
    @assertions++
    if not condition then @failures.push msg
  ok: (x) ->
    @assert x, "`#{x}` is not ok"
  empty: (x) ->
    @assert (Object.empty x), "`#{x}` is not empty"
  isTrue: (x) -> 
    @assert x == true, "`#{x}` is not true"
  isNull: (x) ->
    @assert !x?, "`#{x}` is not null"
  equals: (expected, actual) ->
    @assert (Object.equals expected, actual), "`#{actual}` does not equal `#{expected}`"
  contains: (y, x) ->
    @assert (Array.contains y, x), "`#{x}` does not contain `#{y}`"
  elementOf: (y, x) ->
    @assert (Array.elementOf y, x), "`#{x}` is not an element of `#{y}`"
  partOf: (y, x) ->
    @assert (Array.partOf y, x), "`#{x}` is not a part of `#{y}`"
  includes: (y, x) ->
    @assert (Array.includes y, x), "`#{x}` does not include `#{y}`"
  instanceOf: (y, x) ->
    @assert (Object.instanceOf y, x), "`#{x}` is not an instance of `#{y}`"
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
    @openAsyncCall()
    Action.checkCallsBackIn msecs, action, (result) -> 
      @assert result, "Action does not call back in #{msecs}ms"
      @closeAsyncCall()

  

  # resultEquals: (expected, action) ->
  #   @expectResultTo [Object.equals, expected], action, "does not equal `#{expected}`"
  resultEquals: 
    resultBinaryAssertion "does not equal", Object.equals
  resultContains: 
    resultBinaryAssertion "does not contain", Array.contains
  # resultEquals: (y, action) ->
  #   assertResult [Object.equals, y], action, "does not equal"




  allAsyncCallsClosedCallback: ->
  openAsyncCalls: 0
  openAsyncCall: ->
    @openAsyncCalls ++
  closeAsyncCall: ->
    @openAsyncCalls --
    if @openAsyncCalls == 0 then @allAsyncCallsClosedCallback()
    else if @openAsyncCalls < 0 then throw "Unexpected async call closure"


unaryAssertion = (partialMsg, predicate) ->
  (x) -> assert (predicate x), "`#{x}` #{partialMsg}"

binaryAssertion = (partialMsg, predicate) ->
  (y, x) -> assert (predicate y, x), "`#{x}` #{partialMsg} `#{y}`"

assert = Function.composable (condition, msg) ->
  @assertions ++
  if not condition
    @failures.push msg


resultUnaryAssertion = (partialMsg, predicate) ->
  (action) ->
    assertResult predicate, partialMsg, action

resultBinaryAssertion = (partialMsg, predicate) ->
  (y, action) ->
    assertResult [predicate, y], "#{partialMsg} `#{y}`", action

assertResult = Function.composable (predicate, partialMsg, action) ->
  @assertions ++

  calledBack = false
  timedOut = false
  @openAsyncCall()
  action (x) -> 
    if not timedOut
      calledBack = true
      if not predicate x
        @failures.push "Action result `#{x}` #{partialMsg}"
      @closeAsyncCall()
  setTimeout(
    ->
      if not calledBack
        timedOut = true
        @failures.push "Action has not called back in 10s"
        @closeAsyncCall()
    10000
  )


