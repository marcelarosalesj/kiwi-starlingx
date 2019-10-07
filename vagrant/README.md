# Vagrant for enabling StarlingX Maintenance

Vagrant was selected as the development environment for enabling StarlingX Maintenance service because, unlike Docker containers, it creates and provides a VM which can enable and work with systemd services.

## Prerequisites
* Install vagrant

## Usage of this StarlingX Vagrant box
```
vagrant up
vagrant ssh
cd /vagrant # Inside the VM
./install_starlingx.sh [--obs|--local]
```
* Vagrant supports HTTP_PROXY and HTTPS_PROXY environmental variables.
* /vagrant is a sync folder with the host machine
* install_starlingx.sh script will download the starlingx packages in the list starlingx_packages.txt. This is to have a little bit of control on what is installed on the virtual machine as right now some packages stil have errors.


## Enabling StarlingX Maintenance Workflow

Patches and changes for Starlingx Maintenance enabling are done in a github branch.
```
git clone https://github.com/marcelarosalesj/metal
cd metal
git checkout opensuse
git remote add upstream https://opendev.org/starlingx/metal
# do a rebase if required
```
After cloning the branch and performing appropriate changes, it's required to rebuild the RPM package using osc tool.
```
osc co home:marcelarosalesj mtce
cd home:marcelarosalesj/mtce
```
Modify `_service` to use your development branch
```
<services>
    <service name="obs_scm">
        <param name="scm">git</param>
        <param name="url">https://github.com/marcelarosalesj/metal.git</param>
        <param name="revision">systemd</param>
        <param name="version">1.0</param>
        <param name="subdir">mtce/src</param>
        <param name="filename">mtce</param>
        <param name="changesgenerate">disable</param>
    </service>
    <service mode="buildtime" name="tar" />
    <service mode="buildtime" name="recompress">
        <param name="compression">gz</param>
        <param name="file">*.tar</param>
    </service>
    <service name="set_version" mode="disabled"/>
</services>
```
Then, run the service and build the package.
```
osc service run
osc build -p /vagrant/myrepo/ -k /vagrant/myrepo/ --no-verify openSUSE_Leap_15.0 x86_64 mtce.spec
```

## Other useful commands
```
# If you want to do a graceful shutdown
vagrant halt

# systemd useful commands
sudo journalctl -xe -u hwmon
systemctl start hwmon
systemctl daemon-reload

# Zypper
zypper install --download-only <package name>
```

## References
- [Vagrant Cloud opensuse box](https://app.vagrantup.com/opensuse/boxes/openSUSE-15.0-x86_64)
- [Vagrant Getting Started](https://www.vagrantup.com/intro/getting-started/index.html)
- [StarlingX MultiOS OpenSUSE](https://wiki.openstack.org/wiki/StarlingX/MultiOS/OpenSUSE)
