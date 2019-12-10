# StarlingX openSUSE simplex installation

Current goal is to get a very basic non-Starlingx openSUSE image with autoYaST automatic installation. Later, we can consider StarlingX specific image needs.

## AutoYaST
It is a software utility that automatically do the openSUSE installation based on a `autoinst.xml` file. You can see more details about this file here in the AutoYaST guide [1].

The easiest way to get an openSUSE image is to follow the "Making a Custom Installation ISO" [2]. Some of my previous experiments on creating live images and injecting DVD ISO files are in iso_inject [3] and live_img [4].

```
# mount ISO
mkdir $HOME/ISOBuild
sudo mount -o loop openSUSE-official.iso /mnt
rsync -AHPSXav /mnt/ $HOME/ISOBuild/
# insert your autoinst.xml file
cp My-AutoYaST.xml $HOME/ISOBuild/autoinst.xml
# create custom iso
xorriso -as mkisofs -no-emul-boot -boot-load-size 4 -boot-info-table -iso-level 4 -b boot/x86_64/loader/isolinux.bin -c boot/x86_64/loader/boot.cat -eltorito-alt-boot -e boot/x86_64/efi -no-emul-boot -o $HOME/openSUSE-MyCustom.iso $HOME/ISOBuild
```

## Debugging
For debugging you could press `Ctrl-Alt-Shift-X` in the middle of the installation to get a terminal [5]. In the terminal you could edit the `autoinst.xml` file, abort the current installation, and then repeat again. The changes are going to apply for the new installation.

## Resources
- [1] [AutoYaST guide](https://documentation.suse.com/sles/11-SP4/html/SLES-all/book-autoyast.html)
- [2] [Customized ISO](https://en.opensuse.org/SDB:Creating_customized_installation_source)
- [3] [Marcela's repo iso_inject](https://github.com/marcelarosalesj/iso_inject/)
- [4] [Marcela's repo live_img](https://github.com/marcelarosalesj/live_img)
- [5] [YaST tricks](https://en.opensuse.org/SDB:YaST_tricks)

