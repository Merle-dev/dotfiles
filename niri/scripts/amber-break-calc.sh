#!/bin/bash

notify-send -a "Calculation" $(fuzzel -d -p " λ " -w 45 -l 3 \
  --background-color=#261a1dcc \
  --input-color=#f0e9d5ff \
  --border-color=#00000000 | kalker -r )
