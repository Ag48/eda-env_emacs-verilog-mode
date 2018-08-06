FROM centos:6
LABEL maintainor="Tomoki Sugiura"
ARG file_evm="verilog-mode.el.gz"
ARG url_download_evm="https://www.veripool.org/ftp/${file_evm}"
WORKDIR /tmp

RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# add user 'eda'
RUN useradd -c 'for eda test' -s /bin/bash -d /home/eda eda \
    && echo 'eda:I1oveEDA' |chpasswd

# apply packages
RUN yum update -y \
    && yum install -y \
         epel-release \
         emacs \
         openssh-server \
         wget \
    && yum clean all

# install emacs-verilog-mode
RUN wget ${url_download_evm} \
    && gunzip ${file_evm} \
    && mv verilog-mode.el /usr/share/emacs/23.1/lisp
