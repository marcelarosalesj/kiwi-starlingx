
# Use Dockerfile

Create a docker image using this Dockerfile to get an openSUSE system with StarlingX packages installed.

```
docker build --build-arg http_proxy=$PROXY --build-arg https_proxy=$PROXY -t test -f Dockerfile .
```
