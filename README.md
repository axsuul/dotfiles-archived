# dotfiles 
[Gotta have my dotfiles!](https://www.youtube.com/watch?v=Kt6JI9gzECo) Plays nicely with: 

- git
- nvim
- tmux
- oh-my-zsh
- rbenv
- direnv
- scm_breeze

# Installation
Use [homesick](https://github.com/technicalpickles/homesick) to install these dotfiles

    $ gem install homesick
    $ homesick clone axsuul/dotfiles
    $ homesick symlink axsuul/dotfiles

# Neovim

Ensure Vundle is installed

```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then run `:PluginInstall` within **nvim** to install plugins.

# Chef
There's a [Chef](http://chef.io) cookbook that exists in getting these dotfiles setup in a jiffy. [You can find it right here!](https://github.com/axsuul/cookbook-dotfiles)
