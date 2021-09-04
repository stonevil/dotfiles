#!/usr/bin/env bash
# vim:ft=sh :

tm_cleanup() {
	tm_list=$(tmutil listlocalsnapshots / | awk -F '.' 'NF > 1 {print $4}')
	while IFS= read -r l; do
		sudo tmutil deletelocalsnapshots "$l"
	done <<<"$tm_list"
}
