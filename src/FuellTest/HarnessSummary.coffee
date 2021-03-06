{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

exports.text = 
text = (pretty, name, summary) ->
  reset       = if pretty then "\x1B[0m" else ""
  red         = if pretty then "\x1B[31m" else ""
  green       = if pretty then '\x1B[32m' else ""
  yellow      = if pretty then "\x1B[33m" else ""
  blue        = if pretty then "\x1B[34m" else ""
  magenta     = if pretty then "\x1B[35m" else ""
  cyan        = if pretty then "\x1B[36m" else ""
  bright      = if pretty then "\x1B[1m" else ""
  dimmed      = if pretty then "\x1B[2m" else ""
  underlined  = if pretty then "\x1B[4m" else ""
  inverse     = if pretty then "\x1B[7m" else ""

  success = summary.suitesPassed == summary.suitesRun

  failureHeader  = reset + yellow
  successHeader  = reset + green
  normal         = reset + dimmed 
  error          = reset + red


  testSummaryText = (summary) ->
    Strings.interlayedUnion "\n", [
      "Spent #{summary.time}ms"
      "#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed"
      if !Array.empty summary.messages
        "Failed assertions:\n" +
        error +
        Text.indented 2, Strings.multilineText summary.messages
    ]

  suiteSummaryText = (summary) ->
    Strings.interlayedUnion "\n", [
      "Spent #{summary.time}ms"
      "#{summary.testsPassed} of #{summary.testsRun} tests passed"
      "#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed"

      if !Array.empty summary.failedTestSummaryByNamePairs
        "Failed tests summaries:\n" +
        Text.indented 2, Strings.multilineText do ->
          for [name, summary] in summary.failedTestSummaryByNamePairs
            Strings.union [
              if summary.assertionsPassed == summary.assertionsRun
                "#{successHeader}Test `#{name}` passed\n"
              else
                "#{failureHeader}Test `#{name}` failed\n"
              normal 
              Text.indented 2, testSummaryText summary
            ]
    ]

  Strings.union [
    if summary.assertionsPassed == summary.assertionsRun
      "#{successHeader}Testing harness `#{name}` passed\n"
    else
      "#{failureHeader}Testing harness `#{name}` failed\n"
    
    normal
    Text.indented 2, Strings.interlayedUnion "\n", [
      "Spent #{summary.time}ms"
      "#{summary.suitesPassed} of #{summary.suitesRun} suites passed"
      "#{summary.testsPassed} of #{summary.testsRun} tests passed"
      "#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed"
      if !Array.empty summary.failedSuiteSummaryByNamePairs
        "Failed suites summaries:\n" +
        Text.indented 2, Strings.multilineText do ->
          for [name, summary] in summary.failedSuiteSummaryByNamePairs
            Strings.union [
              if summary.assertionsPassed == summary.assertionsRun
                "#{successHeader}Suite `#{name}` passed\n"
              else
                "#{failureHeader}Suite `#{name}` failed\n"
              normal 
              Text.indented 2, suiteSummaryText summary
            ]
    ] 

    reset
  ]


# console.log text false, 
#   time: 1000
#   suites: 1
#   suitesPassed: 0
#   failedSuiteByNamePairs: [
#     ["suite 1", {
#       time: 10
#       tests: 2
#       testsPassed: 1
#       failedTestByNamePairs: [
#         ["test 1", {
#           time: 1
#           assertions: 1
#           assertionsPassed: 1
#           messages: [
#             "some assertion failure message"
#           ]
#         }]
#       ]
#     }]
#   ]
