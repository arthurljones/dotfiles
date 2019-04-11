#!/bin/bash
xfce4-settings-manager -d panel-preferences &
sleep 0.2
kill $!
