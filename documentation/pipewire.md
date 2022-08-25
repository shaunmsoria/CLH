## Pipewire Read Me Documentation
File: /usr/share/pipewire/pipewire.conf
	# allow to set pipewire parameters
	# can be copied to /etc/pipewire to be modified

pw-cli ls
	# will show all objects contained in pipewire

pw-cli ls Node
	# show only Nodes

pw-cli ls Port
	# show only Ports

pw-cli ls Device
	# show only Devices

gst-launch-1.0 audiotestsrc ! pipewiresink mode=provide
	# create a test sound output into pipewire via pipewiresink

gst-launch-1.0 pipewiresrc ! alsasink
	# take pipewiresrc as input and send it to alsa via alsasink

systemclt --user restart pipewire
	# will restart pipewire



## Wireplumber
File: /usr/share/wireplumber.conf 
	# allows to set wireplumber parameters via lua programming language

wpctl status
	# show all objects managed by wireplumber

wpctl set-profile 34 1
	# set profile of object with id 34 [different / object] to profile 1

systemctl --user restart wireplumber
	# restart wireplumber

systemctl --user status wireplumber
	# check wireplumber status

export PIPEWIRE_RUNTIME_DIR=/run/user/1000/
	# export the socket in a container for it to find it
