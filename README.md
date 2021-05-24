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
git config --global core.autocrlf
true <- remember

git config --global core.autocrlf input
git clone --recursive https://github.com/smalruby/smalruby3-develop.git

git config --global core.autocrlf true <- above
```

## Build docker image

```
git config core.autocrlf input
$ docker-compose build gui
$ docker-compose run --rm gui bash -c "cd /app/gui/scratch-vm && npm install && npm run build && npm link"
$ docker-compose run -e DEBUG=1 --rm smalruby3-gui bash -c "cd /app/gui/smalruby3-gui && npm install && npm link scratch-vm"
```

## Boot smalruby3-gui

```
$ docker-compose up gui
(snip)
smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

Open http://localhost:8601 on your web browser.

For debug, specify `--env-file ./config/.env.debug`.

```
$ docker-compose --env-file ./config/.env.debug up gui
(snip)
smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

### Stop smalruby3-gui

```
$ docker-compose stop gui
```

## Develop

see gui/smalruby3-gui/README.md and gui/scratch-vm/README.md.
