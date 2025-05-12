# AMD SMI CLI tool Docker image

> [!IMPORTANT]
> Moved to https://github.com/dstackai/dstack/tree/master/docker/amd-smi

An Ubuntu 24.04-based image with [AMD SMI](https://rocm.docs.amd.com/projects/amdsmi/en/latest/) preinstalled. Suitable for AMD GPU detection.

## Usage

```shell
docker run --rm --device /dev/kfd --device /dev/dri un1def/amd-smi static
```
