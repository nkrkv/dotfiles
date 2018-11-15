# My Dotfiles

Managed by GNU Stow. To setup on a new system:

```bash
$ yaourt -Sy stow
$ git clone git@github.com:nkrkv/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles

$ stow zsh
$ stow nvim
# etc ...
```

## Terminal fonts

Required for ZSH.

```bash
$ yaourt -Sy powerline-fonts-git awesome-terminal-fonts
```

## Herbstluft WM

```bash
$ yaourt -Sy i3lock gnome-do amixer-utils feh
```

## BSPWM

```bash
$ yaourt -Sy bspwm-git sxhkd i3lock amixer-utils ulauncher
```

## NVim

### Viable Neovim GTK client

This one! https://github.com/daa84/neovim-gtk

```bash
$ yaourt -Sy neovim-gtk-git
$ nvim-gtk
```

### Language Server/Client

Neovim as a language client requires:

```bash
$ yaourt -Sy python-neovim python2-neovim
$ npm install -g neovim
```

ReasonML language server: `npm install -g reason-cli@3.1.0-linux`
