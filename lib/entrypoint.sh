#! /bin/sh

xvfb-run --auth-file /tmp/xvfb-run --server-args="-screen 0 640x480x24" -- xterm &
sleep 5
x11vnc -display :99 -auth /tmp/xvfb-run -forever -usepw
