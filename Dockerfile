FROM centos:6

# ARG url_devtool="https://copr-fe.cloud.fedoraproject.org/coprs/rhscl/devtoolset-3/repo/epel-6/rhscl-devtoolset-3-epel-6.repo"
ARG version_devtool="2"
ARG url_devtool="http://people.centos.org/tru/devtools-2/devtools-2.repo"

ARG version_modelsim="16.0"
ARG build_modelsim="211"
ARG bin_modelsim="ModelSimSetup-${version_modelsim}.0.${build_modelsim}-linux.run"
ARG url_donwload_modelsim="http://download.altera.com/akdlm/software/acdsinst/${version_modelsim}/${build_modelsim}/ib_installers/${bin_modelsim}"
ARG path_install_modelsim="/eda/intelFPGA/${version_modelsim}"

RUN yum update -y
RUN \rm /etc/localtime; ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN useradd -c 'for eda test' -s /bin/bash -d /home/eda eda
RUN echo 'eda:I1oveEDA' |chpasswd
RUN echo "User 'eda' has generated successfully" 
# apply packages
RUN yum install -y epel-release wget openssh-server

# for verilator
# RUN yum install -y git gcc gcc-c++ autoconf flex bison
RUN yum install -y gcc gcc-c++ git autoconf flex bison
## Test GCC & G++
RUN which gcc g++; gcc --version; g++ --version
RUN git clone http://git.veripool.org/git/verilator  /tmp/verilator; cd /tmp/verilator; autoconf; ./configure; make; make install
RUN echo "Verilator has installed successfully" 

# for emacs-verilog-mode
RUN yum install -y emacs 
CMD /etc/rc.d/init/sshd start
