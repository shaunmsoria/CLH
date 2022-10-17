# Containerised Linode Homelab v1.0

Here are my study notes for the CLH Project

1) What is CLH?
 <br>CLH is a Docker Container running on Ubuntu 22.04 with GUI, Google Chrome, Neovim, GitHub, Kitty installed.
 <br>The container is running on a Linode server accessible via noVNC via an encrypted password.

2) What is the rational?
 <br>The purpose of CLH is to allow the user to access a highly customisable homelab from any device, anywhere in the world and at any time to work on development project.
 <br>The access to the container is secured with an encrypted password and the container is easily redeployable if something goes wrong without compromising the linode server.
 

3) What problems needed to be overcome to create CLH?
 <br>The first challenge was to install all the necessary dependencies in the dockerfile while having the container running efficiently and with the expected behavior.
 <br>The second challenge was to set a GUI accessible via a browser. Proper network configuration was required to allow the container to stream its GUI via the browser.
 <br>The third challenge was to keep the container to a reasonable size ~ 1Gb to be easily redeployable if necessary.
 
 
4) What is next for the CLH Project?
   - Streaming sound with video to the browser
   - Allow multiple streaming browser to the same container to reproduce the multiple displays effect
   - Chain containers together for redundancy [if one container is overloaded, being able to pass the workload to another container]
