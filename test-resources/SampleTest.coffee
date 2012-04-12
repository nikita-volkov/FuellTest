

exports.tests = 
  "a failing 'a, b' test": ->
    @equals "a", "b"
  "a failing test with some successfull assertions": ->
    @equals 1, 1
    @equals 2, 1
