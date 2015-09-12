# My .files use on your own resposibility

These dotfiles inspired by https://dotfiles.github.io/ initialy forked from [webpro/dotfiles](https://github.com/webpro/dotfiles) and customised for Ubuntu.

These dotfiles project aim to provide a way to make instant setup for Ubuntu system. This project include:

- Vim and plugins
- Sublime Text 3 and plugins
- Programming tools and system utilities
- Shell configuration and git configs

## Instalation
On fresh Ubuntu instalation:
```sh
 git clone https://github.com/Chyzwar/dotfiles-ubuntu.git
 sudo chmod +x dotfiles 
 ./dotfiles
```
This will show list of options.


### ./dotfiles system  
This option will install system related software. It will also install multiple programming envirotments 

1. utility software
	* curl
	* shutter
	* p7zip
	* alien libaio1 unixodbc
	* ppa-purge
	* btsync
	* dropbox
	* LibreOffice prerelase (optional)
	* Gnome Shell Stagging (optional)

2. programming utilities
	* git and git-flow
	* docker

3. programming envirotments
	* Python and tools: virtualenvwrapper, pip,jedi, ipython
	* node and tools: nvm, gulp, grunt, yo, karma, bower, etc
	* PHP, mysql, composer,mcrypt, mods, mysql
	* Oracle Java: 7, 8, 8, ant, maven (default 8)
	* Julia lang
	* Clojure and Lein
	* Haskell platform (optional)
	* Ruby and rvm
	* Go Lang



### ./dotfiles vim
This command will install Vim and Vunndle package manager. Vimrc nad vundle.vim files will be symlinked to you home directory and overwrite existing one.

vim/vimrc include config for vim, there are two themes possible to choose
- [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
- [sickill/vim-monokai](https://github.com/sickill/vim-monokai) (default)

Add/Remove plugins in vim/vundle.vim


### ./dotfiles sublime
This will add ppa for Sublime Text 3, it will also install Package Manager and plugins listed in sublime/Package\ Control.sublime-settings. 
Again configuration files will be symlinked to Sublime packages folder. 

### bash and zhs config (in-progress)
```sh
./dotfiles shell
```