#!/bin/bash

obs_repo="obs_starlingx"

wget https://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.1/Cloud:StarlingX:2.0.repo
sudo mv Cloud:StarlingX:2.0.repo /etc/yum.repos.d/
mkdir $obs_repo
dnf reposync --downloadonly --repoid=Cloud_StarlingX_2.0 --downloaddir=$obs_repo
