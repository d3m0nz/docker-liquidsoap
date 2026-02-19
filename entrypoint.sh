#!/bin/sh
set -e

mkdir -p /data/beets

# Initialize config if missing
if [ ! -f "/data/beets/config.yaml" ]; then
  echo "No beets config found. Creating default."
  cp /defaults/config.yaml /data/beets/config.yaml
fi

# Run beets
if [ -f "/data/beets/musiclibrary.db" ]; then
  beet -c /data/beets/config.yaml update -m || true
else
  beet -c /data/beets/config.yaml import -q /music || true
fi

exec liquidsoap /data/liquidsoap/script.liq
