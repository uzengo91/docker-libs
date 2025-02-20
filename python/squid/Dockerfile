FROM ubuntu/squid:latest

LABEL author="uzengo91"
LABEL name="ssrf_proxy"

ENV HTTP_PORT: ${SSRF_HTTP_PORT:-3128}
ENV COREDUMP_DIR: ${SSRF_COREDUMP_DIR:-/var/spool/squid}
ENV REVERSE_PROXY_PORT: ${SSRF_REVERSE_PROXY_PORT:-8194}
ENV SANDBOX_HOST: ${SSRF_SANDBOX_HOST:-sandbox}
ENV SANDBOX_PORT: ${SANDBOX_PORT:-8194}

# sources.list-10-buster 加速国内apt源
COPY ssrf_proxy/squid.conf.template /etc/squid/squid.conf.template
COPY ssrf_proxy/docker-entrypoint.sh /docker-entrypoint-mount.sh


ENTRYPOINT [ 'sh', '-c', "cp /docker-entrypoint-mount.sh /docker-entrypoint.sh && sed -i 's/\r$$//' /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh && /docker-entrypoint.sh"  ]
