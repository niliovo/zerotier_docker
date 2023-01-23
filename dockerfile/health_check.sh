#!/bin/bash

function check
{

  judge=$(ps -ef | grep zerotier | grep -v grep | wc -l)
  [ $judge -eq 0 ] && echo "exit 1"

  judge=$(ps -ef | grep ztncui | grep -v grep | wc -l)
  [ $judge -eq 0 ] && echo "exit 1"

  echo "exit 0"
}

check "$@"