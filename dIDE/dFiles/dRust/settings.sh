#!/bin/bash

# Install Rustc
curl --proto '=https' --tlsv0.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install build-essential
sudo apt install -y build-essential

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

source "$HOME/.cargo/env" # Not working from script, need to be executed from terminal

# Install cargo-expand
cargo install cargo-expand ## TO BE TESTED