# My Dotfiles

Managed by GNU Stow. To setup on a new system:

```bash
$ yay -S stow
$ git clone git@github.com:nkrkv/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles

$ stow zsh
$ stow nvim
# etc ...
```

## ZSH

The shell & plugins manager:

```bash
$ yay -S zsh antigen-git
```

Terminal fonts:

```bash
$ yay -S powerline-fonts awesome-terminal-fonts
```

## Herbstluft WM

```bash
$ yay -S i3lock gnome-do amixer-utils feh
```

## BSPWM

```bash
$ yay -S bspwm-git sxhkd compton i3lock amixer-utils ulauncher
```

## NVim

### Viable Neovim GTK client

This one! https://github.com/daa84/neovim-gtk

```bash
$ yay -S neovim-gtk-git
$ nvim-gtk
```

### Language Server/Client

Neovim as a language client requires:

```bash
$ yay -S python-neovim python2-neovim
$ npm install -g neovim
```

ReasonML language server: `yay -S reason-language-server`
