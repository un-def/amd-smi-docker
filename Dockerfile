FROM ubuntu:24.04

ARG TITLE
ARG VERSION
ARG CREATED
ARG AMDGPU_INSTALL_URL

RUN \
    : "${TITLE:?}" && \
    : "${VERSION:?}" && \
    : "${CREATED:?}" && \
    : "${AMDGPU_INSTALL_URL:?}" && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    wget -O amdgpu-install.deb "${AMDGPU_INSTALL_URL}" && \
    apt-get install -y --no-install-recommends ./amdgpu-install.deb && \
    rm ./amdgpu-install.deb && \
    apt-get update && \
    apt-get install -y amd-smi-lib

ENTRYPOINT ["/opt/rocm/bin/amd-smi"]
CMD ["--help"]

LABEL org.opencontainers.image.title="${TITLE}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.created="${CREATED}"
