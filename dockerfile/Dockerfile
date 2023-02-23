FROM keynetworks/ztncui:latest AS oztn

FROM debian:bullseye-slim

MAINTAINER niliovo 1791356563@qq.com

ENV m_dir="/zerotier"

WORKDIR $m_dir

COPY --from=oztn /usr/local/bin/argon2g /usr/local/bin/

COPY zerotier_build.sh $m_dir

COPY zerotier_startup.sh $m_dir

COPY health_check.sh $m_dir

RUN chmod 777 $m_dir/zerotier_build.sh $m_dir/zerotier_startup.sh $m_dir/health_check.sh

RUN ["/bin/bash", "zerotier_build.sh"]

EXPOSE 9993 9993/udp 9994 9995

HEALTHCHECK --interval=30s --timeout=10s \
  CMD ["/bin/bash", "health_check.sh"]

ENTRYPOINT ["/bin/bash", "zerotier_startup.sh"]