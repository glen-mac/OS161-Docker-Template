# BASE IMAGE
# =========
FROM ubuntu:16.04

# UPDATE PACKAGE LIST AND INSTALL REQUIRED PACKAGES
# =================================================
# install vim just because its useful
RUN apt-get update && apt-get install -y \
    wget \
    git \
    gcc \
    libpython2.7 \
    vim \
    sed

# GET REQUIRED OS161 BINARIES (E.G. bmake)
# =======================================
WORKDIR /root
RUN wget http://www.cse.unsw.edu.au/~cs3231/os161-files/os161-utils_2.0.8.deb
RUN dpkg -i os161-utils_2.0.8.deb && rm os161-utils_2.0.8.deb

# PEDA INSTALL
# ===================
RUN git clone https://github.com/longld/peda.git /root/peda

# COPY OS161 SOURCE CODE INTO THE IMAGE
# =====================================
ADD ./src /root/os161-src

# SETUP CONFIG FOR BUILD KERNEL
# =============================
RUN wget http://cgi.cse.unsw.edu.au/~cs3231/17s1/assignments/asst2/sys161-asst2.conf
RUN mv sys161-asst2.conf /root/os161-src/sys161.conf

# SETUP INIT CONFIG FOR OS161-GDB
# ===============================
ADD ./.gdbinit-os161 /root/os161-src/.gdbinit

# SETUP INIT CONFIG FOR STANDARD GDB
# ==================================
ADD ./.gdbinit-root /root/.gdbinit

# bash rc
ADD ./bashrc /root/.bashrc

# gitignore
ADD ./gitignore /root/os161-src/.gitignore

# SET CWD BACK TO HOME
# ==================
WORKDIR /root/os161-src

RUN ./configure --ostree=/root/os161-src
# RUN BASH
# ========
# Note: this image should be run with a -ti option.
# E.g. docker run --rm -ti <image_name>
CMD bash
