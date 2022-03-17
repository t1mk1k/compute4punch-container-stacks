# Configurable HTCondor worker node image

This docker image provides a HTCondor worker node which is configurable using
ansible. HTCondor itself is configured using 
[condor_git_config](https://pypi.org/project/condor_git_config/). Currently
this image supports HTCondor's pool password and token authentication. 

In order to configure your worker node, you need to create a directory
containing an yaml containing the supported ansible variables described below.

| Variable                           | Description                                                                                                                |
|------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| HTCONDOR_CONFIG_GIT_REPO           | URL pointing to the Git repository containing the HTCondor configuration                                                   |
| HTCONDOR_CONFIG_GIT_CACHE_PATH     | Cache path location on destination system (optional, default=/etc/condor/config.git)                                       |
| GIT_USER                           | Username to use when accessing the Git repository above                                                                    |
| GIT_TOKEN                          | Token/Password to use when accessing the Git repository above                                                              |
| CLOUD_SITE_ID                      | We are using `condor-git-config` white listing to support multiple cloud sites                                             |
| HTCONDOR_POOL_PASSWORD (Optional)  | Pool password to authenticate the worker node with the HTCondor cluster (optional base64 support for binary passwords)     |
| HTCONDOR_TOKEN (Optional)          | Token to authenticate the worker node against the HTCondor cluster (optional base64 support for binary passwords)          |
| HTCONDOR_TOKEN_PASSWORD (Optional) | Token password to authenticate the HTCondor cluster against the worker node (optional base64 support for binary passwords) |

## Example configurations

Create a new `config` directory and add a new file `secrets.yaml`
containing the following contents depending the authentication method you would
like to use.

### Enable token based authentication

```yaml
HTCONDOR_CONFIG_GIT_REPO: "https://git.somewhere.org/configs.git"
GIT_USER: "CaptainGit"
GIT_TOKEN: "Don't tell you!"
CLOUD_SITE_ID: "BotNet"
HTCONDOR_TOKEN:
  BotNet: Test123456
HTCONDOR_TOKEN_PASSWORD:
  BotNet: Test123
```

### Enable pool password authentication

```yaml
HTCONDOR_CONFIG_GIT_REPO: "https://git.somewhere.org/configs.git"
GIT_USER: "CaptainGit"
GIT_TOKEN: "Don't tell you!"
CLOUD_SITE_ID: "BotNet"
HTCONDOR_POOL_PASSWORD: "TopSecret123456!"
```

## How to start-up the worker node

The workernode can then be started and configured by bind mounting the `config`
directory into `/srv/config`.

```shell
docker run -v $PWD/config:/srv/config htcondor-wn:latest
```

In case you want to use a read-only `singularity` container, you need to bind mount
a local directory into `/scratch` as well.

```shell
singularity run --userns -B $PWD/config:/srv/config -B ${SOMELOCALDIR}:/scratch /cvmfs/unpacked.cern.ch/registry.hub.docker.com/matterminers/htcondor-wn\:latest
```

The HTCondor is started automatically and HTCondor is configured using ansible
and the static configuration in your Git repository.
