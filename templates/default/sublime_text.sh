#!/bin/bash
if [[ "$OSTYPE" =~ "darwin" ]]; then
  open -a /Applications/Sublime\ Text\ 2.app $@
else
  /usr/local/bin/subl $@  </dev/null >/dev/null 2>&1 &
fi
