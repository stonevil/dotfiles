#!/usr/bin/env bash
# vim:ft=sh :

ydl() {
	if youtube-dl -f 'bestvideo[height<=720]+bestaudio[ext=m4a]/best[height<=720]' --recode-video mp4 --audio-format m4a --merge-output-format mp4 "$@"; then
		terminal-notifier -title "Video Download" -subtitle 'Video download finished' -appIcon /System/Library/PrivateFrameworks/PhotoPrintProduct.framework/Versions/A/Resources/alert-yellow_large.tiff -sound Hero -ignoreDnD -message "$@"
	else
		terminal-notifier -title "Video Download" -subtitle 'Video download failed' -appIcon /System/Library/PrivateFrameworks/PhotoPrintProduct.framework/Versions/A/Resources/alert-yellow_large.tiff -sound Hero -ignoreDnD -message "$@"
	fi
}

ymdl() {
	if youtube-dl -x --audio-format m4a --embed-thumbnail "$@"; then
		terminal-notifier -title "Audio Download" -subtitle 'Audio download finished' -appIcon /System/Library/PrivateFrameworks/PhotoPrintProduct.framework/Versions/A/Resources/cloud_download_image.png -sound Hero -ignoreDnD -message "$@"
	else
		terminal-notifier -title "Audio Download" -subtitle 'Audio download failed' -appIcon /System/Library/PrivateFrameworks/PhotoPrintProduct.framework/Versions/A/Resources/cloud_download_image.png -sound Hero -ignoreDnD -message "$@"
	fi
}
