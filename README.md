dotFiles
----

My collection of the dot and config files. dotFiles in active redevelopment right now.

I'm DevOps and Dev Engineer. AWS, GCP clouds, Go, Python, Ruby. And this configuration build to reflect my personal requirements.

I'm doing a lot R'n'D and consulting for different companies and this requires to setup very often new environments, laptops provided by the clients (for security reason), etc. Also, just like any guy with some knowledge arount tech I'm *intimidated* to help support family, friends, etc. computers.

This configurations reflects my specific requirements to manage all this laptops (usually macOS), workstations, home servers, and containers and VM's flotilla.

Build in mind for macOS 25.x and higher and Linux and latest technology.
ArchLinux with Hyprland and mostly KDE Plasma is use.
Fedora Linux mostly used for home / work servers and containers required some GUI/VNC access. Also most Lima-VM VM's based on the Fedora Linux. Both **amd64** and **arm64**.


#### Platform key specific
Automation build in mind to work for user account without admin level access as much as possible.

macOS Homebrew configured and installed only for current user in ${HOME}/.brew folder. BASH/ZSH environment confgured to respect and include all required PATH.

The same principal reflected on some level with Linux.

Command ``chezmoi init`` provides ability to setup different aspects of the configuration like packages required, dark of light theme, theming for terminal, tab wight for all application (neovim, shell, bat, etc.)
In case if you want to change configuration just execute ``chezmoi init`` command again. Another functionality added is ability by ``chezmoi`` to read current configuration and propose as ``default`` configuration. So, if you need to change just one option you do not need to setup whole configuration again.


#### Supported platforms:
- Both my ``personal`` and ``working`` laptops managed by this configuration automation.
- ``macOS 26 Tahoe``. In use everyday on **arm64** MacBook Pro. I do not have have anymore access for **amd64** Mac for testing. Trying to support as much as possible but have no ability to test properly anymore.
- ``ArchLinux``. My Linux laptops. Asus Zephyrus G16, Lenovo Thinkpad's (usually T14).
- ``Fedora`` Linux 42 and higher. Containers, VM's and home servers.

> [!WARNING]
> Never tested in any ``Windows WSL``. Never used ``Windows`` for anything except gaming. Use at your own risk.
>
> ``Windows`` gaming platform automation managed in separate repository.


#### Testing
Requirements:
* ``macOS`` / ``Linux``: standart or admin user account.
* [Lima-VM](https://lima-vm.io/)
* [QEMU](https://www.qemu.org/)


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


Known issues
----
[chezmoi](https://www.chezmoi.io/) are increadible tool. Huge thanks everyone to contribution to this project.

But like any tool, chezmoi have own limitation.

Just like Go templates also have some limitations. And this limitations had contribution to sometimes not so optiomal solutions.


TODO
----
[Project Github issues](https://github.com/stonevil/dotfiles/issues)
