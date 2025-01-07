FROM zengo1209/dockerlibs-sources as runtime
FROM zengo1209/dockerlibs-jemalloc as builder



FROM eclipse-temurin:21.0.5_11-jdk-jammy
LABEL author="uzengo91"
LABEL name="jdk21"

RUN cat /etc/os-release && cat /etc/apt/sources.list && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# sources.list-20.04-focal 加速国内apt源
COPY --from=runtime /opt/sources/ubuntu/sources.list-22.04-jammy /etc/apt/sources.list
# Copy only the necessary library files
COPY --from=builder /usr/local/output/libjemalloc.so.2 /usr/local/lib/
RUN ldconfig /usr/local/lib

# Set environment variables to enable jemalloc
ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2
ENV MALLOC_CONF="background_thread:true,metadata_thp:auto"

RUN apt update && apt install -y procps curl wget net-tools xz-utils iputils-ping jq && apt clean && \
apt autoremove && apt autoclean && rm -rf /var/lib/apt/lists/*
