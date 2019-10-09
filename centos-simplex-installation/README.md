# About StarlingX SimpleX Installation files

To enable StarlingX on openSUSE operating system, it is not possible to reuse the same kickstart files that are used for CentOS installation nor the names of the packages installed. To approach this problem, first we need to identify CentOS packages installed on a SimpleX and find an equivalent for openSUSE.

The files in this directory are taken from a StarlingX R2 simplex installation.

**simplex-comps.xml**
In a simplex installation this file is located in /www/pages/feed/rel-19.09/repodata/comps.xml and contains the packages that could  be installed.

**smallsystem_ks.cfg**
For simplex, this file contains what of the comps.xml packages are going to be installed. The @ is for software group selection, the - is to exclude packages.

**packages-\*** from previous files, I generated manually these lists of files that are required for starlingx installation (centos)
