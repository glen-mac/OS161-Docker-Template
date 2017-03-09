# BASE IMAGE
# =========
FROM ubuntu:14.04

# UPDATE PACKAGE LIST AND INSTALL REQUIRED PACKAGES
# =================================================
RUN apt-get update && apt-get install -y \
    wget \
    git \
    gcc

# GET REQUIRED OS161 BINARIES (E.G. bmake)
# =======================================
WORKDIR /home
RUN wget http://www.cse.unsw.edu.au/~cs3231/os161-files/os161-utils_2.0.8.deb
RUN dpkg -i os161-utils_2.0.8.deb && rm os161-utils_2.0.8.deb

# SETUP CONFIG FOR BUILD KERNEL
# =============================
WORKDIR /home/root
RUN wget http://cgi.cse.unsw.edu.au/~cs3231/17s1/assignments/asst0/sys161-asst0.conf && mv sys161-asst0.conf sys161.conf

# COPY OS161 SOURCE CODE INTO THE IMAGE
# =====================================
ADD ./src /home/os161-src

# ADD BUILD SCRIPT
# ================
ADD ./build_kernel.sh /home

# OPTIONAL: BUILD THE KERNEL
# ==========================
# Note: This can be done inside the container as well by running the build_kernel script
# RUN /home/build_kernel.sh

# SET CWD BACK TO HOME
# ===================
WORKDIR /home

# RUN BASH
# ========
# Note: this image should be run with a -ti option.
# E.g. docker run --rm -ti <image_name>
CMD bash
