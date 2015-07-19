#!/bin/bash

# install all default packages
for i in $(cat $HOME/.default_packages | xargs -L1); do sudo pacman -S $i; done
