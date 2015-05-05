# My .files use on your own resposibility

Dotfiles inspire by https://dotfiles.github.io/ initialy forked from [webpro/dotfiles](https://github.com/webpro/dotfiles) and customised for Ubuntu.

These dotfiles project aim to provide a way to make instant setup for Ubuntu system. This project include:

- Vim and plugins
- Sublime Text 3 and plugins
- Programming tools
- Shell configuration

### Instalation
On fresh Ubuntu instalation:
```sh
 git clone https://github.com/Chyzwar/dotfiles-ubuntu.git
 sudo chmod +x dotfiles 
 ./dotfiles
```

### Vim and plugins (done)
```sh
./dotfiles vim
```
This command will install Vim and Vunndle package manager. Configuration from vim folder will be symlinked to you home directory and overwrite existing one.
vim/vimrc include config for vim, there are two themes possible to choose
- [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
- [sickill/vim-monokai](https://github.com/sickill/vim-monokai) (default)

Add/Remove plugins in vim/vundle.vim

### Sublime Text 3 (done)
```sh
./dotfiles sublime
```
This will add ppa for Sublime Text 3, it will also install Package Manager and plugins listed in sublime/Package\ Control.sublime-settings. Again configuration files will be symlinked to your home directory. This will conviente place to sync installed plugins on diffrent machines. 

### Programming Tools(done)
```sh
./dotfiles system
```
Its not only intall tools but also some programming leanguges not native to ubuntu. 

### bash and zhs config (in-progress)
```sh
./dotfiles shell
```