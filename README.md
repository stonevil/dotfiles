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
sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --apply stonevil
```

For containers and other temporal environments:

```shell
sh -c "$(BINDIR=$HOME/.local/bin curl -fsLS git.io/chezmoi)" -- init --one-shot stonevil
```

## TODO

1. Cleanup ```.inputrc```
2. Cleanup ```.zshrc```
3. Move to ```fish```. Lua everywhere
4. Add ```nfsd``` to Privacy, Full Disk Access 
5. Synchronize git ```aliases``` in shell script and ```git``` config
6. Proper README
7. Rework ```shellrc```
8. Fix ```lima``` templates
