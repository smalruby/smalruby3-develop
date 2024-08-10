#! /bin/sh -e

if [ ! -e /app/gui/built-scratch-vm ]; then
  (
    cd /app/gui/scratch-vm
    npm ci
    npm run build
    npm link
    touch /app/gui/built-scratch-vm
  )
fi

if [ ! -e /app/gui/built-smalruby3-gui ]; then
  (
    cd /app/gui/smalruby3-gui
    npm ci
    npm link scratch-vm
    npm run build
    touch /app/gui/built-smalruby3-gui
  )
fi

exec "$@"
