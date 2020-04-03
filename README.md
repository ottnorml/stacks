# Raspberry Stacks

These are some Docker stacks running on a Raspberry Pi using [HypriotOS](https://blog.hypriot.com).

## Setup

Using Hypriot's own [flash tool](https://github.com/hypriot/flash) and [cloud-init](https://cloudinit.readthedocs.io/) the SD card can be prepared with the following steps:

```shell
curl -LO https://github.com/hypriot/flash/releases/download/2.5.1/flash
curl -LO https://raw.githubusercontent.com/witsch/stacks/cloud-init.yaml
bash flash --userdata cloud-init.yaml https://github.com/hypriot/image-builder-rpi/releases/download/v1.12.0/hypriotos-rpi-v1.12.0.img.zip
```

When it's done the card can be inserted into the Raspberry, which should then be configured automatically and have a Docker swarm running within a few minutes. It can be reached using `ssh pirate@black-pearl.local` with password “hypriot”.


## Background

See the following blog posts for more information:
  - [Releasing HypriotOS 1.11.0: Docker 19.03.0 CE from Raspberry Pi Zero to 4B](https://blog.hypriot.com/post/releasing-HypriotOS-1-11/)
  - [Bootstrapping a Cloud with Cloud-Init and HypriotOS](https://blog.hypriot.com/post/cloud-init-cloud-on-hypriot-x64/)
