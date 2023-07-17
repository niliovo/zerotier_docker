FROM keynetworks/ztncui:latest AS oztn

FROM debian:bookworm-slim

MAINTAINER niliovo 1791356563@qq.com

WORKDIR /zerotier

COPY --from=oztn /usr/local/bin/argon2g /usr/local/bin/

COPY ./* .

RUN chmod 777 zerotier_build.sh zerotier_startup.sh health_check.sh /usr/local/bin/argon2g

RUN bash zerotier_build.sh

EXPOSE 9993 9993/udp 9994 9995

HEALTHCHECK --interval=30s --timeout=10s \
  CMD ["/bin/bash", "health_check.sh"]

ENTRYPOINT ["/bin/bash", "zerotier_startup.sh"]