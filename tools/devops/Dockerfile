FROM debian:12.13-slim

# 修改 apt 源为阿里云镜像
RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list.d/debian.sources || \
    sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list

# 更新包列表并安装基础排查工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    default-mysql-client \
    redis-tools \
    telnet \
    tcpdump \
    netcat-openbsd \
    apache2-utils \
    iputils-ping \
    wget \
    vim \
    net-tools \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 配置 pip 使用华为云镜像源
RUN pip3 config set global.index-url https://mirrors.huaweicloud.com/repository/pypi/simple && \
    pip3 config set global.trusted-host mirrors.huaweicloud.com

# 设置工作目录
WORKDIR /workspace

# 默认命令
CMD ["/bin/bash"]


# docker buildx build --platform linux/amd64,linux/arm64 -t registry.steam.crcloud.com/crcsoft-digital-human/s3proxy:tool-v.0.0.1 --push .
