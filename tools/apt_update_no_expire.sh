#!/bin/sh
#Does an apt-get update without checking if the data is past it's pull-by
#date. Useful when we're using a past-EOL distro and are pointed at archived
#package repos.
apt-get -o Acquire::Check-Valid-Until=false update
