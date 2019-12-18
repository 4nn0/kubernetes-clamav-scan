FROM fedora:latest
MAINTAINER Andreas Nowak <andreas-nowak@gmx.net>

USER root

RUN dnf upgrade --security -y && dnf install -y --setopt=tsflags=nodocs clamav clamav-update && freshclam --no-warnings && dnf clean all && rm -rf /var/cache/* && chmod +r /etc/freshclam.conf && chmod 777 -R /var/lib/clamav/

ENV SCANDIR /scan
ENV RUNHOUR 2

USER 1000

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME /scan
