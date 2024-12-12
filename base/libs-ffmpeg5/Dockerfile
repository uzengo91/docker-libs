FROM alpine:3.21.0 as runtime


WORKDIR /opt
RUN apk update && apk add --no-cache curl xz && rm -rf /var/cache/apk/*

ARG OSS_HOST
ARG ffmpeg_version5=ffmpeg-n5.1-latest-linux64-gpl-5.1
ARG ffmpeg_version5_file=${ffmpeg_version5}.tar.xz

RUN curl -O -L "${OSS_HOST}/local/ffmpeg/${ffmpeg_version5_file}" \
&& tar -xvf ${ffmpeg_version5_file} && mkdir -p /opt/ffmpeg && cp ${ffmpeg_version5}/bin/ffmpeg ${ffmpeg_version5}/bin/ffprobe  /opt/ffmpeg/ \
&& rm -rf ${ffmpeg_version5_file} ${ffmpeg_version5}
# 压缩目录
RUN tar -cJf  ffmpeg.tar.xz -C /opt/ffmpeg . && rm -rf /opt/ffmpeg


FROM alpine:3.21.0
LABEL author="uzengo91"
LABEL name="zengo1209/dockerlibs-ffmpeg5"
WORKDIR /opt
COPY --from=runtime /opt/ffmpeg.tar.xz /opt/ffmpeg.tar.xz