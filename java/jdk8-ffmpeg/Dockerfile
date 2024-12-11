FROM zengo1209/dockerlibs-sources as runtime

FROM adoptopenjdk/openjdk8:x86_64-debianslim-jdk8u432-b06

LABEL author="uzengo91"

WORKDIR /opt

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# sources.list-10-buster 加速国内apt源
COPY --from=runtime /opt/sources/debian/sources.list-10-buster /etc/apt/sources.list



ARG ffmpeg_version=ffmpeg-n5.1-latest-linux64-gpl-5.1
ARG ffmpeg_version_file=${ffmpeg_version}.tar.xz


RUN apt update && apt install -y curl wget procps net-tools xz-utils iputils-ping jq && apt clean \
&& apt autoremove && apt autoclean && rm -rf /var/lib/apt/lists/*  \
&& curl -O -L "https://autotrainplatform-online.oss-cn-beijing.aliyuncs.com/local/ffmpeg/${ffmpeg_version_file}" \
&& tar -xvf ${ffmpeg_version_file} && cp ${ffmpeg_version}/bin/ffmpeg ${ffmpeg_version}/bin/ffprobe  /usr/local/bin/ \
&& rm -rf ${ffmpeg_version_file} ${ffmpeg_version} && ffmpeg -version

