#! /bin/sh -e

if [ ! -e /app/gui/built-monorepo ]; then
  (
    cd /app/gui/smalruby3-editor
    npm install
    cd packages/scratch-gui
    npm run setup:opal
    touch /app/gui/built-monorepo
  )
fi

exec "$@"
