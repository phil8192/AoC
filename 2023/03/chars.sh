#!/bin/bash
# eh
cat input.txt               \
  |sed 's/./\0\n/g'         \
  |sort                     \
  |uniq                     \
  |grep -v "[0-9]"          \
  |grep -v "\."             \
  |tail -n+2                \
  |awk '{print "\""$1"\""}' \
  |paste -sd,
