FROM centos:6

RUN yum update -y
RUN \rm /etc/localtime; ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# add user 'eda'
RUN useradd -c 'for eda test' -s /bin/bash -d /home/eda eda
RUN echo 'eda:I1oveEDA' |chpasswd
RUN echo "User 'eda' has generated successfully" 

# apply packages
RUN yum install -y epel-release wget openssh-server

# for verilator
RUN yum install -y git gcc gcc-c++ autoconf flex bison
## Test GCC & G++
RUN which gcc g++; gcc --version; g++ --version
RUN git clone http://git.veripool.org/git/verilator  /tmp/verilator; cd /tmp/verilator; autoconf; ./configure; make; make install
RUN echo "Verilator has installed successfully" 

# for emacs-verilog-mode
RUN yum install -y emacs 
# RUN /etc/init.d/sshd start; echo "run sshd..."
# CMD ["/usr/sbin/sshd", "-D"]
