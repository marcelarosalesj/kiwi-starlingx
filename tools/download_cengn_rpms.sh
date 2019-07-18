#!/bin/bash

dir="cengn_repo"
mkdir -p $dir
wget http://mirror.starlingx.cengn.ca/mirror/starlingx/master/centos/latest_build/outputs/RPMS/std/
for rpm in $(cat index.html | cut -d'>' -f1-1 | cut -d'"' -f2-2); do
    wget http://mirror.starlingx.cengn.ca/mirror/starlingx/master/centos/latest_build/outputs/RPMS/std/$rpm
    mv $rpm $dir
done 
