FROM debian:bullseye-slim AS builder
LABEL author="uzengo91"
LABEL name="zengo1209/dockerlibs-jemalloc"
# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    wget \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Download and extract jemalloc
WORKDIR /opt
RUN wget -q https://github.com/jemalloc/jemalloc/releases/download/5.3.0/jemalloc-5.3.0.tar.bz2 \
    && tar -xjf jemalloc-5.3.0.tar.bz2 \
    && rm jemalloc-5.3.0.tar.bz2

# Build jemalloc
WORKDIR /opt/jemalloc-5.3.0
RUN ./autogen.sh \
    && ./configure --enable-prof \
    && make -j2 \
    && make install \
    && mkdir -p /usr/local/output \
    && cp lib/libjemalloc.so.2 /usr/local/output/

# # Final stage
# FROM eclipse-temurin:21-jdk-jammy

# # Copy only the necessary library files
# COPY --from=builder /usr/local/output/libjemalloc.so.2 /usr/local/lib/
# RUN ldconfig /usr/local/lib

# # Set environment variables to enable jemalloc
# ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2
# ENV MALLOC_CONF="background_thread:true,metadata_thp:auto"
