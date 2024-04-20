# dotfiles (archived)

> [!WARNING]
> I've decided to make my dotfiles private going forward. Anything you see here is outdated but a good baseline for getting started on your own

[Gotta have my dotfiles!](https://www.youtube.com/watch?v=Kt6JI9gzECo) Plays nicely with: 

- autojump
- direnv
- fzf
- gcloud
- git
- nvim
- oh-my-zsh
- rbenv
- scm_breeze
- tmux

# Installation

Use [homesick](https://github.com/technicalpickles/homesick) to install these dotfiles

    $ gem install homesick
    $ homesick clone axsuul/dotfiles
    $ homesick symlink dotfiles

# Setup

## vim

Ensure Vundle is installed

```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then run `:PluginInstall` within vim to install plugins.
