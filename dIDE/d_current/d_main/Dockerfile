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

# Installing git & github cli & kitty & neovim
RUN apt update -y \
	&& apt install -y git \
	&& git config --global user.name "shaunmsoria" \
	&& git config --global user.email "shaunmsoria@gmail.com" \
	&& apt install -y gh kitty neovim

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

## Setting background
#ADD settings.sh /home
#RUN sudo chmod +x /home/shaun/settings.sh \
#	&& /home/shaun/settings.sh \
#	&& rm -f /home/shaun/settings.sh

#RUN mkdir -p /home/shaun/downloads/wallpapers
#ADD a0BLEP.webp /home/shaun/downloads/wallpapers
#RUN cd /home/shaun/downloads/wallpapers/ \
#	&& sudo feh --bg-fill a0BLEP.webp

## Setting Kitty.conf ## TEST
#RUN cd ~/.config/kitty \
#      	&& ln -s ./kitty-themes/themes/Tomorrow_Night_Blue.conf ~/.config/kitty/theme.conf \
#	&& echo "include ./theme.conf" | cat ./theme.conf

# Copying necessary files
COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY supervisord.conf /etc/
EXPOSE 8080

CMD ["sh", "-c", "chown shaun:shaun /data /dev/stdout && exec gosu shaun supervisord"]

### CLI CMD 

## Lunch Caddy so we can connect via a browser to the container
# docker run --detach --volume=shaun-data:/data --net=shaun-net --name=shaun-web --env=APP_USERNAME="shaun" --env=APP_PASSWORD_HASH="JDJhJDEwJFR2OTJ5bEJlYmtHR0NHUFQ3RGUwMk9UR3VBcTY3ZFRFYXVKNGYyWm9UQXpDOEFHS2UxQWdl" --publish=8080:8080 caddy/shaun:1

## Lunch the image to work with noVNC
# docker run --detach --rm -v shaun-data:/data -v /home/shaun/Program/dockerfiles/dIDE/volume:/home/shaun/volume  --shm-size=1g --net=shaun-net --name=shaun-app --privileged opt:2
