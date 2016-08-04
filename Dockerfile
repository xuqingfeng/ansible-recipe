# Dockerfile for xuqingfeng/ansible-recipe
FROM centos:centos7
MAINTAINER "xuqingfeng" <js-xqf@hotmail.com>
ENV container docker
RUN echo "===> Enabling systemd..." && \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);\
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/* && \
\
echo "===> Updating..." && \
yum -y update && \
\
echo "===> Installing EPEL..." && \
yum -y install epel-release && \
\
echo "===> Installing Ansible..." && \
yum -y install ansible

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "ansible-playbook", "--version" ]

WORKDIR /tmp
COPY . /tmp
RUN echo 'localhost ansible_connection=local' > inventory
#RUN ansible-playbook -i inventory play.yml --tags="git golang ..."
