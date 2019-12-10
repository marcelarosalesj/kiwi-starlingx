# Using QEMU for openSUSE StarlingX

## Steps

First, clone test repository and set up `automated-robot-suite` environment.
```
git clone https://opendev.org/starlingx/test.git
cd automated-robot-suite
#
virtualenv -p python3 infra
source infra/bin/activate
pip install -r requirements.txt
pip install -r test-requirements.txt
```

Use Qemu setup script
```
cd Qemu
python qemu_setup.py -i /home/marosale/Repos/test/automated-robot-suite/Qemu/openSUSE-Leap-15.1-DVD-x86_64.iso -c configs/simplex.yaml
```
At this point... the VM wont have network access. It is required to:
- check which card has the `stx-nat` virtual network network source (in my case the MAC was x:x:x::40 and it was the
  interface eth2)
- then give an ip in `10.10.10.x` segment to that interface. `sudo ip addr add 10.10.10.100/24 dev eth2`
- it may be required to add the route default `sudo ip route add default via 10.10.10.1`
- then configure proxies and the DNS, this has to be done through `yast2`. System > Network Settings. In Global options
  I changed from NetworkManager Service to Wicked Service, then in Hostname/DNS tab I added my DNS.

