{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

exports.text = 
text = (useFormatting, summary) ->
  green   = if useFormatting then '\x1B[32m' else ""
  red     = if useFormatting then "\x1B[31m" else ""
  normal  = if useFormatting then "\x1B[0m" else ""

  testSummaryText = (summary) ->
    Strings.interlayedUnion "\n", [
      "Spent #{summary.time}ms"
      "#{green}#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed#{normal}"
      
      if !Array.empty summary.messages
        Strings.union [
          red
          "Failed assertions:\n"
          Text.indented 2, Strings.multilineText summary.messages
          normal
        ]
    ]

  suiteSummaryText = (summary) ->
    Strings.interlayedUnion "\n", [
      "Spent #{summary.time}ms"
      "#{green}#{summary.testsPassed} of #{summary.testsRun} tests passed#{normal}"
      "#{green}#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed#{normal}"

      if !Array.empty summary.failedTestSummaryByNamePairs
        "Failed tests summaries:\n" +
        Text.indented 2, Strings.multilineText do ->
          for [name, summary] in summary.failedTestSummaryByNamePairs
            "Test `#{name}`\n" +
            Text.indented 2, testSummaryText summary
    ]

  Strings.interlayedUnion "\n", [
    "Spent #{summary.time}ms"
    "#{green}#{summary.suitesPassed} of #{summary.suitesRun} suites passed#{normal}"
    "#{green}#{summary.testsPassed} of #{summary.testsRun} tests passed#{normal}"
    "#{green}#{summary.assertionsPassed} of #{summary.assertionsRun} assertions passed#{normal}"
    if !Array.empty summary.failedSuiteSummaryByNamePairs
      "Failed suites summaries:\n" +
      Text.indented 2, Strings.multilineText do ->
        for [name, summary] in summary.failedSuiteSummaryByNamePairs
          "Suite `#{name}`\n" +
          Text.indented 2, suiteSummaryText summary
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
