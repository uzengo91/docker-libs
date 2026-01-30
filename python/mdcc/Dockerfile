FROM python:3.10.15-slim-bookworm

LABEL author="uzengo91"
LABEL name="mdcc"

WORKDIR /opt

# ENV PUPPETEER_SKIP_DOWNLOAD=true

RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list.d/debian.sources

RUN apt update && apt install -y curl wget procps net-tools xz-utils iputils-ping jq \
    nodejs npm \
    fonts-noto-cjk fonts-liberation fonts-noto-color-emoji fonts-dejavu  \
    && npm install -g @mermaid-js/mermaid-cli \
    && npm cache clean --force \
    && mmdc --version  && apt clean \
    && apt autoremove && apt autoclean && rm -rf /var/lib/apt/lists/*


