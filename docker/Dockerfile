FROM opensuse:leap

RUN zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/StarlingX:/2.0/openSUSE_Leap_15.0/Cloud:StarlingX:2.0.repo
RUN zypper -n addrepo -G http://download.opensuse.org/repositories/Cloud:/OpenStack:/Stein/openSUSE_Leap_15.0/Cloud:OpenStack:Stein.repo
#RUN zypper -n addrepo -G https://download.opensuse.org/repositories/Kernel:/tools/openSUSE_Leap_15.0/Kernel:tools.repo
RUN zypper -n refresh && zypper -n  install vim


# Install all starlingx packages
#RUN zypper -n install `zypper pa -ur 2 | awk '{print $5}' | tail -n +5`

# Install one package
RUN zypper -n install sm-api
