#!/usr/bin/env bash
# vim:ft=sh :

npm config set prefix "${HOME}/.local/npm-packages"
export NPM_PACKAGES="${HOME}/.local/npm-packages"
