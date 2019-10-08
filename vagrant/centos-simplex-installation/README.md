# About StarlingX SimpleX Installation files

The files in this directory are taken from a StarlingX R2 simplex installation.

**simplex-comps.xml**
In a simplex installation this file is located in /www/pages/feed/rel-19.09/repodata/<hash>-comps.xml and contains the packages that could  be installed.

**smallsystem_ks.cfg**
For simplex, this file contains what of the comps.xml packages are going to be installed. The @ is for software group selection, the - is to exclude packages.

