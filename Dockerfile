FROM centos:7

RUN yum -q -y update && yum -q clean all

RUN yum -q -y install epel-release && \
    yum -y install git make gcc-c++ cmake swig python python-devel python34-devel epydoc doxygen libuuid-devel openssl-devel cyrus-sasl-devel jsoncpp-devel sudo && \
    yum -q clean all

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID jenkins && useradd -u $USER_ID -s /bin/sh -g jenkins jenkins
RUN echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
