#!/usr/bin/env bash
# vim:ft=sh :

# TODO
# 1. Rebuild logic for python pip and gems. Use Pipfile and Gemsfile only for major packages. Handle properly version ==

nvim_plugins_update() {
	if command -v nvim >/dev/null; then
		nvim +PlugInstall! +PlugClean! +PlugUpdate! +UpdateRemotePlugins +qall
	fi
}

gcloud_plugins_update() {
	if command -v gcloud >/dev/null; then
		yes Y | gcloud components update
	fi
}

krew_plugins_update() {
	if command -v kubectl-krew >/dev/null; then
		kubectl-krew update && kubectl-krew upgrade
	fi
}

#if command -v pip3 >/dev/null; then
#  pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
#fi
#
#if command -v gem >/dev/null; then
#  cd "$HOME"/.Files || exit
#  gem update $(gem outdated | cut -d ' ' -f 1)
#  cd "$HOME" || exit
#fi

tmux_plugins_update() {
	if [ -d "$HOME"/.tmux/plugins ]; then
		for plugin in "$HOME"/.tmux/plugins/*; do
			if [ -d "$plugin" ]; then
				cd "$plugin" || exit
				if [ -d '.git' ]; then
					git pull
				fi
			fi
		done
		tmux source-file ~/.tmux.conf
	fi
}

packages_update() {
	if [ "$(uname)" = "Darwin" ]; then
		brew update && brew upgrade && brew upgrade --cask && brew cleanup && brew autoremove
	fi

	if [ "$(uname)" = "Linux" ]; then
		if command -v pacman >/dev/null; then
			sudo pacman --noconfirm -Syu "$(pacman -Qq)"
		fi
	fi
}

update_all() {
	packages_update
	tmux_plugins_update
	gcloud_plugins_update
	krew_plugins_update
	nvim_plugins_update
}
