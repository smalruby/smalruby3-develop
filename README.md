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
$ docker-compose run smalruby3-gui bash -c 'cd /app/scratch-vm && npm install && npm run build && npm link'
$ docker-compose run smalruby3-gui bash -c 'cd /app/smalruby3-gui && npm install && npm link scratch-vm'
```

## Boot smalruby3-gui

```
$ docker-compose up
(snip)
smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

Open http://127.0.0.1:8601 on your web browser.

## Develop

see smalruby3-gui/README.md and scratch-vm/README.md.
