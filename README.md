# AMD SMI CLI tool Docker image

An Ubuntu 24.04-based image with [AMD SMI](https://rocm.docs.amd.com/projects/amdsmi/en/latest/) preinstalled. Suitable for AMD GPU detection.

## Usage

```shell
docker run --rm --device /dev/kfd --device /dev/dri un1def/amd-smi static
```
