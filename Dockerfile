
#bench Dockerfile

FROM ubuntu:18.04
LABEL MAINTAINER frappé

USER root
# Generate locale C.UTF-8 for mariadb and general locale data
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y git python-dev python-setuptools python-pip redis-tools redis-server curl sudo
RUN useradd -ms /bin/bash -G sudo frappe && printf '# User rules for frappe\nfrappe ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/frappe

#nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

USER frappe
WORKDIR /home/frappe
RUN git clone https://github.com/frappe/bench
RUN pip install -e ./bench

USER frappe
WORKDIR /home/frappe/frappe-bench





