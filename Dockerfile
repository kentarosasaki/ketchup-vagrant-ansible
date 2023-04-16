FROM centos:7

ENV container=docker

ENV ANSIBLE_VERSION 2.4.2.0
ENV ANSIBLE_RPM https://github.com/infra-ci-book/support/raw/master/obsoleted/ansible-2.4.2.0-2.el7.noarch.rpm
ENV ANSIBLE_LINT_VERSION 3.4.21
ENV ANSIBLE_LINT_RPM https://github.com/infra-ci-book/support/raw/master/obsoleted/ansible-lint-3.4.21-1.el7.centos.noarch.rpm
# Fix "failed to get D-Bus connection: Operation not permitted."
ENV docker_systemctl_replacement="https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/v1.5.7106/files/docker/systemctl.py"

COPY ./ ./

RUN yum install -y epel-release wget git&& \
    yum install -y ${ANSIBLE_RPM:?} && \
    yum install -y ${ANSIBLE_LINT_RPM:?} && \
    yum clean all

RUN wget "${docker_systemctl_replacement}" --output-document=/usr/bin/systemctl

VOLUME ["/sys/fs/cgroup","/bin"]
CMD ["/usr/bin/systemctl"]
