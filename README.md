dotFiles in active redevelopment right now. Use for you own risk. In a process migration to [chezmoi](https://www.chezmoi.io).

## dotFiles

My collection of dot and config files.

Build in mind for macOS 12.x and higher and Linux Workstation.

## Testing

```shell
./.test.sh [distro] [version]
```

Example for Alpine Linux

```shell
./.test.sh alpine edge
```

##### Supported test platforms:

- macOS (with Vagrant)
- Alpine Linux Edge
- Arch Linux
- CentOS 8 or higher
- Fedora 37

## Install

```shell
sh -c "$(BINDIR=/tmp curl -fsLS git.io/chezmoi)" -- init --apply stonevil
```

For containers and other temporal environments:

```shell
sh -c "$(BINDIR=/tmp curl -fsLS git.io/chezmoi)" -- init apply --force --one-shot stonevil
```

## TODO

[Project Github issues](https://github.com/stonevil/dotfiles/issues)
