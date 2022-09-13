FROM ubuntu:latest
RUN apt-get -y update \
	&& apt-get clean

# Add shaun as a user in the system
RUN adduser shaun && echo "shaun:shaun" | chpasswd && adduser shaun sudo \
	&& mkdir -p /home/shaun && chown shaun:shaun /home/shaun

# Install sudo
RUN apt-get install -y sudo

# Installing pipewire
RUN apt update \
	&& apt install -y pipewire \
	&& apt install -y wireplumber \
	&& apt install -y pipewire-pulse
	

# Set the variable PIPE_RUNTIME_DIR for user shaun
ENV PIPEWIRE_RUNTIME_DIR=/run/user/1000/

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
	&& sudo apt install -y alsa-base alsa-tools

# Install VLC for audio testing
RUN sudo apt update \
	&& sudo apt upgrade -y \
	&& sudo apt install -y vlc

# Copy test audio file
Chttps://www.youtube.com/watch?v=---6uKMVWOEOPY Ed_Sheeran_Shivers.mp3 /home/
