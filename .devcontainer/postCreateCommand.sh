#!/usr/bin/env bash

set -ex

# set aliases for sotn/dec/differ
printf '\nalias sotn="make clean && make -j extract && make -j build && make expected"\n' >> ~/.bashrc
printf 'alias dec="./tools/decompile.py"\n' >> ~/.bashrc
printf 'alias differ="python3 ./tools/asm-differ/diff.py -mow3 --overlay"\n\n' >> ~/.bashrc

apt-get update

# install git and clone the repo
apt-get install -y git

# update submodules
git submodule update --init --recursive

# install debian packages
apt-get install -y $(cat tools/requirements-debian.txt)

# install rust and add to environment
curl https://sh.rustup.rs -sSf | sh -s -- -y

# source the rust installation
. "$HOME/.cargo/env"

make update-dependencies