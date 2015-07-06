#
# Ubuntu 14.04 with activiti Dockerfile
#
# Pull base image.
FROM ubuntu

MAINTAINER David "support@bpmunion.com"

ENV REFRESHED_AT 2015-07-6 22:00

USER root

RUN apt-get update

RUN apt-get install git openssh-server -y

RUN echo "export LC_ALL=C" >> /root/.bashrc                                               

# Install Supervisor.
RUN  apt-get install -y supervisor && sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf 

ADD adds/authorized_keys /authorized_keys

ADD config/config.sh /config.sh

RUN chmod u+x /config.sh

RUN sh /config.sh && rm /config.sh

ADD config/sshd.conf /etc/supervisor/conf.d/sshd.conf

EXPOSE 8080

EXPOSE 22 

ADD assets /assets

CMD ["/assets/init"]

