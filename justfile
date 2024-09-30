image := 'un1def/amd-smi'
rocm_version := '6.2.2'
revision := '0'
image_version := rocm_version + '-' + revision
amdgpu_install_url := 'https://repo.radeon.com/amdgpu-install/' + rocm_version + '/ubuntu/noble/amdgpu-install_6.2.60202-1_all.deb'

_list:
  @just --list --unsorted

build:
  #!/bin/sh
  if docker image inspect '{{image}}:{{image_version}}' > /dev/null 2>&1; then
    echo '{{image}}:{{image_version}} already exists'
    exit 1
  fi
  build_date=$(date --utc --iso-8601=seconds)Z
  docker build . \
    --pull --no-cache \
    --build-arg='TITLE={{image}}' \
    --build-arg='VERSION={{image_version}}' \
    --build-arg="CREATED=${build_date}" \
    --build-arg='AMDGPU_INSTALL_URL={{amdgpu_install_url}}' \
    --tag '{{image}}:{{image_version}}' --tag '{{image}}:latest'

push:
  docker push '{{image}}:{{image_version}}'
  docker push '{{image}}:latest'
