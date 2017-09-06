#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

case $STATE in
        "MASTER") echo "$STATE" > /etc/keepalived/state
                  exit 0
                  ;;
        "BACKUP") echo "$STATE" > /etc/keepalived/state
                  exit 0
                  ;;
        "FAULT")  echo "$STATE" > /etc/keepalived/state
                  echo 0
                  ;;
        *)        echo "$STATE" > /etc/keepalived/state
                  exit 1
                  ;;
esac
