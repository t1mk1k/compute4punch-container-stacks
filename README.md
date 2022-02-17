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

# Trouble shooting
The successfull output should be simething like this:
```
(base) [root@gput401 ~]# docker login gitlab-p4n.aip.de:5005
Authenticating with existing credentials...
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
(base) [root@gput401 ~]# git clone https://gitlab-p4n.aip.de/compute4punch/container-stacks.git
Cloning into 'container-stacks'...
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 15 (delta 3), reused 0 (delta 0), pack-reused 3
Unpacking objects: 100% (15/15), done.
(base) [root@gput401 ~]# cd container-stacks/
(base) [root@gput401 container-stacks]# git pull origin test-push
From https://gitlab-p4n.aip.de/compute4punch/container-stacks
 * branch            test-push  -> FETCH_HEAD
Updating 527fb8f..840ccec
Fast-forward
 .gitlab-ci.yml | 19 +++++++++++++++++++
 Dockerfile     |  2 ++
 README.md      | 20 +++++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.yml
 create mode 100644 Dockerfile
(base) [root@gput401 container-stacks]# ls
Dockerfile  README.md
(base) [root@gput401 container-stacks]# docker build -t gitlab-p4n.aip.de:5005/compute4punch/container-stacks .
Sending build context to Docker daemon  71.68kB
Step 1/1 : FROM  tensorflow/tensorflow:latest-gpu-py3-jupyter
 ---> ce8f7398433c
Successfully built ce8f7398433c
Successfully tagged gitlab-p4n.aip.de:5005/compute4punch/container-stacks:latest
(base) [root@gput401 container-stacks]# docker push gitlab-p4n.aip.de:5005/compute4punch/container-stacks
Using default tag: latest
The push refers to repository [gitlab-p4n.aip.de:5005/compute4punch/container-stacks]
702d1b8be4d8: Layer already exists 
e6817758b16e: Layer already exists 
aade6230e744: Layer already exists 
36c8797c46d0: Layer already exists 
008b0a19ee8e: Layer already exists 
e5ce0446b10f: Layer already exists 
8da5bb7ec7aa: Layer already exists 
15faca21012b: Layer already exists 
31ab8487b099: Layer already exists 
f42938bba454: Layer already exists 
4a5030e4aa0e: Layer already exists 
ee7a7b4f2fea: Layer already exists 
00f95e0cfeef: Layer already exists 
a29a5994f375: Layer already exists 
13c4327d38ff: Layer already exists 
8bdbbc38d97a: Layer already exists 
6e576898edb7: Layer already exists 
b8f75ed65728: Layer already exists 
2acb7acd7288: Layer already exists 
9e34e92e6b95: Layer already exists 
e24139c523b9: Layer already exists 
51997f5d204b: Layer already exists 
5c4b8cd3b09b: Layer already exists 
e44ff087319e: Layer already exists 
808fd332a58a: Layer already exists 
b16af11cbf29: Layer already exists 
37b9a4b22186: Layer already exists 
e0b3afb09dc3: Layer already exists 
6c01b5a53aac: Layer already exists 
2c6ac8e5063e: Layer already exists 
cc967c529ced: Layer already exists 
latest: digest: sha256:901b827b19d14aa0dd79ebbd45f410ee9dbfa209f6a4db71041b5b8ae144fea5 size: 6801

```
