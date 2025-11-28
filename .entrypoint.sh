#!/usr/bin/env sh
# vim:ft=sh

# trap '' SIGINT

if command -v "pacman" >/dev/null 2>&1; then
	echo "Arch Linux. Install bare minimal packages"
	sed -i '/^ID=/s/archarm/arch/' /etc/os-release
	pacman-key --init
	(pacman --noconfirm --needed --sync --refresh --sysupgrade sudo bash curl git rsync neovim) || exit 1
fi

if command -v "dnf" >/dev/null 2>&1; then
	echo "Fedora. Install bare minimal packages"
	(dnf update -y && dnf install -y sudo bash curl git rsync vim) || exit 1
fi

groupadd --force --gid ${PGID:-1000} vagrant
useradd --shell /bin/bash --uid ${PUID:-1000} --gid ${PGID:-1000} --groups wheel --password "$(openssl passwd ${vagrant_p:-vagrant})" --create-home --home-dir /home/vagrant vagrant
mkdir -p /etc/sudoers.d
echo "vagrant	ALL = (ALL) NOPASSWD:	ALL" > /etc/sudoers.d/vagrant

echo 'rsync --exclude ".git/" -avz /chezmoi ${HOME}/.local/share/' > /usr/bin/cua && chmod 755 /usr/bin/cua
# Exclude externals due GitHub API rate limits
echo 'rsync --exclude ".git/" --exclude ".chezmoiexternals/" -avz /chezmoi ${HOME}/.local/share/' > /usr/bin/cu && chmod 755 /usr/bin/cu
echo 'chezmoi execute-template < $@ | more' > /usr/bin/ct && chmod 755 /usr/bin/ct
echo 'chezmoi execute-template < $@ | bash -' > /usr/bin/cx && chmod 755 /usr/bin/cx
echo 'chezmoi init' > /usr/bin/ci && chmod 755 /usr/bin/ci
echo 'chezmoi apply' > /usr/bin/ca && chmod 755 /usr/bin/ca
echo 'chezmoi state reset' > /usr/bin/creset && chmod 755 /usr/bin/creset
ln -s /usr/bin/nvim /usr/bin/v
ln -s /usr/bin/nvim /usr/bin/vi
ln -s /usr/bin/nvim /usr/bin/vim

su - vagrant -c 'grep -qF "PATH" ${HOME}/.bashrc || echo PATH=${HOME}/.local/bin:${PATH} >> ${HOME}/.bashrc'

su - vagrant -c 'mkdir -p /home/vagrant/.local/share'
su - vagrant -c 'rsync --exclude ".git/" --exclude ".chezmoiexternals/" -avz /chezmoi ${HOME}/.local/share/'

su - vagrant -c 'export CODESPACES=true && export EPHEMERAL=true && export BINDIR="$HOME/.local/bin" && export PATH=$BINDIR:$PATH && sh -c "$(curl -fsLS git.io/chezmoi)"; bash'
