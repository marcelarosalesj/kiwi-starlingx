# Using kiwi

Here [kiwi](https://opensource.suse.com/kiwi/) tool is used to get an installation of starlingx packages on an openSUSE leap distribution.  

Right now, the main goal is to identify if there are errors when installing the packages.

## OEM disk image

```
git clone https://github.com/OSInside/kiwi-descriptions
sudo kiwi-ng --type oem system build --description kiwi-descriptions/suse/x86_64/suse-leap-15.1-JeOS --target-dir /tmp/myimage
```

## AutoYaST and Kiwi


## Plus some StarlingX Packages


## Quick boot the image

```
qemu-img create target_disk 20g
qemu -cdrom LimeJeOS-Leap-15.1.x86_64-1.15.1.install.iso -hda target_disk -boot d -m 4096
```

## References
* [Build OEM Expandable Disk Image](https://osinside.github.io/kiwi/building/build_oem_disk.html?highlight=oem)
