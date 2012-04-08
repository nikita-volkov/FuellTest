{Action, Actions, Array, Arrays, Environment, Function, FunctionByLengthMap, FunctionByTypesPairs, FunctionTemplate, Keys, Map, Number, Object, Optional, Pair, Pairs, RegExp, Set, SortedArray, String, Strings, Text} = require "Fuell"

exports.text = 
text = (useFormatting, summary) ->
  green   = if useFormatting then "\\033[32m" else ""
  red     = if useFormatting then "\\033[31m" else ""
  normal  = if useFormatting then "\\033[0m" else ""

  testSummaryText = (summary) ->
    Strings.interlayedUnion "\n", [
      "#{green}#{summary.assertionsPassed} of #{summary.assertions} assertions passed#{normal}"
      
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
      "#{green}#{summary.testsPassed} of #{summary.tests} tests passed#{normal}"
      if !Array.empty summary.failedTestByNamePairs
        "Failed tests:\n" +
        Text.indented 2, Strings.multilineText do ->
          for [name, summary] in summary.failedTestByNamePairs
            "Test `#{name}` summary\n" +
            Text.indented 2, testSummaryText summary
    ]

  Strings.interlayedUnion "\n", [
    "#{green}#{summary.suitesPassed} of #{summary.suites} suites passed#{normal}"
    if !Array.empty summary.failedSuiteByNamePairs
      "Failed suites:\n" +
      Text.indented 2, Strings.multilineText do ->
        for [name, summary] in summary.failedSuiteByNamePairs
          "Suite `#{name}` summary\n" +
          Text.indented 2, suiteSummaryText summary
  ]

# console.log text false, 
#   suites: 1
#   suitesPassed: 0
#   failedSuiteByNamePairs: [
#     ["suite 1", {
#       tests: 2
#       testsPassed: 1
#       failedTestByNamePairs: [
#         ["test 1", {
#           assertions: 1
#           assertionsPassed: 1
#           messages: [
#             "some assertion failure message"
#           ]
#         }]
#       ]
#     }]
#   ]
