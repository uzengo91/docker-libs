FROM dockerlibs-base as runtime

FROM adoptopenjdk/openjdk8:x86_64-debianslim-jdk8u432-b06

LABEL author="uzengo91"

WORKDIR /opt

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

COPY --from=runtime /opt/sources/debian/sources.list-buster /etc/apt/sources.list

ARG arthas-tunnel=arthas-tunnel-server-4.0.4-fatjar.jar

#RUN curl -O -L "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/${ffmpeg_version_file}" && tar -xvf ${ffmpeg_version_file} && cp ${ffmpeg_version}/bin/* /usr/local/bin/ && rm -rf ${ffmpeg_version_file} ${ffmpeg_version}

RUN apt update && apt install -y curl wget procps net-tools xz-utils iputils-ping jq && apt clean \
&& curl -O /opt/${arthas-tunnel} -L "https://github.com/alibaba/arthas/releases/download/arthas-all-4.0.4/${arthas-tunnel}"

CMD [ "java" , "-jar", "arthas-tunnel-server-4.0.4-fatjar.jar" ]


