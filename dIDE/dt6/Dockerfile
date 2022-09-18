FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build \
&& go get github.com/geek1011/easy-novnc@v1.1.0 \
&& go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# Install package dependencies
RUN apt-get update -y && \
	apt-get install -y --no-install-recommends \
		alsa-base \
		alsa-utils \
		libsndfile1-dev && \
	apt-get clean


# Add shaun as a user in the system
RUN adduser shaun && echo "shaun:shaun" | chpasswd && adduser shaun sudo
RUN mkdir -p /home/shaun && chown shaun:shaun /home/shaun

COPY Ed_Sheeran_Shivers.mp3 /home/shaun

# Install sudo x11vnc xvfb wget wmctrl
RUN apt-get install -y sudo x11vnc xvfb wget wmctrl

# Install vlc
RUN sudo apt update && sudo apt upgrade -y \
	&& sudo apt install vlc -y

# Install pipewire wireplumber
RUN sudo apt update \
	&& apt install -y pipewire wireplumber pipewire-pulse

# Install pulseaudio
RUN sudo apt update \
	&& sudo apt -y install pulseaudio

# Install nvim
RUN sudo apt update \
	&& sudo apt -y install neovim
