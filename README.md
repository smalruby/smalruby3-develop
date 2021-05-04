## Smalruby 3 Development Environment

smalruby3-develop is a developement environment for Smalruby 3.

## Prepare

### Install docker

 - Windows: https://www.docker.com/docker-windows
 - Mac: https://www.docker.com/docker-mac

### Install git and clone

 - Windows: https://gitforwindows.org/
 - Mac: open Terminal.app and run `xcode-select --install`
 
Then run below command to clone. `--recursive` is important to clone submodules.

```
git clone --recursive https://github.com/smalruby/smalruby3-develop.git
```

## Build docker image

```
$ docker-compose build gui
$ docker-compose run smalruby3-gui bash -c 'cd /app/gui/scratch-vm && npm install && npm run build && npm link'
$ docker-compose run smalruby3-gui bash -c 'cd /app/gui/smalruby3-gui && npm install && npm link scratch-vm'
```

## Boot smalruby3-gui

```
$ docker-compose up gui
(snip)
smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

Open http://127.0.0.1:8601 on your web browser.

### Stop smalruby3-gui

```
$ docker-compose stop gui
```

## Develop

see gui/smalruby3-gui/README.md and gui/scratch-vm/README.md.
