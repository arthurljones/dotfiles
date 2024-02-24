#!/bin/bash
cd $(dirname $(readlink -f $0))
source common.sh
startup

# TODO
sleep 1

shutdown
