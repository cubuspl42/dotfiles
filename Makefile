all: rat-fix utils fuck oh-my-zsh cp-dotfiles cp-bin mk-tmp chrome exfat neovim fzf hub

utils:
	sudo apt -y install \
		tree unp rofi xsel

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

~/.oh-my-zsh:
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

bundler: ruby
	sudo gem install bundler

/usr/local/bin/hub: ~/code golang bundler
	git clone https://github.com/github/hub.git ~/code/hub
	make -C ~/code/hub
	sudo make -C ~/code/hub install prefix=/usr/local

hub: /usr/local/bin/hub
