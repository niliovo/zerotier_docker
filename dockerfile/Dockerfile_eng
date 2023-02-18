FROM keynetworks/ztncui:latest AS oztn

FROM debian:bullseye-slim

MAINTAINER niliovo 1791356563@qq.com

WORKDIR /zerotier

COPY --from=oztn /usr/local/bin/argon2g /usr/local/bin/

COPY zerotier_build.sh zerotier_build.sh

COPY zerotier_startup.sh zerotier_startup.sh

COPY health_check.sh health_check.sh

RUN chmod 777 zerotier_build.sh zerotier_startup.sh health_check.sh

RUN ["/bin/bash", "-c", "./zerotier_build.sh"]

EXPOSE 9993 9993/udp 9994 9995

HEALTHCHECK --interval=30s --timeout=10s \
  CMD ["/bin/bash", "./health_check.sh"]

ENTRYPOINT ["/bin/bash", "./zerotier_startup.sh"]