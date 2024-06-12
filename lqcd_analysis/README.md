# Heavy Quark Diffusion from 2+1 Flavor Lattice QCD with 320 MeV Pion Mass

This documentation records how it is done to run the analysis of ```Heavy Quark Diffusion from 2+1 Flavor Lattice QCD with 320 MeV Pion Mass``` on Compute4PUNCH. From the se
tup of the Docker container ...

## Instructions to run and test the analysis workflow locally

1. Install Docker for Ubuntu system, 64-bit version of one of these Ubuntu versions:
    * Ubuntu Lunar 23.04
    * Ubuntu Kinetic 22.10
    * Ubuntu Jammy 22.04 (LTS)
    * Ubuntu Focal 20.04 (LTS)

[Instructions of installing Docker](https://docs.docker.com/engine/install/ubuntu/)

2. Create Dockerfile

Create a directory with a name of your choise. Here the name ```lqcd_analysis``` is used.
Change into this directory.

```
mkdir lqcd_analysis
cd lqcd_analysis/
```
## Instructions to run the analysis on Compute4PUNCH infrastructure (instructions for the users using terminal on Ubuntu system)

1. Follow the instructions on [Compute4PUNCH documentation](https://intra.punch4nfdi.de/?md=/docs/TA2/WP2/Compute4PUNCH_Documentation_Users.md)
2. Instructions of creating your own container which is outlined at the bottom of the documentation page
    1. Fork [https://gitlab-p4n.aip.de/compute4punch/container-stacks](https://gitlab-p4n.aip.de/compute4punch/container-stacks) into your account
    2. Create a feature branch and put your Dockerfile and stuff into a meaningful sub-directory
	To create a repositary locally with a new branch, first to 
	```
	git clone 
	```

        Next, create a new local branch and check it out:
        ```
        git checkout -b <branch-name>
	```
	
	Create a directory with a name of your choise. Her the name ```lqcd_analysis``` is used. Then change into this directory.
	```
	mkdir lqcd_analysis
	cd lqcd_analysis/
	```
	Download the files that are included in the repository. 
	
	
	The remote branch is automatically created when you push it to the remote server:
	```
	git push <remote-name> <branch-name>
	```
	```<remote-name>``` is typically ```origin```
    3. Submit a merge request, once the CI pipeline runs to completion
    4. Let the Compute4PUNCH team know, when the merge request and the created branch is ready to be reviewed
