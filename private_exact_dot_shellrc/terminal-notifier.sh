#!/usr/bin/env bash
# vim:ft=sh :

if [ "$(uname)" = "Darwin" ]; then
	tn() {
		start_time=$(date +%s)
		"$@"
		end_time=$(date +%s)
		terminal-notifier -title "Job is done, Sir!" -subtitle $((end_time - start_time)) -appIcon /System/Library/PrivateFrameworks/PhotoLibraryPrivate.framework/Versions/A/Frameworks/PhotoPrintProduct.framework/Versions/A/Resources/alert-yellow_large.tiff -sound Frog -ignoreDnD -message "$@"
	}
fi
