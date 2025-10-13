#!/usr/bin/env bash
# vim:ft=bash

set -eu # Fail on errors or undeclared variables

asusctl profile -n && notify-send --hint=string:desktop-entry:rog-control-center "$(asusctl profile -p)"
