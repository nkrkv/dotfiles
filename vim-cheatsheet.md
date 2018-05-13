
# My personal Vim cheatsheet

## vimrc

```vim
:tabe $MYVIMRC      " open vimrc for editing
:so %               " source vimrc when it is open
```

## Viable Neovim GTK client

This one! https://github.com/daa84/neovim-gtk

```bash
$ yaourt -Sy neovim-gtk-git
$ nvim-gtk
```

## Language Server/Client

Neovim as a language client requires:

```bash
yaourt -Sy python-neovim python2-neovim
npm install -g neovim
```

ReasonML language server: `npm install -g reason-cli@3.1.0-linux`

JavaScript language server: `yaourt -Sy javascript-typescript-langserver`

