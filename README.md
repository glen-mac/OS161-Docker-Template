# A Docker setup for Assignment 0 CS3121

The purpose of this repository is to provide a docker based workflow for using os161 source code in CS3121.

This repository contains the following:

- A copy of assignment 0 source code obtained by running `cp -r ~cs3231/assigns/asst0/src .` on a cse machine
- A Dockerfile for defining the build rules for the docker image
- A script to build the docker image
- A script to build the os161 kernel (should be run inside the docker container)
- A script to run a container from the build docker image

## A sample workflow
In order to build the image, run the container and compile and run the os161 kernel the following steps should be taken.

```
# From the root of the repo
./build_image.sh
./run_image.sh # runs and moves you into the container

# Now from inside the container
./build_kernel.sh
# the build kernel script creates the kernel in the /home/root folder
cd root

# Run the kernel
sys161 kernel
```
### Some notes on this workflow
Currently, the os161 source code is copied over to the image. This is less than ideal since you will need to re-build the image every time you change the source code

To make this easier, you can add the kernel compile step into the Dockerfile so the kernel is ready when the image is built

Eventually I will change the workflow so that the source code is mounted as a volume, which will allow live code editing inside the container.


## Some notes on the scripts and the docker file

### Dockerfile
The dockerfile pulls two things from the internet (again just FYI)

1. The .deb package that contains all the os161 utils
2. The `sys161-asst0.conf` file.

Also, the dockerfile has commented a commented out section which when uncommented will build the os161 kernel in the image itself. Useful if you always want your source code compiled when the container starts

### run_image.sh
This currently starts the container with `--rm` which means the container will be destroyed when you quit it, just FYI
