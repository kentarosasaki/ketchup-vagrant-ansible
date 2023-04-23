FROM centos:7

ENV container=docker

# Fix "failed to get D-Bus connection: Operation not permitted."
ENV docker_systemctl_replacement="https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/v1.5.7106/files/docker/systemctl.py"

COPY ./ ./

RUN yum install -y epel-release wget git && \
    yum install -y ansible ansible-lint && \
    yum clean all

RUN wget "${docker_systemctl_replacement}" --output-document=/usr/bin/systemctl

VOLUME ["/sys/fs/cgroup","/bin"]
CMD ["/usr/bin/systemctl"]
