FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build \
	&& go get github.com/geek1011/easy-novnc@v1.1.0 \
	&& go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ubuntu:22.04
RUN apt-get update -y \
	&& apt-get clean

# Add shaun as a user in the system
RUN useradd --home-dir /data --shell /bin/bash shaun \
	&& echo "shaun:shaun" | chpasswd && adduser shaun sudo \
	&& mkdir -p /home/shaun && chown shaun:shaun /home/shaun \
	&& mkdir -p /data
VOLUME /data

# Install sudo x11vnc xvfb wget wmctrl
RUN apt-get install -y sudo x11vnc xvfb wget wmctrl

# Install dependencies
RUN apt install software-properties-common apt-transport-https -y

# install tigervnc-standalone-server supervisor gosu
RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends tigervnc-standalone-server supervisor gosu \
	&& rm -rf /var/lib/apt/lists \
	&& mkdir -p /usr/share/desktop-directories

RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends nano openssh-client rsync ca-certificates xdg-utils htop xzip bzip2 zip unzip \
	&& rm -rf /var/lib/apt/lists


# Installing awesome [window manager] & setup with rc.lua
ADD rc.lua /home/shaun/
RUN apt update -y \
	&& apt install -y awesome \
	&& mkdir /home/shaun/.config \
	&& mkdir /home/shaun/.config/awesome/ \
	&& cp /usr/share/awesome/themes/default/theme.lua /home/shaun/.config/awesome/ \
	&& sudo cat /home/shaun/rc.lua > /etc/xdg/awesome/rc.lua \
	&& sudo rm -f /home/shaun/rc.lua

# Insalling google chrome stable
RUN apt update && apt upgrade -y \
	&& apt install ca-certificates gnupg2 ubuntu-keyring -y \
	&& wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | tee /usr/share/keyrings/google-chrome.gpg \
	&& echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/google-chrome.list \
	&& apt update \
	&& apt install google-chrome-stable -y \
	&& chown -R shaun:shaun /home/shaun

## Changing shaun Home Directory
RUN sudo usermod -d /home/shaun shaun

# Installing git & github cli & neovim
RUN apt update -y \
	&& apt install -y git \
	&& git config --global user.name "shaunmsoria" \
	&& git config --global user.email "shaunmsoria@gmail.com" \
	&& apt install -y gh neovim

## Setting background
RUN mkdir -p /usr/share/awesome/themes/custom \
	&& sudo rm -f /home/shaun/.config/awesome/theme.lua
ADD kali.png /usr/share/awesome/themes/custom
ADD theme.lua /home/shaun/.config/awesome/

# Installing Kitty & Setting
RUN sudo apt update \
	&& sudo apt -y install kitty

# Setting Kitty.conf 
RUN mkdir -p home/shaun/.config/kitty/kitty-themes
RUN sudo git clone --depth 1 https://github.com/dexpota/kitty-themes.git /home/shaun/.config/kitty/kitty-themes
RUN cd /home/shaun/.config/kitty
RUN sudo cp /home/shaun/.config/kitty/kitty-themes/themes/Tomorrow_Night_Blue.conf /home/shaun/.config/kitty \
	&& sudo mv /home/shaun/.config/kitty/Tomorrow_Night_Blue.conf /home/shaun/.config/kitty/theme.conf
RUN sudo echo "include /home/shaun/.config/kitty/theme.conf" >> /etc/xdg/kitty/kitty.conf

# Installing Curl
RUN apt update \
	&& sudo apt install -y curl

# Install Tree
RUN sudo apt update \
	&& sudo apt install -y tree 

# Creating Program & nvim folders
RUN sudo mkdir -p /home/shaun/Programs/ \
	&& sudo mkdir -p /home/shaun/.config/nvim

# Adding  init.vim in the right location 
ADD init.vim /home/shaun/.config/nvim

# Install exuberant-ctags for nvim tagbar plugin
RUN sudo apt update \
	&& sudo apt install exuberant-ctags

# Install jq for json manipulation in the shell
RUN sudo apt update \
	&& sudo apt upgrade -y \
	&& sudo apt install -y jq

# Install Node.js & npm
RUN curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
	&& sudo apt install -y nodejs \
	&& sudo apt install -y build-essential

# Install Ganache
RUN npm install -y ganache-cli --global

# Add UI version of Ganache
RUN mkdir /home/shaun/Programs/apps
ADD ganache-2.5.4-linux-x86_64.AppImage /home/shaun/Programs/apps
RUN sudo chmod +x /home/shaun/Programs/apps/ganache-2.5.4-linux-x86_64.AppImage

# Install FUSE necessary to execute Ganache UI
RUN sudo apt-get install fuse libfuse2 \
	&& sudo addgroup fuse \
	&& sudo adduser $USER shaun fuse

# Install Truffle
RUN npm install -g -y truffle

# Install Hardhat
RUN npm install -g -y hardhat

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install vim-plug
RUN su - shaun -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN su - shaun -c "nvim +PlugInstall +qall"

# Install Rustc
ARG PASS_WD
RUN su - shaun -c "curl --proto '=https' --tlsv0.2 -sSf https://sh.rustup.rs | sh -s -- -y" \
	&& su - shaun -c "curl https://sh.rustup.rs -sSf | sh -s -- -y" \
	&& su - shaun -c "echo '${PASS_WD}' | sudo -S apt install -y build-essential" \
	&& source "/home/shaun/.cargo/env" \
	&& sudo printf "\n#add directory cargo to bash\nsource \"/home/shaun/.cargo/env\"" >> /etc/bash.bashrc \
	&& su - shaun -c "cargo install cargo-expand"

# Copying necessary files
COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY supervisord.conf /etc/
EXPOSE 8080

CMD ["sh", "-c", "chown shaun:shaun /data /dev/stdout && exec gosu shaun supervisord"]

### CLI CMD 

## Lunch Caddy so we can connect via a browser to the container
# docker run --detach --volume=shaun-data:/data --net=shaun-net --name=shaun-web --env=APP_USERNAME="shaun" --env=APP_PASSWORD_HASH="JDJhJDEwJFR2OTJ5bEJlYmtHR0NHUFQ3RGUwMk9UR3VBcTY3ZFRFYXVKNGYyWm9UQXpDOEFHS2UxQWdl" --restart unless-stopped --publish=8080:8080 shaun/caddy:1

## Lunch the image to work with noVNC
# docker run --detach --rm -v shaun-data:/data -v /home/shaun/Program/dockerfiles/dIDE/volume:/home/shaun/volume  --shm-size=1.5g --net=shaun-net --name=shaun-app --privileged homelab:1
