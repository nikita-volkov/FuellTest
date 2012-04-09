{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

exports.text = 
text = (useFormatting, summary) ->
  reset    = if useFormatting then "\x1B[0m" else ""
  red      = if useFormatting then "\x1B[31m" else ""
  green    = if useFormatting then '\x1B[32m' else ""
  yellow   = if useFormatting then "\x1B[33m" else ""
  blue     = if useFormatting then "\x1B[34m" else ""
  magenta  = if useFormatting then "\x1B[35m" else ""
  cyan     = if useFormatting then "\x1B[36m" else ""

  testSummaryText = (summary) ->
    Strings.interlayedUnion "\n", [
      "Spent #{summary.time}ms"
      "#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed"
      if !Array.empty summary.messages
        Strings.union [
          "Failed assertions:\n"
          red
          Text.indented 2, Strings.multilineText summary.messages
          reset
        ]
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
              if summary.assertionsPassed == summary.assertionsRun then green
              else if summary.assertionsPassed > 0 then yellow
              else red
              "Test `#{name}`\n"
              Text.indented 2, testSummaryText summary
              reset
            ]
    ]

  Strings.interlayedUnion "\n", [
    "Spent #{summary.time}ms"
    "#{summary.suitesPassed} of #{summary.suitesRun} suites passed"
    "#{summary.testsPassed} of #{summary.testsRun} tests passed"
    "#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed"
    if !Array.empty summary.failedSuiteSummaryByNamePairs
      "Failed suites summaries:\n" +
      Text.indented 2, Strings.multilineText do ->
        for [name, summary] in summary.failedSuiteSummaryByNamePairs
          Strings.union [
            if summary.assertionsPassed == summary.assertionsRun then green
            else if summary.assertionsPassed > 0 then yellow
            else red
            "Suite `#{name}`\n" +
            Text.indented 2, suiteSummaryText summary
            reset
          ]
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
