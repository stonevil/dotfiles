#!/usr/bin/env bash
# vim:ft=sh :

ydl() {
	youtube-dl -f 'bestvideo[height<=720]+bestaudio[ext=m4a]/best[height<=720]' --recode-video mp4 --audio-format m4a --merge-output-format mp4 "$@"
}

ymdl() {
	youtube-dl -x --audio-format m4a --embed-thumbnail "$@"
}
