#!/bin/bash

reponame="starlingx"
repourl="https://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/"
imgtargetdir="/tmp/myimage"

leap150dir="suse/x86_64/suse-leap-15.0-JeOS"
leap151dir="suse/x86_64/suse-leap-15.1-JeOS"

end_delimiter="     <!-- StarlingX Packages End -->"

if [ "$1" == "addpackages" ]; then
    # Add starlingx to zypper repos - this is needed id starlingx repo does not exist
    # sudo zypper removerepo starlingx ||
    # sudo zypper addrepo $repourl $reponame
    # sudo zypper update
    # Get list of packages in starlingx and filter
    for i in $(zypper packages -r $reponame | awk -F "|" '{print $3}'); do
        if [ "$i" == "Name" ]; then
            # skip this one because it is the Name column
            :
        else
            package_to_add="        <package name=\"$i\"/>";
            if [ "$2" == "150" ]; then
                grep -q "$package_to_add" $leap150dir/config.xml
                if [ "$?" -ne 0 ]; then
                    echo "$package_to_add"
                    #sed -i "s/$end_delimiter/$package_to_add\n$end_delimiter/g" $leap150dir/config.xml
                fi
            elif [ "$2" == "151" ]; then
                grep -q "$package_to_add" $leap151dir/config.xml
                if [ "$?" -ne 0 ]; then
                    echo "$package_to_add"
                fi

            fi
        fi
    done
elif [ "$1" == "createimage" ]; then
    sudo rm -rf $imgtargetdir
    sudo kiwi-ng --type vmx system build --description $leap150dir --target-dir $imgtargetdir
elif [ "$1" == "createoemimage" ]; then
    sudo rm -rf $imgtargetdir
    sudo kiwi-ng --type oem system build --description $leap151dir --target-dir $imgtargetdir
else
    echo "./tools.sh [ getpackages | createimage | createoemimage ]"
fi
