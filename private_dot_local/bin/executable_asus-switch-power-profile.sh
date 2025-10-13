#!/usr/bin/env bash
# vim:ft=bash

set -eu # Fail on errors or undeclared variables

profile=$(kdialog --radiolist "Select Power Profile:" Performance "Performance" on Balanced "Balanced" off Quiet "Quiet" off)

asusctl profile -P $profile && notify-send --hint=string:desktop-entry:rog-control-center $profile
