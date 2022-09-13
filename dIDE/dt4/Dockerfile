FROM ubuntu:latest
RUN apt-get -y update \
	&& apt-get clean

# Add shaun as a user in the system
RUN adduser shaun && echo "shaun:shaun" | chpasswd && adduser shaun sudo \
	&& mkdir -p /home/shaun && chown shaun:shaun /home/shaun

# Install sudo
RUN apt-get install -y sudo

# Set the variables for user shaun
ENV PIPEWIRE_RUNTIME_DIR=/run/user/1000/
ENV DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
ENV XDG_RUNTIME_DIR=/run/user/1000i
ENV PULSE_SERVER=tcp:127.0.0.1:4713

# Install pipewire
RUN apt update \
	&& apt install -y pipewire \
	&& apt install -y wireplumber \
	&& apt install -y pipewire-pulse

# Install pulseaudio
RUN apt update \
	&& apt install -y pulseaudio

# Install alsa-plugins
RUN apt update \
	&& apt install -y libasound2-plugins \
	&& sudo apt install -y alsa-base alsa-tools alsa-utils alsa-source

# Install VLC for audio testing
RUN sudo apt update \
	&& sudo apt upgrade -y \
	&& sudo apt install -y vlc

# Copy test audio file
COPY Ed_Sheeran_Shivers.mp3 /home/
