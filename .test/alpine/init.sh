#!/usr/bin/env bash
# vim:ft=sh

limactl shell docker docker run -it --rm -v $PWD:/root/.local/share/chezmoi -v $PWD/.test/alpine/repositories:/etc/apk/repositories alpine:edge sh -c "/root/.local/share/chezmoi/.test/alpine/test.sh"
