#!/usr/bin/env bash
# vim:ft=sh :

if [ "$(uname)" = "Darwin" ]; then
	darkmode() {
		# shellcheck disable=SC2046,SC2145
		defaults write $(osascript -e 'id of app "'"$@"'"' | tr -d '\n' | tr -d '\r') NSRequiresAquaSystemAppearance -bool FALSE
		# shellcheck disable=SC2145
		if command -v terminal-notifier >/dev/null; then
			terminal-notifier -title "The Empire Strikes Back" -subtitle 'Embrace the Dark Side, Luke' -appIcon /System/Library/PrivateFrameworks/PhotoLibraryPrivate.framework/Versions/A/Frameworks/PhotoPrintProduct.framework/Versions/A/Resources/alert-yellow_large.tiff -sound Hero -ignoreDnD -message "Use your $@"
		fi
	}

	darkmodeoff() {
		# shellcheck disable=SC2046,SC2145
		defaults delete $(osascript -e 'id of app "'"$@"'"' | tr -d '\n' | tr -d '\r') NSRequiresAquaSystemAppearance
		# shellcheck disable=SC2145
		if command -v terminal-notifier >/dev/null; then
			terminal-notifier -title "A New Hope" -subtitle 'I felt a great disturbance in the Force' -appIcon /System/Library/PrivateFrameworks/PhotoLibraryPrivate.framework/Versions/A/Frameworks/PhotoPrintProduct.framework/Versions/A/Resources/alert-yellow_large.tiff -sound Hero -ignoreDnD -message "Use your $@"
		fi
	}
fi
