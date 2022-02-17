# Container Stacks

Contains all containers used on the compute4punch infrastructure

# Test  workflow

```
docker login gitlab-p4n.aip.de:5005
docker pull --pull always gitlab-p4n.aip.de:5005//compute4punch/container-stacks:test-push
```
## Steps to reproduce an image

```
docker login gitlab-p4n.aip.de:5005
git clone https://gitlab-p4n.aip.de/compute4punch/container-stacks.git
cd container-stacks/
git pull origin test-push

docker build -t gitlab-p4n.aip.de:5005/compute4punch/container-stacks .
docker push gitlab-p4n.aip.de:5005/compute4punch/container-stacks
```
