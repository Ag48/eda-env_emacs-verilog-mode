FROM centos:7
LABEL maintainor="Tomoki Sugiura"
ARG file_evm="verilog-mode.el.gz"
ARG url_download_evm="https://www.veripool.org/ftp/${file_evm}"
ARG emacs_version="24.3"

# change locale
RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# apply packages
RUN yum update -y \
    && yum install -y \
         epel-release \
         emacs \
         git \
         wget \
    && yum clean all
# install emacs-verilog-mode
RUN wget ${url_download_evm} \
    && gunzip ${file_evm} \
    && mv verilog-mode.el /usr/share/emacs/${emacs_version}/lisp
