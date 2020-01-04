# My dotfiles use on your own resposibility

These dotfiles inspired by [dotfiles](https://dotfiles.github.io/)

These dotfiles project aim to provide a way to make instant setup for Ubuntu system. This project include:
Use branch for corresponding Ubuntu version.

- Vim and plugins
- VSCode and Atom
- Sublime Text 3 and plugins
- Programming languages and tools
- Shell configuration and plugins
- Git configuration

## Instalation

On fresh Ubuntu instalation:

```sh
 git clone https://github.com/Chyzwar/dotfiles-ubuntu.git
 sudo chmod +x dotfiles
 ./dotfiles
```

This will show list of options. Use branch coresponding to Ubuntu version.

### ./dotfiles system

This option will install system tools and related software.

- curl
- wget
- ppa-purge
- mercurial
- alacarte
- dropbox
- gimp
- libreoffice
- openssh-client
- openssh-server
- dropbox
- chrome
- chromium
- spotify
- picard

### ./dotfiles pro

This options will install programming languages and tooling

- python and pyenv
- node and nodenv
- erlang and kerl
- elixir and kiex
- docker and virtualbox
- rust and rustup
- php and composer
- apache
- mariadb
- open java 8, 9, ant, maven
- scala and sbt
- julia lang
- clojure and lein
- haskell platform
- ruby and rvm
- crystal and crenv
- go Lang
- scala and sbt
- nix

### ./dotfiles shell

Bash it will install liquidpromt. It also create symbolic links from this repo to you home.

### ./dotfiles vim

This command will install Vim  ./etc/.vimrc file will be symlinked to you home directory and overwrite existing one.
It use native vim package manager to install basic plugins.

### ./dotfiles vscode

This command will install VSCode and VSCode Insiders using snap. code-settings-sync is also pre installed

### ./dotfiles sublime

This will add ppa for Sublime Text 3, it will also install Package Manager and plugins listed in sublime/Package\ Control.sublime-settings.
Again configuration files will be symlinked to Sublime packages folder.

### ./dotfile atom

Install Atom editor
