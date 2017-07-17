all: rat-fix utils fuck oh-my-zsh cp-dotfiles cp-bin mk-tmp chrome exfat neovim fzf ssh-key cp-sudoers sublime3

utils:
	sudo apt -y install \
		tree unp rofi xsel mtools qemu

/bin/zsh:
	sudo apt-get -y install zsh

/etc/X11/xorg.conf.d/910-rat.conf:
	sudo mkdir -p /etc/X11/xorg.conf.d/GH
	sudo cp ./etc/X11/xorg.conf.d/910-rat.conf /etc/X11/xorg.conf.d/910-rat.conf

rat-fix: /etc/X11/xorg.conf.d/910-rat.conf

~/bin:
	cp -r ./bin ~/bin

cp-bin: ~/bin

~/tmp:
	mkdir ~/tmp

mk-tmp: ~/tmp

cp-dotfiles:
	cp -r dotfiles/. ~

/etc/sudoers.d/kuba:
	sudo cp .$@ $@

cp-sudoers: /etc/sudoers.d/kuba

/bin/zsh:
	sudo apt-get -y install zsh

zsh: /bin/zsh

~/.oh-my-zsh: zsh
	sh -c "$$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	echo "source ~/.myzshrc" >> ~/.zshrc

oh-my-zsh: ~/.oh-my-zsh

/usr/local/bin/thefuck:
	sudo apt install python3-dev python3-pip
	sudo -H pip3 install thefuck

fuck: /usr/local/bin/thefuck

/usr/bin/google-chrome-stable:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt-get update
	sudo apt-get -y install google-chrome-stable

chrome: /usr/bin/google-chrome-stable

/usr/bin/xmonad:
	sudo apt install xmonad libghc-xmonad-contrib-dev
	cp -r .xmonad ~
	echo https://wiki.haskell.org/Xmonad/Using_xmonad_in_XFCE

xmonad: /usr/bin/xmonad

/usr/bin/taffybar: xmonad
	sudo apt -y install cabal-install alex happy
	sudo apt -y install libgtk2.0-dev libpango1.0-dev libglib2.0-dev libcairo2-dev
	cabal update
	cabal install gtk2hs-buildtools
	cabal install gtk
	cabal install taffybar

taffybar: /usr/bin/taffybar

/sbin/exfatfsck:
	sudo apt -y install exfat-fuse exfat-utils

exfat: /sbin/exfatfsck

/usr/bin/nvim:
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt update
	sudo apt -y install neovim

neovim: /usr/bin/nvim

~/.fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

fzf: ~/.fzf

~/code:
	mkdir -p ~/code

/usr/bin/go:
	sudo apt -y install golang

golang: /usr/bin/go

/usr/bin/ruby:
	sudo apt -y install ruby-dev

ruby: /usr/bin/ruby

~/.ssh/id_rsa:
	ssh-keygen -t rsa -b 4096 -C "cubuspl42@gmail.com" -N "" -f ~/.ssh/id_rsa
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

ssh-key: ~/.ssh/id_rsa

/usr/bin/xsel:
	sudo apt -y install xsel

xsel: /usr/bin/xsel

update-editor:
	sudo update-alternatives --config editor

/usr/bin/subl:
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer

sublime3: /usr/bin/subl

/usr/bin/umake:
	sudo apt-get -y install ubuntu-make

umake: /usr/bin/umake

idea: umake /home/kuba/.local/share/umake/ide/idea
	umake ide idea

~/local/bin/hub:
	wget -O /tmp/hub.tgz https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz
	tar -xvzf /tmp/hub.tgz -C /tmp
	mkdir -p ~/local/bin
	cp /tmp/hub-linux-amd64-2.2.9/bin/hub ~/local/bin

hub: ~/local/bin/hub

gitconfig-include-common:
	cat ~/dotfiles/include.common.gitconfig >> ~/.gitconfig
