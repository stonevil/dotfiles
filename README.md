dotFiles
----
My collection of dot and config files. dotFiles in active redevelopment right now.

Build in mind for macOS 12.x and higher and Linux.

#### Supported platforms:

- macOS Sonoma 14.0. In use everyday both on amd64 and arm64 MacBook Pro
- Alpine Linux Edge
- Arch Linux (!) (not tested for long-long time. Broken)
- CentOS 8 or higher (simplified on purpose. Used only in restricted environment with limited access to the Internet)
- Fedora 38. VM's, Toolbox container, and my Linux laptop.

> Never tested in any ``Windows`` ``WSL``. Never used ``Windows`` for anything except gaming.  Use at your own risk.


Testing
----
```shell
./.test.sh [distro] [version]
```

Example for Alpine Linux

```shell
./.test.sh alpine edge
```


Installation
----
In ``bash`` OR your favourite one terminal session execute commands:

```shell
export BINDIR="$HOME/.local/bin"
export PATH=$BINDIR:$PATH

sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply stonevil
```

For containers and other temporal environments:

```shell
export CODESPACES=true

export BINDIR="$HOME/.local/bin"
export PATH=$BINDIR:$PATH

sh -c "$(curl -fsLS git.io/chezmoi)" -- init apply --force --one-shot stonevil
```


TODO
----

[Project Github issues](https://github.com/stonevil/dotfiles/issues)