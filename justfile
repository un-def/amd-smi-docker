image := 'un1def/amd-smi'
rocm_version := '6.4'
revision := '1'
image_version := rocm_version + '-' + revision
base_url := 'https://repo.radeon.com/amdgpu-install/' + rocm_version + '/ubuntu/noble/'

_list:
  @just --list --unsorted

build:
  #!/bin/sh
  set -eu
  if docker image inspect '{{image}}:{{image_version}}' > /dev/null 2>&1; then
    echo '{{image}}:{{image_version}} already exists'
    exit 1
  fi
  deb=$(wget -qO- '{{base_url}}' | grep -Po '(?<=href=")amdgpu-install_[^"]+')
  url="{{base_url}}${deb}"
  build_date=$(date --utc --iso-8601=seconds)Z
  docker build . \
    --pull --no-cache \
    --build-arg='TITLE={{image}}' \
    --build-arg='VERSION={{image_version}}' \
    --build-arg="CREATED=${build_date}" \
    --build-arg="AMDGPU_INSTALL_URL=${url}" \
    --tag '{{image}}:{{image_version}}' --tag '{{image}}:latest'

push:
  docker push '{{image}}:{{image_version}}'
  docker push '{{image}}:latest'
