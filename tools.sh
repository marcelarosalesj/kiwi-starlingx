#!/bin/bash

reponame="starlingx"
repourl="https://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/"
imgtargetdir="/tmp/myimage"

if [ "$1" == "getpackages" ]; then
    echo "getpackages"
    # Add starlingx to zypper repos
    #sudo zypper addrepo $repourl $reponame
    # Get list of packages in starlingx and filter
    for i in $(zypper packages -r $reponame | awk -F "|" '{print $3}'); do
        echo "<package name=\"$i\"/>";
    done
elif [ "$1" == "createimage" ]; then
    sudo rm -rf $imgtargetdir
    sudo kiwi-ng --type vmx system build --description suse/x86_64/suse-leap-15.0-JeOS --target-dir $imgtargetdir
else
    echo "./tools.sh [ getpackages | createimage ]"
fi
