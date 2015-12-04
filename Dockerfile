FROM phusion/baseimage
MAINTAINER niall_creech@yahoo.co.uk

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Environment variables setup
# COPY files/container_environment/* /etc/container_environment/

# APT packages setup
RUN apt-get update
RUN apt-get -y install \
  git \
  python-pip

# PIP packages setup
RUN pip install \
    awscli

# Daemons setup
#RUN mkdir -p /etc/service/test
#ADD files/service/test/run /etc/service/test/run

# Startup scripts setup
RUN mkdir -p /etc/my_init.d
ADD files/etc/my_init.d/* /etc/my_init.d/

# Binaries setup
COPY files/bin/* /usr/local/bin/

# Cron setup
#ADD files/etc/cron.d/* /etc/cron.d/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
