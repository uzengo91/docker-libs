FROM zengo1209/dockerlibs-sources as runtime



FROM eclipse-temurin:21.0.5_11-jdk-jammy
LABEL author="uzengo91"
LABEL name="jdk21"

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# sources.list-20.04-focal 加速国内apt源
COPY --from=runtime /opt/sources/ubuntu/sources.list-22.04-jammy /etc/apt/sources.list

RUN apt update && apt install -y procps curl wget net-tools xz-utils iputils-ping jq && apt clean && \
apt autoremove && apt autoclean && rm -rf /var/lib/apt/lists/*
