#!/bin/sh
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
HOSTNAME=$(hostname)
. $SCRIPTPATH/$HOSTNAME.sh
