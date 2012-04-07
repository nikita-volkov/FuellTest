{exec} = require 'child_process'

task "run", "", ->
  compile -> npmInstall -> run "lib/Main.js", ->

npmInstall = (cb) ->
  exec1 "npm install", cb

compile = (cb) ->
  exec1 "coffee -c -o lib src", cb

run = (file, cb) ->
  exec1 "node #{file}", cb

exec1 = (cmd, cb) ->
  exec cmd, (err, stdout, stderr) ->
    if err 
      console.error err.stack
    else if stdout || stderr
      console.log stdout + stderr 
      cb?()