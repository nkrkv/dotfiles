# My dotfiles

## Terminal fonts

Required for ZSH.

```bash
$ yaourt -Sy powerline-fonts-git awesome-terminal-fonts
```

## NVim

### Viable Neovim GTK client

This one! https://github.com/daa84/neovim-gtk

```bash
$ yaourt -Sy neovim-gtk-git
$ nvim-gtk
```

## Language Server/Client

Neovim as a language client requires:

```bash
$ yaourt -Sy python-neovim python2-neovim
$ npm install -g neovim
```

ReasonML language server: `npm install -g reason-cli@3.1.0-linux`
