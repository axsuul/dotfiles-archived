# Description
These are my `.files`, files that I put in my home directory on UNIX systems which then multiply my productivity by over nine thousand!

# Dependencies
- vim
- tmux
- oh-my-zsh

# Installation
Use [homesick](https://github.com/technicalpickles/homesick) to install these dotfiles. Unfortunately, it introduces a ruby dependency but honestly how can you live without it? Thankfully it works on `1.8.7` so you can still be an old tard.

    $ gem install homesick
    $ homesick clone axsuul/dotfiles
    $ homesick symlink axsuul/dotfiles

## vim
`vim` uses the [solarized](https://github.com/altercation/solarized) color scheme. Please refer to their instructions are getting it to properly display in your terminal of choice.

# Chef
There's a chef cookbook that exists in getting these dotfiles to the right mouths. [It's right here if you have the appetite for it.](https://github.com/axsuul/cookbook-dotfiles)