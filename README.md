### dotFiles in active redevelopment right now. Use for you own risk. In a process migration to chezmoi. Unstable and can be broken.



## dotFiles

My collection of dot and config files.

Build in mind for macOS 11.x and higher and Arch Linux with AwesomeWM.



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
   1. Antigen.zsh
   2. Prompt
   3. Oh-my-ZSH
3. Migration to the fish?
4. Rebuild initial install procedure for Homebrew
5. Synchronise git aliases in shell script and git config

