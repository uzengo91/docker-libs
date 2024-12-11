FROM zengo1209/dockerlibs-sources as runtime

FROM adoptopenjdk/openjdk11:x86_64-debianslim-jdk-11.0.25_9

LABEL author="uzengo91"

WORKDIR /opt

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# sources.list-10-buster 加速国内apt源
COPY --from=runtime /opt/sources/debian/sources.list-10-buster /etc/apt/sources.list


RUN apt update && apt install -y curl wget procps net-tools xz-utils iputils-ping jq && apt clean

