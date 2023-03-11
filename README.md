### dotFiles in active redevelopment right now. Use for you own risk. In a process migration to chezmoi. Unstable and can be broken.

## 

## dotFiles

My collection of dot and config files.

Build in mind for macOS 12.x and higher and Linux Workstation.

## Testing

```shell
./.test.sh [distro] [version]
```

Example for Alpine Linux

```shell
./.test.sh alpine 3.17
```

Check directory ```.test``` for list of supported platforms.

## Install

```shell
sh -c "$(BINDIR=/tmp curl -fsLS git.io/chezmoi)" -- init --apply stonevil
```

For containers and other temporal environments:

```shell
sh -c "$(BINDIR=/tmp curl -fsLS git.io/chezmoi)" -- init --promptString email="fu@bar.org" --promptBool workstation=true apply --force --one-shot stonevil
```

## TODO

[Project Github issues](https://github.com/stonevil/dotfiles/issues)
