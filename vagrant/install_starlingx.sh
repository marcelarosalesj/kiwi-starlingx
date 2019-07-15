#!/bin/bash

STX_LIST="starlingx_packages.txt"

add_repos(){
    sudo zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/Cloud:StarlingX:2.0.repo &> /dev/null
    sudo zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/OpenStack:/Stein/openSUSE_Leap_15.0/Cloud:OpenStack:Stein.repo &> /dev/null
}


gen_stx_list(){
    sudo zypper pa -ur Cloud_StarlingX_2.0 | awk '{print $5}' | tail -n +5 > $STX_LIST
}

install_starlingx(){
    sudo zypper -n install $(cat $STX_LIST)
}

add_my_repo(){
    sudo zypper -n install createrepo
    createrepo /vagrant/myrepo
    sudo zypper -n addrepo -G /vagrant/myrepo myrepo
    sudo zypper -n refresh
}

add_repos
if [ ! -f $STX_LIST ]; then
    gen_stx_list
fi
install_starlingx
