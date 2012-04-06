{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"
Assertions = require "./FueLTesting/Assertion"


# startTime   = Date.now()
# currentFile = null
# passedTests = 0
# failures    = []


# exports.test = (description, fn) ->
#   try
#     fn.test = {description, currentFile}
#     fn.call(fn)
#     ++passedTests
#   catch e
#     e.description = description if description?
#     e.source      = fn.toString() if fn.toString?
#     failures.push filename: currentFile, error: e


# robusta test/FueLTest.robusta
# srcDirs: ["test", "src"]


exports.run = 
run = (suite, testsDeclaration) ->
  startTime   = Date.now()
  passedTests = 0
  failures    = []
  test = (description, fn) ->
    try
      fn.test = {description, suite}
      fn.call(fn)
      ++passedTests
    catch e
      e.description = description if description?
      e.source      = fn.toString() if fn.toString?
      failures.push 
        suite: suite
        error: e

###
Fuell testing library.

Makes testing simple. It does not fall into the trend of verbosely describing every detail of your test as most modern testing frameworks do, instead it relies on self-describing assertion function names which themselves produce meaningful messages.

As fast as possible. Runs all your tests parallelly.

Supports testing of asynchronous functions with callbacks.

###



exports.runTestSuites = 
runTestSuites = (suiteByNameMap, cb) ->
  ###
  Parallelly runs all test suites, summarizing the results and passing them to the callback.

  Is intended to be used for running all test suites of the project.
  ###
  throw "todo"


exports.runTestSuite =
runTestSuite = (testByNameMap, cb) ->
  ###
  Parallelly calls all tests, summarizing the results and passing them to the callback.
  ###
  startTime = Date.now()
  Map.collect runTest, testByNameMap, (testSummaryByNameMap) ->
    cb {
      testSummaryByNameMap
      time: Date.now() - startTime
    }






class TestSuite
  startTime: Date.now()
  constructor: (declarationByNameMap) ->
    @testByNamePairs = 
      for name, declaration of declarationByNameMap
        [
          name
          new Test declaration
        ]
  run: (cb) ->
    timedOut = false
    finished = false
    setTimeout(
      ->
        timedOut = true
        cb() if !finished 
      10000
    )
    for test in tests
      test.run ->
        @finishedTests.push test
        if @finishedTests.length == @tests.length
          finished = true
          cb() if !timedOut




class Test
  constructor: (@declaration) ->
    @startTime = Date.now()
    @failures = []
    @assertions = 0
    @unfinishedAsyncCalls = 0
  run: (@exitCallback) ->
    @declaration.call @
    tryToExit()
  tryToExit: ->
    if @unfinishedAsyncCalls <= 0
      @exitCallback()
  assert: (condition, msg) ->
    @assertions++
    if not condition then @failures.push msg
  equals: (y, x) ->
    @assert (Object.equals y, x), "does not equal"
  callsBackIn: (msecs, action) ->
    @unfinishedAsyncCalls++
    Action.checkCallsBackIn msecs, action, (result) =>
      @unfinishedAsyncCalls--
      @assert result, "Action does not call back in #{msecs}ms"
      @tryToExit()