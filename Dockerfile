FROM debian:bookworm-slim

LABEL maintainer="Dirty D3M0Nz" \
      github="https://github.com/d3m0nz/docker-liquidsoap"

ENV DEBIAN_FRONTEND=noninteractive
ENV BEETS_CONFIG=/data/beets/config.yaml
ENV BEETS_LIBRARY=/data/beets/musiclibrary.db

RUN apt update && \
    apt install -y --no-install-recommends \
        liquidsoap \
        beets \
        ca-certificates \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Create user + directories
RUN groupadd -g 999 radio && \
    useradd -m -r -u 999 -g radio -s /bin/bash radio && \
    mkdir -p /data/beets /data/liquidsoap /data/ids /music /defaults && \
    chown -R radio:radio /data /music

# Copy configs
COPY defaults/config.yaml /defaults/config.yaml

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    chown radio:radio /entrypoint.sh

USER radio
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]