#!/usr/bin/env bash
# vim:ft=sh :

ydl() {
	cd "$HOME"/Downloads || exit 1
	video_title=$(youtube-dl --skip-download --get-title --no-warnings "$@" | sed 2d)
	if yt-dlp -f 'bestvideo[height<=720]+bestaudio[ext=m4a]/best[height<=720]' --recode-video mp4 --audio-format m4a --merge-output-format mp4 "$@"; then
		terminal-notifier -title "Video Download Finished" -sound default -message "$video_title"
	else
		terminal-notifier -title "Video Download Failed" -sound default -message "$video_title"
	fi
}

ymdl() {
	cd "$HOME"/Downloads || exit 1
	video_title=$(youtube-dl --skip-download --get-title --no-warnings "$@" | sed 2d)
	if yt-dlp -x --audio-format m4a --embed-thumbnail "$@"; then
		terminal-notifier -title "Video Download Finished" -sound default -message "$video_title"
	else
		terminal-notifier -title "Video Download Failed" -sound default -message "$video_title"
	fi
}
