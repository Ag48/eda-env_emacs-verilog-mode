FROM centos:6
LABEL maintainor="Tomoki Sugiura"
ARG file_evm="verilog-mode.el.gz"
ARG url_download_evm="https://www.veripool.org/ftp/${file_evm}"
WORKDIR /tmp

RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# add user 'eda' & change uid + gid for writable authority in Linux Docker
RUN echo 'root:I1oveEDA' | chpasswd

# apply packages
RUN yum update -y \
    && yum install -y \
         epel-release \
         emacs \
         git \
         openssh-server \
         wget \
    && yum clean all

# install emacs-verilog-mode
RUN wget ${url_download_evm} \
    && gunzip ${file_evm} \
    && mv verilog-mode.el /usr/share/emacs/23.1/lisp
# set ssh config & gen ssh-key
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
## gen ssh-key
RUN /etc/init.d/sshd start 
EXPOSE 22

CMD /usr/sbin/sshd -D
