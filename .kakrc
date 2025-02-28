define-command kill-server %{
  echo :KILLING SERVER:
  nop %sh{lsof -i tcp:8033 | tail -n 1 | awk '{print $2}' | xargs kill -9}
  echo :SERVER IS F:
}

define-command run-debug %{
  echo :TURNING SERVER ON:
  eval -try-client tools %{kakpipe -S -w -- sh -c "python main.py --host localhost --port 8033"}
}

define-command rest %{
  echo :OPENING REST:
  eval -try-client tools %{
    edit api.rest
  }
}

define-command test %{
  eval -try-client tools %{echo not implemented}
}

define-command runB %{
  kill-server
  run-debug
}

define-command prompt-commands %{
  peneira "DO: " %{
printf "ide
runB
kill-server
rest"
  } %{
    eval %arg{1}
  }
}

map global user j ': prompt-commands<ret>'
