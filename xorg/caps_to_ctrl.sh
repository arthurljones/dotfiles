#!/bin/bash
sleep 1
DISPLAY=":0.0"
HOME=/home/aj/
XAUTHORITY=$HOME/.Xauthority
export DISPLAY XAUTHORITY HOME

#setxkbmap -layout dvorak
setxkbmap -option ctrl:nocaps
