# Vagrant

## Prerequisites 
* Install vagrant

## Usage of this StarlingX Vagrant box
```
vagrant up
vagrant ssh
cd /vagrant # Inside the VM
./install_starlingx.sh
```
* Vagrant supports HTTP_PROXY and HTTPS_PROXY environmental variables.
* /vagrant is a sync folder with the host machine
* install_starlingx.sh script will download the starlingx packages in the list starlingx_packages.txt. This is to have a
  little bit of control on what is installed on the virtual machine as right now some packages stil have errors.

## Other useful commands

```
# If you want to do a graceful shutdown
vagrant halt
```

## References
- [Vagrant Cloud opensuse box](https://app.vagrantup.com/opensuse/boxes/openSUSE-15.0-x86_64)
- [Vagrant Getting Started](https://www.vagrantup.com/intro/getting-started/index.html)
