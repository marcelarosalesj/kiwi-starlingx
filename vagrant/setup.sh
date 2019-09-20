#!/bin/bash

# Install packages
sudo zypper refresh
addrepo https://download.opensuse.org/repositories/openSUSE:/Tools/openSUSE_15.0/openSUSE:Tools.repo
sudo zypper -n install osc build obs-service-tar_scm obs-service-recompress obs-service-obs_scm
sudo zypper -n install createrepo
sudo zypper -n install git strace

# Add StarlingX OBS repos
sudo zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/Cloud:StarlingX:2.0.repo &> /dev/null
sudo zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/OpenStack:/Stein/openSUSE_Leap_15.0/Cloud:OpenStack:Stein.repo &> /dev/null

# Create local repo 
createrepo /vagrant/myrepo

#
echo "alias l=\"ls -lah\"" >> ~/.bashrc
source ~/.bashrc
