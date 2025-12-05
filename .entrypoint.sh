#!/usr/bin/env sh
# vim:ft=sh

# trap '' SIGINT

if command -v "pacman" >/dev/null 2>&1; then
	echo "Arch Linux. Install bare minimal packages"
	sudo sed -i '/^ID=/s/archarm/arch/' /etc/os-release # just in case for ARM64 ArchLinux
	sudo pacman-key --init
	sudo pacman --noconfirm --needed --sync --refresh --sysupgrade sudo bash curl git rsync neovim
fi

if command -v "dnf" >/dev/null 2>&1; then
	echo "Fedora. Install bare minimal packages"
	sudo dnf update -y && dnf install -y sudo bash curl git rsync vim
fi

# Create aliases to simplify testing
echo 'rsync --exclude ".git/" --exclude ".stignore" -avz /Users/${USER}/.local/share/chezmoi /home/${USER}.linux/.local/share/' | sudo tee /usr/bin/cu && sudo chmod 755 /usr/bin/cu
echo '${HOME}/.local/bin/chezmoi execute-template < $@ | more' | sudo tee /usr/bin/cm && sudo chmod 755 /usr/bin/cm
echo '${HOME}/.local/bin/chezmoi execute-template < $@ | bash -x -' | sudo tee /usr/bin/cx && sudo chmod 755 /usr/bin/cx
echo '${HOME}/.local/bin/chezmoi execute-template' | sudo tee /usr/bin/ct && sudo chmod 755 /usr/bin/ct
echo '${HOME}/.local/bin/chezmoi init' | sudo tee /usr/bin/ci && sudo chmod 755 /usr/bin/ci
echo '${HOME}/.local/bin/chezmoi apply' | sudo tee /usr/bin/ca && sudo chmod 755 /usr/bin/ca
echo '${HOME}/.local/bin/chezmoi apply -R' | sudo tee /usr/bin/ce && sudo chmod 755 /usr/bin/ce
echo '${HOME}/.local/bin/chezmoi state reset' | sudo tee /usr/bin/creset && sudo chmod 755 /usr/bin/creset
sudo ln -s /usr/bin/nvim /usr/bin/v
sudo ln -s /usr/bin/nvim /usr/bin/vi
sudo ln -s /usr/bin/nvim /usr/bin/vim

grep -qF "PATH" ${HOME}/.bashrc || echo PATH=${HOME}/.local/bin:${PATH} >> ${HOME}/.bashrc

export CODESPACES=true && export EPHEMERAL=true && export BINDIR="$HOME/.local/bin" && export PATH=$BINDIR:$PATH && sh -c "$(curl -fsLS git.io/chezmoi)"; bash
