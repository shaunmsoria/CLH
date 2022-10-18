# Containerised Linode Homelab v1.0

Here are my study notes for the CLH Project

1) What is CLH?
 <br>CLH is a Docker Container running on Ubuntu 22.04 with GUI, Google Chrome, Neovim, GitHub, Kitty installed.
 <br>The container is running on a Linode server accessible via noVNC via an encrypted password.
 <br>Image and futher details are available at: https://shaunmsoria.github.io/resume/ in the Portfolio Section.

2) What is the rational?
 <br>The purpose of CLH is to allow the user to access a highly customisable homelab from any device, anywhere in the world and at any time to work on development project.
 <br>The access to the container is secured with an encrypted password and the container is easily redeployable if something goes wrong without compromising the linode server.
 
 3) How to install CLH on your machine?
 <br>1) Ensure to have GitHub installed
 <br>2) Ensure to have Docker installed
 <br>3) Clone this repo on your machine
 <br>4) Then cd in the repo to CLH/dIDE/dFiles/caddy/
 <br>5) Then execute the follow command in your terminal: docker build -t caddyname:1 .
 <br>6) Then cd in the repo to CLH/dIDE/dFiles/dBase/
 <br>7) Then execute the follow command in your terminal: docker build -t basename:1 .
 <br>8) Then execute: docker network create networkname
 <br>9) Then execute: docker volume create volumename
 <br>10) Then execute the following command to create a mypassword-hash we will need to run the caddy container. Here 'mypass' would be a password of your choosing: docker run --rm -it caddyname:1 caddy hash-password -plaintext 'mypass'
 <br>11) Then execute: docker run --detach --volume=volumename:/data --net=networkname --name=streamname --env=APP_USERNAME="myusername" --env=APP_PASSWORD_HASH="mypassword-hash" --restart unless-stopped --publish=8080:8080 caddyname:1
 <br>12) Then execute: docker run --detach --rm -v volumename:/data -v /home/shaun/Program/dockerfiles/dIDE/volume:/home/shaun/volume  --shm-size=1g --net=networkname --name=containername --privileged basename:1


4) What problems needed to be overcome to create CLH?
   - The first challenge was to install all the necessary dependencies in the dockerfile while having the container running efficiently and with the expected behavior.
   - The second challenge was to set a GUI accessible via a browser. Proper network configuration was required to allow the container to stream its GUI via the browser.
   - The third challenge was to keep the container to a reasonable size ~ 1Gb to be easily redeployable if necessary.
 
 
5) What is next for the CLH Project?
   - Streaming sound with video to the browser
   - Allow multiple streaming browser to the same container to reproduce the multiple displays effect
   - Chain containers together for redundancy [if one container is overloaded, being able to pass the workload to another container]
