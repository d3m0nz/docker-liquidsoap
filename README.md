## docker-liquidsoap

[![Build Status](https://img.shields.io/github/actions/workflow/status/d3m0nz/docker-liquidsoap/docker-publish.yml)](https://github.com/d3m0nz/docker-liquidsoap/actions/workflows/docker-publish.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/d3m0nz/liquidsoap)](https://hub.docker.com/r/d3m0nz/liquidsoap)
[![Docker Image Size](https://img.shields.io/docker/image-size/d3m0nz/liquidsoap)](https://hub.docker.com/r/d3m0nz/liquidsoap)
[![License](https://img.shields.io/github/license/d3m0nz/docker-liquidsoap
)](https://github.com/d3m0nz/docker-liquidsoap/blob/main/LICENSE)

Dockerfile for running [Liquidsoap](https://www.liquidsoap.info/) in a container. \
Just mount your Liquidsoap script, music directory and you are good to go!

Works well with containerized [icecast2](https://icecast.org/): [pltnk/docker-icecast2](https://github.com/pltnk/docker-icecast2)

### Installation
- Pull the image from one of public Docker registries, supported tags: `latest`
  - Docker Hub `docker pull d3m0nz/liquidsoap`
  - GitHub Packages `docker pull ghcr.io/d3m0nz/liquidsoap`
- Build the image yourself
  - `docker build -t d3m0nz/liquidsoap github.com/d3m0nz/docker-liquidsoap`
  - Add build arg `LIQUIDSOAP_VERSION` to specify the version of Liquidsoap to use in the image, check available versions [here](https://opam.ocaml.org/packages/liquidsoap/). \
  Example: `docker build -t d3m0nz/liquidsoap:1.4.4 --build-arg LIQUIDSOAP_VERSION=1.4.4 github.com/d3m0nz/docker-liquidsoap`

### Configuration
- Mount your Liquidsoap script file to `/data/liquidsoap/script.liq`
- Mount your music directory to `/music`
- In your Liquidsoap script change path to your music directory to `/music`

#### docker run
```
docker run --name liquidsoap -d --restart=always \
--volume /path/to/your/script.liq:/data/liquidsoap/script.liq \
--volume /path/to/your/music:/music \
d3m0nz/liquidsoap
```
#### docker-compose.yml
```
liquidsoap:
  image: d3m0nz/liquidsoap
  container_name: liquidsoap
  restart: always
  volumes:
    - /path/to/your/script.liq:/data/liquidsoap/script.liq
    - /path/to/your/music:/music
```
Add cronjob
*/30 * * * * docker exec liquidsoap_container beet update -q

script must contain
BEET = "/usr/bin/beet -c /data/beets/config.yaml"
