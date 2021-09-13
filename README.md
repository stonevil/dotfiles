### dotFiles in active redevelopment right now. Use for you own risk. In a process migration to chezmoi. Unstable and can be broken.

## dotFiles

My collection of dot and config files.

Build in mind for macOS 11.x and higher and Arch Linux with AwesomeWM.

## Testing

Alpine Linux build

```shell
docker build --pull -t dotfiles -f Dockerfile.alpinelinux .
```

Arch Linux build

```shell
docker build --pull -t dotfiles -f Dockerfile.archlinux .
```

macOS 11 build

```shell
vagrant up
```

## Install

```shell
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply stonevil
```

For containers and other temporal environments:

```shell
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --one-shot stonevil
```

## TODO

1. Cleanup .inputrc
2. Cleanup .zshrc
   1. Prompt
3. Nvim config migration to lua
4. Add distraction free / markdown mode for Nvim
5. Migration to the fish?
6. Synchronise git aliases in shell script and git config
7. Templating personal inforamtion like email, etc.
8. Proper README
9. Further trim docker environments
10. Packer template for Vagrant toolbox
11. CentOS 7/8 Dockerfile and Yumfiles