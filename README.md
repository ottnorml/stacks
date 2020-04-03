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


## Services

Pi-hole's DNS service (which you want to use to block ads anyway) is configured so that all host names ending in `.pi` resolve to the Raspberry Pi. With this working the following services are available:

  - [Traefik](http://traefik.io/) at http://traefik.pi/
  - [Pi-hole](https://pi-hole.net/) at http://hole.pi/
  - [Portainer](https://www.portainer.io/) at http://portainer.pi/

## Background

See the following blog posts for more information:
  - [Releasing HypriotOS 1.11.0: Docker 19.03.0 CE from Raspberry Pi Zero to 4B](https://blog.hypriot.com/post/releasing-HypriotOS-1-11/)
  - [Bootstrapping a Cloud with Cloud-Init and HypriotOS](https://blog.hypriot.com/post/cloud-init-cloud-on-hypriot-x64/)


## Testing

The setup via [cloud-init](https://cloudinit.readthedocs.io/) can be locally tested using [multipass](https://multipass.run/):

```shell
brew cask install multipass chef/chef/inspec
patch < multipass.patch
multipass launch --name pi --cloud-init cloud-init.yaml
multipass exec pi -- sudo docker stack ls
inspec exec tests --shell --shell-command='multipass exec pi sudo sh'
```

Note that the `patch` command adds an `apt` section for `arm64`, which is needed to install Docker (on HypriotOS it comes pre-installed).
