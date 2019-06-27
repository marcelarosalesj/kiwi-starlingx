#!/bin/bash

reponame="starlingx"
repourl="https://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/"
imgtargetdir="/tmp/myimage"

leap150dir="suse/x86_64/suse-leap-15.0-JeOS"
leap151dir="suse/x86_64/suse-leap-15.1-JeOS"

end_delimiter="     <!-- StarlingX Packages End -->"

add_packages(){
    package_to_add=$2
    xml_directory=$3
    grep -q "$package_to_add" $xml_directory/config.xml # Verify if it is already in the XML
    if [ "$?" -ne 0 ]; then
        echo "$package_to_add"
        line_number=$(sed -n '/<!-- StarlingX Packages End -->/=' ${xml_directory}/config.xml)
        echo "line no: $line_number"
        sed -i "$line_number i $package_to_add" ${xml_directory}/config.xml
    fi


}

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
            package_to_add="<package name=\"$i\"/>";
            if [ "$2" == "150" ]; then
                add_packages $package_to_add $leap150dir
            elif [ "$2" == "151" ]; then
                add_packages $package_to_add $leap151dir
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
