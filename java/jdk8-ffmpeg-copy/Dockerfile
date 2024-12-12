FROM zengo1209/dockerlibs-sources as runtime
FROM zengo1209/dockerlibs-ffmpeg5 as ffmpeg


FROM adoptopenjdk/openjdk8:x86_64-debianslim-jdk8u432-b06
LABEL author="uzengo91"
LABEL name="jdk8-ffmpeg"
WORKDIR /opt
RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

ARG ffmpeg_tar=ffmpeg.tar.xz
# sources.list-10-buster 加速国内apt源
COPY --from=runtime /opt/sources/debian/sources.list-10-buster /etc/apt/sources.list
COPY --from=ffmpeg /opt/${ffmpeg_tar} /opt/${ffmpeg_tar}

RUN apt update && apt install -y curl wget procps net-tools xz-utils iputils-ping jq && apt clean \
&& apt autoremove && apt autoclean && rm -rf /var/lib/apt/lists/* \
&& tar -xvf ${ffmpeg_tar} && cp /opt/ffmpeg /opt/ffprobe  /usr/local/bin/ \
&& rm -rf /opt/ff* && ffmpeg -version && ffprobe -version
