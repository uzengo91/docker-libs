FROM dockerlibs-base as runtime



FROM adoptopenjdk/openjdk8:x86_64-debianslim-jdk8u432-b06
LABEL author="uzengo91"

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

COPY --from=runtime /opt/sources/debian/sources.list-buster /etc/apt/sources.list

RUN apt update && apt install -y procps curl wget net-tools xz-utils iputils-ping jq && apt clean
