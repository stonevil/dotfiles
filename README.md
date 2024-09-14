dotFiles
----

My collection of dot and config files. dotFiles in active redevelopment right now.

Build in mind for macOS 14.x and higher and Linux.

#### Supported platforms:

- macOS 14 Sonoma. In use everyday both on amd64 and arm64 MacBook Pro.
- Fedora 40 and higher.
- Debian 12. VM's, Toolbox container, and my Linux laptop.

> [!WARNING]
> Never tested in any ``Windows WSL``. Never used ``Windows`` for anything except gaming.  Use at your own risk.


Testing
----
```bash
./.test.sh [distro] [version]
```

Example for Fedora Linux

```bash
./.test.sh fedora
```


Installation
----
In ``bash`` OR your favourite one terminal session execute commands:

```bash
export BINDIR="$HOME/.local/bin"
export PATH=$BINDIR:$PATH

sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply stonevil
```

For containers and other temporary environments:

```bash
export CODESPACES=true

export BINDIR="$HOME/.local/bin"
export PATH=$BINDIR:$PATH

sh -c "$(curl -fsLS git.io/chezmoi)" -- init apply --force --one-shot stonevil
```


TODO
----

[Project Github issues](https://github.com/stonevil/dotfiles/issues)
