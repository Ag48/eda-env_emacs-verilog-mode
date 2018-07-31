FROM centos:6

ARG file_evm="verilog-mode.el.gz"
ARG url_donwload_evm="https://www.veripool.org/ftp/${file_evm}"

RUN yum update -y
RUN \rm /etc/localtime; ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# add user 'eda'
RUN useradd -c 'for eda test' -s /bin/bash -d /home/eda eda
RUN echo 'eda:I1oveEDA' |chpasswd

# apply packages
RUN yum install -y epel-release wget openssh-server

# # for verilator
# RUN yum install -y git gcc gcc-c++ autoconf flex bison
# ## Test GCC & G++
# RUN which gcc g++; gcc --version; g++ --version
# RUN git clone http://git.veripool.org/git/verilator  /tmp/verilator; cd /tmp/verilator; autoconf; ./configure; make; make install; rm -rf /tmp/verilator

# for emacs-verilog-mode
RUN yum install -y emacs 
RUN cd /tmp; wget ${url_donwload_evm}; gunzip ${file_evm}; mv verilog-mode.el /usr/share/emacs/23.1/lisp
