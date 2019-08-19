#!/bin/bash

STX_LIST="starlingx_packages.txt"

add_obs_repos(){
    sudo zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/Cloud:StarlingX:2.0.repo &> /dev/null
    sudo zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/OpenStack:/Stein/openSUSE_Leap_15.0/Cloud:OpenStack:Stein.repo &> /dev/null
}

gen_stx_list(){
    sudo zypper pa -r Cloud_StarlingX_2.0 | awk -F '|' '{print $3}' | tail -n +5 | tr -d " " > $STX_LIST
}

install_starlingx(){
    sudo zypper -n --no-gpg-checks install $(cat $STX_LIST)
}

install_starlingx_my_repo(){
    sudo zypper -n --no-gpg-checks install --from myrepo $(cat $STX_LIST)
}

add_my_repo(){
    sudo zypper -n install createrepo
    createrepo /vagrant/myrepo
    sudo zypper -n addrepo -G /vagrant/myrepo myrepo
    sudo zypper -n refresh
}


if [ "$1" == "--obs" ]; then
    echo "From OBS"
    add_obs_repos
    if [ ! -f $STX_LIST ]; then
        gen_stx_list
    fi
    sudo zypper -n refresh
    install_starlingx
elif [ "$1" == "--local" ]; then
    echo "From local repo"
    add_my_repo
    sudo zypper -n refresh
    install_starlingx_my_repo
else
    echo "usage ./install_starlingx.sh [--obs | --local]"

fi
