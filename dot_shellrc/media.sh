#!/usr/bin/env bash
# vim:ft=sh :

ydl() {
	if youtube-dl -f 'bestvideo[height<=720]+bestaudio[ext=m4a]/best[height<=720]' --recode-video mp4 --audio-format m4a --merge-output-format mp4 "$@"; then
		terminal-notifier -title "Video Download Finished" -sound default -message "$@"
	else
		terminal-notifier -title "Video Download Failed" -sound default -message "$@"
	fi
}

ymdl() {
	if youtube-dl -x --audio-format m4a --embed-thumbnail "$@"; then
		terminal-notifier -title "Audio Download Finished" -sound default -message "$@"
	else
		terminal-notifier -title "Audio Download Failed" -sound default -message "$@"
	fi
}
