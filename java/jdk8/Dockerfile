FROM adoptopenjdk/openjdk8:x86_64-debianslim-jdk8u432-b06

LABEL author="uzengo91"

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

COPY ./sources.list /etc/apt/sources.list


ARG ffmpeg_version=ffmpeg-n5.1-latest-linux64-gpl-5.1
ARG ffmpeg_version_file=${ffmpeg_version}.tar.xz


RUN apt update && apt install -y procps curl wget net-tools xz-utils iputils-ping jq && apt clean
