FROM alpine:3.21.0 as runtime


WORKDIR /opt
RUN apk update && apk add --no-cache curl xz && rm -rf /var/cache/apk/*

ARG OSS_HOST
ARG ffmpeg_version6=ffmpeg-n6.1-latest-linux64-lgpl-6.1
ARG ffmpeg_version6_file=${ffmpeg_version6}.tar.xz

RUN curl -O -L "${OSS_HOST}/local/ffmpeg/${ffmpeg_version6_file}" \
&& tar -xvf ${ffmpeg_version6_file} && mkdir -p /opt/ffmpeg && cp ${ffmpeg_version6}/bin/ffmpeg ${ffmpeg_version6}/bin/ffprobe  /opt/ffmpeg/ \
&& rm -rf ${ffmpeg_version6_file} ${ffmpeg_version6}

# 压缩目录
RUN tar -cJf  ffmpeg.tar.xz /opt/ffmpeg && rm -rf /opt/ffmpeg


FROM alpine:3.21.0
LABEL author="uzengo91"
LABEL name="zengo1209/dockerlibs-ffmpeg6"
WORKDIR /opt
COPY --from=runtime /opt/ffmpeg.tar.xz /opt/ffmpeg.tar.xz