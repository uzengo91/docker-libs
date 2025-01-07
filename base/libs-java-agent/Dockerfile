FROM alpine:3.21.0 as runtime
WORKDIR /opt
RUN apk update && apk add --no-cache curl xz && rm -rf /var/cache/apk/*
ARG OPEN_AGENT_VERSION=v2.10.0
ARG OPEN_AGENT=opentelemetry-javaagent.jar
RUN curl -O -L "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/${OPEN_AGENT_VERSION}/${OPEN_AGENT}"


FROM alpine:3.21.0
LABEL author="uzengo91"
LABEL name="zengo1209/dockerlibs-java-agent"
WORKDIR /opt
COPY --from=runtime /opt/opentelemetry-javaagent.jar /opt/opentelemetry-javaagent.jar