FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build \
	&& go get github.com/geek1011/easy-novnc@v1.1.0 \
	&& go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ubuntu:latest
RUN apt-get -y update && \
	apt-get clean

# Add shaun as a user in the system
RUN adduser shaun && echo "shaun:shaun" | chpasswd && adduser shaun sudo
RUN mkdir -p /home/shaun && chown shaun:shaun /home/shaun

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
	&& sudo cat /home/shaun/rc.lua > /etc/xdg/awesome/rc.lua

# Insalling google chrome stable
RUN apt update && apt upgrade -y \
	&& apt install ca-certificates gnupg2 ubuntu-keyring -y \
	&& wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | tee /usr/share/keyrings/google-chrome.gpg \
	&& echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/google-chrome.list \
	&& apt update \
	&& apt install google-chrome-stable -y \
	&& chown -R shaun:shaun /home/shaun

# Copying necessary files
COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY supervisord.conf /etc/
EXPOSE 8080

# Set the variable PIPE_RUNTIME_DIR for user shaun
ENV PIPEWIRE_RUNTIME_DIR='/run/user/1000/'
ENV XDG_RUNTIME_DIR='/home/shaun/'
# ENV XDG_RUNTIME_DIR='/root'

# Installing pipewire
RUN apt update \
	&& apt install -y pipewire wireplumber pipewire-pulse 

# Install python3-gst-1.0
RUN sudo apt update \
	&& apt install -y python3-gst-1.0

# Intall gstreamer1.0-x package
RUN sudo apt-get update \
	&& sudo apt-get install -y gstreamer1.0-x gstreamer1.0-tools \
	&& sudo apt-get install -y gstreamer1.0-pipewire
	
# Install alsa-tools
RUN sudo apt update \
	&& sudo apt install -y gstreamer1.0-alsa \
	&& sudo apt install -y alsa-base alsa-source alsa-tools alsa-utils alsa-oss

# Install inxi package to see container access to the host hardware
RUN sudo apt update \
	&& sudo apt install -y inxi

# Install Dbus
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y dbus
COPY org.manjaro.pamac.daemon.conf /etc/dbus-1/session.d/



# Copying the bootstrap.sh scrip into the container
#COPY bootstrap.sh /

# Making the script executable
#RUN chmod +x /bootstrap.sh

# Executing script
#CMD '/bootstrap.sh'

# Adding user shaun to the audio group
RUN sudo usermod -a -G audio shaun

# Adding test audio file
COPY Ed_Sheeran_Shivers.mp3 ./home/shaun/

# Install gstreamer1.0-x package part 2
RUN sudo apt-get update \
	&& sudo apt-get install -y libgstreamer1.0-dev \
	&& sudo apt-get install -y libgstreamer-plugins-base1.0-dev \
	&& sudo apt-get install -y libgstreamer-plugins-bad1.0-dev \
	&& sudo apt-get install -y gstreamer1.0-plugins-base \
	&& sudo apt-get install -y gstreamer1.0-plugins-good \
	&& sudo apt-get install -y gstreamer1.0-plugins-bad \
	&& sudo apt-get install -y gstreamer1.0-plugins-ugly \
	&& sudo apt-get install -y gstreamer1.0-libav \
	&& sudo apt-get install -y gstreamer1.0-gl \
 	&& sudo apt-get install -y gstreamer1.0-gtk3
#	&& sudo apt-get install -y gstreamer1.0-doc		## install doesn't work 
#	&& sudo apt-get install -y gstreamer1.0-qt5i		## install doesn't work
#	&& sudo apt-get install -y gstreamer1.0-pulseaudio 	## pulseaudio not installed


# Install ffmpeg for the mp4 format
RUN sudo add-apt-repository universe \
	&& sudo apt update \
	&& sudo apt install -y ffmpeg

# Install youtube-dl to work with Gstreamer-1.0
RUN sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl \
	&& sudo chmod a+rx /usr/local/bin/youtube-dl
#	RUN sudo apt-get update \
#	&& sudo apt install -y youtube-dl


# Creating the volume data and exec gosu supervisord
RUN groupadd -f --gid 1000 app \
	&& useradd --home-dir /data --shell /bin/bash --uid 1001 --gid 1000 app \
	&& mkdir -p /data
VOLUME /data

CMD ["sh", "-c", "chown app:app /data /dev/stdout && exec gosu app supervisord"] 

## To run the Basic Dockerfile with the following command:
#	docker run -p 5900:5900 -e VNC_SERVER_PASSWORD=password --user shaun --privileged ubuntu/shaun:1

## To run the image with enough RAM allocation and Memory access
#	docker run -p 5900:5900 -v ~/Programs/Docker/dFiles/dIDE/volume:/shared-folder-Shaun --shm-size=2g -e VNC_SERVER_PASSWORD=password --user shaun --privileged ubuntu/shaun:1

## to lunch the image to work with noVNC
# docker run --detach -v shaun-data:/data -v /run/user/1000/pipewire-0:/run/user/1000/pipewire-0 -v /run/dbus:/run/dbus  --shm-size=2g --net=shaun-net --name=shaun-app --privileged web/shaun:5

## to lunch Caddy so we can connect via a browser to the container
# docker run --detach --volume=shaun-data:/data --net=shaun-net --name=shaun-web --env=APP_USERNAME="shaun" --env=APP_PASSWORD_HASH="JDJhJDEwJFR2OTJ5bEJlYmtHR0NHUFQ3RGUwMk9UR3VBcTY3ZFRFYXVKNGYyWm9UQXpDOEFHS2UxQWdl" --publish=8080:8080 caddy/shaun:1
