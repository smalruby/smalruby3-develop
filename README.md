## Smalruby 3 Development Environment

smalruby3-develop is a developement environment for Smalruby 3.

## Prepare

### Install docker

 - Windows: https://www.docker.com/docker-windows
 - Mac: https://www.docker.com/docker-mac

### Install git and clone

 - Windows: https://gitforwindows.org/
 - Mac: open Terminal.app and run `xcode-select --install`

## Build docker image

```
$ docker-compose build
```

## Boot smalruby3-gui

```
$ docker-compose up -d
```

Open http://127.0.0.1:8601 on your web browser.

## Develop

see smalruby3-gui/README.md and scratch-vm/README.md.
