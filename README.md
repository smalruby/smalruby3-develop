# Smalruby 3 Development Environment

smalruby3-develop is a development environment for Smalruby 3.

## Prepare

### Install docker

- <https://www.docker.com/products/docker-desktop/>

### Install git and clone

- Windows: <https://gitforwindows.org/>
- macOS: open Terminal.app and run `xcode-select --install`

Then run below command to clone. `--recursive` is important to clone submodules.

```shell
git config --global core.autocrlf
# (output)
# true <- remember

git config --global core.autocrlf input
git clone --recursive https://github.com/smalruby/smalruby3-develop.git

git config --global core.autocrlf true <- above
```

## Build docker image

```shell
docker compose build gui
docker compose run --rm gui bash
# (Wait a minutes, output below. Then hit 'exit' to quit)
# root@592ae4944bb8:/app/gui/smalruby3-gui# exit
```

## Boot smalruby3-gui

```shell
docker compose up gui
# (output)
# (snip)
# smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

Open <http://localhost:8601> on your web browser.

For debug, specify `--env-file ./config/.env.debug`.

```shell
docker compose --env-file ./config/.env.debug up gui
# (output)
# (snip)
# smalruby3-gui_1  | ℹ ｢wdm｣: Compiled successfully.
```

### Stop smalruby3-gui

```shell
docker compose stop gui
```

## Develop

see gui/smalruby3-gui/README.md and gui/scratch-vm/README.md.
