#!/usr/bin/env bash
# vim:ft=sh :

npm config set prefix "${HOME}"/.local
export NPM_PACKAGES="${HOME}"/.local
